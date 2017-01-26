From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] mmc: host: constify mmc_host_ops structures
Date: Thu, 26 Jan 2017 20:20:34 +0530
Message-ID: <1485442234-2900-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, ulf.hansson@linaro.org, matthias.bgg@gmail.com, saschasommer@freenet.de, maxime.ripard@free-electrons.com, wens@csie.org, tony.olech@elandigitalsystems.com, linux@prisktech.co.nz, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Declare mmc_host_ops structures as const as they are only stored in the
ops field of a mmc_host structure. This field is of type const, so
mmc_host_ops structures having this property can be made const too.
Done using Coccinelle:

@r disable optional_qualifier@
identifier x;
position p;
@@
static struct mmc_host_ops x@p={...};

@ok@
struct mmc_host mmc;
identifier r.x;
position p;
@@
mmc.ops=&x@p;

@bad@
position p != {r.p,ok.p};
identifier r.x;
@@
x@p

@depends on !bad disable optional_qualifier@
identifier r.x;
@@
+const
struct mmc_host_ops x;

File size details before and after patching.
First line of every .o file shows the file size before patching
and second line shows the size after patching.

   text	   data	    bss	    dec	    hex	filename

   4710	    344	      0	   5054	   13be	drivers/mmc/host/moxart-mmc.o
   4854	    192	      0	   5046	   13b6	drivers/mmc/host/moxart-mmc.o

  10743	    344	      0	  11087	   2b4f	drivers/mmc/host/mtk-sd.o
  10887	    192	      0	  11079	   2b47	drivers/mmc/host/mtk-sd.o

   2760	    376	      4	   3140	    c44	drivers/mmc/host/sdricoh_cs.o
   2920	    240	      4	   3164	    c5c	drivers/mmc/host/sdricoh_cs.o

   9485	    344	      0	   9829	   2665	drivers/mmc/host/sh_mmcif.o
   9645	    192	      0	   9837	   266d	drivers/mmc/host/sh_mmcif.o

   7281	    344	      0	   7625	   1dc9	drivers/mmc/host/sunxi-mmc.o
   7441	    192	      0	   7633	   1dd1	drivers/mmc/host/sunxi-mmc.o

   4982	    408	      0	   5390	   150e	drivers/mmc/host/toshsd.o
   5142	    264	      0	   5406	   151e	drivers/mmc/host/toshsd.o

  11239	    344	      0	  11583	   2d3f	drivers/mmc/host/usdhi6rol0.o
  11391	    192	      0	  11583	   2d3f	drivers/mmc/host/usdhi6rol0.o

  19444	    541	     29	  20014	   4e2e	drivers/mmc/host/vub300.o
  19604	    381	     29	  20014	   4e2e	drivers/mmc/host/vub300.o

   5487	    376	      0	   5863	   16e7	drivers/mmc/host/wmt-sdmmc.o
   5639	    220	      0	   5859	   16e3	drivers/mmc/host/wmt-sdmmc.o

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/mmc/host/moxart-mmc.c | 2 +-
 drivers/mmc/host/mtk-sd.c     | 2 +-
 drivers/mmc/host/sdricoh_cs.c | 2 +-
 drivers/mmc/host/sh_mmcif.c   | 2 +-
 drivers/mmc/host/sunxi-mmc.c  | 2 +-
 drivers/mmc/host/toshsd.c     | 2 +-
 drivers/mmc/host/usdhi6rol0.c | 2 +-
 drivers/mmc/host/vub300.c     | 2 +-
 drivers/mmc/host/wmt-sdmmc.c  | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/moxart-mmc.c b/drivers/mmc/host/moxart-mmc.c
index bbad309..ac07dab 100644
--- a/drivers/mmc/host/moxart-mmc.c
+++ b/drivers/mmc/host/moxart-mmc.c
@@ -548,7 +548,7 @@ static int moxart_get_ro(struct mmc_host *mmc)
 	return !!(readl(host->base + REG_STATUS) & WRITE_PROT);
 }
 
-static struct mmc_host_ops moxart_ops = {
+static const struct mmc_host_ops moxart_ops = {
 	.request = moxart_request,
 	.set_ios = moxart_set_ios,
 	.get_ro = moxart_get_ro,
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 10ef2ae..fa0c331 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1467,7 +1467,7 @@ static void msdc_hw_reset(struct mmc_host *mmc)
 	sdr_clr_bits(host->base + EMMC_IOCON, 1);
 }
 
-static struct mmc_host_ops mt_msdc_ops = {
+static const struct mmc_host_ops mt_msdc_ops = {
 	.post_req = msdc_post_req,
 	.pre_req = msdc_pre_req,
 	.request = msdc_ops_request,
diff --git a/drivers/mmc/host/sdricoh_cs.c b/drivers/mmc/host/sdricoh_cs.c
index 5ff26ab..6732753 100644
--- a/drivers/mmc/host/sdricoh_cs.c
+++ b/drivers/mmc/host/sdricoh_cs.c
@@ -388,7 +388,7 @@ static int sdricoh_get_ro(struct mmc_host *mmc)
 	return (status & STATUS_CARD_LOCKED);
 }
 
-static struct mmc_host_ops sdricoh_ops = {
+static const struct mmc_host_ops sdricoh_ops = {
 	.request = sdricoh_request,
 	.set_ios = sdricoh_set_ios,
 	.get_ro = sdricoh_get_ro,
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 9007784..93cff28 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1095,7 +1095,7 @@ static int sh_mmcif_get_cd(struct mmc_host *mmc)
 		return p->get_cd(host->pd);
 }
 
-static struct mmc_host_ops sh_mmcif_ops = {
+static const struct mmc_host_ops sh_mmcif_ops = {
 	.request	= sh_mmcif_request,
 	.set_ios	= sh_mmcif_set_ios,
 	.get_cd		= sh_mmcif_get_cd,
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index b1d1303..e75e11a 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1033,7 +1033,7 @@ static int sunxi_mmc_card_busy(struct mmc_host *mmc)
 	return !!(mmc_readl(host, REG_STAS) & SDXC_CARD_DATA_BUSY);
 }
 
-static struct mmc_host_ops sunxi_mmc_ops = {
+static const struct mmc_host_ops sunxi_mmc_ops = {
 	.request	 = sunxi_mmc_request,
 	.set_ios	 = sunxi_mmc_set_ios,
 	.get_ro		 = mmc_gpio_get_ro,
diff --git a/drivers/mmc/host/toshsd.c b/drivers/mmc/host/toshsd.c
index 553ef41..dd961c5 100644
--- a/drivers/mmc/host/toshsd.c
+++ b/drivers/mmc/host/toshsd.c
@@ -550,7 +550,7 @@ static int toshsd_get_cd(struct mmc_host *mmc)
 	return !!(ioread16(host->ioaddr + SD_CARDSTATUS) & SD_CARD_PRESENT_0);
 }
 
-static struct mmc_host_ops toshsd_ops = {
+static const struct mmc_host_ops toshsd_ops = {
 	.request = toshsd_request,
 	.set_ios = toshsd_set_ios,
 	.get_ro = toshsd_get_ro,
diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 1bd5f1a..64da6a8 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1185,7 +1185,7 @@ static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 	return ret;
 }
 
-static struct mmc_host_ops usdhi6_ops = {
+static const struct mmc_host_ops usdhi6_ops = {
 	.request	= usdhi6_request,
 	.set_ios	= usdhi6_set_ios,
 	.get_cd		= usdhi6_get_cd,
diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index bb3e0d1..ec23121 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2083,7 +2083,7 @@ static void vub300_init_card(struct mmc_host *mmc, struct mmc_card *card)
 	dev_info(&vub300->udev->dev, "NO host QUIRKS for this card\n");
 }
 
-static struct mmc_host_ops vub300_mmc_ops = {
+static const struct mmc_host_ops vub300_mmc_ops = {
 	.request = vub300_mmc_request,
 	.set_ios = vub300_mmc_set_ios,
 	.get_ro = vub300_mmc_get_ro,
diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 5af0055..1bf725a 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -725,7 +725,7 @@ static int wmt_mci_get_cd(struct mmc_host *mmc)
 	return !(cd ^ priv->cd_inverted);
 }
 
-static struct mmc_host_ops wmt_mci_ops = {
+static const struct mmc_host_ops wmt_mci_ops = {
 	.request = wmt_mci_request,
 	.set_ios = wmt_mci_set_ios,
 	.get_ro = wmt_mci_get_ro,
-- 
2.7.4
