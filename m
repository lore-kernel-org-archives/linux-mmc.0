Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B341DE85F;
	Fri,  2 Aug 2024 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722594190; cv=none; b=bS23f2M/dpf6y66BkfKfPg7CTIIZ9XZQWvmVkK0ER7ONFBDiCqULvgjJq3+tIZQCaChbxX+U0rhodhK0M26K9fz5aVx87p2IeVsVcL2JF8DPfakw+mIygCJpJ8I6dd9GMqE0CAh1NVViKQBysxup417RCM0eusNwleLErMcSGsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722594190; c=relaxed/simple;
	bh=urHhvNgFjlJC0RUvDI1zmMHs1AZTnco7V3JoqsJKmGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ShxAw5k1WUMHPIH6A43+c8G28+KqKCd++d1fbsILTMiKLlBFJgpDzcxMf2EcdUCdDtoLJUndl3tWivZakKWk9YnsEpu2WctVt/kGqVg+QU8Lum1Mn1jXwnOLR8/AfcSZbhSl7m+FBqBwc8ZJdbyc06KTdpoi7f5l3wZUQf+LPcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imrZyB9/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imrZyB9/"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d150e8153so2115348b3a.0;
        Fri, 02 Aug 2024 03:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722594188; x=1723198988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elnfGKAy/7+HbOAzxPXIpLPWv33SV0UOKZl7RY/LQJw=;
        b=imrZyB9/grmZFmGugEY8Xq9BZ7NNlt4uNr6xLFtt7zZY8YcxY2C928HkKvif6K+VMu
         Q2BIBhPYUl5ZZSfVBj28VqivH1yF9DRMlg5jf/PbDFU3oFDKY5I1x+wVkbAxkExJBqzg
         MeoSKwvA5gR+RKCD4uk5PhWiw8h4iI3hvThBVmVMNh3lrppGglZHcKwH3hff3P2gc3Xh
         Ky0dY5V2R3vFJ2Qi7MZMwbfk2Zx36qtAyhS5CQFCuia25DG1zyV/gbtmcgyWFVTq42wu
         7ygMAo6l3HszKl00PUV6YCyfslmcvO0WJHw3FeN/sk3EZEHSkxobXLXBbJaqYfaK56ys
         KdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722594188; x=1723198988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elnfGKAy/7+HbOAzxPXIpLPWv33SV0UOKZl7RY/LQJw=;
        b=H22nTI8lPo06IaylL4jzPU9yyXShlo2GRTSEG/hKZoY1XT/6mTpROfLmyaUHZ6XdoZ
         b9GMCAyOV9xVNKNEYKsUHNApQvHs72nrNHTsIc/mJqMbPaIR9kDYGhbsczxk1nkrcu8X
         Fa1kchhk5u7XRpY9uN7Jc6BiM+hHdXLK5UziVyMv5tqhvqvV8cJn1V9njl4/eZMwi4RD
         hC+bYHGUpoGyNPiDIkZGw9HNr17KR+bcDNRX/fmsBkvVQjh/tVcQH/eVJiOOn3FWOPHm
         HELDp5iiQHHznBL8bSm6+wWultTtmn71Zk0yTN36+ngcYZ6XFNdMTTyWTVdmwfIE3y08
         KAhA==
X-Forwarded-Encrypted: i=1; AJvYcCUKVg3GKTmOT7a+PYZtZhj8k5YfPC/4bUyBWl+63kfi0eR9kacxeEawGLaMolfNNLrSpe3eypI4IUILTOzMhqpj4DvIJqtqUSuCCX8z
X-Gm-Message-State: AOJu0YwBFbFTwZF2dsa4I8uIGnJJPR4c5ZcnQWpN92h/caFy6T2S9P9y
	ssJoCP1WaM/+sUixJ6Vg/M8ipcsrcBMLBcIF/c5sZBXcE6E0IZpX
X-Google-Smtp-Source: AGHT+IF2nNiCjQ55aGcJvkZHH9xMprVBlksndSY9rLNhQekjZ0Rn000Rc8jKSQreV06JGlwY6pMAMg==
X-Received: by 2002:a05:6a00:1893:b0:704:151d:dcce with SMTP id d2e1a72fcca58-7106d9f4b8bmr4100168b3a.5.1722594188401;
        Fri, 02 Aug 2024 03:23:08 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:a802:89d:114:fb3c:5d5d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b784c61fdcsm798000a12.51.2024.08.02.03.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 03:23:08 -0700 (PDT)
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
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V18 06/22] mmc: core: Add New function to re-factoring the code
Date: Fri,  2 Aug 2024 18:22:13 +0800
Message-Id: <20240802102229.10204-7-victorshihgli@gmail.com>
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

Add __mmc_go_idle function to re-factoring mmc_go_idle function.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---
 drivers/mmc/core/mmc_ops.c | 24 ++++++++++++++++--------
 drivers/mmc/core/mmc_ops.h |  1 +
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 3b3adbddf664..5c8e62e8f331 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -144,10 +144,24 @@ int mmc_set_dsr(struct mmc_host *host)
 	return mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 }
 
+int __mmc_go_idle(struct mmc_host *host)
+{
+	struct mmc_command cmd = {};
+	int err;
+
+	cmd.opcode = MMC_GO_IDLE_STATE;
+	cmd.arg = 0;
+	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
+
+	err = mmc_wait_for_cmd(host, &cmd, 0);
+	mmc_delay(1);
+
+	return err;
+}
+
 int mmc_go_idle(struct mmc_host *host)
 {
 	int err;
-	struct mmc_command cmd = {};
 
 	/*
 	 * Non-SPI hosts need to prevent chipselect going active during
@@ -163,13 +177,7 @@ int mmc_go_idle(struct mmc_host *host)
 		mmc_delay(1);
 	}
 
-	cmd.opcode = MMC_GO_IDLE_STATE;
-	cmd.arg = 0;
-	cmd.flags = MMC_RSP_SPI_R1 | MMC_RSP_NONE | MMC_CMD_BC;
-
-	err = mmc_wait_for_cmd(host, &cmd, 0);
-
-	mmc_delay(1);
+	err = __mmc_go_idle(host);
 
 	if (!mmc_host_is_spi(host)) {
 		mmc_set_chip_select(host, MMC_CS_DONTCARE);
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 92d4194c7893..3eaefe989c80 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -25,6 +25,7 @@ struct mmc_command;
 int mmc_select_card(struct mmc_card *card);
 int mmc_deselect_cards(struct mmc_host *host);
 int mmc_set_dsr(struct mmc_host *host);
+int __mmc_go_idle(struct mmc_host *host);
 int mmc_go_idle(struct mmc_host *host);
 int mmc_send_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr);
 int mmc_set_relative_addr(struct mmc_card *card);
-- 
2.25.1

