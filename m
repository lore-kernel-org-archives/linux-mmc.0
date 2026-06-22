Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF2C3CF04C
	for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 15:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782143789; cv=none; b=JYdtyIUju0Z2xopKOPBj9NfGGnospPG8h7VtPZbo3ntW4eZ+bTmNTCeKgqBPdkNWInyUlVuQ3BgrAzqSTVuhi4q7pQTAc+vYvUYfTQKbBVNAOWcIYFSEROWY58mnniVQJKiWClZrnpvq4sBo7K/XTP8lkAiY4iv46GR1NwgHlR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782143789; c=relaxed/simple;
	bh=2/LD1OatQJUDfHSnXpDX6TvGqBZHTTlPo9RrmADq2Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbIL1E7wvERgIpcR6akyCSx18iWkQWVgydUJOtYyo8Vv2NlakfYamiov5FHqszVioM4QeJP7ZZsZBhU1KkfE9cDnIKsIZEAv90KOVRe/tUws3mB3Urppxp042PCEmT94L3tzbNUwRTrHQXAPZrkX/pa4NYsjPkD0nHhy0BmT3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJTY/Sjn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJTY/Sjn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490b8ac62baso482035e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jun 2026 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782143784; x=1782748584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtBoyBOOZiGN1y5/NEeBQpM3YYk+AWxueD/rb/7AYDk=;
        b=eJTY/Sjnrf+jYrjr6i+Fsb22K6fXVJKa8p03GlkhsWzvXYgLg1Ls3SkZ+/ZXTxaSLs
         dJTUyW/FNesgo5yxlca15d9HKBX2x5e2ykgUvhvbl4sPYXVuUHXzfr+k84Jgb8PAmnLN
         uxRkOp3isQq1IGXv7Ku2WnbjzJbxr11p4a5lzY34f8K6EX1OFdis8xtAqWn7Qv2RM8yS
         iRSaVAnc4PGacwPTXcEna4DQ5Ofvkh4fXklzQcF2Na7tHvvFBfa25LBzF6rc7kOS8CZ0
         uDiACtTw2L386pL/VK4CZbIB4aqSB1OygchKX11vAj1N3kfU7lxnidZzaSPG1kGp66Zx
         akoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782143784; x=1782748584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtBoyBOOZiGN1y5/NEeBQpM3YYk+AWxueD/rb/7AYDk=;
        b=lujCX9abTDojtk7HaQ2yKCpyg3Hce4y8p3/DGqVR/729mxMGTVm3q1TQx5OR+M6ptg
         CJW8YPA9IpMPus7HiwBaLt2P31i6cIEEWUJ9T5srs48uYXfhE/zV0guJMNPF1ER9iv4l
         00jV+8pLy/8zFQ/lhhWwB3xDOjLtUalDqcH9nUYHgwLICdmGQl85WlOBSEKcBMe36ETR
         /cD52JcR4v6O+ztil33Hlgt+zSFulUt1NlQtxbRITvghH6wTQ747u2oLYKSndz83MEPR
         n15Iy8OXvEErVzGA/yYBGoOiwQPLzo/zT3fg+GuHLmRbA+0pgrnFHgK+sZm6ev0YZ/qE
         vUmw==
X-Forwarded-Encrypted: i=1; AFNElJ+hqaXb8wdKtQ7Cfkc301e6FpuiRivkhRdK0t5DpJmXO7YdeTpN3C7tsgKPh7WNbud4LZ02bVkySBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxD/Oi6IUN+1nZUJXS9VBxhQB+7pFdgJjaXdBdEux2na92AfSul
	5H5tZAHA1ltxNxyAaDIcXvlI7c8oxxyp7lvyjRLPA9yy68jX+u81dlTlV4epRw==
X-Gm-Gg: AfdE7cnDwhyVKL1vYTW9wWHpCPiAbvJHJzUmmXt06LZRcMZgK/sDSDk3M8LQoGsVQMc
	t736bZuFhR+RQTumr4ldhh2H7aNfTrQv/LLariV7XGSZtI6nNkDbf7TmBmBFVzIen5lf7A4AZLW
	frH8/f2pQ5CyJTphJ8Nqj8HzO+jFijkyqldkemQRCrAlYGTzmErmxDW/0vjFuQtRRT5p2SEbTAi
	Z6fvdBWKI7YJk6OJbIeONtE9ufy+lsEan8WWEB7LaNOvnWpJr5mgHf0G1Ql98gxvb9vmnzPbTul
	CzTtW15IMHx8lEGOMoT6GajWa8Ctwvw8bUQJi4nLpsuG2SSChQQfdfHNoRcXiVoBPdx/Fxea8wp
	wYSmAhqrH7EdTb8ByR8XJyAlNhLipQc0EbL1Q7K3Y8LssxC+UJxjOpckhGygbYi9eSwmArhsKqa
	az9ZW8RIfqzmLxaYMCeIK/65xndcSOtZaI+rD+/w+P57j/oX7U
X-Received: by 2002:a05:600c:5287:b0:490:b26c:64ad with SMTP id 5b1f17b1804b1-4925a0a775dmr1408305e9.5.1782143783713;
        Mon, 22 Jun 2026 08:56:23 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:fdf9:c68d:5fce:b1ef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923ff8a9e3sm331778025e9.14.2026.06.22.08.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 08:56:23 -0700 (PDT)
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
Subject: [PATCH v18 09/12] mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
Date: Mon, 22 Jun 2026 16:56:00 +0100
Message-ID: <20260622155610.184271-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622155610.184271-1-biju.das.jz@bp.renesas.com>
References: <20260622155610.184271-1-biju.das.jz@bp.renesas.com>
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
v17->v18:
 * No change.
v1->v17:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h      | 1 +
 drivers/mmc/host/renesas_sdhi_core.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 9ac5cb25ee98..9d5e591ef2f5 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -106,6 +106,7 @@ struct renesas_sdhi {
 	struct regulator_dev *rdev;
 
 	unsigned int divider;
+	u32 cache_sd_status;
 };
 
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 8e14ce3ca7ba..f77985d305c0 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1391,6 +1391,9 @@ int renesas_sdhi_suspend(struct device *dev)
 	};
 	int ret;
 
+	if (priv->rdev)
+		priv->cache_sd_status = sd_ctrl_read32(host, CTL_SD_STATUS);
+
 	ret = pm_runtime_force_suspend(dev);
 	if (ret)
 		return ret;
@@ -1422,6 +1425,9 @@ int renesas_sdhi_resume(struct device *dev)
 	if (ret)
 		reset_control_bulk_assert(ARRAY_SIZE(resets), resets);
 
+	if (priv->rdev)
+		sd_ctrl_write32(host, CTL_SD_STATUS, priv->cache_sd_status);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_resume);
-- 
2.43.0

