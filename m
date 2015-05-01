From: Xuebing Wang <xbing6@gmail.com>
Subject: Re: /dev/mmcblk0 (or /dev/mmcblk0p1) does not exist on
 Freescale iMX6SL board
Date: Fri, 01 May 2015 18:39:09 +0800
Message-ID: <554357CD.4030903@gmail.com>
References: <5541F3CC.4090000@gmail.com>	<CAOMZO5Dm3v=ig+aXRf7DqmXcTsiepYcFpXB9G2hpfMtRPtE4ag@mail.gmail.com>	<554223C4.9030506@gmail.com>	<CAOMZO5CCgNwopEP8Aj=XwdV3VSETX9uP5=wzSaMrmx40gC821g@mail.gmail.com>	<554227C5.70004@gmail.com> <CAOMZO5CTwBBzWFecaWa4dq2gnTvV6ygtU2zoNo56PgOv+yy7zQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35448 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753664AbbEAKjP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 May 2015 06:39:15 -0400
Received: by qgej70 with SMTP id j70so36446338qge.2
        for <linux-mmc@vger.kernel.org>; Fri, 01 May 2015 03:39:14 -0700 (PDT)
In-Reply-To: <CAOMZO5CTwBBzWFecaWa4dq2gnTvV6ygtU2zoNo56PgOv+yy7zQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Felipe Balbi <balbi@ti.com>, niranjan Patil <Niranjan.Patil@infocus.com>, richard Jiang <Richard.Jiang@infocus.com>


On 04/30/2015 09:06 PM, Fabio Estevam wrote:
>> Fabio,
>> >
>> >Thanks. No, I do not have access to a mx6sl-evk. But I can try to get one.
>> >
>> >There is no eMMC (only sd-card) on mx6sl-evk, right?
> That's correct. If you need eMMC with mx6sl, then you can try imx6sl-warp.
>
> I have tested both boards here recently and mmc operation is working fine.

Fabio, thanks.

I got my eMMC working on kernel v4.0.1 by:
1) In device tree, use 8 data lines (rather than 4 lines for sdhc)
2) Force ext_csd.rev to be 4
-------------------------
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1d41e85..aa1ca6c 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -355,6 +355,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, 
u8 *ext_csd)
          * are authorized, see JEDEC JESD84-B50 section B.8.
          */
         card->ext_csd.rev = ext_csd[EXT_CSD_REV];
+       card->ext_csd.rev = 4;

         card->ext_csd.raw_sectors[0] = ext_csd[EXT_CSD_SEC_CNT + 0];
         card->ext_csd.raw_sectors[1] = ext_csd[EXT_CSD_SEC_CNT + 1];
-------------------------

eMMC on my board is Micron "MTFC4GLDDQ-4M IT", according to its 
datasheet, it is "JEDEC/MMC standard version 4.41-compliant
(JEDEC Standard No. 84-A441)", and its "Extended CSD revision" 
(EXT_CSD_REV) = 5

This seems either because kernel does not handle (ext_csd == 5) 
correctly, or there is an firmware issue in Micron "MTFC4GLDDQ-4M IT" 
(in terms of JEDEC standard compliance), what do you think?


-- 
Xuebing
