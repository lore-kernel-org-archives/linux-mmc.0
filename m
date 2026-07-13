Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B13537CD
	for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 17:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965136; cv=none; b=cu0mRWLuUbIxVAx+hDAw8Lpgby1NNDt214wU+iM1bRw4BOSPlBdIcsBU5wC/y4R4IYQUJ4AsfL3oNmtrb9HAToWOiSCwNv5v6C0zUGbnL46Vb3VccoXjws9l+BJJdIu3fCWMmNmNYFkEsLvUOFXkvc/w7dhMtUtiiyMAGydeHeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965136; c=relaxed/simple;
	bh=HbW5N3phPFJJMjdweeAACfoi+lvBLPALP5Jt5/2V3eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=furxzPl6miMq9X8FXJ3VtRRh599epuBGreYTR2JdercYikF6Tp5DcumM+c88soywGP7MN9G+2fse988blpT9AObN+ytEvOlY68LeTens4SYKo14esP7dLaMAfARaQEw8Kx8FcKpQU3/ik/DzAgR6gudqTLFzHDgJY92wor1xsiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5VKFW1r; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5VKFW1r"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-493d92b7db3so1583175e9.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jul 2026 10:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783965130; x=1784569930; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CMabxijrPdjD148L5yvur0WhCfh5+SdQvtGwbs6Bgv0=;
        b=A5VKFW1r0JlBKKKSoeBGgriV5RRByQMUsGOvuT+cy+0mSrDnAB3mT3an73xXs5lU6i
         BtdpGW+nhzmbPOa1Sw9HRi1a5rOWsI0BArD+ZU4ClWUYJN/6tjQoJqePNvwwAcicOohN
         uKoJJrUrOwkvJb80RpfFOz/pyn0Oxv0HOZc39n7Oj6t+IDixbclh/Eu2NIyKW+tUvYYR
         4/kxAAiW8gPCXXRQQje25ziAI7CPK6qCqqVP5pJCQHXwa16dciw/cTHhvGziK87L62mD
         9zoWEaigvvqdF24u+59Lck/KjeQsySbVATk7DfvmnyPPe0Yjq8rCMSDOvlWd+0EpeQZt
         zEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783965130; x=1784569930;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CMabxijrPdjD148L5yvur0WhCfh5+SdQvtGwbs6Bgv0=;
        b=N4X6ky/BEo2Q5/HR+P/iKj6lnG/23HnHIhvtBYtMqmbnLQatN551CvJbN0T4JwmRst
         7YEiDv2GDD7ub5wTtVBTFkFbR1unu3Jh+oDX9lie65f2PrlVuUdzLNdQh3dyTKjVzfr+
         qnat24+4JF1EVUV89e9cuOIySBKL9WMBdhXWqs59lSfkDdrHkQfHB5qVi3qXSFnHPYhB
         8lSa6ycx43o3VqbSLN4vPGMhsWUoneP3afmWLUOEbZxbXOStcbjGQVfUUS6XKzi/vYze
         wfM8mtcvfNZD3/Mtzf8/zTcqbbUk2xvBCIeUbkrJwMxSyaLwJf6gYVDL9r9ZEXfHBfMA
         FHZg==
X-Forwarded-Encrypted: i=1; AHgh+Rou5LHw7Roch9/aFm3GwrUpCu9VTkKHpKHIXblXfwPX05h9HoHzzJMVeWkPluC7IarDIPcnHEsaALM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPTM1N1TN9LIQToReh9EJmXhuSML8w9/NJ/f/Qw9rA2r8SVyJ3
	FUCzur1ZX3XDtqnLtUthSQNLbyDTn56IVXtlGt56dQTzmGvuHGmwZpkS
X-Gm-Gg: AfdE7ck83sEaHJEDGl995P4aYFKTQft2SDwwHy58Ow4eE050q7ss9uUTY8wgpqRqcOa
	myKrBL2Ljz0OOemA4aLbx1xiB+l+fnz4cFLsfYOtIjQ28EXUMsgpL8BwZYXSw+PMRA/BgR1tw97
	VwKi658Qw063Gf6tcACiasLeSJDQibf6ng6PggGQJe8kqXTZFqasA3HF8nvQMfvcmSm8S4WDkWP
	S8M5+f0o/ld6Gr9sebS/g2wvbqX323iH31hh8OnMr5J1IqtYYtWMVACpMOBhvnYd0Hvg790G4st
	Cvya4DdTkBuf09DV3IVFQbgpHtqZmecBfUCvlEci9RsJn8rj3xXSq/f2qh7y86TUVbO5sQyW7ZS
	fAti7+sjjDDXMyT8mgY4KOmyehK3EkTcEtGCveFxHjetvKuwYshVu4lmQdEL+yVyEMZkpESJnHC
	Tim+ODU6MQZrUG7hfRl/15zAr8J1LU/nf7+l4lWw==
X-Received: by 2002:a05:600c:8011:b0:493:c0ec:9a5f with SMTP id 5b1f17b1804b1-493f8818045mr110615525e9.19.1783965130307;
        Mon, 13 Jul 2026 10:52:10 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:c899:4fec:2bdb:b719])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464d6fa7sm1011037f8f.37.2026.07.13.10.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 10:52:10 -0700 (PDT)
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
Subject: [PATCH v20 09/12] mmc: renesas_sdhi: Save and restore IOVS across suspend/resume
Date: Mon, 13 Jul 2026 18:51:50 +0100
Message-ID: <20260713175159.138334-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
References: <20260713175159.138334-1-biju.das.jz@bp.renesas.com>
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
index d46598190004..39d915da6f38 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -104,6 +104,8 @@ struct renesas_sdhi {
 	struct reset_control *rstc_axim;
 	struct tmio_mmc_host *host;
 	struct regulator_dev *rdev;
+
+	u32 cache_sd_status;
 };
 
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 42548f5fa2f4..861fa83b9980 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1403,6 +1403,15 @@ int renesas_sdhi_suspend(struct device *dev)
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
@@ -1432,8 +1441,23 @@ int renesas_sdhi_resume(struct device *dev)
 
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

