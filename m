From: ludovic.desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH] mmc: atmel-mci: fix burst/chunk size modification
Date: Thu, 24 May 2012 09:21:00 +0200
Message-ID: <4FBDE15C.1000607@atmel.com>
References: <1337176838-24111-1-git-send-email-ludovic.desroches@atmel.com>
 <1337176838-24111-2-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1337176838-24111-2-git-send-email-ludovic.desroches@atmel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Ball <cjb@laptop.org>
Cc: nicolas.ferre@atmel.com, ludovic.desroches@atmel.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

I was doing some tests on mmc-next and I had issues with atmel-mci and =

DMA because this patch was missing.

Can you pull it?

Thanks.

Regards.

Ludovic

Le 05/16/2012 04:00 PM, ludovic.desroches@atmel.com a =E9crit :
> From: Nicolas Ferre<nicolas.ferre@atmel.com>
>
> The use of DMA slave config operation requires that the burst size
> (aka chunk size) is specified through this interface.
> Modify atmel-mci slave driver to use this specification on its side.
>
> Signed-off-by: Nicolas Ferre<nicolas.ferre@atmel.com>
> Signed-off-by: Ludovic Desroches<ludovic.desroches@atmel.com>
> ---
>   drivers/mmc/host/atmel-mci-regs.h |   14 ++++++++++++++
>   drivers/mmc/host/atmel-mci.c      |    7 +++++--
>   2 files changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/atmel-mci-regs.h b/drivers/mmc/host/atmel-m=
ci-regs.h
> index 787aba1..ab56f7d 100644
> --- a/drivers/mmc/host/atmel-mci-regs.h
> +++ b/drivers/mmc/host/atmel-mci-regs.h
> @@ -140,4 +140,18 @@
>   #define atmci_writel(port,reg,value)			\
>   	__raw_writel((value), (port)->regs + reg)
>
> +/*
> + * Fix sconfig's burst size according to atmel MCI. We need to convert t=
hem as:
> + * 1 ->  0, 4 ->  1, 8 ->  2, 16 ->  3.
> + *
> + * This can be done by finding most significant bit set.
> + */
> +static inline unsigned int atmci_convert_chksize(unsigned int maxburst)
> +{
> +	if (maxburst>  1)
> +		return fls(maxburst) - 2;
> +	else
> +		return 0;
> +}
> +
>   #endif /* __DRIVERS_MMC_ATMEL_MCI_H__ */
> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
> index 2dbfb28..50e8652 100644
> --- a/drivers/mmc/host/atmel-mci.c
> +++ b/drivers/mmc/host/atmel-mci.c
> @@ -834,6 +834,7 @@ atmci_prepare_data_dma(struct atmel_mci *host, struct=
 mmc_data *data)
>   	enum dma_data_direction		direction;
>   	enum dma_transfer_direction	slave_dirn;
>   	unsigned int			sglen;
> +	u32				maxburst;
>   	u32 iflags;
>
>   	data->error =3D -EINPROGRESS;
> @@ -867,16 +868,18 @@ atmci_prepare_data_dma(struct atmel_mci *host, stru=
ct mmc_data *data)
>   	if (!chan)
>   		return -ENODEV;
>
> -	atmci_writel(host, ATMCI_DMA, ATMCI_DMA_CHKSIZE(3) | ATMCI_DMAEN);
> -
>   	if (data->flags&  MMC_DATA_READ) {
>   		direction =3D DMA_FROM_DEVICE;
>   		host->dma_conf.direction =3D slave_dirn =3D DMA_DEV_TO_MEM;
> +		maxburst =3D atmci_convert_chksize(host->dma_conf.src_maxburst);
>   	} else {
>   		direction =3D DMA_TO_DEVICE;
>   		host->dma_conf.direction =3D slave_dirn =3D DMA_MEM_TO_DEV;
> +		maxburst =3D atmci_convert_chksize(host->dma_conf.dst_maxburst);
>   	}
>
> +	atmci_writel(host, ATMCI_DMA, ATMCI_DMA_CHKSIZE(maxburst) | ATMCI_DMAEN=
);
> +
>   	sglen =3D dma_map_sg(chan->device->dev, data->sg,
>   			data->sg_len, direction);
>
