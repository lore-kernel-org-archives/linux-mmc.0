Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BDF19148A;
	Thu, 29 Aug 2024 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926596; cv=none; b=eecx7W8uhK0hBLeUhUi+w8RYm3H3D9lnS4gc17n41QNEGvRW/s2zW0u6B/g1QCq7AmIb429zdIanQ3sBObsuBoqWOE6uJtEYA2aJMGlZUq4EvhS9rRopSeCqx0uKvlG9CYmI4j0+4IPJWaDjK5GnVt5QaWI8vXLJJkgvKhzSH3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926596; c=relaxed/simple;
	bh=tNWL2yxo2uDQa0iyKVclsZm+e2qhVUxxzq34g14C8ts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kIhtqylrHUH+RSoyLoO9ATnehSdCQ9FZEf9YeoTWeuIB+LcUGqEAei8MIahvpAyerQjNkz8dw69N7wEtmb4TZb2nKSo1Yda73hFhylZnDNTYfwCrm5UOLBueWhH2fL2pzabtYGTdCnesDUBg44eurMQGP11Xxw9aGGnnB7t6g6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzPTQcHD; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzPTQcHD"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-715abede256so357629b3a.3;
        Thu, 29 Aug 2024 03:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724926594; x=1725531394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2u5k+9P7fnLwaL1GZATBK9ZKcQNGMTg+CrJ1EQReTio=;
        b=TzPTQcHDW37Zu+78W4Uq8uBqMwvaaYdyP2TcjVRCMqziSwZiiJnNf/8cn/IHIaSQJh
         kuZhwVR8tCWAz0OvRQa73jy4UxMRNKxp19YqazczN2+qtEpVpPF8TIiDfkQ12pBRWqgK
         iGuIoEti9DWDIz9oHqYw7I+mlMIgbTlVV+uqWTsInZURjf6l5z4eHK0Z2GSHcxz/h8HX
         xyyY2Wd2W8A9GzE2QRY9tX4lTlI3Ob6Otf7oOYNtl4puSuAXshUktwlipyQSlnQ9KG+K
         tqrD0dV7RnC5IWAcfpqNkgCwS6BXBbCYRVupVZHTlvLtw5VwYwvK4Ui70csdP0FO+xYk
         jDHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926594; x=1725531394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2u5k+9P7fnLwaL1GZATBK9ZKcQNGMTg+CrJ1EQReTio=;
        b=U1W90iTc2Z4hbOvJv0uCbtkITkXeIXUxRbl+pAhDampDUAQi79MtxxPKWWqXK7PHkz
         N6KoT78c2NENaePWAu2OMH4wNQqETFuXbkReTZCAUfLHUYP2ULjInwlXy+XQVC1MaRPq
         HJ522ehzb+El1ae8rSSRtT0fqFAPDXgw73U5L0MI1TwpgizdlWsU870IMXZs+ovtjj17
         QBR6oDMj2nTkUkBOxXdWRp3UDDLOoryNIRnebpZH4JPqOFBS3inZTP0VgWfQvw1rORY9
         a+7Pvi3aIsftlpYADRnA7YP7zexKYSkGlpgUzxsnokU+uEjg7V8aVo1ChijW5CBZ6Elh
         W/Zg==
X-Forwarded-Encrypted: i=1; AJvYcCUH7o+jllOehJqeKG83rB4yo5uSCzXcez040Q1RXeMvbA7+z0l4cUdbdJHI9tLBCNgL1Y2EUq5JJUYzvrc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4E1JYk8BteiI7bgQZF05aK/+gQWwjgghvdaCi3YFm1ZbsI6r0
	zqF+fHnhUfh+z6vGf3Dr77z5vM/8heDpjLNvK5kIcFPToFAzjvekQFFDFzBq
X-Google-Smtp-Source: AGHT+IHIEVF0QL5T/fIojGr4YJfvf2ZxagumUKkkbzpLuhc5c4RvqGLQ0xOIbAznt5IpL00M4Ho4ig==
X-Received: by 2002:a05:6a00:2789:b0:713:f127:ad5c with SMTP id d2e1a72fcca58-715dfcc91a7mr2752029b3a.28.1724926594320;
        Thu, 29 Aug 2024 03:16:34 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:a52:632f:b914:4ddf:273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d77eesm816577b3a.153.2024.08.29.03.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:16:34 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V19 11/22] mmc: sdhci-uhs2: add reset function
Date: Thu, 29 Aug 2024 18:15:28 +0800
Message-Id: <20240829101539.5058-12-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829101539.5058-1-victorshihgli@gmail.com>
References: <20240829101539.5058-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Sdhci_uhs2_reset() does a UHS-II specific reset operation.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V17:
 - Move the sdhci_uhs2_reset_cmd_data() to the other patch it was used
   for the first time.

Updates in V16:
 - Add sdhci_uhs2_reset_cmd_data() function.

Updates in V15:
 - Refer the SD Host Controller Standard Specification Section 3.10
   to add reset command data mechanism.

Updates in V14:
 - Since mmc_card_uhs2() is the same as sdhci_uhs2_mode(), so drop
   sdhci_uhs2_mode() and use mmc_card_uhs2() instead of sdhci_uhs2_mode().

Updates in V13:
 - Use ios timing to stead MMC_UHS2_SUPPORT for indicate the UHS2 mode.

Updates in V8:
 - Adjust the position of matching brackets.

Updates in V6:
 - Remove unnecessary functions and simplify code.

---

 drivers/mmc/host/sdhci-uhs2.c | 37 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 9cb0f1b2a37d..3d16f1ef9344 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -10,7 +10,9 @@
  *  Author: AKASHI Takahiro <takahiro.akashi@linaro.org>
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/iopoll.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -21,6 +23,8 @@
 #define SDHCI_UHS2_DUMP(f, x...) \
 	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
 
+#define UHS2_RESET_TIMEOUT_100MS		100000
+
 void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 {
 	if (!(mmc_card_uhs2(host->mmc)))
@@ -49,6 +53,39 @@ void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
+/*****************************************************************************\
+ *                                                                           *
+ * Low level functions                                                       *
+ *                                                                           *
+\*****************************************************************************/
+
+/**
+ * sdhci_uhs2_reset - invoke SW reset
+ * @host: SDHCI host
+ * @mask: Control mask
+ *
+ * Invoke SW reset, depending on a bit in @mask and wait for completion.
+ */
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask)
+{
+	u32 val;
+
+	sdhci_writew(host, mask, SDHCI_UHS2_SW_RESET);
+
+	if (mask & SDHCI_UHS2_SW_RESET_FULL)
+		host->clock = 0;
+
+	/* hw clears the bit when it's done */
+	if (read_poll_timeout_atomic(sdhci_readw, val, !(val & mask), 10,
+				     UHS2_RESET_TIMEOUT_100MS, true, host, SDHCI_UHS2_SW_RESET)) {
+		pr_warn("%s: %s: Reset 0x%x never completed. %s: clean reset bit.\n", __func__,
+			mmc_hostname(host->mmc), (int)mask, mmc_hostname(host->mmc));
+		sdhci_writeb(host, 0, SDHCI_UHS2_SW_RESET);
+		return;
+	}
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_reset);
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 2bfe18d29bca..caaf9fba4975 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -177,5 +177,6 @@
 struct sdhci_host;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1

