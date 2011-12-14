From: Huang Shijie <b32955@freescale.com>
Subject: Re: [PATCH 4/4] mtd: gpmi-nand: move to dma_transfer_direction
Date: Wed, 14 Dec 2011 10:20:31 +0800
Message-ID: <4EE807EF.4090109@freescale.com>
References: <1323791286-29574-1-git-send-email-shawn.guo@linaro.org> <1323791286-29574-5-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1323791286-29574-5-git-send-email-shawn.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Vinod Koul <vinod.koul@intel.com>, Chris Ball <cjb@laptop.org>, Artem Bityutskiy <artem.bityutskiy@intel.com>, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

=D3=DA 2011=C4=EA12=D4=C213=C8=D5 23:48, Shawn Guo =D0=B4=B5=C0:
> This patch fixes usage of dma direction to adopt dma_transfer_directi=
on.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/mtd/nand/gpmi-nand/gpmi-lib.c |   22 ++++++++++++----------
>  1 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c b/drivers/mtd/nand=
/gpmi-nand/gpmi-lib.c
> index de4db76..c4c4d6d 100644
> --- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
> @@ -827,7 +827,7 @@ int gpmi_send_command(struct gpmi_nand_data *this=
)
>  	pio[1] =3D pio[2] =3D 0;
>  	desc =3D channel->device->device_prep_slave_sg(channel,
>  					(struct scatterlist *)pio,
> -					ARRAY_SIZE(pio), DMA_NONE, 0);
> +					ARRAY_SIZE(pio), DMA_TRANS_NONE, 0);
>  	if (!desc) {
>  		pr_err("step 1 error\n");
>  		return -1;
> @@ -839,7 +839,7 @@ int gpmi_send_command(struct gpmi_nand_data *this=
)
>  	sg_init_one(sgl, this->cmd_buffer, this->command_length);
>  	dma_map_sg(this->dev, sgl, 1, DMA_TO_DEVICE);
>  	desc =3D channel->device->device_prep_slave_sg(channel,
> -					sgl, 1, DMA_TO_DEVICE, 1);
> +					sgl, 1, DMA_MEM_TO_DEV, 1);
>  	if (!desc) {
>  		pr_err("step 2 error\n");
>  		return -1;
> @@ -872,7 +872,7 @@ int gpmi_send_data(struct gpmi_nand_data *this)
>  	pio[1] =3D 0;
>  	desc =3D channel->device->device_prep_slave_sg(channel,
>  					(struct scatterlist *)pio,
> -					ARRAY_SIZE(pio), DMA_NONE, 0);
> +					ARRAY_SIZE(pio), DMA_TRANS_NONE, 0);
>  	if (!desc) {
>  		pr_err("step 1 error\n");
>  		return -1;
> @@ -881,7 +881,7 @@ int gpmi_send_data(struct gpmi_nand_data *this)
>  	/* [2] send DMA request */
>  	prepare_data_dma(this, DMA_TO_DEVICE);
>  	desc =3D channel->device->device_prep_slave_sg(channel, &this->data=
_sgl,
> -						1, DMA_TO_DEVICE, 1);
> +						1, DMA_MEM_TO_DEV, 1);
>  	if (!desc) {
>  		pr_err("step 2 error\n");
>  		return -1;
> @@ -908,7 +908,7 @@ int gpmi_read_data(struct gpmi_nand_data *this)
>  	pio[1] =3D 0;
>  	desc =3D channel->device->device_prep_slave_sg(channel,
>  					(struct scatterlist *)pio,
> -					ARRAY_SIZE(pio), DMA_NONE, 0);
> +					ARRAY_SIZE(pio), DMA_TRANS_NONE, 0);
>  	if (!desc) {
>  		pr_err("step 1 error\n");
>  		return -1;
> @@ -917,7 +917,7 @@ int gpmi_read_data(struct gpmi_nand_data *this)
>  	/* [2] : send DMA request */
>  	prepare_data_dma(this, DMA_FROM_DEVICE);
>  	desc =3D channel->device->device_prep_slave_sg(channel, &this->data=
_sgl,
> -						1, DMA_FROM_DEVICE, 1);
> +						1, DMA_DEV_TO_MEM, 1);
>  	if (!desc) {
>  		pr_err("step 2 error\n");
>  		return -1;
> @@ -964,7 +964,7 @@ int gpmi_send_page(struct gpmi_nand_data *this,
> =20
>  	desc =3D channel->device->device_prep_slave_sg(channel,
>  					(struct scatterlist *)pio,
> -					ARRAY_SIZE(pio), DMA_NONE, 0);
> +					ARRAY_SIZE(pio), DMA_TRANS_NONE, 0);
>  	if (!desc) {
>  		pr_err("step 2 error\n");
>  		return -1;
> @@ -998,7 +998,8 @@ int gpmi_read_page(struct gpmi_nand_data *this,
>  		| BF_GPMI_CTRL0_XFER_COUNT(0);
>  	pio[1] =3D 0;
>  	desc =3D channel->device->device_prep_slave_sg(channel,
> -				(struct scatterlist *)pio, 2, DMA_NONE, 0);
> +				(struct scatterlist *)pio, 2,
> +				DMA_TRANS_NONE, 0);
>  	if (!desc) {
>  		pr_err("step 1 error\n");
>  		return -1;
> @@ -1027,7 +1028,7 @@ int gpmi_read_page(struct gpmi_nand_data *this,
>  	pio[5] =3D auxiliary;
>  	desc =3D channel->device->device_prep_slave_sg(channel,
>  					(struct scatterlist *)pio,
> -					ARRAY_SIZE(pio), DMA_NONE, 1);
> +					ARRAY_SIZE(pio), DMA_TRANS_NONE, 1);
>  	if (!desc) {
>  		pr_err("step 2 error\n");
>  		return -1;
> @@ -1045,7 +1046,8 @@ int gpmi_read_page(struct gpmi_nand_data *this,
>  		| BF_GPMI_CTRL0_XFER_COUNT(geo->page_size);
>  	pio[1] =3D 0;
>  	desc =3D channel->device->device_prep_slave_sg(channel,
> -				(struct scatterlist *)pio, 2, DMA_NONE, 1);
> +				(struct scatterlist *)pio, 2,
> +				DMA_TRANS_NONE, 1);
>  	if (!desc) {
>  		pr_err("step 3 error\n");
>  		return -1;
It's ok to me.
