From: Per Forlin <per.forlin@linaro.org>
Subject: Re: [PATCH] mmc: mxs-mmc: add support for pre_req and post_req
Date: Wed, 20 Apr 2011 09:58:48 +0200
Message-ID: <BANLkTikGEUj-J2kOcd3gjVAtGhm+88DJKQ@mail.gmail.com>
References: <1302116833-24540-1-git-send-email-per.forlin@linaro.org>
	<1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:64431 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab1DTH6t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 03:58:49 -0400
Received: by qyg14 with SMTP id 14so269559qyg.19
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2011 00:58:48 -0700 (PDT)
In-Reply-To: <1303058010-30256-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, cjb@laptop.org

On 17 April 2011 18:33, Shawn Guo <shawn.guo@linaro.org> wrote:
> pre_req() runs dma_map_sg() post_req() runs dma_unmap_sg.
> If not calling pre_req() before mxs_mmc_request(), request()
> will prepare the cache just like it did it before.
> It is optional to use pre_req() and post_req().
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> =A0drivers/mmc/host/mxs-mmc.c | =A0 75 ++++++++++++++++++++++++++++++=
++++++++++++--
> =A01 files changed, 72 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
> index 99d39a6..63c2ae2 100644
> --- a/drivers/mmc/host/mxs-mmc.c
> +++ b/drivers/mmc/host/mxs-mmc.c
> @@ -137,6 +137,10 @@
>
> =A0#define SSP_PIO_NUM =A0 =A03
>
> +struct mxs_mmc_next {
> + =A0 =A0 =A0 s32 cookie;
> +};
> +
> =A0struct mxs_mmc_host {
> =A0 =A0 =A0 =A0struct mmc_host =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 *mmc;
> =A0 =A0 =A0 =A0struct mmc_request =A0 =A0 =A0 =A0 =A0 =A0 =A0*mrq;
> @@ -154,6 +158,7 @@ struct mxs_mmc_host {
> =A0 =A0 =A0 =A0struct mxs_dma_data =A0 =A0 =A0 =A0 =A0 =A0 dma_data;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dm=
a_dir;
> =A0 =A0 =A0 =A0u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 ssp_pio_words[SSP_PIO_NUM];
> + =A0 =A0 =A0 struct mxs_mmc_next =A0 =A0 =A0 =A0 =A0 =A0 next_data;
>
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ve=
rsion;
> =A0 =A0 =A0 =A0unsigned char =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_=
width;
> @@ -302,6 +307,31 @@ static irqreturn_t mxs_mmc_irq_handler(int irq, =
void *dev_id)
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> =A0}
>
> +static int mxs_mmc_prep_dma_data(struct mxs_mmc_host *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
mmc_data *data,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct =
mxs_mmc_next *next)
> +{
> + =A0 =A0 =A0 if (!next && data->host_cookie &&
> + =A0 =A0 =A0 =A0 =A0 data->host_cookie !=3D host->next_data.cookie) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "[%s] invalid cooki=
e: data->host_cookie %d"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" host->next_data.cookie=
 %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, data->host_coo=
kie, host->next_data.cookie);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->host_cookie =3D 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Check if next job is already prepared */
> + =A0 =A0 =A0 if (next || (!next && data->host_cookie !=3D host->next=
_data.cookie))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dma_map_sg(mmc_dev(host->mmc), data=
->sg, data->sg_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(data->f=
lags & MMC_DATA_WRITE) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0DMA_TO_D=
EVICE : DMA_FROM_DEVICE) =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 if (next)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->host_cookie =3D ++next->cookie < =
0 ? 1 : next->cookie;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0static struct dma_async_tx_descriptor *mxs_mmc_prep_dma(
> =A0 =A0 =A0 =A0struct mxs_mmc_host *host, unsigned int append)
> =A0{
> @@ -312,8 +342,8 @@ static struct dma_async_tx_descriptor *mxs_mmc_pr=
ep_dma(
>
> =A0 =A0 =A0 =A0if (data) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* data */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_map_sg(mmc_dev(host->mmc), data->sg=
,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->sg_len, ho=
st->dma_dir);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (mxs_mmc_prep_dma_data(host, data, N=
ULL))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sgl =3D data->sg;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sg_len =3D data->sg_len;
> =A0 =A0 =A0 =A0} else {
> @@ -328,9 +358,11 @@ static struct dma_async_tx_descriptor *mxs_mmc_p=
rep_dma(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->callback =3D mxs_mmc_dma_irq_cal=
lback;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0desc->callback_param =3D host;
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_unmap_sg(mmc_dev(h=
ost->mmc), data->sg,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 data->sg_len, host->dma_dir);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->host_cookie =3D 0=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
When is dma_unmap_sg called? If host_cookie is set dma_unmap() should
only be called from post_req.
My guess is
+ if (data && !data->host_cookie) {
It looks like only dma_map is run in parallel with transfer but not
dma_unmap. This may explain the numbers.
