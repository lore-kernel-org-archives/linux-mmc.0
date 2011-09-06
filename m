From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH 1/2] omap: hsmmc: Normalize dma cleanup operations
Date: Wed, 7 Sep 2011 00:33:28 +0530
Message-ID: <CAF=Qhp1BedGcJFF9BNmHsCAOw1FqiAE-EySD_HTKemYjx9gM7w@mail.gmail.com>
References: <1314903957-24408-2-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61166 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899Ab1IFTIh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Sep 2011 15:08:37 -0400
In-Reply-To: <1314903957-24408-2-git-send-email-svenkatr@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, per.forlin@linaro.org, cjb@laptop.org

On Fri, Sep 2, 2011 at 12:35 AM, Venkatraman S <svenkatr@ti.com> wrote:
> Reuse omap_hsmmc_dma_cleanup even for normal dma teardown in
> omap_hsmmc_dma_cb. Consolidate multiple points of dma unmap into a
> single location in post_req function, to prevent double unmapping.
>
> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 20 +++++---------------
> =A01 files changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 21e4a79..5b7776c 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -999,7 +999,8 @@ static void omap_hsmmc_dma_cleanup(struct omap_hs=
mmc_host *host, int errno)
> =A0{
> =A0 =A0 =A0 =A0int dma_ch;
>
> - =A0 =A0 =A0 host->data->error =3D errno;
> + =A0 =A0 =A0 if (host->data)

The condition check above becomes redundant since dma_cleanup is
called during errors in omap_hsmmc_do_irq. Better have this check in
the dma_cb where dma_cleanup is newly added.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data->error =3D errno;
>
> =A0 =A0 =A0 =A0spin_lock(&host->irq_lock);
> =A0 =A0 =A0 =A0dma_ch =3D host->dma_ch;
> @@ -1007,12 +1008,8 @@ static void omap_hsmmc_dma_cleanup(struct omap=
_hsmmc_host *host, int errno)
> =A0 =A0 =A0 =A0spin_unlock(&host->irq_lock);
>
> =A0 =A0 =A0 =A0if (host->use_dma && dma_ch !=3D -1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), host->=
data->sg,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data->sg_len,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_get_dma_dir(=
host, host->data));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_free_dma(dma_ch);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 host->data =3D NULL;

No need to remove the above one.

> =A0}
>
> =A0/*
> @@ -1370,7 +1367,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_s=
tatus, void *cb_data)
> =A0{
> =A0 =A0 =A0 =A0struct omap_hsmmc_host *host =3D cb_data;
> =A0 =A0 =A0 =A0struct mmc_data *data;
> - =A0 =A0 =A0 int dma_ch, req_in_progress;
> + =A0 =A0 =A0 int req_in_progress;
>
> =A0 =A0 =A0 =A0if (!(ch_status & OMAP_DMA_BLOCK_IRQ)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_warn(mmc_dev(host->mmc), "unexpect=
ed dma status %x\n",
> @@ -1394,16 +1391,9 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_=
status, void *cb_data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 if (!data->host_cookie)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data->=
sg, data->sg_len,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_g=
et_dma_dir(host, data));
> -
> =A0 =A0 =A0 =A0req_in_progress =3D host->req_in_progress;
> - =A0 =A0 =A0 dma_ch =3D host->dma_ch;
> - =A0 =A0 =A0 host->dma_ch =3D -1;
> =A0 =A0 =A0 =A0spin_unlock(&host->irq_lock);
> -
> - =A0 =A0 =A0 omap_free_dma(dma_ch);
> + =A0 =A0 =A0 omap_hsmmc_dma_cleanup(host, 0);
>
> =A0 =A0 =A0 =A0/* If DMA has finished after TC, complete the request =
*/
> =A0 =A0 =A0 =A0if (!req_in_progress) {
> @@ -1575,7 +1565,7 @@ static void omap_hsmmc_post_req(struct mmc_host=
 *mmc, struct mmc_request *mrq,
> =A0 =A0 =A0 =A0struct omap_hsmmc_host *host =3D mmc_priv(mmc);
> =A0 =A0 =A0 =A0struct mmc_data *data =3D mrq->data;
>
> - =A0 =A0 =A0 if (host->use_dma) {

Here also , the above conditional check is required.

> + =A0 =A0 =A0 if (data->host_cookie) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_unmap_sg(mmc_dev(host->mmc), data-=
>sg, data->sg_len,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_ge=
t_dma_dir(host, data));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->host_cookie =3D 0;
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
