From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: mmci: Allow MMCI to request channels with
 information acquired from DT
Date: Thu, 18 Apr 2013 10:21:14 +0200
Message-ID: <CAPDyKFqHBYRRNFqKMdw4H73_o-v_sQ5ybGg3jZHqgNDg4zyB5w@mail.gmail.com>
References: <1366205534-25079-1-git-send-email-lee.jones@linaro.org>
	<201304171550.56037.arnd@arndb.de>
	<20130417150437.GA3137@gmail.com>
	<201304171731.56292.arnd@arndb.de>
	<20130418080238.GB3137@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:37553 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755676Ab3DRIVP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Apr 2013 04:21:15 -0400
Received: by mail-vc0-f169.google.com with SMTP id hx10so2227411vcb.0
        for <linux-mmc@vger.kernel.org>; Thu, 18 Apr 2013 01:21:14 -0700 (PDT)
In-Reply-To: <20130418080238.GB3137@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@stericsson.com, Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 18 April 2013 10:02, Lee Jones <lee.jones@linaro.org> wrote:
>> I think you can further simplify this, given that in the DT case we =
always
>> allocate a zeroed mmci_platform_data for host->plat, so !plat cannot=
 happen
>> when we get here.
>
> Okay, third time lucky. :)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index 372e921..3260ab4 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -298,14 +298,16 @@ static void mmci_init_sg(struct mmci_host *host=
, struct mmc_data *data)
>   * no custom DMA interfaces are supported.
>   */
>  #ifdef CONFIG_DMA_ENGINE
> -static void mmci_dma_setup(struct mmci_host *host)
> +static void mmci_dma_setup(struct amba_device *dev,
> +                          struct mmci_host *host)

Hi Lee,

You don't need to pass the amba_device, this can be fetched from the
mmci_host. Check how other functions converts the mmci host it in this
driver.

Kind regards
Ulf Hansson

>  {
> +       struct device_node *np =3D dev->dev.of_node;
>         struct mmci_platform_data *plat =3D host->plat;
>         const char *rxname, *txname;
>         dma_cap_mask_t mask;
>
> -       if (!plat || !plat->dma_filter) {
> -               dev_info(mmc_dev(host->mmc), "no DMA platform data\n"=
);
> +       if (!(plat->dma_filter || np)) {
> +               dev_info(mmc_dev(host->mmc), "no DMA platform data or=
 DT\n");
>                 return;
>         }
>
> @@ -321,19 +323,21 @@ static void mmci_dma_setup(struct mmci_host *ho=
st)
>          * attempt to use it bidirectionally, however if it is
>          * is specified but cannot be located, DMA will be disabled.
>          */
> -       if (plat->dma_rx_param) {
> -               host->dma_rx_channel =3D dma_request_channel(mask,
> -                                                          plat->dma_=
filter,
> -                                                          plat->dma_=
rx_param);
> +       if (plat->dma_rx_param || np) {
> +               host->dma_rx_channel =3D dma_request_slave_channel_co=
mpat(mask,
> +                                                               plat-=
>dma_filter,
> +                                                               plat-=
>dma_rx_param,
> +                                                               &dev-=
>dev, "rx");
>                 /* E.g if no DMA hardware is present */
>                 if (!host->dma_rx_channel)
>                         dev_err(mmc_dev(host->mmc), "no RX DMA channe=
l\n");
>         }
>
> -       if (plat->dma_tx_param) {
> -               host->dma_tx_channel =3D dma_request_channel(mask,
> -                                                          plat->dma_=
filter,
> -                                                          plat->dma_=
tx_param);
> +       if (plat->dma_tx_param || np) {
> +               host->dma_tx_channel =3D dma_request_slave_channel_co=
mpat(mask,
> +                                                               plat-=
>dma_filter,
> +                                                               plat-=
>dma_tx_param,
> +                                                               &dev-=
>dev, "tx");
>                 if (!host->dma_tx_channel)
>                         dev_warn(mmc_dev(host->mmc), "no TX DMA chann=
el\n");
>         } else {
> @@ -1538,7 +1542,7 @@ static int mmci_probe(struct amba_device *dev,
>                  amba_rev(dev), (unsigned long long)dev->res.start,
>                  dev->irq[0], dev->irq[1]);
>
> -       mmci_dma_setup(host);
> +       mmci_dma_setup(dev, host);
>
>         pm_runtime_set_autosuspend_delay(&dev->dev, 50);
>         pm_runtime_use_autosuspend(&dev->dev);
>
> --
> Lee Jones
> Linaro ST-Ericsson Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
