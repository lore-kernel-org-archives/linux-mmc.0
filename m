From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci_f_sdh30: Fix the size passed to sdhci_alloc_host
Date: Tue, 5 May 2015 10:34:42 +0200
Message-ID: <CAPDyKFpttvw=AtkRA_KnQg62TTmmWSxjVDsDv=4iygfQgDU0jg@mail.gmail.com>
References: <1429858829.18906.0.camel@ingics.com>
	<1429858920.18906.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f177.google.com ([209.85.216.177]:33162 "EHLO
	mail-qc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756664AbbEEIen (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 04:34:43 -0400
Received: by qcvz3 with SMTP id z3so35128041qcv.0
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 01:34:42 -0700 (PDT)
In-Reply-To: <1429858920.18906.2.camel@ingics.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Andy Green <andy.green@linaro.org>, Vincent Yang <vincent.yang.fujitsu@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 24 April 2015 at 09:02, Axel Lin <axel.lin@ingics.com> wrote:
> sdhci_alloc_host() takes priv_size rather than
> sizeof(struct sdhci_host) + priv_size.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Thanks, applied!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci_f_sdh30.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_sdh30.c
> index 5397e27..983b8b3 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -114,8 +114,7 @@ static int sdhci_f_sdh30_probe(struct platform_device *pdev)
>                 return irq;
>         }
>
> -       host = sdhci_alloc_host(dev, sizeof(struct sdhci_host) +
> -                                               sizeof(struct f_sdhost_priv));
> +       host = sdhci_alloc_host(dev, sizeof(struct f_sdhost_priv));
>         if (IS_ERR(host))
>                 return PTR_ERR(host);
>
> --
> 2.1.0
>
>
>
