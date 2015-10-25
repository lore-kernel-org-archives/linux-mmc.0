From: Robert Nelson <robertcnelson@gmail.com>
Subject: Re: [PATCH V2 06/11] mmc: sdhci-esdhc-imx: fix cd regression for dt platform
Date: Sun, 25 Oct 2015 16:33:51 -0500
Message-ID: <CAOCHtYj1QuEYLg4vbxshWkYXPe6r9b5OP7hh_O0WoE6xfL0mjw@mail.gmail.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
 <1437569590-5228-7-git-send-email-aisheng.dong@freescale.com>
 <2333b5f060a8e45bd8adcdab55365fab@agner.ch> <CAOMZO5BUKmqczyVgz_WgYmBMeuGugDS4uVjw+LXebxf-nPDTyw@mail.gmail.com>
 <CAOMZO5Dz0KijjryoPihoXsP4b5Wy_5rock++oY=i-9gESThUbg@mail.gmail.com>
 <CAOCHtYgayRZoHxJ2d8f1mO0QW_=N4Mx2_RSCrADKERHdP9TGYQ@mail.gmail.com> <CAOMZO5D2LNS93XVx86fL7oLTgy4apU036v-ohhv-=kw5gFsCww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:33358 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751728AbbJYVeW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Oct 2015 17:34:22 -0400
In-Reply-To: <CAOMZO5D2LNS93XVx86fL7oLTgy4apU036v-ohhv-=kw5gFsCww@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>, Dong Aisheng <aisheng.dong@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Soeren Moch <smoch@web.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Rabeeh Khoury <rabeeh@solid-run.com>, Troy Kisky <troy.kisky@boundarydevices.com>, =?UTF-8?Q?Rostislav_Lisov=C3=BD?= <lisovy@gmail.com>, Heiko Schocher <hs@denx.de>, Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, Tim

On Sun, Oct 25, 2015 at 4:05 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Sun, Oct 25, 2015 at 6:52 PM, Robert Nelson <robertcnelson@gmail.com> wrote:
>
>> I need to finish a full bisect run, but one of these sdhci-esdhci-imx
>> fixes broke the wandboard..
>
> Could you please try to apply the attached patch?
>
> Looks like this one was not applied.

Thanks Fabio, that fixes the regression on v4.1.11 on my wand's... Too
bad it's also not in:

https://lkml.org/lkml/2015/10/23/516

Regards,

-- 
Robert Nelson
https://rcn-ee.com/
