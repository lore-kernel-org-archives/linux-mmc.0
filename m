Return-Path: <SRS0=mOb4=6T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428ECC47247
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 11:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220B2206A5
	for <linux-mmc@archiver.kernel.org>; Tue,  5 May 2020 11:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwQiB1gV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgEELd0 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 5 May 2020 07:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727090AbgEELd0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2020 07:33:26 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291FFC061A10
        for <linux-mmc@vger.kernel.org>; Tue,  5 May 2020 04:33:26 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 1so997888vsl.9
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2020 04:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aW3lDGiADWs7JW9cxGTC8AY/7i0BQSigJub/cuiuwnI=;
        b=gwQiB1gVTJOghuOSOjL5cVHiwLy0rFkim78R7G2TC6F+hsHSwnidTIKVzx5klHJ7YG
         SIRFog74RlxFwXxnapCTCiNXZ4ohqiDY8CEOcnTliPMuDXg1n+BRFTVaJoGAWu3k30rq
         4mTAmNf7HdW16nfyEwSTy/j+IEKOz/Z5EdgS9LOz9Q7/aIF4OXi/zXryZFQTXnS5kNzB
         ttSuzVw2u3gm9ZQA4oE3o0oMx7tLrYRkDdJid37BJ+dugHdK17yzBPzDO6RZTdThjCT1
         uZ74y5/ZJQ2vlXfetxdiqjHX3KHYW3meAgxWIcCB/2GGn3pnV6qhknYnPJNq1+qXR/CO
         5CmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aW3lDGiADWs7JW9cxGTC8AY/7i0BQSigJub/cuiuwnI=;
        b=fVjAZv8/lx6//12L1NeSQ+CoJ7pu872aeun8JB+vfZlW3lT7aZCT5LmBBg1kYCWfTl
         5GxmC5icN60WtgBlEsuX2fr9AuhCkzAiaQHX2gjNS/LX+yQ9rg1r4NYWHzRxH8GEzOU9
         bYvXxUpqF03txWaZn0yGtP8aH7jbtqAMCQoeUDm7CA69ZzDp0igRLjxkTAv72O8G8EWz
         lO4QBm5rlfYuIwQFjVUYoT9dJr6ORQe8+OXjvroOJ0CaFOASPE96nvbUAJJzvpMJ967b
         Mt3iN0nGjN15Yeu8CLJ4ldby1LP8wlY9oUOPhTwQaGU7axkh62eDaMOwhzsh1YUqYV6B
         jrew==
X-Gm-Message-State: AGi0PubpnzCzPA2lm+yGFWuX6VN1sArUsSOSyTw8umCk8dPHuCNEwetQ
        Zn5DELSzEyrl/WiSq3mYUoXpeff73gWxVTDIE5qS+Q==
X-Google-Smtp-Source: APiQypKN2KubwVNFLqBgumhtfc3ZFGWJnjyO+xL/wte15DAf1paIFz3MQ1edPKMchbyijD0ksiL4NAl5DlghKwTlndw=
X-Received: by 2002:a67:ead1:: with SMTP id s17mr2269661vso.200.1588678405301;
 Tue, 05 May 2020 04:33:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200427103048.20785-1-benchuanggli@gmail.com>
In-Reply-To: <20200427103048.20785-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 May 2020 13:32:49 +0200
Message-ID: <CAPDyKFqm5oJaKUNpvcWQ=eY+B=bF54TfcS9cLv55e4M2qGULvw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Fix no irq handler from suspend
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Renius.Chen@genesyslogic.com.tw, vineethrp@gmail.com,
        dflogeras2@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 27 Apr 2020 at 12:30, Ben Chuang <benchuanggli@gmail.com> wrote:
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

Applied for fixes, thanks!

Kind regards
Uffe


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
