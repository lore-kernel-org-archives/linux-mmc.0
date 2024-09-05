Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E48199EA4;
	Thu,  5 Sep 2024 10:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531632; cv=none; b=l9L6+4xsxoOy1uJAjY7SpaQo/5H6/WfTFyvHEKFafnmkiImAKmfxfrLdQG+r1wUDMJnXPmWHBWEWyEHEATvhaN2eC2mJ80HcYu9Zpi0MrfQFS8XmOZAN0+tGZfQvB51koqH+FnaHX+kTnhVaqfiAVs2vj8ldzmGYKV5IBpvUrQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531632; c=relaxed/simple;
	bh=ItSyxu3z+cpuKQYpHT1VflweB01MjpYZ5FR4CmHMj+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UfDa+MGvPbNIyzZy9SmGeAFO3xUNtTR+8jl0h/tKrbQx1VS9dK0CRvw4044YZfGQlj3F6iDTwRAtcr1RI7mr/JVg1K4fPbx+z8b36IXkD9Ld80yC9nrfQUqJ9e3gqEYvoPfxD1zChl3geWgeDOWbjZB7Q0PgcFwrKK/Na7Z0MH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mnuaRMXw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mnuaRMXw"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-206aee40676so5716845ad.0;
        Thu, 05 Sep 2024 03:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725531631; x=1726136431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sxDQEMkG0vSVZkGLeTe49B0S8pLWIGbl/FPUz9dZDz0=;
        b=mnuaRMXwoKAdId/kW0O493vZz71bh0KpktGasseANAyMISOrLyLSrTrp+4KvTJu/eS
         6RUEFqzfwprErAXTTL19/b9Gi1YqoCUGV6O5qOki2aTaxO5gPa5R2xFMfzEZbfs86vEf
         E9W4tWKHwD3FuiXuGChgWxRyunSpNcRoX3oZemmfFOPE+bpUYTuelrSK41t7DYji5KBU
         rNUjLtWmKT46QKxbMTWMUIwp9KMicMM9CdRRfBviL/WTW8BTyUUiyV5+vqgsDZMyCD8K
         OF+7od3skA1XWnyh1Qb90QkEZhgeIMIqpZBqTwgDwbo7CPsACp3LCls/QL7fC2WHBg5U
         BMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725531631; x=1726136431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sxDQEMkG0vSVZkGLeTe49B0S8pLWIGbl/FPUz9dZDz0=;
        b=OSZHgnd2Rm8xgIxxaNV6Mzj2a0lXoD1O0TGv0qYvgiQkj6cGfW/pOZ/U26AXg7TwWM
         RbnOWaaUs+MYbU0RycOmWNyLpERFDk/8xKnelCWb4+JS8jE3IFWF1iUT7iqI7bgOKrVy
         CGNLkQYcAhtTmjN+K7Q383Xrovyj1HZm6AHKPb6qf/NXOSiz2XcB/N+XuajRYXgoYsCz
         6TwJfm5lxTuT7T27ihjooEHL9SFi3dUFmZ2pHYdHhBI/KK3vLsBksKX5GI2Tj7BjBrN7
         gxSVgiKt3Hl4SFrYMFJZr/htm+3+lg85vxTgQfhSI+j+tfVmiJc5zU2Fim7wHSMssz5W
         2srA==
X-Forwarded-Encrypted: i=1; AJvYcCUm23CaXjPp+6P9fuiWhkdZfNeLjOuQWMgqXmW5CPVV8E7ENeLv6mjGeGeEj7nwyZhn7CgT1scprWKWaSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzamt4trp31w/MdL5OBLCRq7Ws6yeMGzESei+J9VvV6f82qiQ4U
	lfQ6qa6RE+e11VvuAqlj1ND4x99HtYor7g6fgZmItqezg6RHbNwR
X-Google-Smtp-Source: AGHT+IHY/EG1qlc7Fc4+626oGw0olTj0128fkgzLCOvZ1r87gH+kaaUKQl5MD3d9iHMPIuKRFYJTgg==
X-Received: by 2002:a17:902:e5cb:b0:206:ba59:3e16 with SMTP id d9443c01a7336-206ba593f0fmr40227645ad.50.1725531630755;
        Thu, 05 Sep 2024 03:20:30 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:244d:9999:a704:87a3:25c6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea3855asm25979245ad.144.2024.09.05.03.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:20:30 -0700 (PDT)
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
Subject: [PATCH V20 06/22] mmc: core: Add New function to re-factoring the code
Date: Thu,  5 Sep 2024 18:19:44 +0800
Message-Id: <20240905102000.5020-7-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905102000.5020-1-victorshihgli@gmail.com>
References: <20240905102000.5020-1-victorshihgli@gmail.com>
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
index 06017110e1b0..0df3ebd900d1 100644
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

