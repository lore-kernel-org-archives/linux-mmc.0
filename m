From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH 6/6] mmc: ffu: Hack for Samsung part
Date: Wed, 13 Apr 2016 15:33:44 -0700
Message-ID: <1460586824-40688-7-git-send-email-gwendal@chromium.org>
References: <1460586824-40688-1-git-send-email-gwendal@chromium.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36854 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbcDMWe3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 18:34:29 -0400
Received: by mail-pa0-f43.google.com with SMTP id er2so9872059pad.3
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2016 15:34:29 -0700 (PDT)
In-Reply-To: <1460586824-40688-1-git-send-email-gwendal@chromium.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, Alex.Lemberg@sandisk.com, avi.shchislowski@sandisk.com, yaniv.agman@sandisk.com, holgerschurig@gmail.com, chris@printf.net, baolin.wang@linaro.org
Cc: linux-mmc@vger.kernel.org

Samsung eMMC5.0 is not fully Jedec compliant:

CMD25 write argument is a fixed value not from FFU_ARG.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/mmc/core/ffu.c  | 39 +++++++++++++++++++++++++++++++--------
 include/linux/mmc/ffu.h | 25 ++++++++++++++++++++++---
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/core/ffu.c b/drivers/mmc/core/ffu.c
index 8538365..e89bd34 100644
--- a/drivers/mmc/core/ffu.c
+++ b/drivers/mmc/core/ffu.c
@@ -57,6 +57,22 @@ struct mmc_ffu_area {
 };
 
 /*
+ * Get hack value
+ */
+static const struct mmc_ffu_hack *mmc_get_hack(
+		const struct mmc_ffu_args *args,
+		enum mmc_ffu_hack_type type)
+{
+	int i;
+
+	for (i = 0; i < args->ack_nb; i++) {
+		if (args->hack[i].type == type)
+			return &args->hack[i];
+	}
+	return NULL;
+}
+
+/*
  * Map memory into a scatterlist.
  */
 static unsigned int mmc_ffu_map_sg(struct mmc_ffu_mem *mem, int size,
@@ -350,13 +366,15 @@ static int mmc_ffu_install(struct mmc_card *card, u8 **ext_csd)
 	return 0;
 }
 
-int mmc_ffu_invoke(struct mmc_card *card, const char *name)
+int mmc_ffu_invoke(struct mmc_card *card, const struct mmc_ffu_args *args)
 {
 	u8 *ext_csd = NULL;
 	int err;
 	u32 arg;
 	u32 fw_prog_bytes;
 	const struct firmware *fw;
+	const struct mmc_ffu_hack *hack;
+
 
 	/* Check if FFU is supported */
 	if (!card->ext_csd.ffu_capable) {
@@ -366,14 +384,14 @@ int mmc_ffu_invoke(struct mmc_card *card, const char *name)
 		return -EOPNOTSUPP;
 	}
 
-	if (strlen(name) > 512) {
+	if (strlen(args->name) > 512) {
 		pr_err("FFU: %s: name %.20s is too long.\n",
-		       mmc_hostname(card->host), name);
+		       mmc_hostname(card->host), args->name);
 		return -EINVAL;
 	}
 
 	/* setup FW data buffer */
-	err = request_firmware(&fw, name, &card->dev);
+	err = request_firmware(&fw, args->name, &card->dev);
 	if (err) {
 		pr_err("FFU: %s: Firmware request failed %d\n",
 		       mmc_hostname(card->host), err);
@@ -404,10 +422,15 @@ int mmc_ffu_invoke(struct mmc_card *card, const char *name)
 	}
 
 	/* set CMD ARG */
-	arg = ext_csd[EXT_CSD_FFU_ARG] |
-		ext_csd[EXT_CSD_FFU_ARG + 1] << 8 |
-		ext_csd[EXT_CSD_FFU_ARG + 2] << 16 |
-		ext_csd[EXT_CSD_FFU_ARG + 3] << 24;
+	hack = mmc_get_hack(args, MMC_OVERRIDE_FFU_ARG);
+	if (hack == NULL) {
+		arg = ext_csd[EXT_CSD_FFU_ARG] |
+			ext_csd[EXT_CSD_FFU_ARG + 1] << 8 |
+			ext_csd[EXT_CSD_FFU_ARG + 2] << 16 |
+			ext_csd[EXT_CSD_FFU_ARG + 3] << 24;
+	} else {
+		arg = cpu_to_le32(hack->value);
+	}
 
 	/* set device to FFU mode */
 	err = mmc_ffu_switch_mode(card, MMC_FFU_MODE_SET);
diff --git a/include/linux/mmc/ffu.h b/include/linux/mmc/ffu.h
index f307742..3786cc0 100644
--- a/include/linux/mmc/ffu.h
+++ b/include/linux/mmc/ffu.h
@@ -29,18 +29,37 @@
 #define MMC_FFU_MODE_NORMAL 0x0
 #define MMC_FFU_INSTALL_SET 0x2
 
+#define FFU_NAME_LEN 80  /* Name of the firmware file udev should find */
+
+enum mmc_ffu_hack_type {
+	MMC_OVERRIDE_FFU_ARG = 0,
+	MMC_HACK_LEN,
+};
+
+struct mmc_ffu_hack {
+	enum mmc_ffu_hack_type type;
+	u64 value;
+};
+
+struct mmc_ffu_args {
+	char name[FFU_NAME_LEN];
+	u32 ack_nb;
+	struct mmc_ffu_hack hack[0];
+};
+
 #ifdef CONFIG_MMC_FFU
 #define MMC_FFU_FEATURES 0x1
 #define FFU_FEATURES(ffu_features) (ffu_features & MMC_FFU_FEATURES)
 
-int mmc_ffu_invoke(struct mmc_card *card, const char *name);
+int mmc_ffu_invoke(struct mmc_card *card, const struct mmc_ffu_args *args);
 
 #else
-static inline int mmc_ffu_invoke(struct mmc_card *card, const char *name)
+static inline int mmc_ffu_invoke(struct mmc_card *card,
+		const struct mmc_ffu_args *args)
 {
 	return -EOPNOTSUPP;
 }
 #endif
-#endif /* FFU_H_ */
+#endif /* _FFU_H_ */
 
 
-- 
2.8.0.rc3.226.g39d4020

