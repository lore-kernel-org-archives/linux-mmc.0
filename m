From: Alexander Varnin <fenixk19-JGs/UdohzUI@public.gmane.org>
Subject: Re: mwifiex_sdio on chromebook
Date: Mon, 04 Nov 2013 06:18:14 +0400
Message-ID: <527703E6.8040504@mail.ru>
References: <5276491F.20207@mail.ru> <477F20668A386D41ADCC57781B1F70430F45757E63@SC-VEXCH1.marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060700000200060503010602"
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <477F20668A386D41ADCC57781B1F70430F45757E63-r8ILAu4/owuHXkj8w7BxOhL4W9x8LtSr@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bing Zhao <bzhao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

This is a multi-part message in MIME format.
--------------060700000200060503010602
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

04.11.2013 02:10, Bing Zhao пишет:
> Your Chromebook supports SDIO high speed mode (SDIO 2.0 spec). So
> 50MHz is correct.

Ok, but mainline kernel doesn't try this frequency. It tries 400kHz at
most.

> What are you trying to do here? Are you trying to run a mainline kernel on your Chromebook?

Yes. I've got kernel 3.4 from Google Chrome OS. It works ok for
mwifiex_sdio. But I want to run mainline kernel. As of 3.11 it is able
to boot on Chromebook, but WiFi doesn't work.

> You said mmc_attach_sdio function fails. The mwifiex_sdio driver and
> the firmware will not be loaded at all. 

Ok, that is clear.

> CONFIG_MMC_DEBUG=y, and collect the debug logs.  

This way seems not very useful, because there is also internal and
external storage on mmc bus, so log quickly get garbaged with it. Dmesg
seems to be overflowed and forgets early initialization. I have made a
dirty hack to collect some useful info about initialization. I am
attaching it. Please check, if I need to add something. Will it be
useful this way?

--------------060700000200060503010602
Content-Type: text/x-patch;
 name="dirty-hack.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dirty-hack.diff"

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index bf18b6b..c4a2b22 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1001,12 +1001,16 @@ EXPORT_SYMBOL(mmc_put_card);
 static inline void mmc_set_ios(struct mmc_host *host)
 {
 	struct mmc_ios *ios = &host->ios;
-
-	pr_debug("%s: clock %uHz busmode %u powermode %u cs %u Vdd %u "
+	
+	if(((char*)mmc_hostname(host))[3]=='2') {
+	  printk("%s: clock %uHz busmode %u powermode %u cs %u Vdd %u "
 		"width %u timing %u\n",
 		 mmc_hostname(host), ios->clock, ios->bus_mode,
 		 ios->power_mode, ios->chip_select, ios->vdd,
 		 ios->bus_width, ios->timing);
+	
+	  dump_stack();
+	}
 
 	if (ios->clock > 0)
 		mmc_set_ungated(host);
diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 80d89cff..0773be2 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -1133,11 +1133,14 @@ int mmc_attach_sdio(struct mmc_host *host)
 	int err, i, funcs;
 	u32 ocr;
 	struct mmc_card *card;
+	
+	printk("mmc_attach_sdio 1\n");
 
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
 
 	err = mmc_send_io_op_cond(host, 0, &ocr);
+	printk("mmc_attach_sdio err %d\n", err);
 	if (err)
 		return err;
 
@@ -1166,6 +1169,8 @@ int mmc_attach_sdio(struct mmc_host *host)
 		goto err;
 	}
 
+	printk("mmc_attach_sdio 2\n");
+	
 	/*
 	 * Detect and init the card.
 	 */
@@ -1182,11 +1187,13 @@ int mmc_attach_sdio(struct mmc_host *host)
 			host->ocr &= ~R4_18V_PRESENT;
 			err = mmc_sdio_init_card(host, host->ocr, NULL, 0);
 		}
+		printk("mmc_attach_sdio 3 err %d\n", err);
 		if (err)
 			goto err;
 	}
 	card = host->card;
 
+	printk("mmc_attach_sdio 4\n");
 	/*
 	 * Enable runtime PM only if supported by host+card+board
 	 */
@@ -1195,6 +1202,7 @@ int mmc_attach_sdio(struct mmc_host *host)
 		 * Let runtime PM core know our card is active
 		 */
 		err = pm_runtime_set_active(&card->dev);
+		printk("mmc_attach_sdio 5 err %d\n", err);
 		if (err)
 			goto remove;
 
@@ -1226,6 +1234,7 @@ int mmc_attach_sdio(struct mmc_host *host)
 			pm_runtime_enable(&card->sdio_func[i]->dev);
 	}
 
+	printk("mmc_attach_sdio 6\n");
 	/*
 	 * First add the card to the driver model...
 	 */
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 018f365..342b0c4 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1917,6 +1917,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 
 	mmc->ops = &dw_mci_ops;
 	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 510);
+	printk("f_min = %u;  %d", mmc->f_min, host->bus_hz);
 	mmc->f_max = host->bus_hz;
 
 	if (host->pdata->get_ocr)
diff --git a/drivers/net/wireless/mwifiex/Makefile b/drivers/net/wireless/mwifiex/Makefile
index a42a506..145f376 100644
--- a/drivers/net/wireless/mwifiex/Makefile
+++ b/drivers/net/wireless/mwifiex/Makefile
@@ -14,7 +14,10 @@
 # ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
 # this warranty disclaimer.
 
--------------060700000200060503010602--
