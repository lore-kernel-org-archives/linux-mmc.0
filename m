Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA54EC5519F
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 15:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E6924794
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Nov 2020 15:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tA/bE1TZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgKRPoN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Nov 2020 10:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgKRPoM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Nov 2020 10:44:12 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5466CC0613D4
        for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2020 07:44:12 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id w67so557771vke.10
        for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2020 07:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ydW4yk3TuZeSZNEMd5axHSNJoQSvtmifCt5BdKRg16c=;
        b=tA/bE1TZGsTU92aTpRhEFvcyxzto5ecR9XJkFucrG8nxq2ihWvjgHGw1iuywYvzipU
         6YvjThzK2uomYFlRwGZs/4slkWzQdwdqkQ/fN+8XFkyQ+cz+tp+9wEkcr5dFRe/tQ4in
         Uvds9pYH9IgCzN5SL4vuds34h/D/zNQ1GBT1cdh/d2Bpr8x2VTgxY/zv0SXrVf/smnvD
         uI5XcI1AwNVbcIb3asABOyPIgdngYu+zSx9+KxprHaC43jdC5ckL3YhQQ2wL/qzJgtxh
         OKPN5HKu9JAlBeZ5nTxF7HklNo8p7oPUJ/EdAELw+CYnW2layqGwmSrDFOv23hUeRfl/
         wDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ydW4yk3TuZeSZNEMd5axHSNJoQSvtmifCt5BdKRg16c=;
        b=SxXag6Z2t/DhreiBKi0l5Na/GSxJtw58JEvZQY6hseF6VNufRknocRZWvBC9eBYYo6
         weuAzsDF0agBGMO+DJkVutHsLmCA5aa48jhsYt5TX7H8D1+j7MaCb6EqAtchUx1h9qJL
         jU3lkyGwtrx+WJmUsu3kSE63WeALh+b/WxU6ZJJvH6YjXG1nd+qlfSS3wMZyPv2lQIVg
         mK+zTWWkrhu8Aqnu+nk4HiJq0vf6HoxwLl29yIsPhXD2vB7tNO9Y+2lIbUdRfmjthKEh
         HSfy4J3G91Ef37ugvWy8LafUUAb2pKw8mdgr6gr1aEwzVWnO+FaBWer7womrPIdPJuRe
         eroA==
X-Gm-Message-State: AOAM5312yPjpckfpUzHGaBx468FB335VKfYw5jSoD9AFtRqDXYHs6tdj
        rGEiMhlSutr5DQ+tcDzi2BaqLff2wQx8PaC05ONmLQDf4QaWXSFa
X-Google-Smtp-Source: ABdhPJyclpsoyMGwEp4eAi3irUnBeWNOvcROuZtu5a/eHfn8VDPqkTkMqfp76L/7oEhiRZt1qoUuCvCNowDqVMNb2pU=
X-Received: by 2002:a1f:41cc:: with SMTP id o195mr3817836vka.15.1605714251540;
 Wed, 18 Nov 2020 07:44:11 -0800 (PST)
MIME-Version: 1.0
References: <1605680495-37483-1-git-send-email-manish.narani@xilinx.com>
In-Reply-To: <1605680495-37483-1-git-send-email-manish.narani@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Nov 2020 16:43:35 +0100
Message-ID: <CAPDyKFr7KTf7jUAuPj=0NZ1sty+y7ySV8PkdrKFXPVthJ=VJVQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Add pinctrl support to the driver
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 18 Nov 2020 at 07:22, Manish Narani <manish.narani@xilinx.com> wrote:
>
> Driver should be able to handle optional pinctrl setting.
>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 829ccef87426..f788cc9d5914 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -23,6 +23,7 @@
>  #include <linux/regmap.h>
>  #include <linux/of.h>
>  #include <linux/firmware/xlnx-zynqmp.h>
> +#include <linux/pinctrl/consumer.h>
>
>  #include "cqhci.h"
>  #include "sdhci-pltfm.h"
> @@ -135,6 +136,8 @@ struct sdhci_arasan_clk_data {
>   * @clk_ops:           Struct for the Arasan Controller Clock Operations.
>   * @soc_ctl_base:      Pointer to regmap for syscon for soc_ctl registers.
>   * @soc_ctl_map:       Map to get offsets into soc_ctl registers.
> + * @pinctrl:           Per-device pin control state holder.
> + * @pins_default:      Pinctrl state for a device.
>   * @quirks:            Arasan deviations from spec.
>   */
>  struct sdhci_arasan_data {
> @@ -149,6 +152,8 @@ struct sdhci_arasan_data {
>
>         struct regmap   *soc_ctl_base;
>         const struct sdhci_arasan_soc_ctl_map *soc_ctl_map;
> +       struct pinctrl  *pinctrl;
> +       struct pinctrl_state *pins_default;
>         unsigned int    quirks;
>
>  /* Controller does not have CD wired and will not function normally without */
> @@ -1619,6 +1624,25 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 goto unreg_clk;
>         }
>
> +       sdhci_arasan->pinctrl = devm_pinctrl_get(&pdev->dev);
> +       if (!IS_ERR(sdhci_arasan->pinctrl)) {
> +               sdhci_arasan->pins_default =
> +                       pinctrl_lookup_state(sdhci_arasan->pinctrl,
> +                                            PINCTRL_STATE_DEFAULT);
> +               if (IS_ERR(sdhci_arasan->pins_default)) {
> +                       dev_err(&pdev->dev, "Missing default pinctrl config\n");
> +                       ret = PTR_ERR(sdhci_arasan->pins_default);
> +                       goto unreg_clk;
> +               }
> +
> +               ret = pinctrl_select_state(sdhci_arasan->pinctrl,
> +                                          sdhci_arasan->pins_default);
> +               if (ret) {
> +                       dev_err(&pdev->dev, "could not select default state\n");
> +                       goto unreg_clk;
> +               }
> +       }

Isn't all this already taken care of via pinctrl_bind_pins() called by
driver core during probe?

[...]

Kind regards
Uffe
