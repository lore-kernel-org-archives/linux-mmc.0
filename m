Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9763CA0ECA
	for <linux-mmc@archiver.kernel.org>; Tue, 12 Sep 2023 13:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjILNUR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 12 Sep 2023 09:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235500AbjILNUQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Sep 2023 09:20:16 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6D010CA
        for <linux-mmc@vger.kernel.org>; Tue, 12 Sep 2023 06:20:11 -0700 (PDT)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C85563F63D
        for <linux-mmc@vger.kernel.org>; Tue, 12 Sep 2023 13:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1694524809;
        bh=Sf56SkwawGpbC/RXPSnmT5Ux3keGTDqMFdPqD5kK9Z4=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=O0qtfvA/Dr9x7CWNrHDBntzk5TKybBarsUQKGf4ap/xA3xGF4OWpqxi5P7rV67YDt
         B4belnNHzsoNrzuU/eogwYa5jcrVQVd9exFkbh/EKJ5ctE3VRQBiLD5uPPEEGXQ/Mo
         cCe+5pcq2L9iveev0fk3WV+NISWCjA6J4Y8bUJOeqprLYi4aRa8GeODc7UPwhurP7Y
         +CNYnJXIckHlD8ZaV8J1QntZfuNwrKyy+7h9y68ahDR8aIzN1PepIDxj7l9UlZkeEz
         GWch2L1gRTi9anCKC1Jpg8W2obOqYS7FsfKRgzMutaq+fOJ3rzvMmdKMAmyfqhS/yx
         9J3PJ2EcLpsBQ==
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3aa172b512eso7000415b6e.3
        for <linux-mmc@vger.kernel.org>; Tue, 12 Sep 2023 06:20:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694524808; x=1695129608;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sf56SkwawGpbC/RXPSnmT5Ux3keGTDqMFdPqD5kK9Z4=;
        b=nII8WtFPJlwg5ge5ewK2AlfCyrgq4s0ZlzIedqoxM+oKBF38jTYOwF3DHPTDOGz9+i
         kyP0k00xyjTnrWr9Ur5CqQvAq/lQQxmlLULzwGKMN00Qpfv+3woTxtmTpHU3B2pVOIEi
         APhAbaF6RlcZPqm8mMtTnSLCWo3CRLrLrdYbJP5mYRlO78EXcnW/+Tz2X9LwEL3MFA6O
         ccNYb0Rj52Jb0NTMTPGD/Sp7LrVL5TX60F5+ebTOIJP8j3AdDd2mb6dZYVm9u/htL/hm
         rTzskH/4MhYrfNeP1/3hyuiT1/BTQEOlNOuWKzhnot3HlqWK+q5bj32fkNmCJ5WCCzRY
         GjlQ==
X-Gm-Message-State: AOJu0YwAggo5IBv3GbAXzCj0pdJeIgoF4HJA7J18z/z0WxVIGIFQPpoO
        q36rx0Ko0X2jK+9Y+IwgYlam8NNp9nZWzEzloqDTQDMxS3GV0AqgC7kWVh4uBGRWKvY5V3HIzJw
        RPBdItnZufxFORYqy0+WXzJJtfKLSwd/EpL40kG99L18jYGHN5i+8Zw==
X-Received: by 2002:a54:4101:0:b0:3a4:1f0f:d108 with SMTP id l1-20020a544101000000b003a41f0fd108mr14393049oic.46.1694524808655;
        Tue, 12 Sep 2023 06:20:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4tqK3LNB3nC4RtCAQYbX1Quh3QzmjM4JzXHKI7S/+TjQFf7rCkw4++4RrSzzbyNfkzEgQDnrmo7gpHJADav4=
X-Received: by 2002:a54:4101:0:b0:3a4:1f0f:d108 with SMTP id
 l1-20020a544101000000b003a41f0fd108mr14393037oic.46.1694524808389; Tue, 12
 Sep 2023 06:20:08 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 12 Sep 2023 06:20:07 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20230912081402.51477-6-william.qiu@starfivetech.com>
References: <20230912081402.51477-1-william.qiu@starfivetech.com> <20230912081402.51477-6-william.qiu@starfivetech.com>
Mime-Version: 1.0
Date:   Tue, 12 Sep 2023 06:20:07 -0700
Message-ID: <CAJM55Z9riu4vwfgri1a4UsAtCmTeatVhKCGA3LAtTXsHsddtXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: starfive: Change tuning implementation
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mmc@vger.kernel.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Rob Herring <robh+dt@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

William Qiu wrote:
> Before, we used syscon to achieve tuning, but the actual measurement
> showed little effect, so the tuning implementation was modified here,
> and it was realized by reading and writing the UHS_REG_EXT register.
>
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> ---
>  drivers/mmc/host/dw_mmc-starfive.c | 137 +++++++++--------------------
>  1 file changed, 40 insertions(+), 97 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
> index fd05a648a8bb..ad8f39c62fed 100644
> --- a/drivers/mmc/host/dw_mmc-starfive.c
> +++ b/drivers/mmc/host/dw_mmc-starfive.c
> @@ -5,6 +5,7 @@
>   * Copyright (c) 2022 StarFive Technology Co., Ltd.
>   */
>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/mfd/syscon.h>
> @@ -20,13 +21,7 @@
>  #define ALL_INT_CLR		0x1ffff
>  #define MAX_DELAY_CHAIN		32
>
> -struct starfive_priv {
> -	struct device *dev;
> -	struct regmap *reg_syscon;
> -	u32 syscon_offset;
> -	u32 syscon_shift;
> -	u32 syscon_mask;
> -};
> +#define STARFIVE_SMPL_PHASE     GENMASK(20, 16)
>
>  static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
> @@ -44,117 +39,65 @@ static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  	}
>  }
>
> +static void dw_mci_starfive_set_sample_phase(struct dw_mci *host, u32 smpl_phase)
> +{
> +	/* change driver phase and sample phase */
> +	u32 reg_value = mci_readl(host, UHS_REG_EXT);
> +
> +	/* In UHS_REG_EXT, only 5 bits valid in DRV_PHASE and SMPL_PHASE */
> +	reg_value &= ~STARFIVE_SMPL_PHASE;
> +	reg_value |= FIELD_PREP(STARFIVE_SMPL_PHASE, smpl_phase);
> +	mci_writel(host, UHS_REG_EXT, reg_value);
> +
> +	/* We should delay 1ms wait for timing setting finished. */
> +	mdelay(1);
> +}
> +
>  static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
>  					     u32 opcode)
>  {
>  	static const int grade  = MAX_DELAY_CHAIN;
>  	struct dw_mci *host = slot->host;
> -	struct starfive_priv *priv = host->priv;
> -	int rise_point = -1, fall_point = -1;
> -	int err, prev_err = 0;
> -	int i;
> -	bool found = 0;
> -	u32 regval;
> -
> -	/*
> -	 * Use grade as the max delay chain, and use the rise_point and
> -	 * fall_point to ensure the best sampling point of a data input
> -	 * signals.
> -	 */
> -	for (i = 0; i < grade; i++) {
> -		regval = i << priv->syscon_shift;
> -		err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
> -						priv->syscon_mask, regval);
> -		if (err)
> -			return err;
> +	int smpl_phase, smpl_raise = -1, smpl_fall = -1;
> +	int ret;
> +
> +	for (smpl_phase = 0; smpl_phase < grade; smpl_phase++) {
> +		dw_mci_starfive_set_sample_phase(host, smpl_phase);
>  		mci_writel(host, RINTSTS, ALL_INT_CLR);
>
> -		err = mmc_send_tuning(slot->mmc, opcode, NULL);
> -		if (!err)
> -			found = 1;
> +		ret = mmc_send_tuning(slot->mmc, opcode, NULL);
>
> -		if (i > 0) {
> -			if (err && !prev_err)
> -				fall_point = i - 1;
> -			if (!err && prev_err)
> -				rise_point = i;
> +		if (!ret && smpl_raise < 0) {
> +			smpl_raise = smpl_phase;
> +		} else if (ret && smpl_raise >= 0) {
> +			smpl_fall = smpl_phase - 1;
> +			break;
>  		}
> -
> -		if (rise_point != -1 && fall_point != -1)
> -			goto tuning_out;
> -
> -		prev_err = err;
> -		err = 0;
>  	}
>
> -tuning_out:
> -	if (found) {
> -		if (rise_point == -1)
> -			rise_point = 0;
> -		if (fall_point == -1)
> -			fall_point = grade - 1;
> -		if (fall_point < rise_point) {
> -			if ((rise_point + fall_point) >
> -			    (grade - 1))
> -				i = fall_point / 2;
> -			else
> -				i = (rise_point + grade - 1) / 2;
> -		} else {
> -			i = (rise_point + fall_point) / 2;
> -		}
> -
> -		regval = i << priv->syscon_shift;
> -		err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
> -						priv->syscon_mask, regval);
> -		if (err)
> -			return err;
> -		mci_writel(host, RINTSTS, ALL_INT_CLR);
> +	if (smpl_phase >= grade && smpl_raise >= 0)
> +		smpl_fall = grade - 1;

If you switch the order of the two if's above and below you won't need the
smpl_raise >= 0 clause here. With that cleaned up:

Reviewed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>

>
> -		dev_info(host->dev, "Found valid delay chain! use it [delay=%d]\n", i);
> -	} else {
> +	if (smpl_raise < 0) {
> +		smpl_phase = 0;
>  		dev_err(host->dev, "No valid delay chain! use default\n");
> -		err = -EINVAL;
> +		ret = -EINVAL;
> +		goto out;
>  	}
>
> -	mci_writel(host, RINTSTS, ALL_INT_CLR);
> -	return err;
> -}
> -
> -static int dw_mci_starfive_parse_dt(struct dw_mci *host)
> -{
> -	struct of_phandle_args args;
> -	struct starfive_priv *priv;
> -	int ret;
> -
> -	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
> -	if (!priv)
> -		return -ENOMEM;
> +	smpl_phase = (smpl_raise + smpl_fall) / 2;
> +	dev_dbg(host->dev, "Found valid delay chain! use it [delay=%d]\n", smpl_phase);
> +	ret = 0;
>
> -	ret = of_parse_phandle_with_fixed_args(host->dev->of_node,
> -						"starfive,sysreg", 3, 0, &args);
> -	if (ret) {
> -		dev_err(host->dev, "Failed to parse starfive,sysreg\n");
> -		return -EINVAL;
> -	}
> -
> -	priv->reg_syscon = syscon_node_to_regmap(args.np);
> -	of_node_put(args.np);
> -	if (IS_ERR(priv->reg_syscon))
> -		return PTR_ERR(priv->reg_syscon);
> -
> -	priv->syscon_offset = args.args[0];
> -	priv->syscon_shift  = args.args[1];
> -	priv->syscon_mask   = args.args[2];
> -
> -	host->priv = priv;
> -
> -	return 0;
> +out:
> +	dw_mci_starfive_set_sample_phase(host, smpl_phase);
> +	mci_writel(host, RINTSTS, ALL_INT_CLR);
> +	return ret;
>  }
>
>  static const struct dw_mci_drv_data starfive_data = {
>  	.common_caps		= MMC_CAP_CMD23,
>  	.set_ios		= dw_mci_starfive_set_ios,
> -	.parse_dt		= dw_mci_starfive_parse_dt,
>  	.execute_tuning		= dw_mci_starfive_execute_tuning,
>  };
>
> --
> 2.34.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
