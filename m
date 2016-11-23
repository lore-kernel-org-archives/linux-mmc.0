From: Jeremy McNicoll <jeremymc@redhat.com>
Subject: [PATCH 2/5] smd: Make packet size a constant
Date: Tue, 22 Nov 2016 17:09:45 -0800
Message-ID: <1479863388-23678-3-git-send-email-jeremymc@redhat.com>
References: <1479863388-23678-1-git-send-email-jeremymc@redhat.com>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1479863388-23678-1-git-send-email-jeremymc@redhat.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org

Use a macro to define the maximum size of a RPM message.

Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
---
 drivers/soc/qcom/smd-rpm.c   | 2 +-
 include/linux/soc/qcom/smd.h | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
index 6609d7e..b5a2836 100644
--- a/drivers/soc/qcom/smd-rpm.c
+++ b/drivers/soc/qcom/smd-rpm.c
@@ -114,7 +114,7 @@ int qcom_rpm_smd_write(struct qcom_smd_rpm *rpm,
 	size_t size = sizeof(*pkt) + count;
 
 	/* SMD packets to the RPM may not exceed 256 bytes */
-	if (WARN_ON(size >= 256))
+	if (WARN_ON(size >= SMD_RPM_MAX_SIZE))
 		return -EINVAL;
 
 	pkt = kmalloc(size, GFP_KERNEL);
diff --git a/include/linux/soc/qcom/smd.h b/include/linux/soc/qcom/smd.h
index f148e0f..8039015 100644
--- a/include/linux/soc/qcom/smd.h
+++ b/include/linux/soc/qcom/smd.h
@@ -4,6 +4,13 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 
+
+/*
+ * SMD packets to the RPM may not exceed 256 bytes
+ */
+#define SMD_RPM_MAX_SIZE 256
+
+
 struct qcom_smd;
 struct qcom_smd_channel;
 struct qcom_smd_lookup;
-- 
2.6.1
