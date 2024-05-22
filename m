Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C60E839EA;
	Wed, 22 May 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376212; cv=none; b=NqpWAv8hlR9YeZzNARZZ/2UgIXO1L71NjSCiXH3hhtpOVzqlpReVrvn+l27Ks3RwvTD4V8i5GWgcuJDeM6NgVF+xQAqMUF9Kn8CuRH+RX3tUAokmabqhrlkhRV/FmLB2bik8f0X2d07+99reqljyF5j9zLnqBbpZYALZt7KU7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376212; c=relaxed/simple;
	bh=Soy/+Fwgbt0INuM2cPmw0hhd0aE0PW8ni3wrIYcRiUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QEKoVrDSYtchUw+Ql7T0sh1kbGCHruxknrDyT6TyordLZNHxUI2K72HLW1PRxxHo8UrusIhzAPEx3OuMo2iOXABXDRuFK4CHRCimbbB4AObfzUWlCklWr0/ubyDIcXyi5NU+QfXVUUc8+u59jVlEjkTiPNupR84f7qjT1iLSq40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kZQV3sA6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kZQV3sA6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f304533064so5499945ad.0;
        Wed, 22 May 2024 04:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376210; x=1716981010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Fj7MKr2tOzge1qyOk9/xzb39EqiXpQi46erhjZRq7c=;
        b=kZQV3sA66dEXekJh4recsKgapQfpT97vdrBAyH6CgD6zVcRDQ1jkG4sQ9dTw2CsZDP
         CgtgSp/3VSS6Eak2bl4F9R8NWbMlzjOuznipOTLrRqbED7SDAaVSrrCGtzgAfB63hVGZ
         eR2Fe8pCuovYBb89ljxwnVwu31KO46fMvKc3O+CW+UKhtWXAi47A0fvkvDKgYYVl/Ilh
         wsUzu4mw4n/j4cjbVSktrbC9GdIDRGRTs025l09GFUqRd4bFDxotw4fwPasJ5hqRLljw
         /DPeeqgZN94tap6HpVNJFzjnwsUFnOu0lbxuSkvHZiMf6dIOjGCW7KkDSS7S72sSsuOA
         RpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376210; x=1716981010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Fj7MKr2tOzge1qyOk9/xzb39EqiXpQi46erhjZRq7c=;
        b=HLbGIQ//Ka+gOu8zz7r4gecjP9fuuZq6rsZI4BJbjJW7ZeaiYWl5A1e3pLLUIxldRa
         DODx2RQwQa170DELBI97VhsLUeH32wWeEL9msk46EcU/eiD1qa5wBHXLDgA47X8fDH/a
         /6iHHFNnqO0fOUf15ZmIVE9h3Xq1JEYoMJTaAS/BFVchHhD+k4AkwxQ1IgRMPLmaFUew
         cLfZ7GN6UT+gaW1Zimdtvu/Jt4lkFRTL1CLslnjWxTpqvxy7HXtxdKQX76SaaZW0DnbH
         y1OdFQb8mA7sOWBWGNL0xDnR1PxDMSutRwzJFETRx6C4xDdchboapohgK7IePLcs2b1N
         t1Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU3AQSPcsctiXjqFTVQeE6YniLmUqphhiun2ETas/PFlr7U1+uo4LE1IJdTdlHs1vdndPnTuCFciehVds38qiuKypcU07JcWHT+QrY7
X-Gm-Message-State: AOJu0YytllefFwuQ0sqawJdKufL39hj0NjgbGWKoaihqcI7NLbOO1hEL
	pIZGhlGayLGTVVmOoEoubPqsx2WBrjHHv2fUgdkeCYwnUDlJzgzc
X-Google-Smtp-Source: AGHT+IG5+ZTYSzr0xImkYaoqiK7RqN8eTm7Rc+3BHSyM0Y+ZRIt4ABOPAxx/C2AqRRKd1sDwDPd/ZA==
X-Received: by 2002:a17:902:a70f:b0:1e7:e7ed:cbd8 with SMTP id d9443c01a7336-1f2ed32b1e1mr121795515ad.22.1716376209851;
        Wed, 22 May 2024 04:10:09 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:10:09 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V16 14/23] mmc: sdhci-uhs2: add set_timeout()
Date: Wed, 22 May 2024 19:09:00 +0800
Message-Id: <20240522110909.10060-15-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522110909.10060-1-victorshihgli@gmail.com>
References: <20240522110909.10060-1-victorshihgli@gmail.com>
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
index 8ad9a25484fa..8c802142e875 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/iopoll.h>
+#include <linux/bitfield.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -152,6 +153,77 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
 	}
 }
 
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
index caaf9fba4975..089a6c0cabda 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -175,8 +175,10 @@
 #define SDHCI_UHS2_VENDOR_PTR			0xE8
 
 struct sdhci_host;
+struct mmc_command;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1

