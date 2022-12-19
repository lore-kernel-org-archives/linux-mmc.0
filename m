Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5619C4167B
	for <linux-mmc@archiver.kernel.org>; Mon, 19 Dec 2022 15:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbiLSPlz (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 19 Dec 2022 10:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbiLSPlt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2022 10:41:49 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC09D11C1C
        for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2022 07:41:48 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id p36so14189096lfa.12
        for <linux-mmc@vger.kernel.org>; Mon, 19 Dec 2022 07:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OPySi+jcQcviSPVv+LV6bNjIASezBPf2TkmclDtC97I=;
        b=y/v4lZjONmbQR/D/77RrBWQP3QA4QH4hATJnZAyKgb3O+MOSBZUTS9GEUT6JaHJCUU
         p4AoIGGJ+xqjqvyWNacJYYEhMqycevbfuiceGnvalU0N7MNF+r3CWFuNPhbFOQNjuhrX
         cLNybl7T1XX036UOKtcIE/T67lztkxqjJYb6qvsSTlRIi85ervroihKKoODBCFFlMsg5
         2xZYX1kaLXc9YCNvwqYE4CHN2QzEOfEDXHehl5w6fYwQfBbEGUci5wj7ZO82qFqbp/Eu
         vxg2c5hfPjOlbHMvahqmTkOQbP8neUntViK/2uz34hynkOthiYPnsx/3iPTCwv8AXapq
         /pgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPySi+jcQcviSPVv+LV6bNjIASezBPf2TkmclDtC97I=;
        b=uVFNoUxoKrJmG4FqX54naoTmOKHuWREM5d4XDXnFk8JV0pNFGEATZ4K6UJJoMWtFaN
         JBM4I3s3dfO2pD/Nie7sKlbMlX65s3CV05QtEBmvVqr5nHmwMG6QZ3/F7wHO4/Xv2pCg
         FjZ1+YqoCyFsyfMtxuEEqM1InPOg/0c1qSODTJP7nJVJvn6A4NYoqUKO77JSthmbU3mO
         zMlg84v4v7PnwU5tBh+/6UievvDBgKQheCBPmrN7rx3lf9ul7R/Qx0qnU745QXQjNpEv
         RLFe/P9odTRZsd2Vc9UZ/50ObWWfacI5lnklssgbzbSzRlypp8KFEPHIiCtdQN/GvTlb
         Febg==
X-Gm-Message-State: ANoB5plu//oOzppVh506bkJKO3yX+vxwqc/amH30IoL9aS+XLXefQ0Ea
        ob73QF/DEx+b28Uri97FSSTHVw==
X-Google-Smtp-Source: AA0mqf6a7A4r0Kj20/hU8dHWnzLl6CeRPebS6PaL/n/nEVJgIoVR1cN4kaJKuM9FLe3zbzGz0tm+cg==
X-Received: by 2002:a05:6512:b91:b0:4b6:ed8b:4f16 with SMTP id b17-20020a0565120b9100b004b6ed8b4f16mr12729404lfv.52.1671464507096;
        Mon, 19 Dec 2022 07:41:47 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f3-20020a056512360300b00492ca820e15sm1129467lfs.270.2022.12.19.07.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 07:41:46 -0800 (PST)
Message-ID: <c008733c-b47b-606e-f8e6-d5ea14e5befb@linaro.org>
Date:   Mon, 19 Dec 2022 16:41:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/5] drivers: mmc: sdhci-cadence: SD6 controller support
Content-Language: en-US
To:     Piyush Malgujar <pmalgujar@marvell.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, yamada.masahiro@socionext.com,
        devicetree@vger.kernel.org
Cc:     jannadurai@marvell.com, cchavva@marvell.com,
        Dhananjay Kangude <dkangude@cadence.com>
References: <20221219142418.27949-1-pmalgujar@marvell.com>
 <20221219142418.27949-2-pmalgujar@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221219142418.27949-2-pmalgujar@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 19/12/2022 15:24, Piyush Malgujar wrote:
> From: Dhananjay Kangude <dkangude@cadence.com>
> 
> This patch includes changes done to support SD6 controller:

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> - Added SD6 related ops which are isolated from SD4
> - changes to support HS400, HS400ES emmc mode
> - Updated HS200 tuning values and support to read tune configuration
>   from FDT.
> - Support to configure host side drive strength and slew
>   and read it from device tree
> 


(...)

>  
> @@ -455,7 +1752,14 @@ static const struct of_device_id sdhci_cdns_match[] = {
>  		.compatible = "socionext,uniphier-sd4hc",
>  		.data = &sdhci_cdns_uniphier_pltfm_data,
>  	},
> -	{ .compatible = "cdns,sd4hc" },
> +	{
> +		.compatible = "cdns,sd4hc",
> +		.data = &sdhci_cdns_sd4_of_data,
> +	},
> +	{
> +		.compatible = "cdns,sd6hc",
> +		.data = &sdhci_cdns_sd6_of_data,
> +	},

Your bindings said something different - every sd4hc is compatible with
sd6hc.

Best regards,
Krzysztof

