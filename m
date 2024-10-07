Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD1E1D1302
	for <linux-mmc@vger.kernel.org>; Mon,  7 Oct 2024 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728301766; cv=none; b=pNS/fKwUOTL3tFh9OwGJtwxad1UQTSXDQUG8THXvD8SOBYSPiUdoBIEqUaJCi3C5npAvbT50lrFfHsAESC9VUiLFvAi9iOTrP5nt+0huBRtEa8sBTMT55cBjYstcs0V3Wb64jKL+BTNPxazapJ+xo/LzlpVxX8hfQkx9+uSF4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728301766; c=relaxed/simple;
	bh=3HpEuDlKwvLMsJm5pK5n4l/IzWqXEfzLiU8zqrPKi4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dgPwV+Jt4xwNTmoGeJPcSWwmMa3knN2I7pjdhD9BA7jYVpfBmLiW5Cm9XYPuAIC4riYedtGZjatf5pwbaG1ET7eXbOCO7caYutS1PVcKndWMyt2yctFVaiYJYlSE749357nj6rNTpzyLd0KMLVrSofin2bP5YmPt2yENff2Un4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=uQgzd2Xn; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="uQgzd2Xn"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so44806915e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 07 Oct 2024 04:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728301761; x=1728906561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1LvSfzkrrq1edO65ZqABisdNdPzmZ+rbdqRIfcFP+q4=;
        b=uQgzd2Xn+2BHY1NkMLan5yce1rV5dcMlCjyavgie+aQEJ5h/EnNsUjP3YsGm7gOot4
         4gvkZvSgCYzg8WiBtf03cjMy2WSbZ4O9gLfWopW3TRrDX5lC1MzVQZvt+C+VWhX8zbvP
         kdiYZ/aDaOjxnjQmC0bml5gok53Xiy4vogvN5fiEea4M6xwmMKHolbGOU8jxNbm2Gi7b
         rdxzL3qjyUBZMq5wFD/CWGkGNIskRQG7n54I1nUOpqKnUScUwhMBOTO1VqZByVH+CUWQ
         eHGv5uu6zt7rlEx4/b5dSQPuK6MPcKS63vmmuhJq2Liwj4g/zztps9W2QAslJQ6NWxdD
         8v7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728301761; x=1728906561;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LvSfzkrrq1edO65ZqABisdNdPzmZ+rbdqRIfcFP+q4=;
        b=vZCe8NsWrcIR2eY8RTk+J5mgPfn8AtFso9gBbdWNGsmNkCR2YYkXXQQ5rpy0fcS7+W
         tRcaBSktEpb5PRdvSu2rZ3XXmlsJ5qeUozcB4jW8Dz9D2PueDJcfPn+YlQNv4obM08jA
         uAEpKndLMGuatV4s9pEagwkoGAfAIn1PHrMRqBl1nhrF+X73LSFyb4EcqXpXXCwrEHNM
         UrGOdWm0KuNKWeyQKuELiJee4umGKQAic9KySOagjvkTy0W12o/IyhgZvNk/ogcNvhgu
         bKPUMNdc4enqi8BVrRUA/aGZfbplt0h/290vlwOeU3CqB1RMy+g5F4nQOzQbsgdKqGtW
         Vu0w==
X-Gm-Message-State: AOJu0YxSp8c9uqvP6/lViJyN2cv+95Vc++tDWLT1sosuZ2hzvv4Qr6et
	owpuCGDnBwy+uv43MuinznHj3ybL7iryj2YPxPZvapqIDBApRXH0tyCfAQfQuPs=
X-Google-Smtp-Source: AGHT+IHf9LR6ONgc+274pvmiS4LyQDk910hcJu4EDlErL63s34vj95abPuZqXzebRsqQn2xLWBrS2w==
X-Received: by 2002:a5d:64e7:0:b0:37c:cd8a:50e3 with SMTP id ffacd0b85a97d-37d0e6eee41mr8463433f8f.13.1728301761130;
        Mon, 07 Oct 2024 04:49:21 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6100:637:cbe9:f3bc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d16920549sm5548261f8f.54.2024.10.07.04.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 04:49:20 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/2] mmc: davinci: order includes alphabetically
Date: Mon,  7 Oct 2024 13:49:17 +0200
Message-ID: <20241007114918.52066-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

For better readability, put all header inclusions in alphabetical order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/mmc/host/davinci_mmc.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 7ed533758dbe..fe7712532e84 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -7,24 +7,23 @@
  * Copyright (C) 2009 David Brownell
  */
 
-#include <linux/module.h>
-#include <linux/ioport.h>
-#include <linux/platform_device.h>
 #include <linux/clk.h>
-#include <linux/err.h>
 #include <linux/cpufreq.h>
-#include <linux/mmc/host.h>
-#include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/delay.h>
-#include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-#include <linux/mmc/mmc.h>
-#include <linux/of.h>
-#include <linux/mmc/slot-gpio.h>
+#include <linux/dmaengine.h>
+#include <linux/err.h>
 #include <linux/interrupt.h>
-
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/irq.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/slot-gpio.h>
+#include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_data/mmc-davinci.h>
+#include <linux/platform_device.h>
 
 /*
  * Register Definitions
-- 
2.43.0

