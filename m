Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79258191F74
	for <linux-mmc@vger.kernel.org>; Mon, 18 Nov 2024 07:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731914998; cv=none; b=TMCt0StMlr2h/2zH/B0mUUEIYEgxV3Fph8HRmd2SH8YiRdok+b5zv+FuOJFDqIT1JdxU2v4oEInbnReIcwooMcF4VELd7N3O2xioAgJuSktWjdSwt6UH3qHfRwr4qS/sELjng6EyU6r2IpV2+e46T8L7pECNCQND0FSg710j+Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731914998; c=relaxed/simple;
	bh=94qwWOo7QTWYKV/Sooqe52Aii0FwTnDZQrIkGfFMP2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lv7Prw5XM079NvrOXhvhddPPj7QA4MhxF55yV1wpFRp3lE2IuLkzQ6wrAvPZAoE7wjQUD7MRWy6DHaG0VWmbwuChMdWMDYsBH+33Zp2Y1esdtRIqj35APbbo/iDLucr+pOwfFHLsdKLs8kUGdQdNHvYwAgIbuI8iyyLeLQ3+5xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=gp+Jy/xU; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gp+Jy/xU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=3h32pvFwgdQwwoj/jDtNsBZmb+nL7PZupdbpCoD9vLQ=; b=gp+Jy/
	xUSA6CivLIykTPkkxGPhZwwmLJt3q9gsN3kQ1+d8hiVrMF+mtchh77opr/W/5TxJ
	D0mm/z6Z/hxZ2ZhEdEJfVPprunzwno79NVO3YfXd/beg7aIj1Y7HYlN9FU1Cejjb
	yy/XG/pZnJS2Eekou/nfFVhNeCVgEY6C+ogaE33VOaNiEPJDloNIyLf51iuibu7r
	JsBAjzrALOFhVQfVCwg0p5Iw/EyrlnicF3OcCBiJfqeRr+5fZBXt76vRYXWlh72Y
	YhaQC4nHuejFPKVFuvQwQ9veUa2b0Xef+MybH1BHxpNS5hxxM8Ea43bm0177QkOh
	Hqh3wze7czj4AbJA==
Received: (qmail 112470 invoked from network); 18 Nov 2024 08:29:40 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 18 Nov 2024 08:29:40 +0100
X-UD-Smtp-Session: l3s3148p1@ynAn4Son/NUujntT
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org
Subject: [PATCH 08/15] mmc: core: don't include 'pm_wakeup.h' directly
Date: Mon, 18 Nov 2024 08:29:07 +0100
Message-Id: <20241118072917.3853-9-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
References: <20241118072917.3853-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The header clearly states that it does not want to be included directly,
only via 'device.h'. 'platform_device.h' works equally well. Remove the
direct inclusion.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/core.c | 1 -
 drivers/mmc/core/host.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d6c819dd68ed..c877dae8b4e2 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -19,7 +19,6 @@
 #include <linux/scatterlist.h>
 #include <linux/log2.h>
 #include <linux/pm_runtime.h>
-#include <linux/pm_wakeup.h>
 #include <linux/suspend.h>
 #include <linux/fault-inject.h>
 #include <linux/random.h>
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 48bda70145ee..bdb22998357e 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -14,7 +14,6 @@
 #include <linux/idr.h>
 #include <linux/of.h>
 #include <linux/pagemap.h>
-#include <linux/pm_wakeup.h>
 #include <linux/export.h>
 #include <linux/leds.h>
 #include <linux/slab.h>
-- 
2.39.2

