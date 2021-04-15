Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57642C433B4
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CAB4613B7
	for <linux-mmc@archiver.kernel.org>; Thu, 15 Apr 2021 12:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhDOMDj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 15 Apr 2021 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhDOMDh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Apr 2021 08:03:37 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87448C061756
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:13 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id 33so7407882uaa.7
        for <linux-mmc@vger.kernel.org>; Thu, 15 Apr 2021 05:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyWS15qqYPq25mldI8XVE5ZMH/QV/WXZP1xn4X0ooIg=;
        b=b9KeIVNWXdyk0MYvW3lH/pszngqEs0JXSiXMdVsXgHbUrSTkkuij0voFL+lQzwt9Mi
         xZ40/JOvT+MeuCT7aqKkOHmdaGeDqObgrrubuz3gXs8nzlnMEzhIfU0VSOAOWKwOwm93
         6P1zl9SA0himRSzoryGekmycd8o1NsMKI8MzQtSKPJuTPhAh1qlnkLKeds2XCe5Q8DfV
         6n2RhKImzcsIw+qvoxtOeu+re6ayH0hQRZT2jS8tvpm8X3/ek2YQDvH3WxU0iY1FiyKx
         WT3iMajBr4VJxm0IdBZtGLLkb3qTplj8y/4omnKdrXpiCQcRd6UfGxfewtjNQz/48R3d
         aAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyWS15qqYPq25mldI8XVE5ZMH/QV/WXZP1xn4X0ooIg=;
        b=h+W5Nw/35WzT6jGyMtbKLZwLB9jQQxLPKwxqdWiEVrOql75aUUY98kJFXqRJsQf+nO
         fcJf/HUZsbVmj/sI6MC2E8UijljyxjhjlmJ7RNlRe2kcym6pev2we3SCprN5cww0Dxtd
         oXmVZVFhND+ZMGIUF4gp+J3CG+kyST8Fb9HiCLsj8n9m5GsOIYaVublaxsW/zbkMgaf/
         sJGdchKCyB9IyW9xxV6BTACq3a7eWrNXvCmuEBGGgwOCN72h/kcmJYuI/90yLU+dv9an
         aYPzHx1TNAZjDu0Jloytp9KPAn1jykReKHa5DG5I+He6LYtw3pBfSznidGBFBa77H4Ja
         yA8Q==
X-Gm-Message-State: AOAM531wthgFqEVuXY3OupUGBrp+o34VmR9whzlAlfK1hrZRjI+Kz+oW
        w8W1TlNMNruFVcAU9fiiYSr/xojGLRdvydi2EjRJRQ==
X-Google-Smtp-Source: ABdhPJxEfJCcnwEzl4ksTx5+3ToYflHaWAwnldJV4BYXUjAxrfxhORrNDOb8TGG55HvfxkoAvUsUAwW7gVYDC7sQ2lk=
X-Received: by 2002:ab0:2c16:: with SMTP id l22mr1431867uar.100.1618488191187;
 Thu, 15 Apr 2021 05:03:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210415032637.5219-1-benchuanggli@gmail.com>
In-Reply-To: <20210415032637.5219-1-benchuanggli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 15 Apr 2021 14:02:33 +0200
Message-ID: <CAPDyKFqHs6eOqq0m==R1EQBMaYhf2pVOzvxXsgEO7uMYWa=zYw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Enlarge ASPM L1 entry delay of GL975x
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SeanHY.Chen@genesyslogic.com.tw,
        =?UTF-8?B?UmVuaXVzQ2hlblvpmbPlu7rlro9d?= 
        <Renius.Chen@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 15 Apr 2021 at 05:23, Ben Chuang <benchuanggli@gmail.com> wrote:
>
> GL975x enters ASPM L1 state after a short idle in default.
> Enlarge the idle period to 7.9us for improving the R/W performance.
>
> Signed-off-by: Ben Chuang <benchuanggli@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index eb1ebb67e113..592d79082f58 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -22,6 +22,10 @@
>  #define   GLI_9750_WT_EN_ON        0x1
>  #define   GLI_9750_WT_EN_OFF       0x0
>
> +#define SDHCI_GLI_9750_CFG2          0x848
> +#define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> +#define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> +
>  #define SDHCI_GLI_9750_DRIVING      0x860
>  #define   SDHCI_GLI_9750_DRIVING_1    GENMASK(11, 0)
>  #define   SDHCI_GLI_9750_DRIVING_2    GENMASK(27, 26)
> @@ -113,6 +117,10 @@
>  #define   PCI_GLI_9755_LFCLK    GENMASK(14, 12)
>  #define   PCI_GLI_9755_DMACLK   BIT(29)
>
> +#define PCI_GLI_9755_CFG2          0x48
> +#define   PCI_GLI_9755_CFG2_L1DLY    GENMASK(28, 24)
> +#define   GLI_9755_CFG2_L1DLY_VALUE  0x1F
> +
>  #define PCI_GLI_9755_PLL            0x64
>  #define   PCI_GLI_9755_PLL_LDIV       GENMASK(9, 0)
>  #define   PCI_GLI_9755_PLL_PDIV       GENMASK(14, 12)
> @@ -408,6 +416,22 @@ static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
>         sdhci_enable_clk(host, clk);
>  }
>
> +static void gl9750_hw_setting(struct sdhci_host *host)
> +{
> +       u32 value;
> +
> +       gl9750_wt_on(host);
> +
> +       value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
> +       value &= ~SDHCI_GLI_9750_CFG2_L1DLY;
> +       /* set ASPM L1 entry delay to 7.9us */
> +       value |= FIELD_PREP(SDHCI_GLI_9750_CFG2_L1DLY,
> +                           GLI_9750_CFG2_L1DLY_VALUE);
> +       sdhci_writel(host, value, SDHCI_GLI_9750_CFG2);
> +
> +       gl9750_wt_off(host);
> +}
> +
>  static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
>  {
>         int ret;
> @@ -555,6 +579,13 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>         value &= ~PCI_GLI_9755_SCP_DIS;
>         pci_write_config_dword(pdev, PCI_GLI_9755_SerDes, value);
>
> +       pci_read_config_dword(pdev, PCI_GLI_9755_CFG2, &value);
> +       value &= ~PCI_GLI_9755_CFG2_L1DLY;
> +       /* set ASPM L1 entry delay to 7.9us */
> +       value |= FIELD_PREP(PCI_GLI_9755_CFG2_L1DLY,
> +                           GLI_9755_CFG2_L1DLY_VALUE);
> +       pci_write_config_dword(pdev, PCI_GLI_9755_CFG2, value);
> +
>         gl9755_wt_off(pdev);
>  }
>
> @@ -562,6 +593,7 @@ static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>         struct sdhci_host *host = slot->host;
>
> +       gl9750_hw_setting(host);
>         gli_pcie_enable_msi(slot);
>         slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
>         sdhci_enable_v4_mode(host);
> --
> 2.30.0
>
