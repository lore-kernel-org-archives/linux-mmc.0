Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE271DB524;
	Fri, 13 Sep 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223369; cv=none; b=KHV4rPNqSqlSU0tednTN0A8C2gBn4aOpoLjC9rzCZUE705cBTyU//q5QLPOTdK/Np6XK/BBjMQpmuERh02ZmBEEBgK0NwNeWYm68ea0JlVvEtlzTIYcW+8ENokmvSrUh+JKTT16jI4iQZWRYGA2iW6Y4hr8abFGJ45FER8+A7Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223369; c=relaxed/simple;
	bh=xwFiWQ5tOpWStPyh3+9Y+jsJxfVLG9TjYX8BQUYRy6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TTxvNwtWJ2TpForBA1kIdtUNPqx2+yENk2D8ELXHHcLfdGUBvbjH7DEgwNEJRmqdsE78L0cSY/Fe9MlsRZH2LvdvgxgrgJ4ZJTb3KIzio+/0pcJzp+J5WGA8Or1Y+MwBnkM/HYx++5JhZL4CFLaFlBbwhtB42Y4bBD6Vu2di+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8ZjNb5t; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8ZjNb5t"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7d666fb3fb9so1014534a12.0;
        Fri, 13 Sep 2024 03:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223367; x=1726828167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tY1jYPZ8EM+61uC7VsYBzo9x1mBBtiuwXTRSGcxof4I=;
        b=I8ZjNb5tPTrg/xSmg9gQvA1ZxALVAPAQNzoFBzI90kF10Q3ION/7PgiQMYR7LnzTzv
         UsfefPix+GA14jYdjT2djUIcfZqQuULTMKU3WIwTX5oBkVxISn4jQTxAUx+xWU2d12TC
         fnxXOPMMyoJ2mIIBPuSyXKJkWGS5/mpJ7nGLhrtK2EiMMDWvbKnjrXhTd6ons///dI9b
         S9wLQVPtPjBCczKLcBWDfUgz1yOJ8a3ZcwOe+HxjHlsghOyoD/dcpiBoBeJVa+ZFF/DV
         VDQNx4105FPvhBvVIVa4SKh8dROoZyYL5xCI7KoytvXJ8TQaPrdNV4c5aOsTyPhsus2R
         k04g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223367; x=1726828167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tY1jYPZ8EM+61uC7VsYBzo9x1mBBtiuwXTRSGcxof4I=;
        b=Fc5czWkZ4p9vRK2/89EH8G3yPGFp8XHqQaRDy6oP0r2cKhTsg0J39/e4iO5tkAM3KY
         DBTObTtY91eklhnRQ2cKs18pHPX7X9NbL8n0LZATK7LUQn28C20+ry2Qpex1AWOGypkh
         8Tn0Y7SqtFF/Vv3tPAWCp3crK3u4VhFYIAD/BKjCu5pfRlh/h/6BIJ7BjcBXqEPo09da
         S0+BEk8QV/jCyGQJIxAeroWKWdji9pKQ9z9AWTyQkEnw2LtEBGpKDzufTnhzEoxXFygv
         0BleYg0FrsQY7MR8WbOUrcbNn/LwHKXimNcdRLLDEkuMAju560igQx8uWh0+8ysk1mOC
         CWhA==
X-Forwarded-Encrypted: i=1; AJvYcCUBXBhqQKz8UPyUPJKmHN5/bX6W8FZ6FiMIoNbbSCW7FNz2KE9tqcN2ooxjCAeeeqgeRETgOAbHZ3z2OU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPQN9xogVsH9Tkg7UZHqfK6upf4SsM6Xls2bIQJ3ub8MhXhNv6
	m8rI51L9LJeIZUbgpIYaG6cM6ORcrY275cYB48uCMpXTiV56F79r
X-Google-Smtp-Source: AGHT+IF3IOhB6XMUv1oqL/RItOlKQeXIKx/ijb6DPPFRRPbetQOO0yqBxvKcQvLiH2/MIo/lhKOQbQ==
X-Received: by 2002:a05:6a20:c70b:b0:1cf:359b:1a31 with SMTP id adf61e73a8af0-1cf756c404bmr9945813637.19.1726223367091;
        Fri, 13 Sep 2024 03:29:27 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:29:26 -0700 (PDT)
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
Subject: [PATCH V22 10/22] mmc: sdhci-uhs2: dump UHS-II registers
Date: Fri, 13 Sep 2024 18:28:24 +0800
Message-Id: <20240913102836.6144-11-victorshihgli@gmail.com>
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

Dump UHS-II specific registers, if available, in sdhci_dumpregs()
for informative/debugging use.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V14:
 - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
   sdhci_uhs2_dump_regs().

Updates in V7:
 - Use sdhci_uhs2_mode() to simplify code.

Updates in V6:
 - Remove unnecessary code.

---

 drivers/mmc/host/sdhci-uhs2.c | 30 ++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  4 ++++
 drivers/mmc/host/sdhci.c      |  3 +++
 drivers/mmc/host/sdhci.h      |  1 +
 4 files changed, 38 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 9ec1d6abb47c..14514710e763 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -18,6 +18,36 @@
 #define DRIVER_NAME "sdhci_uhs2"
 #define DBG(f, x...) \
 	pr_debug(DRIVER_NAME " [%s()]: " f, __func__, ## x)
+#define SDHCI_UHS2_DUMP(f, x...) \
+	pr_err("%s: " DRIVER_NAME ": " f, mmc_hostname(host->mmc), ## x)
+
+void sdhci_uhs2_dump_regs(struct sdhci_host *host)
+{
+	if (!(mmc_card_uhs2(host->mmc)))
+		return;
+
+	SDHCI_UHS2_DUMP("==================== UHS2 ==================\n");
+	SDHCI_UHS2_DUMP("Blk Size:  0x%08x | Blk Cnt:  0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_BLOCK_SIZE),
+			sdhci_readl(host, SDHCI_UHS2_BLOCK_COUNT));
+	SDHCI_UHS2_DUMP("Cmd:       0x%08x | Trn mode: 0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_CMD),
+			sdhci_readw(host, SDHCI_UHS2_TRANS_MODE));
+	SDHCI_UHS2_DUMP("Int Stat:  0x%08x | Dev Sel : 0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_DEV_INT_STATUS),
+			sdhci_readb(host, SDHCI_UHS2_DEV_SELECT));
+	SDHCI_UHS2_DUMP("Dev Int Code:  0x%08x\n",
+			sdhci_readb(host, SDHCI_UHS2_DEV_INT_CODE));
+	SDHCI_UHS2_DUMP("Reset:     0x%08x | Timer:    0x%08x\n",
+			sdhci_readw(host, SDHCI_UHS2_SW_RESET),
+			sdhci_readw(host, SDHCI_UHS2_TIMER_CTRL));
+	SDHCI_UHS2_DUMP("ErrInt:    0x%08x | ErrIntEn: 0x%08x\n",
+			sdhci_readl(host, SDHCI_UHS2_INT_STATUS),
+			sdhci_readl(host, SDHCI_UHS2_INT_STATUS_ENABLE));
+	SDHCI_UHS2_DUMP("ErrSigEn:  0x%08x\n",
+			sdhci_readl(host, SDHCI_UHS2_INT_SIGNAL_ENABLE));
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
 /*****************************************************************************\
  *                                                                           *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index e993f41ffb7f..2bfe18d29bca 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -174,4 +174,8 @@
 #define SDHCI_UHS2_EMBED_CTRL_PTR		0xE6
 #define SDHCI_UHS2_VENDOR_PTR			0xE8
 
+struct sdhci_host;
+
+void sdhci_uhs2_dump_regs(struct sdhci_host *host);
+
 #endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4b91c9e96635..5a5fe3528bb4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -110,6 +110,9 @@ void sdhci_dumpregs(struct sdhci_host *host)
 		}
 	}
 
+	if (host->ops->dump_uhs2_regs)
+		host->ops->dump_uhs2_regs(host);
+
 	if (host->ops->dump_vendor_regs)
 		host->ops->dump_vendor_regs(host);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e1013925e91e..66ab90bd4017 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -719,6 +719,7 @@ struct sdhci_ops {
 	void	(*request_done)(struct sdhci_host *host,
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
+	void	(*dump_uhs2_regs)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

