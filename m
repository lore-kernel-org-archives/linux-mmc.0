Return-Path: <SRS0=NquR=6B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B1FC38A29
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 11:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E17207FC
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 11:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jOmKcedf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbgDQL3u (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730324AbgDQL3s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Apr 2020 07:29:48 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45038C061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 04:29:48 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id v24so529483uak.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 04:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5nFVKkWZ5xyTitKrY5QjzGiXnsITN8r7PQrHLIEfcA=;
        b=jOmKcedfTITffCC9PTZIlMwhUW2bq5rlZdsTywtn/5ARqsk8RlDzGENJY8vfR52lRc
         Htzdps7pBeAB1fi4oz7s1xNDrBibOaOa64ubhLfxKk7EcPtZvOEDNdsNd6mySn3mcyBl
         Pi3u4TP+g19fRpi1Gr50O+2GuRXwron3S91NmYvdE9CJxzSWYD+FZcVV7QNmXW1H2YSD
         0xLFxkNufYDhFhxDDGwPkdOeAxGmN9oB3YpcsR2d1eVJCRXj39qm64hyT9dglMW8eiW3
         u8IoUIxkB0Xz81rGHIn09LVQJYW1awpS7A8Q5nG25u0g5fgtl+cigQRy/tJsS28gqJD3
         uY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5nFVKkWZ5xyTitKrY5QjzGiXnsITN8r7PQrHLIEfcA=;
        b=J/5qMNBedl6yIc3w6Ad2FjbRkbOnRE6HAqewY1Bvq0FdjNZEg7z63YUQd8Q7k33niw
         LV2pXszn3SN2AFv6TliLdXHKkbX5B3Fm8buQxAT6OBTU2hmFColPRs7/OO/pJMgnuUSR
         eNBGdUe3MW0wGJulAotwsQsz/nSfYTOAkclvpNcIAOd1cO0hFvm1QvnbyX7V3O79pf8y
         hDENFhszNWEG0ksVtAR14nWJ86FYxf545lWpfXpbEFicSIo5W00snfw94Yh+4JI9obLO
         nzclCkHS2YZGHpjvTPNbyTUZg+t1gquCOv0gtVPHemTsT1Ff/Z9wsoQpknDvENZDo29Q
         WQcg==
X-Gm-Message-State: AGi0PuaQBeKr3YidHSZQ2xWpsKcw1CHS8BhUW6bQcFTMihEaeb9188nI
        R22NqeiN6J/ctCbfAEI9gag5AKN9g3XbG7HLpexGag==
X-Google-Smtp-Source: APiQypIuhM3HBNXcvjyF/50pP+nD+6Cyse/reE4BBoOzfxTzz115Xj5qnR66MczhnuQ7UckQdy1ZlEma+1OtP5iraJA=
X-Received: by 2002:ab0:6449:: with SMTP id j9mr1959667uap.19.1587122987396;
 Fri, 17 Apr 2020 04:29:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200412090349.1607-1-adrian.hunter@intel.com>
In-Reply-To: <20200412090349.1607-1-adrian.hunter@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Apr 2020 13:29:11 +0200
Message-ID: <CAPDyKFqKk0uNUQm8SA3ETDXK60ssmcsDsZ0veHGnArWSw5E5Ow@mail.gmail.com>
Subject: Re: [PATCH 0/5] mmc: sdhci: Reduce maximum time under spinlock in sdhci_send_command()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 12 Apr 2020 at 11:04, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> Hi
>
> Here are some patches to reduce maximum time under spinlock in
> sdhci_send_command(), but also pave the way for an atomic request
> function.
>
> I haven't tried it, but with these patches, something like below
> should work.
>
>
>
> static int sdhci_atomic_request(struct mmc_host *mmc,
>                                 struct mmc_request *mrq)
> {
>         struct sdhci_host *host = mmc_priv(mmc);
>         struct mmc_command *cmd;
>         unsigned long flags;
>         int ret = 0;
>
>         spin_lock_irqsave(&host->lock, flags);
>
>         if (sdhci_present_error(host, mrq->cmd, true))
>                 goto out_finish;
>
>         cmd = sdhci_manual_cmd23(host, mrq) ? mrq->sbc : mrq->cmd;
>
>         if (sdhci_send_command(host, cmd))
>                 sdhci_led_activate(host);
>         else
>                 ret = -EBUSY;
>
>         spin_unlock_irqrestore(&host->lock, flags);
>
>         return ret;
>
> out_finish:
>         sdhci_finish_mrq(host, mrq);
>         spin_unlock_irqrestore(&host->lock, flags);
>         return 0;
> }
>
>
>
> Adrian Hunter (5):
>       mmc: sdhci: Add helpers for the auto-CMD23 flag
>       mmc: sdhci: Stop exporting sdhci_send_command()
>       mmc: sdhci: Remove unneeded forward declaration of sdhci_finish_data()
>       mmc: sdhci: Tidy sdhci_request() a bit
>       mmc: sdhci: Reduce maximum time under spinlock in sdhci_send_command()
>
>  drivers/mmc/host/sdhci.c | 182 +++++++++++++++++++++++++++++++++++------------
>  drivers/mmc/host/sdhci.h |   2 +-
>  2 files changed, 139 insertions(+), 45 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
