Return-Path: <SRS0=ssCU=6L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6BAC54FD0
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 20:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF212074F
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 20:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrVJHLVx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgD0UN3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726850AbgD0UMx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Apr 2020 16:12:53 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208BFC0610D5;
        Mon, 27 Apr 2020 13:12:52 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u127so341685wmg.1;
        Mon, 27 Apr 2020 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x1zonVb/BbRigHqP69T8VBwuU0bduWhkzmHUC7793dM=;
        b=SrVJHLVxg21IVO23W2AGolBEV2fVOJXFbod/kjJ1H1wEPl5pEpJr/F/wRuYBSvaPWY
         ebs82S2n+w7pEciImNGMDyjj8WMYy0aFXxC2/h9xMrFKDeDFD7y1GUgA+J7T65aZFtjk
         xs+8LWL+QAjxaLOkJg9LLwL9VMN9sHcKKDqheNk8/Uv65WB4ddP3F8IGqQKJlx6szR0X
         13rb5/Jl77mFcKUcs1VlFO8s+TDBcBnOUf+nvG3h0PwECAejKS6TUcY7YcuNV1S+a10p
         JQO1hN/3SQkDv+hdIAHZMpeywFRqxk9wNr4gbu9Nh2EoW21Qa1Ef2IMIpI9ioWIklA9s
         Nhlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x1zonVb/BbRigHqP69T8VBwuU0bduWhkzmHUC7793dM=;
        b=fLtling7ZjvO2p88wh2xhe2x628x3B2NonXUWZPEAWsYjDVrfzdJmxtOBFzzHxUxBe
         QVfJewwkUFOxVqWbo+tW7KS6EJGgIciOPD3JevWTTMsp1GkjHDZBT/dgpFdI9vRSqaXE
         9P2oBH5sy4aUrW2cp8fHYuJJ0B2++qWciFkfPVL6BZwL6TxppWhnXBXKQKWNDFfsLfrw
         9vimFMiiGtOqBLkG9pI5BSFKB2W6HpWoeXBmgHNatzo8Z/namT3/QCT8N9VzvGD8hk3d
         PUGHD/vYwDR4UnE+Pzeyuj/6BHP2tWivH+S4Z35iv817TKtGgOmWKWt460P3IuX2aKF0
         8lSg==
X-Gm-Message-State: AGi0PubVWnzbKPW2/56X23+atzO6ZylaKvMcJuFmSRJs82v7nscomvYP
        MSlCbH187Tbwdx3rpxMP1I70V7GxZMKGzN/0oBI=
X-Google-Smtp-Source: APiQypLiCFtjL1zFB7OdQgYbc9SVeTlF4OAYPBx3Gc5cNaKO/YffjNVwodyP+eWjvYbcJf5NrAaZUOvwpX6rrjojCTU=
X-Received: by 2002:a7b:c74d:: with SMTP id w13mr436755wmk.36.1588018370739;
 Mon, 27 Apr 2020 13:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200427103048.20785-1-benchuanggli@gmail.com>
In-Reply-To: <20200427103048.20785-1-benchuanggli@gmail.com>
From:   Vineeth Pillai <vineethrp@gmail.com>
Date:   Mon, 27 Apr 2020 16:12:39 -0400
Message-ID: <CAOBnfPi+ztJ7vtgQ9qcHhGKDB8QKW3F=_9MR2roQOBLfrtqbDg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Fix no irq handler from suspend
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmVuQ2h1YW5nW+iOiuaZuumHj10=?= 
        <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?UmVuaXVzQ2hlblvpmbPlu7rlro9d?= 
        <Renius.Chen@genesyslogic.com.tw>, dflogeras2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Tested-by: Vineeth Pillai <vineethrp@gmail.com>

Thanks,
Vineeth

On Mon, Apr 27, 2020 at 6:30 AM Ben Chuang <benchuanggli@gmail.com> wrote:
>
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>
> The kernel prints a message similar to
> "[   28.881959] do_IRQ: 5.36 No irq handler for vector"
> when GL975x resumes from suspend. Implement a resume callback to fix this.
>
> Fixes: 31e43f31890c ("mmc: sdhci-pci-gli: Enable MSI interrupt for GL975x")
> Co-developed-by: Renius Chen <renius.chen@genesyslogic.com.tw>
> Signed-off-by: Renius Chen <renius.chen@genesyslogic.com.tw>
> Tested-by: Dave Flogeras <dflogeras2@gmail.com>
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index ce15a05f23d4..7195dd33ac3d 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -334,6 +334,18 @@ static u32 sdhci_gl9750_readl(struct sdhci_host *host, int reg)
>         return value;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +int sdhci_pci_gli_resume(struct sdhci_pci_chip *chip)
> +{
> +       struct sdhci_pci_slot *slot = chip->slots[0];
> +
> +       pci_free_irq_vectors(slot->chip->pdev);
> +       gli_pcie_enable_msi(slot);
> +
> +       return sdhci_pci_resume_host(chip);
> +}
> +#endif
> +
>  static const struct sdhci_ops sdhci_gl9755_ops = {
>         .set_clock              = sdhci_set_clock,
>         .enable_dma             = sdhci_pci_enable_dma,
> @@ -348,6 +360,9 @@ const struct sdhci_pci_fixes sdhci_gl9755 = {
>         .quirks2        = SDHCI_QUIRK2_BROKEN_DDR50,
>         .probe_slot     = gli_probe_slot_gl9755,
>         .ops            = &sdhci_gl9755_ops,
> +#ifdef CONFIG_PM_SLEEP
> +       .resume         = sdhci_pci_gli_resume,
> +#endif
>  };
>
>  static const struct sdhci_ops sdhci_gl9750_ops = {
> @@ -366,4 +381,7 @@ const struct sdhci_pci_fixes sdhci_gl9750 = {
>         .quirks2        = SDHCI_QUIRK2_BROKEN_DDR50,
>         .probe_slot     = gli_probe_slot_gl9750,
>         .ops            = &sdhci_gl9750_ops,
> +#ifdef CONFIG_PM_SLEEP
> +       .resume         = sdhci_pci_gli_resume,
> +#endif
>  };
> --
> 2.26.2
>


-- 
Cheers,
~Vineeth

## "Its not the load that breaks you, but the way u carry it!" ##
