Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9A5CDB474
	for <linux-mmc@archiver.kernel.org>; Mon, 23 Oct 2023 11:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233703AbjJWLPF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 23 Oct 2023 07:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjJWLPD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Oct 2023 07:15:03 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF12A4
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 04:15:00 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9fe0a598d8so656495276.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2023 04:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698059699; x=1698664499; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6hu9rh6KgAvsKfYXXWL8zYTarr8RBDwNjZxBfWtY8rc=;
        b=jhJdqTgG6cuxZgiMwNG6i7xc7PU5cqdtV6LM1qD+GztmAFymK7qG5xFJmz3uIJC+KK
         hS65xNfgvvCvi7UMeXmnszp+eHXFOKD24oGaLgE/J9dsjRtxH25Zh+HJ6kl81himaf9F
         V8ZxLdxxdvnoTA1L91gSMN48R6DfMdJtfkSoYAo52os7K+7jhCIHrvQqFRIZx119vLx2
         zHRNEiDWWCLlfNPOOKtowb+wIghE9Br1o/gAEImZB6E26WHAziimA2nveYxOIvUngwpi
         5AEjzQojpTynXf8HOR3kYGKZCKYO0aeKqZI1yJIh7xfjF2ovyH/DlGvEC5mEvklnxoaa
         niIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698059699; x=1698664499;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hu9rh6KgAvsKfYXXWL8zYTarr8RBDwNjZxBfWtY8rc=;
        b=opk/S+GR6pj2AziyFCsDa+IEO2xQeitS4Ro8MF59uY8/pO6WbnhndQlSAxMCUviu4Q
         NqgR7eOuEb9cXaJAmdUtQpjn2DW28VeYurCSV2iKqanm8ZT64mmXkwCBSa7i4/R65f0s
         c4DQxmmJVKpVZ6U+1kceH64PikqIz6UHN9mkJAxiWAR0rHCVuvVR5rUM/wxudwkJJ2uV
         Tb0wbHh9kMlewNmOdnvnukDuttnmDrny2QsyTXka/joBZHqdm2+fTaPufqINt3MmLWXJ
         xKGiPV0AF9/7QGHQcfGh2j3KztgiuGFOtqUPKeUU5hLmCKJeNI/H8MOZe9sDS+0xeI4F
         ZfhA==
X-Gm-Message-State: AOJu0YyNqM0tA+goZwij7nIdvZrU3oQyTQuQl4mUR4ZIALkjKWcJ2q9V
        NHD9KAnfVtn7nG3ErI/Er1Lx0vFVzQ5rkA3euXhECw==
X-Google-Smtp-Source: AGHT+IHp30gB+Nvus0ZLdoTwDy/MryEBQA4AcnzU9gz/ai6P20jZzANHatsRweskKd+aafcJHUWnH2n5rq8Ic2Zl5eQ=
X-Received: by 2002:a5b:608:0:b0:d9a:e947:447b with SMTP id
 d8-20020a5b0608000000b00d9ae947447bmr8427971ybq.14.1698059699399; Mon, 23 Oct
 2023 04:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <TYZPR01MB5556B56D834E02F41C44D81DC95FA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
 <TYZPR01MB5556A3E71554A2EC08597EA4C9CDA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
In-Reply-To: <TYZPR01MB5556A3E71554A2EC08597EA4C9CDA@TYZPR01MB5556.apcprd01.prod.exchangelabs.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 23 Oct 2023 13:14:23 +0200
Message-ID: <CAPDyKFrLUf+dcZbPtXFncu_KO_SgzKSN1KCW8ds4=OUGpT8+Gg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: meson-mx-sdhc: Fix initialization frozen issue
To:     Ziyang Huang <hzyitc@outlook.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     neil.armstrong@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com,
        yinxin_1989@aliyun.com, briannorris@chromium.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Thorsten

On Tue, 10 Oct 2023 at 18:44, Ziyang Huang <hzyitc@outlook.com> wrote:
>
> Commit 4bc31edebde5 ("mmc: core: Set HS clock speed before sending
> HS CMD13") set HS clock (52MHz) before switching to HS mode. For this
> freq, FCLK_DIV5 will be selected and div value is 10 (reg value is 9).
> Then we set rx_clk_phase to 11 or 15 which is out of range and make
> hardware frozen. After we send command request, no irq will be
> interrupted and the mmc driver will keep to wait for request finished,
> even durning rebooting.
>
> So let's set it to Phase 90 which should work in most cases. Then let
> meson_mx_sdhc_execute_tuning() to find the accurate value for data
> transfer.
>
> If this doesn't work, maybe need to define a factor in dts.
>
> Fixes: e4bf1b0970ef ("mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host")
> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>

I have re-added Thorsten to see if he has some time to test this on his end.

Kind regards
Uffe

> ---
> Changes since v1:
>   Use Phase 90 instand of value 1
>
>  drivers/mmc/host/meson-mx-sdhc-mmc.c | 26 +++++---------------------
>  1 file changed, 5 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/mmc/host/meson-mx-sdhc-mmc.c b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> index 97168cdfa8e9..29698fceb89c 100644
> --- a/drivers/mmc/host/meson-mx-sdhc-mmc.c
> +++ b/drivers/mmc/host/meson-mx-sdhc-mmc.c
> @@ -269,7 +269,7 @@ static int meson_mx_sdhc_enable_clks(struct mmc_host *mmc)
>  static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
>  {
>         struct meson_mx_sdhc_host *host = mmc_priv(mmc);
> -       u32 rx_clk_phase;
> +       u32 val, rx_clk_phase;
>         int ret;
>
>         meson_mx_sdhc_disable_clks(mmc);
> @@ -290,27 +290,11 @@ static int meson_mx_sdhc_set_clk(struct mmc_host *mmc, struct mmc_ios *ios)
>                 mmc->actual_clock = clk_get_rate(host->sd_clk);
>
>                 /*
> -                * according to Amlogic the following latching points are
> -                * selected with empirical values, there is no (known) formula
> -                * to calculate these.
> +                * Phase 90 should work in most cases. For data transmission,
> +                * meson_mx_sdhc_execute_tuning() will find a accurate value
>                  */
> -               if (mmc->actual_clock > 100000000) {
> -                       rx_clk_phase = 1;
> -               } else if (mmc->actual_clock > 45000000) {
> -                       if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
> -                               rx_clk_phase = 15;
> -                       else
> -                               rx_clk_phase = 11;
> -               } else if (mmc->actual_clock >= 25000000) {
> -                       rx_clk_phase = 15;
> -               } else if (mmc->actual_clock > 5000000) {
> -                       rx_clk_phase = 23;
> -               } else if (mmc->actual_clock > 1000000) {
> -                       rx_clk_phase = 55;
> -               } else {
> -                       rx_clk_phase = 1061;
> -               }
> -
> +               regmap_read(host->regmap, MESON_SDHC_CLKC, &val);
> +               rx_clk_phase = FIELD_GET(MESON_SDHC_CLKC_CLK_DIV, val) / 4;
>                 regmap_update_bits(host->regmap, MESON_SDHC_CLK2,
>                                    MESON_SDHC_CLK2_RX_CLK_PHASE,
>                                    FIELD_PREP(MESON_SDHC_CLK2_RX_CLK_PHASE,
> --
> 2.34.1
>
