From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND 08/12] mmc: sdhci-pxav3: Get optional core clock
Date: Tue, 28 Oct 2014 10:53:21 +0100
Message-ID: <CAPDyKFoXzyFnuEwaa_q-uzhQMioAEs=9HyKTfOwV9KahCJnZhQ@mail.gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
	<1413883364-681-9-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:42347 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbaJ1JxW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Oct 2014 05:53:22 -0400
Received: by mail-qa0-f47.google.com with SMTP id dc16so163311qab.20
        for <linux-mmc@vger.kernel.org>; Tue, 28 Oct 2014 02:53:21 -0700 (PDT)
In-Reply-To: <1413883364-681-9-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Chris Ball <chris@printf.net>, =?UTF-8?Q?Antoine_T=C3=A9nart?= <antoine.tenart@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 21 October 2014 11:22, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> Besides the I/O clock, some PXAv3 SDHCI IP also requires a core clock=
 to
> be enabled. Add an optional core clock to the corresponding driver.
>
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com=
>

Thanks! Applied for next!

Kind regards
Uffe


> ---
> Cc: Chris Ball <chris@printf.net>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "Antoine T=C3=A9nart" <antoine.tenart@free-electrons.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/mmc/host/sdhci-pxav3.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-=
pxav3.c
> index 3dfd97977515..ad0badad0ebc 100644
> --- a/drivers/mmc/host/sdhci-pxav3.c
> +++ b/drivers/mmc/host/sdhci-pxav3.c
> @@ -59,6 +59,7 @@
>  #define SDCE_MISC_INT_EN       (1<<1)
>
>  struct sdhci_pxa {
> +       struct clk *clk_core;
>         struct clk *clk_io;
>         u8      power_mode;
>  };
> @@ -320,6 +321,10 @@ static int sdhci_pxav3_probe(struct platform_dev=
ice *pdev)
>         pltfm_host->clk =3D pxa->clk_io;
>         clk_prepare_enable(pxa->clk_io);
>
> +       pxa->clk_core =3D devm_clk_get(dev, "core");
> +       if (!IS_ERR(pxa->clk_core))
> +               clk_prepare_enable(pxa->clk_core);
> +
>         /* enable 1/8V DDR capable */
>         host->mmc->caps |=3D MMC_CAP_1_8V_DDR;
>
> @@ -392,6 +397,8 @@ err_add_host:
>  err_of_parse:
>  err_cd_req:
>         clk_disable_unprepare(pxa->clk_io);
> +       if (!IS_ERR(pxa->clk_core))
> +               clk_disable_unprepare(pxa->clk_core);
>  err_clk_get:
>  err_mbus_win:
>         sdhci_pltfm_free(pdev);
> @@ -409,6 +416,8 @@ static int sdhci_pxav3_remove(struct platform_dev=
ice *pdev)
>         pm_runtime_disable(&pdev->dev);
>
>         clk_disable_unprepare(pxa->clk_io);
> +       if (!IS_ERR(pxa->clk_core))
> +               clk_disable_unprepare(pxa->clk_core);
>
>         sdhci_pltfm_free(pdev);
>
> @@ -456,6 +465,8 @@ static int sdhci_pxav3_runtime_suspend(struct dev=
ice *dev)
>         spin_unlock_irqrestore(&host->lock, flags);
>
>         clk_disable_unprepare(pxa->clk_io);
> +       if (!IS_ERR(pxa->clk_core))
> +               clk_disable_unprepare(pxa->clk_core);
>
>         return 0;
>  }
> @@ -468,6 +479,8 @@ static int sdhci_pxav3_runtime_resume(struct devi=
ce *dev)
>         unsigned long flags;
>
>         clk_prepare_enable(pxa->clk_io);
> +       if (!IS_ERR(pxa->clk_core))
> +               clk_prepare_enable(pxa->clk_core);
>
>         spin_lock_irqsave(&host->lock, flags);
>         host->runtime_suspended =3D false;
> --
> 2.1.1
>
