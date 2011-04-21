From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] sdhci: add quirk to support shared bus controller
Date: Thu, 21 Apr 2011 04:05:14 -0500
Message-ID: <BANLkTincOuKrTEzP3gv-d2Vk-Cih+BS4hw@mail.gmail.com>
References: <BANLkTi=7h_gBQ1CGqYgUUhZabcwVuoRhCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og117.obsmtp.com ([64.18.0.149]:36283 "EHLO
	exprod5og117.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831Ab1DUJFT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 05:05:19 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.22.94.168])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3L95fhE002390
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 05:05:41 -0400 (EDT)
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com [74.125.82.170])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p3L95dMd002366
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 05:05:41 -0400 (EDT)
Received: by wyb34 with SMTP id 34so1877270wyb.15
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 02:05:14 -0700 (PDT)
In-Reply-To: <BANLkTi=7h_gBQ1CGqYgUUhZabcwVuoRhCw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Barry Song <21cnbao@gmail.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, bin.shi@csr.com, Binghua.Duan@csr.com

Hi,

On Thu, Apr 21, 2011 at 3:51 AM, Barry Song <21cnbao@gmail.com> wrote:
> From: Bin Shi <bin.shi@csr.com>
>
> some controllers share data bus or other pins between
> multi-controllers and need to switch the functions of shared pins
> runtime
> this patch requested those shared pins before actual hardware access
> and release them after access
>
> Signed-off-by: Bin Shi <bin.shi@csr.com>
> Cc: Binghua Duan <binghua.duan@csr.com>
> Signed-off-by: Barry Song <21cnbao@gmail.com>
> ---
> =A0drivers/mmc/host/sdhci.c =A0| =A0 13 +++++++++++++
> =A0drivers/mmc/host/sdhci.h =A0| =A0 =A02 ++
> =A0include/linux/mmc/sdhci.h | =A0 =A02 ++
> =A03 files changed, 17 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f31077d..7b07152 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1379,6 +1379,13 @@ static void sdhci_tasklet_finish(unsigned long=
 param)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sdhci_reset(host, SDHCI_RESET_DATA);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* some controllers share data bus or other pins betw=
een multi-controller
> + =A0 =A0 =A0 =A0* and need to switch the function of pins runtime
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_SHARED_PINS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->get_shared_pins(host);
> +

Why in tasklet_finish? Why not in sdhci_request?
No need to waste a quirk flag. Just invoke if method is not NULL.

Also, I would assume host->ops->get_shared_pins would need to
synchronize with other SDHCI instances
it shares the pins with. Since you do it after the host->lock (as you
should), what happens if get_shared_pins needs to wait?
Can you show the rest (sdhci driver implementing these hooks)?

> =A0 =A0 =A0 =A0host->mrq =3D NULL;
> =A0 =A0 =A0 =A0host->cmd =3D NULL;
> =A0 =A0 =A0 =A0host->data =3D NULL;
> @@ -1391,6 +1398,12 @@ static void sdhci_tasklet_finish(unsigned long=
 param)
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
>
> =A0 =A0 =A0 =A0mmc_request_done(host->mmc, mrq);
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* release shared pins so that other controllers can =
use them
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (host->quirks & SDHCI_QUIRK_SHARED_PINS)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->ops->get_shared_pins(host);
> =A0}
>
> =A0static void sdhci_timeout_timer(unsigned long data)
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 85750a9..9d918a5 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -229,6 +229,8 @@ struct sdhci_ops {
> =A0 =A0 =A0 =A0void (*platform_send_init_74_clocks)(struct sdhci_host=
 *host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 u8 power_mode);
> =A0 =A0 =A0 =A0unsigned int =A0 =A0(*get_ro)(struct sdhci_host *host)=
;
> + =A0 =A0 =A0 unsigned int =A0 =A0(*get_shared_pins)(struct sdhci_hos=
t *host);
> + =A0 =A0 =A0 unsigned int =A0 =A0(*put_shared_pins)(struct sdhci_hos=
t *host);
> =A0};
>
> =A0#ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index 83bd9f7..32ab422 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -85,6 +85,8 @@ struct sdhci_host {
> =A0#define SDHCI_QUIRK_NO_HISPD_BIT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 (1<<29)
> =A0/* Controller treats ADMA descriptors with length 0000h incorrectl=
y */
> =A0#define SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC =A0 =A0 =A0 =A0 =A0 (=
1<<30)
> +/* Controller shared data bus or other pins with other controllers *=
/
> +#define SDHCI_QUIRK_SHARED_PINS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 (1<<31)
>
> =A0 =A0 =A0 =A0int irq; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Device IRQ =
*/
> =A0 =A0 =A0 =A0void __iomem *ioaddr; =A0 /* Mapped address */
> --
> 1.7.1
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
