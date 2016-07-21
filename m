From: Mark Brown <broonie@kernel.org>
Subject: Re: Unsynchronized access to spi bus by mmc_rescan?
Date: Fri, 22 Jul 2016 00:27:37 +0100
Message-ID: <20160721232737.GW6509@sirena.org.uk>
References: <20160422212842.GB21636@brightrain.aerifal.cx>
 <20160504224445.GW21636@brightrain.aerifal.cx>
 <20160721204451.GE15995@brightrain.aerifal.cx>
 <20160721214015.GG15995@brightrain.aerifal.cx>
 <20160721224308.GT6509@sirena.org.uk>
 <20160721230615.GH15995@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sDhuxz86kt5qlkuV"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42668 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbcGUX1q (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2016 19:27:46 -0400
Content-Disposition: inline
In-Reply-To: <20160721230615.GH15995@brightrain.aerifal.cx>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rich Felker <dalias@libc.org>
Cc: linux-spi@vger.kernel.org, linux-mmc@vger.kernel.org, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Ernst Schwab <eschwab@online.de>, Matt Fleming <matt@console-pimps.org>, Antonio Ospite <ospite@studenti.unina.it>


--sDhuxz86kt5qlkuV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2016 at 07:06:15PM -0400, Rich Felker wrote:
> On Thu, Jul 21, 2016 at 11:43:08PM +0100, Mark Brown wrote:
> > On Thu, Jul 21, 2016 at 05:40:15PM -0400, Rich Felker wrote:

> > spi_sync() shouldn't be reading the flag in the first place as far as I
> > can tell, it should unconditionally have the flag clear as locked
> > callers have to use spi_sync_locked() but that will give us a fast path
> > that doesn't check for the bus lock which starts to reveal the
> > underlying issue.

> Ah, in that case maybe the actual bug is just one line of commit
> 24c8cd1b0812? Reverting just that also seems to make the problem go
> away.

For those playing at home that's "spi: fix possible deadlock between
internal bus locks and bus_lock_flag".  That won't work entirely since
that'd mean that we're not doing I/O locking to exclude the message pump
in cases where we push data directly in spi_sync() with the bus lock
held by a caller.  That's probably going to work most of the time as
most callers will be single threaded but they might not be.  It should
be saved by the checks to see if we're already processing a message
inside the pump function but it's better to be clear about what we're
doing I think, and we can clear cur_msg inside the message pump.  But
perhaps it's enough...  anyway, I'm not going to think through all the
cases properly at this time of night.

Please include human readable descriptions of things like commits and
issues being discussed in e-mail in your mails, this makes them much
easier for humans to read especially when they have no internet access.
I do frequently catch up on my mail on flights or while otherwise
travelling so this is even more pressing for me than just being about
making things a bit easier to read.

--sDhuxz86kt5qlkuV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXkVpoAAoJECTWi3JdVIfQPQQH/1frxXo3kzAOYq4t9ZzeJfix
9EV9dYKVEDrnpebkfzHn3MT4ZW4xR46P6oCiYTJ3HmpAVuFn4MatcZzizicQxRiM
Nm5zuQDTku2dNiucmcu8H+N15IyylaAOfzbBngItPDEmrwJFqvTGtdVjcg/R5g/P
EkIcf63ORN3DSVL/0oL/IJImTg7M4TBmlibTYBlh904d2Pa17ZqqDWkKo/PwMhwt
4RAMSRKZSZRX/9pNnPDy8n1gjHzto+xEPCat1x/648TEIi7cVieOsJ5EYaqlKgBY
p0RR2QH6yEF4mJB8ZPht41LNHoJh6Iuk91V5wG7vVygOe45Lei4ayi0+RI2OaIQ=
=WwHz
-----END PGP SIGNATURE-----

--sDhuxz86kt5qlkuV--
