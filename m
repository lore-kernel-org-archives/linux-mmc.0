From: Zang Roy-R61911 <r61911@freescale.com>
Subject: RE: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for eSDHC driver
Date: Tue, 10 Aug 2010 18:07:20 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A0562B0@zch01exm23.fsl.freescale.net>
References: <AANLkTikUypKobPAHsE+tz-Py-XvvJhbcj7Syj3rX_ej0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe005.messaging.microsoft.com ([216.32.180.31]:32688
	"EHLO VA3EHSOBE005.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750866Ab0HJKHq convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Aug 2010 06:07:46 -0400
Received: from mail129-va3 (localhost.localdomain [127.0.0.1])	by
 mail129-va3-R.bigfish.com (Postfix) with ESMTP id A3F5D1A4028D	for
 <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2010 10:07:45 +0000 (UTC)
Received: from VA3EHSMHS009.bigfish.com (unknown [10.7.14.249])	by
 mail129-va3.bigfish.com (Postfix) with ESMTP id 103DB1BB80CF	for
 <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2010 10:07:27 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
 [10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
 o7AA7PKr010002	for <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2010 03:07:25
 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
 [10.192.129.207])	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
 o7AAIsGX010087	for <linux-mmc@vger.kernel.org>; Tue, 10 Aug 2010 05:18:55
 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <AANLkTikUypKobPAHsE+tz-Py-XvvJhbcj7Syj3rX_ej0@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: linux-mmc@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org

=20

> -----Original Message-----
> From: Micha=B3 Miros=B3aw [mailto:mirqus@gmail.com]=20
> Sent: Tuesday, August 10, 2010 2:25 AM
> To: Zang Roy-R61911
> Cc: linux-mmc@vger.kernel.org; linuxppc-dev@ozlabs.org;=20
> akpm@linux-foundation.org
> Subject: Re: [PATCH 1/3 v2] sdhci: Add auto CMD12 support for=20
> eSDHC driver
>=20
> 2010/8/3 Roy Zang <tie-fei.zang@freescale.com>:
> [...]
> > @@ -240,6 +240,8 @@ struct sdhci_host {
> > =A0#define SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1<<25)
> > =A0/* Controller cannot support End Attribute in NOP ADMA=20
> descriptor */
> > =A0#define SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC =A0 =A0 =A0 =A0 =A0 =A0=
 =A0(1<<26)
> > +/* Controller uses Auto CMD12 command to stop the transfer */
> > +#define SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12 =A0 =A0 =A0 =A0 =A0 =A0=
 (1<<27)
> >
> > =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq; =A0=
 =A0 =A0 =A0 =A0 =A0/* Device IRQ */
> > =A0 =A0 =A0 =A0void __iomem * =A0 =A0 =A0 =A0 =A0ioaddr; =A0 =A0 =A0=
 =A0 /* Mapped address */
>=20
> Just a cosmetic hint: I suggest SDHCI_QUIRK_MULTIBLOCK_READ_AUTO_CMD1=
2
> or something for the quirk name, because ACMD12 part might be confuse=
d
> with MMC/SD App CMD 12 (CMD55+CMD12 combo) if/whenever that gets used=
=2E
Thanks for the suggestion.
There are several ACMD12 needed to be updated.
Send a new patch to update it.
Roy

