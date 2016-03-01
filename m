From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci: Set DMA mask
Date: Tue, 01 Mar 2016 22:30:26 +0100
Message-ID: <12391836.3mgJ3uDMLr@wuerfel>
References: <1456806764-16467-1-git-send-email-acourbot@nvidia.com> <1456806764-16467-2-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456806764-16467-2-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 01 March 2016 13:32:43 Alexandre Courbot wrote:
>          */
> -       if (!(host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA))) {
> +       if (!(host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)))
>                 host->dma_mask = DMA_BIT_MASK(64);
> -               mmc_dev(mmc)->dma_mask = &host->dma_mask;
> -       }
> +
> +       if (host->dma_mask &&
> +           dma_set_mask_and_coherent(mmc_dev(mmc), host->dma_mask))
> +               pr_warn("%s: cannot set DMA mask\n", mmc_hostname(mmc));
> 

Looks good, 

Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
