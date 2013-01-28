From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] goldfish: emulated MMC device
Date: Mon, 28 Jan 2013 17:04:29 -0500
Message-ID: <87boc96k2a.fsf@laptop.org>
References: <20130121234339.19859.80987.stgit@bob.linux.org.uk>
	<CAGxe1ZGu4mQRPy=17-G2pBqVOTgwHs4pAsJZ8Bb2V+HNiiq2JA@mail.gmail.com>
	<20130122224701.5785e345@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:40898 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754552Ab3A1WFH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jan 2013 17:05:07 -0500
In-Reply-To: <20130122224701.5785e345@bob.linux.org.uk> (Alan Cox's message of
	"Tue, 22 Jan 2013 22:47:01 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Girish K S <girish.shivananjappa@linaro.org>, linux-mmc@vger.kernel.org

Hi,

On Tue, Jan 22 2013, Alan Cox wrote:
>> does it support dt? i cannot see and table entry here? I think Nall =
ew
>> drivers added should be dt compatible.
>> there should be a of table entry here
>
> [..]
> Goldfish is an established platform used for most Android development
> work nowdays so we don't get to re-decide how it works just support i=
t.

I agree that we should go ahead and merge this given that it's in
widespread use already.

Does anyone mind if I change the filename to
drivers/mmc/host/android-goldfish.c?  Kconfig will stay the same.

I've also made trivial style edits and converted from ISO-8859 to
UTF-8, as attached.

Queued in mmc-next for 3.9, thanks,

- Chris.

diff --git a/drivers/mmc/host/goldfish.c b/drivers/mmc/host/goldfish.c
index 5763f78..ef3aef0 100644
--- a/drivers/mmc/host/goldfish.c
+++ b/drivers/mmc/host/goldfish.c
@@ -4,7 +4,7 @@
  *
  *  based on omap.c driver, which was
  *  Copyright (C) 2004 Nokia Corporation
- *  Written by Tuukka Tikkanen and Juha Yrj=C3=B6l=C3=A4<juha.yrjola@n=
okia.com>
+ *  Written by Tuukka Tikkanen and Juha Yrj=C3=83=C2=B6l=C3=83=C2=A4 <=
juha.yrjola@nokia.com>
  *  Misc hacks here and there by Tony Lindgren <tony@atomide.com>
  *  Other hacks (DMA, SD, etc) by David Brownell
  *
@@ -58,7 +58,6 @@
 #define GOLDFISH_MMC_READ(host, addr)   (readl(host->reg_base + addr))
 #define GOLDFISH_MMC_WRITE(host, addr, x)   (writel(x, host->reg_base =
+ addr))
=20
-
 enum {
 	/* status register */
 	MMC_INT_STATUS	        =3D 0x00,
@@ -140,12 +139,12 @@ goldfish_mmc_cover_is_open(struct goldfish_mmc_ho=
st *host)
=20
 static ssize_t
 goldfish_mmc_show_cover_switch(struct device *dev,
-	struct device_attribute *attr, char *buf)
+			       struct device_attribute *attr, char *buf)
 {
 	struct goldfish_mmc_host *host =3D dev_get_drvdata(dev);
=20
 	return sprintf(buf, "%s\n", goldfish_mmc_cover_is_open(host) ? "open"=
 :
-			"closed");
+		       "closed");
 }
=20
 static DEVICE_ATTR(cover_switch, S_IRUGO, goldfish_mmc_show_cover_swit=
ch, NULL);
@@ -208,7 +207,7 @@ goldfish_mmc_start_command(struct goldfish_mmc_host=
 *host, struct mmc_command *c
 }
=20
 static void goldfish_mmc_xfer_done(struct goldfish_mmc_host *host,
-							struct mmc_data *data)
+				   struct mmc_data *data)
 {
 	if (host->dma_in_use) {
 		enum dma_data_direction dma_data_dir;
@@ -228,13 +227,14 @@ static void goldfish_mmc_xfer_done(struct goldfis=
h_mmc_host *host,
 		}
 		host->data->bytes_xfered +=3D data->sg->length;
 		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->sg_len,
-								dma_data_dir);
+			     dma_data_dir);
 	}
=20
 	host->data =3D NULL;
 	host->sg_len =3D 0;
=20
-	/* NOTE:  MMC layer will sometimes poll-wait CMD13 next, issuing
+	/*
+	 * NOTE:  MMC layer will sometimes poll-wait CMD13 next, issuing
 	 * dozens of requests until the card finishes writing data.
 	 * It'd be cheaper to just wait till an EOFB interrupt arrives...
 	 */
@@ -249,7 +249,7 @@ static void goldfish_mmc_xfer_done(struct goldfish_=
mmc_host *host,
 }
=20
 static void goldfish_mmc_end_of_data(struct goldfish_mmc_host *host,
-							struct mmc_data *data)
+				     struct mmc_data *data)
 {
 	if (!host->dma_in_use) {
 		goldfish_mmc_xfer_done(host, data);
@@ -260,7 +260,7 @@ static void goldfish_mmc_end_of_data(struct goldfis=
h_mmc_host *host,
 }
=20
 static void goldfish_mmc_cmd_done(struct goldfish_mmc_host *host,
-						struct mmc_command *cmd)
+				  struct mmc_command *cmd)
 {
 	host->cmd =3D NULL;
 	if (cmd->flags & MMC_RSP_PRESENT) {
@@ -364,7 +364,7 @@ static irqreturn_t goldfish_mmc_irq(int irq, void *=
dev_id)
 }
=20
 static void goldfish_mmc_prepare_data(struct goldfish_mmc_host *host,
-						struct mmc_request *req)
+				      struct mmc_request *req)
 {
 	struct mmc_data *data =3D req->data;
 	int block_size;
@@ -384,7 +384,8 @@ static void goldfish_mmc_prepare_data(struct goldfi=
sh_mmc_host *host,
 	GOLDFISH_MMC_WRITE(host, MMC_BLOCK_COUNT, data->blocks - 1);
 	GOLDFISH_MMC_WRITE(host, MMC_BLOCK_LENGTH, block_size - 1);
=20
-	/* cope with calling layer confusion; it issues "single
+	/*
+	 * Cope with calling layer confusion; it issues "single
 	 * block" writes using multi-block scatterlists.
 	 */
 	sg_len =3D (data->blocks =3D=3D 1) ? 1 : data->sg_len;
@@ -395,13 +396,15 @@ static void goldfish_mmc_prepare_data(struct gold=
fish_mmc_host *host,
 		dma_data_dir =3D DMA_FROM_DEVICE;
=20
 	host->sg_len =3D dma_map_sg(mmc_dev(host->mmc), data->sg,
-				sg_len, dma_data_dir);
+				  sg_len, dma_data_dir);
 	host->dma_done =3D 0;
 	host->dma_in_use =3D 1;
=20
 	if (dma_data_dir =3D=3D DMA_TO_DEVICE) {
-		/* we don't really have DMA, so we need to copy to our
-		   platform driver buffer */
+		/*
+		 * We don't really have DMA, so we need to copy to our
+		 * platform driver buffer
+		 */
 		const uint8_t *src =3D (uint8_t *)sg_virt(data->sg);
 		memcpy(host->virt_base, src, data->sg->length);
 	}
@@ -417,10 +420,12 @@ static void goldfish_mmc_request(struct mmc_host =
*mmc, struct mmc_request *req)
 	goldfish_mmc_prepare_data(host, req);
 	goldfish_mmc_start_command(host, req->cmd);
=20
-	/* this is to avoid accidentally being detected as an SDIO card
-	   in mmc_attach_sdio() */
+	/*
+	 * This is to avoid accidentally being detected as an SDIO card
+	 * in mmc_attach_sdio().
+	 */
 	if (req->cmd->opcode =3D=3D SD_IO_SEND_OP_COND &&
-		req->cmd->flags =3D=3D (MMC_RSP_SPI_R4 | MMC_RSP_R4 | MMC_CMD_BCR))
+	    req->cmd->flags =3D=3D (MMC_RSP_SPI_R4 | MMC_RSP_R4 | MMC_CMD_BCR=
))
 		req->cmd->error =3D -EINVAL;
 }
=20
@@ -477,7 +482,7 @@ static int goldfish_mmc_probe(struct platform_devic=
e *pdev)
 		goto ioremap_failed;
 	}
 	host->virt_base =3D dma_alloc_coherent(&pdev->dev, BUFFER_SIZE,
-							&buf_addr, GFP_KERNEL);
+					     &buf_addr, GFP_KERNEL);
=20
 	if (host->virt_base =3D=3D 0) {
 		ret =3D -ENOMEM;
@@ -507,7 +512,6 @@ static int goldfish_mmc_probe(struct platform_devic=
e *pdev)
 	ret =3D request_irq(host->irq, goldfish_mmc_irq, 0, DRIVER_NAME, host=
);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed IRQ Adding goldfish MMC\n");
-
 		goto err_request_irq_failed;
 	}
=20
@@ -517,19 +521,19 @@ static int goldfish_mmc_probe(struct platform_dev=
ice *pdev)
 	ret =3D device_create_file(&pdev->dev, &dev_attr_cover_switch);
 	if (ret)
 		dev_warn(mmc_dev(host->mmc),
-				"Unable to create sysfs attributes\n");
+			 "Unable to create sysfs attributes\n");
=20
 	GOLDFISH_MMC_WRITE(host, MMC_SET_BUFFER, host->phys_base);
 	GOLDFISH_MMC_WRITE(host, MMC_INT_ENABLE,
-		MMC_STAT_END_OF_CMD | MMC_STAT_END_OF_DATA |
-		MMC_STAT_STATE_CHANGE | MMC_STAT_CMD_TIMEOUT);
+			   MMC_STAT_END_OF_CMD | MMC_STAT_END_OF_DATA |
+			   MMC_STAT_STATE_CHANGE | MMC_STAT_CMD_TIMEOUT);
=20
 	mmc_add_host(mmc);
 	return 0;
=20
 err_request_irq_failed:
 	dma_free_coherent(&pdev->dev, BUFFER_SIZE, host->virt_base,
-							host->phys_base);
+			  host->phys_base);
 dma_alloc_failed:
 	iounmap(host->reg_base);
 ioremap_failed:

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
