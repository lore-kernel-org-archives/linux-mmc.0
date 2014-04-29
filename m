From: srinivas.kandagatla@linaro.org
Subject: [PATCH v1 01/11] ARM: amba: Add Qualcomm vendor ID.
Date: Tue, 29 Apr 2014 09:19:02 +0100
Message-ID: <1398759542-13017-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1398759492-12970-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34856 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756711AbaD2ITN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Apr 2014 04:19:13 -0400
Received: by mail-wi0-f175.google.com with SMTP id cc10so6965282wib.8
        for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2014 01:19:12 -0700 (PDT)
In-Reply-To: <1398759492-12970-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, agross@quicinc.com, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

This patch adds Qualcomm amba vendor Id to the list. This ID is used in mmci
driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/linux/amba/bus.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 63b5eff..fdd7e1b 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -47,6 +47,7 @@ struct amba_driver {
 enum amba_vendor {
 	AMBA_VENDOR_ARM = 0x41,
 	AMBA_VENDOR_ST = 0x80,
+	AMBA_VENDOR_QCOM = 0x51,
 };
 
 extern struct bus_type amba_bustype;
-- 
1.7.9.5

