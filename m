Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9C782877;
	Wed, 22 May 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716376234; cv=none; b=OH42z+HDEFbFi3dqWgUlB9q7fayGDihHRiEkTVq2nWP4ReZnb0ybZ0s6DqmF0vIjA0/i6osahPPvnSsJ1oxM+jY6DSHpcAQdnAp3HlZhuqfdFG/CRguWb091rx9iwyOozrAUt5skrWr4a4iMuA38bDYsB9ow9T9IWfpxBN5v6ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716376234; c=relaxed/simple;
	bh=PO8Dl/s5nq1xFbKipUHoDWp7sDE+Ke5jgtWFF1rzhBk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YOWTd58NAgyTBQcXhCt1om6ripwUYBGUQ7WakWxS0yLsLhu/jZ5bNua+j0R381Cv+HnTNJGpacN1i3kraLTJDi2daH/ovKBDr1Jg48Tkf759aLAibtYPSGzblZtYn7u3WgZEtPSPj94hg+Wtb0Vh8qn0inMNidsf75Zw2V9uyWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKn5Vrm4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKn5Vrm4"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f4ed9dc7beso582424b3a.1;
        Wed, 22 May 2024 04:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716376232; x=1716981032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCou7XQ+dDCJdxA1LypdyMsFhwoG9AApr0UXzlecsV4=;
        b=bKn5Vrm4ExjuCd5mkmbg8dNucJtEmfDDjElRyWiCJ7bodZ4QN+lAgfmUAPSpeuhU9r
         OTTliRRNFHAXYzb2HuKsGuDsNfw28E5Bz5pMosGa3aHpCL67CkJkBkO8sNogn36gfBfd
         xRrc+cPqIc83uK+6Dh2Yhjpq/jqXi01O0ZdXQzA2c9L2I9qyhDmoFUn29XCHIv8OZABD
         4OULkRrIE01I38fX/seIZKEQf+qlkf/+WJ2SgWr6gcsdThFWtlXHkkT62Y8EmFbGaW7W
         Xc+AKK3mO6FdL2PrdR0wH30FePJDaa5bYnnggOH6SWQ2XHGypFUFwLRAVzIJjOEy6Big
         38hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716376232; x=1716981032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCou7XQ+dDCJdxA1LypdyMsFhwoG9AApr0UXzlecsV4=;
        b=ncOOeLD+xJiPpGU9F4slTzcBtmRfZ08o7Iuzt5uV15QrfipFVG2XCnDqCBeOmkpPLY
         ue/tul4UUxVBi4pzle5ofETS5L64p5HUKDNaH/X0tYxrtY8Ijrvcjt5YUPey3J6FZ7Ig
         PDClI0poy18Gz+dmnOgi9J5i3Xu73pWOZhOVf+3CLf2se3V3U9LeVXQCsyTh7HBOT+2t
         M7SRBEOUkx1cTGW5fQABbH3moz1LVlX/jbRio6XNivrvgd2cHZrVqJ/yXOURUHj/zkI0
         gzVSRslKU3lKgXRDE/3kOLqIKjH5o/FIxo2tcaHMwk8AYssdcxNLALen6btCC99DgE6K
         Kf+A==
X-Forwarded-Encrypted: i=1; AJvYcCXnOhhTlVLS3OLVDqBrS6Oj4QD2hEtYUCttNy8PvprOkpY0NGmIFvSyzizRUnYPh6kIVBT+FOUra8FkEAukuIVDYPDkWExY3Y/RpzN0
X-Gm-Message-State: AOJu0YypWKByZHV3zjhOcVbsVHhld5OvuXJ+Zd56g+B6qCt1vpdmxdCM
	2vSYmxR4H7I+ZD58KPth/U+DT7dRtNho9jP7lzWXvFuxMGoa8W0L
X-Google-Smtp-Source: AGHT+IEu+rw/UmfWZ5G8x32TsVnzJWIpEpeaZfc0tmld6drzh6K9j87bJG7Fsz3zPsC5dA5ChoqLYw==
X-Received: by 2002:a05:6a00:6506:b0:6f4:4b35:d7b5 with SMTP id d2e1a72fcca58-6f69fb7dc7emr15870591b3a.1.1716376232351;
        Wed, 22 May 2024 04:10:32 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e283-0474-753d-295c-237e-167b.emome-ip6.hinet.net. [2001:b400:e283:474:753d:295c:237e:167b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2af2a98sm22223760b3a.169.2024.05.22.04.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 May 2024 04:10:32 -0700 (PDT)
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
	Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V16 20/23] mmc: sdhci-uhs2: add pre-detect_init hook
Date: Wed, 22 May 2024 19:09:06 +0800
Message-Id: <20240522110909.10060-21-victorshihgli@gmail.com>
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

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

This "pre" hook for detect_init(), uhs2_pre_detect_init, will be required
to enable UHS-II support, at least, on GL9755.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci-uhs2.c | 3 +++
 drivers/mmc/host/sdhci.h      | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 30a8f6b7d275..c830ee352504 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -417,6 +417,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("Begin do uhs2 detect init.\n");
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
 		return -EIO;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 03148c7ea614..576b8de2c04e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -725,6 +725,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

