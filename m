From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH] arch/avr32: Fix build failure for avr32 caused by typo
Date: Mon, 28 Dec 2009 11:20:28 +0100
Message-ID: <20091228112028.5babace2@hskinnemoen-d830>
References: <200912252008.45602.PeterHuewe@gmx.de>
	<20091228091318.454c4713@hcegtvedt.norway.atmel.com>
	<200912281059.30450.PeterHuewe@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from relay.atmel.no ([80.232.32.139]:50175 "EHLO relay.atmel.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750736AbZL1KUb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2009 05:20:31 -0500
In-Reply-To: <200912281059.30450.PeterHuewe@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter =?UTF-8?B?SMO8d2U=?= <PeterHuewe@gmx.de>
Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Ma <pma@mediamatech.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Peter H=C3=BCwe <PeterHuewe@gmx.de> wrote:
> Great, thanks for the update.
> The only thing that still catches my eye is that the kzalloc line can=
 fail, so=20
> you should perhaps add something like
> if (!slave) {
> 	printk(KERN_ERR "No memory left for at32ap700x: at32_add_device_mc")=
;
> 	goto fail;
> }

I agree, except that this is extremely unlikely to happen, so we should
either drop the printk() or use pr_debug() in order to waste as little
memory as possible in production systems.

I think your first patch is good as it is, so I will apply it. Please
send any additional fixes as a separate patch.

Haavard
