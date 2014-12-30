From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci: Remove redundant ADMA page boundary warnings
Date: Tue, 30 Dec 2014 11:58:35 +0100
Message-ID: <CAPDyKFopfQmB9_+MyjwPpKV_jwq+Cc0Ha5Kw8dOUxYKOX3Uitw@mail.gmail.com>
References: <1419251001-12168-1-git-send-email-andrew_gabbasov@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f41.google.com ([209.85.216.41]:53820 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbaL3K6g (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Dec 2014 05:58:36 -0500
Received: by mail-qa0-f41.google.com with SMTP id s7so10185970qap.28
        for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2014 02:58:35 -0800 (PST)
In-Reply-To: <1419251001-12168-1-git-send-email-andrew_gabbasov@mentor.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Gabbasov <andrew_gabbasov@mentor.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 22 December 2014 at 13:23, Andrew Gabbasov
<andrew_gabbasov@mentor.com> wrote:
> The bounce buffer, used for misaligned bytes for ADMA access,
> resides wholly within the (align_sz)-aligned word, just by construction.
> The page addresses are aligned to (align_sz), either for 4 or 8 bytes
> alignment, so that the aligned word resides wholly within a single page
> and can't cross the page boundary. So, the bounce buffer can't cross
> the page boundary too. That's why the warnings are never hit, and can
> be safely removed.
>
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>

Thanks! Applied for next.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index cbb245b..9dc2770 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -533,8 +533,6 @@ static int sdhci_adma_table_pre(struct sdhci_host *host,
>                 if (offset) {
>                         if (data->flags & MMC_DATA_WRITE) {
>                                 buffer = sdhci_kmap_atomic(sg, &flags);
> -                               WARN_ON(((long)buffer & (PAGE_SIZE - 1)) >
> -                                       (PAGE_SIZE - offset));
>                                 memcpy(align, buffer, offset);
>                                 sdhci_kunmap_atomic(buffer, &flags);
>                         }
> @@ -641,8 +639,6 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
>                                        (sg_dma_address(sg) & host->align_mask);
>
>                                 buffer = sdhci_kmap_atomic(sg, &flags);
> -                               WARN_ON(((long)buffer & (PAGE_SIZE - 1)) >
> -                                       (PAGE_SIZE - size));
>                                 memcpy(buffer, align, size);
>                                 sdhci_kunmap_atomic(buffer, &flags);
>
> --
> 2.1.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
