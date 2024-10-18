Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5F202F72;
	Fri, 18 Oct 2024 10:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248856; cv=none; b=AsA5jroraVkfxqdW8MdYT3dHo4IStJMgbTWD6LAHFAmpTfYcxAyY05XJ7VWFbBjV67Rv/ks0heBHPCtNFh2BaSXDVE/Oj/wzftTgcg41JkyM0hj5ql5k5srKDPehU93LMgJPRU9VjlWWACcy+9NNMh3DTusZ1QRvaybwm5V6/D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248856; c=relaxed/simple;
	bh=VB5pAfZlY5yWHbxrV1VvySF25vuCBwsa2Yimme8Jx9w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aDkVxNHb0ALm6w0xCPjvN/qowHcAX3hSwKYIko6ceFmcAHnPW0VXSfOzzVsmvBFhlIeEJkdzRRmitP87GLixL40NyeYqdblQ3F/dxKL/6COSoreiy1hjQr2gUywP7uXzNS8IZtBxay8wZ5kC6gS3Al19EyebYfIqbqNFWxkpudU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0dQhcQM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0dQhcQM"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c693b68f5so21559835ad.1;
        Fri, 18 Oct 2024 03:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729248854; x=1729853654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGS5FnAtxOoJb/6wOxS2ea2cNEevmIiG+LI1be0l3jU=;
        b=D0dQhcQMA6eKkLGL575yWpfECiBAtDFsx7VxVRvaV4PIs6uyUIoz387CKDPhPhH1wy
         4EJ87rNhU7bKuKmHCJxn6e1NzgBw2FtsLaRu4bHXLpioOD3rXVbhWNFAJNvPg1mXia+q
         2vLTjLciQh83TtJJzUNZV7KcHEuzj7kaExco4h9XvQFimbefmSZ35LxiFnpAOtPsccc5
         SGYWrAOOhNgHNXu/ne6nA/i3c5ZpvHg+79aQSi23zfmxFsj6/Cp/LdNmKyvbr+IVs9D1
         1O6XpGcJOkv6+fLhDIfdS3riKSpS2lYRI2H95bBvhE3jNIdYVQdjnXnXtuD4FME9JZqX
         RhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729248854; x=1729853654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGS5FnAtxOoJb/6wOxS2ea2cNEevmIiG+LI1be0l3jU=;
        b=eFtYuxDEr/YkcLnaD9cUSNiIls1FizVjloUYBEj2bHtxXbj4DfLd9dKnzN5FuxEkzX
         5fIzmtmuVGSG3A4y9t1lXbD/O7FDdcclV8v3ZmcgdAg+rXJ/z1TrvXR2ForJIRU7PdU3
         3AxfhPZIJqh2auT9/IfFbdgJ37RbKbU+bzQsKS8Jj2IQpr3EaG+t7Mrx6WCXRGPNkjSW
         JmUX5hzBxcpFu0qzPhRbvWTX15MTmFk5pt2d+Vg9frS2D/vOBp8jvOMiCqkx9lI4KZqN
         6KnBcTJil/yvVp/I6sDK1H1xjrYdI9OO/bp/CGv3VLBWhPwxd8QCi09WEGMLVp6LyWbg
         S7zg==
X-Forwarded-Encrypted: i=1; AJvYcCVfhg0hx+9I8l5ufG7k3aABRsJoeJDnsb6NTheJ3pFnvfSEec6wSK1/JwX262FwCGRGZGOF59bn80EY5oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrkMkBvWt4fTmk9n1Bm7XOjMlJnDS3fpEn4j1pIPTA3kNNT8hS
	Yk+kglN9fVFFIxxgGB9UacyF7FrWJ6BixtwPyCUazsShh8x+iK5JV+q/3A==
X-Google-Smtp-Source: AGHT+IGFIw4MCpwUYyysC9aeT84AnFkvJ4pEVcGeOW//2XwIrhsz/5/0eVfHmRpLlUCXUwnsecVyyQ==
X-Received: by 2002:a17:903:32c2:b0:20c:b274:34d0 with SMTP id d9443c01a7336-20e5a913801mr23688565ad.46.1729248853826;
        Fri, 18 Oct 2024 03:54:13 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47a:11ee:3789:3bcf:d64f:bc9a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a8fa20esm10237455ad.234.2024.10.18.03.54.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 03:54:13 -0700 (PDT)
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
Subject: [PATCH V23 07/16] mmc: sdhci-uhs2: add set_timeout()
Date: Fri, 18 Oct 2024 18:53:24 +0800
Message-Id: <20241018105333.4569-8-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241018105333.4569-1-victorshihgli@gmail.com>
References: <20241018105333.4569-1-victorshihgli@gmail.com>
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
index 756e44d84b87..6b249eb8395a 100644
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

