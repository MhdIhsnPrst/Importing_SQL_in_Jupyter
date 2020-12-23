SELECT invoices.InvoiceId, count(invoice_items.InvoiceLineId) as item_bought, invoices.Total FROM invoices
INNER JOIN invoice_items on invoices.InvoiceId = invoice_items.InvoiceId 
GROUP BY invoices.InvoiceId;

SELECT customers.Country, genres.Name, count(genres.GenreId) as genre_bought from customers
INNER JOIN invoices on customers.CustomerId = invoices.CustomerId
INNER JOIN invoice_items on invoices.InvoiceId = invoice_items.InvoiceId
INNER JOIN tracks on invoice_items.TrackId = tracks.TrackId
INNER JOIN genres on tracks.GenreId = genres.GenreId
GROUP BY customers.Country, genres.Name;

SELECT artists.Name, sum(invoice_items.UnitPrice) from artists
INNER JOIN albums on artists.ArtistId = albums.ArtistId
INNER JOIN tracks on albums.AlbumId = tracks.AlbumId
INNER JOIN invoice_items on tracks.TrackId = invoice_items.TrackId
GROUP BY artists.Name;

select BillingCountry, AVG(Total) as CountryAvgInv from invoices
group by BillingCountry
having CountryAvgInv >
(select AVG(Total) from invoices);

SELECT gen.Title, gen.Name, max(inv_it.Total_Sales)
FROM 
(SELECT al.Title, genres.Name FROM genres
INNER JOIN tracks on genres.GenreId = tracks.GenreId
INNER JOIN albums al on tracks.AlbumId = al.AlbumId
GROUP BY al.Title) as gen
INNER JOIN 
(SELECT al.Title, sum(invoice_items.UnitPrice) as Total_Sales FROM invoice_items
INNER JOIN tracks on invoice_items.TrackId = tracks.TrackId
INNER JOIN albums al on tracks.AlbumId = al.AlbumId
GROUP BY al.Title) as inv_it
on gen.Title = inv_it.Title
GROUP BY gen.Name;

SELECT customers.Country, genres.Name, count(genres.GenreId) as genre_bought from customers
INNER JOIN invoices on customers.CustomerId = invoices.CustomerId
INNER JOIN invoice_items on invoices.InvoiceId = invoice_items.InvoiceId
INNER JOIN tracks on invoice_items.TrackId = tracks.TrackId
INNER JOIN genres on tracks.GenreId = genres.GenreId
GROUP BY customers.Country, genres.Name
HAVING genre_bought>8;

SELECT gen.Country, gen.Name, max(gen.test) as bought_item
FROM 
(SELECT customers.Country, genres.Name, count(genres.Name) as test FROM customers
INNER JOIN invoices on customers.CustomerId = invoices.CustomerId
INNER JOIN invoice_items on invoices.InvoiceId = invoice_items.InvoiceId
INNER JOIN tracks on invoice_items.TrackId = tracks.TrackId
INNER JOIN genres on tracks.GenreId = genres.GenreId
GROUP BY customers.Country, genres.Name) as gen
GROUP BY gen.Country;