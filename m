From: srinivas.kandagatla@linaro.org
Subject: [PATCH RFC 01/12] ARM: amba: Add Qualcomm vendor ID.
Date: Mon, 21 Apr 2014 22:47:11 +0100
Message-ID: <1398116831-31235-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33222 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754210AbaDUVrT (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 21 Apr 2014 17:47:19 -0400
Received: by mail-wi0-f174.google.com with SMTP id d1so2361193wiv.7
        for <linux-mmc@vger.kernel.org>; Mon, 21 Apr 2014 14:47:18 -0700 (PDT)
In-Reply-To: <1398116624-31052-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, agross@quicinc.com, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

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

