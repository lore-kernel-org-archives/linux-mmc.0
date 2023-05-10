Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3A4C77B7D
	for <linux-mmc@archiver.kernel.org>; Wed, 10 May 2023 14:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237448AbjEJOZt (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 10 May 2023 10:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237248AbjEJOZn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 May 2023 10:25:43 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BBBDD89
        for <linux-mmc@vger.kernel.org>; Wed, 10 May 2023 07:25:12 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 6ec4a200-ef3e-11ed-a9de-005056bdf889;
        Wed, 10 May 2023 17:24:54 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Wed, 10 May 2023 17:24:54 +0300
To:     Sricharan Ramabadhran <quic_srichara@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org,
        linus.walleij@linaro.org, catalin.marinas@arm.com, will@kernel.org,
        p.zabel@pengutronix.de, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 4/8] pinctrl: qcom: Add IPQ5018 pinctrl driver
Message-ID: <ZFupNrdrcsrIFpYq@surfacebook>
References: <20230510134121.1232286-1-quic_srichara@quicinc.com>
 <20230510134121.1232286-5-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510134121.1232286-5-quic_srichara@quicinc.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Wed, May 10, 2023 at 07:11:17PM +0530, Sricharan Ramabadhran kirjoitti:
> Add pinctrl definitions for the TLMM of IPQ5018.

...

> +#define FUNCTION(fname)			                \
> +	[msm_mux_##fname] = {		                \
> +		.name = #fname,				\
> +		.groups = fname##_groups,               \
> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
> +	}

Can you coordinate with Rohit Agarwal <quic_rohiagar@quicinc.com> and use
his work [1] which moves the QCom drivers to use struct pingroup and struct
pinfunction?

[1]: https://lore.kernel.org/r/1683718725-14869-1-git-send-email-quic_rohiagar@quicinc.com

...

> +static const struct of_device_id ipq5018_pinctrl_of_match[] = {
> +	{ .compatible = "qcom,ipq5018-tlmm", },

> +	{ },

No comma for the terminator entry.

> +};

Move MODULE_DEVICE_TABLE() here.

-- 
With Best Regards,
Andy Shevchenko


