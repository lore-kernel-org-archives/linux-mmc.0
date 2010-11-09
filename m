From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] mxcmmc: update the regulator support code to the
	latest API
Date: Tue, 9 Nov 2010 11:14:06 +0100
Message-ID: <20101109101406.GW16938@pengutronix.de>
References: <1288656337.29881.13.camel@realization> <20101102073932.GB6017@pengutronix.de> <1288949275.3072.3.camel@realization> <1289213595.3425.23.camel@realization> <20101108143746.GA23201@void.printf.net> <1289297390.3020.27.camel@realization>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1289297390.3020.27.camel@realization>
Sender: linux-kernel-owner@vger.kernel.org
To: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Daniel Mack <daniel@caiaq.de>, Andrew Morton <akpm@linux-foundation.org>, Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>, Fabio Estevam <fabioestevam@yahoo.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Linus Walleij <linus.ml.walleij@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 09, 2010 at 11:09:50AM +0100, Alberto Panizzo wrote:
>=20
> This fix also the build problem introduced by my previous patch
> due to unhanded API changes introduced by
s/handed/handled/ ?

> commit:99fc5131018cbdc3cf42ce09fb394a4e8b053c74
Linus wants to have the commit shortlog for references to other commits=
=2E
After doing:

	git config --global alias.one "show -s --pretty=3D'format:%h (%s)'"

once you can simply use the output of

	git one 99fc5131018cbdc3cf42ce09fb394a4e8b053c74

for that.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
