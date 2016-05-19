From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC PATCH 2/3] mmc: host: omap_hsmmc: Enable ADMA2
Date: Thu, 19 May 2016 11:25:06 +0300
Message-ID: <7e9c3486-88c5-a61d-0629-936b428ad959@ti.com>
References: <1463561115-31798-1-git-send-email-kishon@ti.com>
 <1463561115-31798-3-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48542 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753713AbcESI1S (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 May 2016 04:27:18 -0400
In-Reply-To: <1463561115-31798-3-git-send-email-kishon@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, afenkart@gmail.com, ulf.hansson@linaro.org, linux@armlinux.org.uk, tony@atomide.com
Cc: rogerq@ti.com, bcousson@baylibre.com, galak@codeaurora.org, ijc+devicetree@hellion.org.uk, mark.rutland@arm.com, pawel.moll@arm.com, robh+dt@kernel.org, nsekhar@ti.com

On 05/18/2016 11:45 AM, Kishon Vijay Abraham I wrote:
> omap hsmmc host controller has ADMA2 feature. Enable it here
> for better read and write throughput. Add a new dt binding
> "ti,use_adma" to enable ADMA2.
>=20
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    1 +
>  drivers/mmc/host/omap_hsmmc.c                      |  320 ++++++++++=
++++++----
>  include/linux/platform_data/hsmmc-omap.h           |    1 +
>  3 files changed, 256 insertions(+), 66 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt =
b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> index 74166a0..eb5ceec2 100644
> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
> @@ -28,6 +28,7 @@ specifier is required.
>  dma-names: List of DMA request names. These strings correspond
>  1:1 with the DMA specifiers listed in dmas. The string naming is
>  to be "rx" and "tx" for RX and TX DMA requests, respectively.
> +ti,use_adma: enable adma2 feature
> =20
>  Examples:
> =20
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index cc916d5..b4a7d18 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -66,6 +66,8 @@
>  #define OMAP_HSMMC_ISE		0x0138
>  #define OMAP_HSMMC_AC12		0x013C
>  #define OMAP_HSMMC_CAPA		0x0140
> +#define OMAP_HSMMC_ADMAES	0x0154
> +#define OMAP_HSMMC_ADMASAL	0x0158
> =20
>  #define VS18			(1 << 26)
>  #define VS30			(1 << 25)
> @@ -76,6 +78,7 @@
>  #define SDVS_MASK		0x00000E00
>  #define SDVSCLR			0xFFFFF1FF
>  #define SDVSDET			0x00000400
> +#define DMA_SELECT		(2 << 3)
>  #define AUTOIDLE		0x1
>  #define SDBP			(1 << 8)
>  #define DTO			0xe
> @@ -97,6 +100,7 @@
>  #define FOUR_BIT		(1 << 1)
>  #define HSPE			(1 << 2)
>  #define IWE			(1 << 24)
> +#define DMA_MASTER		(1 << 20)
>  #define DDR			(1 << 19)
>  #define CLKEXTFREE		(1 << 16)
>  #define CTPL			(1 << 11)
> @@ -127,10 +131,11 @@
>  #define DCRC_EN			(1 << 21)
>  #define DEB_EN			(1 << 22)
>  #define ACE_EN			(1 << 24)
> +#define ADMAE_EN		(1 << 24)
>  #define CERR_EN			(1 << 28)
>  #define BADA_EN			(1 << 29)
> =20
> -#define INT_EN_MASK (BADA_EN | CERR_EN | ACE_EN | DEB_EN | DCRC_EN |=
\
> +#define INT_EN_MASK (BADA_EN | CERR_EN | ADMAE_EN | ACE_EN | DEB_EN =
| DCRC_EN |\
>  		DTO_EN | CIE_EN | CEB_EN | CCRC_EN | CTO_EN | \
>  		BRR_EN | BWR_EN | TC_EN | CC_EN)
> =20
> @@ -168,6 +173,25 @@
>  #define OMAP_HSMMC_WRITE(base, reg, val) \
>  	__raw_writel((val), (base) + OMAP_HSMMC_##reg)
> =20
> +struct omap_hsmmc_adma_desc {
> +	u8 attr;
> +	u8 reserved;
> +	u16 len;
> +	u32 addr;
> +} __packed;
> +
> +#define ADMA_MAX_LEN			65532
> +
> +/* Decriptor table defines */
> +#define ADMA_DESC_ATTR_VALID		BIT(0)
> +#define ADMA_DESC_ATTR_END		BIT(1)
> +#define ADMA_DESC_ATTR_INT		BIT(2)
> +#define ADMA_DESC_ATTR_ACT1		BIT(4)
> +#define ADMA_DESC_ATTR_ACT2		BIT(5)
> +
> +#define ADMA_DESC_TRANSFER_DATA		ADMA_DESC_ATTR_ACT2
> +#define ADMA_DESC_LINK_DESC	(ADMA_DESC_ATTR_ACT1 | ADMA_DESC_ATTR_AC=
T2)
> +
>  struct omap_hsmmc_next {
>  	unsigned int	dma_len;
>  	s32		cookie;
> @@ -213,6 +237,9 @@ struct omap_hsmmc_host {
>  	struct omap_hsmmc_next	next_data;
>  	struct	omap_hsmmc_platform_data	*pdata;
> =20
> +	struct omap_hsmmc_adma_desc *adma_desc_table;
> +	dma_addr_t              adma_desc_table_addr;
> +
>  	/* return MMC cover switch state, can be NULL if not supported.
>  	 *
>  	 * possible return values:
> @@ -951,6 +978,19 @@ static struct dma_chan *omap_hsmmc_get_dma_chan(=
struct omap_hsmmc_host *host,
>  	return data->flags & MMC_DATA_WRITE ? host->tx_chan : host->rx_chan=
;
>  }
> =20
> +static void omap_hsmmc_adma_cleanup(struct omap_hsmmc_host *host)
> +{
> +	u32 val;
> +
> +	val =3D OMAP_HSMMC_READ(host->base, HCTL);
> +	val &=3D ~DMA_SELECT;
> +	OMAP_HSMMC_WRITE(host->base, HCTL, val);
> +
> +	val =3D OMAP_HSMMC_READ(host->base, CON);
> +	val &=3D ~DMA_MASTER;
> +	OMAP_HSMMC_WRITE(host->base, CON, val);
> +}
> +
>  static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, st=
ruct mmc_request *mrq)
>  {
>  	int dma_ch;
> @@ -963,8 +1003,11 @@ static void omap_hsmmc_request_done(struct omap=
_hsmmc_host *host, struct mmc_req
> =20
>  	omap_hsmmc_disable_irq(host);
>  	/* Do not complete the request if DMA is still in progress */
> -	if (mrq->data && dma_ch !=3D -1)
> +	if (host->pdata->controller_flags =3D=3D OMAP_HSMMC_USE_ADMA)

host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA

and I would probably name the flag to OMAP_HSMMC_MASTER_DMA_SUPPORTED

> +		omap_hsmmc_adma_cleanup(host);
> +	else if (mrq->data && dma_ch !=3D -1)
>  		return;
> +
>  	host->mrq =3D NULL;
>  	mmc_request_done(host->mmc, mrq);
>  	pm_runtime_mark_last_busy(host->dev);
> @@ -1052,15 +1095,22 @@ static void omap_hsmmc_dma_cleanup(struct oma=
p_hsmmc_host *host, int errno)
>  	host->dma_ch =3D -1;
>  	spin_unlock_irqrestore(&host->irq_lock, flags);
> =20
> -	if (dma_ch !=3D -1) {
> -		struct dma_chan *chan =3D omap_hsmmc_get_dma_chan(host, host->data=
);
> -
> -		dmaengine_terminate_all(chan);
> -		dma_unmap_sg(chan->device->dev,
> -			host->data->sg, host->data->sg_len,
> +	if (!(host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)) {

it might be better to use the same order in the driver for Master and S=
lave
DMA cases:

if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA) {
	/* Master DMA case */
} else {
	/* Slave DMA case */
}

It will make the driver easier to read.

> +		if (dma_ch !=3D -1) {
> +			struct dma_chan *chan =3D omap_hsmmc_get_dma_chan(host,
> +								host->data);
> +			dmaengine_terminate_all(chan);
> +			dma_unmap_sg(chan->device->dev,
> +				     host->data->sg, host->data->sg_len,
>  			omap_hsmmc_get_dma_dir(host, host->data));
> =20
> +			host->data->host_cookie =3D 0;
> +		}
> +	} else {
> +		dma_unmap_sg(host->dev, host->data->sg, host->data->sg_len,
> +			     omap_hsmmc_get_dma_dir(host, host->data));
>  		host->data->host_cookie =3D 0;
> +
>  	}
>  	host->data =3D NULL;
>  }
> @@ -1191,6 +1241,14 @@ static void omap_hsmmc_do_irq(struct omap_hsmm=
c_host *host, int status)
>  			}
>  			dev_dbg(mmc_dev(host->mmc), "AC12 err: 0x%x\n", ac12);
>  		}
> +
> +		if (status & ADMAE_EN) {
> +			u32 val;
> +
> +			val =3D OMAP_HSMMC_READ(host->base, ADMAES);
> +			dev_dbg(mmc_dev(host->mmc), "ADMA error status: 0x%x\n",
> +				val);
> +		}
>  	}
> =20
>  	OMAP_HSMMC_WRITE(host->base, STAT, status);
> @@ -1378,6 +1436,7 @@ static int omap_hsmmc_pre_dma_transfer(struct o=
map_hsmmc_host *host,
>  				       struct dma_chan *chan)
>  {
>  	int dma_len;
> +	struct device *dev;
> =20
>  	if (!next && data->host_cookie &&
>  	    data->host_cookie !=3D host->next_data.cookie) {
> @@ -1387,9 +1446,14 @@ static int omap_hsmmc_pre_dma_transfer(struct =
omap_hsmmc_host *host,
>  		data->host_cookie =3D 0;
>  	}
> =20
> +	if (chan)
> +		dev =3D chan->device->dev;
> +	else
> +		dev =3D mmc_dev(host->mmc);
> +
>  	/* Check if next job is already prepared */
>  	if (next || data->host_cookie !=3D host->next_data.cookie) {
> -		dma_len =3D dma_map_sg(chan->device->dev, data->sg, data->sg_len,
> +		dma_len =3D dma_map_sg(dev, data->sg, data->sg_len,
>  				     omap_hsmmc_get_dma_dir(host, data));
> =20
>  	} else {
> @@ -1516,6 +1580,7 @@ static void omap_hsmmc_start_dma_transfer(struc=
t omap_hsmmc_host *host)
>  {
>  	struct mmc_request *req =3D host->mrq;
>  	struct dma_chan *chan;
> +	int val;
> =20
>  	if (!req->data)
>  		return;
> @@ -1523,10 +1588,66 @@ static void omap_hsmmc_start_dma_transfer(str=
uct omap_hsmmc_host *host)
>  				| (req->data->blocks << 16));
>  	set_data_timeout(host, req->data->timeout_ns,
>  				req->data->timeout_clks);
> -	chan =3D omap_hsmmc_get_dma_chan(host, req->data);
> -	dma_async_issue_pending(chan);
> +
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA) {
> +		val =3D OMAP_HSMMC_READ(host->base, HCTL);
> +		val |=3D DMA_SELECT;
> +		OMAP_HSMMC_WRITE(host->base, HCTL, val);
> +
> +		val =3D OMAP_HSMMC_READ(host->base, CON);
> +		val |=3D DMA_MASTER;
> +		OMAP_HSMMC_WRITE(host->base, CON, val);
> +
> +		OMAP_HSMMC_WRITE(host->base, ADMASAL,
> +				 (u32)host->adma_desc_table_addr);
> +	} else {
> +		chan =3D omap_hsmmc_get_dma_chan(host, req->data);
> +		dma_async_issue_pending(chan);
> +	}
> +}
> +
> +static int omap_hsmmc_write_adma_desc(struct omap_hsmmc_host *host, =
void *desc,
> +				      dma_addr_t addr, u16 len, u8 attr)
> +{
> +	struct omap_hsmmc_adma_desc *dma_desc =3D desc;
> +
> +	dma_desc->len =3D len;
> +	dma_desc->addr =3D (u32)addr;
> +	dma_desc->reserved =3D 0;
> +	dma_desc->attr =3D attr;
> +
> +	return 0;
>  }
> =20
> +static int omap_hsmmc_setup_adma_transfer(struct omap_hsmmc_host *ho=
st,
> +					  struct mmc_request *req)
> +{
> +	struct mmc_data *data =3D req->data;
> +	struct scatterlist *sg;
> +	int i;
> +	int len;
> +	int ret;
> +	dma_addr_t addr;
> +	struct omap_hsmmc_adma_desc *dma_desc;
> +
> +	ret =3D omap_hsmmc_pre_dma_transfer(host, data, NULL, NULL);
> +	if (ret)
> +		return ret;
> +
> +	dma_desc =3D host->adma_desc_table;
> +	for_each_sg(data->sg, sg, host->dma_len, i) {
> +		addr =3D sg_dma_address(sg);
> +		len =3D sg_dma_len(sg);
> +		WARN_ON(len > ADMA_MAX_LEN);
> +		omap_hsmmc_write_adma_desc(host, dma_desc, addr, len,
> +					   ADMA_DESC_ATTR_VALID |
> +					   ADMA_DESC_TRANSFER_DATA);
> +		dma_desc++;
> +	}
> +	omap_hsmmc_write_adma_desc(host, dma_desc, 0, 0, ADMA_DESC_ATTR_END=
);
> +
> +	return 0;
> +}

Would be nice to group the ADMA functions in one section, not scatterin=
g it
around the driver.

>  /*
>   * Configure block length for MMC/SD cards and initiate the transfer=
=2E
>   */
> @@ -1547,10 +1668,18 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_hos=
t *host, struct mmc_request *req)
>  		return 0;
>  	}
> =20
> -	ret =3D omap_hsmmc_setup_dma_transfer(host, req);
> -	if (ret !=3D 0) {
> -		dev_err(mmc_dev(host->mmc), "MMC start dma failure\n");
> -		return ret;
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA) {
> +		ret =3D omap_hsmmc_setup_adma_transfer(host, req);
> +		if (ret !=3D 0) {
> +			dev_err(mmc_dev(host->mmc), "MMC adma setup failed\n");
> +			return ret;
> +		}
> +	} else {
> +		ret =3D omap_hsmmc_setup_dma_transfer(host, req);
> +		if (ret !=3D 0) {
> +			dev_err(mmc_dev(host->mmc), "MMC start dma failure\n");
> +			return ret;

the error checking can go outside

> +		}
>  	}
>  	return 0;

	if (ret !=3D 0)
		dev_err(mmc_dev(host->mmc), "MMC start dma failure\n");
	return ret;

if compiler complains about ret not beeing initialized
int rer =3D 0;

>  }
> @@ -1560,11 +1689,18 @@ static void omap_hsmmc_post_req(struct mmc_ho=
st *mmc, struct mmc_request *mrq,
>  {
>  	struct omap_hsmmc_host *host =3D mmc_priv(mmc);
>  	struct mmc_data *data =3D mrq->data;
> +	struct device *dev;
> +	struct dma_chan *c;
> =20
>  	if (data->host_cookie) {
> -		struct dma_chan *c =3D omap_hsmmc_get_dma_chan(host, data);
> +		if (!(host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)) {
> +			c =3D omap_hsmmc_get_dma_chan(host, mrq->data);
> +			dev =3D c->device->dev;
> +		} else {
> +			dev =3D mmc_dev(mmc);
> +		}
> =20
> -		dma_unmap_sg(c->device->dev, data->sg, data->sg_len,
> +		dma_unmap_sg(dev, data->sg, data->sg_len,
>  			     omap_hsmmc_get_dma_dir(host, data));
>  		data->host_cookie =3D 0;
>  	}
> @@ -1574,13 +1710,15 @@ static void omap_hsmmc_pre_req(struct mmc_hos=
t *mmc, struct mmc_request *mrq,
>  			       bool is_first_req)
>  {
>  	struct omap_hsmmc_host *host =3D mmc_priv(mmc);
> +	struct dma_chan *c =3D NULL;
> =20
>  	if (mrq->data->host_cookie) {
>  		mrq->data->host_cookie =3D 0;
>  		return ;
>  	}
> =20
> -	struct dma_chan *c =3D omap_hsmmc_get_dma_chan(host, mrq->data);
> +	if (!(host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA))
> +		c =3D omap_hsmmc_get_dma_chan(host, mrq->data);
> =20
>  	if (omap_hsmmc_pre_dma_transfer(host, mrq->data,
>  					&host->next_data, c))
> @@ -1967,6 +2105,9 @@ static struct omap_hsmmc_platform_data *of_get_=
hsmmc_pdata(struct device *dev)
>  	if (of_find_property(np, "ti,dual-volt", NULL))
>  		pdata->controller_flags |=3D OMAP_HSMMC_SUPPORTS_DUAL_VOLT;
> =20
> +	if (of_find_property(np, "ti,use_adma", NULL))
> +		pdata->controller_flags |=3D OMAP_HSMMC_USE_ADMA;
> +
>  	pdata->gpio_cd =3D -EINVAL;
>  	pdata->gpio_cod =3D -EINVAL;
>  	pdata->gpio_wp =3D -EINVAL;
> @@ -1992,6 +2133,84 @@ static inline struct omap_hsmmc_platform_data
>  }
>  #endif
> =20
> +static int omap_hsmmc_adma_init(struct omap_hsmmc_host *host)
> +{
> +	struct mmc_host *mmc =3D host->mmc;
> +
> +	host->adma_desc_table =3D dma_alloc_coherent(host->dev, mmc->max_se=
gs + 1,
> +						   &host->adma_desc_table_addr,
> +						   GFP_KERNEL);
> +	if (!host->adma_desc_table) {
> +		dev_err(host->dev, "failed to allocate adma desc table\n");
> +		return -ENOMEM;

=46all back to Slave DMA?

> +	}
> +
> +	return 0;
> +}
> +
> +static void omap_hsmmc_adma_exit(struct omap_hsmmc_host *host)
> +{
> +	struct mmc_host *mmc =3D host->mmc;
> +
> +	dma_free_coherent(host->dev, mmc->max_segs + 1,
> +			  host->adma_desc_table, host->adma_desc_table_addr);
> +}
> +
> +static int omap_hsmmc_dma_init(struct omap_hsmmc_host *host)
> +{
> +	dma_cap_mask_t mask;
> +	unsigned int tx_req, rx_req;
> +	struct resource *res;
> +	struct platform_device *pdev =3D to_platform_device(host->dev);
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	if (!pdev->dev.of_node) {
> +		res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> +		if (!res) {
> +			dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> +			return -ENXIO;
> +		}
> +		tx_req =3D res->start;
> +
> +		res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> +		if (!res) {
> +			dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
> +			return -ENXIO;
> +		}
> +		rx_req =3D res->start;
> +	}
> +
> +	host->rx_chan =3D
> +		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> +						 &rx_req, &pdev->dev, "rx");
> +
> +	if (!host->rx_chan) {
> +		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channe=
l\n");
> +		return -ENXIO;
> +	}
> +
> +	host->tx_chan =3D
> +		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> +						 &tx_req, &pdev->dev, "tx");
> +
> +	if (!host->tx_chan) {
> +		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channe=
l\n");
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static void omap_hsmmc_dma_exit(struct omap_hsmmc_host *host)
> +{
> +	if (host->tx_chan)
> +		dma_release_channel(host->tx_chan);
> +	if (host->rx_chan)
> +		dma_release_channel(host->rx_chan);
> +}
> +
>  static int omap_hsmmc_probe(struct platform_device *pdev)
>  {
>  	struct omap_hsmmc_platform_data *pdata =3D pdev->dev.platform_data;
> @@ -2000,8 +2219,6 @@ static int omap_hsmmc_probe(struct platform_dev=
ice *pdev)
>  	struct resource *res;
>  	int ret, irq;
>  	const struct of_device_id *match;
> -	dma_cap_mask_t mask;
> -	unsigned tx_req, rx_req;
>  	const struct omap_mmc_of_data *data;
>  	void __iomem *base;
> =20
> @@ -2114,7 +2331,10 @@ static int omap_hsmmc_probe(struct platform_de=
vice *pdev)
>  	mmc->max_blk_size =3D 512;       /* Block Length at max can be 1024=
 */
>  	mmc->max_blk_count =3D 0xFFFF;    /* No. of Blocks is 16 bits */
>  	mmc->max_req_size =3D mmc->max_blk_size * mmc->max_blk_count;
> -	mmc->max_seg_size =3D mmc->max_req_size;
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)
> +		mmc->max_seg_size =3D ADMA_MAX_LEN;
> +	else
> +		mmc->max_seg_size =3D mmc->max_req_size;
> =20
>  	mmc->caps |=3D MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
>  		     MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_ERASE;
> @@ -2130,46 +2350,12 @@ static int omap_hsmmc_probe(struct platform_d=
evice *pdev)
> =20
>  	omap_hsmmc_conf_bus_power(host);
> =20
> -	if (!pdev->dev.of_node) {
> -		res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "tx");
> -		if (!res) {
> -			dev_err(mmc_dev(host->mmc), "cannot get DMA TX channel\n");
> -			ret =3D -ENXIO;
> -			goto err_irq;
> -		}
> -		tx_req =3D res->start;
> -
> -		res =3D platform_get_resource_byname(pdev, IORESOURCE_DMA, "rx");
> -		if (!res) {
> -			dev_err(mmc_dev(host->mmc), "cannot get DMA RX channel\n");
> -			ret =3D -ENXIO;
> -			goto err_irq;
> -		}
> -		rx_req =3D res->start;
> -	}
> -
> -	dma_cap_zero(mask);
> -	dma_cap_set(DMA_SLAVE, mask);
> -
> -	host->rx_chan =3D
> -		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> -						 &rx_req, &pdev->dev, "rx");
> -
> -	if (!host->rx_chan) {
> -		dev_err(mmc_dev(host->mmc), "unable to obtain RX DMA engine channe=
l\n");
> -		ret =3D -ENXIO;
> -		goto err_irq;
> -	}
> -
> -	host->tx_chan =3D
> -		dma_request_slave_channel_compat(mask, omap_dma_filter_fn,
> -						 &tx_req, &pdev->dev, "tx");
> -
> -	if (!host->tx_chan) {
> -		dev_err(mmc_dev(host->mmc), "unable to obtain TX DMA engine channe=
l\n");
> -		ret =3D -ENXIO;
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)
> +		ret =3D omap_hsmmc_adma_init(host);
> +	else
> +		ret =3D omap_hsmmc_dma_init(host);
> +	if (ret)
>  		goto err_irq;
> -	}
> =20
>  	/* Request IRQ for MMC operations */
>  	ret =3D devm_request_irq(&pdev->dev, host->irq, omap_hsmmc_irq, 0,
> @@ -2225,11 +2411,11 @@ err_slot_name:
>  	mmc_remove_host(mmc);
>  err_irq:
>  	device_init_wakeup(&pdev->dev, false);
> -	if (host->tx_chan)
> -		dma_release_channel(host->tx_chan);
> -	if (host->rx_chan)
> -		dma_release_channel(host->rx_chan);
>  	pm_runtime_dont_use_autosuspend(host->dev);
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)
> +		omap_hsmmc_adma_exit(host);
> +	else
> +		omap_hsmmc_dma_exit(host);
>  	pm_runtime_put_sync(host->dev);
>  	pm_runtime_disable(host->dev);
>  	if (host->dbclk)
> @@ -2248,8 +2434,10 @@ static int omap_hsmmc_remove(struct platform_d=
evice *pdev)
>  	pm_runtime_get_sync(host->dev);
>  	mmc_remove_host(host->mmc);
> =20
> -	dma_release_channel(host->tx_chan);
> -	dma_release_channel(host->rx_chan);
> +	if (host->pdata->controller_flags & OMAP_HSMMC_USE_ADMA)
> +		omap_hsmmc_adma_exit(host);
> +	else
> +		omap_hsmmc_dma_exit(host);
> =20
>  	pm_runtime_dont_use_autosuspend(host->dev);
>  	pm_runtime_put_sync(host->dev);
> diff --git a/include/linux/platform_data/hsmmc-omap.h b/include/linux=
/platform_data/hsmmc-omap.h
> index 8e981be..e26013d 100644
> --- a/include/linux/platform_data/hsmmc-omap.h
> +++ b/include/linux/platform_data/hsmmc-omap.h
> @@ -27,6 +27,7 @@
>  #define OMAP_HSMMC_SUPPORTS_DUAL_VOLT		BIT(0)
>  #define OMAP_HSMMC_BROKEN_MULTIBLOCK_READ	BIT(1)
>  #define OMAP_HSMMC_SWAKEUP_MISSING		BIT(2)
> +#define OMAP_HSMMC_USE_ADMA			BIT(3)
> =20
>  struct omap_hsmmc_dev_attr {
>  	u8 flags;
>=20


--=20
P=E9ter
