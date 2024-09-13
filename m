Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA931D933B;
	Fri, 13 Sep 2024 10:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223351; cv=none; b=M9J17JMO3rWyk9pyAH8lLWZzRSCFbgtU4tBa49cnEMP9mgxzWPkkB1ql+yVGBCUcw1Ww8uB0gVFpTefapFCaLkvoImuc8cgqG1bf5A++hWkUDbIXUbSlTU2Y9RaoyKWIe5KjlbmF8UebZWrqFgf3G7wsWNk2mgv/3Nz5juC9cq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223351; c=relaxed/simple;
	bh=ItSyxu3z+cpuKQYpHT1VflweB01MjpYZ5FR4CmHMj+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z57I9ChAueHidK2nczyfXdr1pc+QoySq4YzCK1KUHZ6pRKG4z5hmn/FtD47HFyycfqfUONbjsWbKv6YTJMr/59eUmQxhDnV/ih9EyMVql2yhB/LckBsRtOLUU1JHQIBJtdcVvKZNGkz5Pdtr0H5g9j6sPgEXfkSKwKa1Prho7JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKLUGoX7; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKLUGoX7"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-718e285544fso620247b3a.1;
        Fri, 13 Sep 2024 03:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223349; x=1726828149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxDQEMkG0vSVZkGLeTe49B0S8pLWIGbl/FPUz9dZDz0=;
        b=ZKLUGoX7FL/TtdnnnHFnr1SkDA96vW7TpCA/J56w5Hc4NOrddDwr16tLzk8R6fZOEm
         AuUP7yYmYFow6fHVGkudrpxO4Gri7itegc4iHc/02dEHo9LRPkPtVQvFvjmBY/5S6onX
         h9Gq6mKiLy5mZQYAEOssox4o70lJaY6u4BwzxiP5isSl95+PbNomccgbhbXwtuNs86MO
         /RZ9JohCmRmM4K0m6axaGiMFLpp2/woLXSgUm38xkKsXlIq31kDHrOqRH3Ql0FXBD/NT
         9ZX19/o4md6ykv1dNpBtE8gGS8lvOPJe75DXoHjYIX5h2f459ovfXxM//ZhVXcZyJcz/
         tnpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223349; x=1726828149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxDQEMkG0vSVZkGLeTe49B0S8pLWIGbl/FPUz9dZDz0=;
        b=i+N2/fE4vYeKVAfVA9rBN+HlCkinFc8IPMiZtavcCuE0tvuZHDs+yuHtdPDu6ibVxM
         AY3SQHCbXLrxYFwR1kl9mxZNlMmeKlprWUUQJp4TJK2npQhRYBiezzuZjoPpUqLdB9/h
         Cx4YHo5Uy9/whRVFGvoDj9qLMeOROd5jCjxvvaEhVq+acBULBlP9hQd1OUsdA2sjtne7
         MP8ojRYzQ+DIPgC0KfF3nHveFXT+aTMzki7Z1lKhoKP1hvu0bG5kkTaoIUmL4bBvOE5/
         Sq4ozgzJbKfrhroLOLPrdVQB9s4gI29Pt0P7BcETdawdE5sRWgxpFUaVUzmatICZGdAL
         aJ/g==
X-Forwarded-Encrypted: i=1; AJvYcCVhWSkKOd7yMOI2VJ8ms3276xnktDXCpF6mfmR45jMvvrSD2yGh+RT+CBoDuno0C/h0aqt2lTgF1ir8OT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDDjZOldrh02FS73UEEclZ02C4mD3g2XH6hBQfJKi02omswAfv
	W0JAc9W256MNuG59pxrez3BuyELzAdxcr14Buwl8KIfCyyjOt5CJ
X-Google-Smtp-Source: AGHT+IFJXxSoQGqEc+wCI3vDO0B2QBm8O7yvnla8p5nopbp/FYMfCi6VpHfoFD5NlixywPlt5XFwdQ==
X-Received: by 2002:a05:6a21:6f83:b0:1cf:5d45:3b29 with SMTP id adf61e73a8af0-1d112e8bfb9mr3445999637.35.1726223348935;
        Fri, 13 Sep 2024 03:29:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:29:08 -0700 (PDT)
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
Subject: [PATCH V22 06/22] mmc: core: Add New function to re-factoring the code
Date: Fri, 13 Sep 2024 18:28:20 +0800
Message-Id: <20240913102836.6144-7-victorshihgli@gmail.com>
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

