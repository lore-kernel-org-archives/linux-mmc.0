From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] mmc: omap_hsmmc: Add support for slot-name property in DT
Date: Mon, 28 Dec 2015 15:41:01 +0100
Message-ID: <2889805.FbnHzlrmH7@wuerfel>
References: <1431724489-32359-1-git-send-email-pali.rohar@gmail.com> <1600826.3aUcPX7Ju6@wuerfel> <201512281528.48097@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:51319 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbbL1OlG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2015 09:41:06 -0500
In-Reply-To: <201512281528.48097@pali>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Monday 28 December 2015 15:28:48 Pali Roh=E1r wrote:
> On Monday 28 December 2015 15:14:50 Arnd Bergmann wrote:
> > On Friday 25 December 2015 13:53:11 Pali Roh=E1r wrote:
> > > On Monday 18 May 2015 17:07:57 Arnd Bergmann wrote:
> > > > On Monday 18 May 2015 08:06:07 Tony Lindgren wrote:
> > > > > * Arnd Bergmann <arnd@arndb.de> [150515 14:26]:
> > > > > > On Friday 15 May 2015 23:22:37 Pali Roh=E1r wrote:
> > > > > If setting up the generic binding is expected to take a while=
,
> > > > > you can naturally pass it in pdata while waiting for the
> > > > > generic binding to get merged.
> > > >=20
> > > > Yes, good idea. So the n900 machine can use auxdata to pass thi=
s
> > > > for the time being, while the binding and generic implementatio=
n
> > > > is being worked out.
> > >=20
> > > Ok, so what is needed to finish this patch series?
> >=20
> > I don't know where we are at this point. Has either the auxdata
> > approach or the generic binding been worked on at all?
>=20
> What are auxdata data?=20

I mean you can add the platform data to the omap_auxdata_lookup[] table
for this board.

> And what do you mean with "generic binding" approach?

Start a discussion to specify slot names and implement that in the
mmc driver core, so we can remove the hack from the OMAP driver and
make it work the same way for any machine.

	Arnd
