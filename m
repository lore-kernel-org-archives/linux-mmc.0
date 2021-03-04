Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065A7C433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 13:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE80E64F4A
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 13:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241491AbhCDNvP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 08:51:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241600AbhCDNvN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 08:51:13 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49498C061574
        for <linux-mmc@vger.kernel.org>; Thu,  4 Mar 2021 05:50:33 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id b189so8653620vsd.0
        for <linux-mmc@vger.kernel.org>; Thu, 04 Mar 2021 05:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cuj7PrrpTUGz6W6b+3LSWHrJMrhRSHgCKv4axOnp68A=;
        b=zkoV0/hJBCXr3hS9sIJVhnnxQzzfcseN453Du+BSX3NKMq/sEQUel/sgBOZUAnXoIL
         gJiyeeziPYCIxJQlyWGlgycgsb6PxUZpWYwvxGFCioOfZgYbnqzbgUyboNPWBSssbbWw
         ny33lLNgZO+oRrt9h1ss29rjEVoo0A2/u6UtF9KGFp73rdEGWnZugdgT+s2ckLlqBa2P
         8YHzjD16VDVcTl58m1+GyAM4YUSPXR8c02dVIrEw/7ZAbdYB6TBWyrEbVIU95UJvxf3t
         I+7wEflKW+olGkIyBnENPAVqQERQATH95QvIMh8QdNkAtqMWLejv/8EOlqw1sL5rw+Lx
         3ydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cuj7PrrpTUGz6W6b+3LSWHrJMrhRSHgCKv4axOnp68A=;
        b=LaqXo8a8ZgcV9l9L6yXaJThU+iEKGwr5f7kIt0Mg1H/i0qw1bZqPLHAxT2Jnfaw2BE
         Vkl91shcUmtTCw2Iv1UPghbKNQ4xmDUc7qQ+9xGYrKhMkf3S7XmJz7YfVxrEy6KjQ/GN
         /VySqE88zK68KdlIK4w5sr+3fgXnmhshzuNBSKd7vyRHLi4pJWz9a8TDb+YUUfbnzenb
         nZmWsH3CqCeG+OiaBBym7JS8ARsqqWldqfPVQxYJ2/eSKcE07Kuv4TQdx+0tTYced00b
         JRva8pGC8dq+dxBdz50bS4GAJI2xHjqsLzYuKdJ+irTYf7pQR/XngAsze9FDDl32FSv/
         HjdQ==
X-Gm-Message-State: AOAM5319nnfqKO7/f3icwu2wtf/mu3lew4I4y19V6y2hyfLnBQZAhxkq
        VgVeuMTYRKgAPBfykNg6YH94RndMqnO0u4RGt8dx4WDM1QdzCQ==
X-Google-Smtp-Source: ABdhPJwAc1wO/KSW/CPaJgowVTMaXIAiHRBU7RsSYpC0VdVPy1G60E9AZZMaeX+wsYX2NmTRbAq8x9H/MV6CDweQt3k=
X-Received: by 2002:a67:c787:: with SMTP id t7mr2666358vsk.48.1614865832499;
 Thu, 04 Mar 2021 05:50:32 -0800 (PST)
MIME-Version: 1.0
References: <1614760331-43499-1-git-send-email-pragalla@qti.qualcomm.com>
In-Reply-To: <1614760331-43499-1-git-send-email-pragalla@qti.qualcomm.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Mar 2021 14:49:55 +0100
Message-ID: <CAPDyKFqFNr7AiOdVP07XS=CKpMbDKC7n0gMPu0516fgH3=S18Q@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci: Check for reset prior to DMA address unmap
To:     Pradeep P V K <pragalla@qti.qualcomm.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pradeep P V K <pragalla@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 3 Mar 2021 at 09:32, Pradeep P V K <pragalla@qti.qualcomm.com> wrote:
>
> From: Pradeep P V K <pragalla@codeaurora.org>
>
> For data read commands, SDHC may initiate data transfers even before it
> completely process the command response. In case command itself fails,
> driver un-maps the memory associated with data transfer but this memory
> can still be accessed by SDHC for the already initiated data transfer.
> This scenario can lead to un-mapped memory access error.
>
> To avoid this scenario, reset SDHC (when command fails) prior to
> un-mapping memory. Resetting SDHC ensures that all in-flight data
> transfers are either aborted or completed. So we don't run into this
> scenario.
>
> Swap the reset, un-map steps sequence in sdhci_request_done().
>
> Changes since V1:
> - Added an empty line and fixed the comment style.
> - Retained the Acked-by signoff.
>
> Suggested-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> Signed-off-by: Pradeep P V K <pragalla@codeaurora.org>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Seems like it might be a good idea to tag this for stable? I did that,
but awaiting for your confirmation.

So, applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci.c | 60 +++++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 646823d..130fd2d 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2998,6 +2998,37 @@ static bool sdhci_request_done(struct sdhci_host *host)
>         }
>
>         /*
> +        * The controller needs a reset of internal state machines
> +        * upon error conditions.
> +        */
> +       if (sdhci_needs_reset(host, mrq)) {
> +               /*
> +                * Do not finish until command and data lines are available for
> +                * reset. Note there can only be one other mrq, so it cannot
> +                * also be in mrqs_done, otherwise host->cmd and host->data_cmd
> +                * would both be null.
> +                */
> +               if (host->cmd || host->data_cmd) {
> +                       spin_unlock_irqrestore(&host->lock, flags);
> +                       return true;
> +               }
> +
> +               /* Some controllers need this kick or reset won't work here */
> +               if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
> +                       /* This is to force an update */
> +                       host->ops->set_clock(host, host->clock);
> +
> +               /*
> +                * Spec says we should do both at the same time, but Ricoh
> +                * controllers do not like that.
> +                */
> +               sdhci_do_reset(host, SDHCI_RESET_CMD);
> +               sdhci_do_reset(host, SDHCI_RESET_DATA);
> +
> +               host->pending_reset = false;
> +       }
> +
> +       /*
>          * Always unmap the data buffers if they were mapped by
>          * sdhci_prepare_data() whenever we finish with a request.
>          * This avoids leaking DMA mappings on error.
> @@ -3060,35 +3091,6 @@ static bool sdhci_request_done(struct sdhci_host *host)
>                 }
>         }
>
> -       /*
> -        * The controller needs a reset of internal state machines
> -        * upon error conditions.
> -        */
> -       if (sdhci_needs_reset(host, mrq)) {
> -               /*
> -                * Do not finish until command and data lines are available for
> -                * reset. Note there can only be one other mrq, so it cannot
> -                * also be in mrqs_done, otherwise host->cmd and host->data_cmd
> -                * would both be null.
> -                */
> -               if (host->cmd || host->data_cmd) {
> -                       spin_unlock_irqrestore(&host->lock, flags);
> -                       return true;
> -               }
> -
> -               /* Some controllers need this kick or reset won't work here */
> -               if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
> -                       /* This is to force an update */
> -                       host->ops->set_clock(host, host->clock);
> -
> -               /* Spec says we should do both at the same time, but Ricoh
> -                  controllers do not like that. */
> -               sdhci_do_reset(host, SDHCI_RESET_CMD);
> -               sdhci_do_reset(host, SDHCI_RESET_DATA);
> -
> -               host->pending_reset = false;
> -       }
> -
>         host->mrqs_done[i] = NULL;
>
>         spin_unlock_irqrestore(&host->lock, flags);
> --
> 2.7.4
>
