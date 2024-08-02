Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3811DE867;
	Fri,  2 Aug 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594257; cv=none; b=aZY1bO3dhWBwMfxX6Tio+gT0XHy0DxFGyXGPdK6qG1J7yYc42Oa44HRWtQCrtVunUgjkbAO5bwd4TsN7f+di2trMTWT4HxqurwK0AB3azhi6Sf6zzaQbJdhCP2syjsVWjzZ/jef7wBI5PoT/BptA5dUt4KHAmvARWPkjGRcxUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594257; c=relaxed/simple;
	bh=bJ/yt2HdgO4f+p7Z9KCU9XaD+lVgkROWGcsIqCfkPBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=afzrFRExe+fWSbVOSYF4wPWXwW1aZKMsuJNKs1iMk7mlZE8sTjc0ILaM7AjYabthVtysZg1IUTUCznKNV19GP+k4C7wSfhoZ16o0z/AgFGW5UT+EHij7uUyB2U4LLKkYdjRAj/9xZbRihR85eWnxbfi/np1qLwq5CaTvAJcI/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnfpZjQN; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnfpZjQN"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7093efbade6so5445500a34.2;
        Fri, 02 Aug 2024 03:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594255; x=1723199055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy8KncKhSK0AEsmwwclzsO03/D/kqB6O0hwv3v+6ttQ=;
        b=AnfpZjQNUeonHtr1HK1iztZHLzrg7ycEfGsEfoYuMjjVZlW+ATd2oxWVUasPcZdEYf
         7E6f30eqKuX8IeGGKvS/DLvmvn3ailpSYBYfTsCtuW/3FgHrb9l/kgNusiPLKeajjfy8
         oUhBwSbv9qVGYNoq3LZ3Y6xXVP7NQA17a/LSZltzJp5f1wyM11jla4sysIr0WGotzGY4
         x3KijI/rI+8mHwxEJVZvCdwkxmLMXvH+XxqVaNyyYlqtDI5kzg8T6jT6hH3ZGpP7VeS4
         uhFwyLXQTnd5c433TGeq+FWDVqqKUg9Eij9x2tRClE1YShv13He/al710+gITmbXHkLb
         /SZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594255; x=1723199055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sy8KncKhSK0AEsmwwclzsO03/D/kqB6O0hwv3v+6ttQ=;
        b=cesf7pE9W/PWUD1ufUd1FjqqoKBmB5HgjGfwaWFkAur3Hywd67VrcMH541t7Y2hSM2
         4zTlBMy69H2FhSmETHA5lDOihBN+Saw9udu6Ly+s5qprFSvRF98EDJilBmHx7s4IJ4Q5
         L+lErwLV7W8U91qcdSXyh1df9sl1ih6CAFslKFcW5KBV/OXafJmmofWu0M10jXRjRNOU
         7ZJ5kt3/NXexp+XqNYjt5bIPzkNIAqZgkU5Nx0He+9rQ4edeZOs+7SgbnowpKjHtsOnv
         bXSflD05f4525DS0sZsTFa2aOIxHHAYZZKjEHmHpmS9x/r1vQ10n600Fio3BUP/6PhIy
         dZGA==
X-Forwarded-Encrypted: i=1; AJvYcCXsUF4ty0YiYkA7P8QInqwLIg8G2UqkeO2fJExFZR1iBoFaaGUp3Ad2kbK5Xh77lgCTP9xxz1hYYUcWJau2V6zj/vJVKxjU+qCUY4zj
X-Gm-Message-State: AOJu0Yz5+b5o5WA0OKYzRl7EqgjP/YReHhqu99SVY9fUNIbB1dDRTtbr
	jJeZvuWeIFPJEB7jL3ihpEWFIbEF/o+726zVnJgkAUD8Hn6KgN/g
X-Google-Smtp-Source: AGHT+IHNI1s1Q5PhF9DROlO4lp35FZWaRYAB/WhsmH89zLR6rwNkEVxI8vQEhbhsXSEnKzAeIEOUpQ==
X-Received: by 2002:a05:6830:6f04:b0:709:472d:f35a with SMTP id 46e09a7af769-709b31fef99mr4204996a34.2.1722594255493;
        Fri, 02 Aug 2024 03:24:15 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:a802:89d:114:fb3c:5d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b784c61fdcsm798000a12.51.2024.08.02.03.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:24:15 -0700 (PDT)
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
	Ben Chuang <ben.chuang@genesyslogic.com.tw>
Subject: [PATCH V18 19/22] mmc: sdhci-uhs2: add pre-detect_init hook
Date: Fri,  2 Aug 2024 18:22:26 +0800
Message-Id: <20240802102229.10204-20-victorshihgli@gmail.com>
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
index 864e3c08d83f..ea149ef5a684 100644
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
index c5e987dce927..588dd76320bb 100644
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

