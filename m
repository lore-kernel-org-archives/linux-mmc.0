Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E8AC7EE29
	for <linux-mmc@archiver.kernel.org>; Thu,  1 Jun 2023 08:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjFAI2M (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 1 Jun 2023 04:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjFAI2B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 1 Jun 2023 04:28:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1F21B6
        for <linux-mmc@vger.kernel.org>; Thu,  1 Jun 2023 01:27:54 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f4f3ac389eso577456e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 01 Jun 2023 01:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685608072; x=1688200072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsfcfGESGOogETw3T5X2wpY9BTZmmJqhcoXtEqtASKo=;
        b=hMnlUuBCsDAMUJwZvzCz2mNIgNmh4u1n7SQ7oO0yMgXB685qM/Yy9fq9cuRw0j3odh
         JxRNe4d389ndVXS79hqAAvinlJ2nUKx4W7xaA+pRbf1YW/LOCEP5vciT0cki1kQEw4ph
         7vgXBCDRDQpHJEA5NMxjXE3ZSkb4+EfPJkyidQCZg0AHZIPlcaiWNv14u/80OTjFi7Tt
         xhKOtexAeffyKlqnmZAKLsbXmynYgmN0e8nI9PSof9/a1qbpUyq/TlTAT3KBVEP954X1
         Bf4kXzqgto8FQ2j9EDp15LkY5RaUxNWXidJVzRXM6UH7GWL0c01ua1x1A7QN08IzztP6
         02CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685608072; x=1688200072;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsfcfGESGOogETw3T5X2wpY9BTZmmJqhcoXtEqtASKo=;
        b=QWPwatNZidqtHAc08obMuB5klXZt3P7vM8Cgzyqz3T44PYaGilpOdCgJmOKEyJDqPO
         4drgaivkoI03rCflfn5HUgNpbl5rnbz+p0mRfDDAG+MXTSJEk+tmulWtlWAljv0kKjN0
         zn/kQ2f4PtY2f1ZpGZOK8nl/XMzpONBx86+dVo8w8Iz8FtWbYQgBkWoT5fVVN9YOr6l+
         04l+xIJy7DSsEgEO+ddv1y54xtHj9TUooE0T6fcYxgeeBefV9Q4tIB2+w+Xs59ig/dkt
         1U8XWGmxmBLec4RDShjcNz50hbUpcntogTcSRAuXuE/JTFfUOhuHWr2QuqdbwyO3z0av
         ntSw==
X-Gm-Message-State: AC+VfDwZjYJBlV3E5ZRpxEkklhbH2LewFb1zKDd85oS/avWnrNUvIXWx
        xJWIPzd8oFcDpE8U9QCApk6j05iRR5edohnbtbE=
X-Google-Smtp-Source: ACHHUZ5tYw/+FcRpUECgAitYh/zC9TCY6uDCLqNVK14Gvoiqu/LnI5iFdPakDoYcpGjlOWGGit0p/w==
X-Received: by 2002:ac2:518e:0:b0:4f4:b864:1da0 with SMTP id u14-20020ac2518e000000b004f4b8641da0mr844057lfi.15.1685608071525;
        Thu, 01 Jun 2023 01:27:51 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id e18-20020ac25472000000b004efee5841b9sm990576lfn.290.2023.06.01.01.27.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 01:27:51 -0700 (PDT)
Message-ID: <4f4a4ec8-9dad-312f-0859-7469c8c25477@linaro.org>
Date:   Thu, 1 Jun 2023 10:27:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v4 3/4] arm64: dts: qcom: qdu1000: Add SDHCI pin
 configuration to DTSI
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230601065805.18079-1-quic_kbajaj@quicinc.com>
 <20230601065805.18079-4-quic_kbajaj@quicinc.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230601065805.18079-4-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org



On 1.06.2023 08:58, Komal Bajaj wrote:
> Add required pins for SDHCI, so that the interface can work reliably.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  arch/arm64/boot/dts/qcom/qdu1000.dtsi | 50 +++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index 6df07334f1d3..9f615f3368c2 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -1147,6 +1147,56 @@
>  				pins = "gpio31";
>  				function = "gpio";
>  			};
> +
> +			sdc_on_state: sdc-on-state {
> +				clk-pins {
> +					pins = "sdc1_clk";
> +					drive-strength = <16>;
> +					bias-disable;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc1_cmd";
> +					drive-strength = <10>;
> +					bias-pull-up;
> +				};
> +
> +				data-pins {
> +					pins = "sdc1_data";
> +					drive-strength = <10>;
> +					bias-pull-up;
> +				};
> +
> +				rclk-pins {
> +					pins = "sdc1_rclk";
> +					bias-pull-down;
> +				};
> +			};
> +
> +			sdc_off_state: sdc-off-state {
> +				clk-pins {
> +					pins = "sdc1_clk";
> +					drive-strength = <2>;
> +					bias-disable;
> +				};
> +
> +				cmd-pins {
> +					pins = "sdc1_cmd";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +
> +				data-pins {
> +					pins = "sdc1_data";
> +					drive-strength = <2>;
> +					bias-pull-up;
> +				};
> +
> +				rclk-pins {
> +					pins = "sdc1_rclk";
> +					bias-pull-down;
> +				};
> +			};
>  		};
> 
>  		apps_smmu: iommu@15000000 {
> --
> 2.17.1
> 
