Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4AB1E2138;
	Fri,  2 Aug 2024 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594227; cv=none; b=RnqyM+TaKVsGZrBOp44Elrr69Gg/MDHCBQesbfxsAbxwtxlxBeZiJWi1tD8evJk5xJoke9OHoheMIOn5OtMKF9rI7LCVvfwYOEH8tQB2wl5KbFmjWodpVWe9lqYrLiVgDMgjn2+Lj2eRpRR1x8GDgpRlgNbviFjsX+FyvHwY+jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594227; c=relaxed/simple;
	bh=+dwK5282uCMsnjW1mk1L8dKJumjWhVd+pfUeWylbOt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AHIRuuqEY6gCQ2ECLblOCBMvPqxLgPJAaUtCBnyXZ7vJthKu877NCxVgxmNmT+UEYF3O5lBK/YhIqA2er9p6+0cHLmfzBK8iaERBJrE+tHjxPZhQOXhzs7nqnknnCJQNfA5i6eA7pwlLwMwF9bkc0nY5swwrf5tYurGJ3zG2YYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rj5Oq+mk; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj5Oq+mk"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7093472356dso4721339a34.0;
        Fri, 02 Aug 2024 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594225; x=1723199025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOdkXrgNTgcSvN5kJ0Vv+BY8p0cgmlvV1dWGrb2VSKU=;
        b=Rj5Oq+mkwEJ9KmYTEKRlUan2O298ghZR0GPEYVRfTKTzVyMKTugZFynkrqn70G4gGu
         xi0Nb+rS6JtXGgF/8QP/mfd25gMRXW5hd0sSkIyIiLDWFHNd290yNJ+aYePoCG7Gfz5p
         twnUF2Gv7jnWX2QlXHyeZL02gE2u4byYQ3p2fctvt1dpxE5IthIHlEIXTA8ypA+1YyMJ
         8pNsZ/s8nP2/TgtD/FIxffcj6C7B3GMvSt+aH+CNAfOHpbvPTDEHAbsrK+gpgO3wpM/r
         Nt7u6B56Z3UCD+TxZoMOWnZkBfdBBEaN5Qq4Wgxgrdp/c9nJO/kNWPsPSj3yRVNmncvZ
         Z13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594225; x=1723199025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOdkXrgNTgcSvN5kJ0Vv+BY8p0cgmlvV1dWGrb2VSKU=;
        b=kr2APk9iTQFCwZlD/lYILKp6WVVRmLF+v7cMm38ngLzfGl9Ym50t5tXWuYehF6R+cn
         Dt6cFaGLW0kpcqAMCE6pIgOeS2u54UJoMqHfE1l2PTxKSQq5ApXOGCPUcPYKCs6K4DCH
         mWZcUHgRNi1k5df/AdULSIoi7nPEzDeD9WIA50ObcQ5dvMYhobYDdMscnH5/Vau06F1T
         9zsPD9q2SADubXiMFt8u2O5VIdCAXrhJ/VLxnkZjRzvQbmR5SEHJKpq9nqICHQqV6+Kk
         9hOv29wpeh/G0eXg192cdndeM/Uvf6J36wotzg9ymDgeBsQT36DWOQ590kcPac44HGkF
         Xu2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVziruFE0a3epXGWU9onbBMh5HwJnGvGTLLeEenawrEcvpC3vYqzMDxRGPHEwKcHwC2i8qyErmDdNmN663exd/UWInVyR8+Hj3NIGnY
X-Gm-Message-State: AOJu0YzjBEYKg1dunE9dai4TIfoV6z1tDTnXID502hKsrhhkqs0VWWf/
	QYA4EHj9RtMBjIRGD8Q1g3WOmcyvRclNX3wZmcIBn7A1As8cGBVt
X-Google-Smtp-Source: AGHT+IHsOYFIrsRLOD+ByzdaH3ksYNl8M7XUYetAyI9u3th2NhhiUC9XlcOodZPRhmG7ak/WB75f6Q==
X-Received: by 2002:a05:6830:2801:b0:709:2752:4523 with SMTP id 46e09a7af769-709b3209eb8mr3688911a34.8.1722594225182;
        Fri, 02 Aug 2024 03:23:45 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:a802:89d:114:fb3c:5d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b784c61fdcsm798000a12.51.2024.08.02.03.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:23:44 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	Lucas.Lai@genesyslogic.com.tw,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V18 13/22] mmc: sdhci-uhs2: add set_timeout()
Date: Fri,  2 Aug 2024 18:22:20 +0800
Message-Id: <20240802102229.10204-14-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240802102229.10204-1-victorshihgli@gmail.com>
References: <20240802102229.10204-1-victorshihgli@gmail.com>
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

