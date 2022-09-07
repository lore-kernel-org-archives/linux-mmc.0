Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F9EECAAD3
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Sep 2022 10:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiIGKEb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Sep 2022 06:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiIGKEV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Sep 2022 06:04:21 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47740A1A0
        for <linux-mmc@vger.kernel.org>; Wed,  7 Sep 2022 03:04:15 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id w8so21571437lft.12
        for <linux-mmc@vger.kernel.org>; Wed, 07 Sep 2022 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=TAZqFTvXBXXH9w3af00aI8k1+qFPAPiLt1+jlcSSA3g=;
        b=bw0TKC6urZGW7lO5kynRiMmmFTnP6/XNFQWXeOs8WaJzTHkKoNeFa8MNoq+cmNq5Ts
         yxz7M9CrRKDQL4NxYQuRRGXuG7O8BBqjCdwY9yigUP52Ye6sDdv8dNTMl0ido6tP+pHO
         i1sO6fUoHcrHK6G1Ex9o8LAESq/1MTVKiLFzOcgsyYBGlhfZyWb4kivB/1tSlt991sCt
         JPdodzaXiV3p4X5riFpFU9sk7gaIuhucJEmrGyW/M+YYUAz6WVbfkwgzlaRWhr9jLJkm
         vxSdxQT5Fgu1tOwiLfXasxZWvKq2q12yzo6UXHVWHjRv9E+0KqmMZ/smYDpqI0/ePl1O
         T+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=TAZqFTvXBXXH9w3af00aI8k1+qFPAPiLt1+jlcSSA3g=;
        b=g+NIb68sgodE1cxeYKAmNN7pPKZuYKm/mL1uVpfE6MIw8l1KdgAlrB4fIbRWk6/PRM
         Z916ROFjMFA8AWHunbpYs7diWJ5vQdcdekL+6rTdaVkudTZOcPyvA1i0TCqjvKQkWGiM
         goMAc69LY8hAqrdMWfHcHY66nZJIDrzk+pc2Xudd1EM+CNsFxBROG3Fz2/lCzbIbT9A1
         aMlRTCfl196WuGpMiTMi39+22stZDb7Xaq1Vbt7ozfU8G6vqrncbJsq2/bhAAlqsjcq9
         LB82rENITBBMFES0niIXG0JrXXfq4FAIngMcwh14ZGtkxESbPXIRW2dnb2G4We5zsqjj
         viWw==
X-Gm-Message-State: ACgBeo3JZrS0Dnu6qfjS3E1YKAHHACUtI9CgX4GVNFWv9weL4N0mD1jO
        DKj87AE0eNrOwJjlGByU6UCftFcq2re1+IGrU7UJXw==
X-Google-Smtp-Source: AA6agR5v88esUA/qs466TA0gTV26tbFglAXViwnePq4L/UPYceYRxYn8QGB8+CK3LHDP2honzhgNrKyY8qbrSn9OI8Y=
X-Received: by 2002:a05:6512:2306:b0:48b:2905:21a8 with SMTP id
 o6-20020a056512230600b0048b290521a8mr972328lfu.167.1662545053356; Wed, 07 Sep
 2022 03:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220831124359.2005165-1-paulliu@debian.org> <20220831124359.2005165-2-paulliu@debian.org>
 <3648678c-3c42-2555-aa84-a21b1e7c661f@intel.com>
In-Reply-To: <3648678c-3c42-2555-aa84-a21b1e7c661f@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 7 Sep 2022 12:03:37 +0200
Message-ID: <CAPDyKFpmeAPFvLqA3wp8p_O4qQ_svrGPZquznSViiz+Sc3Y=mQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mmc: sdhci: check host->cmd is null or not in sdhci_cqe_irq()
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
        linux-mmc@vger.kernel.org, Ram Muthiah <rammuthiah@google.com>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Adrian,

On Wed, 7 Sept 2022 at 09:06, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 31/08/22 15:43, Ying-Chun Liu (PaulLiu) wrote:
> > From: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> >
> > If we don't check host->cmd. We will get the following oops
> > when booting from eMMC on RockPi4.
> >
> >  Unable to handle kernel read from unreadable memory at
> >    virtual address 0000000000000000
> >  Call trace:
> >    sdhci_cqe_irq+0x40/0x254
>
> Thank you!  However, I prefer this patch:
>
> https://lore.kernel.org/linux-mmc/20220907035847.13783-1-wenchao.chen666@gmail.com/

That patch means that we need to do a sdhci_readw() to figure out what
command we are running, rather than just checking for a valid pointer.
Maybe it's not a big deal as this code isn't executed that often?

Anyway, it's your call to make, I pick the patch that you prefer.

Kind regards
Uffe

>
> >
> > Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> > Signed-off-by: Ram Muthiah <rammuthiah@google.com>
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Ritesh Harjani <riteshh@codeaurora.org>
> > Cc: Asutosh Das <asutoshd@codeaurora.org>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: linux-mmc@vger.kernel.org
> > ---
> >  drivers/mmc/host/sdhci.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 7689ffec5ad1..e0e7768bd6c0 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3928,7 +3928,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
> >
> >       if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC)) {
> >               *cmd_error = -EILSEQ;
> > -             if (!mmc_op_tuning(host->cmd->opcode))
> > +             if (host->cmd && !mmc_op_tuning(host->cmd->opcode))
> >                       sdhci_err_stats_inc(host, CMD_CRC);
> >       } else if (intmask & SDHCI_INT_TIMEOUT) {
> >               *cmd_error = -ETIMEDOUT;
> > @@ -3938,7 +3938,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
> >
> >       if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
> >               *data_error = -EILSEQ;
> > -             if (!mmc_op_tuning(host->cmd->opcode))
> > +             if (host->cmd && !mmc_op_tuning(host->cmd->opcode))
> >                       sdhci_err_stats_inc(host, DAT_CRC);
> >       } else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
> >               *data_error = -ETIMEDOUT;
>
