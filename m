Return-Path: <SRS0=9sJp=55=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F48C2BB55
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 02:46:15 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60A2206C3
	for <linux-mmc@archiver.kernel.org>; Mon, 13 Apr 2020 02:46:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bm6weko7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D60A2206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mmc-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgDMCqN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 12 Apr 2020 22:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:43308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728248AbgDMCqN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 12 Apr 2020 22:46:13 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3457AC0086D3
        for <linux-mmc@vger.kernel.org>; Sun, 12 Apr 2020 19:46:13 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id r7so7342123ljg.13
        for <linux-mmc@vger.kernel.org>; Sun, 12 Apr 2020 19:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bk2WSS+yc+Q0bUQahGMfk+TqjHcCnBEICuCR5gRzWxE=;
        b=Bm6weko7YL+KOLu2gRKXWW9NNBwg93OQobWj4P6YPqsK4wuRHjlS+NIfKDIfyj38T6
         9974C38q/pPVlSj0/IZWvP+qUkBA+Wy1tPL0gt8eTk7PjolqL7qtHGRmstnzU+f3/Hkp
         m41TwoKRiO0t189tWtXlA+A6xe+FQeOg8RpM5CosPai/wuqRlQBSM8x4pA59NogIP0PG
         kDcHW0+Xf7wC41FroWO3+ZQ8g9vLNGkVh/w5n5DKyjPMN2fEi+3aYvSNEb28inZ4MC/m
         OnEjkLFU9eFQZkEh9ziK/MihM/KIxoi8Or99NKBUSMsCCwZc60nhveOzA9N8CFXkyd4T
         6fpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bk2WSS+yc+Q0bUQahGMfk+TqjHcCnBEICuCR5gRzWxE=;
        b=HJkFNDA8jAO9M4cWk3vY1M20AQUB3XZ7h4oTuDS5aUXIfNn3Ynmvao9tUq3K+H7me7
         NQ9S9horJR+kVVpoMFChoK95jJm+72n1oeeago0s9abdGIWr7OltQzrmhL5IPsc+vuXT
         CokiE5YDzJeO9ccFMiV8XqAeDhwskOFAPIexpg4KlzZxAvMEHyS9rUGs5scC3iTiAC7/
         dxdnS9+SrtyT076sQSHGDa4WVQZLIwv78+1bAlsV3xQGuYt3mzFJMbavOMc61TrK1ZvY
         GY2UhbhJjXW2ueuBPxNfDkfgUbdn/T4pzRiyTGxIvT1kN14QIpLO3yuj9wd9GPT2JbLq
         1oig==
X-Gm-Message-State: AGi0PuYnonJ0zaBaf1IsokmQCQ7sT4heAqcMSvJWDL/ZI+FT44eZJJAh
        ufafdk6T7zyyiifhGIx+n334dGJzxD779l5pVUw=
X-Google-Smtp-Source: APiQypKYpdy+mKv7NJ7HIWix9DPtSGm1Svi/AZZRL5uWK7CBWDT+Gp8HUBIskBAg4+Tidru1+GimGfnxhjkgQM66HRs=
X-Received: by 2002:a2e:5746:: with SMTP id r6mr1372071ljd.15.1586745971732;
 Sun, 12 Apr 2020 19:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200412090349.1607-1-adrian.hunter@intel.com>
In-Reply-To: <20200412090349.1607-1-adrian.hunter@intel.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 13 Apr 2020 10:46:00 +0800
Message-ID: <CADBw62qNwHHRQe+xPHOp8-gQp-5GK4X5FhVE85bsVUZ4GkRSRg@mail.gmail.com>
Subject: Re: [PATCH 0/5] mmc: sdhci: Reduce maximum time under spinlock in sdhci_send_command()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Sun, Apr 12, 2020 at 5:04 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
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

Yes, this looks good to me, and I've tested on my platform with
re-implementing sdhci_request_atomic() based on your patch set, it
worked well. Thanks for your help.
Tested-by: Baolin Wang <baolin.wang7@gmail.com>

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
>
>
> Regards
> Adrian



-- 
Baolin Wang
