Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7371AB50E;
	Thu, 20 Jun 2024 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880346; cv=none; b=jGYjdZS4iLXaYECwgD5SMe2qti9NUoZKunpJWzJIAhs06m0HVh4qX1+C0H1Y6UwKzufJdEhoIcVsqdkptrWt45/PNpu6amQf8zSBQ195r2jFY+0BU4HZocFvyhdsNVHgZtvYOXuM4PxJ4VqgSF70X0m9Fp0L48IIdSUukSzENtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880346; c=relaxed/simple;
	bh=+dwK5282uCMsnjW1mk1L8dKJumjWhVd+pfUeWylbOt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mPaZu9QmIuUOa7m/pbV4KoqDOS2Bf2opjLVDUgCUWfRsfdEkOCAhu+q48z9btAC2B8jOfcjL5gOcEpGDu+qT7mSzmsVW+2jp7ASSjnWnyftvE8jTsBZ8h9Fnjg6/k+/SJw3PeUwhyJWT8Dgeq9z94mz2jgogx+7VqBrvPrcTcN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rc7H75ud; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc7H75ud"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1f64ecb1766so5472115ad.1;
        Thu, 20 Jun 2024 03:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718880344; x=1719485144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOdkXrgNTgcSvN5kJ0Vv+BY8p0cgmlvV1dWGrb2VSKU=;
        b=Rc7H75udqruKvo+KS501kAb/wPrg1xXAPkQU0MqmbrpMdGskdbkUZw3LzpzS50HoKy
         UYestONUqM5DPDq3cpwJpgs6zqxf9Rtpu65O7C0RgGJeSOMOS7VQOff3dyI/JPY6doda
         xi5/islTZ6zUOSb2SBNapTjceuXNeYG0/GyXLNp7UWL66aH4fjcp+AiL48nKOigXP6gN
         SRQHTAMPDNXNBD8sCOrlDSQ0AinBDv+IodeQcXk4Au4EspQZ7cq67OZDrtiB1uWKRflw
         blLyuWm6Sj0cTNeX6Nh0rD7H8PhYXwnpaNRfh1sLconH4t7AOmFyTzftmJf1kZ/whw4Q
         clUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880344; x=1719485144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOdkXrgNTgcSvN5kJ0Vv+BY8p0cgmlvV1dWGrb2VSKU=;
        b=eFTUHssQiVMgmW9GEd3NmAJEYnp6BvPu1YUZG4e+OMrq32zVZBvEyFNnGTliVaPSua
         mOH7zXiNkOCq7pQhvh8RQxLloh0qqI/IA86F4iPJpPWqV7Rv4w97lxrjfwLI87EB5OSw
         y0skvRHQMOdm3TbRWCmPUJhKy0dpwjozR3bIw/f5ZKkctPb7ObOJNrKwxmLrI9YK3g5m
         GjvKkP+Vevf1etAsCPcp/aagLe03GU9yekAqbICPHU6EN2Knc1oO28ZO/fjHii6rx0DC
         6+OTYoguBqcbFJWlMwRxFlmMZ0mj27S3KKKRXVvf0amrpTpeiVKnkHZX3zt8D9Xjll3i
         pIjA==
X-Forwarded-Encrypted: i=1; AJvYcCVBCP04LB88kGqLzuJzeYXsRBML9P52ZTajTxDWNJ7Vs5eBXWLTC6ytlUNJo5dxRBq4srJAOpfG3XENzZ+RCohguDWO/S24w9nStjyB
X-Gm-Message-State: AOJu0YxWNoIqE9sC01oj3y+PVWkt0oVV5WVMXvrvaqKs9Vt5NiC4oOkt
	v65/FnRSnzPf1umGBPutrlHT32rA1fMGDwNWVqLaX2+LMEDwbKpz
X-Google-Smtp-Source: AGHT+IFfT5UDqdWP/tPiT0dnJWnoUhGGY3BmAjEn6NRBuhFHyK0WqbabXr9ndt/4YB7G+KcI7VpS5g==
X-Received: by 2002:a17:902:f550:b0:1f9:b301:dc6 with SMTP id d9443c01a7336-1f9b30111f9mr41047455ad.7.1718880343887;
        Thu, 20 Jun 2024 03:45:43 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e28a-abbc-b19b-27f2-8368-202e.emome-ip6.hinet.net. [2001:b400:e28a:abbc:b19b:27f2:8368:202e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55ca1sm134007805ad.49.2024.06.20.03.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:45:43 -0700 (PDT)
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
Subject: [PATCH V17 13/22] mmc: sdhci-uhs2: add set_timeout()
Date: Thu, 20 Jun 2024 18:44:35 +0800
Message-Id: <20240620104444.5862-14-victorshihgli@gmail.com>
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

This is a UHS-II version of sdhci's set_timeout() operation.
Use sdhci_uhs2_set_timeout() to set and calculate the timeout time.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V14:
 - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
   sdhci_uhs2_set_timeout().

Updates in V13:
 - Modify comment message.

Updates in V8:
 - Initialization be combined with declaration and realigned
   in sdhci_calc_timeout_uhs2().
 - Forward declare struct mmc_command in sdhci_uhs2.h.

Updates in V6:
 - Use GENMASK() and FIELD_PREP() in some case.
 - Use sdhci_uhs2_mode() to simplify code.
 - Remove unnecessary functions.

---

 drivers/mmc/host/sdhci-uhs2.c | 72 +++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-uhs2.h |  2 +
 2 files changed, 74 insertions(+)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 0cfe9a3f91f7..8bd2baa79d76 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/iopoll.h>
+#include <linux/bitfield.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -135,6 +136,77 @@ void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned
 }
 EXPORT_SYMBOL_GPL(sdhci_uhs2_set_power);
 
+static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res, u8 *dead_lock)
+{
+	/* timeout in us */
+	unsigned int dead_lock_timeout = 1 * 1000 * 1000;
+	unsigned int cmd_res_timeout = 5 * 1000;
+	unsigned int current_timeout;
+	u8 count;
+
+	/*
+	 * Figure out needed cycles.
+	 * We do this in steps in order to fit inside a 32 bit int.
+	 * The first step is the minimum timeout, which will have a
+	 * minimum resolution of 6 bits:
+	 * (1) 2^13*1000 > 2^22,
+	 * (2) host->timeout_clk < 2^16
+	 *     =>
+	 *     (1) / (2) > 2^6
+	 */
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < cmd_res_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for CMD_RES!\n",
+		    mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*cmd_res = count;
+
+	count = 0;
+	current_timeout = (1 << 13) * 1000 / host->timeout_clk;
+	while (current_timeout < dead_lock_timeout) {
+		count++;
+		current_timeout <<= 1;
+		if (count >= 0xF)
+			break;
+	}
+
+	if (count >= 0xF) {
+		DBG("%s: Too large timeout 0x%x requested for DEADLOCK!\n",
+		    mmc_hostname(host->mmc), count);
+		count = 0xE;
+	}
+	*dead_lock = count;
+
+	return count;
+}
+
+static void __sdhci_uhs2_set_timeout(struct sdhci_host *host)
+{
+	u8 cmd_res, dead_lock;
+
+	sdhci_calc_timeout_uhs2(host, &cmd_res, &dead_lock);
+	cmd_res |= FIELD_PREP(SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK, dead_lock);
+	sdhci_writeb(host, cmd_res, SDHCI_UHS2_TIMER_CTRL);
+}
+
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	__sdhci_set_timeout(host, cmd);
+
+	if (mmc_card_uhs2(host->mmc))
+		__sdhci_uhs2_set_timeout(host);
+}
+EXPORT_SYMBOL_GPL(sdhci_uhs2_set_timeout);
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
index 3efa8dd690bf..9bd3f610cf8c 100644
--- a/drivers/mmc/host/sdhci-uhs2.h
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -175,9 +175,11 @@
 #define SDHCI_UHS2_VENDOR_PTR			0xE8
 
 struct sdhci_host;
+struct mmc_command;
 
 void sdhci_uhs2_dump_regs(struct sdhci_host *host);
 void sdhci_uhs2_reset(struct sdhci_host *host, u16 mask);
 void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, unsigned short vdd);
+void sdhci_uhs2_set_timeout(struct sdhci_host *host, struct mmc_command *cmd);
 
 #endif /* __SDHCI_UHS2_H */
-- 
2.25.1

