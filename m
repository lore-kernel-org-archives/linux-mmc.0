From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Unsynchronized access to spi bus by mmc_rescan?
Date: Thu, 21 Jul 2016 23:43:08 +0100
Message-ID: <20160721224308.GT6509@sirena.org.uk>
References: <20160422212842.GB21636@brightrain.aerifal.cx>
 <20160504224445.GW21636@brightrain.aerifal.cx>
 <20160721204451.GE15995@brightrain.aerifal.cx>
 <20160721214015.GG15995@brightrain.aerifal.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="chReQkDOePndSGWY"
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160721214015.GG15995-C3MtFaGISjmo6RMmaWD+6Sb1p8zYI1N1@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Ernst Schwab <eschwab-BGeptl67XyCzQB+pC5nmwQ@public.gmane.org>, Matt Fleming <matt-HNK1S37rvNbeXh+fF434Mdi2O/JbrIOy@public.gmane.org>, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


--chReQkDOePndSGWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 21, 2016 at 05:40:15PM -0400, Rich Felker wrote:

> The spi master device has a "bus lock flag" that's used in lieu of a
> recursive mutex, but it seems to be used entirely incorrectly. The
> logic I'm seeing in spi.c is essentially:

I am entirely unclear why you believe there is a recursive mutex here,
that's not the purpose of the spi_bus_lock() API at all.

> 	if (some_task_has_spi_bus_locked)
> 		use_spi_master_without_locking();

> There seems to be no check that the task that's using the master
> without locking is the same one that locked it!

That's because there is no requirement that something that takes a bus
lock be executing from a single context.  It is just granting exclusive
access to the bus, the caller is free to do those accesses in any manner
it sees fit.

> Also, master->bus_lock_flag is modified completely unsynchonized from
> read access to master->bus_lock_flag. There is no locking of
> master->bus_lock_mutex or master->bus_lock_spinlock around the read
> accesses to master->bus_lock_flag, and in one place the write (of 0)
> to master->bus_lock_flag takes place without holding the spinlock.

The critical read access is in spi_async where we exclude users that
don't hold the lock which *is* spinlocked; we should probably hold the
spinlock on release but it's not so important since we know that we hold
the lock when we call it and the mutex ends up providing protection.
spi_sync() shouldn't be reading the flag in the first place as far as I
can tell, it should unconditionally have the flag clear as locked
callers have to use spi_sync_locked() but that will give us a fast path
that doesn't check for the bus lock which starts to reveal the
underlying issue.

This underlying issue is that we are trying to use one mutex for two
purposes, the existing mutex is mainly being used to serialize access to
the physical bus but the externally visible bus lock is there to ensure
that only one caller is able to queue new transfers which is not the
same thing at all.  It is completely irrelevant when we are pushing
messages to the bus if we are doing so with the bus lock held.

> The obvious fix would be using an actual recursive mutex to obtain
> recursive mutex semantics.

This would be broken since we need to be able to start transfers from
atomic context.

--chReQkDOePndSGWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXkU/7AAoJECTWi3JdVIfQrdMH/11fr5pongn/k5IrWS14SIJT
DeBvojeLTEudU4NVBxjNbqQYesrHpgmHtMN2kFdO/YW3padqp679Z92WFywFN3DV
KyaerefpqvFwwJNiWRwD4/k5f48I7hgT6bilAx08JV6pHqVSSLExPC3p5byr9Q27
j6+LGtqOOcs9pmSOpAN6HdXUAQcaKmp2k8rsAs6ylcorgqIOXLbKJQmoJfC00SO5
ko4BPZlIohD+wPSkGz/nr57g5yUgDtHcVP6ikOxVrPDs4ip+sHvh3Jw8dAKqyhex
tk71y1u3L7xgJrjVD0aUU6zmbJNMBhgHWIaxdW9UnfQdB1JcQuPjZiZYldrGa+0=
=m6xI
-----END PGP SIGNATURE-----

--chReQkDOePndSGWY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
