Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C514AC433E0
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E6861606
	for <linux-mmc@archiver.kernel.org>; Wed,  3 Mar 2021 01:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234004AbhCCBqe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 2 Mar 2021 20:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349597AbhCBKm2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Mar 2021 05:42:28 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A3BC0611BD
        for <linux-mmc@vger.kernel.org>; Tue,  2 Mar 2021 02:39:57 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id b189so4409277vsd.0
        for <linux-mmc@vger.kernel.org>; Tue, 02 Mar 2021 02:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6yK7zojmd2caTqKaDe5ClSdgsBzC7JBS/wNNBBcaZxA=;
        b=IoLMpKuxBiqHyBwq9YqDrdCjt+NDVivAfb1Ktdc+FLKrEY6Yg/vUuJAFhUHXj0ixK6
         YxACozNO2/U6fV16rJIE9zn89NANeI9753x9o2jzuQy9ZGV+e1IqHWY79+mGAwy+BOVX
         EWH/9rmDnGNfIvesHhF/2tynS011oHtx7XMt7cmIgyJkkJ2tDOi8pQvQ+rDdTUBzE3y9
         aqJcY/ItTcmj755unV7uMc+EyzbGtlAokvn4eft0mxOkaWAW+y/oC6N9XMknTiuek6Wt
         LMqW/eYTpzZw3WRhm6VgNWkTxwtsytThVMWEP2kxwBKAF5CLU8RJ36Ez4hK6V9quGAGR
         zHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6yK7zojmd2caTqKaDe5ClSdgsBzC7JBS/wNNBBcaZxA=;
        b=hftSCnRwlxLypPT0tujaSt86CyN4Ke31A//X/hssqFHMlKZVmp5bth/bthYSvH/PQG
         e7sr+ZlG40Kz82ZIvURwyDOxv30rsF/3rb6Dmvbj0Oj1X6BSmyMbbTVAuOcvYlbfOTPW
         HpvnBL+xwPOEUTgK+LLX3e2XSGIBWOe2US2XXzOdzGwF9T9JEeLVWczLBqaRcpV5QIgB
         HaeeLSt0SAOnjP/L9LKurmP7wa2ydy/39BKNDMgg7Ez1TsKVjmgaoreYuW10QBkTe1aW
         xl9lPKQgcsSk1n1lPsMZBsD/czBL1GHs8cQUEVItY/9JPYwZEHOLCoMDHxPJf/gcOT0q
         hh0g==
X-Gm-Message-State: AOAM531b3tCMjCH085yt6BJn5umk+/HEUVyQculgjzY8OyjNvBuTs+WE
        Ad2QuBfEin1MDMP6dTBm3Ap/49KReiYl1im/h0wd3A==
X-Google-Smtp-Source: ABdhPJzteFnm34/rnE8GfsHicqY6EuLlD/nABaelsO0moyaBgSjS4nricgbLbBWqmMgK/N4kWtfzf+XWYC5ysbajh10=
X-Received: by 2002:a67:f98a:: with SMTP id b10mr1465857vsq.19.1614681597024;
 Tue, 02 Mar 2021 02:39:57 -0800 (PST)
MIME-Version: 1.0
References: <20210225111307.62975-1-reniuschengl@gmail.com>
In-Reply-To: <20210225111307.62975-1-reniuschengl@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 2 Mar 2021 11:39:19 +0100
Message-ID: <CAPDyKFqBdYf4A6xEiPUu4qKSmNYMfC9WnxfTrjc5zgRdcre5cw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Enable short circuit protection
 mechanism of GL9755
To:     Renius Chen <reniuschengl@gmail.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 25 Feb 2021 at 12:13, Renius Chen <reniuschengl@gmail.com> wrote:
>
> Short circuit protection mechanism of GL9755 is disabled by HW default
> setting. Enable short circuit protection to prevent GL9755 from being
> damaged by short circuit or over current.
>
> Signed-off-by: Renius Chen <reniuschengl@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 5606bdc08a96..7ba0fd601696 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -123,6 +123,9 @@
>  #define PCI_GLI_9755_PLLSSC        0x68
>  #define   PCI_GLI_9755_PLLSSC_PPM    GENMASK(15, 0)
>
> +#define PCI_GLI_9755_SerDes  0x70
> +#define PCI_GLI_9755_SCP_DIS   BIT(19)
> +
>  #define GLI_MAX_TUNING_LOOP 40
>
>  /* Genesys Logic chipset */
> @@ -547,6 +550,11 @@ static void gl9755_hw_setting(struct sdhci_pci_slot *slot)
>         value &= ~PCI_GLI_9755_DMACLK;
>         pci_write_config_dword(pdev, PCI_GLI_9755_PECONF, value);
>
> +       /* enable short circuit protection */
> +       pci_read_config_dword(pdev, PCI_GLI_9755_SerDes, &value);
> +       value &= ~PCI_GLI_9755_SCP_DIS;
> +       pci_write_config_dword(pdev, PCI_GLI_9755_SerDes, value);
> +
>         gl9755_wt_off(pdev);
>  }
>
> --
> 2.27.0
>
