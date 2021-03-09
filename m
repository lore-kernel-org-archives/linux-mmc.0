Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 786E1C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 21:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C4F66523B
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 21:01:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhCIVAn (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 16:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbhCIVAN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 16:00:13 -0500
X-Greylist: delayed 573 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Mar 2021 13:00:12 PST
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D993AC06174A
        for <linux-mmc@vger.kernel.org>; Tue,  9 Mar 2021 13:00:12 -0800 (PST)
Received: from [192.168.1.101] (abac94.neoplus.adsl.tpnet.pl [83.6.166.94])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 8F1813EB31;
        Tue,  9 Mar 2021 21:50:33 +0100 (CET)
Subject: Re: [PATCH V1] arm64: dts: qcom: sc7280: Add nodes for eMMC and SD
 card
To:     Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        robh+dt@kernel.org, sartgarg@codeaurora.org
Cc:     asutoshd@codeaurora.org, stummala@codeaurora.org,
        vbadigan@codeaurora.org, rampraka@codeaurora.org,
        sayalil@codeaurora.org, rnayak@codeaurora.org,
        saiprakash.ranjan@codeaurora.org, sibis@codeaurora.org,
        cang@codeaurora.org, pragalla@codeaurora.org,
        nitirawa@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org
References: <1615317483-23780-1-git-send-email-sbhanu@codeaurora.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
Message-ID: <9346cc73-297a-6bd8-1d0f-c09027ebcced@somainline.org>
Date:   Tue, 9 Mar 2021 21:50:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615317483-23780-1-git-send-email-sbhanu@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi!


> +
> +&sdhc_1 {
> +	status = "okay";
> +
> +	pinctrl-names = "default", "sleep";
> +	pinctrl-0 = <&sdc1_on>;
> +	pinctrl-1 = <&sdc1_off>;
> +
> +	vmmc-supply = <&vreg_l7b_2p9>;
> +	vqmmc-supply = <&vreg_l19b_1p8>;
> +

Redundant newline, please remove


> +
> +			mmc-ddr-1_8v;
> +			mmc-hs200-1_8v;
> +			mmc-hs400-1_8v;
> +			mmc-hs400-enhanced-strobe;
> +
> +			status = "disabled";
> +

Redundant newline, please remove


> +		};
> +
> +		sdhc_2: sdhci@8804000 {
> +			compatible = "qcom,sdhci-msm-v5";
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
> +
> +			bus-width = <4>;
> +
> +			no-mmc;
> +			no-sdio;
> +
> +			max-frequency = <202000000>;
> +
> +			qcom,dll-config = <0x0007642c>;
> +
> +			status = "disabled";
> +

Redundant newline, please remove


Konrad

