From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 3/5] mmc: sh_mobile_sdhi: add some SoC specific data
 for R-Car Gen3
Date: Fri, 16 Jun 2017 09:55:36 +0200
Message-ID: <20170616075534.GH22158@verge.net.au>
References: <1496927368-18897-1-git-send-email-horms+renesas@verge.net.au>
 <1496927368-18897-5-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWrpsRDDqzrxJjt3_V0gjTo9fQiFGRzo=crdaeeHKX2uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdWrpsRDDqzrxJjt3_V0gjTo9fQiFGRzo=crdaeeHKX2uw@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 09, 2017 at 09:34:46AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Jun 8, 2017 at 3:09 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > To avoid complicate code in own dma code for gen3, this patch
> > adds set max_segs to 1. Then, the tmio driver will get requests
> > as sg_len = 1 only.
> 
> The above doesn't seem to match with the actual code changes?
> 
> > In the performance point of view, the CONFIG_MMC_BLOCK_BOUNCE should
> > be set. Otherwise, mmc block layer will set 4-kbyte each as a request.
> 
> FWIW, CONFIG_MMC_BLOCK_BOUNCE is no more in -next.

Thanks.

The code has been shuffled around to the point where this patch doesn't
seem to make much sense as is. I squashed it into the previous patch like this:

mmc: tmio, renesas_sdhi: add max_segs and max_blk_count in tmio_mmc_data

Allow TMIO and SDHI driver implementations to provide values for
max_segs and max_blk_count.

A follow-up patch will set these values for Renesas Gen3 SoCs
the using an SDHI driver.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index eb3ea15ff92d..6f7233fe32a2 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -31,6 +31,8 @@ struct renesas_sdhi_of_data {
 	int scc_offset;
 	struct renesas_sdhi_scc *taps;
 	int taps_num;
+	unsigned int max_blk_count;
+	unsigned short max_segs;
 };
 
 int renesas_sdhi_probe(struct platform_device *pdev,
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f4690cba3443..75c7bf4f7ca2 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -523,6 +523,8 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		mmc_data->capabilities |= of_data->capabilities;
 		mmc_data->capabilities2 |= of_data->capabilities2;
 		mmc_data->dma_rx_offset = of_data->dma_rx_offset;
+		mmc_data->max_blk_count = of_data->max_blk_count;
+		mmc_data->max_segs = of_data->max_segs;
 		dma_priv->dma_buswidth = of_data->dma_buswidth;
 		host->bus_shift = of_data->bus_shift;
 	}
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index fbe38464e7d7..7cb8d3510396 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1248,10 +1248,10 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host,
 
 	mmc->caps |= MMC_CAP_4_BIT_DATA | pdata->capabilities;
 	mmc->caps2 |= pdata->capabilities2;
-	mmc->max_segs = 32;
+	mmc->max_segs = pdata->max_segs ? : 32;
 	mmc->max_blk_size = 512;
-	mmc->max_blk_count = (PAGE_SIZE / mmc->max_blk_size) *
-		mmc->max_segs;
+	mmc->max_blk_count = pdata->max_blk_count ? :
+		(PAGE_SIZE / mmc->max_blk_size) * mmc->max_segs;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
 	mmc->max_seg_size = mmc->max_req_size;
 
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index c83c16b931a8..4e261ea94d6a 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -128,6 +128,8 @@ struct tmio_mmc_data {
 	unsigned int			cd_gpio;
 	int				alignment_shift;
 	dma_addr_t			dma_rx_offset;
+	unsigned int			max_blk_count;
+	unsigned short			max_segs;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 };
