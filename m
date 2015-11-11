From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V2 06/11] mmc: sdhci-esdhc-imx: fix cd regression for dt platform
Date: Wed, 11 Nov 2015 13:16:20 -0200
Message-ID: <CAOMZO5CJsRoXpsV2e0WTzKWmQJxvb45DVOAUeUGH_Oro_svfQA@mail.gmail.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
	<1437569590-5228-7-git-send-email-aisheng.dong@freescale.com>
	<2333b5f060a8e45bd8adcdab55365fab@agner.ch>
	<CAOMZO5BUKmqczyVgz_WgYmBMeuGugDS4uVjw+LXebxf-nPDTyw@mail.gmail.com>
	<CAOMZO5Dz0KijjryoPihoXsP4b5Wy_5rock++oY=i-9gESThUbg@mail.gmail.com>
	<CAOCHtYgayRZoHxJ2d8f1mO0QW_=N4Mx2_RSCrADKERHdP9TGYQ@mail.gmail.com>
	<CAOMZO5D2LNS93XVx86fL7oLTgy4apU036v-ohhv-=kw5gFsCww@mail.gmail.com>
	<CAOCHtYj1QuEYLg4vbxshWkYXPe6r9b5OP7hh_O0WoE6xfL0mjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:35033 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752484AbbKKPQV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Nov 2015 10:16:21 -0500
In-Reply-To: <CAOCHtYj1QuEYLg4vbxshWkYXPe6r9b5OP7hh_O0WoE6xfL0mjw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Robert Nelson <robertcnelson@gmail.com>
Cc: Stefan Agner <stefan@agner.ch>, Dong Aisheng <aisheng.dong@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Soeren Moch <smoch@web.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Rabeeh Khoury <rabeeh@solid-run.com>, Troy Kisky <troy.kisky@boundarydevices.com>, =?UTF-8?Q?Rostislav_Lisov=C3=BD?= <lisovy@gmail.com>, Heiko Schocher <hs@denx.de>, Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, Tim

Hi Robert,

On Sun, Oct 25, 2015 at 7:33 PM, Robert Nelson <robertcnelson@gmail.com> wrote:

> Thanks Fabio, that fixes the regression on v4.1.11 on my wand's... Too
> bad it's also not in:
>
> https://lkml.org/lkml/2015/10/23/516

The fix is in 4.1.13 now.
