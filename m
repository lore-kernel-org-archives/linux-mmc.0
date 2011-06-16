From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH v4 02/12] omap_hsmmc: use original sg_len for dma_unmap_sg
Date: Thu, 16 Jun 2011 18:46:58 +0530
Message-ID: <BANLkTinWzJ22NrVGofSNvgOcQePD1BKAuA@mail.gmail.com>
References: <1306360653-6196-1-git-send-email-per.forlin@linaro.org>
	<1306360653-6196-3-git-send-email-per.forlin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:40701 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753138Ab1FPNRA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 16 Jun 2011 09:17:00 -0400
In-Reply-To: <1306360653-6196-3-git-send-email-per.forlin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.forlin@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, linaro-dev <linaro-dev@lists.linaro.org>, David Vrabel <david.vrabel@csr.com>

On Thu, May 26, 2011 at 3:27 AM, Per Forlin <per.forlin@linaro.org> wro=
te:
> Don't use the returned sg_len from dma_map_sg() as inparameter
> to dma_unmap_sg(). Use the original sg_len for both dma_map_sg
> and dma_unmap_sg.
>
> Signed-off-by: Per Forlin <per.forlin@linaro.org>
> ---
> =A0drivers/mmc/host/omap_hsmmc.c | =A0 =A05 +++--
> =A01 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index 259ece0..ad3731a 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -959,7 +959,8 @@ static void omap_hsmmc_dma_cleanup(struct omap_hs=
mmc_host *host, int errno)
> =A0 =A0 =A0 =A0spin_unlock(&host->irq_lock);
>
> =A0 =A0 =A0 =A0if (host->use_dma && dma_ch !=3D -1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), host->=
data->sg, host->dma_len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), host->=
data->sg,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data->sg_len,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_get_dma_dir=
(host, host->data));
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_free_dma(dma_ch);
> =A0 =A0 =A0 =A0}
> @@ -1343,7 +1344,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_s=
tatus, void *cb_data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_le=
n,
> + =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data->sg, data->sg_len=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_get_dma_dir(host, data));
>
> =A0 =A0 =A0 =A0req_in_progress =3D host->req_in_progress;
> --
> 1.7.4.1
>

Reviewed-by: Venkatraman S <svenkatr@ti.com>

Perhaps this doesn't belong to $FEATURE and can be posted as a separate=
 patch ?
Thanks,
Venkat.
