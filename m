From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH] mmc: dw_mmc: avoid race condition of cpu and IDMAC
Date: Tue, 16 Aug 2016 11:23:47 +0800
Message-ID: <1471317827-6049-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:49244 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932583AbcHPD2I (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Aug 2016 23:28:08 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, Shawn Lin <shawn.lin@rock-chips.com>

We could see an obvious race condition by test that
the former write operation by IDMAC aiming to clear
OWN bit reach right after the later configuration of
the same desc, which makes the IDMAC be in SUSPEND
state as the OWN bit was cleared by the asynchronous
write operation of IDMAC. The bug can be very easy
reproduced on RK3288 or similar when lowering the
bandwidth of bus and aggravating the Qos to make the
large numbers of IP fight for the priority. One possible
replaceable solution may be alloc dual buff for the
desc to avoid it but could still race each other
theoretically.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 drivers/mmc/host/dw_mmc.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 32380d5..7b01fab 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -490,6 +490,23 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 				length -= desc_len;
 
 				/*
+				 * OWN bit should be clear by IDMAC after
+				 * finishing transfer. Let's wait for the
+				 * asynchronous operation of IDMAC and cpu
+				 * to make sure that we do not rely on the
+				 * order of Qos of bus and architecture.
+				 * Otherwise we could see a race condition
+				 * here that the former write operation of
+				 * IDMAC(to clear the OWN bit) reach right
+				 * after the later new configuration of desc
+				 * which makes value of desc been covered
+				 * leading to DMA_SUSPEND state as IDMAC fecth
+				 * the wrong desc then.
+				 */
+				while ((readl(&desc->des0) & IDMAC_DES0_OWN))
+					;
+
+				/*
 				 * Set the OWN bit and disable interrupts
 				 * for this descriptor
 				 */
@@ -535,6 +552,23 @@ static void dw_mci_translate_sglist(struct dw_mci *host, struct mmc_data *data,
 				length -= desc_len;
 
 				/*
+				 * OWN bit should be clear by IDMAC after
+				 * finishing transfer. Let's wait for the
+				 * asynchronous operation of IDMAC and cpu
+				 * to make sure that we do not rely on the
+				 * order of Qos of bus and architecture.
+				 * Otherwise we could see a race condition
+				 * here that the former write operation of
+				 * IDMAC(to clear the OWN bit) reach right
+				 * after the later new configuration of desc
+				 * which makes value of desc been covered
+				 * leading to DMA_SUSPEND state as IDMAC fecth
+				 * the wrong desc then.
+				 */
+				while ((readl(&desc->des0) & IDMAC_DES0_OWN))
+					;
+
+				/*
 				 * Set the OWN bit and disable interrupts
 				 * for this descriptor
 				 */
-- 
2.3.7


