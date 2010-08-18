From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] mmc: fix for CONFIG_PM disabled
Date: Wed, 18 Aug 2010 11:10:01 +0200
Message-ID: <20100818091001.GA4805@pengutronix.de>
References: <201008112340.o7BNenDe021017@imap1.linux-foundation.org> <20100812093643.852adc98.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100812093643.852adc98.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-mmc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, Maxim Levitsky <maximlevitsky@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 12, 2010 at 09:36:43AM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
>=20
> Minimal patch to fix mmc to build when CONFIG_PM is not enabled:
>=20
> (.text+0x128fcd): undefined reference to `mmc_pm_notify'
>=20
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>

I sent the same patch[1] a few hours later than Randy, mine got

	Acked-by: Kukjin Kim <kgene.kim@samsung.com>
	Acked-by: Maxim Levitsky <maximlevitsky@gmail.com>

=2E  I think it's fine to add these to Randy's patch, too, together wit=
h
my Ack.  Maybe add a reference to the breaking commit as my patch did?
=09
Thanks
Uwe

[1] http://mid.gmane.org/1281691473-15481-1-git-send-email-u.kleine-koe=
nig@pengutronix.de

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
