Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68D1991BE;
	Thu,  5 Sep 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531650; cv=none; b=lDDhwcuc88tt8R8P6rfLbv3wlScQt+ifbBMPDvG2BhG+3XdsmfvIvJNgYZGuDIgpAEGTLp+SRfMevu5ZXc6bhl2xPbKVl/G1HB+AVcmfLg+g8fe0TZzmwGCQkof/ZH+M4zuYnp41YoGRBit96yt/4yLth+q0jg2GT0FYqa7KngE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531650; c=relaxed/simple;
	bh=SFCAPMYUToX959hW0aIShZQqJGkxYWPyMu4KNnD8Hbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R65sUsTvfB7u6ShTiU95+7Bzg1YWpLshpS2+fMu8uw5/idEOwRxlWuWGs+4W8GhcKTQPZBJxSlgct/tpKvLdUp2GtKQdo0OV+Mq/Bt1Ti52lekrv1lB2bVH7R2GHPNsb6ZtbV8Fp6bDIWl6Z61WJzKZD8k+aAzKmBALFpNLdIqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igofiK6q; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igofiK6q"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2021c08b95cso14212305ad.0;
        Thu, 05 Sep 2024 03:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531648; x=1726136448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaGkQPCGzuVUjaXJrxV+hmji/yjfP4ceyoxn5sAqRnc=;
        b=igofiK6qwjYBv5EgjrWOz7rQanKnHIUa+ExOEkcPvSHqI9dmij21hy72CpALgyNjeJ
         QVpLnIMOPdgM+gneEdOmrM3FWbF97eR1+NDS8rtO+jqVjBQFDPp69xftKX/y7kWBe37H
         vvA9MM0ZnlOj72vKyPptOKKv4De+Sfx+l6PguAr/1komRM4uGAjTsfasWKH5O2x9o1Pr
         17oO3BH7m/BVDlmBQV53uQnMtB4dihH+5rEQzTOWMLYYUQNH8R/sFolqBLmFMzuKXuAn
         Vk8QqAYtqe8CZdB194uc2Af70R+uu/sKq+AFaw5L34uwuh6N+dgPJ+/3FyNNFfeGcqoy
         yzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531648; x=1726136448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaGkQPCGzuVUjaXJrxV+hmji/yjfP4ceyoxn5sAqRnc=;
        b=h78Kw5475Sp7o5GQWW5w/a07hXzWl/jogBdRuAVyBovEA6V0fS26vz3CqSv3mbgIye
         sxuv58XUddremKCpVeUEUErNti5y+a9o/v23g14qL99nLV8g+4VawMcq2GAFbpZPh7tf
         MJurR90FrAfSlSuOUdTjrPWuorPQ/htxazGXpofNstTheZMP1ogsjG/rgSUXDftOk9Tg
         +04q7Cc0Hfr2PGWn1KPhoJnHHnQkS4QXiiOhXI/wVuQm/gnYPag3Pi6iQvHKWTVwvdjF
         62cLabogsZLQg+FW9F7tBcKHMruIxgYKBWZZRlLw1CkSB5qUFMao9cDeOg1eHX1WXLWn
         CbEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5iy9Esdsenza7mG3GBO1QGErMqaRPa5XT5antWnaIRt/H5KHIil+UiPlqNNaB3ciUOCfHrmY2N2ubZMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaDhfmUWLMK8HSS8YW5LI5IA1nXmChASt+JEKk7UC4CAhgGUXv
	9h3hS5C/SPWfp0a413teXDT0VpWOjTyopguyNeXX2ofKj1eK5QeI
X-Google-Smtp-Source: AGHT+IFa1h8tjkkiUkM/og1FT6no2zVNKm8bOVm/L/Ckq6id4DPktuzThHFIk+o3uQpPITRUMDxVvw==
X-Received: by 2002:a17:902:dac8:b0:205:4d27:616e with SMTP id d9443c01a7336-206b839b15amr82867525ad.22.1725531648590;
        Thu, 05 Sep 2024 03:20:48 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:9999:a704:87a3:25c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3855asm25979245ad.144.2024.09.05.03.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:20:48 -0700 (PDT)
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
Subject: [PATCH V20 10/22] mmc: sdhci-uhs2: dump UHS-II registers
Date: Thu,  5 Sep 2024 18:19:48 +0800
Message-Id: <20240905102000.5020-11-victorshihgli@gmail.com>
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
index 608f8ad5aaed..9cb0f1b2a37d 100644
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

