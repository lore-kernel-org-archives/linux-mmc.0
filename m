From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci_f_sdh30: Staticize local functions
Date: Tue, 5 May 2015 10:34:36 +0200
Message-ID: <CAPDyKFp+7=pEh8-rjSAMLrF1Ff-wWLrbjUzz_JngoXAv0o_LPw@mail.gmail.com>
References: <1429858829.18906.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f173.google.com ([209.85.216.173]:33125 "EHLO
	mail-qc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756797AbbEEIeh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 04:34:37 -0400
Received: by qcvz3 with SMTP id z3so35127200qcv.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 01:34:36 -0700 (PDT)
In-Reply-To: <1429858829.18906.0.camel@ingics.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Andy Green <andy.green@linaro.org>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 24 April 2015 at 09:00, Axel Lin <axel.lin@ingics.com> wrote:
> Make local functions static.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Thanks, applied!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index 2fe8b91..5397e27 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -49,7 +49,7 @@ struct f_sdhost_priv {
>         struct device *dev;
>  };
>
> -void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
> +static void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
>  {
>         struct f_sdhost_priv *priv = sdhci_priv(host);
>         u32 ctrl = 0;
> @@ -77,12 +77,12 @@ void sdhci_f_sdh30_soft_voltage_switch(struct sdhci_host *host)
>         sdhci_writel(host, ctrl, F_SDH30_TUNING_SETTING);
>  }
>
> -unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
> +static unsigned int sdhci_f_sdh30_get_min_clock(struct sdhci_host *host)
>  {
>         return F_SDH30_MIN_CLOCK;
>  }
>
> -void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
> +static void sdhci_f_sdh30_reset(struct sdhci_host *host, u8 mask)
>  {
>         if (sdhci_readw(host, SDHCI_CLOCK_CONTROL) == 0)
>                 sdhci_writew(host, 0xBC01, SDHCI_CLOCK_CONTROL);
> --
> 2.1.0
>
>
>
