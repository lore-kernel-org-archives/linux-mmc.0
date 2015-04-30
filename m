From: Fabio Estevam <festevam@gmail.com>
Subject: Re: /dev/mmcblk0 (or /dev/mmcblk0p1) does not exist on
 Freescale iMX6SL board
Date: Thu, 30 Apr 2015 09:51:10 -0300
Message-ID: <CAOMZO5CCgNwopEP8Aj=XwdV3VSETX9uP5=wzSaMrmx40gC821g@mail.gmail.com>
References: <5541F3CC.4090000@gmail.com>
	<CAOMZO5Dm3v=ig+aXRf7DqmXcTsiepYcFpXB9G2hpfMtRPtE4ag@mail.gmail.com>
	<554223C4.9030506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f43.google.com ([209.85.215.43]:34452 "EHLO
	mail-la0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751114AbbD3MvM (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 08:51:12 -0400
Received: by laat2 with SMTP id t2so43359700laa.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2015 05:51:10 -0700 (PDT)
In-Reply-To: <554223C4.9030506@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Xuebing Wang <xbing6@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Felipe Balbi <balbi@ti.com>, niranjan Patil <Niranjan.Patil@infocus.com>, richard Jiang <Richard.Jiang@infocus.com>

On Thu, Apr 30, 2015 at 9:44 AM, Xuebing Wang <xbing6@gmail.com> wrote:

> Unfortunately, no, cherry-pick this patch from 4.1-rc1 into v4.0.1 has the
> same result.

Do you have access to a mx6sl-evk? This board also can also detect the
SD card on both 4.0 and 4.1-rc1?

Regards,

Fabio Estevam
