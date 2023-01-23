Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D0EC05027
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Jan 2023 19:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjAWThs (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Jan 2023 14:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjAWThp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Jan 2023 14:37:45 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4373251B
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2023 11:37:39 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id fl11-20020a05600c0b8b00b003daf72fc844so11401416wmb.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Jan 2023 11:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1OhZ+D+QYAHJTyvBziWpPe0FwSfgzOqFw40HzEYSV/0=;
        b=wAFt0TMSFvgQUOzquwM5mhRQ0LN/8p/mCfMqdkitO+sojifz2twvshK/7RdpUNNE0G
         sfVxhtXxGDfAN3/ASBe34ChyKGu+6lwVHoOZXclfhcKUF6/H2g4y7tvScZKZrNqRkUpA
         j+nrunz1u6wdye2JNrGPhPv6T4JsPKs3HZ2tj3wWMYDAkoHyaAAbk1cKDQGiUEGSjYj7
         jVgexovoFCoMaBxjPtzvzp7rD/TcCnE+avoh+3/7SeWKcNNeid8lkDHiaGcJ3OHc+Lxg
         1X8nOJ9y3ihb2/I1ypiS7zcFRsXT60p6ToTsQpiySiLJk7sBGtKdHSKtnq/YBL9VHRyn
         /S+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1OhZ+D+QYAHJTyvBziWpPe0FwSfgzOqFw40HzEYSV/0=;
        b=aQtXdNBQ82Az+bg7wJgYbDjuBR7WjxQi/3zo0eQzCmDjBbseJvbZXQ8i4ht7W4CAZc
         MoIXKmUQNJnZ9oewp2YcVn6B5UeairflAGAo5/ZULxWVaf7BQVCb5EC+qHYxJFiOLWRp
         rR463Ysc8Yx1rFtlVH03+ra7yWb8WIxFNYzUP1uZfuq+5OJJ8PrUthGdQ+xZi0hO7sB5
         1v4Mkg8o2LGiXPcHDEGv86P8t+78Pp1AvEX2UG5L2ZGuoWc38ka8vNhuxZoMjw9aK8vE
         A+lwpIbpRAJ8wiXTsG4f0Gvbmell+wK/SS9A/lct1oxLjuCmxEDjVOJmkzrhUdxz0pHg
         neJQ==
X-Gm-Message-State: AFqh2koi/xqWf4UpT0H8rWxLCcbJlkOd8ZY8GGMCyG90YM8wVxGCubEX
        C4OpJXbw4Thq5H3dzMP6BgXCsw==
X-Google-Smtp-Source: AMrXdXs/SBkzeUzSBJNT1Gp49ytoZiHX/WkrYsJguNF2i+bufOCj2ALHstW8FBhivh2jeZSrM64xqw==
X-Received: by 2002:a05:600c:a4c:b0:3dc:d5b:5f6a with SMTP id c12-20020a05600c0a4c00b003dc0d5b5f6amr210384wmq.30.1674502657662;
        Mon, 23 Jan 2023 11:37:37 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p4-20020a05600c418400b003d98f92692fsm74359wmh.17.2023.01.23.11.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 11:37:37 -0800 (PST)
Message-ID: <c1a49032-eefd-e028-5a10-845bd0762362@linaro.org>
Date:   Mon, 23 Jan 2023 20:37:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/5] drivers: mmc: sdhci-cadence: Reformat the code
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com,
        Dhananjay Kangude <dkangude@cadence.com>
References: <20230123192735.21136-1-pmalgujar@marvell.com>
 <20230123192735.21136-2-pmalgujar@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230123192735.21136-2-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/01/2023 20:27, Piyush Malgujar wrote:
> From: Dhananjay Kangude <dkangude@cadence.com>
> 

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

(there is no "drivers:" part)

> Reformat the code so that further SD6 changes could be
> added and it could be isolated from SD4 related code.
> Also renamed functions accordingly.

Your code makes much more than just reformat. Split trivial reformating
and renaming from code which has functional impact.


> 
> Signed-off-by: Dhananjay Kangude <dkangude@cadence.com>
> Co-developed-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Jayanthi Annadurai <jannadurai@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>
> ---
>  drivers/mmc/host/sdhci-cadence.c | 165 ++++++++++++++++++++-----------
>  1 file changed, 110 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
> index 6f2de54a598773879bf339aae8450f63e1251509..cb108ff9abda32767b356bb572abdf8626746cd6 100644
> --- a/drivers/mmc/host/sdhci-cadence.c
> +++ b/drivers/mmc/host/sdhci-cadence.c
> @@ -15,14 +15,14 @@
>  
>  #include "sdhci-pltfm.h"
>  
> -/* HRS - Host Register Set (specific to Cadence) */
> +/* SD 4.0 Controller HRS - Host Register Set (specific to Cadence) */
>  #define SDHCI_CDNS_HRS04		0x10		/* PHY access port */
> -#define   SDHCI_CDNS_HRS04_ACK			BIT(26)
> -#define   SDHCI_CDNS_HRS04_RD			BIT(25)
> -#define   SDHCI_CDNS_HRS04_WR			BIT(24)
> -#define   SDHCI_CDNS_HRS04_RDATA		GENMASK(23, 16)
> -#define   SDHCI_CDNS_HRS04_WDATA		GENMASK(15, 8)
> -#define   SDHCI_CDNS_HRS04_ADDR			GENMASK(5, 0)
> +#define SDHCI_CDNS_SD4_HRS04_ACK		BIT(26)
> +#define SDHCI_CDNS_SD4_HRS04_RD			BIT(25)
> +#define SDHCI_CDNS_SD4_HRS04_WR			BIT(24)
> +#define SDHCI_CDNS_SD4_HRS04_RDATA		GENMASK(23, 16)
> +#define SDHCI_CDNS_SD4_HRS04_WDATA		GENMASK(15, 8)
> +#define SDHCI_CDNS_SD4_HRS04_ADDR		GENMASK(5, 0)
>  
>  #define SDHCI_CDNS_HRS06		0x18		/* eMMC control */
>  #define   SDHCI_CDNS_HRS06_TUNE_UP		BIT(15)
> @@ -38,7 +38,7 @@
>  /* SRS - Slot Register Set (SDHCI-compatible) */
>  #define SDHCI_CDNS_SRS_BASE		0x200
>  
> -/* PHY */
> +/* PHY registers for SD4 controller */
>  #define SDHCI_CDNS_PHY_DLY_SD_HS	0x00
>  #define SDHCI_CDNS_PHY_DLY_SD_DEFAULT	0x01
>  #define SDHCI_CDNS_PHY_DLY_UHS_SDR12	0x02
> @@ -59,24 +59,43 @@
>   */
>  #define SDHCI_CDNS_MAX_TUNING_LOOP	40
>  
> -struct sdhci_cdns_phy_param {
> +struct sdhci_cdns_priv;
> +
> +struct sdhci_cdns_sd4_phy_param {
>  	u8 addr;
>  	u8 data;
>  };
>  
> +struct sdhci_cdns_data {
> +	int (*phy_init)(struct sdhci_cdns_priv *priv);
> +	int (*set_tune_val)(struct sdhci_host *host, unsigned int val);
> +};
> +
> +struct sdhci_cdns_sd4_phy {
> +	unsigned int nr_phy_params;
> +	struct sdhci_cdns_sd4_phy_param phy_params[];
> +};

Defining new structures is not a "reformat".


Best regards,
Krzysztof

