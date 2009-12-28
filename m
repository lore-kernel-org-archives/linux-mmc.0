From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Subject: Re: [PATCH] arch/avr32: Fix build failure for avr32 caused by typo
Date: Mon, 28 Dec 2009 12:07:23 +0100
Message-ID: <20091228120723.6a22367e@hcegtvedt.norway.atmel.com>
References: <200912252008.45602.PeterHuewe@gmx.de>
	<200912281059.30450.PeterHuewe@gmx.de>
	<20091228112028.5babace2@hskinnemoen-d830>
	<200912281134.36763.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay.atmel.no ([80.232.32.139]:63274 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752074AbZL1LH2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2009 06:07:28 -0500
In-Reply-To: <200912281134.36763.PeterHuewe@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter =?UTF-8?B?SMO8d2U=?= <PeterHuewe@gmx.de>
Cc: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Ma <pma@mediamatech.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

On Mon, 28 Dec 2009 11:34:36 +0100
Peter H=C3=BCwe <PeterHuewe@gmx.de> wrote:

> Am Montag 28 Dezember 2009 11:20:28 schrieb Haavard Skinnemoen:
> > Peter H=C3=BCwe <PeterHuewe@gmx.de> wrote:
> > > Great, thanks for the update.
> > > The only thing that still catches my eye is that the kzalloc line=
 can
> > > fail, so you should perhaps add something like
> > > if (!slave) {
> > > 	printk(KERN_ERR "No memory left for at32ap700x: at32_add_device_=
mc");
> > > 	goto fail;
> > > }
> >=20
> > I agree, except that this is extremely unlikely to happen, so we sh=
ould
> > either drop the printk() or use pr_debug() in order to waste as lit=
tle
> > memory as possible in production systems.
> ok.
>

I skipped the print message, as no other platform devices will print
similar information. If people really need this kind of information
they could provide a patch adding it for all the platform devices.

> > I think your first patch is good as it is, so I will apply it. Plea=
se
> > send any additional fixes as a separate patch.
>=20
> Okay thanks for applying.
>=20
> @Hans: can you create the cleanup patch or should I ?
>=20

I'll do it, should arrive here shortly.

--=20
Best regards,
Hans-Christian Egtvedt
