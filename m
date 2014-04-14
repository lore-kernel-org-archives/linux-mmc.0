From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND] mmc: sdhci-s3c: Remove unused define for NUM_GPIOS
Date: Mon, 14 Apr 2014 14:57:31 +0200
Message-ID: <CAPDyKFpTOjXbgepXcEDm0=UhNyAv+4bsQ8jzynAzqU=vQbyKAw@mail.gmail.com>
References: <1394262224.3868.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:58787 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282AbaDNM5b (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Apr 2014 08:57:31 -0400
Received: by mail-qa0-f53.google.com with SMTP id w8so7794694qac.40
        for <linux-mmc@vger.kernel.org>; Mon, 14 Apr 2014 05:57:31 -0700 (PDT)
In-Reply-To: <1394262224.3868.1.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Chris Ball <chris@printf.net>, Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc <linux-mmc@vger.kernel.org>

On 8 March 2014 08:03, Axel Lin <axel.lin@ingics.com> wrote:
> NUM_GPIOS is not used after commit e19499ae
> "mmc: sdhci-s3c: let device core setup the default pin configuration".
> Thus remove it.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  drivers/mmc/host/sdhci-s3c.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 926aaf6..d0732d2 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -33,9 +33,6 @@
>
>  #define MAX_BUS_CLK    (4)
>
> -/* Number of gpio's used is max data bus width + command and clock lines */
> -#define NUM_GPIOS(x)   (x + 2)
> -
>  /**
>   * struct sdhci_s3c - S3C SDHCI instance
>   * @host: The SDHCI host created
> --
> 1.8.1.2
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
