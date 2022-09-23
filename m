Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE87C6FA82
	for <linux-mmc@archiver.kernel.org>; Fri, 23 Sep 2022 09:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiIWJkx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 23 Sep 2022 05:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiIWJiv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Sep 2022 05:38:51 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEEDF1879
        for <linux-mmc@vger.kernel.org>; Fri, 23 Sep 2022 02:38:34 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so18944982lfr.2
        for <linux-mmc@vger.kernel.org>; Fri, 23 Sep 2022 02:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=kUkKnSToWBiAp7jFJoJfzt/vyDxgquAmqUaAVPpyLJo=;
        b=o8tltaqBCnETP2nIc7yxtqe2HACJeknkObRZc8S2S1AYjjxb0AJ14zw2/jaalhEFqj
         sRAYv4Q+8L1lDh8qcnY5bxF0nsBUOnoN5viGa7/VrgBGOojkC2388NkhOB6SZtyuB52u
         OkicU7Q3xZqS36+ZRHWpUUeHzWIPhVSbpar1k9bziM5SRSXc2KrKTj9sTRHz/uECDVRd
         y58JrHvDMhbl5035Ls49F95QFXJ3auOINZp5lSGfZMAacCeYnZneaVXOWZTivPzwKqkp
         wpAzPdEkMWlx7raEbhWmdrwuJjh1M0dJS+6cHB8WUfGjrtgJljFeUTfHSJHXdwK45aiE
         8k5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=kUkKnSToWBiAp7jFJoJfzt/vyDxgquAmqUaAVPpyLJo=;
        b=qz+f4WI6gsgoUOCqrmCv/T973YHhEaDX2QEPpAoiyO0cJPgcWiynli2EPwzz4sR8GF
         Qb1DMSFilZLtTLZAj5D/AreZ5gbGz1JOjPrDMSJ/Nojn72Mer51/QJAm2dfNSouUlHnb
         NZF1KBP6kCKNDoFIfEfAT1IYtbs4c8oUhewGrA6iwWmuueYznoW0pBS9Me7FOPVbdTUi
         n2GfqBLNLCuzTPu48EHmJBUOQsmABJufnEQT82YPfNYvZWZzF30gDzdykHuAP6OwhCRX
         BylNmENmVwXYS/yEYld2D7tM9TKkmboyCXmhnX++YgwcPTe9NHlL/wMRZXE07I7wD6OD
         hcLQ==
X-Gm-Message-State: ACrzQf1tTGgdxeYlwCFJkg7uU6oTms8xuyrd5s5OFF1gLpBWFsiZlAQb
        bZkV3O0rU4861NzvmGyPz6OB7A==
X-Google-Smtp-Source: AMsMyM6PSJE5Ve/XZ7OKQb0FHJiZgYISJoAOwRQqG4fNfNeQ7YdMKUWmDEjNEJJRm3W+kEo7ChCOeA==
X-Received: by 2002:ac2:4c50:0:b0:49a:3768:da81 with SMTP id o16-20020ac24c50000000b0049a3768da81mr2750254lfk.247.1663925913003;
        Fri, 23 Sep 2022 02:38:33 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id x15-20020a19e00f000000b00498fc3d4d15sm1363465lfg.190.2022.09.23.02.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 02:38:32 -0700 (PDT)
Message-ID: <e9860dfc-061d-4ab4-c7e3-d0b062cb9eda@linaro.org>
Date:   Fri, 23 Sep 2022 11:38:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 2/2] mmc: sdhci-msm: add compatible string check for
 sdm670
Content-Language: en-US
To:     Richard Acayan <mailingradian@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
References: <20220923014322.33620-1-mailingradian@gmail.com>
 <20220923014322.33620-3-mailingradian@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220923014322.33620-3-mailingradian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 23/09/2022 03:43, Richard Acayan wrote:
> The Snapdragon 670 has the same quirk as Snapdragon 845 (needing to
> restore the dll config). Add a compatible string check to detect the need
> for this.
> 
> Signed-off-by: Richard Acayan <mailingradian@gmail.com>
> ---
>  drivers/mmc/host/sdhci-msm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index dc2991422a87..3a091a387ecb 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -2441,6 +2441,7 @@ static const struct of_device_id sdhci_msm_dt_match[] = {
>  	 */
>  	{.compatible = "qcom,sdhci-msm-v4", .data = &sdhci_msm_mci_var},
>  	{.compatible = "qcom,sdhci-msm-v5", .data = &sdhci_msm_v5_var},
> +	{.compatible = "qcom,sdm670-sdhci", .data = &sdm845_sdhci_var},
>  	{.compatible = "qcom,sdm845-sdhci", .data = &sdm845_sdhci_var},
>  	{.compatible = "qcom,sc7180-sdhci", .data = &sdm845_sdhci_var},

Probably we should make them a family of compatible devices, because the
list grows. For three items:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

If you want to add fourth, I propose to make it a family.


Best regards,
Krzysztof

