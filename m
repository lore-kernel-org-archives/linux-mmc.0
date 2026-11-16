Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794855164;
	b=mmfG3fea7J5j6r+3DOUf33xLSlu9MHjnak0BvVc1EkywEb7kKsjd/OuxVMJPHH9fCS50
	 WtKMsbLrDe96K83ZdHqiyrFp6tdnNMPt/YYTXeNV2uvqFkRxtSvpd3mD9Otyjd8NbfTrb
	 KO8sCP8j9TtXUpNGOf320i3BTI7yxjUagLSkUJh16VWIA+if7TT2+nByD9sWXq901OBry
	 wS+JkkqZCKtPxxfy8x89XcJtKws7sizIh9OsthO5+EIw0ue9zASWriP8g6e7D0dGAlZVk
	 JNp9afALBe+7x3IyJ6MXx3kxUeidXUwxxJWjD7UEafDxyTMBko2d6LkyNnuFLBePOaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855164;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=+dkEPDVy0VHptq+I/g6JYGM++xkWiF4W9qF7n02UaTc=;
	b=qDJeDX6tdZhL6v6GfqWe12gTfQICBaRGzoCY1OqDBZ7UlVXCYGQUJ4u9xiP7DljqU+xX
	 s/SUBh/iT9VIDBBeeTXzs5Po8Rhu5va0Sc0hWhoSweSr4zSqJGwqKPXLwtRrq6hwHxGFY
	 RrlOAyJh0xA6RzM0KnmzGGPbUfO3bOLE5dMzTTrxDDBkosYu6HudlL/g3BR8YjFQdFxUa
	 aJq57skj9N2PJtaYvTLP4Vyuw2et5vKJF8513Z6S6CtdH1Ab8Z9/kpf39jZ3UYqAdmZK3
	 ISfgCVkuZkzEXJN7oiJMf0DISc4r57PZEXAlMaTwPjCx/2qIcThKWTeivRdn4D02eFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=je3WgVDS;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0E7606A339
	for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 18:52:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D0E7606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=je3WgVDS
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4a358881793so121026f8f.0
        for <linux-mmc@vger.kernel.org>; Mon, 16 Nov 2026 10:52:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794855162; x=1795459962; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+dkEPDVy0VHptq+I/g6JYGM++xkWiF4W9qF7n02UaTc=;
        b=je3WgVDSzPP+yBl/FMyb5Ls3+qgwG4uKtiS8DhxigkQc1CiUz+8iqXekwQC9Nqc/Ly
         J2Bh18ffkWFwmRFKjBu7wWkzXLqG284ER6IKGK+u4vi7odV1Jh4XWOGhF3bVN7DxOtRV
         ybyhbxyMtoWl+Z+TxjjkNYt1EjFPWXSfkdlwmMZOqUtCjLv2/8YTei5FAlLJyz9bR2bd
         ylSgkZc5DR/x5odsUu9sBA25XDkTZz0iFRPz0HrZeiMfFRXw/6dGdXbIsVazO55fxJRu
         6f7WRlvGUBS3C+Rm06LrcaX2MC7JBL4/YyH8w6ihqgS+1WMhP/R9HLEprti2QkINEJ+4
         17Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855162; x=1795459962;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+dkEPDVy0VHptq+I/g6JYGM++xkWiF4W9qF7n02UaTc=;
        b=2BY2cixbupt7il+/78Naem7aGOlZGZ0sEzNyNn07oKIF8u6OM4vV8yxdvzG4ECwtmE
         uRQ7FwW6GzT4brL+dNHUZ43Q0YNGZq4LofSVjpptk9/xw7Gwr4s3QYs2n94PjUQTYWvc
         A5rAvgAwZgz9dDz5IuCL/vCsQAfT+39JHBilryKN0j5srHDoy9ZQ21qYliIIponVf1AL
         +IkwVQplbprbahvojYapaCY7QFZ8xyKuQnestySRMLYDtR5H25yLHgzkZCjh5euFimfg
         0JgdHc7ivJkJeNs5oI07sQaIALKFU8QTqOboSD7hJq04NMdlSkM8baKe28HToYQIMtwg
         etIg==
X-Gm-Message-State: APuU4Z+JZwKS+ZrkAne3/wr40XLi07RItDA6Br+ITdVFhmMOGGo4JxS+
	bzBxOd0sFjchfOVzjm+diMq/DHTpevNYHXLuxyoIXTe8bSNI0n9OCfFN
X-Gm-Gg: AYBFou3U2h0HGbOYCXRHvNQXG1vTCh2O2w/K/XJ4JDNUP4QDz0qa74+M/9RrF6Zm2H9
	rHgm/kEZ9rVps++pKGw8/gub3YjvYd/2568QptkTm07rLC/Htj5Aa3oWyKYv2qM3bpMXc1qX4O4
	zRkukKdonDdIB/kkdRkfPLv8ba0U3WF0yFHk1URG1lZfISGZ4rSvnrvEaNFWTzQch1qST5su3/9
	V43u04k+C29JDCkSn2IUkYP0tRRworELpZhntGKV5cRl4pFgtHQNUqqFco3b5Kpo3sqLJRdFRIr
	RV4n9GJUvLD3K+jCUdaJmWx3K7amqqH/T49eAvuJulocX/QmOipH6dwR2r1+P/5976oFBs6dMyw
	63vqjjXGY9dwHa6IGqU2xL/1mbSIz78aSNiVH5+kN0laWdYT54Zbi5jGenhXSI5w3zz+91y2p5/
	exavYdx5eOT/PJRAMiU2YmojR7BoNSkL7IAFqiBv4OVI4s3+L7tpGD4ZiN1tmAjZqFPznFVCXZK
	XTuOz3jxJrFFFWil58rHsshqyLVrCoiKWjq6wOsC3SdwUNwi9u+sboY/TvHGRBfn/1R3u+cpaIE
	i6CjQS/CxaO0U+QNBv+ooLUgrCJwbIRwhCS8n+1rS23dQGteDA/bnYz9N2JG1+qyMQ==
X-Received: by 2002:a05:600c:8716:b0:4bb:6847:791f with SMTP id 5b1f17b1804b1-4bb68477becmr153891005e9.7.1794855161517;
        Mon, 16 Nov 2026 10:52:41 -0800 (PST)
Received: from [127.0.1.1] ([2a00:23c4:a702:d301:6889:eb24:5e57:83b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5720f6basm157961345e9.4.2026.11.16.10.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 10:52:41 -0800 (PST)
From: Biju Das <biju.das.au@gmail.com>
Date: Mon, 16 Nov 2026 18:52:39 +0000
Subject: [PATCH v2 1/3] mmc: renesas_sdhi: Save and restore IOVS across
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
Message-Id: <20261116-sdhi_hs400-v2-1-de41f7a7f330@bp.renesas.com>
References: <20261116-sdhi_hs400-v2-0-de41f7a7f330@bp.renesas.com>
In-Reply-To: <20261116-sdhi_hs400-v2-0-de41f7a7f330@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794855160; l=2510;
 i=biju.das.jz@bp.renesas.com; s=20261020; h=from:subject:message-id;
 bh=72pqcPIdoyFJ2Xiah39zI/T9p3oP+0sAL771H/Z26kQ=;
 b=wV2z4bmLlPvfIXA5O3yDQNxl/F2i0z1To8NyO+nf8XHyuNtIPuzzvtbuWwYqVlZBLcXJHXobJ
 kU7geJiQPgaBnivDoZx+xHwfaODHgMsKpzLl5akbKFG/FOS8dcMXYVi
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
v1->v2:
 * Added fixes tag
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

