Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4FF6C7EE2E
	for <linux-mmc@archiver.kernel.org>; Tue, 13 Jun 2023 12:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbjFMMI6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 13 Jun 2023 08:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjFMMI5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 13 Jun 2023 08:08:57 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A01E56
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 05:08:56 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bc5566538fdso3348234276.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Jun 2023 05:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686658135; x=1689250135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4U/SDkRXm6JkONHl+aWXETJibApGBtdkGiq/SpX1/d4=;
        b=D/abDtSqFY96ns73/ovymsUDWZPjiAAI+3v9BMsjwFMwvTm5t5GuGyOpMONucXZNLn
         30ATL75uvZYUTOPsxw945GCHBH91blhSZBwtsUUWFeDwccndQfXz7OGNQHW/mIGbTo1V
         JW4PcaBbxlGKMxzzx/d2gthJzJkDMJRBuPocqAFMvVk6PMqdRIrEwk1ge3C9VIRNVRfv
         ridd60LoMcAjmA5CJPK1NIsJlIZcW0eV9x2u2U9o2WdQny255DhM645FYCuap2NgkAkp
         t9pzDdzQsvsbrs7ol2I28nenyedWo9+KRBfzpb1gU4eTL+VDJde4phmp7+5f9H6r3QWC
         CtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686658135; x=1689250135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4U/SDkRXm6JkONHl+aWXETJibApGBtdkGiq/SpX1/d4=;
        b=l1QU+xE/hyqrwBqsi1anofd2LMnPBmNGlwP339k4BDkkhOv3LbKW4ulzt5XoPlijqv
         crCNIzNeqWhpDum21FT+lLaysuyrcIxb1kHP/rxhiWdbO6jrCz8tABBjmgVGbIeQMTLi
         P12yT4nT7B8uyP65baMhGndq3FDpGBB1sxsU7FVt5cW5jgGAAwwoAxtzDKED+y6ovXsI
         DQnO7ysWiQF5tvK2m38DGPiBkN6g6qCEPabmlR8jLJh7zSJBShBEqNMy/KoSHcgNER9O
         CSGuZHrQaIJiu2AnM45E/yTEwBrEVEFh1p9G+tncQMBj3oEJolSLHOTP5mrdEmaTyd6b
         B80A==
X-Gm-Message-State: AC+VfDxLDSx8TtB5DMC3R7ggaKr7ES1UXWi9TYTcXiH+xLbyLiAhVSGY
        ozAEhcZ+outG0Kwgfb9wt457PGI1HTpQxZyN8AMdmQ==
X-Google-Smtp-Source: ACHHUZ6WVoLDVEDK0BpXNpOAwZ5+NTR7G+XMiR4IQvyhiJB1aFu88filt1KWfDheICbk25Cb9d/sTd4vmbFww6ispAk=
X-Received: by 2002:a25:df83:0:b0:bc6:7dea:d08c with SMTP id
 w125-20020a25df83000000b00bc67dead08cmr1586473ybg.34.1686658135322; Tue, 13
 Jun 2023 05:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230405-pl180-busydetect-fix-v3-0-cd3d5925ae64@linaro.org> <20230405-pl180-busydetect-fix-v3-6-cd3d5925ae64@linaro.org>
In-Reply-To: <20230405-pl180-busydetect-fix-v3-6-cd3d5925ae64@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 13 Jun 2023 14:08:19 +0200
Message-ID: <CAPDyKFph_wm1f6bXs7eETVG8OciS8FsjWpcfCj9_meE7HsrWcg@mail.gmail.com>
Subject: Re: [PATCH v3 06/10] mmc: mmci: Retry the busy start condition
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Yann Gautier <yann.gautier@foss.st.com>,
        Stefan Hansson <newbyte@disroot.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, 11 Jun 2023 at 21:41, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This makes the ux500 ->busy_complete() callback re-read
> the status register 10 times while waiting for the busy
> signal to assert in the status register.
>
> If this does not happen, we bail out regarding the
> command completed already, i.e. before we managed to
> start to check the busy status.
>
> There is a comment in the code about this, let's just
> implement it to be certain that we can catch this glitch
> if it happens.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v2->v3:
> - Rebased.
> ChangeLog v1->v2:
> - Move over the initial saving of host->busy_status from
>   an unrelated patch to this one: it is clear what we are
>   doing: we don't want to miss any transient
>   (MCI_CMDSENT | MCI_CMDRESPEND) in the status register.
> ---
>  drivers/mmc/host/mmci.c | 40 ++++++++++++++++++++++++++++------------
>  1 file changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index edc68fc7b642..2858d8d67129 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -664,6 +664,7 @@ static u32 ux500v2_get_dctrl_cfg(struct mmci_host *host)
>  static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>  {
>         void __iomem *base = host->base;
> +       int retries = 10;
>
>         if (status & err_msk) {
>                 /* Stop any ongoing busy detection if an error occurs */
> @@ -684,21 +685,36 @@ static bool ux500_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
>          * Note that, the card may need a couple of clock cycles before
>          * it starts signaling busy on DAT0, hence re-read the
>          * MMCISTATUS register here, to allow the busy bit to be set.
> -        * Potentially we may even need to poll the register for a
> -        * while, to allow it to be set, but tests indicates that it
> -        * isn't needed.
>          */
>         if (host->busy_state == MMCI_BUSY_DONE) {
> -               status = readl(base + MMCISTATUS);
> -               if (status & host->variant->busy_detect_flag) {
> -                       writel(readl(base + MMCIMASK0) |
> -                              host->variant->busy_detect_mask,
> -                              base + MMCIMASK0);
> -
> -                       host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
> -                       host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
> -                       return false;
> +               /*
> +                * Save the first status register read to be sure to catch
> +                * all bits that may be lost will retrying. If the command
> +                * is still busy this will result in assigning 0 to
> +                * host->busy_status, which is what it should be in IDLE.
> +                */
> +               host->busy_status = status & (MCI_CMDSENT | MCI_CMDRESPEND);
> +               while (retries) {
> +                       status = readl(base + MMCISTATUS);
> +                       if (status & host->variant->busy_detect_flag) {
> +                               writel(readl(base + MMCIMASK0) |
> +                                      host->variant->busy_detect_mask,
> +                                      base + MMCIMASK0);
> +
> +                               /* Keep accumulating status bits */
> +                               host->busy_status |= status & (MCI_CMDSENT | MCI_CMDRESPEND);

Looks like we should accumulate the status, no matter whether the
host->variant->busy_detect_flag is set?

Perhaps move this just before the if-clause above?

> +                               host->busy_state = MMCI_BUSY_WAITING_FOR_START_IRQ;
> +                               return false;
> +                       }
> +                       retries--;
>                 }
> +               dev_dbg(mmc_dev(host->mmc), "no busy signalling in time\n");
> +               writel(host->variant->busy_detect_mask, base + MMCICLEAR);
> +               writel(readl(base + MMCIMASK0) &
> +                      ~host->variant->busy_detect_mask, base + MMCIMASK0);
> +               host->busy_state = MMCI_BUSY_DONE;
> +               host->busy_status = 0;
> +               return true;
>         }
>

Kind regards
Uffe
