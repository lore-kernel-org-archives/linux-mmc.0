Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D35218FC8C;
	Thu, 29 Aug 2024 10:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926573; cv=none; b=mdGFxOzZX5D7XGew3bYKsVUuGasbLRrg5ET0Wb9cN/Yc9knT9dXmVhXutqZiUPcIfZLC9g7uwxmjxOR3t1e1QQay32V8OS4OKE5xeGBAFrgPBErlw0eMeITttBeIF3HoNhh81IvFkNbyPC4rJu+Mp+fYjm00MFofK/EbKEiPJfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926573; c=relaxed/simple;
	bh=urHhvNgFjlJC0RUvDI1zmMHs1AZTnco7V3JoqsJKmGU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VseR8zUqdm8WPPX/WgmRPeIzySvn79i07DCjyoYJ6YvHoSHZYHfVpM4CZdpYcXaF6WgwyNVSFMrdVYPvTEJ57SSiHEhQr4pE//TsRh71jPqggTbKrpgHqkEzrLbLT4yPNUSGuNrre5sRXsuTUEf4NwcpM8v8DH5eG07l0SkimMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KQLDePi2; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQLDePi2"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71433096e89so381441b3a.3;
        Thu, 29 Aug 2024 03:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724926571; x=1725531371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elnfGKAy/7+HbOAzxPXIpLPWv33SV0UOKZl7RY/LQJw=;
        b=KQLDePi2eGn5z6G5OZHlEMz46CDPoStuHd4vwnCD/TGaNuWn/WLTeh5LLS0EsOAs8h
         cCosvzSaxFUv7amF8cjwh8Xoa9RLFGYI0zpLgsBrn3gGbfOH7Jn3+Fy5hLV+9/TRNg3d
         GNpcujV2I2iyj/Dq2GQaCGf5DkVOA3TfJI/THiUJ900PuxFj65Px2qUmIJhtzjudKoyG
         ZhL0y6UuYdkoc3F7mO8vx6nsWmnnY4mpTyShJh+0/YcCBGdNCvt+sO6ogOBDPr8nXQff
         Ww69DBufBykweF4caV2FMYkCGkxAUXoqg89fHa7KgH8PsI13fj51YLaoic0AfgcAmVnq
         QZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926571; x=1725531371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elnfGKAy/7+HbOAzxPXIpLPWv33SV0UOKZl7RY/LQJw=;
        b=VQlvg1Q7cXi6DxCnen1OYqaNc0fEn+iT0jsi1Ro+vpy7+f44NLW27OK7qcyKojhmrL
         Dkq/v/93J+chX2p7yf2oE4DegwoEQYakivD7RNAPT6lb0uimzcqYBYSt04kG9s+8vkwj
         YdHF9/IjYDVfKl3f6b0jdYofzaTQdCsCfqYCkqYqd9YhiV4SN3v8GhlCX/fPIZeNQngd
         dWbeTenqFpNItt9/BA906EZ3Y8+kVVIjjh1mdcFDc+pNNxIOXgxIvQVym0iyTKQYNatm
         VJz2U67hcTSPXM7BY+rxDkqE636cIUJtOQSRImK3O7aluMFgY3NWFxobo885w95TC1XO
         yq9A==
X-Forwarded-Encrypted: i=1; AJvYcCXGzfXF28CDOeIM8Mqs1VK/lmh7cc6ZHrWKpFfYT4JPcyweOsqm9JqVBA+2osb0atJxZswfkPmM2ro6qLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOyiYyKX8BGGO8vSIdxPMFh8LoOrQI4Ku6FXdU5MrBj+JG1uA
	1oehuzhMBFCLU/l/4IWhvu33+c9zBObKsOBrAPLlfE2ef0UOl9oP
X-Google-Smtp-Source: AGHT+IGFtrLdK08ITWSFu7yvH5GHNlBtviikNArhhe1WfSUYdwaK4uGmJJC99uPR0cF7OLFxwYseVQ==
X-Received: by 2002:a05:6a21:164e:b0:1c0:ed80:6e69 with SMTP id adf61e73a8af0-1cce10c4f32mr1821087637.39.1724926571338;
        Thu, 29 Aug 2024 03:16:11 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:479:a52:632f:b914:4ddf:273])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e56d77eesm816577b3a.153.2024.08.29.03.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:16:11 -0700 (PDT)
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
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V19 06/22] mmc: core: Add New function to re-factoring the code
Date: Thu, 29 Aug 2024 18:15:23 +0800
Message-Id: <20240829101539.5058-7-victorshihgli@gmail.com>
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

