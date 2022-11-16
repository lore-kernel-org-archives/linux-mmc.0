Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92ECBC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 16 Nov 2022 15:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234426AbiKPPVk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 16 Nov 2022 10:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiKPPVd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 16 Nov 2022 10:21:33 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7271327B39
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 07:21:28 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id k5so16808692pjo.5
        for <linux-mmc@vger.kernel.org>; Wed, 16 Nov 2022 07:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8OvGtAqRoTQELMczmQoHKstBKe+hWZtT69Hm+pj822g=;
        b=BkOM7+3oyrZLB50a7ooVuiZCyXmDm528HyGCCWA2DWwPN/y7hl6ST/jCgSP9DZYmqd
         AEhEe+Ze1hMpDERr1icN/DOsLk0VU4+amJJ7ugq9morEwfu3wNb9JeWcmjZtgurIe+rt
         U0hO2hfm3fiyiIRs0sxFBgSDA4tSTMReIFgI32kT9E9ftISGtGlM+PEj6h2hMquhGCl5
         fZrz895lM2BtV5fchkJPYy3N4VDooCegRy4i+d6k0i7WCKspRhF88r21NFSeqm/zn+qC
         nWP83HRHRBFqc+HxWDW6/PpCn4pR8mt/z525IisYtnmrFJHoZTi9xAX3GHEjgoky46kG
         r2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OvGtAqRoTQELMczmQoHKstBKe+hWZtT69Hm+pj822g=;
        b=I1XpDVA6oMR66v+U201644OcfF5K5HrGmCHW5zN6fCFeImcGbcHeUOwEj+g4YSlGaQ
         tfmPj6KUGTEiDEiV1ZBTYkCCF07ycc1jElTdl08LmteTH4UFMaSTma8KLddvcWBMuPdX
         o1Mk3CzqS7oKIxiu3OxCungw4bs4GIWLHIRIc8s/yKP1NQQSi+QyKn0c30+HCDArKFvl
         nE06N/rbw3ry4mPxwMRX0xoSC6QLzDyAyrotKf5ktl21cBYyBPerY7OTgUxC1pLTQzGu
         AITg8wk/d+WXV0VIypkD1H1OsPwmR99HFiaXHeK+xXsS08Oc75+Qa3S36XBOv2iBfOo9
         RiLQ==
X-Gm-Message-State: ANoB5pnTRoMgB9Gd3kf+JBO5kPeVAEUyvFOC7qnqGiisBUEp67L9KexJ
        x0HIJgFs/7p1yqMdPIWT8gaeC4VWgFtfwJlZZZmkeA==
X-Google-Smtp-Source: AA0mqf4GwQYIelvsRq8vdudWPLdb8BqPtPml7BZT0L2Yx3B0wfRoHUumYE8+2T9/CzGG9Y8x3hT5DosOf6BTcwrh6zM=
X-Received: by 2002:a17:90a:7804:b0:211:2d90:321 with SMTP id
 w4-20020a17090a780400b002112d900321mr4280330pjk.84.1668612088110; Wed, 16 Nov
 2022 07:21:28 -0800 (PST)
MIME-Version: 1.0
References: <20221111084214.14822-1-wenchao.chen666@gmail.com> <20221111084214.14822-2-wenchao.chen666@gmail.com>
In-Reply-To: <20221111084214.14822-2-wenchao.chen666@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 16 Nov 2022 16:20:51 +0100
Message-ID: <CAPDyKFqvbFLeVFHrd12Q1VdNy3TFmpRaNyuk4AJjNukPzNpT5w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: sdhci: Fixed too many logs being printed during tuning
To:     Wenchao Chen <wenchao.chen666@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, megoo.tang@gmail.com,
        lzx.stg@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 11 Nov 2022 at 09:42, Wenchao Chen <wenchao.chen666@gmail.com> wrote:
>
> From: Wenchao Chen <wenchao.chen@unisoc.com>
>
> During the HS200 tuning process, too many tuning errors are printed in
> the log.
>
> Signed-off-by: Wenchao Chen <wenchao.chen@unisoc.com>
> ---
>  drivers/mmc/host/sdhci.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index fef03de85b99..a503b54305eb 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -3401,6 +3401,10 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
>                 if (host->pending_reset)
>                         return;
>
> +               command = SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND));
> +               if (command == MMC_SEND_TUNING_BLOCK || command == MMC_SEND_TUNING_BLOCK_HS200)
> +                       return;
> +

Please use mmc_op_tuning() instead of open-coding this. I also need an
ack from Adrian to apply this.

>                 pr_err("%s: Got data interrupt 0x%08x even though no data operation was in progress.\n",
>                        mmc_hostname(host->mmc), (unsigned)intmask);
>                 sdhci_err_stats_inc(host, UNEXPECTED_IRQ);
> --
> 2.17.1
>

Kind regards
Uffe
