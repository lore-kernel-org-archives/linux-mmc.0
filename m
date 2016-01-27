From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/5 RFC] mmc: sdhci-iproc: Clean up platform allocations
 if shdci init fails
Date: Wed, 27 Jan 2016 15:16:15 +0100
Message-ID: <CAPDyKFotbX4cA-GxTbj5S=XEmeVYs+ZvNp53WJdTSj9abTja4A@mail.gmail.com>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
	<1453042744-16196-2-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35913 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932393AbcA0OQQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Jan 2016 09:16:16 -0500
Received: by mail-yk0-f175.google.com with SMTP id v14so241632184ykd.3
        for <linux-mmc@vger.kernel.org>; Wed, 27 Jan 2016 06:16:16 -0800 (PST)
In-Reply-To: <1453042744-16196-2-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, kernel@martin.sperl.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, linux-mmc <linux-mmc@vger.kernel.org>, bcm-kernel-feedback-list@broadcom.com

On 17 January 2016 at 15:59, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> This patch adopts the changes from 475c9e43bfa7 ("mmc: sdhci-bcm2835:
> Clean up platform allocations if sdhci init fails") to sdhci-iproc.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-iproc.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 3b423b0..e22060a 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -213,7 +213,11 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>                 host->caps1 = iproc_host->data->caps1;
>         }
>
> -       return sdhci_add_host(host);
> +       ret = sdhci_add_host(host);
> +       if (ret)
> +               goto err;
> +
> +       return 0;
>
>  err:
>         sdhci_pltfm_free(pdev);
> --
> 1.7.9.5
>
