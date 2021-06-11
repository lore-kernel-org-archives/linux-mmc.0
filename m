Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D1AC48BD1
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 03:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 758F761076
	for <linux-mmc@archiver.kernel.org>; Fri, 11 Jun 2021 03:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFKDoo (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 10 Jun 2021 23:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhFKDoo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Jun 2021 23:44:44 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC926C061574
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jun 2021 20:42:46 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id q20-20020a4a6c140000b029024915d1bd7cso396227ooc.12
        for <linux-mmc@vger.kernel.org>; Thu, 10 Jun 2021 20:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aYl+CCoyEpsMle4Am2b97IzHogprDzY8kaWu6Mbbf1k=;
        b=AQ6vbyr9uNQZ+GHPLa2a1kit4Q4cIV37m1GMNQsiO76XCg+xTvGg37nilT7vPB7iko
         Ie/EgAkoebhsWPZvLxupC2BO6dQIl4MpmmNYAXFsiC+6ozWqoGgjtyk1NWkWTVDJA6tI
         2aY8uOFbjT2ceMUm/dvony/Votw9LUL4UflgZzPln1baaXyWdE1ORoJQqiZnVkOSygTy
         /4A/UrsjA5cexHv6XED3GfC5tBjULlHrX+FxQNESTErAKZmZaxGWvWrx4wOIHfS/W7oI
         gBYFfUseRNVK225E99XXl7Fo8m2cpB4DgmqG3yGa08AmSom9iF7CuEsTpDoEP28Ec7TM
         cJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aYl+CCoyEpsMle4Am2b97IzHogprDzY8kaWu6Mbbf1k=;
        b=ghw6OKpMrNfM8iQVgo+XvERJqCc1CK+4SNPwhRf2wfLjbgQVq4pPFiD2hoEBQn0exB
         cs6fcsbdwMp05PaejrW8vFOiu+gIC4oyc+sCtgXtjYPKuS3t2gnMQ/t5/hLLJjOsMa0K
         Xh8qL3XvgjevKzBFqqmusbsa0b5zdFOge9wdrGYdShqzI+/qxcDdcIY9lt7C76Dki8Xq
         o/4E0mtRie1zDn0bl6e5h6stfMdFkpIXrov9FCjwbbF6SM1wCGU3fY49MLwotxO2Ld4C
         cqleirUoPS7PwGDW1h39rt9yUDsiqEXcoijNM9A637NAAxG2P0b/mxCHzqaFqmu3c4hC
         vYNw==
X-Gm-Message-State: AOAM5323A8nkeJuJRdS6KZa3px7Imxnv91X1PjYiAvAIAAW5JzPNc0g/
        0CbIJRK9av0nktaKsPpK0+MraA==
X-Google-Smtp-Source: ABdhPJz1hwVQUMR6EXA0q0L7XAng8OjeIfRMjbd/FqCEHE5PEdjDIvGXYthGX7YwYlTji8HGftLSYw==
X-Received: by 2002:a4a:5182:: with SMTP id s124mr1334378ooa.34.1623382964450;
        Thu, 10 Jun 2021 20:42:44 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r25sm926969oos.44.2021.06.10.20.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 20:42:43 -0700 (PDT)
Date:   Thu, 10 Jun 2021 22:42:41 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>
Cc:     adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, asutoshd@codeaurora.org,
        stummala@codeaurora.org, vbadigan@codeaurora.org,
        rampraka@codeaurora.org, sayalil@codeaurora.org,
        sartgarg@codeaurora.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, sibis@codeaurora.org,
        okukatla@codeaurora.org, djakov@kernel.org, cang@codeaurora.org,
        pragalla@codeaurora.org, nitirawa@codeaurora.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        agross@kernel.org
Subject: Re: [PATCH V3] arm64: dts: qcom: sc7280: Add nodes for eMMC and SD
 card
Message-ID: <YMLbsZUojmYjM/j0@builder.lan>
References: <1623252028-20467-1-git-send-email-sbhanu@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623252028-20467-1-git-send-email-sbhanu@codeaurora.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed 09 Jun 10:20 CDT 2021, Shaik Sajida Bhanu wrote:

> Add nodes for eMMC and SD card on sc7280.
> 
> Signed-off-by: Shaik Sajida Bhanu <sbhanu@codeaurora.org>
> ---
> 
> This change is depends on the below patch series:
> https://lore.kernel.org/patchwork/cover/1418814/
> 
> Change since V2:
> 	- Added leading zero's for register address and "qcom,sc7280-sdhci"
> 	  string in compatible as suggested by Stephen Boyd and Doug.
> 	- Removed max-frequency flag, no-mmc and no-sdio flags for Sd
> 	  card as suggested by Doug and Stephen Boyd.
> 	- Moved non-removable, no-sd, no-sdio and some pin config changes
> 	  from soc to board dts file as suggested by Doug.
> 	- Removed sleep state for CD line and drive-strength for input pins
> 	  as suggested by Doug.
> 	- Updated bus vote numbers for eMMC and SD card.
> 
> Changes since V1:
> 	- Moved SDHC nodes as suggested by Bjorn Andersson.
> 	- Dropped "pinconf-" prefix as suggested by Bjorn
> 	  Andersson.
> 	- Removed extra newlines as suggested by Konrad
> 	  Dybcio.
> 	- Changed sd-cd pin to bias-pull-up in sdc2_off
>           as suggested by Veerabhadrarao Badiganti.
> 	- Added bandwidth votes for eMMC and SD card.
> ---
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts |  79 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi    | 146 ++++++++++++++++++++++++++++++++
>  2 files changed, 225 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> index 3900cfc..8b159d1 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
> @@ -11,6 +11,7 @@
>  #include <dt-bindings/iio/qcom,spmi-adc7-pmr735b.h>
>  #include <dt-bindings/iio/qcom,spmi-adc7-pm8350.h>
>  #include <dt-bindings/iio/qcom,spmi-adc7-pmk8350.h>
> +#include <dt-bindings/gpio/gpio.h>
>  #include "sc7280.dtsi"
>  #include "pm7325.dtsi"
>  #include "pmr735a.dtsi"
> @@ -272,6 +273,36 @@
>  	status = "okay";
>  };
>  
> +&sdhc_1 {
> +	status = "okay";
> +
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc1_clk &sdc1_cmd &sdc1_data &sdc1_rclk>;
> +	pinctrl-1 = <&sdc1_clk_sleep &sdc1_cmd_sleep &sdc1_data_sleep &sdc1_rclk_sleep>;
> +

Extra newline.

> +
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +
> +	vmmc-supply = <&vreg_l7b_2p9>;
> +	vqmmc-supply = <&vreg_l19b_1p8>;
> +

Extra newline.

> +};
> +
> +&sdhc_2 {
> +	status = "okay";
> +
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc2_clk &sdc2_cmd &sdc2_data &sd_cd>;
> +	pinctrl-1 = <&sdc2_clk_sleep &sdc2_cmd_sleep &sdc2_data_sleep>;
> +
> +	vmmc-supply = <&vreg_l9c_2p9>;
> +	vqmmc-supply = <&vreg_l6c_2p9>;
> +
> +	cd-gpios = <&tlmm 91 GPIO_ACTIVE_LOW>;
> +};
> +
>  &uart5 {
>  	status = "okay";
>  };
> @@ -291,3 +322,51 @@
>  		bias-pull-up;
>  	};
>  };
> +
> +&tlmm {
> +	sdc1_clk: sdc1-clk {
> +		pins = "sdc1_clk";
> +		bias-disable;
> +		drive-strength = <16>;
> +	};
> +
> +	sdc1_cmd: sdc1-cmd {
> +		pins = "sdc1_cmd";
> +		bias-pull-up;
> +		drive-strength = <10>;
> +	};
> +
> +	sdc1_data: sdc1-data {
> +		pins = "sdc1_data";
> +		bias-pull-up;
> +		drive-strength = <10>;
> +	};
> +	sdc1_rclk: sdc1-rclk {
> +		pins = "sdc1_rclk";
> +		bias-pull-down;
> +	};
> +
> +	sdc2_clk: sdc2-clk {
> +		pins = "sdc2_clk";
> +		bias-disable;
> +		drive-strength = <16>;
> +	};
> +
> +	sdc2_cmd: sdc2-cmd {
> +		pins = "sdc2_cmd";
> +		bias-pull-up;
> +		drive-strength = <10>;
> +	};
> +
> +	sdc2_data: sdc2-data {
> +		pins = "sdc2_data";
> +		bias-pull-up;
> +		drive-strength = <10>;
> +	};
> +
> +	sd_cd: sd-cd {
> +		pins = "gpio91";
> +		bias-pull-up;
> +	};

As Konrad pointed out, this is much cleaner described as:

	sdc1_default_state: sdc1-default-state {
		clk {
		};

		cmd {

		};

		data {

		};

		rclk {

		};
	};

> +
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0b6f119..eab6f7b 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -24,6 +24,11 @@
>  
>  	chosen { };
>  
> +	aliases {
> +		mmc1 = &sdhc_1;
> +		mmc2 = &sdhc_2;
> +	};
> +
>  	clocks {
>  		xo_board: xo-board {
>  			compatible = "fixed-clock";
> @@ -430,6 +435,60 @@
>  			#mbox-cells = <2>;
>  		};
>  
> +		sdhc_1: sdhci@7c4000 {
> +			compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
> +			status = "disabled";
> +
> +			reg = <0 0x007c4000 0 0x1000>,
> +					<0 0x007c5000 0 0x1000>;

Whenever you break lines, align your '<' on each line.

> +			reg-names = "hc", "cqhci";
> +
> +			iommus = <&apps_smmu 0xc0 0x0>;
> +			interrupts = <GIC_SPI 652 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 656 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC1_APPS_CLK>,
> +					<&gcc GCC_SDCC1_AHB_CLK>,
> +					<&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "core", "iface", "xo";
> +			interconnects = <&aggre1_noc MASTER_SDCC_1 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_SDCC_1 0>;
> +			interconnect-names = "sdhc-ddr","cpu-sdhc";
> +			power-domains = <&rpmhpd SC7280_CX>;
> +			operating-points-v2 = <&sdhc1_opp_table>;
> +
> +			bus-width = <8>;
> +			supports-cqe;
> +
> +			qcom,dll-config = <0x0007642c>;
> +			qcom,ddr-config = <0x80040868>;
> +
> +			mmc-ddr-1_8v;
> +			mmc-hs200-1_8v;
> +			mmc-hs400-1_8v;
> +			mmc-hs400-enhanced-strobe;
> +
> +			sdhc1_opp_table: sdhc1-opp-table {

No need for "sdhc1-" in the node name.

> +				compatible = "operating-points-v2";
> +
> +				opp-100000000 {
> +					opp-hz = /bits/ 64 <100000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <1800000 400000>;
> +					opp-avg-kBps = <100000 0>;
> +				};
> +
> +				opp-384000000 {
> +					opp-hz = /bits/ 64 <384000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <5400000 1600000>;
> +					opp-avg-kBps = <390000 0>;
> +				};
> +			};
> +
> +		};
> +
>  		qupv3_id_0: geniqup@9c0000 {
>  			compatible = "qcom,geni-se-qup";
>  			reg = <0 0x009c0000 0 0x2000>;
> @@ -973,6 +1032,51 @@
>  			};
>  		};
>  
> +		sdhc_2: sdhci@8804000 {
> +			compatible = "qcom,sc7280-sdhci", "qcom,sdhci-msm-v5";
> +			status = "disabled";
> +
> +			reg = <0 0x08804000 0 0x1000>;
> +
> +			iommus = <&apps_smmu 0x100 0x0>;
> +			interrupts = <GIC_SPI 207 IRQ_TYPE_LEVEL_HIGH>,
> +					<GIC_SPI 223 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&gcc GCC_SDCC2_APPS_CLK>,
> +					<&gcc GCC_SDCC2_AHB_CLK>,
> +					<&rpmhcc RPMH_CXO_CLK>;
> +			clock-names = "core", "iface", "xo";
> +			interconnects = <&aggre1_noc MASTER_SDCC_2 0 &mc_virt SLAVE_EBI1 0>,
> +					<&gem_noc MASTER_APPSS_PROC 0 &cnoc2 SLAVE_SDCC_2 0>;
> +			interconnect-names = "sdhc-ddr","cpu-sdhc";
> +			power-domains = <&rpmhpd SC7280_CX>;
> +			operating-points-v2 = <&sdhc2_opp_table>;
> +
> +			bus-width = <4>;
> +
> +			qcom,dll-config = <0x0007642c>;
> +
> +			sdhc2_opp_table: sdhc2-opp-table {
> +				compatible = "operating-points-v2";
> +
> +				opp-100000000 {
> +					opp-hz = /bits/ 64 <100000000>;
> +					required-opps = <&rpmhpd_opp_low_svs>;
> +					opp-peak-kBps = <1800000 400000>;
> +					opp-avg-kBps = <100000 0>;
> +				};
> +
> +				opp-202000000 {
> +					opp-hz = /bits/ 64 <202000000>;
> +					required-opps = <&rpmhpd_opp_nom>;
> +					opp-peak-kBps = <5400000 1600000>;
> +					opp-avg-kBps = <200000 0>;
> +				};
> +			};
> +
> +		};
> +
>  		system-cache-controller@9200000 {
>  			compatible = "qcom,sc7280-llcc";
>  			reg = <0 0x09200000 0 0xd0000>, <0 0x09600000 0 0x50000>;
> @@ -1102,6 +1206,48 @@
>  				pins = "gpio46", "gpio47";
>  				function = "qup13";
>  			};
> +
> +			sdc1_clk_sleep: sdc1-clk-sleep {
> +				pins = "sdc1_clk";
> +				drive-strength = <2>;
> +				bias-bus-hold;
> +			};
> +
> +			sdc1_cmd_sleep: sdc1-cmd-sleep {
> +				pins = "sdc1_cmd";
> +				drive-strength = <2>;
> +				bias-bus-hold;
> +			};
> +
> +			sdc1_data_sleep: sdc1-data-sleep {
> +				pins = "sdc1_data";
> +				drive-strength = <2>;
> +				bias-bus-hold;
> +			};
> +
> +			sdc1_rclk_sleep: sdc1-rclk-sleep {
> +				pins = "sdc1_rclk";
> +				bias-bus-hold;
> +			};
> +
> +			sdc2_clk_sleep: sdc2-clk-sleep {
> +				pins = "sdc2_clk";
> +				drive-strength = <2>;
> +				bias-bus-hold;
> +			};
> +
> +			sdc2_cmd_sleep: sdc2-cmd-sleep{
> +				pins ="sdc2_cmd";
> +				drive-strength = <2>;
> +				bias-bus-hold;
> +			};
> +
> +			sdc2_data_sleep: sdc2-data-sleep {
> +				pins ="sdc2_data";
> +				drive-strength = <2>;
> +				bias-bus-hold;
> +			};

Please structure these as suggested above.

> +

And please drop this empty line.

Thanks,
Bjorn

>  		};
>  
>  		apps_smmu: iommu@15000000 {
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
