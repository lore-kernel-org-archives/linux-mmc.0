Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878461CCEF3;
	Fri,  6 Sep 2024 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618117; cv=none; b=OcBrpSEpXp6iVlbOQD9Ds2Bu/DyDJCRUetKk7rlszhT3ZK9omfA39uO3R5G3AM2+PHjmJG8QH/YWacCZx+MCMC1yAoIzlwFwFDZZxmyV7BD/mL1epK6Ph+kMrfDMVolfQtN1KN/D5YsO9nQIfIXhudZ60a6XNOpOULWP6TFhSWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618117; c=relaxed/simple;
	bh=+dwK5282uCMsnjW1mk1L8dKJumjWhVd+pfUeWylbOt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mM/PrFhlbyN9gqh49r/nEBujHZQ7O5w93x8nIfWMDYRRWWVuSpZNBTepmf6VhlHxL++5Dau75QClzoLjrS1BEyEkW0SirAouOr8jraXmpIa9yelaPpO9cxpt1gMGX33hWphTzqvb/CnHf7sIDnJhEircV9aiCaij7Jax/Vr02Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6fWbPLD; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6fWbPLD"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7163489149eso1471752a12.1;
        Fri, 06 Sep 2024 03:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725618115; x=1726222915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOdkXrgNTgcSvN5kJ0Vv+BY8p0cgmlvV1dWGrb2VSKU=;
        b=C6fWbPLDM8zta1X7YucruAqaM3T59CUziqXuKjahzTS7215ffecBL4JuDDrR+kcyF9
         rc3ySDGc9O3zlT0I+i97XnK8sdO9LP3Ug2ZE1nV+bbRm0PQ05jX7+ksJEYfF0lBbT8cl
         Hgu9chbJnYsHdzolYBntyVfm0Yj+K8IdXFK7MqGbihVISBFKnrg/LHlkDFSKD6y+MUi3
         tXOTIobjU4jURDuNYmjDnt2s1E6KZmxEWaRnTZ4pEPLqaR4Newjt/EGRyc7Cw/nQIPR2
         MZpvzMU+L8b2b56otUpIZJH8+wphYl9rYUx4Bo9DO9mYyxVnQvD5svL7uuOtQWasI5cH
         9BvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618115; x=1726222915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOdkXrgNTgcSvN5kJ0Vv+BY8p0cgmlvV1dWGrb2VSKU=;
        b=qhHKyhaX2/Gw1ii8d4HQrmmgO/ujmQYJcTeMi2jxww+CLZnX+jNwP9jVgqCFnHOr0a
         6hU+8OjZkKQRqW9VkIT5vpx++vJflUIEYTJHhW5YRiDO+G8mFM3gkDU7tZQ1Ql2i0r8J
         I6mJH1MzyHRQKB7Gy4vcQo5SQfdNtSK9sRTQJxh/T5wWaOp549NlmdDT3KCpGq/dYENm
         AugalAOJSPQQwlEMxjH69FgmaacCgcFSmXcX1r7cZ14diYFRUbvT+gLHdqN6fnmdaI7+
         MoHpMy/1HzlG9+znH6i+9gTxbJPzbVRe9ZAnS0jPEDciSweXvk2IahAF+FU46AilN4rh
         awQg==
X-Forwarded-Encrypted: i=1; AJvYcCVXhUQK1THoHv2Ctg/Ca0lHFK12VcfZcOOiFUdUpFhFY+PfBnKWKuxQltiBuJtQyqMybF9JQ4H6FpwD9wE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy55f/LGD/GLqp1JIWpiv+pHlJnec2aiss1n2GRGPLvISaaxyZN
	Qj7uWD0vOxQ0T9mbzRwg3tfn+FDdOUZXxCErBcVxigaRUsUeDWF2
X-Google-Smtp-Source: AGHT+IH5EMZ1Nfx6EPE3McEgRBZvY5OnYN61R4GYeqWc222gj3nZSjz7NqKRopVX239Q3eDkkNCuYA==
X-Received: by 2002:a05:6a20:43ab:b0:1c4:6be3:f571 with SMTP id adf61e73a8af0-1cf1d1b32b9mr2260781637.39.1725618114663;
        Fri, 06 Sep 2024 03:21:54 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:5f74:48c1:9f66:fb02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717931fca8csm2072611b3a.139.2024.09.06.03.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:21:54 -0700 (PDT)
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
Subject: [PATCH V21 13/22] mmc: sdhci-uhs2: add set_timeout()
Date: Fri,  6 Sep 2024 18:20:40 +0800
Message-Id: <20240906102049.7059-14-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240906102049.7059-1-victorshihgli@gmail.com>
References: <20240906102049.7059-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a UHS-II version of sdhci's set_timeout() operation.
Use sdhci_uhs2_set_timeout() to set and calculate the timeout time.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V14:
 - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
   sdhci_uhs2_set_timeout().

Updates in V13:
 - Modify comment message.

Updates in V8:
 - Initialization be combined with declaration and realigned
   in sdhci_calc_timeout_uhs2().
 - Forward declare struct mmc_command in sdhci_uhs2.h.

Updates in V6:
 - Use GENMASK() and FIELD_PREP() in some case.
 - Use sdhci_uhs2_mode() to simplify code.
 - Remove unnecessary functions.

---

 drivers/mmc/host/sdhci-uhs2.c | 72 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  2 +
 2 files changed, 74 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 0cfe9a3f91f7..8bd2baa79d76 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/iopoll.h>
+#include <linux/bitfield.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -135,6 +136,77 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
 
+static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res, u8 *dead_lock)
+{
+	/* timeout in us */
+	unsigned int dead_lock_timeout = 1 * 1000 * 1000;
+	unsigned int cmd_res_timeout = 5 * 1000;
+	unsigned int current_timeout;
+	u8 count;
+
+	/*
+	 * Figure out needed cycles.
+	 * We do this in steps in order to fit inside a 32 bit int.
+	 * The first step is the minimum timeout, which will have a
+	 * minimum resolution of 6 bits:
+	 * (1) 2^13*1000 > 2^22,
+	 * (2) host->timeout_clk < 2^16
+	 *     =>
+	 *     (1) / (2) > 2^6
+	 */
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < cmd_res_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for CMD_RES!\n",
+		    mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*cmd_res = count;
+
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < dead_lock_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for DEADLOCK!\n",
+		    mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*dead_lock = count;
+
+	return count;
+}
+
+static void __sdhci_uhs2_set_timeout(struct sdhci_host *host)
+{
+	u8 cmd_res, dead_lock;
+
+	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
+	cmd_res |= FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead_lock);
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+}
+
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	__sdhci_set_timeout(host, cmd);
+
+	if (mmc_card_uhs2(host->mmc))
+		__sdhci_uhs2_set_timeout(host);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 3efa8dd690bf..9bd3f610cf8c 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -175,9 +175,11 @@
 #define SDHCI_UHS2_VENDOR_PTR			0xE8
 
 struct sdhci_host;
+struct mmc_command;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd);
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1

