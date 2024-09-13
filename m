Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8131DC1BF;
	Fri, 13 Sep 2024 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223408; cv=none; b=OoWS4U6zE3fH46EXtm9hiB7fHBYEsN/dGdDKTr7pZ0HZzHsdlTmNdTeKIo0QpJzHuJAc16rHqY8r71rtCRhE7qrq3nTMDYct1BH5jEy0Mhw95DjKVYVRcHP4oAo7DiONLt/TSFqpD3Wz1xUfkHwBnQrS6pRChWLyJgNF5vs3/nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223408; c=relaxed/simple;
	bh=v4MM9bGqXsTwGu4en4i1RloVtI86bYOecflv6HHdnis=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UvNuuUiEI/93OYX+CtNq9CXv/sMw9hbLvgodgA+kwKVNnrYo2ubqFF+xtBPo2gpm1LDvHqqP4FqSEgc7Bb8axAzBS6GHQ2kVXbtFnKGWzQCiW9b2OX4X0qMvGOaSeASVBHqltqpIQRs2S7GbFFLdUn82cWNUIqYJYM8803luY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VS42Pn/6; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VS42Pn/6"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7191fb54147so1406904b3a.2;
        Fri, 13 Sep 2024 03:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726223407; x=1726828207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pefaTk8qKKbtSAgriHJ425KtY2+eFqYfJpkB9h3wzgM=;
        b=VS42Pn/67n1rTORQ9qB/vaBisDJm1V7QvUwj3G/opMulz4BzxudX2QGQK3Ymc2W38X
         DqAcDon1UOowclQauZYNKG/dIGyIq+a+7nF5aKeAAa+XDkXdPBEajrjVaHS7Nxg/4w1s
         dM5bn3YTYWYjaleLzgh6DF6yA6WawMsz1qLx0BgychgD+3XZ0Xj7H7FReegVUEdVnVPQ
         0qUnohEivOpy3btazeS8hpM+ofPjxC4pgGV5GK9oJRbiNiObT0Lijns3k717t9a5aB1T
         Ankn0/+R6lYbNzGNjJDCB3Ha783S9LR2W78bzvas/zxD3fL3/TCusTB2Y/M0Q3JHD9fo
         Chpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726223407; x=1726828207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pefaTk8qKKbtSAgriHJ425KtY2+eFqYfJpkB9h3wzgM=;
        b=Pg+a48pH3A8sEhIWuhgfxf0bJiz1nGv5cxuAfWHcv84ZBN0oXR6ZqRdwJjGl/a9WfI
         Ds1C6F0UNw31Eqx6OCRvA4QJl16JXjazRmmR3oCJzgMfwy7NtSnD3g6TIF7PyQySM1m6
         aye3gHTPYRvsFNkeKHJJyQI85bzu2m6n3/m4EfYUm7SWn23wjtaChQ4jQ11WbU+8iu83
         dimZLIIjVCpOhlQLWskLECCLmdGKCi3bhYvLb67W8UPXmzSs2NQGLEW65wco4C35uU6I
         EeUF0anMHNUuAEWQYlgb5Aj4UtvAB+sWmJYJ/9nXG2Mzmc2+J4rtmPOq5G7uT3KNG1Mz
         9Qeg==
X-Forwarded-Encrypted: i=1; AJvYcCWzMzryOEPs7PzR+w3Bvi75I5yJK4B185MpQLtDT5wbDjkstVi5rKL4i3bZVKXKffbY0NiSoUMjxc/r20k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr0sViV5xlPU5RgzgQlMc5v4CInb5a4Cv0JSTKRwxR6B7o+cr5
	fcd0ibUe49R7ecBtc/zaaivIO2XLA72/cD8dn/3PuSn9vpvKlD4S
X-Google-Smtp-Source: AGHT+IE7g4H2FNwLVup/XTs5DIU5atEGKDPhco31O1iqlVJvBjg34dMyEzdSr0lL/jcwQVg8jV2xCw==
X-Received: by 2002:a05:6a00:4b55:b0:718:d7ac:6342 with SMTP id d2e1a72fcca58-7192609100amr9545361b3a.13.1726223406700;
        Fri, 13 Sep 2024 03:30:06 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:568:acb8:4bcf:ada3:4620:3cfb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fad0ac6sm3137683a12.0.2024.09.13.03.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 03:30:06 -0700 (PDT)
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
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH V22 19/22] mmc: sdhci-uhs2: add pre-detect_init hook
Date: Fri, 13 Sep 2024 18:28:33 +0800
Message-Id: <20240913102836.6144-20-victorshihgli@gmail.com>
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
index d99ea05098cb..c488c6d56015 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -413,6 +413,9 @@ static int sdhci_uhs2_do_detect_init(struct mmc_host *mmc)
 
 	DBG("Begin do uhs2 detect init.\n");
 
+	if (host->ops && host->ops->uhs2_pre_detect_init)
+		host->ops->uhs2_pre_detect_init(host);
+
 	if (sdhci_uhs2_interface_detect(host)) {
 		pr_warn("%s: cannot detect UHS2 interface.\n", mmc_hostname(host->mmc));
 		return -EIO;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c636808139d5..cd0e35a80542 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -723,6 +723,7 @@ struct sdhci_ops {
 				struct mmc_request *mrq);
 	void    (*dump_vendor_regs)(struct sdhci_host *host);
 	void	(*dump_uhs2_regs)(struct sdhci_host *host);
+	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
 };
 
 #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
-- 
2.25.1

