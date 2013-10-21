From: Zhang Haijun <b42677@freescale.com>
Subject: Re: [PATCH 1/2] mmc:sdhc: Add vendor specific interrupt and handle
 routine
Date: Mon, 21 Oct 2013 17:20:21 +0800
Message-ID: <5264F1D5.3080403@freescale.com>
References: <1379395711-28462-1-git-send-email-Haijun.Zhang@freescale.com> <1379395711-28462-2-git-send-email-Haijun.Zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from [213.199.154.207] ([213.199.154.207]:12305 "EHLO
	am1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1754972Ab3JUJV1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 21 Oct 2013 05:21:27 -0400
In-Reply-To: <1379395711-28462-2-git-send-email-Haijun.Zhang@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Haijun Zhang <Haijun.Zhang@freescale.com>, linux-mmc@vger.kernel.org
Cc: cbouatmailru@gmail.com, cjb@laptop.org, scottwood@freescale.com, X.Xie@freescale.com, ulf.hansson@linaro.org

Hi, Ulf

Coud you give some advice on this patch?


Thanks.

=D3=DA 2013/9/17 13:28, Haijun Zhang =D0=B4=B5=C0:
> As spec detailed:
> Error Interrupt Status Register(Offset 032h)[15-12]
> Error Interrupt Status Enable Register (Offset 036h)[15-12]
> Error Interrupt Signal Enable Register (Offset 03Ah)[15-12]
>
> Bits above are specified by vendor itself.
> So add interface to handle this requirememt.
> Also share sdhci_dma_show in sdhc.h for platform usr.
>
> Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
> ---
>  drivers/mmc/host/sdhci.c | 25 +++++++++++++++++++------
>  drivers/mmc/host/sdhci.h |  5 +++++
>  2 files changed, 24 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index b4d7f27..2ba9c6d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -238,16 +238,25 @@ static void sdhci_set_ios(struct mmc_host *mmc,=
 struct mmc_ios *ios);
> =20
>  static void sdhci_init(struct sdhci_host *host, int soft)
>  {
> +	u32 pltm_irq =3D 0, irq =3D 0;
> +
>  	if (soft)
>  		sdhci_reset(host, SDHCI_RESET_CMD|SDHCI_RESET_DATA);
>  	else
>  		sdhci_reset(host, SDHCI_RESET_ALL);
> =20
> -	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK,
> -		SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
> +	irq =3D SDHCI_INT_BUS_POWER | SDHCI_INT_DATA_END_BIT |
>  		SDHCI_INT_DATA_CRC | SDHCI_INT_DATA_TIMEOUT | SDHCI_INT_INDEX |
>  		SDHCI_INT_END_BIT | SDHCI_INT_CRC | SDHCI_INT_TIMEOUT |
> -		SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE);
> +		SDHCI_INT_DATA_END | SDHCI_INT_RESPONSE;
> +	/* Vendor Specific Error Status, Status enable and Signal Enable */
> +	if (host->ops->get_platform_irq)
> +		host->ops->get_platform_irq(host, &pltm_irq);
> +
> +	if (pltm_irq)
> +		irq |=3D pltm_irq;
> +
> +	sdhci_clear_set_irqs(host, SDHCI_INT_ALL_MASK, irq);
> =20
>  	if (soft) {
>  		/* force clock reconfiguration */
> @@ -2241,6 +2250,9 @@ static void sdhci_cmd_irq(struct sdhci_host *ho=
st, u32 intmask)
>  			SDHCI_INT_INDEX))
>  		host->cmd->error =3D -EILSEQ;
> =20
> +	if (host->ops->handle_platform_irq)
> +		host->ops->handle_platform_irq(host, intmask);
> +
>  	if (host->cmd->error) {
>  		tasklet_schedule(&host->finish_tasklet);
>  		return;
> @@ -2273,7 +2285,7 @@ static void sdhci_cmd_irq(struct sdhci_host *ho=
st, u32 intmask)
>  }
> =20
>  #ifdef CONFIG_MMC_DEBUG
> -static void sdhci_show_adma_error(struct sdhci_host *host)
> +void sdhci_show_adma_error(struct sdhci_host *host)
>  {
>  	const char *name =3D mmc_hostname(host->mmc);
>  	u8 *desc =3D host->adma_desc;
> @@ -2350,10 +2362,11 @@ static void sdhci_data_irq(struct sdhci_host =
*host, u32 intmask)
>  		pr_err("%s: ADMA error\n", mmc_hostname(host->mmc));
>  		sdhci_show_adma_error(host);
>  		host->data->error =3D -EIO;
> -		if (host->ops->adma_workaround)
> -			host->ops->adma_workaround(host, intmask);
>  	}
> =20
> +	if (host->ops->handle_platform_irq)
> +		host->ops->handle_platform_irq(host, intmask);
> +
>  	if (host->data->error)
>  		sdhci_finish_data(host);
>  	else {
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index b037f18..a0f1734 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -292,6 +292,8 @@ struct sdhci_ops {
>  	void	(*hw_reset)(struct sdhci_host *host);
>  	void	(*platform_suspend)(struct sdhci_host *host);
>  	void	(*platform_resume)(struct sdhci_host *host);
> +	void    (*get_platform_irq)(struct sdhci_host *host, u32 *irq);
> +	void    (*handle_platform_irq)(struct sdhci_host *host, u32 intmask=
);
>  	void    (*adma_workaround)(struct sdhci_host *host, u32 intmask);
>  	void	(*platform_init)(struct sdhci_host *host);
>  	void    (*card_event)(struct sdhci_host *host);
> @@ -405,4 +407,7 @@ extern int sdhci_runtime_suspend_host(struct sdhc=
i_host *host);
>  extern int sdhci_runtime_resume_host(struct sdhci_host *host);
>  #endif
> =20
> +#ifdef CONFIG_MMC_DEBUG
> +extern void sdhci_show_adma_error(struct sdhci_host *host);
> +#endif
>  #endif /* __SDHCI_HW_H */

--=20
Thanks & Regards
Haijun.


