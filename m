Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1863E3167
	for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2026 08:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646539; cv=none; b=tVHdLvgkRwB7BIHyZ9e1Vnzc8u2mrTmqPUMwbVyQf3lknkUOmaw5OrdpIoWW9Ox6OmK2ls0nBqv7dTdCEeh1lfU+T6uIuUd97rgUTvkt6OSmtJkE6WKt+fvmGC/+nimchQ0qNivnm3hI3FysgRcbCCfAKDdhBR3QkILAW2l4q0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646539; c=relaxed/simple;
	bh=D1UCAtU9SxqGtG7q6DYSm91qmaVsbEgtt8rPORR9a+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pWNBBXDySsCIFgr5vuhLlu0o2HzlI3ntZlaTc3QSmU92Tqii5DrYZVszaT24LP81aDs6vBsy+F52m/R5DIpIieNZTlLO9ClLxbt0GcxlGYbEwdhfERkR3Cghgj/71u/yInvX86hSnnDgcNbPcvywWFQthT+Bw+3Ir3c9FOl96F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcEPt0CD; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcEPt0CD"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-ca88130e09aso2716337a12.3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2026 01:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787646537; x=1788251337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=auUE+jAHKPa+cSMKOTTSmj2ehc05SvpVRDH7zDwZHsU=;
        b=fcEPt0CDRWDhvcZJxb3I5keLGlVo7r87Jp2ovMSheAAYRLEf5FyIEt6qfGd6E8CITB
         swJquWo7aXB+tnf8eaVaUc/iYT0mxpwBY0HQUIsZLc144oMvFPzKodKG7rDWeoyRqKOE
         jT96QT15Dz2AmhVY/a5DMdKJ1W2cG/K4z8fAIFfl741NfB4GNEgr60YfBPtCtmdChVh0
         ayt0gE4LrbxbARGRJn42tusR9KnD4GEnvLChH66s3R17npuxRL9hQknNACX2CTkPyjLW
         SEf6hzsBpLJhb8+aVDswA4h8HQtdVMLaZgVADgRN+6pmRmwDFamg3sYoG5xcsdWU/p4f
         cvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787646537; x=1788251337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=auUE+jAHKPa+cSMKOTTSmj2ehc05SvpVRDH7zDwZHsU=;
        b=T8w3W9fc1gAE3lOU/D1feG/4bTZh3kxbPYNlIhYQv1uVgedOEQa1gPiJmIDTvfJw3p
         lSR1lv/nNhFrOpNZcsVLWQ9tCxEd7f1YGo0AvGiRGUwsfnyF81dXRReHumTxSFagdP+Z
         vTmc3FDXQlVx0kJxjL8nguQYVGxg+553lEj3r53aNV7vxy17Qwz2ODq5r77c2QXwHa3r
         65Dlt7qQx5wdbWfoXh0TZoNrCedtKoTOleGpEj8D4nvBq9Mj76zzuB7ymT+zlPtRnVr1
         H+KRZjzQMQDYg/w+Cz4BeO3g2pCKsEFyLwn7V8XB6KheUotWwMQ9EbUhUJ0Kbt9S0J/o
         eFRQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJj6Jm4mtZ1HEQbIsAYKqpYW0c0+pga1+xOIhiZiW3jh53jtHHmnhWhTBr7Yk3Nj/4edBeZAAZZ48=@vger.kernel.org
X-Gm-Message-State: AFuF++lidzZgTJc5bV3vPhp63x3fzdrj4DPV8SWR6xFbxUA0ha0PhyYd
	Yx50Ov5ZtQb/WxFJrZ/k7SqR65CESaLB0NwkhKjBjxLwFe3bLLX0Jj4=
X-Gm-Gg: AR+sD134AQ9U6BCCq2I/oSN+DOgQ+y6ZreqjVBvDW60RWXV5EQzW4/2iOIQhBDO0lDT
	B7b2OXpebGqnsEMRdIUHZv2QZJhP2LJem2k/alMR3cemkpbqX1Mdp00867jgnIDK/jhfbTCmFTD
	vkkTTuSLMO+lOSBusrZvp9tyKmFnK+ChZU1K+SnyuZhyQDUTIojTFsNzAgeBX3u1nHKw3mR0h2e
	VPBcYsttb+h3iNA9FOdZp5oFQ9EHbXkEoyV5IC7hIx/afx6AR+zdXWM550+Vgrqmk/h2UMTLTVZ
	IqR2Ct2LI+HiWVUZwyykCvnqvi4Afbqv37pKDtDqWwIr0CHPinHbERHMnD8n6I4664m6Drx/eYU
	HUS+oGCZUEUYSst9dAoGbCI/0vEWpo45Nrdrkr0dEa8k3mC708Yf9Fy4lgqyZqlBC+0nPf6BYIN
	BiKWr9BqQIklQPVoSl41Vu08+7r8Z8kfGTIdFEaTR3wx7OxT9mvTnHV0z6dq+SyKM0rC4+HH/Q7
	A==
X-Received: by 2002:a17:90b:53d0:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-395c359a74bmr59130797a91.12.1787646536867;
        Tue, 25 Aug 2026 01:28:56 -0700 (PDT)
Received: from DL2XHKPB4.dl.net ([103.63.104.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b3a49bsm2946379a91.6.2026.08.25.01.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:28:56 -0700 (PDT)
From: Triet Hoang <triet.hoang.dev@gmail.com>
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Alex Dubov <oakad@yahoo.com>,
	Ulf Hansson <ulfh@kernel.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Triet Hoang <triet.hoang.dev@gmail.com>
Subject: [PATCH] memstick: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Date: Tue, 25 Aug 2026 15:27:17 +0700
Message-ID: <20260825082718.244949-1-triet.hoang.dev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the deprecated SIMPLE_DEV_PM_OPS to DEFINE_SIMPLE_DEV_PM_OPS
and pm_sleep_ptr().

This lets us drop the __maybe_unused annotations from the suspend
and resume callbacks, also reduces kernel size in case CONFIG_PM
or CONFIG_PM_SLEEP is disabled.

Signed-off-by: Triet Hoang <triet.hoang.dev@gmail.com>
---
 drivers/memstick/host/jmb38x_ms.c | 8 ++++----
 drivers/memstick/host/r592.c      | 6 ++----
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
index d93ba5e8662c..2f5f0e0677f5 100644
--- a/drivers/memstick/host/jmb38x_ms.c
+++ b/drivers/memstick/host/jmb38x_ms.c
@@ -792,7 +792,7 @@ static int jmb38x_ms_pmos(struct pci_dev *pdev, int flag)
         return 0;
 }
 
-static int __maybe_unused jmb38x_ms_suspend(struct device *dev)
+static int jmb38x_ms_suspend(struct device *dev)
 {
 	struct jmb38x_ms *jm = dev_get_drvdata(dev);
 
@@ -809,7 +809,7 @@ static int __maybe_unused jmb38x_ms_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused jmb38x_ms_resume(struct device *dev)
+static int jmb38x_ms_resume(struct device *dev)
 {
 	struct jmb38x_ms *jm = dev_get_drvdata(dev);
 	int rc;
@@ -1011,14 +1011,14 @@ static struct pci_device_id jmb38x_ms_id_tbl [] = {
 	{ }
 };
 
-static SIMPLE_DEV_PM_OPS(jmb38x_ms_pm_ops, jmb38x_ms_suspend, jmb38x_ms_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(jmb38x_ms_pm_ops, jmb38x_ms_suspend, jmb38x_ms_resume);
 
 static struct pci_driver jmb38x_ms_driver = {
 	.name = DRIVER_NAME,
 	.id_table = jmb38x_ms_id_tbl,
 	.probe = jmb38x_ms_probe,
 	.remove = jmb38x_ms_remove,
-	.driver.pm = &jmb38x_ms_pm_ops,
+	.driver.pm = pm_sleep_ptr(&jmb38x_ms_pm_ops),
 };
 
 module_pci_driver(jmb38x_ms_driver);
diff --git a/drivers/memstick/host/r592.c b/drivers/memstick/host/r592.c
index 605b2265536f..ba7d63eb5b31 100644
--- a/drivers/memstick/host/r592.c
+++ b/drivers/memstick/host/r592.c
@@ -847,7 +847,6 @@ static void r592_remove(struct pci_dev *pdev)
 	memstick_free_host(dev->host);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int r592_suspend(struct device *core_dev)
 {
 	struct r592_device *dev = dev_get_drvdata(core_dev);
@@ -868,9 +867,8 @@ static int r592_resume(struct device *core_dev)
 	r592_update_card_detect(dev);
 	return 0;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(r592_pm_ops, r592_suspend, r592_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(r592_pm_ops, r592_suspend, r592_resume);
 
 MODULE_DEVICE_TABLE(pci, r592_pci_id_tbl);
 
@@ -879,7 +877,7 @@ static struct pci_driver r592_pci_driver = {
 	.id_table	= r592_pci_id_tbl,
 	.probe		= r592_probe,
 	.remove		= r592_remove,
-	.driver.pm	= &r592_pm_ops,
+	.driver.pm	= pm_sleep_ptr(&r592_pm_ops),
 };
 
 module_pci_driver(r592_pci_driver);
-- 
2.53.0

