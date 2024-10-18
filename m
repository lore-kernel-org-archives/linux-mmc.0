Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3B220408C;
	Fri, 18 Oct 2024 10:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248842; cv=none; b=shNe2J8VF6oVqF5+0RIW5Vzki/z4w5SiBbU2sPPMMa2iVSrgcsbLGz7twe1+n6B7SAEyQi4138fS3oqOY+MbEmJD+y4iKFwWdQz4zAmvahxhLRQRnohOwHq4U2yZXZZ8W8dSUxtjmOVtf6pvz5N70ojB43cQoPZJWQ1LbAVF2ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248842; c=relaxed/simple;
	bh=xwFiWQ5tOpWStPyh3+9Y+jsJxfVLG9TjYX8BQUYRy6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JkHJV3G32SA1VCZLSgpeLEwHYm9tzaxViwkiUW0F9bezwkBByjKltOrBKUFbDB5E+BBGfIW0VpMeMSh4lrUcFQG9uNPfoPkX8ropbwSeQvDCK68Lf958tmRt0jGam48FCeTJ3sMsV+CQNOGnoQzaI/eXsf/pfw8DVpUt4hbyoZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzg9F5Wz; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzg9F5Wz"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20c8b557f91so20992165ad.2;
        Fri, 18 Oct 2024 03:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248840; x=1729853640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tY1jYPZ8EM+61uC7VsYBzo9x1mBBtiuwXTRSGcxof4I=;
        b=bzg9F5WzFvqqyVNal4J1v0yRdBvszvkC31+mv0J2fiNEa2csxoezqe0js7WU/FQrfc
         T0/e43/4BgBPW8psRjd+XCFU0VwLBccN9o5zr9kEGbR+MATX+rrPVH6kn89cdhQU+HQs
         dhSW+xb08XM9ii61DEKUfjyTNps75gZ4qMA9M6vRHkBwd7UOiat+BDJ6t477WzkR4+z8
         pejuWA3K/JIKtbdajL+WdXTfq3uFymqU+4IUstQbND35exwdW1d+IRoT2cAIfG7N0Xs4
         lhFO3H83GGKlFr9iwSaf/WGBtmF6sUg559Xh11+Lg24hmJjtyOZwLu/TRpMjCzyUIrkN
         Fa2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248840; x=1729853640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tY1jYPZ8EM+61uC7VsYBzo9x1mBBtiuwXTRSGcxof4I=;
        b=MIsRTZGdQoeq3VOIP6SYEFbo1Dqw977W0Zctu918wdTgCWsX15mE+PAUkkPzFS2ZTb
         BkquIzmoU6ta0vdI5F7N95mP0Y/453B9I9AxCLgxpR2Yrc+OJlSt5J77aEHhOi2TzygM
         +Gpv3CM4w8bi5t4quM2p/X26QuOF0MQl2lVQBjuE4jKrSs3GeoCdh9PlnBG8VUORCNJG
         gVXEe+yhooi5ipf9Y4tGxMCiTpMbfJ+gO19rRo+cAzNwKqEIAzQ3y6pZl80fekyw4/Zv
         93wmpaJKoBpBnoNQfqCD0+TXykZdUY4gOjM4+xs0NzK8LL5PKa1nDzq0wLZnr72nIMtV
         8iAA==
X-Forwarded-Encrypted: i=1; AJvYcCXVLH4yA2ZATc0VGzAudb+TOGxSVK4szi5clcAxf0kvXm1df1OkQC4UATZuMKMya0T1WTgaSMHi1cpEP6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAYQjvB0MXmEZBDx2YMLf4NLStv9JtKvbeAKUkGfjky/ikR/tM
	Rr79eSW7ifPy6fvvCWIBz1jiXgBa6QqfEBzoE+dPBJntTUuD+aLk
X-Google-Smtp-Source: AGHT+IFiQzqWTXZBnEku2Up+j+doO27pnfDz8PRF8/S6R9GPczV1BhE0SnbLm8tvz1g6NVFdh1k+PA==
X-Received: by 2002:a17:902:ec8e:b0:206:aac4:b844 with SMTP id d9443c01a7336-20e5a709796mr27794305ad.6.1729248840498;
        Fri, 18 Oct 2024 03:54:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47a:11ee:3789:3bcf:d64f:bc9a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8fa20esm10237455ad.234.2024.10.18.03.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:54:00 -0700 (PDT)
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
Subject: [PATCH V23 04/16] mmc: sdhci-uhs2: dump UHS-II registers
Date: Fri, 18 Oct 2024 18:53:21 +0800
Message-Id: <20241018105333.4569-5-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018105333.4569-1-victorshihgli@gmail.com>
References: <20241018105333.4569-1-victorshihgli@gmail.com>
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

