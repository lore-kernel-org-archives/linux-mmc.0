Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245081ABCDA;
	Thu, 20 Jun 2024 10:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880334; cv=none; b=A3/RlHjZ6AQxLlgXQHfQBRiRtZGG4WYvP3RzA4yi2rH6wst+mMcawICAJumsZyRA0YHiKooj9DBF765d09NdTiifHxc6loRwlTeV/eCUfR45IO1jI+UZyk3V/P5DJlRv60kNkMgtwcwwgJp81SudXYPjD/xR1kblByGDT66GG+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880334; c=relaxed/simple;
	bh=VDO+0Tj49KEOBq19KziQB7YiThTUgR5jttu90eNxnUQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q3LaaaGlnXD5Z+QqV0dPhgpsNLUb3OfuJw0inqppEDt81KwxFYrIwRLJcfw6QXvsRDLd3nd3dYhiyvt54jiEeqUQOq9TkCjWn02IGCWY24G8Qe+ZapVUPLjnJ04CXMZqxKjhhzoZG8EO+QXYnPFl/iXGdrbdXp4hb5bUkbEagAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekWG10hh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekWG10hh"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1f480624d10so6009835ad.1;
        Thu, 20 Jun 2024 03:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718880332; x=1719485132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0E+X0B3463x+ySzrb8RMJMYXBtgxmBPuTkwp509q9vM=;
        b=ekWG10hhKqlZZ2M/dwFiqMRoAA4nX4ZE6RffIx0KFCalk7jYXGkzY28fgCoYapNdgq
         e39CvxN2jR1uG3W2vi2Scss5ap8ATttqgPj+/D0gIrfgkRNAainHwZx51rjcH5Jth2DZ
         LrGmgrpDOzXEcdGfzwh12DZMg1lqO3zzXPm9Ds0hb9VSl+UPRbsg0oRqxEtGSyZQ1OgW
         KprKY2cOfCwhiwJ8yp1w+8Iazp5tu0vhnCry8qUo4G6x0fz1fQKou/aLQzRBsQHKlAdU
         g6HffAqLhKivwERdM9vx92EgVvmFUs5KJCgDVHKZEzPZmYn9+28F+pSEtYN+ME0ezfWL
         yx/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880332; x=1719485132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0E+X0B3463x+ySzrb8RMJMYXBtgxmBPuTkwp509q9vM=;
        b=C2CCK7M0JoJ8+JefrmPZYhhYQ85giY52fCWMIdX2Bp2XSY56A47U6FtX4jNsCNsf3T
         K73JLge42aRk4BozxAIqcPAP8I68kW+9jh2CT5p9KgTwqzHmukzStpkJhxC5C+oghpuT
         MfBY89+DVk+8VxDn5G8wzhlBQEEz+t6jws6NuOywDcvj38Yj3/dm+whgfxLnYJ8xv3mA
         C3YXT7u8PewSLwmx9FCcB6DoiZYXobj7CXxFmngtaNBqYbcrd9t95B6FZG/gx/QYtbu3
         ZLG292Y4/kovAzpB24z1U+R0bO+a99hk5ZD66QLZS/gosCDU9sc9Shd73jPoYSzilj4j
         uQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqyAami6l46gozHpkmXdVsVFR3hvI+3QY7G7r8vyFbHRRPPYKtNjXCQ1eZG8By89v51z0jIA1zXeP5h1JuCqWo+LyH9Vdiv2jiFtx7
X-Gm-Message-State: AOJu0YwQf3PG7+IWWjXCykPXjLG2iYKayW3e1GvDSziPOIs2GFeAhe95
	xwDpEulgFchP08IuDbv7ZfaX3T4Ex1ug/WrIgT08ipADtDfZuUqF
X-Google-Smtp-Source: AGHT+IFzBW1SE00gNRb85qLkGS1+1oYoZ82gzFjuQa+DWZ3OiF2KQGwt2cKOuH+gEI/14k8RaPWlCw==
X-Received: by 2002:a17:902:e54c:b0:1f6:93a0:9a45 with SMTP id d9443c01a7336-1f9aa3ebf85mr60992855ad.36.1718880332351;
        Thu, 20 Jun 2024 03:45:32 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28a-abbc-b19b-27f2-8368-202e.emome-ip6.hinet.net. [2001:b400:e28a:abbc:b19b:27f2:8368:202e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55ca1sm134007805ad.49.2024.06.20.03.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:45:31 -0700 (PDT)
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
Subject: [PATCH V17 10/22] mmc: sdhci-uhs2: dump UHS-II registers
Date: Thu, 20 Jun 2024 18:44:32 +0800
Message-Id: <20240620104444.5862-11-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620104444.5862-1-victorshihgli@gmail.com>
References: <20240620104444.5862-1-victorshihgli@gmail.com>
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

