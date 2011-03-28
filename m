From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] SDHCI: Suspend/Resume needs to save/restore INT_ENABLE on ARM/Tegra2
Date: Mon, 28 Mar 2011 12:50:15 -0700
Message-ID: <BANLkTim3cFTC-0f91Pufp99P3sy1hNNyZg@mail.gmail.com>
References: <20110308213921.00625208186@grundler.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:27656 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab1C1TuS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Mar 2011 15:50:18 -0400
Received: from kpbe13.cbf.corp.google.com (kpbe13.cbf.corp.google.com [172.25.105.77])
	by smtp-out.google.com with ESMTP id p2SJoHqg010557
	for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2011 12:50:17 -0700
Received: from gxk27 (gxk27.prod.google.com [10.202.11.27])
	by kpbe13.cbf.corp.google.com with ESMTP id p2SJoFwl032269
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2011 12:50:15 -0700
Received: by gxk27 with SMTP id 27so1920089gxk.1
        for <linux-mmc@vger.kernel.org>; Mon, 28 Mar 2011 12:50:15 -0700 (PDT)
In-Reply-To: <20110308213921.00625208186@grundler.mtv.corp.google.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Chris,
Ping?

The discussion on save/restoring SDHCI_INT_ENABLE reached consensus
that this patch is needed. Can you still apply?


On Tue, Mar 8, 2011 at 1:39 PM, Grant Grundler <grundler@google.com> wr=
ote:
>
> Save and restore SDHCI interrupt mask during suspend/resume.
> Enables ARM Tegra2 board to suspend/resume.
>
> Signed-off-by: Venkat Rao <vrao@broadcom.com>
> Reviewed-by: Olof Johansson <olofj@chromium.org>
> Reviewed-by: Grant Grundler <grundler@chromium.org>

Please add "From: Venkat Rao <vrao@broadcom.com>" since he should get
"author credit" for this patch.

thanks,
grant


> ---
> =C2=A0drivers/mmc/host/sdhci.c =C2=A0| =C2=A0 =C2=A05 +++++
> =C2=A0include/linux/mmc/sdhci.h | =C2=A0 =C2=A02 ++
> =C2=A02 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 3c6358f..68d2e36 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1654,6 +1654,8 @@ int sdhci_suspend_host(struct sdhci_host *host,=
 pm_message_t state)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mmc->card && (mmc->card->type !=3D MMC=
_TYPE_SDIO))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D mmc_su=
spend_host(host->mmc);
>
> + =C2=A0 =C2=A0 =C2=A0 /* Save the original intmask to restore later =
*/
> + =C2=A0 =C2=A0 =C2=A0 host->save_intmask =3D sdhci_readl(host, SDHCI=
_INT_ENABLE);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sdhci_mask_irqs(host, SDHCI_INT_ALL_MASK);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (host->vmmc)
> @@ -1695,6 +1697,9 @@ int sdhci_resume_host(struct sdhci_host *host)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sdhci_enable_card_detection(host);
>
> + =C2=A0 =C2=A0 =C2=A0 /* Restore the original intmask */
> + =C2=A0 =C2=A0 =C2=A0 sdhci_unmask_irqs(host, host->save_intmask);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;
> =C2=A0}
>
> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
> index dfb2106..5b9f6db 100644
> --- a/include/linux/mmc/sdhci.h
> +++ b/include/linux/mmc/sdhci.h
> @@ -141,6 +141,8 @@ struct sdhci_host {
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int caps; =C2=A0 =C2=A0 =C2=A0/* =
Alternative capabilities */
>
> + =C2=A0 =C2=A0 =C2=A0 unsigned int save_intmask; =C2=A0 =C2=A0/* Sto=
re original intmask */
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned long private[0] ____cacheline_ali=
gned;
> =C2=A0};
> =C2=A0#endif /* __SDHCI_H */
> --
> 1.7.2.3
>
>
