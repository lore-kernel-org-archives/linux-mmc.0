From: James Hogan <james@albanarts.com>
Subject: Re: [PATCH 1/7] mmc: dw_mmc: lookup for optional biu and ciu clocks
Date: Wed, 2 May 2012 15:53:53 +0100
Message-ID: <CAAG0J9-NDM9wLKpq04ofPkvFqiWxjmP84ojsP9Hfs0SJ_0FaXg@mail.gmail.com>
References: <1335935266-25289-1-git-send-email-thomas.abraham@linaro.org>
	<1335935266-25289-2-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:42441 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753779Ab2EBOxz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 May 2012 10:53:55 -0400
Received: by wgbdr13 with SMTP id dr13so742320wgb.1
        for <linux-mmc@vger.kernel.org>; Wed, 02 May 2012 07:53:54 -0700 (PDT)
In-Reply-To: <1335935266-25289-2-git-send-email-thomas.abraham@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, patches@linaro.org

Hi

On 2 May 2012 06:07, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> Some platforms allow for clock gating and control of bus interface un=
it clock
> and card interface unit clock. Add support for clock lookup of option=
al biu
> and ciu clocks for clock gating and clock speed determination.
>
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
> =A0drivers/mmc/host/dw_mmc.c =A0| =A0 35 ++++++++++++++++++++++++++++=
+++----
> =A0include/linux/mmc/dw_mmc.h | =A0 =A04 ++++
> =A02 files changed, 35 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 1532357..036846f 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1938,19 +1938,35 @@ int dw_mci_probe(struct dw_mci *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (!host->pdata->bus_hz) {
> + =A0 =A0 =A0 host->biu_clk =3D clk_get(&host->dev, "biu");

These clock names sound quite platform specific (what if they're
called something else on another platform, or another platform has
separate ones for different instantiations of the block?). Perhaps the
clk names should get passed in through platform data. I haven't looked
how other drivers handle that though.

> + =A0 =A0 =A0 if (IS_ERR(host->biu_clk))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&host->dev, "biu clock not ava=
ilable\n");

In this case, should it set host->biu_clk to NULL or are clk_disable
and clk_put guaranteed to handle an IS_ERR value?

> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(host->biu_clk);
> +
> + =A0 =A0 =A0 host->ciu_clk =3D clk_get(&host->dev, "ciu");
> + =A0 =A0 =A0 if (IS_ERR(host->ciu_clk))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_info(&host->dev, "ciu clock not ava=
ilable\n");

same here

> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(host->ciu_clk);
> +
> + =A0 =A0 =A0 if (IS_ERR(host->ciu_clk))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->bus_hz =3D host->pdata->bus_hz;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->bus_hz =3D clk_get_rate(host->ciu=
_clk);
> +
> + =A0 =A0 =A0 if (!host->bus_hz) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&host->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"Platform data must su=
pply bus speed\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_clk;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 host->bus_hz =3D host->pdata->bus_hz;
> =A0 =A0 =A0 =A0host->quirks =3D host->pdata->quirks;
>
> =A0 =A0 =A0 =A0spin_lock_init(&host->lock);
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&host->queue);
>
> -
> =A0 =A0 =A0 =A0host->dma_ops =3D host->pdata->dma_ops;
> =A0 =A0 =A0 =A0dw_mci_init_dma(host);
>
> @@ -2095,6 +2111,13 @@ err_dmaunmap:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulator_disable(host->vmmc);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulator_put(host->vmmc);
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 kfree(host);

what's this about?

> +
> +err_clk:
> + =A0 =A0 =A0 clk_disable(host->ciu_clk);
> + =A0 =A0 =A0 clk_disable(host->biu_clk);
> + =A0 =A0 =A0 clk_put(host->ciu_clk);
> + =A0 =A0 =A0 clk_put(host->biu_clk);
> =A0 =A0 =A0 =A0return ret;
> =A0}
> =A0EXPORT_SYMBOL(dw_mci_probe);
> @@ -2128,6 +2151,10 @@ void dw_mci_remove(struct dw_mci *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulator_put(host->vmmc);
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 clk_disable(host->ciu_clk);
> + =A0 =A0 =A0 clk_disable(host->biu_clk);
> + =A0 =A0 =A0 clk_put(host->ciu_clk);
> + =A0 =A0 =A0 clk_put(host->biu_clk);
> =A0}
> =A0EXPORT_SYMBOL(dw_mci_remove);
>
> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
> index 7a7ebd3..fa9a139 100644
> --- a/include/linux/mmc/dw_mmc.h
> +++ b/include/linux/mmc/dw_mmc.h
> @@ -78,6 +78,8 @@ struct mmc_data;
> =A0* @data_offset: Set the offset of DATA register according to VERID=
=2E
> =A0* @dev: Device associated with the MMC controller.
> =A0* @pdata: Platform data associated with the MMC controller.
> + * @biu_clk: Pointer to bus interface unit clock instance.
> + * @ciu_clk: Pointer to card interface unit clock instance.
> =A0* @slot: Slots sharing this MMC controller.
> =A0* @fifo_depth: depth of FIFO.
> =A0* @data_shift: log2 of FIFO item size.
> @@ -158,6 +160,8 @@ struct dw_mci {
> =A0 =A0 =A0 =A0u16 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data_offse=
t;
> =A0 =A0 =A0 =A0struct device =A0 =A0 =A0 =A0 =A0 dev;
> =A0 =A0 =A0 =A0struct dw_mci_board =A0 =A0 *pdata;
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*biu_clk;
> + =A0 =A0 =A0 struct clk =A0 =A0 =A0 =A0 =A0 =A0 =A0*ciu_clk;
> =A0 =A0 =A0 =A0struct dw_mci_slot =A0 =A0 =A0*slot[MAX_MCI_SLOTS];
>
> =A0 =A0 =A0 =A0/* FIFO push and pull */
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/



--=20
James Hogan
