Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7A18EFCB;
	Thu, 29 Aug 2024 10:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926594; cv=none; b=P1AZ05o4EyjtKuoVbUPmNlxMYqgUKLBWA+YjVN7vxd4T3pJnnxJu3Y8q8ZTimhO/bhiE5qvfXV7o1ugVintThc82jvK9W0Al919sDQEeMXoj0r4BR9eoRlYgjgqZmJOQYgA7UIZh1swZ9dbNuQKUAfRPaAvg5RCvlNs7DD0uScM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926594; c=relaxed/simple;
	bh=SFCAPMYUToX959hW0aIShZQqJGkxYWPyMu4KNnD8Hbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mwjodlt1gh+Trwgz3gdK5WP0Ed6ruYJDCwGWVRMIkmK/87tDYTfTrmlr0YhVsIbSV5t6ejj6ciHAN3D6FuaFZc9i9T8/5j+zF6Qow5BkNA0otqWeTcPTreDHfqc+HOAV18DAFKH+soG+Qai30yfVrxAy7SHlQ9dFH7Pk7aNgyXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2e0SFds; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2e0SFds"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7141285db14so436217b3a.1;
        Thu, 29 Aug 2024 03:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724926590; x=1725531390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaGkQPCGzuVUjaXJrxV+hmji/yjfP4ceyoxn5sAqRnc=;
        b=c2e0SFdsE51Mc97AI2o6zFe+f+wb6l97BFT+yS/ZIFNKmplalxBGhColAkDDsgPKyi
         CWLAJfMC95qPb4VaZbynfrfAftG9t5zNGIMh62HaLsISpPYyFMaWxw5GGYCxTpYK/nf9
         huke1YtkFTjaPVS79Nd+w0RZ5O2hpPBlrFD5DjV/JtVVaZVDxDPoYegVn+buQMwwps1C
         jIV0E0ehpAmx2epKvPuyvgKGUm2wh3vOac0HNd6lie7+PkKrzw5rptHfTzZgibsvcixZ
         y2tAT4oVpzFkj1/G1psjN4kGrO2pHoYZ0tNKWCX3QNXTjJ1mRDhotgrd8q+tPHvYeZjx
         8E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926590; x=1725531390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaGkQPCGzuVUjaXJrxV+hmji/yjfP4ceyoxn5sAqRnc=;
        b=nDusgkN0jrcYyyyXz1fbT7y59f8vCP9FjKuXrBAwiDLj5qICUcHYribLjvjBAE+KCv
         W41yL47Y5+lBbteLKVOwLFjDihuCK+YrgcOtl++vezA85Izr1FFVJtgddinpJ7pvMILA
         RsIkNW6P0lZPZbCm0HPsgYbqL4NeFussyfrL37FAfP2wn3uBZrx+Laabmwao9cr35I7q
         elVgcgmzhV1WlAJCzKCqsHNWdO9KjtveJyxBrCuG31IdIAhxWRd3xhk/DouIuHrGd0cL
         0au5Mvf52m50Luttey1hgRYnzyMMznZAOoq1Xw+qXcag4vc4lXdsw1qda4FAzXnt63RU
         85yQ==
X-Forwarded-Encrypted: i=1; AJvYcCWiGuM5TI+DfO1BmgwJ85aZh30EBih+IzCsA/z89yVbHmYAJ/dPM9pMNXvhbCaVQ74sfDatWIVjVFZX1r0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBh5kK9txD0FvqmZnHs9S6fwd7L+eEAbPUkJkcrtM3CKxemO+F
	XG7C509SuHXgztUEyFGi3l8FizdCp4Gv8BmpgAUYTTlOb9h+CjMh8MNLfowk
X-Google-Smtp-Source: AGHT+IFsyhq8lKBvQwDyTg0JcYRK9q70GEKmCS2V7Wecu3+FM1ZOAdIHfpwwzKWVSYBpOjMtmsZHYg==
X-Received: by 2002:a05:6a00:a1f:b0:707:ffa4:de3f with SMTP id d2e1a72fcca58-715dfbc1965mr2939430b3a.17.1724926589909;
        Thu, 29 Aug 2024 03:16:29 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:a52:632f:b914:4ddf:273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d77eesm816577b3a.153.2024.08.29.03.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:16:29 -0700 (PDT)
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
Subject: [PATCH V19 10/22] mmc: sdhci-uhs2: dump UHS-II registers
Date: Thu, 29 Aug 2024 18:15:27 +0800
Message-Id: <20240829101539.5058-11-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240829101539.5058-1-victorshihgli@gmail.com>
References: <20240829101539.5058-1-victorshihgli@gmail.com>
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

