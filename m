From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: /dev/mmcblk0 (or /dev/mmcblk0p1) does not exist on
 Freescale iMX6SL board
Date: Thu, 30 Apr 2015 21:01:57 +0800
Message-ID: <554227C5.70004@gmail.com>
References: <5541F3CC.4090000@gmail.com>	<CAOMZO5Dm3v=ig+aXRf7DqmXcTsiepYcFpXB9G2hpfMtRPtE4ag@mail.gmail.com>	<554223C4.9030506@gmail.com> <CAOMZO5CCgNwopEP8Aj=XwdV3VSETX9uP5=wzSaMrmx40gC821g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33586 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbD3NCI (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Apr 2015 09:02:08 -0400
Received: by pacwv17 with SMTP id wv17so59350432pac.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2015 06:02:07 -0700 (PDT)
In-Reply-To: <CAOMZO5CCgNwopEP8Aj=XwdV3VSETX9uP5=wzSaMrmx40gC821g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Felipe Balbi <balbi@ti.com>, niranjan Patil <Niranjan.Patil@infocus.com>, richard Jiang <Richard.Jiang@infocus.com>


On 04/30/2015 08:51 PM, Fabio Estevam wrote:
>> Unfortunately, no, cherry-pick this patch from 4.1-rc1 into v4.0.1 has the
>> >same result.
> Do you have access to a mx6sl-evk? This board also can also detect the
> SD card on both 4.0 and 4.1-rc1?

Fabio,

Thanks. No, I do not have access to a mx6sl-evk. But I can try to get one.

There is no eMMC (only sd-card) on mx6sl-evk, right?

-- 
Xuebing
