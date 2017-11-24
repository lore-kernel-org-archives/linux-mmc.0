From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: sdhci broke in 4.14 [was: MMC fixes for v.4.14-rc4]
Date: Fri, 24 Nov 2017 16:15:58 +0100
Message-ID: <1861ba33-1d08-ef18-8208-174942be5395@suse.cz>
References: <1507361610-31577-1-git-send-email-ulf.hansson@linaro.org>
 <2248b8b6-a80f-52ef-943f-54c1351d5a36@suse.cz>
 <CAPDyKFrzVaE=upRbJ+sq2rRcR1uitw2QEvTzt=pjtoNh1bij9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37424 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751590AbdKXPQC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Nov 2017 10:16:02 -0500
In-Reply-To: <CAPDyKFrzVaE=upRbJ+sq2rRcR1uitw2QEvTzt=pjtoNh1bij9Q@mail.gmail.com>
Content-Language: en-GB
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linus <torvalds@linux-foundation.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Adrian Hunter <adrian.hunter@intel.com>, Linus Walleij <linus.walleij@linaro.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Rzeszutek Wilk <konrad@kernel.org>

On 11/21/2017, 04:08 PM, Ulf Hansson wrote:
> Subject: [PATCH] mmc: sdhci: Fix bounce buffer overflow
...
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
...
> @@ -3651,22 +3652,29 @@ int sdhci_setup_host(struct sdhci_host *host)
>         spin_lock_init(&host->lock);
> 
>         /*
> +        * Maximum number of sectors in one transfer. Limited by SDMA boundary
> +        * size (512KiB). Note some tuning modes impose a 4MiB limit, but this
> +        * is less anyway.
> +        */
> +       mmc->max_req_size = 524288;
> +
> +       /*
>          * Maximum number of segments. Depends on if the hardware
>          * can do scatter/gather or not.
>          */
> -       if (host->flags & SDHCI_USE_ADMA)
> +       if (host->flags & SDHCI_USE_ADMA) {
>                 mmc->max_segs = SDHCI_MAX_SEGS;
> -       else if (host->flags & SDHCI_USE_SDMA)
> +       } else if (host->flags & SDHCI_USE_SDMA) {
>                 mmc->max_segs = 1;
> -       else /* PIO */
> +               if (swiotlb_max_segment()) {
> +                       unsigned int max_req_size = (1 << IO_TLB_SHIFT) *
> +                                               IO_TLB_SEGSIZE;
> +                       mmc->max_req_size = min(mmc->max_req_size,
> +                                               max_req_size);
> +               }
> +       } else { /* PIO */
>                 mmc->max_segs = SDHCI_MAX_SEGS;

It seems to work fine. FWIW the debug output is:
[    0.708312] mmc0: max_segs=1 max_req_size=262144 h->flags=00004001

thanks,
-- 
js
suse labs
