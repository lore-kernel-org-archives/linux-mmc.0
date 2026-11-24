Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537884;
	b=Obs7O2BKxngMYsgUz8DBWZf3qccdTNvI3rJx/kXhwKOt6Eg+v2JdkV4US5XmmXewNLlb
	 qbmmRa1iEe2fZujCLqX+MgkkrP4dVyY+7fB5KCaXRwIVFfed+Q8grXj6164yicZbEtD0M
	 I4BYKhH+iXHbUleiZx7h1JaRonJPQ/uweJKH/O1DSi+Zlx8X1dIB0L9+SvodLMwDdY69p
	 unbDeQy+OzQeBkCK/Iemx3wPiKoinD9+7fyR9F7oFaCJoQLkB1UkwcXfAMQsdAvijURlk
	 1EN2H6F6FdR0r8TusPSEQRL5321k4VtOKVt/H733D/jjgrHa2cx8R0cfc9+Y1JOzYrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537884;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=hOIc5kjFGDJgz1H1COlV5xHNmspoYVPspyVBpPnRxGQ=;
	b=tBRMwrOz0nYHlZJFTFtkjbItrXCriZ/0SmkYp9/hMdLkdh7R5P1P01Q9cPDRr7OmYJPZ
	 Nmq0IGLPowPGR0d8ZfTO3411Si0Hou697OdOyQiljdM1sqxu1jlQs+Tm7jUcZMyV5PUr4
	 ZUEiplFD4NK8JCQuX/a5ahdQW9GTsFiu9FZlUChxWeO3vjnE92Yw9jmoi+Q+Lqs9vowLo
	 hqin5j+G/lrp69YnyKEeSpRChoiXJeXWxHAlcKzH4FPEOyf6zG89TDPVKHW7ai79mXjEN
	 Wl4tBG5NZO+6OeUJCPWUU+ze1md6P5rVHnctdRIirPViuma6LhZthPvfk4DGc8Rxkig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="LO/10Qmz";
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF367606A339
	for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 16:31:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF367606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LO/10Qmz
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-492f0a1b685so3261310f8f.0
        for <linux-mmc@vger.kernel.org>; Tue, 24 Nov 2026 08:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795537882; x=1796142682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hOIc5kjFGDJgz1H1COlV5xHNmspoYVPspyVBpPnRxGQ=;
        b=LO/10QmzbMJOWlxbUU6wBuAq18RVMV7yVnrusuFonIgvjZ5F/JZ6fyv0rlQZ8wJZw8
         /LC2lv8BGgt9gUrxXRwMO/7kOMJpJsajeFE9DHp1Wsg678U8tsI4j3Bg22LSiDro4+l1
         pWR1FvangA3SP4W8BNqlaFjcQ6A2nDX5dF4sPcCu+sQ4T/26EYHE4F5ThMM5XgO0yA6L
         F+NBTXExgLltLguJ3b9yAhNVi8D/t1YKGTuFK7BWlwdwKITV1bUn6qkjbyQMxNHCfPzc
         fZeIhKAl+pFhBVx3DdMfjIvc+/UMXcj7cFfCCJCFV6JU3MxBNm0fIfAUlKVMmKSpNvaC
         dkxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795537882; x=1796142682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hOIc5kjFGDJgz1H1COlV5xHNmspoYVPspyVBpPnRxGQ=;
        b=QdADlm/Scg/zc+4WC38ACZhijCoPHjh3rXqs/82yWY8j2gqgkBsSI4/8atFbcMGAQx
         Z1kXToqwmMXpKQC4vNk07+O+M2W4fJPMR/WDZMF6Cn9eJo9ZYoLOd18vJK33AVaIA2yC
         Cc5uw0Wru3VbSdrwlqjAHcI3o2ygDdi/tnZI5y96gRTs8DkZRDPol3qOzsaG70V9O5nF
         WtcWcZGmLGy/5j6ZybIhwDkOyOd5Fayqz8H6WJrqjLizSlt35ehLwLbqXYnj3g2L+4Dj
         cW3sPknVp8IxhzX+zPJUwVFggYGbRGoV2sQk4jexelN2WFE0WTlkUnGy47+E1fnL+67v
         L3mQ==
X-Gm-Message-State: APuU4Z86k8cQmDMYMMswSvUt56aDO4St8fu7aGRkYmf5BU3BvlWvTsND
	1m3C23zyQekaAceL4vrkKgxaBcoGrQmQV4zVBGwS81SqZDr6Hhf6izJa
X-Gm-Gg: AZFdTZeglLr49mIQoU10I0KCfdKyyeodhgZ9FAM2h/+w6b87BPAUPkYJjXwKGs2YUuV
	xXBSmfhiTTsHqfDFdDLfWnI2MiiFUNT9mFzkh3SZar4gGImcTJiJ9kmMIrJCHl3kXhr4bArqmlK
	SM4KMU7Vz/LmZlCchzS1T+lf9QqFv+XSa2TIiDjeChqt6qOJZKejJAJiZFtuVlgYLpaq363rXOR
	QGmJHWbHnrCyJ0+CA55KZwdUIEJbbuojUXjmcPed5nj8SS1VB6AM4W0zzlUE1aTy7rU9YBHDUmF
	BpA/S1Vo+1pDFV/VtARJHIvW8JYEx+3OKOTA1iPMAiWQqzYSZ0kyF+KzuhaymwqVWHrxxPlrZtz
	aNsEdIzEJpsuVvttuD5Frtb+1xIhBmL6Pq2CpuYUm0wQa0lLCG/TqodIPJM9fvZPLcCO+r0kyXJ
	OrU0Ua/ZHae7Nby8oAWLQPN6JkZS0q1IGGUKgWxYx2V6/s8GZqkhlQ1vRXGoeLypVLbA9FG9l32
	9AQXbOMUle0eFK6tc0fhKxA5qq06kBd/1SmKGtrozMy6MU23sKbxWTrBQj4FMqChknI4xTTP7fk
	/Y9KA4uKZFSWGhL1kLMOlWZJt7GyCjfcA/BJeTvkI+/jW2rk1uTIgY7XCMA1UHlw7w==
X-Received: by 2002:a05:6000:29d6:b0:493:28c4:331e with SMTP id ffacd0b85a97d-4abb31ae161mr19737972f8f.28.1795537882037;
        Tue, 24 Nov 2026 08:31:22 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:d107:658c:9ded:696c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67fe75sm33058741f8f.24.2026.11.24.08.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 08:31:21 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Date: Tue, 24 Nov 2026 16:31:19 +0000
Subject: [PATCH v4 1/3] mmc: renesas_sdhi: Save and restore IOVS across
 suspend/resume
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-sdhi_hs400-v4-1-df452ccd9bca@bp.renesas.com>
References: <20261124-sdhi_hs400-v4-0-df452ccd9bca@bp.renesas.com>
In-Reply-To: <20261124-sdhi_hs400-v4-0-df452ccd9bca@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795537880; l=2555;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=NNhniuzpGFX1nca5vW4pDZfRZAtHdZfsX1g2gSTvGpQ=;
 b=dBACvf+gLaRjRVNK5ZH/7Y9iHRyWPDVfxjWRzSwE/xYnB95yUePgO1M49y60bDvH7MB4kMpL+
 Wb/iCFWNbT6CvM8GwpmwVwu3xluM7SozAfvV4XppuvliB4Xe1I6YwFn
X-Developer-Key: i=biju.das.jz@bp.renesas.com; a=ed25519;
 pk=yzD2T1OLS3lEYflbk64xhLlxhk75lZ+NoOtkTOqrlVw=

From: Biju Das <biju.das.jz@bp.renesas.com>

The SD_STATUS register, specifically the IOVS (I/O Voltage Switch) bit, is
not automatically restored after a suspend/resume cycle, causing the
regulator to report an incorrect voltage on resume.

Fix this by caching the CTL_SD_STATUS register value in the renesas_sdhi
private struct at suspend time and writing it back during resume. The
whole register is saved and restored, as IOVS shares it with other bits.
The save/restore is only performed when a regulator device (rdev) is
present, as the IOVS bit is only relevant in that context.

Fixes: dcbce328d3a2 ("mmc: renesas_sdhi: Add suspend/resume hooks")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
- No change.
v2->v3:
- No change.
v1->v2:
- Added fixes tag
---
 drivers/mmc/host/renesas_sdhi.h      |  2 ++
 drivers/mmc/host/renesas_sdhi_core.c | 26 +++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 4f8ed1d8efee..a93e613e9821 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -106,6 +106,8 @@ struct renesas_sdhi {
 	struct reset_control *rstc_axim;
 	struct tmio_mmc_host *host;
 	struct regulator_dev *rdev;
+
+	u32 cache_sd_status;
 };
 
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 5e649ef20990..56286431fd2c 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1465,6 +1465,15 @@ int renesas_sdhi_suspend(struct device *dev)
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
@@ -1494,8 +1503,23 @@ int renesas_sdhi_resume(struct device *dev)
 
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

