From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: mmc: core: Add check for card type before mmc_hw_reset_for_init
Date: Fri, 23 Aug 2013 13:04:15 +0200
Message-ID: <CAPDyKFoUAPk69PoEp9h2O8aSfAieVdgAa5B3mPDmKzPtto9r3g@mail.gmail.com>
References: <loom.20130812T082444-829@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f51.google.com ([209.85.212.51]:52393 "EHLO
	mail-vb0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab3HWLEQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Aug 2013 07:04:16 -0400
Received: by mail-vb0-f51.google.com with SMTP id x16so332734vbf.10
        for <linux-mmc@vger.kernel.org>; Fri, 23 Aug 2013 04:04:15 -0700 (PDT)
In-Reply-To: <loom.20130812T082444-829@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prasanna NAVARATNA <prasanna.navaratna@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 12 August 2013 09:02, Prasanna NAVARATNA
<prasanna.navaratna@gmail.com> wrote:
> Almost all the places, before calling hw_reset ops, the card type is checked
> to make sure it is eMMC but missed during mmc_rescan_try_freq.
> The below patch adds the check for card type before calling hardware reset
> for init as double safety measure.
>
> From e7941c5b3b4999318feb59fa83b78c15c13493b3 Mon Sep 17 00:00:00 2001
> From: Prasanna NAVARATNA <prasanna.navaratna@broadcom.com>
> Date: Mon, 12 Aug 2013 12:26:57 +0530
> Subject: [PATCH] mmc: core: add check for card type before
>  mmc_hw_reset_for_init
>
> During mmc_hw_reset_for_init, the card type is not checked before
> calling hw_reset ops.
> Add check for the card type as emmc before issuing hw_reset during init.
>
> Signed-off-by: Prasanna NAVARATNA <prasanna.navaratna@broadcom.com>
> ---
>  drivers/mmc/core/core.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 49a5bca..2dad69a 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2196,7 +2196,8 @@ EXPORT_SYMBOL(mmc_set_blockcount);
>
>  static void mmc_hw_reset_for_init(struct mmc_host *host)
>  {
> -       if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset)
> +       if (!(host->caps & MMC_CAP_HW_RESET) || !host->ops->hw_reset ||
> +                       !mmc_card_mmc(host->card))

No, this does not work.

At this point we don't know the card type yet since we have not
initialized it. We can only trust the host->ops is performing what we
expect.

Kind regards
Ulf Hansson

>                 return;
>         mmc_host_clk_hold(host);
>         host->ops->hw_reset(host);
> --
> 1.7.6
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
