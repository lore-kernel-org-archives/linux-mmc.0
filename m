Return-Path: <SRS0=XGfH=4T=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ABB6C3F2D1
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Mar 2020 17:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C08E22B48
	for <linux-mmc@archiver.kernel.org>; Mon,  2 Mar 2020 17:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgCBRJe (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:09:34 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44989 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbgCBRJd (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 2 Mar 2020 12:09:33 -0500
Received: by mail-il1-f194.google.com with SMTP id x7so110748ilq.11
        for <linux-mmc@vger.kernel.org>; Mon, 02 Mar 2020 09:09:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pY7gYt6OotnqUFf5LH33Rx81o88vShjsNxCsLlJhYP4=;
        b=dH9+7Tdgfb3yxJz8/iaILXZ/muBdKRpwxO+QHd61mBzEwvd+7hk839meonbF2NEKgA
         UhflyvknVng7tAwaHjRzrr+qyRibYRbv8pTy058JFwnZp/4Nwm+WRbobYcBzboj7yG4G
         MPqAVbYApZj1eKaqQCQN2EzJEjE0Lgge86y9dkCIHAjB38NHtmXmRf/XhOvQAVeFxRhH
         sfG10ZdMXh4VIqMqvbUNeOVFLebpPjb6ua38d77cieJCR67TapccM2sgooSVCfZHgVK/
         bmL/LngyRTDFCICD9EzUm5M12d7gDiUv4SFSG57H2DPQ4L8xijIYiiQxB1lSiBJ1mXi/
         o3tA==
X-Gm-Message-State: ANhLgQ2CtuJ8mGglzXKC6piNiVqn1WuDHN6jMXkA1TKVkDAkrXXk7mGM
        XZZAq/dVYZVlawhS1ljvQb2Euw==
X-Google-Smtp-Source: ADFU+vvLqUKxKaXlniz29wyCsSX4+Kp1o78dvk9pMAs2sRWuO4RBSRWjMfxc6G3wlV7VF6Vft4V9EA==
X-Received: by 2002:a92:9c57:: with SMTP id h84mr594806ili.94.1583168970924;
        Mon, 02 Mar 2020 09:09:30 -0800 (PST)
Received: from google.com ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id z63sm6813088ilk.44.2020.03.02.09.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 09:09:30 -0800 (PST)
Date:   Mon, 2 Mar 2020 10:09:26 -0700
From:   Raul Rangel <rrangel@chromium.org>
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Enable MSI interrupt for GL975x
Message-ID: <20200302170926.GA59937@google.com>
References: <20200219092900.9151-1-benchuanggli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219092900.9151-1-benchuanggli@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Feb 19, 2020 at 05:29:00PM +0800, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Enable MSI interrupt for GL9750/GL9755. Some platforms
> do not support PCI INTx and devices can not work without
> interrupt. Like messages below:
> 
> [    4.487132] sdhci-pci 0000:01:00.0: SDHCI controller found [17a0:9755] (rev 0)
> [    4.487198] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.PBR2._PRT.APS2], AE_NOT_FOUND (20190816/psargs-330)
> [    4.487397] ACPI Error: Aborting method \_SB.PCI0.PBR2._PRT due to previous error (AE_NOT_FOUND) (20190816/psparse-529)
> [    4.487707] pcieport 0000:00:01.3: can't derive routing for PCI INT A
> [    4.487709] sdhci-pci 0000:01:00.0: PCI INT A: no GSI
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> ---
>  drivers/mmc/host/sdhci-pci-gli.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
> index 5eea8d70a85d..ce15a05f23d4 100644
> --- a/drivers/mmc/host/sdhci-pci-gli.c
> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> @@ -262,10 +262,26 @@ static int gl9750_execute_tuning(struct sdhci_host *host, u32 opcode)
>  	return 0;
>  }
>  
> +static void gli_pcie_enable_msi(struct sdhci_pci_slot *slot)
> +{
> +	int ret;
> +
> +	ret = pci_alloc_irq_vectors(slot->chip->pdev, 1, 1,
> +				    PCI_IRQ_MSI | PCI_IRQ_MSIX);
> +	if (ret < 0) {
> +		pr_warn("%s: enable PCI MSI failed, error=%d\n",
> +		       mmc_hostname(slot->host->mmc), ret);
> +		return;
> +	}
> +
> +	slot->host->irq = pci_irq_vector(slot->chip->pdev, 0);
> +}
> +
>  static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_host *host = slot->host;
>  
> +	gli_pcie_enable_msi(slot);
>  	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
>  	sdhci_enable_v4_mode(host);
>  
> @@ -276,6 +292,7 @@ static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
>  {
>  	struct sdhci_host *host = slot->host;
>  
> +	gli_pcie_enable_msi(slot);
>  	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
>  	sdhci_enable_v4_mode(host);
>  
Tested-by: Raul E Rangel <rrangel@chromium.org>

