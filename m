Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F8A420486
	for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411138; cv=none; b=tk+MyvZvk8X7EEKqNIdDqeqwWxR07EmRQcPvBup+bEOnAHYLP4Oc6mPa6ESeBmbPcqselr7v3H6jetnKKPtdlg/Sm3cyinu3hEZbaJ0ym+xh9eMpNITWY6CwAI9REKzINWu/KaPh1cIqNUE+mmSABc5y/tPf5GCf2xBy8805tOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411138; c=relaxed/simple;
	bh=wHn3XJMhVSpqzgNGAxEkr8+vf9iQURyCq/YUf6fDWAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg/U0WWY18PNf1rwwz3X4gJlVFnOpLelrttAr+x+MqNMm+UcM+IXQeyZKgd3cWMO06plDUcRkvNFsKpdqZQ3MLnXTKvxlxn/oR/auYfvsA2/mmQ4TYY+tfxaYHtO5sqmgZFQBtR/zxN7cx/bgb3f9k8HNjCJM6tb425h12u2zkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kAZ3AIks; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kAZ3AIks"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f93b2fe4cso1379146f8f.0
        for <linux-mmc@vger.kernel.org>; Thu, 30 Jul 2026 04:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785411134; x=1786015934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ttnpy3XCfPk1xXn7aAyw5FPz8AkLK06BJg53CMkvAIM=;
        b=kAZ3AIks1cMZjvi8mFe6wqpokkfGaj3EFXsHE7d2CKlK8B39DvM615SnZvYkngEoLu
         GNOWb5d42FvTKWW2L1YKX+m3cXB/Z4JtFbZK2AHmC42rle49qK/nxxi2AkO7B0cPPXzO
         v81QwLyCJGRGw42R30Nb2AhevtBwabrKW1lr4mVAAzPe9FTZtndjEmzybaQ+y06nbssX
         Nd/B2dYFKFBqZVJ+V/zobV6UKZpee5uy7bfPg8NXgaocp5Blcic+qiOXisQ5Z5z61t6Z
         hOiqAEDYaLlIz8O3dea1LT7z++HOCBiGx9hcPELvDeuKXY0okGNQdsoaAtSZzD85PojF
         KZlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411134; x=1786015934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ttnpy3XCfPk1xXn7aAyw5FPz8AkLK06BJg53CMkvAIM=;
        b=I7m6GKWOJKy8I8IQ59NxgTgN0uin2N7YlFzrfZZSezyA5BGf4to5rs4mgkigsVWy/w
         FmcZO5LhNJphSefjK7o+xl4QBmjJjF2yFv1NYLLnH/fI3zlV1oNzNe8jjErdhAAsL9/j
         RdUTyvIvmdaGGkbbzzI2LSQ/bxCgTxF95LwlNC8WrkRpDOZFUo0RGsR02Ap8xgXD+/+1
         DEw0XchhTba6keNTIaAWHJbVtdSS3ojfyASC6HX6Uuk2EM/dU1jT0uPyiQAPEEuMYzP4
         LEeY7HrJPnClN6nOT83c7j+a7VjWmUo+hPRGRWq/RerqqaUMHrAEN2iEk5ycifzSTRhr
         VaCw==
X-Forwarded-Encrypted: i=1; AHgh+Rp++bdejESoG511cmZn1wdk+hGUQlZ+txeczyjZ6E1tZ58fB/4G6FsjNekg5GUgK2zfg2Cq0pn1tCM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzzYjzibP8gpFQcckYOUaUoQ0YwVg9yiOCzNcXCa0gK6Omy39b
	u8rM751KLJ+SOXGav1eHIyvmLdQztwrnfeADXU02HvsD0JBHmffqAAed
X-Gm-Gg: AR+sD10cIl7F/aNFbqjh/0NON1Wk45AFKcX5vVufjRwBDxDTQWBe7r3P5Ui/sUWrzH3
	lexXzgV8g8H06saSDHRkCcVgaiPXA6s6IRY6rY9q+jcm6AfuhLfdICEY4CdOhm8pzRyJURKZkko
	Pg+mSL0Uw4gpjnATVaOg5/aHpyfDz//oNvjkP3vs3wdnXjWc9aOPGre8KDv+NydMyKXe/2LmfjS
	Ef+BhG02da3uG1k/yBQX69jJH7ZkejVNb7hF/iHCiQvpCDfoKxqolsz7gZggkK3nGNEBOmabA0Q
	I6pNr8DC9kNjIqDEI6nUQIJ1cUt3GSUP4L3LErI/861atBeEjVCjyImye6F93mGsv+wQA3pWIV4
	Z1ZIvo08HituphhAPXkP9Aub3tBOjPG11KNuE694COulKER9KDI24iJ3Z4NK9RB2nwLNKt7raD1
	G6RkJ6vI3BxLtwrcbhDTxOwMJ6afXcqtgFB/tLfpdZATwOQ79DLax+X7rIK+k3SvJFDbCt9/JF5
	rcmdIAuvVqKMw==
X-Received: by 2002:a05:600c:4685:b0:495:5205:86c with SMTP id 5b1f17b1804b1-49800ea4a38mr28656995e9.22.1785411134174;
        Thu, 30 Jul 2026 04:32:14 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:eabf:a623:1e7d:c359])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc89351e3sm5737947f8f.29.2026.07.30.04.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 04:32:13 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v23 11/14] mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
Date: Thu, 30 Jul 2026 12:31:49 +0100
Message-ID: <20260730113200.36456-12-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
References: <20260730113200.36456-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The SD_STATUS register, specifically the IOVS (I/O Voltage Switch) bit, is
not automatically restored after a suspend/resume cycle, causing the
regulator to report an incorrect voltage on resume.

Fix this by caching the CTL_SD_STATUS register value in the renesas_sdhi
private struct at suspend time and writing it back during resume. The
save/restore is only performed when a regulator device (rdev) is present,
as the IOVS bit is only relevant in that context.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v22->v23:
 * No change.
v21->v22:
 * No change.
v20->v21:
 * No change.
v19->v20:
 * Updated resume() with scoped PM runtime call.
v18->v19:
 * Updated suspend/resume with scoped runtime calls in suspend.
v17->v18:
 * No change.
v1->v17:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 26 +++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 3b140cd4ee0c..3e08b099ee87 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -105,6 +105,8 @@ struct renesas_sdhi {
 	struct reset_control *rstc_axim;
 	struct tmio_mmc_host *host;
 	struct regulator_dev *rdev;
+
+	u32 cache_sd_status;
 };
 
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 65002e6ebf9b..3459df084a02 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1434,6 +1434,15 @@ int renesas_sdhi_suspend(struct device *dev)
 	};
 	int ret;
 
+	if (priv->rdev) {
+		PM_RUNTIME_ACQUIRE_IF_ENABLED(dev, pm);
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret < 0)
+			return ret;
+
+		priv->cache_sd_status = sd_ctrl_read32(host, CTL_SD_STATUS);
+	}
+
 	ret = pm_runtime_force_suspend(dev);
 	if (ret)
 		return ret;
@@ -1463,8 +1472,23 @@ int renesas_sdhi_resume(struct device *dev)
 
 	ret = pm_runtime_force_resume(dev);
 	if (ret)
-		reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
+		goto err_assert;
+
+	if (priv->rdev) {
+		PM_RUNTIME_ACQUIRE_IF_ENABLED(dev, pm);
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret < 0)
+			goto err_pm;
+
+		sd_ctrl_write32(host, CTL_SD_STATUS, priv->cache_sd_status);
+	}
+
+	return 0;
 
+err_pm:
+	pm_runtime_force_suspend(dev);
+err_assert:
+	reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_resume);
-- 
2.43.0

