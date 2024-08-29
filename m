Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0030E191F88;
	Thu, 29 Aug 2024 10:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926604; cv=none; b=N1RPDcSOJKiorGEAjBNg7tVaXX9lOmbU0XijpFlyY7kNAVB/jai6rMSN42a3hiode190XLI90WHsU3rPEvonYAo9d1ejRHcC9NbRpw0y/zRL4snNBL9GP/iK6ClYwGYDbreaQUlmWMxGd50+o9Jjmgzzr4SSiIDQVHHRLfKgisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926604; c=relaxed/simple;
	bh=+dwK5282uCMsnjW1mk1L8dKJumjWhVd+pfUeWylbOt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAPa1+aVlfp13OIddimzvdOwFznrEmPAJorxZLXVxFA2u6C0OaTmTaI5KYix85K3CierPlwJZlFTGzer1u2N9iwCOMGhChcP/4uL71xm3RIIOyJsEmqLExzxt3efKZZFuNGxKRHrMfK+G/g2zXf3JlgXGAqc2/W1zWhuoH7gkII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+RZa+Kx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+RZa+Kx"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71433cba1b7so355038b3a.0;
        Thu, 29 Aug 2024 03:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724926602; x=1725531402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOdkXrgNTgcSvN5kJ0Vv+BY8p0cgmlvV1dWGrb2VSKU=;
        b=Z+RZa+KxA3JkM/xC9NshC6kiU93i+wz2oRSAcWJz7bfoJFx+5rtyKNBpzlQ3jXaWK9
         0B01kFSwq1y5WoWcSdSMjCrz6P/4SXymnrpCCpZNOj9UnN0ZXt7/DPdid/wEhz3+2t1R
         L7PrPjScI16MwuzBjEZELLbVyZjuCeS7MlX55woInggH05qXVi7VORJ4L3uyKnes6Llt
         MwjFccthqG103lK6iR+U70Une1vtaf9b8RGIYDKBeX1xH9jazQjzFBnjL6R47qn2OduF
         B1n57IohrptOBYX2TTPPypUIju5Wo5aoVl3dhtCwQamLekDwZXgP+1qmEyIzK/AmjlOl
         3Kbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926602; x=1725531402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOdkXrgNTgcSvN5kJ0Vv+BY8p0cgmlvV1dWGrb2VSKU=;
        b=XzQ1QFQMYlq2faehsZTvBAa9EDFrRJgmBnZqQF+xnShZVgJDEH64lpyjDzGcmFshvj
         XeHEQN6plykHghCnjtI04nzHoqoLPwSKN+5Gt8AYxwM6f+UUx8MBh4Hfp1VcL86Pk7aZ
         iIABF3IlecdFpgm3RZfmJgcCi3YjDzaWzlDGmWGfOLIhdNhgieqrxCTOL8ZgMzSAzj2M
         SOjzIJ0Q2nGC1MV4OYwO4GUUPbQ8hBEVK2alWvlXzjfjEdjS1MMP4bg2OB0HUlJy867F
         D/fKzvqlxmWU4hXz+23NXJdBR2exvJHzwatmBLzbtFug+jH2MOWAPTsISsKwxVziJ64H
         I0Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWX1eGyPl+LOuWGTl6+2GElxYvhZjPrB0SbwsTlg08EoFQ9wLQSSBe7lc5AOwdd2DEQ7i/DSazU6ISaLKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKjWs14R/+DeaCOJnCNybL4+G0cpMqERJbxtrVBLsJfEHB5eIl
	Bt63TL48K6r0QeyFGQTRB+E7kF9slY9Q/e9szGl8LLk/V/9wvVskTepVCo4/
X-Google-Smtp-Source: AGHT+IGYhUPbzFzj8UMIA/IVInqlsjyTbIAzWKjh5I7le+6uL0YWkid8gpc4ahV0grLpBgAw6oBxqw==
X-Received: by 2002:a05:6a20:c886:b0:1c0:f648:8574 with SMTP id adf61e73a8af0-1cce101d2a0mr2064815637.29.1724926602235;
        Thu, 29 Aug 2024 03:16:42 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:a52:632f:b914:4ddf:273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d77eesm816577b3a.153.2024.08.29.03.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:16:41 -0700 (PDT)
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
Subject: [PATCH V19 13/22] mmc: sdhci-uhs2: add set_timeout()
Date: Thu, 29 Aug 2024 18:15:30 +0800
Message-Id: <20240829101539.5058-14-victorshihgli@gmail.com>
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

