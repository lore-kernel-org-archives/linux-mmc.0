From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH] SDHCI: Suspend/Resume needs to save/restore INT_ENABLE on ARM/Tegra2
Date: Wed, 9 Mar 2011 14:24:54 -0600
Message-ID: <AANLkTik3vKKs+Sxe1g+igFOpqmdYDMec7MH1mKjv0qGw@mail.gmail.com>
References: <20110308213921.00625208186@grundler.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og104.obsmtp.com ([64.18.0.178]:49328 "EHLO
	exprod5og104.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab1CIUY5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Mar 2011 15:24:57 -0500
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.130.20])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p29KPDKR005953
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 15:25:13 -0500 (EST)
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com [209.85.212.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p29JbW7b006737
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Wed, 9 Mar 2011 15:25:12 -0500 (EST)
Received: by mail-vw0-f42.google.com with SMTP id 10so1043531vws.15
        for <linux-mmc@vger.kernel.org>; Wed, 09 Mar 2011 12:24:55 -0800 (PST)
In-Reply-To: <20110308213921.00625208186@grundler.mtv.corp.google.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@google.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Tue, Mar 8, 2011 at 3:39 PM, Grant Grundler <grundler@google.com> wr=
ote:
>
> Save and restore SDHCI interrupt mask during suspend/resume.
> Enables ARM Tegra2 board to suspend/resume.
>
> Signed-off-by: Venkat Rao <vrao@broadcom.com>
> Reviewed-by: Olof Johansson <olofj@chromium.org>
> Reviewed-by: Grant Grundler <grundler@chromium.org>
> ---
> =A0drivers/mmc/host/sdhci.c =A0| =A0 =A05 +++++
> =A0include/linux/mmc/sdhci.h | =A0 =A02 ++
> =A02 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3c6358f..68d2e36 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1654,6 +1654,8 @@ int sdhci_suspend_host(struct sdhci_host *host,=
 pm_message_t state)
> =A0 =A0 =A0 =A0if (mmc->card && (mmc->card->type !=3D MMC_TYPE_SDIO))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D mmc_suspend_host(host->mmc);
>
> + =A0 =A0 =A0 /* Save the original intmask to restore later */
> + =A0 =A0 =A0 host->save_intmask =3D sdhci_readl(host, SDHCI_INT_ENAB=
LE);
> =A0 =A0 =A0 =A0sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
>
> =A0 =A0 =A0 =A0if (host->vmmc)
> @@ -1695,6 +1697,9 @@ int sdhci_resume_host(struct sdhci_host *host)
>
> =A0 =A0 =A0 =A0sdhci_enable_card_detection(host);
>
> + =A0 =A0 =A0 /* Restore the original intmask */
> + =A0 =A0 =A0 sdhci_unmask_irqs(host, host->save_intmask);
> +
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index dfb2106..5b9f6db 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -141,6 +141,8 @@ struct sdhci_host {
>
> =A0 =A0 =A0 =A0unsigned int caps; =A0 =A0 =A0/* Alternative capabilit=
ies */
>
> + =A0 =A0 =A0 unsigned int save_intmask; =A0 =A0/* Store original int=
mask */
> +
> =A0 =A0 =A0 =A0unsigned long private[0] ____cacheline_aligned;
> =A0};
> =A0#endif /* __SDHCI_H */
> --
> 1.7.2.3
>
> --

Hi Grant,

Why is this necessary? If I understand correctly, the sdhci resume
sequence sets some base needed bits inside SDHCI_INT_ENABLE inside
sdhci_clear_set_irqs. Only if you have some outstanding DMA, but
surely all DMA must be completed prior to your suspending
(mmc_queue_suspend ensures nothing is outstanding)?

I'm asking since we're on Tegra 2 and have suspend/resume working fine
with eMMC.

Thanks,
A
