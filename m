Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804821DB92A;
	Fri, 13 Sep 2024 10:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223382; cv=none; b=p1sGZT9kgQ2e9uHrJwrgbRSxYaVWamzK6Mzzm5ZagDyumM86Usxs22+RiaIDhgFXq0/E41EegOk9NQa5KzsHq+kdopJf0YwFzc0U+W/H3LqLiddoPqBQPwvKSVh/Wsy8wbdZcak0KCewmpJ/SmT6zGDRQohXhJOkzwY2OO4bdNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223382; c=relaxed/simple;
	bh=VB5pAfZlY5yWHbxrV1VvySF25vuCBwsa2Yimme8Jx9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QJCDq1o7ucDyKYBdiTMVAits3WqGgi0/O5ZAmxo8PK+jDN81wnjjD/3eqURNlu970f0hsn9A3FxXvPCuxakbhg5ak9PkWysXVo98dx0TiBWzyPdXNVCSsrWX8zcYxpsTFsuq0gnFxtSJVVpYlLI/zwpHK8AmhQfKPQHB4hAz4w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScFmvSnr; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScFmvSnr"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7191f58054aso1713698b3a.0;
        Fri, 13 Sep 2024 03:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223381; x=1726828181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGS5FnAtxOoJb/6wOxS2ea2cNEevmIiG+LI1be0l3jU=;
        b=ScFmvSnr44agjJzdgh82SqZtlp43XkFJ7MQa6QNRsSH8b4EzmgxWmCqLN5H2dL28q8
         GXDu3SmzDpeuLlCEnsXoMMcqOr4DL2URhmVhP1AWYJfgpUS+bwepP1w5SMrZhEE8v686
         ip9jpFerCRWmbGZWPRz/LqEuQMs/gSGvyhYNBHaX5+nLWIZKDDJU9vngY4ERr/JDWSbC
         h3AEt7z401kFkyVhbKgh52sPXUZeY1s5tBkorE3+xOx6K7n6aE+G/WMds7DvFx6PjBas
         H3YhwXaU3myOYl0aNDk5ZrINxoedO/1OlNYm9IPg4VNrNUQ/qdcDZll5E5cSsyAzzGp5
         C5Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223381; x=1726828181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGS5FnAtxOoJb/6wOxS2ea2cNEevmIiG+LI1be0l3jU=;
        b=tKM8XbqQRCgahYGhKKE0O78LXloqHkQqEP5E5qde3qmcrp8iV8Z6+juFpXA9lB+ULK
         cH0Tn1jGLFtFz8ofNncL5bzL7BO2ja7b2eaYcXi0DMurCQuytyaz5dcSpdTqMKDfqthy
         PiCLerdNDVNELMYXJh79viu4gXMHbv8zWKv6EG32DusXHLO88UGpoUC9Z+/vQUV7ooZz
         HNQ5P7DtWgsgoRLKtlMPStX1BFRANlIDuPRSVT+oj4pstDXbzMWnMnfgErtg76Fy9eS8
         ZgoD9pKGprdfDpXFLsG6IBwAdR2qTaC57nq+Kt0XU83buKYeeWQKH7RkX8mTuSznw8Yh
         BcBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAaoRVI1PrvkJTyhf1poqiI+vGV+uwFpJpvaEHts3wViNVaPNgWtleMT1TtShplXo5ZeLl714Lo+jkcL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaQ3zkglWrRnbFrRcG+xWAY6OWDrLady0a09chsjkuEq1A3LAn
	aSgLtNdn3PQ0SH32Q7DCMbRKYnMwz0QMCYkdXR+qS9o2VxpZKTuF
X-Google-Smtp-Source: AGHT+IGOIhlMK21wDG7gfBh7xJ29q0pemK22aSonTKBmCiY5Rke4XQnf2glORp9FkqlC/OSyMafqjQ==
X-Received: by 2002:a05:6a21:9206:b0:1be:c3c1:7be8 with SMTP id adf61e73a8af0-1cf75f3b4bcmr7262126637.26.1726223380696;
        Fri, 13 Sep 2024 03:29:40 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:29:40 -0700 (PDT)
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
Subject: [PATCH V22 13/22] mmc: sdhci-uhs2: add set_timeout()
Date: Fri, 13 Sep 2024 18:28:27 +0800
Message-Id: <20240913102836.6144-14-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240913102836.6144-1-victorshihgli@gmail.com>
References: <20240913102836.6144-1-victorshihgli@gmail.com>
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
index 756e44d84b87..6b249eb8395a 100644
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

