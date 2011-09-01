From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH] mmc: omap_hsmmc: DMA unmap only once in case of MMC error
Date: Fri, 2 Sep 2011 00:49:21 +0530
Message-ID: <CANfBPZ-azGV0H7asRHD5+vdFjCkrx=E2Oypnrk_SW9K5+DwTLQ@mail.gmail.com>
References: <1314569323-6886-1-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:46344 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757264Ab1IATTm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 1 Sep 2011 15:19:42 -0400
In-Reply-To: <1314569323-6886-1-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, Santosh <santosh.shilimkar@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, Chris Ball <cjb@laptop.org>, Nicolas Pitre <nicolas.pitre@linaro.org>

On Mon, Aug 29, 2011 at 3:38 AM, Per Forlin <per.forlin@linaro.org> wro=
te:
> Reported by Russell King:
> ------------
> mmcblk0: error -84 transferring data, sector 149201, nr 64,
> cmd response 0x900, card status 0xb00
> mmcblk0: retrying using single block read
>
> WARNING: at /home/rmk/git/linux-2.6-rmk/lib/dma-debug.c:811 check_unm=
ap
> omap_hsmmc omap_hsmmc.0: DMA-API: device driver tries to free DMA mem=
ory
> it has not allocated [device address=3D0x0000000080933000] [size=3D20=
480 bytes]
> -------------
>
> In case of an error dma_unmap() is issued in omap_hsmmc_dma_cleanup()
> and then again in omap_hsmmc_post_req(). Resolve this by clearing the
> host_cookie to indicate there is no DMA mapped memory to unmap.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> Bug fix on 3.1-rc3
>
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A07 +++++--
> =A01 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 21e4a79..31d9817 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1011,6 +1011,7 @@ static void omap_hsmmc_dma_cleanup(struct omap_=
hsmmc_host *host, int errno)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->data->sg_len,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_get_dma_dir=
(host, host->data));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_free_dma(dma_ch);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data->host_cookie =3D 0;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0host->data =3D NULL;
> =A0}
> @@ -1576,8 +1577,10 @@ static void omap_hsmmc_post_req(struct mmc_hos=
t *mmc, struct mmc_request *mrq,
> =A0 =A0 =A0 =A0struct mmc_data *data =3D mrq->data;
>
> =A0 =A0 =A0 =A0if (host->use_dma) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data->=
sg, data->sg_len,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_g=
et_dma_dir(host, data));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->host_cookie)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(ho=
st->mmc), data->sg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0data->sg_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0omap_hsmmc_get_dma_dir(host, data));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->host_cookie =3D 0;
> =A0 =A0 =A0 =A0}
> =A0}
> --
> 1.7.4.1
>
>

I just posted a patch [1] which just consolidates all unmapping to
just post_req.
This would obviously prevent double unmapping, and keeps all the relate=
d
dma operations at a single place. Let me know if that works better.

[1]: http://marc.info/?l=3Dlinux-mmc&m=3D131490406920616&w=3D2
