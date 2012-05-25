From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 1/3] mmc: omap_hsmmc: Errata i705: SD hot unplug
Date: Fri, 25 May 2012 14:07:03 +0530
Message-ID: <CANfBPZ98Yf+CMoA0ApzHihQqrRNEDKKxPx4U0bMsV=M3XeX4hQ@mail.gmail.com>
References: <1337890467-32573-1-git-send-email-vishp@ti.com> <1337890467-32573-2-git-send-email-vishp@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:48383 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932201Ab2EYIh0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 25 May 2012 04:37:26 -0400
Received: by bkwj4 with SMTP id j4so761233bkw.22
        for <linux-mmc@vger.kernel.org>; Fri, 25 May 2012 01:37:24 -0700 (PDT)
In-Reply-To: <1337890467-32573-2-git-send-email-vishp@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Viswanath Puttagunta <vishp@ti.com>
Cc: Linux-mmc <linux-mmc@vger.kernel.org>, T Krishnamoorthy Balaji <balajitk@ti.com>, Semen Protsenko <semen.protsenko@ti.com>, Volodymyr Riazantsev <v.riazantsev@ti.com>

On Fri, May 25, 2012 at 1:44 AM, Viswanath Puttagunta <vishp@ti.com> wr=
ote:
> Turn off IO & PBIAS cells and then SD card VMMC as soon
> as we get disconnect interrupt. Failure to do so might
> cause current spikes (latch-up issue) which can potentially
> burn the IO cells.
>
> Signed-off-by: Viswanath Puttagunta <vishp@ti.com>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 13 ++++++++++---
> =A01 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 56d4499..61d830f 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1177,10 +1177,17 @@ static irqreturn_t omap_hsmmc_detect(int irq,=
 void *dev_id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0carddetect =3D -ENOSYS;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (carddetect)
> + =A0 =A0 =A0 if (carddetect) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_detect_change(host->mmc, (HZ * 200=
) / 1000);
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detect_change(host->mmc, (HZ * 50) =
/ 1000);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((MMC_POWER_OFF !=3D host->power_mod=
e) &&

Should be if((host->power_mode !=3D MMC_POWER_OFF)

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (mmc_sl=
ot(host).set_power !=3D NULL)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_slot(host).set_powe=
r(host->dev, host->slot_id,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 0, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->power_mode =3D MM=
C_POWER_OFF;

This is just changing the default behaviour, irrespective of whether
the errata is applicable.
What is the effect of this change for other boards / platforms ?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_detect_change(host->mmc, 0);
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
>
> --
> 1.7.4.1
>
