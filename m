Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037641C9ED5;
	Fri,  6 Sep 2024 10:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725618083; cv=none; b=Fjvl+UCa5dpRGZgvCKbCeknK/nsbAz6FIgopTlTuSbR3tkSfi8FvqdeBbM8R4I9QVZk1ThfYgB1zOsV+aDRT+QMi5FgwY6TZLKByma8z+p/BhG63GK+yZAwAjzS1TPTtqu19bO00/mVT/Kw+MaML90KUUIqa8dITHqkcOzfcZfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725618083; c=relaxed/simple;
	bh=ItSyxu3z+cpuKQYpHT1VflweB01MjpYZ5FR4CmHMj+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EdJOtkxRngtpPiyoqpGQmopFYdc/ZI1NCB59NR9+DAXrqRdWNZ8TZXNgDmwmP/4Hc+03fe3df9N8X/nOwvKsEjaOoOmZC8HtqP2/iW8Dbl+0MA98ltF0o/H84yi8omwLdvob5/LhfeOWCa/JM1CQxfSKHGUyrE60RKrGTaIJ2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O9p2AmPm; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9p2AmPm"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-717911ef035so1303752b3a.3;
        Fri, 06 Sep 2024 03:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725618081; x=1726222881; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxDQEMkG0vSVZkGLeTe49B0S8pLWIGbl/FPUz9dZDz0=;
        b=O9p2AmPmcRwkzbfa31xA0qcKoqAM8kHV/zIzbcIZIcqCl+KsuUFKXHRyMRL5qpc9Wd
         h5yq7U6xWuPybSXjnTytunbP97tazERh+QR5p4r2QfY7XzwAVAOjKPWgqBAVM8vbU71m
         0vwYGr932li6vEQtw6HhUbWQauX/Y4et7hxyCIRXbggg7TELdsh3kFSy5E52nJXbBI/o
         yH8CwXO+q4Z3tQhDSyu6JdOLxL/D8U/NutRQK9jkO4iND8gqj8x2ROGvH45B5fdmyAw3
         XdBsjm1Pk8HA9CPiCzYxHXEHlfI0JIWgT8HtysIGD96VUgIu0xHt5RL31M0h8pxdNUkp
         zJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725618081; x=1726222881;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxDQEMkG0vSVZkGLeTe49B0S8pLWIGbl/FPUz9dZDz0=;
        b=fgzwFgNowpKXlIitZJaHGiScTNXp9gf1VopN598UXq3OUf35ECwzsuihzXzGSuanm+
         38rLSTISZXIkxFGZHdZYFhCZMEmmMiFDOYiceyc77Kn5a26s8dqcKLDFYj1tr1S/6DF1
         UvLoa4rp+2ee0+0Ey4Yp2uAbGHSqBltx2bAumqryXYBaldbw67UIoYPj7pPH3eCLbIxp
         GXgfNW+3T96LgUVycqZmtPjc8injmS+ktjxLyicgiehMLFHgL17Ta37z6eIFKJdTlLl5
         025dIMdRdI+Vpk20Wx3kap3PQEuZyKw48iKyRPVekFYG0s7s3YufrPiip4VUQkV+MLq5
         sdHQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGK00w+XGlFpC2JMsSCkkV3GdEVX/H+LlahGM1zPaPffw3qIMRx6Qw4nNxn5+6WpRE+1NmdQAOQxpRrho=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsMVrESlLXlf3qqWCSzCDJtf6WIj7lhrmcEjfe9MsLg3BtMbN/
	uCUskEfg7Hz5nab35l9QMuAlAucA1JDRzNNnsCspOarefMPbGwoI
X-Google-Smtp-Source: AGHT+IFjsGBXTbHibqNyyUC6r3zAnxvrhO4b0Tug3BF3Ak81CJUO+xsMh3uvgsfpA+T6ovlnMKsXOw==
X-Received: by 2002:a05:6a21:151b:b0:1cc:be05:ffe2 with SMTP id adf61e73a8af0-1cf1d0aed4dmr2158955637.18.1725618081373;
        Fri, 06 Sep 2024 03:21:21 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:5f74:48c1:9f66:fb02])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717931fca8csm2072611b3a.139.2024.09.06.03.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 03:21:21 -0700 (PDT)
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
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V21 06/22] mmc: core: Add New function to re-factoring the code
Date: Fri,  6 Sep 2024 18:20:33 +0800
Message-Id: <20240906102049.7059-7-victorshihgli@gmail.com>
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

Add __mmc_go_idle function to re-factoring mmc_go_idle function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/mmc_ops.c | 24 ++++++++++++++++--------
 drivers/mmc/core/mmc_ops.h |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 3b3adbddf664..5c8e62e8f331 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -144,10 +144,24 @@ int mmc_set_dsr(struct mmc_host *host)
 	return mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 }
 
+int __mmc_go_idle(struct mmc_host *host)
+{
+	struct mmc_command cmd = {};
+	int err;
+
+	cmd.opcode = MMC_GO_IDLE_STATE;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	mmc_delay(1);
+
+	return err;
+}
+
 int mmc_go_idle(struct mmc_host *host)
 {
 	int err;
-	struct mmc_command cmd = {};
 
 	/*
 	 * Non-SPI hosts need to prevent chipselect going active during
@@ -163,13 +177,7 @@ int mmc_go_idle(struct mmc_host *host)
 		mmc_delay(1);
 	}
 
-	cmd.opcode = MMC_GO_IDLE_STATE;
-	cmd.arg = 0;
-	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
-
-	err = mmc_wait_for_cmd(host, &cmd, 0);
-
-	mmc_delay(1);
+	err = __mmc_go_idle(host);
 
 	if (!mmc_host_is_spi(host)) {
 		mmc_set_chip_select(host, MMC_CS_DONTCARE);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 06017110e1b0..0df3ebd900d1 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -25,6 +25,7 @@ struct mmc_command;
 int mmc_select_card(struct mmc_card *card);
 int mmc_deselect_cards(struct mmc_host *host);
 int mmc_set_dsr(struct mmc_host *host);
+int __mmc_go_idle(struct mmc_host *host);
 int mmc_go_idle(struct mmc_host *host);
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_set_relative_addr(struct mmc_card *card);
-- 
2.25.1

