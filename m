Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782641991DD;
	Thu,  5 Sep 2024 10:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531663; cv=none; b=lWutuNaJjmW9qYcfibTO1j2y8YG+h3BmTFgT8ENJHPaCpM3EO71v6eId6f2zPkVsY8B7rMMQCXypRlKTjL7/ORJZmcpveBVfHTSQ4mCKukWlBiAlwaxkzvOCqPopRKgkLx/pbNNwH+W5MkYnAo9WMP/MVoIOzLw4fpAEeqOVonU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531663; c=relaxed/simple;
	bh=+dwK5282uCMsnjW1mk1L8dKJumjWhVd+pfUeWylbOt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IyLBY3klcvaDM1VjobGIpg9GeYnWUeWgqU+oXx48WJz07FBgnhXtwJTGD7qCZ4lUxucKzDA4gzFkiO66HNdc3dO4fzHXPdd/SisqKCZKHgSuRm7r++fD6l5SHvR/NkfwvgwGSwCHSQD9TojSAf+kde0rasxoCcoRDQVOQ0OW1sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nl/gbQKq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nl/gbQKq"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20551eeba95so5671765ad.2;
        Thu, 05 Sep 2024 03:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531662; x=1726136462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOdkXrgNTgcSvN5kJ0Vv+BY8p0cgmlvV1dWGrb2VSKU=;
        b=nl/gbQKq2aBqpZpkMDs71enwfFfx0ZtJyBf1ZN9nuoZmLwO2r7HlMm1+m6DwVvFzfP
         bthweD5YGM4jT1AfSMwdQW7hDbrPKCmeLYDX9MHm9naQ03Niio3qTK11E6ejV+RByh6H
         eJ5V5csmC0pfGkpQKiJbql4VEutRIfpGgpr6Ab8HA3C8fTkKU/UlhLA5nFWdb62IC0i1
         5EJUwfvi/BKb6eYgGjzy44sgb/CTdoScpfjbemT3C/6Jm/MLL6yjzqPeXssQ8tk1os35
         ZGOPw8u0hE70PrrLzWMclYysDgMfjqLEMjnBtSUz/qr7lJ8XVnuCiYIL3sT19BPnAxnP
         15aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531662; x=1726136462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOdkXrgNTgcSvN5kJ0Vv+BY8p0cgmlvV1dWGrb2VSKU=;
        b=muNzgszEwhLDwmAdHKeTWLQu+ld24VliD9le5MEHnMt1xNGz84kw70iJZoNyH4pb+1
         wfQX3hcipu2s2Wgp7LKhnqjCBhZWkAb1Y4z1N2qAoW3VHSKCwBBqkJe7khiOdsKY71I3
         NTvKm6s0MdywXSIliTh6L2DfNk7FXftlTOPwceC0ikvzcQReLt8MLbQnwGD8eYb62PgC
         YbD1aHQE3HIPVVofBoCIELVn/yZ86O6Mqxaw29NNAfey5Qgs5pr5Uz5YhWeOQxQuicDD
         PLRgucWsdJg5TdXtjOjVfgsS0j870PU4nvzGMxPJqdkfGabOYL8Quio4AlPkVa5femrP
         bMOw==
X-Forwarded-Encrypted: i=1; AJvYcCVyxex7qF/hcK955B9X+78nZrlAi2zuzbE4mNFajwujNixDzBP6bWOSNAQC1OTjAsloaIjZKsytET2eyZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7mR0DbFrqm1XkEtlU5MA8Buh5kpnqBDrzAy+qMh95ImA0l4F8
	1uex7hESYY0j9/Mkh6CNcbYRy2tnaRBPc1vG42kph82WKFxrBxaJ
X-Google-Smtp-Source: AGHT+IHLYSdkLaftO6IOAxxxc24gLJ2C/A1/R80YRhJaDaBNswo5Kek5WSFgMQY/PORtYFfo6uClFg==
X-Received: by 2002:a17:902:da8a:b0:206:8c4a:7bbb with SMTP id d9443c01a7336-2068c4aea40mr126116155ad.58.1725531661842;
        Thu, 05 Sep 2024 03:21:01 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:9999:a704:87a3:25c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3855asm25979245ad.144.2024.09.05.03.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:21:01 -0700 (PDT)
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
Subject: [PATCH V20 13/22] mmc: sdhci-uhs2: add set_timeout()
Date: Thu,  5 Sep 2024 18:19:51 +0800
Message-Id: <20240905102000.5020-14-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905102000.5020-1-victorshihgli@gmail.com>
References: <20240905102000.5020-1-victorshihgli@gmail.com>
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

