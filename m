From: Fabio Estevam <festevam@gmail.com>
Subject: Re: /dev/mmcblk0 (or /dev/mmcblk0p1) does not exist on
 Freescale iMX6SL board
Date: Thu, 30 Apr 2015 09:16:06 -0300
Message-ID: <CAOMZO5Dm3v=ig+aXRf7DqmXcTsiepYcFpXB9G2hpfMtRPtE4ag@mail.gmail.com>
References: <5541F3CC.4090000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:34646 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbbD3MQI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 08:16:08 -0400
Received: by laat2 with SMTP id t2so42629921laa.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2015 05:16:06 -0700 (PDT)
In-Reply-To: <5541F3CC.4090000@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Xuebing Wang <xbing6@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Felipe Balbi <balbi@ti.com>, niranjan Patil <Niranjan.Patil@infocus.com>, richard Jiang <Richard.Jiang@infocus.com>

On Thu, Apr 30, 2015 at 6:20 AM, Xuebing Wang <xbing6@gmail.com> wrote:
> Hi linux-mmc community,
>
> I am working on a board which is very similar to Freescale iMX6SL EVK
> (evaluation board), but /dev/mmcblk0 does not exist for kernel v4.0.1

On my imx6sl-warp the eMMC is correctly detected when running kernel 4.0.

Does it help if you apply this patch from 4.1-rc1?

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host/sdhci.c?id=04e079cf6b24c794bbc52b04b370f84cb728540e

Regards,

Fabio Estevam
