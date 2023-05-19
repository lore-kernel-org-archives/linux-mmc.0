Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF54C77B75
	for <linux-mmc@archiver.kernel.org>; Fri, 19 May 2023 10:15:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjESKPq (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 19 May 2023 06:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjESKPp (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 19 May 2023 06:15:45 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41639E43
        for <linux-mmc@vger.kernel.org>; Fri, 19 May 2023 03:15:44 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1ae408f4d1aso24535635ad.0
        for <linux-mmc@vger.kernel.org>; Fri, 19 May 2023 03:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684491344; x=1687083344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ylo0BLiLHMimnGwbEKAmy5UwI760pNmz133+iY2EX80=;
        b=jYRgD1LfOzdrMF1zi2cwWMk5xekUG2l2wjsnhAbGE3S8O3LqNTLGA/1eQFFBfDE9d1
         fW/4MAB1GOb3BFoPtRfXm0ZGrmHnYbL46ozdL8q6Cv7zI9NamALOJ+U2o7fgsUElJlOt
         iOPG4gzxGTVXPUU1CAggF1LvDgXCIW8WItWHSDP8T7RuDlQSyz47NuKdxzX3c8LEi0pb
         NiCZLkoK9JQmz8VL7XewO/6vqbYADa6DLEG04TvwptaTxZqSKsnWCuj4KoFQmcVYMQx8
         xyHsWu5A/waUMal0sAeTFGoBXBmqiIXKRADXJStS33vR2fYRcJQBK++caEmokiujLcHN
         tJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684491344; x=1687083344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylo0BLiLHMimnGwbEKAmy5UwI760pNmz133+iY2EX80=;
        b=As7+1ZZ1gilfVdjU6GMTkJA6STr0guIcRJmqQexVwmKlRiOll+sqdGqNAVRoYP6mkn
         BMz50Xeks5uMVWN/L5Y8/n3BtcOgc+Q4T5EiiXII8tRyaZOdh08qtQ1FwKHfnLnf1gHS
         VFFWxOBCsaMXdfyFTOnCJ2+LhdEX7vdgUy0gRhg6eTkCdKP/u5XRoiTeryWIWc3ZinAJ
         VDlOxg3mziEGZY2KGP6/4W96HGvVQFfC/85oKBpFtzTdtAmNRn99hhIMVBnoTJHKf+/d
         OX2XmEUM9wFna2+M0Q6a/ijW7Zy+ynDJPGVUBuApHNlscmvtyhYPYu/AsScdK5Vuae//
         PsOw==
X-Gm-Message-State: AC+VfDy3VgdQ5m12WTwYzE5eITMwkZLNF95gKWvC1C9h19pOC2+2Au4y
        l2/JvdPsMCevpHiecqngkYQYsw==
X-Google-Smtp-Source: ACHHUZ512MKsw7qshc+IsaVgyWhGa8nzHkG4bOmOmgqecRqpTMd8iDObkkAmxyQ1XV1TFv80d5/aOQ==
X-Received: by 2002:a17:902:ba8c:b0:1ae:6290:26d with SMTP id k12-20020a170902ba8c00b001ae6290026dmr2213537pls.7.1684491343711;
        Fri, 19 May 2023 03:15:43 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:d309:883d:817e:8e91:be39? ([2401:4900:1c60:d309:883d:817e:8e91:be39])
        by smtp.gmail.com with ESMTPSA id w24-20020a170902a71800b001a80ad9c599sm3011525plq.294.2023.05.19.03.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 03:15:43 -0700 (PDT)
Message-ID: <4419a3a5-f6b0-967b-7477-4c0b22c48204@linaro.org>
Date:   Fri, 19 May 2023 15:45:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 3/4] arm64: dts: qcom: qdu1000: Add SDHCI1 pin
 configuration to DTSI
Content-Language: en-US
To:     Komal Bajaj <quic_kbajaj@quicinc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230519085122.15758-1-quic_kbajaj@quicinc.com>
 <20230519085122.15758-4-quic_kbajaj@quicinc.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230519085122.15758-4-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 5/19/23 2:21 PM, Komal Bajaj wrote:
> Add required pins for SDHCI1, so that the interface can work reliably.
> 
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---
>   arch/arm64/boot/dts/qcom/qdu1000.dtsi | 50 +++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qdu1000.dtsi b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> index 6113def66a08..556942bfca5d 100644
> --- a/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qdu1000.dtsi
> @@ -1160,6 +1160,56 @@
>   				pins = "gpio31";
>   				function = "gpio";
>   			};
> +
> +			sdc1_on_state: sdc1-on-state {
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
> +			sdc1_off_state: sdc1-off-state {
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
>   		};
> 
>   		apps_smmu: iommu@15000000 {
> --
> 2.17.1

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
