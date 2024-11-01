Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD42156861;
	Fri,  1 Nov 2024 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730457865; cv=none; b=qWquqZeN4OFtL/3UgG7zwQQgUlIyD/BMQb+dYFVbi+GG8TmwwizYYeODkqMbEY9GBb5WM/5s5P+yLK2Os1B+jiA0Omkw6KU9yXuc79fsv9J+LKJs/N9IIqajlABrIzil6OYAlWPxmW7eLXBW+iUMn4SS1VvEA2WOccCU3zcXuoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730457865; c=relaxed/simple;
	bh=k3VBLYjykGEL1QAuj8e008pfYcRG1pbsfWvxooa4tMM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a86wzA5ArQ6H+YGakkE05KA8bnTxWqtpyBV0btwpw8AFfMfJhHcCZjvm0M06R+ZTDWM67vDKRPKNK8yoxw+NtTTcEVezKDwQqKIAfg4CM1jy5JY42D+VskOVODqxDxU/b7zV9uZ3ZBor4zVoUdTezU8dsfkJoyjA63r30oZypw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9zfytXP; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9zfytXP"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-72061bfec2dso1526130b3a.2;
        Fri, 01 Nov 2024 03:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730457863; x=1731062663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rIl842v6UWpan22M/EznSjJv0k6saMu+uOkGIu+5Q7Y=;
        b=S9zfytXPYfrQITEHn8dCIRT+xQvGvML5AMTAhpSMlQBjz0Fn2Urt+ASO76GvofBSuU
         Bu3nPikwMUus/KHkT+8w/1073p/q3Xf0GLoC/Lm1QmBb63M5NtpBZ7Hje/hwaMPLS5C5
         9VrqFEpA/bZuqlZUXWtABT97cDZvfEBgBhrXEG5uL1Nxd2E6B4PZH/A/pE4WXMpokElq
         PuOr9ZrJ3k4F59akV/DZ7WUsvjzVpOT/hf6vTsvb0cBUBtD/BHJodcD1qAUwResvAkGI
         tvlZEs9q2WAYnRuPEgxjoP7VMir30C/BSEekA5IQeuOB/wXsWtLa+Jlg2HvkNqJPDPLR
         0Gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730457863; x=1731062663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rIl842v6UWpan22M/EznSjJv0k6saMu+uOkGIu+5Q7Y=;
        b=oy6IYImYZ7ZY8UToLzqNXTnVCCEspe2fWLk+ry/WpJwJsMkPFrzGoS9Qf87aVWGcku
         cFHWxt6Roqj5Savqx5Q7QPAdoNgoSXHJuRjASdv0JsHrdvH1gGfE0M7jynYWsrx/XW+2
         6Uv5QAlJMEy9FtMuzGvYJVw2e9IHdQfnJsKB9q8JKFE5jv6M/9dDxRBYURcy/41QuKuy
         Rqcqr89ZxnRwQQZVtcx8UnpsHU4aTaivKKYNxQ2+IYj3BH2uu5p9h/N0PoplsZG9UpEC
         cLx5VVCpVBC9hy6dxxwXDPHwMqFOsMJ7OY16O9WnPpfSwsQQnHQ2aEJPf3YMZPNvCvqV
         Qc5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWL+xYf8GY3w42wqC5E9ZR0Ms0fuQJgo1bVLLNv0F75Sa/DEioI/2ws6RHVA0EhLyfJyfm+f+a58lxHrKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzcL+lrfPJ4oCUmKDZq16oBHsfcrm/MiVMisdW63YqnavKa8wq
	xjrUQlcLBNKvEarFttZTgtFJi3EdyGbv8lbPJ1w6ivXaQNBLp8NY
X-Google-Smtp-Source: AGHT+IH2csO5NqHBnjDkpEchE4Cl0b2GMuxwZzcsRiZRrTQND6UE7okOCpQdRzGcYgaeZlochJeqDg==
X-Received: by 2002:a05:6a21:7101:b0:1d9:1fac:7256 with SMTP id adf61e73a8af0-1dba5364c3amr3552674637.30.1730457862697;
        Fri, 01 Nov 2024 03:44:22 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:469:ce01:3140:909e:43aa:4faf])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2ebf38sm2494681b3a.171.2024.11.01.03.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 03:44:22 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	Victor Shih <victorshihgli@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V1] mmc: sdhci-uhs2: correction a warning caused by incorrect type in argument
Date: Fri,  1 Nov 2024 18:44:15 +0800
Message-Id: <20241101104416.4954-1-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

There is a type issue in the argument in the uhs2_dev_cmd()
that will generate a warning when building the kernel.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202410260525.ZUuPhMJz-lkp@intel.com/
Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/host/sdhci-uhs2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 7f41ca67b069..33a16cf2e656 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -70,7 +70,7 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
 
 static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
 {
-	return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
+	return be16_to_cpu((__force __be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
 }
 
 static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
-- 
2.25.1

