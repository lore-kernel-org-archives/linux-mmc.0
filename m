From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V2 06/11] mmc: sdhci-esdhc-imx: fix cd regression for dt platform
Date: Tue, 6 Oct 2015 19:21:03 -0300
Message-ID: <CAOMZO5BUKmqczyVgz_WgYmBMeuGugDS4uVjw+LXebxf-nPDTyw@mail.gmail.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
	<1437569590-5228-7-git-send-email-aisheng.dong@freescale.com>
	<2333b5f060a8e45bd8adcdab55365fab@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34168 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbbJFWVE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Oct 2015 18:21:04 -0400
In-Reply-To: <2333b5f060a8e45bd8adcdab55365fab@agner.ch>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Agner <stefan@agner.ch>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, Soeren Moch <smoch@web.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Robert Nelson <robertcnelson@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Rabeeh Khoury <rabeeh@solid-run.com>, Troy Kisky <troy.kisky@boundarydevices.com>, lisovy@gmail.com, Heiko Schocher <hs@denx.de>, Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, Tim Harvey <tharvey@gateworks.com>

Hi Stefan,

On Tue, Oct 6, 2015 at 7:15 PM, Stefan Agner <stefan@agner.ch> wrote:
> Hi Dong,
>
> Just hit that issue in 4.1, could we add that patch also to stable?

I sent the series to stable, but Greg has not applied it yet.
