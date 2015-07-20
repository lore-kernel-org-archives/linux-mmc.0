From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/1 linux-next] mmc: omap: use for_each_sg() for
 scatterlist parsing
Date: Mon, 20 Jul 2015 16:20:49 +0200
Message-ID: <CAPDyKFqCBN1BT3O62-N9hL8ga0YgiOurkrnVOJqbTtVvtWZBuQ@mail.gmail.com>
References: <1434482116-29583-1-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434482116-29583-1-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jarkko Lavinen <jarkko.lavinen@nokia.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 16 June 2015 at 21:15, Fabian Frederick <fabf@skynet.be> wrote:
> See Documentation/DMA-API.txt - Part Id
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Thanks, applied!

Kind regards
Uffe

> ---
> This is untested.
>
>  drivers/mmc/host/omap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
> index 68dd6c7..70dcf07 100644
> --- a/drivers/mmc/host/omap.c
> +++ b/drivers/mmc/host/omap.c
> @@ -948,6 +948,7 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
>  {
>         struct mmc_data *data = req->data;
>         int i, use_dma = 1, block_size;
> +       struct scatterlist *sg;
>         unsigned sg_len;
>
>         host->data = data;
> @@ -972,8 +973,8 @@ mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
>         sg_len = (data->blocks == 1) ? 1 : data->sg_len;
>
>         /* Only do DMA for entire blocks */
> -       for (i = 0; i < sg_len; i++) {
> -               if ((data->sg[i].length % block_size) != 0) {
> +       for_each_sg(data->sg, sg, sg_len, i) {
> +               if ((sg->length % block_size) != 0) {
>                         use_dma = 0;
>                         break;
>                 }
> --
> 2.4.2
>
