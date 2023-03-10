Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A9FC6FA99
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Mar 2023 15:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjCJP1D (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 10 Mar 2023 10:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233287AbjCJP0n (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Mar 2023 10:26:43 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E00149D31
        for <linux-mmc@vger.kernel.org>; Fri, 10 Mar 2023 07:15:47 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id 6-20020a17090a190600b00237c5b6ecd7so10122582pjg.4
        for <linux-mmc@vger.kernel.org>; Fri, 10 Mar 2023 07:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678461312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xwihrqotRj+gq9lrHr6aSSaghXD8WiZvOwlvCQBnmno=;
        b=mgcM3iMtk8E0NkK3FxpiFFp+SK5A8xXuINcsHbt+81Kg4UKp0TLJTEPIzByK5lttB8
         4wVSRVxuvxgXVl9Loj8tyBGn8SK54iJlwopBXJheYgPnYSaAL4318V9DALRwE8QQrkiW
         6mHjYvnqUu1UP6JviJ2kMf3LnY67vBubC/TUUWOfMHwG2EWotbqjKqqb5AVdM7QPe+qH
         MmkkFFvtXICf1gVA9rv7A5R6ZpEeoIuTfhdFFhqiRLQuQz7YNUha4xDYELTNsezuEdTI
         pBPR2GeOSF6KcVaTeLhO88mfcQy+U7mpYWYoadma0VGHnNcJxkZPmpRoDE/5W/NL/+oW
         6DHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678461312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwihrqotRj+gq9lrHr6aSSaghXD8WiZvOwlvCQBnmno=;
        b=NpfI2fi/xsDCL+L1zZzolkT5929ECkr23RFii7JPmj1xEAmIoLZCTGqlNoxwPD26zX
         k0xGbjrZXfwUWZWOQM4pdxLk5/bh47Z0N4hJPaNRWaFrbXWdYtkh3SK4gWs7KezeySSE
         myDNk1Xa0lYEzQ20whnIAp9Y4E5wA0zmdD61Eu0aBFwrj4YtjJROHBqi82gATVhc5AAO
         LJzcdgJ2lDZ6TPxlc2sKHZ8vOUocZBp9jjZNFQ6sCzKI5EKXWN9icphRuqFIHNK/KYMC
         03xSk1cSAzg6MmUMDFjZiSQyStMugv6pEBAZfXsHg/Pi/d0JJhmFT/RpuAjQqo0/ykV9
         K/Yw==
X-Gm-Message-State: AO0yUKUPfhXoDf5GxHjWWtq4f5d3EEBg3oXplZD1NWQrWQborE48gzzd
        8M9POvk1RKcfILclsCIKyBdDdT4HJxujoMtNKL7geg==
X-Google-Smtp-Source: AK7set//B9HM9w9phC8lBZz6SXmvtiEQ094wWHiy1QRaysIdmyJ8Ds1g6f/fBRiWRyqcd4mH1thulPoGqVvT6UoXVz8=
X-Received: by 2002:a17:902:680e:b0:19c:9fa5:b68a with SMTP id
 h14-20020a170902680e00b0019c9fa5b68amr10258666plk.11.1678461311726; Fri, 10
 Mar 2023 07:15:11 -0800 (PST)
MIME-Version: 1.0
References: <20230223120450.16858-1-fredaibayhubtech@126.com>
In-Reply-To: <20230223120450.16858-1-fredaibayhubtech@126.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 10 Mar 2023 16:14:35 +0100
Message-ID: <CAPDyKFoUNyBrN2BRfOsc+vq45+s4cmgrM6TcZ5KvEYZ7r63GRQ@mail.gmail.com>
Subject: Re: [PATCH V1 1/1] mmc:sdhci-pci-o2micro: Fix SDR50 mode timing issue
To:     fredaibayhubtech@126.com
Cc:     adrian_hunter@intel.com, linux-mmc@vger.kernel.org,
        linux.kernel@vger.kernel.org, shaper.liu@bayhubtech.com,
        chevron.li@bayhubtech.com, xiaoguang.yu@bayhubtech.com,
        shirley.her@bayhubtech.com, fred.ai@bayhubtech.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 23 Feb 2023 at 13:05, <fredaibayhubtech@126.com> wrote:
>
> From: Fred <fred.ai@bayhubtech.com>
>
> Change SDR50 mode clock source from DLL output clock to PLL open clock
> 1.HS200 and SDR104 mode select DLL output clock
> 2.SDR50 mode select PLL open clock
>
> Signed-off-by: Fred <fred.ai@bayhubtech.com>

Applied for next, thanks!

Perhaps I should move this to the fixes branch and we should add a
fixes and a stable tag too?

Kind regards
Uffe

> ---
> Change in V1
> SDR50 mode select PLL open clock as its clock source.
> ---
>  drivers/mmc/host/sdhci-pci-o2micro.c | 30 +++++++++++++++-------------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
> index 98cadff47b2b..620f52ad9667 100644
> --- a/drivers/mmc/host/sdhci-pci-o2micro.c
> +++ b/drivers/mmc/host/sdhci-pci-o2micro.c
> @@ -339,22 +339,24 @@ static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode)
>         reg_val &= ~SDHCI_CLOCK_CARD_EN;
>         sdhci_writew(host, reg_val, SDHCI_CLOCK_CONTROL);
>
> -       /* UnLock WP */
> -       pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> -       scratch_8 &= 0x7f;
> -       pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> -
> -       /* Set pcr 0x354[16] to choose dll clock, and set the default phase */
> -       pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
> -       reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
> -       reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
> -       pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
> +       if ((host->timing == MMC_TIMING_MMC_HS200) ||
> +               (host->timing == MMC_TIMING_UHS_SDR104)) {
> +               /* UnLock WP */
> +               pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +               scratch_8 &= 0x7f;
> +               pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
>
> -       /* Lock WP */
> -       pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> -       scratch_8 |= 0x80;
> -       pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +               /* Set pcr 0x354[16] to choose dll clock, and set the default phase */
> +               pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &reg_val);
> +               reg_val &= ~(O2_SD_SEL_DLL | O2_SD_PHASE_MASK);
> +               reg_val |= (O2_SD_SEL_DLL | O2_SD_FIX_PHASE);
> +               pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, reg_val);
>
> +               /* Lock WP */
> +               pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
> +               scratch_8 |= 0x80;
> +               pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
> +       }
>         /* Start clk */
>         reg_val = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
>         reg_val |= SDHCI_CLOCK_CARD_EN;
> --
> 2.37.2
>
