Return-Path: <SRS0=rM9+=DT=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE21C43467
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 00:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BD1120790
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Oct 2020 00:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZG/7AljI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgJLA7E (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 11 Oct 2020 20:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbgJLA7D (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 11 Oct 2020 20:59:03 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB2BC0613CE
        for <linux-mmc@vger.kernel.org>; Sun, 11 Oct 2020 17:59:01 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id v23so5669588vsp.6
        for <linux-mmc@vger.kernel.org>; Sun, 11 Oct 2020 17:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKuO3QKcuUe/F0t0uUwfDC3OUqDsOLuOv/YQ0PPKJlA=;
        b=ZG/7AljIIxkb5kzG7HUfhx+PenrEEBEfXe2u+72K/l+ASYNVw1bzTK8HkNYSwNlsXK
         bwSJVF9pjjshsq0EMj7KGo7mcBMXwlnURFfVNlOtH6C34LV6twpBsGEVtA+Eqk+Z/wLn
         ENLu//cmWsl73fMUH9ggHyTUOLybFWK8/vrMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKuO3QKcuUe/F0t0uUwfDC3OUqDsOLuOv/YQ0PPKJlA=;
        b=n0TfdgIplPqdoQKQfOaCvYJZOc3FkbVyKPlHwnghfrmcXRZrsmEttBYuy1TOynNnDG
         GKNWKRP9aWvnWxh5BQbMkXJ1cNq6h2zt4rA2Wklg+W4xSZWd8bgO+i8V2AxHKOaUY8WS
         jh8GL9VBCOJt4hRIEwhK4VJTeyQUtozXz1xHs8+vbsssChZsTJT4RPAj0mI8R3FxkwJW
         S8eIhZGwPhLRGAnXZQEfTntuReJM7kGqfqKTE0uIhwCsDk/IVEPa+IOej35br0H+6Zq1
         exP9Q+ZJor+kGF5I1SpQU78frYFbJvLcAzzzqTIe++uej8VWj9eJ7fGa0EKSV582IVsy
         1aNg==
X-Gm-Message-State: AOAM533YbtPbBAp6ss1uedWy8rgdzlneOtGecYgl5WL27tzCM1V6lhD4
        bzhgnIsjxjwuzbE6q9PtEQhnp8ncsyJhfO4r457e9A==
X-Google-Smtp-Source: ABdhPJzbMq6z0XxcHIW6V+QcP9xfb/3LB2U9g8w72z9oVPeF9M6hCzMfU7wevdjFzc2rwF7rScRjmqmEOTel5s5bRLY=
X-Received: by 2002:a67:3344:: with SMTP id z65mr13370348vsz.47.1602464340859;
 Sun, 11 Oct 2020 17:59:00 -0700 (PDT)
MIME-Version: 1.0
References: <20201011091030.28547-1-wenbin.mei@mediatek.com> <20201011091030.28547-5-wenbin.mei@mediatek.com>
In-Reply-To: <20201011091030.28547-5-wenbin.mei@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Mon, 12 Oct 2020 08:58:49 +0800
Message-ID: <CANMq1KDSw6gTL=5oicK5h_Q5rLhYUcANXw1M7RT=xRyT2PzUrA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] mmc: mediatek: Add subsys clock control for MT8192 msdc
To:     Wenbin Mei <wenbin.mei@mediatek.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Oct 11, 2020 at 5:10 PM Wenbin Mei <wenbin.mei@mediatek.com> wrote:
>
> MT8192 msdc is an independent sub system, we need control more bus
> clocks for it.
> Add support for the additional subsys clocks to allow it to be
> configured appropriately.
>
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>

Err, you must not add R-by tag unless I explicitly say so (yes, I
reviewed v3, but I didn't add my R-by tag).

> ---
>  drivers/mmc/host/mtk-sd.c | 80 ++++++++++++++++++++++++++++++---------
>  1 file changed, 62 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index a704745e5882..350e45432e21 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -425,6 +425,8 @@ struct msdc_host {
>         struct clk *h_clk;      /* msdc h_clk */
>         struct clk *bus_clk;    /* bus clock which used to access register */
>         struct clk *src_clk_cg; /* msdc source clock control gate */
> +       struct clk *sys_clk_cg; /* msdc subsys clock control gate */
> +       struct clk_bulk_data bulk_clks[3];      /* pclk, axi, ahb clock control gate */
>         u32 mclk;               /* mmc subsystem clock frequency */
>         u32 src_clk_freq;       /* source clock frequency */
>         unsigned char timing;
> @@ -784,6 +786,8 @@ static void msdc_set_busy_timeout(struct msdc_host *host, u64 ns, u64 clks)
>
>  static void msdc_gate_clock(struct msdc_host *host)
>  {
> +       clk_bulk_disable_unprepare(ARRAY_SIZE(host->bulk_clks),
> +                                  host->bulk_clks);
>         clk_disable_unprepare(host->src_clk_cg);
>         clk_disable_unprepare(host->src_clk);
>         clk_disable_unprepare(host->bus_clk);
> @@ -792,10 +796,19 @@ static void msdc_gate_clock(struct msdc_host *host)
>
>  static void msdc_ungate_clock(struct msdc_host *host)
>  {
> +       int ret;
> +
>         clk_prepare_enable(host->h_clk);
>         clk_prepare_enable(host->bus_clk);
>         clk_prepare_enable(host->src_clk);
>         clk_prepare_enable(host->src_clk_cg);
> +       ret = clk_bulk_prepare_enable(ARRAY_SIZE(host->bulk_clks),
> +                                     host->bulk_clks);
> +       if (ret) {
> +               dev_err(host->dev, "enable clks failed!\n");
> +               return;
> +       }
> +
>         while (!(readl(host->base + MSDC_CFG) & MSDC_CFG_CKSTB))
>                 cpu_relax();
>  }
> @@ -2366,6 +2379,53 @@ static void msdc_of_property_parse(struct platform_device *pdev,
>                 host->cqhci = false;
>  }
>
> +static int msdc_of_clock_parse(struct platform_device *pdev,
> +                              struct msdc_host *host)
> +{
> +       struct clk *clk;
> +
> +       host->src_clk = devm_clk_get_optional(&pdev->dev, "source");
> +       if (IS_ERR(host->src_clk))
> +               return PTR_ERR(host->src_clk);
> +
> +       host->h_clk = devm_clk_get_optional(&pdev->dev, "hclk");
> +       if (IS_ERR(host->h_clk))
> +               return PTR_ERR(host->h_clk);
> +
> +       host->bus_clk = devm_clk_get_optional(&pdev->dev, "bus_clk");
> +       if (IS_ERR(host->bus_clk))
> +               host->bus_clk = NULL;
> +
> +       /*source clock control gate is optional clock*/
> +       host->src_clk_cg = devm_clk_get_optional(&pdev->dev, "source_cg");
> +       if (IS_ERR(host->src_clk_cg))
> +               host->src_clk_cg = NULL;
> +
> +       host->sys_clk_cg = devm_clk_get_optional(&pdev->dev, "sys_cg");
> +       if (IS_ERR(host->sys_clk_cg))
> +               host->sys_clk_cg = NULL;
> +
> +       /* If present, always enable for this clock gate */
> +       clk_prepare_enable(host->sys_clk_cg);

Understand your reply on v3 (this clock gate cannot be disabled --
https://patchwork.kernel.org/patch/11808433/#23678227), but I'm still
unsure if this is the right thing to do to enable it at probe time.
I'll let others comment.

> +
> +       clk = devm_clk_get_optional(&pdev->dev, "pclk_cg");
> +       if (IS_ERR(clk))
> +               clk = NULL;
> +       host->bulk_clks[0].clk = clk;
> +
> +       clk = devm_clk_get_optional(&pdev->dev, "axi_cg");
> +       if (IS_ERR(clk))
> +               clk = NULL;
> +       host->bulk_clks[1].clk = clk;
> +
> +       clk = devm_clk_get_optional(&pdev->dev, "ahb_cg");
> +       if (IS_ERR(clk))
> +               clk = NULL;
> +       host->bulk_clks[2].clk = clk;

Put the clock names in host->bulk_clks[x].id, then call
devm_clk_bulk_get_optional.

Example here: https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpio-dwapb.c#L675

> +
> +       return 0;
> +}
> +
>  static int msdc_drv_probe(struct platform_device *pdev)
>  {
>         struct mmc_host *mmc;
> @@ -2405,25 +2465,9 @@ static int msdc_drv_probe(struct platform_device *pdev)
>         if (ret)
>                 goto host_free;
>
> -       host->src_clk = devm_clk_get(&pdev->dev, "source");
> -       if (IS_ERR(host->src_clk)) {
> -               ret = PTR_ERR(host->src_clk);
> -               goto host_free;
> -       }
> -
> -       host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> -       if (IS_ERR(host->h_clk)) {
> -               ret = PTR_ERR(host->h_clk);
> +       ret = msdc_of_clock_parse(pdev, host);
> +       if (ret)
>                 goto host_free;
> -       }
> -
> -       host->bus_clk = devm_clk_get(&pdev->dev, "bus_clk");
> -       if (IS_ERR(host->bus_clk))
> -               host->bus_clk = NULL;
> -       /*source clock control gate is optional clock*/
> -       host->src_clk_cg = devm_clk_get(&pdev->dev, "source_cg");
> -       if (IS_ERR(host->src_clk_cg))
> -               host->src_clk_cg = NULL;
>
>         host->reset = devm_reset_control_get_optional_exclusive(&pdev->dev,
>                                                                 "hrst");
> --
> 2.18.0
