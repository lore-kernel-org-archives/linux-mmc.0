From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] dw_mmc: fix more const pointer warnings
Date: Thu, 8 Nov 2012 14:26:11 +0000
Message-ID: <201211081426.12208.arnd@arndb.de>
References: <1350376988-27477-1-git-send-email-james.hogan@imgtec.com> <508E4DB6.20504@imgtec.com> <87a9v5xuqj.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:65084 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755976Ab2KHO0R (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Nov 2012 09:26:17 -0500
In-Reply-To: <87a9v5xuqj.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: James Hogan <james.hogan@imgtec.com>, Will Newton <will.newton@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Thomas Abraham <thomas.abraham@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

The patch "dw_mmc: fix multiple drv_data NULL dereferences" has
unfortunately clashed with my "mmc: dw_mmc: constify
dw_mci_idmac_ops in exynos back-end" patch, causing new warnings
to appear.

This should hopefully fix the issue for good.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
On Monday 29 October 2012, Chris Ball wrote:
> Hi,
> 
> On Mon, Oct 29 2012, James Hogan wrote:
> > On 17/10/12 10:11, Will Newton wrote:
> >> Looks good to me too.
> >> 
> >> Acked-by: Will Newton <will.newton@imgtec.com>
> >> 
> >> On Wed, Oct 17, 2012 at 3:06 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> >>> Looks good to me.
> >>>
> >>> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>
> >
> > Thanks for the acks Thomas, Seungwon, Jaehoon and Will.
> >
> > Chris: Any chance of queueing this patch for v3.7?
> 
> Yes, certainly -- pushed to mmc-next for 3.7, thanks.

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c0667c8..5b41348 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -232,7 +232,7 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
 {
 	struct mmc_data	*data;
 	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci_drv_data *drv_data = slot->host->drv_data;
+	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
 	u32 cmdr;
 	cmd->error = -EINPROGRESS;
 
@@ -773,7 +773,7 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
-	struct dw_mci_drv_data *drv_data = slot->host->drv_data;
+	const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
 	u32 regs;
 
 	/* set default 1 bit mode */
@@ -1817,7 +1817,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 {
 	struct mmc_host *mmc;
 	struct dw_mci_slot *slot;
-	struct dw_mci_drv_data *drv_data = host->drv_data;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int ctrl_id, ret;
 	u8 bus_width;
 
@@ -2038,7 +2038,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 	struct dw_mci_board *pdata;
 	struct device *dev = host->dev;
 	struct device_node *np = dev->of_node;
-	struct dw_mci_drv_data *drv_data = host->drv_data;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int idx, ret;
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
@@ -2084,7 +2084,7 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 
 int dw_mci_probe(struct dw_mci *host)
 {
-	struct dw_mci_drv_data *drv_data = host->drv_data;
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int width, i, ret = 0;
 	u32 fifo_size;
 	int init_slots = 0;
