#include "sheetmodel.h"
#include "./../excel/excelhelper.h"
#include "./../logger.h"

#include <QQmlContext>


BookSheetModel::BookSheetModel(QObject *parent)
    : QAbstractListModel(parent)
{}

void BookSheetModel::updateFromFile(QString docPath) {
    beginResetModel();
    ExcelHelper eh(docPath);
    m_sheetNames = eh.getBookSheetNames();
    LOGD("Init: " << m_sheetNames.join(" "));
    endResetModel();
}

QString BookSheetModel::getListNames() {
    return m_sheetNames.join(" ");
}

int BookSheetModel::rowCount(const QModelIndex &parent) const
{
    return m_sheetNames.length();
}

QVariant BookSheetModel::data(const QModelIndex &index, int role) const
{
    if(!checkIndex(index))
        return QVariant();

    if(role == TextRole)
        return m_sheetNames[index.row()];

    return QVariant();
}

QHash<int, QByteArray> BookSheetModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[TextRole] = "text";
    return roles;
}
