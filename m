From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] mmc: add a function to get regulators, supplying
 card's power
Date: Sun, 17 Jun 2012 20:59:22 +0100
Message-ID: <20120617195921.GL4267@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1206131454260.17854@axis700.grange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yQDbd2FCF2Yhw41T"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:40146 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752370Ab2FQT7Y (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 17 Jun 2012 15:59:24 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1206131454260.17854@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ulf Hansson <ulf.hansson@stericsson.com>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>


--yQDbd2FCF2Yhw41T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 13, 2012 at 02:57:41PM +0200, Guennadi Liakhovetski wrote:
> Add a function to get regulators, supplying card's Vdd and Vccq on a
> specific host. If a Vdd supplying regulator is found, the function checks,
> whether a valid OCR mask can be obtained from it. The Vccq regulator is
> optional. A failure to get it is not fatal.

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

--yQDbd2FCF2Yhw41T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP3jcAAAoJEBus8iNuMP3dXikP/2FSoQLscicpsYOz+bwE7+Up
n4zFbU6XAARnLFzSbcBZB0Zo+o1d5BQemu81UCQzvNhOTNTBu+Xm5S11uR0zVjNt
L0fMFEP5Tib3icIWHXwvGgzqxQOnHz3iTOOWX9dO+y3lXrNHL8Bm04Jlg893FYT9
QT8IJXX0PYaR72N/o68jZ4lskLYYkSBV0SILZOo1puNW5UGanhyWU7OQZYYP01aa
zBuV6Ed54bN7FQxYSZZJsn6hTU9Cqp9v8UhD5dWFIuzZuO+pCF9KllWXL8FdK0uq
r1tdpc1KVFfWMVCLc19Cnu5iUwb0qQrB0n72poLqI633K5MbS+8N8jd+l+p+y1Ur
CRL+iKKCXw+CD8tTZylYckDZoHSa428zkEgxYN0dk11DexQqf88pzxnjgrXgsp8T
/dEhVEdRCyOk9XExdrpEgeG4sF1FwxkwB0fxJg/oevKMTlbkv5zKe/HmINgA6xLt
9YxMlOs+hUMcXyr5jDwmcP+uWoVfRdCcOwJUBLi7rh/xKivNJ4cHyN+v/KBsXEQw
nIZ5a5dSo9yKogCsj29MEUGtkfF7fvp5xEKQGyneKZQ+2cTzFan1XDiAl9OLwE4Y
WYAyKaBqFRRJu+YdrVEo/9f7uMBnz/vnnIBR74qtnb9IziICWS8wt2FT7jGSZ8zm
8PNJ6xB4pd7gdi9fZonB
=DLDa
-----END PGP SIGNATURE-----

--yQDbd2FCF2Yhw41T--
