From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] mmc: omap_hsmmc: Add support for slot-name property in DT
Date: Mon, 28 Dec 2015 15:55:28 +0100
Message-ID: <4500962.b9ypZOL9bV@wuerfel>
References: <1431724489-32359-1-git-send-email-pali.rohar@gmail.com> <2889805.FbnHzlrmH7@wuerfel> <201512281554.35277@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:59757 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbL1Ozf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2015 09:55:35 -0500
In-Reply-To: <201512281554.35277@pali>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Monday 28 December 2015 15:54:35 Pali Roh=E1r wrote:
> On Monday 28 December 2015 15:41:01 Arnd Bergmann wrote:
> > On Monday 28 December 2015 15:28:48 Pali Roh=E1r wrote:
> > > On Monday 28 December 2015 15:14:50 Arnd Bergmann wrote:
> > > > On Friday 25 December 2015 13:53:11 Pali Roh=E1r wrote:
> > > > > On Monday 18 May 2015 17:07:57 Arnd Bergmann wrote:
> > > > > > On Monday 18 May 2015 08:06:07 Tony Lindgren wrote:
> > > > > > > * Arnd Bergmann <arnd@arndb.de> [150515 14:26]:
> > > > > > > > On Friday 15 May 2015 23:22:37 Pali Roh=E1r wrote:
> > > > > > > If setting up the generic binding is expected to take a
> > > > > > > while, you can naturally pass it in pdata while waiting
> > > > > > > for the generic binding to get merged.
> > > > > >=20
> > > > > > Yes, good idea. So the n900 machine can use auxdata to pass
> > > > > > this for the time being, while the binding and generic
> > > > > > implementation is being worked out.
> > > > >=20
> > > > > Ok, so what is needed to finish this patch series?
> > > >=20
> > > > I don't know where we are at this point. Has either the auxdata
> > > > approach or the generic binding been worked on at all?
> > >=20
> > > What are auxdata data?
> >=20
> > I mean you can add the platform data to the omap_auxdata_lookup[]
> > table for this board.
>=20
> But can I mix data from omap3-n900.dts and omap_auxdata_lookup[]?

Yes.

	Arnd
