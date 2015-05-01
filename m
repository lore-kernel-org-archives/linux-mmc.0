From: Fabio Estevam <festevam@gmail.com>
Subject: Re: /dev/mmcblk0 (or /dev/mmcblk0p1) does not exist on
 Freescale iMX6SL board
Date: Fri, 1 May 2015 12:03:33 -0300
Message-ID: <CAOMZO5ALebn6wFwhwRjoWrA8O7TafcWsSTaW27VeZiOmHq28zw@mail.gmail.com>
References: <5541F3CC.4090000@gmail.com>
	<CAOMZO5Dm3v=ig+aXRf7DqmXcTsiepYcFpXB9G2hpfMtRPtE4ag@mail.gmail.com>
	<554223C4.9030506@gmail.com>
	<CAOMZO5CCgNwopEP8Aj=XwdV3VSETX9uP5=wzSaMrmx40gC821g@mail.gmail.com>
	<554227C5.70004@gmail.com>
	<CAOMZO5CTwBBzWFecaWa4dq2gnTvV6ygtU2zoNo56PgOv+yy7zQ@mail.gmail.com>
	<554357CD.4030903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lb0-f172.google.com ([209.85.217.172]:34968 "EHLO
	mail-lb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753800AbbEAPDf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 May 2015 11:03:35 -0400
Received: by lbbuc2 with SMTP id uc2so66276907lbb.2
        for <linux-mmc@vger.kernel.org>; Fri, 01 May 2015 08:03:33 -0700 (PDT)
In-Reply-To: <554357CD.4030903@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Xuebing Wang <xbing6@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, Ulf Hansson <ulf.hansson@linaro.org>, Felipe Balbi <balbi@ti.com>, niranjan Patil <Niranjan.Patil@infocus.com>, richard Jiang <Richard.Jiang@infocus.com>

On Fri, May 1, 2015 at 7:39 AM, Xuebing Wang <xbing6@gmail.com> wrote:

> I got my eMMC working on kernel v4.0.1 by:
> 1) In device tree, use 8 data lines (rather than 4 lines for sdhc)

Ok, great. This makes sense.

> 2) Force ext_csd.rev to be 4
> -------------------------
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 1d41e85..aa1ca6c 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -355,6 +355,7 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8
> *ext_csd)
>          * are authorized, see JEDEC JESD84-B50 section B.8.
>          */
>         card->ext_csd.rev = ext_csd[EXT_CSD_REV];
> +       card->ext_csd.rev = 4;
>
>         card->ext_csd.raw_sectors[0] = ext_csd[EXT_CSD_SEC_CNT + 0];
>         card->ext_csd.raw_sectors[1] = ext_csd[EXT_CSD_SEC_CNT + 1];
> -------------------------
>
> eMMC on my board is Micron "MTFC4GLDDQ-4M IT", according to its datasheet,
> it is "JEDEC/MMC standard version 4.41-compliant
> (JEDEC Standard No. 84-A441)", and its "Extended CSD revision" (EXT_CSD_REV)
> = 5
>
> This seems either because kernel does not handle (ext_csd == 5) correctly,
> or there is an firmware issue in Micron "MTFC4GLDDQ-4M IT" (in terms of
> JEDEC standard compliance), what do you think?

I will let the mmc experts comment on this one.

Regards,

Fabio Estevam
