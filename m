From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v2 3/4] mmc: Set slot_no on devicetree / of
 systems too
Date: Sat, 31 May 2014 21:03:33 +0200
Message-ID: <1401563014-13856-4-git-send-email-hdegoede@redhat.com>
References: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBF6PVCOAKGQEFNJKW5A-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1401563014-13856-1-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Some host controllers have multiple slots. The mmc-core sofar does not
really have any knowledge of this, the host drivers for these controllers
simple call mmc_add_host() multiple times.

These mmc_host-s will share their parent device and on devicetree systems
also their parent->of_node.

This commit makes multi-slot mmc host drivers set the already existing, but
sofar only used for ACPI, slot_no member of mmc_host so that mmc-core functions
parsing the devicetree can determine what the right slot devicetree subnode is
to parse for a multi-slot host.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/mmc/host/atmel-mci.c | 1 +
 drivers/mmc/host/dw_mmc.c    | 1 +
 include/linux/mmc/host.h     | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 42706ea..a58906b 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2170,6 +2170,7 @@ static int __init atmci_init_slot(struct atmel_mci *host,
 		slot_data->wp_pin);
 
 	mmc->ops = &atmci_ops;
+	mmc->slotno = id;
 	mmc->f_min = DIV_ROUND_UP(host->bus_hz, 512);
 	mmc->f_max = host->bus_hz / 2;
 	mmc->ocr_avail	= MMC_VDD_32_33 | MMC_VDD_33_34;
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index cced599..c27a86b 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2149,6 +2149,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	slot->quirks = dw_mci_of_get_slot_quirks(host->dev, slot->id);
 
 	mmc->ops = &dw_mci_ops;
+	mmc->slotno = id;
 	if (of_property_read_u32_array(host->dev->of_node,
 				       "clock-freq-min-max", freq, 2)) {
 		mmc->f_min = DW_MCI_FREQ_MIN;
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index cb61ea4..10d1091 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -356,7 +356,7 @@ struct mmc_host {
 
 	unsigned int		actual_clock;	/* Actual HC clock rate */
 
-	unsigned int		slotno;	/* used for sdio acpi binding */
+	unsigned int		slotno;	/* used for sdio acpi / of binding */
 
 	unsigned long		private[0] ____cacheline_aligned;
 };
-- 
2.0.0
