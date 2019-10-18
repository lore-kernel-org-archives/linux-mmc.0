From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 4/9] mmc: host: omap_hsmmc: add code for special init of
 wl1251 to get rid of pandora_wl1251_init_card
Date: Fri, 18 Oct 2019 22:25:25 +0200
Message-ID: <347c23983a727a88c80179c7d7611d9b39e83e9d.1571430329.git.hns@goldelico.com>
References: <cover.1571430329.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1571430329.git.hns@goldelico.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Kalle Valo <kvalo@codeaurora.org>, Mike Rapoport <rppt@linux.ibm.com>, David Sterba <dsterba@suse.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Petr Mladek <pmladek@suse.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, "H. Nikolaus Schaller" <hns@goldelico.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Yangtao Li <tiny.windzz@gmail.com>, Alexios Zavras <alexios.zavras@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Allison Randal <allison@lohutok.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, John Stultz <john.stultz@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: devicetree@vger.kernel.org, letux-kernel@openphoenux.org, linux-mmc@vger.kernel.org, kernel@pyra-handheld.com, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Pandora_wl1251_init_card was used to do special pdata based
setup of the sdio mmc interface. This does no longer work with
v4.7 and later. A fix requires a device tree based mmc3 setup.

Therefore we move the special setup to omap_hsmmc.c instead
of calling some pdata supplied init_card function.

The new code checks for a DT child node compatible to wl1251
so it will not affect other MMC3 use cases.

Fixes: 81eef6ca9201 ("mmc: omap_hsmmc: Use dma_request_chan() for requesting DMA channel")

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Cc: <stable@vger.kernel.org> # 4.7.0
---
 drivers/mmc/host/omap_hsmmc.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 952fa4063ff8..03ba80bcf319 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1512,6 +1512,27 @@ static void omap_hsmmc_init_card(struct mmc_host *mmc, struct mmc_card *card)
 
 	if (mmc_pdata(host)->init_card)
 		mmc_pdata(host)->init_card(card);
+	else if (card->type == MMC_TYPE_SDIO || card->type == MMC_TYPE_SD_COMBO) {
+		struct device_node *np = mmc_dev(mmc)->of_node;
+
+		np = of_get_compatible_child(np, "ti,wl1251");
+		if (np) {
+			/*
+			 * We have TI wl1251 attached to MMC3. Pass this information to
+			 * SDIO core because it can't be probed by normal methods.
+			 */
+
+			dev_info(host->dev, "found wl1251\n");
+			card->quirks |= MMC_QUIRK_NONSTD_SDIO;
+			card->cccr.wide_bus = 1;
+			card->cis.vendor = 0x104c;
+			card->cis.device = 0x9066;
+			card->cis.blksize = 512;
+			card->cis.max_dtr = 24000000;
+			card->ocr = 0x80;
+			of_node_put(np);
+		}
+	}
 }
 
 static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
-- 
2.19.1
