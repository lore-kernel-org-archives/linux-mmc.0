From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/3] mmc: host: sdhci: Use BUG_ON()
Date: Mon, 11 May 2015 12:31:01 +0200
Message-ID: <CAPDyKFpJMRyGE+pidS_tL9WKoR3-SKuGgSWDFtYpM492H_L4tQ@mail.gmail.com>
References: <1431207891-21448-1-git-send-email-festevam@gmail.com>
	<1431207891-21448-3-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:34144 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752833AbbEKKbD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 May 2015 06:31:03 -0400
Received: by qcyk17 with SMTP id k17so66452169qcy.1
        for <linux-mmc@vger.kernel.org>; Mon, 11 May 2015 03:31:01 -0700 (PDT)
In-Reply-To: <1431207891-21448-3-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>

On 9 May 2015 at 23:44, Fabio Estevam <festevam@gmail.com> wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>
> Use BUG_ON() instead of an 'if' condition followed by BUG().
>
> The semantic patch that makes this change is available
> in scripts/coccinelle/misc/bugon.cocci.
>
> More information about semantic patching is available at
> http://coccinelle.lip6.fr/
>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Thanks, applied!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index c80287a..8d97fe0 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -328,8 +328,7 @@ static void sdhci_read_block_pio(struct sdhci_host *host)
>         local_irq_save(flags);
>
>         while (blksize) {
> -               if (!sg_miter_next(&host->sg_miter))
> -                       BUG();
> +               BUG_ON(!sg_miter_next(&host->sg_miter));
>
>                 len = min(host->sg_miter.length, blksize);
>
> @@ -374,8 +373,7 @@ static void sdhci_write_block_pio(struct sdhci_host *host)
>         local_irq_save(flags);
>
>         while (blksize) {
> -               if (!sg_miter_next(&host->sg_miter))
> -                       BUG();
> +               BUG_ON(!sg_miter_next(&host->sg_miter));
>
>                 len = min(host->sg_miter.length, blksize);
>
> --
> 1.9.1
>
