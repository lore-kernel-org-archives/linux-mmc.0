Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE18EEAA50
	for <linux-mmc@archiver.kernel.org>; Thu, 14 Sep 2023 14:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240790AbjINOsw (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 Sep 2023 10:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240632AbjINOsg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Sep 2023 10:48:36 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759CE213A
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 07:48:31 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d7e9d849bdfso1092037276.3
        for <linux-mmc@vger.kernel.org>; Thu, 14 Sep 2023 07:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694702910; x=1695307710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YFfESoywnbM2oGqA0AlbxSUpI+IdaDbHbq5gv50chHI=;
        b=mfRHwQjPXHFk02Ti7Cwpp7/YiYI05ZbOWaDhr9y3W5tPaT9olaL4WblTQiq3tjNg+/
         rpFjJICYWztGzEaMw7S/W8ZdxiMJ0SF5vrp1JsHd5M8glyJ9YwBhucsHNz/qYFtMgnuZ
         XNt40KqS8OAp3nhP/gJ2uSIY7REQAOUqs+R5R/iaUwIZ5TND3U6p4jhCTCPIXwl8mmK2
         0xmN6faYDWyJkioLh9Sl6q5eQsmBe7DKDFeiOnWnuF2yANscMPxDpzMDB0s/99gKQkNW
         lH3ieE2FOUDmAJvHl0DgY0Zz0+pDuD1AH/B8iQm7FuUXtNU1aRlHEwL5H2tGuUJSCpHR
         bQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702910; x=1695307710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YFfESoywnbM2oGqA0AlbxSUpI+IdaDbHbq5gv50chHI=;
        b=weJrp3Qz06qm3qTLFGQ70jQ2mwZxIGspn8OQJx1+89ZotejSN142Z/UcaC9J7VOOpA
         G61co0+5q+PADG63uiREABgfQqtERO8Fca480IzFioGbRoW44HZVJSS91ctRveOyywOw
         ImeyGhmedISEyIuiev/dI9FncuOgfYMbJp5PtQ5v7Ncm9ZNgQBT7RBi44c/1thgfGFFK
         N92+CqvMyyuuQcqqdd0zpvtyvMBLrg79FOcKEQFPb++A/bKKIjyxYhcBkuO+g675SiEM
         klMt0TGR461HJVTmuTe+M/6ZFIQhUoJqiCexRWsFEd6DUFyuT2K8bXMk/hp27hF/+XJw
         +kAA==
X-Gm-Message-State: AOJu0YwWISn7gvS4Ro+IHF2kOwQePja94NgHvGxslQuMGXpg5wY2azHX
        WR0Xt180HUQ5qEqDhGxBNF9tLKi+3RR/ga7gHIwMWw==
X-Google-Smtp-Source: AGHT+IGwW7e1muB88RstaQxIs9bpzkUepLjVnlfFeNQfP8KfVLELvCRgKJ8zEokddRZpk9r6d7zCoUzJY21UntrkZos=
X-Received: by 2002:a25:42ca:0:b0:d72:80bc:d3b2 with SMTP id
 p193-20020a2542ca000000b00d7280bcd3b2mr5467755yba.32.1694702910662; Thu, 14
 Sep 2023 07:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230912091710.7797-1-victorshihgli@gmail.com>
In-Reply-To: <20230912091710.7797-1-victorshihgli@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 Sep 2023 16:47:54 +0200
Message-ID: <CAPDyKFpvFQkygmMTPXfJF00KD1i-3Shp=pJxikVPD2jdcpk9_g@mail.gmail.com>
Subject: Re: [PATCH V1] mmc: sdhci-pci-gli: A workaround to allow GL9750 to
 enter ASPM L1.2
To:     Victor Shih <victorshihgli@gmail.com>
Cc:     adrian.hunter@intel.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, benchuanggli@gmail.com,
        HL.Liu@genesyslogic.com.tw, Greg.tu@genesyslogic.com.tw,
        liukun11@huaqin.com, Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 12 Sept 2023 at 11:17, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> When GL9750 enters ASPM L1 sub-states, it will stay at L1.1 and will not
> enter L1.2. The workaround is to toggle PM state to allow GL9750 to enter
> ASPM L1.2.
>
> Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index ae8c307b7aa7..dd6f09024f08 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -25,6 +25,9 @@
>  #define   GLI_9750_WT_EN_ON        0x1
>  #define   GLI_9750_WT_EN_OFF       0x0
>
> +#define PCI_GLI_9750_PM_CTRL   0xFC
> +#define   PCI_GLI_9750_PM_STATE          GENMASK(1, 0)
> +
>  #define SDHCI_GLI_9750_CFG2          0x848
>  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
>  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> @@ -536,8 +539,12 @@ static void sdhci_gl9750_set_clock(struct sdhci_host *host, unsigned int clock)
>
>  static void gl9750_hw_setting(struct sdhci_host *host)
>  {
> +       struct sdhci_pci_slot *slot = sdhci_priv(host);
> +       struct pci_dev *pdev;
>         u32 value;
>
> +       pdev = slot->chip->pdev;
> +
>         gl9750_wt_on(host);
>
>         value = sdhci_readl(host, SDHCI_GLI_9750_CFG2);
> @@ -547,6 +554,13 @@ static void gl9750_hw_setting(struct sdhci_host *host)
>                             GLI_9750_CFG2_L1DLY_VALUE);
>         sdhci_writel(host, value, SDHCI_GLI_9750_CFG2);
>
> +       /* toggle PM state to allow GL9750 to enter ASPM L1.2 */
> +       pci_read_config_dword(pdev, PCI_GLI_9750_PM_CTRL, &value);
> +       value |= PCI_GLI_9750_PM_STATE;
> +       pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
> +       value &= ~PCI_GLI_9750_PM_STATE;
> +       pci_write_config_dword(pdev, PCI_GLI_9750_PM_CTRL, value);
> +
>         gl9750_wt_off(host);
>  }
>
> --
> 2.25.1
>
