From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH 2/5] mmc: dw_mmc: Add suspend/resume callbacks; disable irq during suspend
Date: Tue,  9 Jul 2013 10:31:08 -0700
Message-ID: <1373391071-6312-3-git-send-email-dianders@chromium.org>
References: <1373391071-6312-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373391071-6312-1-git-send-email-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, James Hogan <james.hogan@imgtec.com>, Grant Grundler <grundler@chromium.org>, Alim Akhtar <alim.akhtar@samsung.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Doug Anderson <dianders@chromium.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On some platforms (like exynos5420) the dw_mmc controller may be in a
strange state after we wake up from sleep.  Add callbacks to allow for
dealing with these quirks.  Prevent interrupts from firing when we're
suspended since this strange state may cause interrupts to fire.

In my case I saw the WAKEUP_INT interrupt firing upon resume and
needed to add some code to handle this.

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c | 12 ++++++++++++
 drivers/mmc/host/dw_mmc.h |  4 ++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index f20273e..2aaa93f 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2434,6 +2434,7 @@ EXPORT_SYMBOL(dw_mci_remove);
  */
 int dw_mci_suspend(struct dw_mci *host)
 {
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int i, ret = 0;
 
 	for (i = 0; i < host->num_slots; i++) {
@@ -2454,14 +2455,25 @@ int dw_mci_suspend(struct dw_mci *host)
 	if (host->vmmc)
 		regulator_disable(host->vmmc);
 
+	disable_irq(host->irq);
+
+	if (drv_data && drv_data->suspend)
+		drv_data->suspend(host);
+
 	return 0;
 }
 EXPORT_SYMBOL(dw_mci_suspend);
 
 int dw_mci_resume(struct dw_mci *host)
 {
+	const struct dw_mci_drv_data *drv_data = host->drv_data;
 	int i, ret;
 
+	if (drv_data && drv_data->resume)
+		drv_data->resume(host);
+
+	enable_irq(host->irq);
+
 	if (host->vmmc) {
 		ret = regulator_enable(host->vmmc);
 		if (ret) {
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 0b74189..52a3266 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -190,6 +190,8 @@ extern int dw_mci_resume(struct dw_mci *host);
  * @prepare_command: handle CMD register extensions.
  * @set_ios: handle bus specific extensions.
  * @parse_dt: parse implementation specific device tree properties.
+ * @suspend: called late in the suspend process
+ * @resume: called early in the resume process
  *
  * Provide controller implementation specific extensions. The usage of this
  * data structure is fully optional and usage of each member in this structure
@@ -202,5 +204,7 @@ struct dw_mci_drv_data {
 	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
+	void		(*suspend)(struct dw_mci *host);
+	void		(*resume)(struct dw_mci *host);
 };
 #endif /* _DW_MMC_H_ */
-- 
1.8.3
