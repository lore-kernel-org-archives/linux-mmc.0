From: Peter =?utf-8?q?H=C3=BCwe?= <PeterHuewe@gmx.de>
Subject: Re: [PATCH] arch/avr32: Fix build failure for avr32 caused by typo
Date: Mon, 28 Dec 2009 11:34:36 +0100
Message-ID: <200912281134.36763.PeterHuewe@gmx.de>
References: <200912252008.45602.PeterHuewe@gmx.de> <200912281059.30450.PeterHuewe@gmx.de> <20091228112028.5babace2@hskinnemoen-d830>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:34980 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752291AbZL1Kem convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2009 05:34:42 -0500
In-Reply-To: <20091228112028.5babace2@hskinnemoen-d830>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Ma <pma@mediamatech.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Am Montag 28 Dezember 2009 11:20:28 schrieb Haavard Skinnemoen:
> Peter H=C3=BCwe <PeterHuewe@gmx.de> wrote:
> > Great, thanks for the update.
> > The only thing that still catches my eye is that the kzalloc line c=
an
> > fail, so you should perhaps add something like
> > if (!slave) {
> > 	printk(KERN_ERR "No memory left for at32ap700x: at32_add_device_mc=
");
> > 	goto fail;
> > }
>=20
> I agree, except that this is extremely unlikely to happen, so we shou=
ld
> either drop the printk() or use pr_debug() in order to waste as littl=
e
> memory as possible in production systems.
ok.

>=20
> I think your first patch is good as it is, so I will apply it. Please
> send any additional fixes as a separate patch.

Okay thanks for applying.

@Hans: can you create the cleanup patch or should I ?

Regards,
Peter
