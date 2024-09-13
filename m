Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC01D1D88A5;
	Fri, 13 Sep 2024 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223374; cv=none; b=qVgnip81JXUvC5unPhG56Eo2EPWoITYC/gzR9cGc6ox2OzsPeqA01PdorOR4PSgFUNIe3K4grGtGYq5vBU5dOW1GiRbVEnvNgXMsZkVJdp3DeAZx8LJOS+rDyGfnEk59EqlgyvikjfauqF1oy5sASNVUzYdCCzjnTyPHqtrRWoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223374; c=relaxed/simple;
	bh=CdA3SI06ubeqqm9CRejDKr9MVIb3Sm3bm+DpHuLlSdk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qAG96JkeKUsDQnqNX6li++uiAao+lZrnDFazb8nVAG/hJIcjNIBVYIFWhsxZ1Tt4nWxtAKMvsjAOPv+eSn8LiOfeBs3fHZZdfSVSoKb2KYu5n36sBuj+tqazebP7QVjFXhK4XUwQMoVnu1ljHu5jARZmbpK6STVvV8IT82eidTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NztmgmO5; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NztmgmO5"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so1287323a12.3;
        Fri, 13 Sep 2024 03:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223372; x=1726828172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpaYtlLd3mQ+A9z10aDKxE+hmD+tiwgrXgbBd5u7JA4=;
        b=NztmgmO5detAdMVa8QbDWShVj3dN4ktpI0Syi22dmpAnK6FenDU3/Lm+xz4msOzeKO
         U00iTl0Vl5Ujokb03WzDwjYbW/e0xGcwyqMpPrHpE2fAtAfgvDZJpnKP/vWwXuLNy5A2
         2PvP8mGJuFIE2SdGoS1igdjbSgDnFny7v52ygQ32dH2nAxaxhzoZ4PntQpxAQgPiz1oV
         LECQpJJoevF1UFiylpNiX1bMMFSF0zQ5RKvPxw8pKx9lOZy/6oWmBgdVLYPsOijIcFtD
         SrA9EUfxp9QG97Nv3wkc3HkI717JDzZW/M8+6cwLdPvfZ5IVQHpxRtCPTEPuT515MSt3
         VDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223372; x=1726828172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpaYtlLd3mQ+A9z10aDKxE+hmD+tiwgrXgbBd5u7JA4=;
        b=CmQfW9fyu6uDGV+bazkEp5VP+R4gn3xo9oeC4kTN4BZcXiwcEL9Ei2RjzJj4owgKr6
         vRz/njOw/FqeslCHXoeiZbPw6NYZ5jIq97eRL4iW05sAe0W1uosdTf+Po26DzXeYwfC0
         1OvaoKasu+Bt/siEa3kekc9Et1QEgZrzCY5fXeaZQ337e3NPqmOIf+jvc8Gn1k7K7vmt
         K/PCgv2+vqngFudEE3MezRU7TFGCxQ61YR1bdI3DUhkKCCA07uUWKHQ187cv9ixnL3rF
         epgsfvh5Np/atd8KHfvfmdq5TO6YsHl512IQePFRyW/PNzg2CZ+7L6wRBkOTfy6acIuA
         QYVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMJoHpLebYPepsWL8RiQ8/4s8PiQH/zCr5QJ0agFNYKVAf1qfxKLUhs3rdF3o5GarKS7S7DrqLwcQ/eWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3B0upL5OG4Co2GZJSIM4UQys2ocvj3lAhK4rOsV4qH3tyRgKo
	uIEfc9N3HhwKcUNhmNXrHkuLpGNQInFG6IVxx3b4NBxHav/UjAu0
X-Google-Smtp-Source: AGHT+IEX9bEXtXQssY/4gcsnjdhpsxIGNHx+af2LsZULDcnkegPgwYTY88BJ288Gia0noSgq/gB0LQ==
X-Received: by 2002:a05:6a21:9d91:b0:1cf:2931:727b with SMTP id adf61e73a8af0-1cf761e5546mr7707540637.31.1726223371876;
        Fri, 13 Sep 2024 03:29:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:29:31 -0700 (PDT)
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
Subject: [PATCH V22 11/22] mmc: sdhci-uhs2: add reset function
Date: Fri, 13 Sep 2024 18:28:25 +0800
Message-Id: <20240913102836.6144-12-victorshihgli@gmail.com>
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
index 14514710e763..71c60952a40a 100644
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

