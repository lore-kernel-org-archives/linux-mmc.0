Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D85CC433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 18:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01EC464F64
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 18:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbhCDSKU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 13:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhCDSJ5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 13:09:57 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C2FC061756
        for <linux-mmc@vger.kernel.org>; Thu,  4 Mar 2021 10:09:17 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id l27so7573246vsj.4
        for <linux-mmc@vger.kernel.org>; Thu, 04 Mar 2021 10:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wm+y856/FEFQ1e35KnxFw2YAIiTFgOMKJrDML+IDxE=;
        b=Di0tAVlQ3YEt8EKPx7Hgz0fG1B3NVCfjPp4ZvTH2wlFQC2s8ry+u2bOdn5Vdm3Apov
         kEAjpYqM5S8agUmR1KrTEauU+sLsPgTN3dgp84qz8xHeKH8aJAyT0LEaUe2Ig3VwBB/A
         tfWeEPsGf5B2lFmnrZzhcInieZszJweqAZCt8jHSYl01dFbF0v1uBeY2UIcvhUgDoAcA
         UgJF94/hzwVHSDeT8lw5iU4DGPCgQ/ydJpdADjG+lHCmBRIoNV8YpLjdz/5+W+IpPkqR
         xyAVmihHVikQr27YiCEXryuM9mbG9Ei4iaMD6yK3FvIBmwbc4wGYQl8YCaEyMKgnSnpu
         b4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wm+y856/FEFQ1e35KnxFw2YAIiTFgOMKJrDML+IDxE=;
        b=OtqRJ0QyfZMm9UP7fpLfIsk3P0XBjyX45qHykW69cdLfEycJ1FkXJHRoQMtC2ThYkt
         9c7b3YQUZcSxmXsonp6ShOdPWRjfrtuadlrEYxTQzk9WilK0ImELKA5+ytwx/MPRGsfZ
         hSh3TBNH7k1Aj++nRNM4Ioexip2CeGHlfDFPb/8GUzs9De1HYfWpbCUN1cCBVLiGecXQ
         Y/K+f2WfqwMJfHLBoKtlMRaFMeSlP9+Sn+AwPBy1lCwh5OvhdL0nQpwkqL9lUnRK4xZk
         h7XfDD0c6vSeyXq2Jh94cEMuxTlnRAWxhesXjh5By9C3j9DrNgqbeo1NsO6BRZ4RE0he
         1/Bg==
X-Gm-Message-State: AOAM533LxFOlldb1Oc+MbWh0M50oWos4ANO8JEK3rwuM+9fN0aLeRpku
        vCyTzDNlRZVU7lzCxALkMk7dTuZBTxmKVRE3NAabGw==
X-Google-Smtp-Source: ABdhPJyWGWmkBQ2Jx35VWGQm63T9M353cU7X+gHZzwBZ1z3mxrW+bkrVPrdQM4lbq0CH29K67mcKZZsSRElyafGrRxk=
X-Received: by 2002:a67:c787:: with SMTP id t7mr3952276vsk.48.1614881356015;
 Thu, 04 Mar 2021 10:09:16 -0800 (PST)
MIME-Version: 1.0
References: <1614760331-43499-1-git-send-email-pragalla@qti.qualcomm.com>
 <CAPDyKFqFNr7AiOdVP07XS=CKpMbDKC7n0gMPu0516fgH3=S18Q@mail.gmail.com> <3962320b58beaa4626ed69b3120d4246@codeaurora.org>
In-Reply-To: <3962320b58beaa4626ed69b3120d4246@codeaurora.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 4 Mar 2021 19:08:39 +0100
Message-ID: <CAPDyKFrTHiZyVAsP5TR5evOdbSi4dS_c+k5u6rdA4UwhAc6YuA@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: sdhci: Check for reset prior to DMA address unmap
To:     Pradeep P V K <pragalla@codeaurora.org>
Cc:     Pradeep P V K <pragalla@qti.qualcomm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Ram Prakash Gupta <rampraka@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 4 Mar 2021 at 16:16, <pragalla@codeaurora.org> wrote:
>
> On 2021-03-04 19:19, Ulf Hansson wrote:
> > On Wed, 3 Mar 2021 at 09:32, Pradeep P V K <pragalla@qti.qualcomm.com>
> > wrote:
> >>
> >> From: Pradeep P V K <pragalla@codeaurora.org>
> >>
> >> For data read commands, SDHC may initiate data transfers even before
> >> it
> >> completely process the command response. In case command itself fails,
> >> driver un-maps the memory associated with data transfer but this
> >> memory
> >> can still be accessed by SDHC for the already initiated data transfer.
> >> This scenario can lead to un-mapped memory access error.
> >>
> >> To avoid this scenario, reset SDHC (when command fails) prior to
> >> un-mapping memory. Resetting SDHC ensures that all in-flight data
> >> transfers are either aborted or completed. So we don't run into this
> >> scenario.
> >>
> >> Swap the reset, un-map steps sequence in sdhci_request_done().
> >>
> >> Changes since V1:
> >> - Added an empty line and fixed the comment style.
> >> - Retained the Acked-by signoff.
> >>
> >> Suggested-by: Veerabhadrarao Badiganti <vbadigan@codeaurora.org>
> >> Signed-off-by: Pradeep P V K <pragalla@codeaurora.org>
> >> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> Hi Uffe,
> >
> > Seems like it might be a good idea to tag this for stable? I did that,
> > but awaiting for your confirmation.
> >
> Yes, this fix is applicable for all stable starting from 4.9 (n/a for
> 4.4).
> Kindly go ahead.
>
> > So, applied for next, thanks!
> >
> > Kind regards
> > Uffe
> >
> Thanks and Regards,
> Pradeep

Thanks for confirming, I have updated the stable tag.

Kind regards
Uffe

>
> >
> >> ---
> >>  drivers/mmc/host/sdhci.c | 60
> >> +++++++++++++++++++++++++-----------------------
> >>  1 file changed, 31 insertions(+), 29 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >> index 646823d..130fd2d 100644
> >> --- a/drivers/mmc/host/sdhci.c
> >> +++ b/drivers/mmc/host/sdhci.c
> >> @@ -2998,6 +2998,37 @@ static bool sdhci_request_done(struct
> >> sdhci_host *host)
> >>         }
> >>
> >>         /*
> >> +        * The controller needs a reset of internal state machines
> >> +        * upon error conditions.
> >> +        */
> >> +       if (sdhci_needs_reset(host, mrq)) {
> >> +               /*
> >> +                * Do not finish until command and data lines are
> >> available for
> >> +                * reset. Note there can only be one other mrq, so it
> >> cannot
> >> +                * also be in mrqs_done, otherwise host->cmd and
> >> host->data_cmd
> >> +                * would both be null.
> >> +                */
> >> +               if (host->cmd || host->data_cmd) {
> >> +                       spin_unlock_irqrestore(&host->lock, flags);
> >> +                       return true;
> >> +               }
> >> +
> >> +               /* Some controllers need this kick or reset won't work
> >> here */
> >> +               if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
> >> +                       /* This is to force an update */
> >> +                       host->ops->set_clock(host, host->clock);
> >> +
> >> +               /*
> >> +                * Spec says we should do both at the same time, but
> >> Ricoh
> >> +                * controllers do not like that.
> >> +                */
> >> +               sdhci_do_reset(host, SDHCI_RESET_CMD);
> >> +               sdhci_do_reset(host, SDHCI_RESET_DATA);
> >> +
> >> +               host->pending_reset = false;
> >> +       }
> >> +
> >> +       /*
> >>          * Always unmap the data buffers if they were mapped by
> >>          * sdhci_prepare_data() whenever we finish with a request.
> >>          * This avoids leaking DMA mappings on error.
> >> @@ -3060,35 +3091,6 @@ static bool sdhci_request_done(struct
> >> sdhci_host *host)
> >>                 }
> >>         }
> >>
> >> -       /*
> >> -        * The controller needs a reset of internal state machines
> >> -        * upon error conditions.
> >> -        */
> >> -       if (sdhci_needs_reset(host, mrq)) {
> >> -               /*
> >> -                * Do not finish until command and data lines are
> >> available for
> >> -                * reset. Note there can only be one other mrq, so it
> >> cannot
> >> -                * also be in mrqs_done, otherwise host->cmd and
> >> host->data_cmd
> >> -                * would both be null.
> >> -                */
> >> -               if (host->cmd || host->data_cmd) {
> >> -                       spin_unlock_irqrestore(&host->lock, flags);
> >> -                       return true;
> >> -               }
> >> -
> >> -               /* Some controllers need this kick or reset won't work
> >> here */
> >> -               if (host->quirks & SDHCI_QUIRK_CLOCK_BEFORE_RESET)
> >> -                       /* This is to force an update */
> >> -                       host->ops->set_clock(host, host->clock);
> >> -
> >> -               /* Spec says we should do both at the same time, but
> >> Ricoh
> >> -                  controllers do not like that. */
> >> -               sdhci_do_reset(host, SDHCI_RESET_CMD);
> >> -               sdhci_do_reset(host, SDHCI_RESET_DATA);
> >> -
> >> -               host->pending_reset = false;
> >> -       }
> >> -
> >>         host->mrqs_done[i] = NULL;
> >>
> >>         spin_unlock_irqrestore(&host->lock, flags);
> >> --
> >> 2.7.4
> >>
