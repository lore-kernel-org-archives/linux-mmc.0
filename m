Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1671DA604
	for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726231569; cv=none; b=ZYAMtqKdhwu2e+BGYDN+ghgBcSivWIuJ9Kg6DVWaOe1PCQtVpa0JjPPkunY9clZoRLOXpQYVkRd+HzVAOeNUNC6MvsNNyTVOMuHUEC7kEKAU47qihhJNxSPLQrq9MuJIXwQJ9PYMb5OP8vpDxIvjVMEoyBHstfCdlIOOl38Q/To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726231569; c=relaxed/simple;
	bh=k4I+h9p8qlPxI/nee5eI3avO7EyK+/Al+hsQ3WMB/Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0k2zokStIG8KhZb/rpAmPyvGZwqTUkDgQGiEDB1Jum0hQkXtBn9272sOuDfodcEpWBhUNs/1uSqVUYAL9oCHs1rZvSMXtcTw+S91PNHrPZPEOglNUJ+hkReOXGBuBFEMOMApC4V/TrjywRKQfmS6t4tq8TtcdF7ze6PqzXWSsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yuegq1bF; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yuegq1bF"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53661a131b4so1250371e87.1
        for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2024 05:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726231566; x=1726836366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PcAubcOov151SdzKdER+0sQbvfB9Ja2dL7QLhCwoy90=;
        b=yuegq1bFaLXGYzX4iGzi+s5PyfAxjgoyeS7pO2lXzp7zEtv+67/3x6nqfIK40+xhXs
         iVWuYJzEgxmhTJNz886F28aFY4rl+UUcUYRQhnVjVQcXpeVRSwI2SGFXLeNEmoZW01fY
         oBYGj2zy9qEuSZst/+k+TTmWOK4p1qRashKQ83n3Hac6UXFYCmEtvV3721vzKI3jevm0
         UrKUK2JnsIczsuwjHAoN1M9agMFynPEn8fT7OIeo8sk13WnzR5UoKyTjBKISddeNpzQn
         mLzioAbnbuGHyeXK0wMifcxqQYinRNGYZdRWd6AX7lp6NxVTp5m6g7HE5fKLzeAZJq35
         NGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726231566; x=1726836366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PcAubcOov151SdzKdER+0sQbvfB9Ja2dL7QLhCwoy90=;
        b=MJAZ8TZoyEMviQhhGiMmLOpCrUC+0b9OXBOmyorNMIpDRKpsdFmMXOq2zjOscwbxSG
         ze2huzILcqoi7j6PK4IGcgOg8UreEyUnrofWkq6aK9PwA4mUyb4WB6Jlpl1xfPBy3ugI
         YY+Iep/DW7Ef+SYkEOJqIXRlXS14TAVbC1sh136vsx510ha2xJzDsgIkMhPFcrcyPcQ4
         f0clOOnWuhccCdrxIRZA++VahrcUCqVSgzqlBjNHE1M+CZ5likIACatPNPUOPNdQREvf
         hJpsx0wUvzjTMwYkUCYNpXIbsg2uvDzccKziRBjHIzYbHjVqTEZrOIjCBpUwxmvsV1Jf
         tCyw==
X-Forwarded-Encrypted: i=1; AJvYcCWoWRKgOnox5OVuCnJhIEp3XXqe4MhMMF4++ddH0ASELD4JVMRMsTuACDHGIW9h67CDaeMY18KTRiI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqvasx4XceBRCvr8C7Fm48FK3nazlfUZGa34sXXq6n+0bF2Vph
	g/dD+ZTCQDdPKutayBPE/VEv+vQ98lB9vXzfOQyKqsc5djKLtwijRSkGllrDILg=
X-Google-Smtp-Source: AGHT+IHmErpNFQ3nmrD3cPKNiJWs1W6U/NpBihW5TQBfdX7Yx5XqRmfHjJDVCkKy1cSAbjd49Qbg9Q==
X-Received: by 2002:a05:6512:3ca1:b0:535:66ff:c681 with SMTP id 2adb3069b0e04-5367ff24f82mr1911959e87.48.1726231565562;
        Fri, 13 Sep 2024 05:46:05 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f86925asm2263519e87.31.2024.09.13.05.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:46:05 -0700 (PDT)
Date: Fri, 13 Sep 2024 15:46:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	ulf.hansson@linaro.org, linus.walleij@linaro.org, catalin.marinas@arm.com, 
	p.zabel@pengutronix.de, geert+renesas@glider.be, neil.armstrong@linaro.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, quic_varada@quicinc.com
Subject: Re: [PATCH 5/8] clk: qcom: add Global Clock controller (GCC) driver
 for IPQ5424 SoC
Message-ID: <glkvcne5eius5l7dro7gzd7hyztc6vc4eekcbbxz6c4wwolwqy@aoj66qbrxezg>
References: <20240913121250.2995351-1-quic_srichara@quicinc.com>
 <20240913121250.2995351-6-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913121250.2995351-6-quic_srichara@quicinc.com>

On Fri, Sep 13, 2024 at 05:42:47PM GMT, Sricharan R wrote:
> From: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> 
> Add support for the global clock controller found on IPQ5424 SoC.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Same comment regarding tags.

> ---
>  drivers/clk/qcom/Kconfig       |    7 +
>  drivers/clk/qcom/Makefile      |    1 +
>  drivers/clk/qcom/gcc-ipq5424.c | 3333 ++++++++++++++++++++++++++++++++
>  3 files changed, 3341 insertions(+)
>  create mode 100644 drivers/clk/qcom/gcc-ipq5424.c
> 
> diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> index a3e2a09e2105..c41e3318c2a7 100644
> --- a/drivers/clk/qcom/Kconfig
> +++ b/drivers/clk/qcom/Kconfig
> @@ -213,6 +213,13 @@ config IPQ_GCC_5332
>  	  Say Y if you want to use peripheral devices such as UART, SPI,
>  	  i2c, USB, SD/eMMC, etc.
>  
> +config IPQ_GCC_5424
> +	tristate "IPQ5424 Global Clock Controller"
> +	help
> +	  Support for the global clock controller on ipq5424 devices.
> +	  Say Y if you want to use peripheral devices such as UART, SPI,
> +	  i2c, USB, SD/eMMC, etc.
> +
>  config IPQ_GCC_6018
>  	tristate "IPQ6018 Global Clock Controller"
>  	help
> diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
> index 2b378667a63f..d58ba0f9a482 100644
> --- a/drivers/clk/qcom/Makefile
> +++ b/drivers/clk/qcom/Makefile
> @@ -32,6 +32,7 @@ obj-$(CONFIG_IPQ_APSS_6018) += apss-ipq6018.o
>  obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
>  obj-$(CONFIG_IPQ_GCC_5018) += gcc-ipq5018.o
>  obj-$(CONFIG_IPQ_GCC_5332) += gcc-ipq5332.o
> +obj-$(CONFIG_IPQ_GCC_5424) += gcc-ipq5424.o
>  obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
>  obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
>  obj-$(CONFIG_IPQ_GCC_8074) += gcc-ipq8074.o
> diff --git a/drivers/clk/qcom/gcc-ipq5424.c b/drivers/clk/qcom/gcc-ipq5424.c
> new file mode 100644
> index 000000000000..72d2c9bfa986
> --- /dev/null
> +++ b/drivers/clk/qcom/gcc-ipq5424.c
> @@ -0,0 +1,3333 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018,2020 The Linux Foundation. All rights reserved.
> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <dt-bindings/clock/qcom,ipq5424-gcc.h>
> +#include <dt-bindings/reset/qcom,ipq5424-gcc.h>
> +
> +#include "clk-alpha-pll.h"
> +#include "clk-branch.h"
> +#include "clk-rcg.h"
> +#include "clk-regmap.h"
> +#include "clk-regmap-divider.h"
> +#include "clk-regmap-mux.h"
> +#include "clk-regmap-phy-mux.h"
> +#include "common.h"
> +#include "reset.h"
> +
> +enum {
> +	DT_XO,
> +	DT_SLEEP_CLK,
> +	DT_PCIE30_PHY0_PIPE_CLK,
> +	DT_PCIE30_PHY1_PIPE_CLK,
> +	DT_PCIE30_PHY2_PIPE_CLK,
> +	DT_PCIE30_PHY3_PIPE_CLK,
> +	DT_USB_PCIE_WRAPPER_PIPE_CLK,

This doesn't seem to match bindings.

> +};
> +
> +enum {
> +	P_GCC_GPLL0_OUT_MAIN_DIV_CLK_SRC,
> +	P_GPLL0_OUT_AUX,
> +	P_GPLL0_OUT_MAIN,
> +	P_GPLL2_OUT_AUX,
> +	P_GPLL2_OUT_MAIN,
> +	P_GPLL4_OUT_AUX,
> +	P_GPLL4_OUT_MAIN,
> +	P_SLEEP_CLK,
> +	P_XO,
> +	P_USB3PHY_0_PIPE,
> +};
> +
> +static const struct clk_parent_data gcc_parent_data_xo = { .index = DT_XO };
> +
> +static struct clk_alpha_pll gpll0 = {
> +	.offset = 0x20000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
> +	.clkr = {
> +		.enable_reg = 0xb000,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpll0",
> +			.parent_data = &gcc_parent_data_xo,
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_ops,
> +			.flags = CLK_IS_CRITICAL,

This deserves a comment

> +		},
> +	},
> +};
> +
> +static struct clk_fixed_factor gpll0_div2 = {
> +	.mult = 1,
> +	.div = 2,
> +	.hw.init = &(const struct clk_init_data) {
> +		.name = "gpll0_div2",
> +		.parent_hws = (const struct clk_hw *[]) {
> +			&gpll0.clkr.hw
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_fixed_factor_ops,
> +	},
> +};
> +
> +static struct clk_alpha_pll gpll2 = {
> +	.offset = 0x21000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_NSS_HUAYRA],
> +	.clkr = {
> +		.enable_reg = 0xb000,
> +		.enable_mask = BIT(1),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpll2",
> +			.parent_data = &gcc_parent_data_xo,
> +			.num_parents = 1,
> +			.ops = &clk_alpha_pll_ops,
> +		},
> +	},
> +};
> +
> +static const struct clk_div_table post_div_table_gpll2_out_main[] = {
> +	{ 0x1, 2 },
> +	{ }
> +};
> +
> +static struct clk_alpha_pll_postdiv gpll2_out_main = {
> +	.offset = 0x21000,
> +	.post_div_table = post_div_table_gpll2_out_main,
> +	.num_post_div = ARRAY_SIZE(post_div_table_gpll2_out_main),
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_NSS_HUAYRA],
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gpll2_out_main",
> +		.parent_hws = (const struct clk_hw*[]) {
> +			&gpll2.clkr.hw,
> +		},
> +		.num_parents = 1,
> +		.ops = &clk_alpha_pll_postdiv_ro_ops,
> +	},
> +};
> +
> +static struct clk_alpha_pll gpll4 = {
> +	.offset = 0x22000,
> +	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT_EVO],
> +	.clkr = {
> +		.enable_reg = 0xb000,
> +		.enable_mask = BIT(2),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gpll4",
> +			.parent_data = &gcc_parent_data_xo,
> +			.num_parents = 1,
> +			.flags = CLK_IS_CRITICAL,

Comment, please.

> +			.ops = &clk_alpha_pll_ops,
> +		},
> +	},
> +};
> +

[skipped]

> +
> +static struct clk_rcg2 gcc_pcnoc_bfdcd_clk_src = {
> +	.cmd_rcgr = 0x31004,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_parent_map_0,
> +	.freq_tbl = ftbl_gcc_pcnoc_bfdcd_clk_src,
> +	.clkr.hw.init = &(const struct clk_init_data) {
> +		.name = "gcc_pcnoc_bfdcd_clk_src",
> +		.parent_data = gcc_parent_data_0,
> +		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
> +		.flags = CLK_IS_CRITICAL,

Comment

> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +

[skipped]

> +
> +static struct clk_branch gcc_qdss_dap_clk = {
> +	.halt_reg = 0x2d058,
> +	.clkr = {
> +		.enable_reg = 0x2d058,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_qdss_dap_clk",
> +			.parent_hws = (const struct clk_hw *[]) {
> +				&gcc_qdss_dap_sync_clk_src.hw
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,

Comment

> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
> +static struct clk_branch gcc_qdss_at_clk = {
> +	.halt_reg = 0x2d034,
> +	.clkr = {
> +		.enable_reg = 0x2d034,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(const struct clk_init_data) {
> +			.name = "gcc_qdss_at_clk",
> +			.parent_hws = (const struct clk_hw *[]) {
> +				&gcc_qdss_at_clk_src.clkr.hw
> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,

Comment

> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +

[skipped]

> +
> +static int gcc_ipq5424_probe(struct platform_device *pdev)
> +{
> +	struct regmap *regmap;
> +	struct qcom_cc_desc ipq5424_desc = gcc_ipq5424_desc;
> +	int ret;
> +
> +	regmap = qcom_cc_map(pdev, &ipq5424_desc);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = qcom_cc_really_probe(&pdev->dev, &ipq5424_desc, regmap);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to register GCC clocks ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	dev_info(&pdev->dev, "Registered GCC clocks\n");
> +
> +	return ret;

Drop all the cruft and use qcom_cc_probe() directly.

> +}
> +
> +static struct platform_driver gcc_ipq5424_driver = {
> +	.probe = gcc_ipq5424_probe,
> +	.driver = {
> +		.name   = "qcom,gcc-ipq5424",
> +		.of_match_table = gcc_ipq5424_match_table,
> +	},
> +};
> +
> +static int __init gcc_ipq5424_init(void)
> +{
> +	return platform_driver_register(&gcc_ipq5424_driver);
> +}
> +core_initcall(gcc_ipq5424_init);
> +
> +static void __exit gcc_ipq5424_exit(void)
> +{
> +	platform_driver_unregister(&gcc_ipq5424_driver);
> +}
> +module_exit(gcc_ipq5424_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. GCC IPQ5424 Driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
