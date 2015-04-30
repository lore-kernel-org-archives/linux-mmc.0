From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: /dev/mmcblk0 (or /dev/mmcblk0p1) does not exist on
 Freescale iMX6SL board
Date: Thu, 30 Apr 2015 21:15:56 +0800
Message-ID: <55422B0C.7060900@gmail.com>
References: <5541F3CC.4090000@gmail.com>	<CAOMZO5Dm3v=ig+aXRf7DqmXcTsiepYcFpXB9G2hpfMtRPtE4ag@mail.gmail.com>	<554223C4.9030506@gmail.com>	<CAOMZO5CCgNwopEP8Aj=XwdV3VSETX9uP5=wzSaMrmx40gC821g@mail.gmail.com>	<554227C5.70004@gmail.com> <CAOMZO5CTwBBzWFecaWa4dq2gnTvV6ygtU2zoNo56PgOv+yy7zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:32971 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbD3NQC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 09:16:02 -0400
Received: by qkx62 with SMTP id 62so32597447qkx.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2015 06:16:01 -0700 (PDT)
In-Reply-To: <CAOMZO5CTwBBzWFecaWa4dq2gnTvV6ygtU2zoNo56PgOv+yy7zQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Felipe Balbi <balbi@ti.com>, niranjan Patil <Niranjan.Patil@infocus.com>, richard Jiang <Richard.Jiang@infocus.com>


On 04/30/2015 09:06 PM, Fabio Estevam wrote:
>> Thanks. No, I do not have access to a mx6sl-evk. But I can try to get one.
>> >
>> >There is no eMMC (only sd-card) on mx6sl-evk, right?
> That's correct. If you need eMMC with mx6sl, then you can try imx6sl-warp.
>
> I have tested both boards here recently and mmc operation is working fine.

Is there an easy way for me to low-down sdhc/eMMC clock (e.g. to modify 
arch/arm/mach-imx/clk-imx6sl.c)? Just in case this is not hardware 
related, e.g. impedance matching of emmc-sdio lines.

-- 
Xuebing
