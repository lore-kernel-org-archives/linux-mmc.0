From: Fabio Estevam <festevam@gmail.com>
Subject: Re: /dev/mmcblk0 (or /dev/mmcblk0p1) does not exist on
 Freescale iMX6SL board
Date: Thu, 30 Apr 2015 10:06:35 -0300
Message-ID: <CAOMZO5CTwBBzWFecaWa4dq2gnTvV6ygtU2zoNo56PgOv+yy7zQ@mail.gmail.com>
References: <5541F3CC.4090000@gmail.com>
	<CAOMZO5Dm3v=ig+aXRf7DqmXcTsiepYcFpXB9G2hpfMtRPtE4ag@mail.gmail.com>
	<554223C4.9030506@gmail.com>
	<CAOMZO5CCgNwopEP8Aj=XwdV3VSETX9uP5=wzSaMrmx40gC821g@mail.gmail.com>
	<554227C5.70004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33489 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbbD3NGg (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 09:06:36 -0400
Received: by lbbzk7 with SMTP id zk7so44073659lbb.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2015 06:06:35 -0700 (PDT)
In-Reply-To: <554227C5.70004@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Xuebing Wang <xbing6@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Felipe Balbi <balbi@ti.com>, niranjan Patil <Niranjan.Patil@infocus.com>, richard Jiang <Richard.Jiang@infocus.com>

On Thu, Apr 30, 2015 at 10:01 AM, Xuebing Wang <xbing6@gmail.com> wrote:

> Fabio,
>
> Thanks. No, I do not have access to a mx6sl-evk. But I can try to get one.
>
> There is no eMMC (only sd-card) on mx6sl-evk, right?

That's correct. If you need eMMC with mx6sl, then you can try imx6sl-warp.

I have tested both boards here recently and mmc operation is working fine.

Regards,

Fabio Estevam
