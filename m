Return-Path: <SRS0=RjyY=7H=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87512C433E0
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 08:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F51120812
	for <linux-mmc@archiver.kernel.org>; Mon, 25 May 2020 08:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UEZajuOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbgEYIsf (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 25 May 2020 04:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388342AbgEYIse (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 25 May 2020 04:48:34 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA1EC061A0E
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 01:48:33 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id i89so5870790uad.5
        for <linux-mmc@vger.kernel.org>; Mon, 25 May 2020 01:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z1iZmTq08CXdaMfQiicNdM4pu/lGlD+cWigl2vKnxAg=;
        b=UEZajuOJll8xfMuvd74p9IqlwIFqk5rB2Bhin7vk27+yV21aJxKHoWJZTHU9Iofp9H
         RzNQ1t4TVBwetAM8UqOihaOOjiiTDis6vPimzQylqDqVXYud0LzUwyGo4tZsxt6ragJ1
         QSSjWhEPDwfLz8xwT7Qgj+fUQxLi4QIqpBzUnE87hfcfs4SMv81ykZiDhHSYEDQQmNJu
         B5os9S5e6RhAiJvb+3xsvqD0nv6u01Xjg3rpvQqSnsy9E7/PQ8iGrKQM8zXjJt4pXwkF
         gKFu/k9iPlUBO+NJkdSXpik1wLX32DDAXNN4fZzGWRgDVQF4acrXlvYOJJBqjx6W74X8
         N0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z1iZmTq08CXdaMfQiicNdM4pu/lGlD+cWigl2vKnxAg=;
        b=fIpAeiMqQlJCvg/C1wvdR2ovruOJ3+Zt69BPUn2LrQC5eTZPqS8XwN1mTHb4Tenup/
         Pc/EpoqtNtHXSqOyiLE+jHq2fBk9t1xQBsuuvZ7dmBd+plHFxiLIGvnl4abmbgs3J0dx
         gc+OFWbkmj0lWPgoSVE+FKKoCAKlFxCdwXu0tcaZSpXUb901KHLnrzwQldaDUyIb8eLT
         eJpurRTr1F5r6YazaZ58OXNPc1RBWYTeD1dZ4Zey96apAZSGuKjKZR9GDrFFjeaIHPpB
         N5M3Qiq0Nq0cdQugLekbhtGsH3HTZjDY+TKoxs7gvM/EPr6NDFR9Iv+3gXlxcAuiiHrX
         DDaA==
X-Gm-Message-State: AOAM530fuej/jXG6088N5QMPq4ixaq/zTNE/5QFX9B1Z5Q22yDyhUxu8
        HyiEXMvtFt6KOS7qtG0AvcroXEG1JqVcke82i4FRdg==
X-Google-Smtp-Source: ABdhPJx1pvX/DBLf9FxgPl6K4pjG71rTG7ymUCRMviNrr1VaOEdeh4mgTW6t5WGR4J4+sooY3PJJ9nmZ0ButE/8kdb4=
X-Received: by 2002:ab0:70c9:: with SMTP id r9mr2965598ual.15.1590396512922;
 Mon, 25 May 2020 01:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200522031256.856-1-yangbo.lu@nxp.com>
In-Reply-To: <20200522031256.856-1-yangbo.lu@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 25 May 2020 10:47:55 +0200
Message-ID: <CAPDyKFoqZvR9eA+AmGxPd31osR7K2S3QKm7H16+a6XxT5-6Xjw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-esdhc: exit HS400 properly before setting
 any speed mode
To:     Yangbo Lu <yangbo.lu@nxp.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 22 May 2020 at 05:17, Yangbo Lu <yangbo.lu@nxp.com> wrote:
>
> The eSDHC HS400 timing requires many specific registers setting,
> unlike other speed modes which need to set only host controller 2
> register. When driver needs to downgrade HS400 mode to other speed
> mode, the controller have to exit HS400 timing properly first.
> This patch is to support the procedure of HS400 exiting at the
> beginning of esdhc_set_uhs_signaling.
>
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-of-esdhc.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
> index 5d8dd87..7c73d24 100644
> --- a/drivers/mmc/host/sdhci-of-esdhc.c
> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
> @@ -1135,6 +1135,40 @@ static int esdhc_execute_tuning(struct mmc_host *mmc, u32 opcode)
>  static void esdhc_set_uhs_signaling(struct sdhci_host *host,
>                                    unsigned int timing)
>  {
> +       u32 val;
> +
> +       /*
> +        * There are specific registers setting for HS400 mode.
> +        * Clean all of them if controller is in HS400 mode to
> +        * exit HS400 mode before re-setting any speed mode.
> +        */
> +       val = sdhci_readl(host, ESDHC_TBCTL);
> +       if (val & ESDHC_HS400_MODE) {
> +               val = sdhci_readl(host, ESDHC_SDTIMNGCTL);
> +               val &= ~ESDHC_FLW_CTL_BG;
> +               sdhci_writel(host, val, ESDHC_SDTIMNGCTL);
> +
> +               val = sdhci_readl(host, ESDHC_SDCLKCTL);
> +               val &= ~ESDHC_CMD_CLK_CTL;
> +               sdhci_writel(host, val, ESDHC_SDCLKCTL);
> +
> +               esdhc_clock_enable(host, false);
> +               val = sdhci_readl(host, ESDHC_TBCTL);
> +               val &= ~ESDHC_HS400_MODE;
> +               sdhci_writel(host, val, ESDHC_TBCTL);
> +               esdhc_clock_enable(host, true);
> +
> +               val = sdhci_readl(host, ESDHC_DLLCFG0);
> +               val &= ~(ESDHC_DLL_ENABLE | ESDHC_DLL_FREQ_SEL);
> +               sdhci_writel(host, val, ESDHC_DLLCFG0);
> +
> +               val = sdhci_readl(host, ESDHC_TBCTL);
> +               val &= ~ESDHC_HS400_WNDW_ADJUST;
> +               sdhci_writel(host, val, ESDHC_TBCTL);
> +
> +               esdhc_tuning_block_enable(host, false);
> +       }
> +
>         if (timing == MMC_TIMING_MMC_HS400)
>                 esdhc_tuning_block_enable(host, true);
>         else
> --
> 2.7.4
>
