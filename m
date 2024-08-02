Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2576D1DF694;
	Fri,  2 Aug 2024 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594211; cv=none; b=ZdFCqu6Kua7kLUFHWVpioT3d2L04OUBm1m8wqkf8ByuUMmvmPO6wVqGw5+G9hcnm0bdYVTNFzasNiStzYeO5NCU3y7o4yErWoKeLYC37BpWRDhR34gRugXyJg1BItS7EXTR5AgsBrxoIkbM5HKRUo1mGcnYOXeExmLPstJEnsvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594211; c=relaxed/simple;
	bh=SFCAPMYUToX959hW0aIShZQqJGkxYWPyMu4KNnD8Hbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kpLFLI5jiVD4gkthmuWTcZiysVkc7+LbaNBooDPQ290WAFDmqfYRiHS+lXTcGuvIztI3lHuKa57VcvR9gukuvDe205K11mKsKcBJyufsCXJ6ib8I1nhxJmIXYC4md9kb5oprQxL/onsCx6lDPL6heeXNfwXMwmD6RLQlgNEE5kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlwwP5UL; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlwwP5UL"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3db1eb76702so5072813b6e.0;
        Fri, 02 Aug 2024 03:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594209; x=1723199009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaGkQPCGzuVUjaXJrxV+hmji/yjfP4ceyoxn5sAqRnc=;
        b=FlwwP5ULLaAdqnwbvyM+dRYwZP0hReA5ugtPDFRg4vtB7+7a/m83xjNRscUi3xhqK5
         7V164UPHdr4ScsqWxakeYoNAeGVC8RgV9Al3CKqJ2oeJLg4P5mwdpm0Es4LZm3CRrzCH
         +3WRy9WBnPrhzLu7CfYE4VXcA3JbwsllX1TsxzcvtRdBZx4Nv4itkuprZdA+/dY5GPDL
         mFc82MEK+GpXBXW4cM3OHemtj+bDx//hXzbLTF2XAR3UaIgYaG12biCjZAm2TnYPZi9E
         NjMP+NAt22iB9mMZjM4q/IIORxiGrt8tkit3Mn4ZlRlHLt3vVdN221RTQSjDwmyiM/ew
         kcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594209; x=1723199009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaGkQPCGzuVUjaXJrxV+hmji/yjfP4ceyoxn5sAqRnc=;
        b=R8LzlYxBTTJ94lHtBt0PbQM5DoA4tiAwetDCQPAL4i235KY8N+i+mJTNf/NzWxIrX2
         R0WKdVJiI7l8EQipLIEUtHbwGxg/+/WQ+UT820mk9Ni48A3UftY20iyk0pD6x1pcONw3
         V40oMC82B5/4TLvq51chp3Oru8HDbZ1WerGhiWFxGjxGamFpATXZ22WbmNWgiCRJcb5f
         GeWdIkRb4LQzFWuGGDGIISK/HyI51F0QuNnBxFzbQ4IY8fSzvu9/7dH/uL+4etoVKO2U
         MUf5PUq5n38QHri5OfmrVQFx+AYB0fHHDE8eTl4zMGLIjEJar/DYiM+mos2ayx4VJmur
         XsJg==
X-Forwarded-Encrypted: i=1; AJvYcCWczA7bYspFxAnaqDcmudqswI/FndeEWmfYeRf5dTYjqGYVFX+iOStqeyjLrtYByCshhanXwVcpvBqQQ2cTnBy3R3/w34Szh4sZ9GHI
X-Gm-Message-State: AOJu0Yw88eP1jHSzReF7H3DBdCjcC5qdmsWUXOESMg1u2fAIniulTZ7R
	ZgkHPxhXSIfdpmRS1DhBUaVZAzOaGrv8OYNXxnlk2+AWdfZL7q36flTdtKwd
X-Google-Smtp-Source: AGHT+IEg7jN/Pju/TCYQ2j/4PuAbmddy5KFB/jxacxcSmsxAeNf/kGeoCU8rwrzhA2Wo3eLS22LboQ==
X-Received: by 2002:a05:6808:bc6:b0:3da:a48b:d1e6 with SMTP id 5614622812f47-3db5580a11amr4355724b6e.16.1722594209213;
        Fri, 02 Aug 2024 03:23:29 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:a802:89d:114:fb3c:5d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b784c61fdcsm798000a12.51.2024.08.02.03.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:23:28 -0700 (PDT)
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
Subject: [PATCH V18 10/22] mmc: sdhci-uhs2: dump UHS-II registers
Date: Fri,  2 Aug 2024 18:22:17 +0800
Message-Id: <20240802102229.10204-11-victorshihgli@gmail.com>
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

