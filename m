Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D53C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Oct 2021 11:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91C6E61372
	for <linux-mmc@archiver.kernel.org>; Tue, 19 Oct 2021 11:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhJSLkB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 19 Oct 2021 07:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbhJSLjy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Oct 2021 07:39:54 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A880AC06176E
        for <linux-mmc@vger.kernel.org>; Tue, 19 Oct 2021 04:37:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id x27so6717559lfa.9
        for <linux-mmc@vger.kernel.org>; Tue, 19 Oct 2021 04:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D5PzwEBrOldlaIz/yoBnECaUyGI46VY83yvfxIz1ZF4=;
        b=WXLTnuVzOfIvphbQT4ZFrAt0wNTFY+MOeJZN7s04aT4LzVae1rULH5dGy0LzUllzwz
         2I4HFJQR5QtcmWPoKV+r+z10l5H05Rzls7CPnkijH4T6AEiHheOanmzBjxzEQ6qUxQME
         k4oVD0v2jt2O4MWMDbs4klhoyOG7bMYoHh5YdkRVDZFUl9eE1b7WqwkPZqczaB2BDBB2
         IFs/RI6e7oQxWn2EIZdL68Snl+58JXtiGJpflTE9bgI067dDWM1naY3dh1uRG/qfmZ5+
         5Ji72Gr0JlOP1Ij/DTKFk+dzrGseMPb1EWaEFK4otMo4H4NaGZIaDuk/JgFMvPPmf7wu
         kSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D5PzwEBrOldlaIz/yoBnECaUyGI46VY83yvfxIz1ZF4=;
        b=nJIm46ea3VwQggQAYp7gG+llvkZwFuz9qK8FjytzjxLFABHOCpm5zDDW+fAQYzr+iW
         Y5/VLD4ywjeadkrdS+BtF4u7QtOivSGW8z+sBPwbclJooanx/pS0urRqR9eloEuytD5d
         PvRsFBfFgH9IPcjuNw5hO1LiuY4eRxF46ss87eH9MSCzwEMm0OxXhlwiN9J421pRIQU0
         EH4oMs3lveB3T5O1aPmTfCKE/UO+BMJQ/t3CiSeyUw1e4N8+r98b+bsA/qkUkuiZNQU0
         bMpVkYnaKzcUnrDnFdDHGL//knlFFnVc/7zNxYqp7MQtMPZQ+pyPai9oifiYor6tMbMK
         KejQ==
X-Gm-Message-State: AOAM532r/+H8CUzazPNZDnTNhyXQQ0j6lyo7ctho4XI0rLCr1RdSKNLb
        oBQ1HxTnaInSqRNB7pqS5RG6nGQ0YWJvSZeVfAh7pA==
X-Google-Smtp-Source: ABdhPJxI1KBn0TsgDp3DyQqblAi01bephKSl6c86Z7+PTcABb14fvdzOS9EMLr3KRGaiG817ECkKj2j23M8q4eSma5I=
X-Received: by 2002:ac2:4293:: with SMTP id m19mr5618302lfh.254.1634643451083;
 Tue, 19 Oct 2021 04:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <4aadb3c97835f7b80f00819c3d549e6130384e67.1634365151.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <4aadb3c97835f7b80f00819c3d549e6130384e67.1634365151.git.christophe.jaillet@wanadoo.fr>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 19 Oct 2021 13:36:54 +0200
Message-ID: <CAPDyKFo-ahKB8naaBFBdrCy3f_a08s_2e9FnjwOqsDc1-gWYvg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mxs-mmc: disable regulator on error and in the
 remove function
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>, Chris Ball <cjb@laptop.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 16 Oct 2021 at 08:21, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
>
> The 'reg_vmmc' regulator is enabled in the probe. It is never disabled.
> Neither in the error handling path of the probe nor in the remove
> function.
>
> Register a devm_action to disable it when needed.
>
> Fixes: 4dc5a79f1350 ("mmc: mxs-mmc: enable regulator for mmc slot")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/mxs-mmc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 947581de7860..8c3655d3be96 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -552,6 +552,11 @@ static const struct of_device_id mxs_mmc_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mxs_mmc_dt_ids);
>
> +static void mxs_mmc_regulator_disable(void *regulator)
> +{
> +       regulator_disable(regulator);
> +}
> +
>  static int mxs_mmc_probe(struct platform_device *pdev)
>  {
>         struct device_node *np = pdev->dev.of_node;
> @@ -591,6 +596,11 @@ static int mxs_mmc_probe(struct platform_device *pdev)
>                                 "Failed to enable vmmc regulator: %d\n", ret);
>                         goto out_mmc_free;
>                 }
> +
> +               ret = devm_add_action_or_reset(&pdev->dev, mxs_mmc_regulator_disable,
> +                                              reg_vmmc);
> +               if (ret)
> +                       goto out_mmc_free;
>         }
>
>         ssp->clk = devm_clk_get(&pdev->dev, NULL);
> --
> 2.30.2
>
