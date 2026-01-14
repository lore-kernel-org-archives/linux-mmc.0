Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CFB39447C;
	Wed, 14 Jan 2026 12:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768393393; cv=none; b=KeK7/EXWi9BECJTgbeiL1GJVLlSO7veENGj7xVrkcxBeDn+bOjuhsYHXvwO64EH9/uVErPiWLs4wWj8gn9mijvasSBGjHvJr8qwpFROwHfR/e93aoE7ZbGS+RqqLVMy3Z+7Dq+lcn1GJfSdDEbWFMcBSXWJX1KfP9x4OSLi1tOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768393393; c=relaxed/simple;
	bh=GrWSKSwZtvr+JMHE5z+04H9SwwgIwWz5iLjIuhBx4kY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IprBVWeQfVsZ0uaUavmn77JEhsgRxOSxH1tX4xVk1B1tKiS6A/kWOwX9Qa1mdGFeJh8GDFSdsLoUbP438PFXxndPzukuQdjLmfsGp6v5gs7FLJwVjNcfl+wL3cQWrsde6PcnGxN5H7bFyqeMo4l4u2+hsEEsgo8fU89oK7+NbmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005182LT.eswin.cn (unknown [10.12.96.155])
	by app1 (Coremail) with SMTP id TAJkCgCH22yjimdpwzcBAA--.5985S2;
	Wed, 14 Jan 2026 20:23:00 +0800 (CST)
From: hehuan1@eswincomputing.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	xuxiang@eswincomputing.com,
	hehuan1@eswincomputing.com
Subject: [PATCH v1] mmc: sdhci-of-dwcmshc: fix DMA 128MB boundary
Date: Wed, 14 Jan 2026 20:22:56 +0800
Message-Id: <20260114122256.1587-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgCH22yjimdpwzcBAA--.5985S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZF47JFWUGw1kAr45Aw1xGrg_yoWDJFg_Ca
	4UX3Z7uFy8ArZ2vw12yF9Iyr1rCa4YgF1DWry0g3yYk3W3ur1kXFn2vr1DJr45WF42kFW7
	GrZ8JrWxXFsrKjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbhxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r126r1DMcIj6xkF7I0En7xvr7AKxVWUJVW8JwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbU73PUUUUU==
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

This DWC MSHC has a 128MB limitation where the data buffer size and start
address must not exceed the 128MB boundary. Registering the missing
'adma_write_desc' callback function.

Signed-off-by: Huan He <hehuan1@eswincomputing.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 51949cde0958..cabb709a8108 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -1726,6 +1726,7 @@ static const struct sdhci_ops sdhci_dwcmshc_eic7700_ops = {
 	.set_uhs_signaling = sdhci_eic7700_set_uhs_wrapper,
 	.set_power = sdhci_set_power_and_bus_voltage,
 	.irq = dwcmshc_cqe_irq_handler,
+	.adma_write_desc = dwcmshc_adma_write_desc,
 	.platform_execute_tuning = sdhci_eic7700_executing_tuning,
 };
 
-- 
2.25.1

