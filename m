From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RESEND 01/12] mmc: sdhci-pxav2: Drop unused struct sdhci_pxa
Date: Mon, 27 Oct 2014 14:38:28 +0100
Message-ID: <CAPDyKFovdmiD8V3sPjk7_+01wiTwZcaxvjLjvvvS3OhnBZFA0A@mail.gmail.com>
References: <1413883364-681-1-git-send-email-sebastian.hesselbarth@gmail.com>
	<1413883364-681-2-git-send-email-sebastian.hesselbarth@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:47352 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbaJ0Ni3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Oct 2014 09:38:29 -0400
Received: by mail-qg0-f53.google.com with SMTP id z107so2070545qgd.12
        for <linux-mmc@vger.kernel.org>; Mon, 27 Oct 2014 06:38:28 -0700 (PDT)
In-Reply-To: <1413883364-681-2-git-send-email-sebastian.hesselbarth@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Chris Ball <chris@printf.net>, =?UTF-8?Q?Antoine_T=C3=A9nart?= <antoine.tenart@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 21 October 2014 11:22, Sebastian Hesselbarth
<sebastian.hesselbarth@gmail.com> wrote:
> struct sdhci_pxa is private data of PXA SDHCI driver, but not used in
> sdhci-pxav2 at all. Drop unused references to struct sdhci_pxa.
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
>  drivers/mmc/host/sdhci-pxav2.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-=
pxav2.c
> index b4c23e983baf..f98008b5ea77 100644
> --- a/drivers/mmc/host/sdhci-pxav2.c
> +++ b/drivers/mmc/host/sdhci-pxav2.c
> @@ -167,23 +167,17 @@ static int sdhci_pxav2_probe(struct platform_de=
vice *pdev)
>         struct sdhci_pxa_platdata *pdata =3D pdev->dev.platform_data;
>         struct device *dev =3D &pdev->dev;
>         struct sdhci_host *host =3D NULL;
> -       struct sdhci_pxa *pxa =3D NULL;
>         const struct of_device_id *match;
>
>         int ret;
>         struct clk *clk;
>
> -       pxa =3D kzalloc(sizeof(struct sdhci_pxa), GFP_KERNEL);
> -       if (!pxa)
> -               return -ENOMEM;
> -
>         host =3D sdhci_pltfm_init(pdev, NULL, 0);
> -       if (IS_ERR(host)) {
> -               kfree(pxa);
> +       if (IS_ERR(host))
>                 return PTR_ERR(host);
> -       }
> +
>         pltfm_host =3D sdhci_priv(host);
> -       pltfm_host->priv =3D pxa;
> +       pltfm_host->priv =3D NULL;
>
>         clk =3D clk_get(dev, "PXA-SDHCLK");
>         if (IS_ERR(clk)) {
> @@ -238,7 +232,6 @@ err_add_host:
>         clk_put(clk);
>  err_clk_get:
>         sdhci_pltfm_free(pdev);
> -       kfree(pxa);
>         return ret;
>  }
>
> @@ -246,14 +239,12 @@ static int sdhci_pxav2_remove(struct platform_d=
evice *pdev)
>  {
>         struct sdhci_host *host =3D platform_get_drvdata(pdev);
>         struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
> -       struct sdhci_pxa *pxa =3D pltfm_host->priv;
>
>         sdhci_remove_host(host, 1);
>
>         clk_disable_unprepare(pltfm_host->clk);
>         clk_put(pltfm_host->clk);
>         sdhci_pltfm_free(pdev);
> -       kfree(pxa);
>
>         return 0;
>  }
> --
> 2.1.1
>
