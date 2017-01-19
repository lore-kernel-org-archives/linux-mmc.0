From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 RESEND] sdhci: Ignore unexpected CARD_INT interrupts
Date: Thu, 19 Jan 2017 21:37:30 +0100
Message-ID: <CAPDyKFpowPmbwvHL9NL60zAABfW53sDKkp0Ag5aXs4jZZLC=Dg@mail.gmail.com>
References: <20170116142342.21283-1-krisman@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:37793 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdASUhd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 15:37:33 -0500
Received: by mail-wm0-f45.google.com with SMTP id c206so12082854wme.0
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2017 12:37:32 -0800 (PST)
In-Reply-To: <20170116142342.21283-1-krisman@collabora.co.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 16 January 2017 at 15:23, Gabriel Krisman Bertazi
<krisman@collabora.co.uk> wrote:
> One of our kernelCI boxes hanged at boot because a faulty eSDHC device
> was triggering spurious CARD_INT interrupts for SD cards, causing CMD52
> reads, which are not allowed for SD devices.  This adds a sanity check
> to the interruption path, preventing that illegal command from getting
> sent if the CARD_INT interruption should be disabled.
>
> This quirk allows that particular machine to resume boot despite the
> faulty hardware, instead of getting hung dealing with thousands of
> mishandled interrupts.
>
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.co.uk>
> CC: Ulf Hansson <ulf.hansson@linaro.org>
> CC: linux-mmc@vger.kernel.org

Thanks, applied for next with update commit msg header and by removing
the CCs from the changelog.

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 51cd4f0e973f..a2efa25c7f3b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2733,7 +2733,8 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>                 if (intmask & SDHCI_INT_RETUNE)
>                         mmc_retune_needed(host->mmc);
>
> -               if (intmask & SDHCI_INT_CARD_INT) {
> +               if ((intmask & SDHCI_INT_CARD_INT) &&
> +                   (host->ier & SDHCI_INT_CARD_INT)) {
>                         sdhci_enable_sdio_irq_nolock(host, false);
>                         host->thread_isr |= SDHCI_INT_CARD_INT;
>                         result = IRQ_WAKE_THREAD;
> --
> 2.11.0
>
