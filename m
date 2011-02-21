From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] dw_mmc: set the debounce value and remove duplicated offset
Date: Mon, 21 Feb 2011 10:23:15 +0000
Message-ID: <AANLkTi=Vv8=7FwArQPwjXPZ93YoE7uKvyR-0Ze81Lmbn@mail.gmail.com>
References: <4D6228F6.6020500@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52860 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1BUKXQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Feb 2011 05:23:16 -0500
Received: by gyb11 with SMTP id 11so183713gyb.19
        for <linux-mmc@vger.kernel.org>; Mon, 21 Feb 2011 02:23:16 -0800 (PST)
In-Reply-To: <4D6228F6.6020500@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>

On Mon, Feb 21, 2011 at 8:57 AM, Jaehoon Chung <jh80.chung@samsung.com>=
 wrote:
> This patch is set the debouce value..
> This value do not need to be changed with every command.
> So we set the value in probe function.
>
> And DATA register offset is duplicated..
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: kyungmin Park <kyungmin.park@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 =A03 +++
> =A0drivers/mmc/host/dw_mmc.h | =A0 =A01 -
> =A02 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 62c8440..b3f94ff 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1623,6 +1623,9 @@ static int dw_mci_probe(struct platform_device =
*pdev)
> =A0 =A0 =A0 =A0/* Put in max timeout */
> =A0 =A0 =A0 =A0mci_writel(host, TMOUT, 0xFFFFFFFF);
>
> + =A0 =A0 =A0 /* Set the debounce value */
> + =A0 =A0 =A0 mci_writel(host, DEBNCE, 0xFFFFFF);
> +

As I understand it this is the reset value of the DEBNCE register? Why
do we need to set it at all?

> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * FIFO threshold settings =A0RxMark =A0=3D fifo_size =
/ 2 - 1,
> =A0 =A0 =A0 =A0 * =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
Tx Mark =3D fifo_size / 2 DMA Size =3D 8
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index 5dd55a7..f492837 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -51,7 +51,6 @@
> =A0#define SDMMC_DSCADDR =A0 =A0 =A0 =A0 =A00x094
> =A0#define SDMMC_BUFADDR =A0 =A0 =A0 =A0 =A00x098
> =A0#define SDMMC_DATA =A0 =A0 =A0 =A0 =A0 =A0 0x100
> -#define SDMMC_DATA_ADR =A0 =A0 =A0 =A0 0x100

This part is fine.

Acked-by: Will Newton <will.newton@imgtec.com>
