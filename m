From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH RFC] mmc: add slot argument to mmc_of_parse
Date: Wed, 7 May 2014 12:06:57 +0200
Message-ID: <1399457217-22846-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: chris@printf.net, ulf.hansson@linaro.org, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

Some hosts manage several slots. In these case information such as the bus
width, chip detect and others are into the slot node. So we have to parse
child nodes. If not NULL, slot node will be used instead of the device
node.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---

Hi,

Since this patch is only a RFC, I have not yet updated drivers using this
function.

I would like to use mmc_of_parse to reduce code duplication. My issue is that
atmel mci is a bit different from others mci host since it can provide
several slots, so it allocates several mmc hosts. By the way, it is not the
only one.

When calling mmc_alloc_host, host->parent is set to &pdev->dev. mmc_of_parse
uses host->parent->of_node but in my case settings are in the slot nodes so in
the child nodes. That's why I would like to have a way to tell which node I
want to use.


Regards

Ludovic



 drivers/mmc/core/host.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index fdea825..ed6cea5 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -300,13 +300,15 @@ static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
 /**
  *	mmc_of_parse() - parse host's device-tree node
  *	@host: host whose node should be parsed.
+ *	@slot: some devices provide several slots so the node to parse
+ *	is not the host one.
  *
  * To keep the rest of the MMC subsystem unaware of whether DT has been
  * used to to instantiate and configure this host instance or not, we
  * parse the properties and set respective generic mmc-host flags and
  * parameters.
  */
-int mmc_of_parse(struct mmc_host *host)
+int mmc_of_parse(struct mmc_host *host, struct device_node *slot)
 {
 	struct device_node *np;
 	u32 bus_width;
@@ -317,7 +319,10 @@ int mmc_of_parse(struct mmc_host *host)
 	if (!host->parent || !host->parent->of_node)
 		return 0;
 
-	np = host->parent->of_node;
+	if (slot)
+		np = slot;
+	else
+		np = host->parent->of_node;
 
 	/* "bus-width" is translated to MMC_CAP_*_BIT_DATA flags */
 	if (of_property_read_u32(np, "bus-width", &bus_width) < 0) {
-- 
1.7.9.5
