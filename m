From: Shawn Guo <shawn.gsc@gmail.com>
Subject: Re: [PATCH] mxcmmc: use dmaengine API
Date: Wed, 12 Jan 2011 20:33:03 +0800
Message-ID: <AANLkTim8Uc7h-GDEitGNC1k56twLF9313FkokbQsqKdf@mail.gmail.com>
References: <1294826996-13764-1-git-send-email-s.hauer@pengutronix.de>
	<1294826996-13764-2-git-send-email-s.hauer@pengutronix.de>
	<20110112122541.GA6569@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:43709 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756014Ab1ALMdG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jan 2011 07:33:06 -0500
Received: by wwa36 with SMTP id 36so549760wwa.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Jan 2011 04:33:04 -0800 (PST)
In-Reply-To: <20110112122541.GA6569@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@freescale.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Jan 12, 2011 at 8:25 PM, Shawn Guo <shawn.guo@freescale.com> wr=
ote:
> It seems all the tabs were turned into spaces.
>
My problem.  Sorry for the noise.

> On Wed, Jan 12, 2011 at 11:09:56AM +0100, Sascha Hauer wrote:
>> This switches the mxcmmc driver to use the dmaengine API. Unlike
>> the old one this one is always present in the tree, even if no DMA
>> is implement, hence we can remove all the #ifdefs in from the driver=
=2E
>> The driver automatically switches to PIO mode if no DMA support or n=
o
>> suitable channel is available.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>> =A0drivers/mmc/host/mxcmmc.c | =A0172 +++++++++++++++++++++++++-----=
---------------
>> =A01 files changed, 97 insertions(+), 75 deletions(-)
>>
> [...]
>
> --
> Regards,
> Shawn
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



--=20
Regards,
Shawn
