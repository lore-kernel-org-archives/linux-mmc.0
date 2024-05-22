Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B8484DE8;
	Wed, 22 May 2024 11:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376200; cv=none; b=dHOYeZpXxAi7fRQ95YudkATDXOn7gvigYoEjf0jrBwnlOAFrVfIGMb7a8tlA5UDXYMX5fWP1DwSb33v1bvneEav819goW3QsHrA+sScnDtDqbe50uanZY/yS3XoRIyQMruH2vJ846MM+adbm5WISoTKI96CRU/CMXvYZ9fh1qlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376200; c=relaxed/simple;
	bh=VDO+0Tj49KEOBq19KziQB7YiThTUgR5jttu90eNxnUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DL8bH63JSAbrlpJpbG13VeIysJMlwIBt/TEgtXsotHnyNdrLg9NFT0VChJ5yChKzpb/v/DoMKBYDAflL0mJooK1d5kjDksXF22h95fJH83lxDFg83upSPh7Ya6w9YE/XKVY97V8BrJlgKeixsarsxusXQLAK666pd8r5lM7fnNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aPzg9btK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aPzg9btK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f4603237e0so583746b3a.0;
        Wed, 22 May 2024 04:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376198; x=1716980998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0E+X0B3463x+ySzrb8RMJMYXBtgxmBPuTkwp509q9vM=;
        b=aPzg9btKdV4MHCIeP3Sfd+r4FvBtANO/3LH+azQ6OmrP7ym3lJlvYq7FCzeTioJmGi
         8uY1Rt4Vd2/xnuyxLcNEnQEbKJFTiXzCU1kYI+ol52NymvXkpe1w+FljckpB1HW2hsZG
         FtpoMdJunX2zhhvMHqFzGZNyS7HN/bnL5GevkyNpwMk9wp+akQ+h3sGsbRp7ldaVF/Jv
         yW/Poh9WQ0LhGQCkyT6Vnda04/bj/Q7SoplZ6F1GUP1XD0zKvOANKHNgm+XhOQHUZYAZ
         iiE1i+lpHZjjzNf16IKG8eiIRxM5cBg86zmuxVZFTUdCBWL/ZmEGSec51qRi9wV+16+2
         DCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376198; x=1716980998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0E+X0B3463x+ySzrb8RMJMYXBtgxmBPuTkwp509q9vM=;
        b=r/6iNq3sNAwpZA0mWgOGFWK8TxW4LIVQb6/4A0i9pwNYM0QKpFnqqx7G4WwfEoLfMz
         ivPq/56F7dWMiAdR9dc8DghZA7E5S8Va++crt5VDBMqx4reC7dZo6fAcGq93R5U2vbg6
         KxEyIpqj9NzuMJW7Gt2eeSynTaZjxZzPTFNGP6Wdj5o++3PX4zTfpevzc2vsIutcXoAb
         0ebKiKxm+rY7sNm75tYCBWSgo8RdTesVedQVLpPHdV4Nyv652Q+La2BUtUl5FBcU4ucp
         ga3F4MXyAiOjpSCd/AWXQj0gGWsAVkuBNUtYn04ANpHJhFjWRimTZUHKViPBk/ZCXAb3
         mtxg==
X-Forwarded-Encrypted: i=1; AJvYcCW/Ca8d/KdORVekgr2HawOX5mcUd+amjwVFponCUKbJyDRyuGJW5qoe5mRnVCA3YSi2NhB71stt1wcz3XcCOklVbDjgHpvuVAF0xo0C
X-Gm-Message-State: AOJu0YyuthaDWHmCJwBEgrcSFnMLilnR79ijGDcRYKR7u0PbCL79nsm2
	+ldMWkSOGruNzd3yf1m7f6cigHyZb9+2KHLI4NwLhrdcq5VYkRVF
X-Google-Smtp-Source: AGHT+IF4VENsbbnmq7nmBHhDtjsHR7cjFyY44oicXCuJkk8cYm01B+IVY/LMPP+a0shqm/l4GhjRuw==
X-Received: by 2002:a05:6a20:5b23:b0:1af:d08d:da34 with SMTP id adf61e73a8af0-1b1ca2cb315mr14642366637.0.1716376198680;
        Wed, 22 May 2024 04:09:58 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:09:58 -0700 (PDT)
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
Subject: [PATCH V16 11/23] mmc: sdhci-uhs2: dump UHS-II registers
Date: Wed, 22 May 2024 19:08:57 +0800
Message-Id: <20240522110909.10060-12-victorshihgli@gmail.com>
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
index 746f4cf7ab03..8fc3e001db74 100644
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
index 7d68d5666080..13703f1a3710 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -721,6 +721,7 @@ struct sdhci_ops {
 	void	(*request_done)(struct sdhci_host *host,
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
+	void	(*dump_uhs2_regs)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

