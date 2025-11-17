Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2595326D65
	for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374377; cv=none; b=K7rXRghymcYK9HOwdUDPaoOg0059ib/uom2W4NnpcGnB713zgKhfwJjWSZMNAkYWHeMmvEC7MtngmIcza0W4Yu9/HIs6nz4eJ6R3WMsZIBwueGzLHqKgusfzIJLQoIyTe3WRJgA3pvxxtA/0wC8LcIAIhA4lObJdz5awvarS9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374377; c=relaxed/simple;
	bh=7RSvUg07B051gI8sV9lF8JjJS0uQZ25LyvxGhWGnduk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wh2xkAPr8Hc578DQOUyANHlxvCUWPBMKepR4RqLwpAn1pydKbAM9LLPTGWlqIBq1jUywpkjwThF+f2DkpJjSu8vHaqo7LFvvn9bHmXTXQBaUVYyTqWSzxiOW0hiBmIc9NHEUTrYRkShhkJSjja/j4FzQNQSsraW+sogFrSxFTOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MwZ5N0Xf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MwZ5N0Xf"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso18352115e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 02:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763374373; x=1763979173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6Y4uKk4uuv0qQmAW/uNPWxDPdMDZQqesObvwQQomkI=;
        b=MwZ5N0XfJn9A+LWg5TglrO+5CHtX+P9gY52T8Yk/B78PMEuZ89HRcKOXHSnjSHv0Is
         YfqmToqGzzL+V72kBCmlBdMCNatSz845ctUCsZHnAXq0cdC+Kk0Q3s6BbLna16GRBdi0
         7jLiZDVcjhGRr9rq381ONopu72ob1l3okaaInTQHSD4XFAw4CE8JZHW322CsfslZSd2G
         b67ToiuOfDAuSofBwRtX+lzlwJQQ6+ePi9lRGwGOp5uIlzCkzmpoRf6MWNdh6v0CwNTh
         P+JTzGNjXRYmVOjSWH+mMw1NaTl3D8ZoW9SJXTm4oOduRPOZToae5/LZjE6cxbkBPJ2h
         s2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763374373; x=1763979173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6Y4uKk4uuv0qQmAW/uNPWxDPdMDZQqesObvwQQomkI=;
        b=qRaNH0ZemEtGnvcrKBz/7nO/HpPlGZK+3HS9CrZIZUxPIjJynv/aHi/ybkGH1tCGdj
         +j6BiCjd8VIIAHhQsHqIyVKUMm9k02J2OJsICvAKk7uqwzGhPSzU9XDx4zdSQWVLForO
         n6dtnL1SN+i00boHLRcSRuXJedArFC5JFaz9r3OFnggUqvHIagL1FFQ4jIbkBkGUvOnc
         7J6XOkyDgnsQ9I7LmeXjOLltb/Na4pBLhXqusMfbYDosUHiXgzQw8MbAqgssKFvQbwSx
         YstWtCx5LhkReEdC1lOusnNc0Fzh6oAo98zWj0sQtIDQjU41WXjkqpHTFAol37wn0Kp2
         13zA==
X-Forwarded-Encrypted: i=1; AJvYcCUy7KOQfYVqBXbMQ4tTLzKNViAGdKz03mYmmOD79AorTl7BDiYXVsFB8A7JbYsNjVIjYEMBG6IinkA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG9u6XM92f/+Y9hvX/gfuRKWhaMRYcyFomRfP5E0XOLLHT6ru+
	talbim3n5PMghsSCOhgXT7Sw9/RJPRZJ1sIXxjouxwkyJnB7uxqK607NRkUyjD5JMpc=
X-Gm-Gg: ASbGncvl5uTqy6/isgqb9R3o46EwdEdqRayLrAyhP/Yg+9V9dNe77xvcZlP05bRiRnP
	/HkvE4Tc74hqht9h8sxuxIJTlX/p+hWmE99u7j4mkpa46JHU3JYFNB7ZmMDZt0rCDsbxb+flTZ7
	VK18imZh3xQHyL2WTJqSNPs1L0hbWlJ6UIJ+JrESBD8TRMb93/Lxgk7VS6Qf3/bR/DVlvi1Mhuu
	9fGdzeoElMh3dz5SfFV8xEgzfYa7M1bsGl2Cn+Zaj1mjwEZUj/S8r/+PqlXyHUHJu5JKDU7VApE
	ZFsJqGEK5mDQLRKwArdOCdNN69lFqT2iTqK1y3CobUrpOd8XKwlZIgPP+KvUbqy4QX6YBPtb/NR
	24QcnJG7rCrrhJfX2C66Y8lH4lKhzUvld4unpPhW9uAoHhPsgXBa+Z8X0c+ariN2oTNBlv9R0Qx
	Z7QxY+UtsFmwPdu4glCPzA2fiO5panKQ==
X-Google-Smtp-Source: AGHT+IFFRowjM4rREb/274yZWIOOnY5X22zM8BYH6Kif2+IeH9srIQ869aWcEjTvttZZrUzgfTu6Pg==
X-Received: by 2002:a05:600c:8b22:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-4778fe553a5mr108959175e9.7.1763374373104;
        Mon, 17 Nov 2025 02:12:53 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f203afsm25806958f8f.39.2025.11.17.02.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:12:52 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	geert@linux-m68k.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 3/3] mmc: renesas_sdhi: Add suspend/resume hooks
Date: Mon, 17 Nov 2025 12:12:42 +0200
Message-ID: <20251117101242.4018208-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117101242.4018208-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251117101242.4018208-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add suspend/resume hooks which assert/deassert the reset signals, along
with forcing runtime suspend/resume. This allows using the driver in
scenarios where the resume is done with the help of bootloader and the
bootloader disables the SDHI clocks, resets, IRQs before passing execution
to Linux.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/mmc/host/renesas_sdhi.h               |  3 ++
 drivers/mmc/host/renesas_sdhi_core.c          | 37 +++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c |  3 +-
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index 084964cecf9d..afc36a407c2c 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -9,6 +9,7 @@
 #ifndef RENESAS_SDHI_H
 #define RENESAS_SDHI_H
 
+#include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <linux/platform_device.h>
 #include <linux/workqueue.h>
@@ -107,4 +108,6 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct renesas_sdhi_of_data *of_data,
 		       const struct renesas_sdhi_quirks *quirks);
 void renesas_sdhi_remove(struct platform_device *pdev);
+int renesas_sdhi_suspend(struct device *dev);
+int renesas_sdhi_resume(struct device *dev);
 #endif
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index c4aaf534868c..2a310a145785 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -31,6 +31,7 @@
 #include <linux/platform_data/tmio.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/pm_runtime.h>
 #include <linux/regulator/consumer.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/of_regulator.h>
@@ -1317,5 +1318,41 @@ void renesas_sdhi_remove(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(renesas_sdhi_remove);
 
+int renesas_sdhi_suspend(struct device *dev)
+{
+	struct tmio_mmc_host *host = dev_get_drvdata(dev);
+	struct renesas_sdhi *priv = host_to_priv(host);
+	int ret;
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret)
+		return ret;
+
+	ret = reset_control_assert(priv->rstc);
+	if (ret)
+		pm_runtime_force_resume(dev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(renesas_sdhi_suspend);
+
+int renesas_sdhi_resume(struct device *dev)
+{
+	struct tmio_mmc_host *host = dev_get_drvdata(dev);
+	struct renesas_sdhi *priv = host_to_priv(host);
+	int ret;
+
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		reset_control_assert(priv->rstc);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(renesas_sdhi_resume);
+
 MODULE_DESCRIPTION("Renesas SDHI core driver");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index ef06c3a60ae8..f6ebb7bc7ede 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -18,7 +18,6 @@
 #include <linux/pagemap.h>
 #include <linux/platform_data/tmio.h>
 #include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
 #include <linux/scatterlist.h>
 #include <linux/sys_soc.h>
 
@@ -600,7 +599,7 @@ static int renesas_sdhi_internal_dmac_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops renesas_sdhi_internal_dmac_dev_pm_ops = {
-	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	SYSTEM_SLEEP_PM_OPS(renesas_sdhi_suspend, renesas_sdhi_resume)
 	RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
 		       tmio_mmc_host_runtime_resume,
 		       NULL)
-- 
2.43.0

