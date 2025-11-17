Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3731D75C
	for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763374375; cv=none; b=Z1RvnzkcfbSN6fU6oF9hzKPggoBgi+Z+qsCjCkPQLTjuZOyHaHXyT5rRfqybFpx+2laAwaiVdKBzMqp2f4ecjPOqjjRM2CdL+Uvbq1z+YrpqWKulqaK/4kVu2UwWu/ormlr+QStLDhvJPf0+VZAq84XytouhV7HJ4Iqoe+QcGqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763374375; c=relaxed/simple;
	bh=+QKT/Rg2f4P02LTHnSwMEDGtEvvt3JIbEpU9JM+I3wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hYfKzJCI40LCLfH1nv8PVgR2ti5vnedKeTnBU+oyEg+LthNklRPEHTx1qF5ZUiavR4zYBBjwd0eINPpxtjuKLjs7jjThTK08OpuGxiwOJRBRzqKXUQWLw4IPC6y764pmuJQchFdAsURVSIopn5ZDFWUNsDkoco/Y80GNg+BEWoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=O0P8vykF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="O0P8vykF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4779a4fc95aso9402185e9.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Nov 2025 02:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763374370; x=1763979170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ex+tMUFuY0anS2wKRB4rpwClxxfgy66lMucIP/0+dJM=;
        b=O0P8vykFqyijNX+8PRgwSwVy8SGmTJjERDtSeDYyIqBNVhmn5BQIv855HI/ukaQDUe
         sgzphdHlqfGQuGKff23Fomrkf3ZTZA/oA2ZcvZ8D/QBdtNeHemr2+qwxd4niltEnnwxw
         fBmtExLRUW2Uxh4/Tu1gYSh0tQTE1rUqizXHOLI2G5Sly0ZT/rg2XR3jpyN4Sn830GXV
         YTLvrNgKRZr+47EJ56/pIzAiSKVtkJontZRCIyzu4+BJ9QV+k37//qgEWB5aIWDOaCVn
         2d8eTslM6L/hjXfTrdvNDjI0PRIIj/BmhkjS/Xk6H574/7bzaDNPwL+23gV4fwtjd3Ly
         1SZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763374370; x=1763979170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ex+tMUFuY0anS2wKRB4rpwClxxfgy66lMucIP/0+dJM=;
        b=SBuCJ8y/GoMo/sMT5HV0q8dkzXNaMCJH++8yX7zRo3Dlfb6B5u+NNGYWgHkKqd9VQA
         dGcPL5cLXKWFlFEAVpb+sYy+Gi95TNXWm0qKVFstJyHbZ//8MRLDCTct/hgwrwHTq13Y
         Z5Qlmq279pdSdk7W03PUyC6dHb9UagnCX7EUWnynHe0trgItGI9EWHnioN3uUp8Z6OR9
         WL7Kmn9iwQRVHrAu22YwGLKrK2/eJScBoKD7DBEoXgUfJZuHB7R90cJxb/iqi6tBbK9T
         /M3Oy7MALLXhgJfNLXaZXYFYzhh1PD4Ma4LkipW5qaskDY9hMt39mWCrMH8JaDQmDgXC
         +Oeg==
X-Forwarded-Encrypted: i=1; AJvYcCXi4Zo2aL85ZyUeOqXr4LRohmqOseu7wgMqB45c8ktOn3ZNNSLpuc2xNWSxbnJPODl0CZBKElOJjNU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1om2v7Ux1kSw0JeCNAEHdW2fMH6KI0hz7XuaVr6OowqN3aDSy
	vcu1oqtpko1v70WBFiIpeh/aJsULI9jma1ko+juSdKyw88YeeQg+QlnvayyjvxWQ0hU=
X-Gm-Gg: ASbGncv+vqUxhrtjcs1lQ7EvCSL3NBRjcqXqLwG5sShoYYvdThEKQ83epDFsHqNbraD
	69PjOaSY7Pfv5/8LSL+ji3dm40stM4ebcUhycEpJau2a091ScifUnUjzfPRZaWLEJ0lZX15v9rr
	7VrsFUSYyt2NCaMedADtRnEcXfYFam2X3Tzwo8/ysh3jG6se+gFUwx1vyxUROcCjUxiku8D2Sra
	Y/YzBdv/ygZzJdLU6VymduQLwPalMaNt5a3YQx8wuyb9P0fnGfQnHR1KFbHKn29c2KKFJu7aGHl
	1ljS0s3iTtYuW0wuxOxRKNJuX0SrB5E0XEipfc9ScqJEuscDtyurHysd0jsoQa4A5HAxN/q+sU/
	qCBynV+YxCc4u2F2dciw29qjK4TzCeQhu7WrEO5+C3YBb1/mhKr/QbvxCOC4W3qIY4Q43uxyOHw
	tAkGc0qbbGM3AGe/UMwxHO8SggE0cb6xQ/czvTGRMw
X-Google-Smtp-Source: AGHT+IGT3sI+SDQvPoR+/Dl9yuK/0OOqHu7g4j98kCKQbIXtBdBya/HNJnhQ695H2TFveadrG52AIg==
X-Received: by 2002:a05:6000:200e:b0:429:58f:26f with SMTP id ffacd0b85a97d-42b58dc1eb4mr12029768f8f.24.1763374370366;
        Mon, 17 Nov 2025 02:12:50 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f203afsm25806958f8f.39.2025.11.17.02.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 02:12:49 -0800 (PST)
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
Subject: [PATCH v2 1/3] mmc: renesas_sdhi: Deassert the reset signal on probe
Date: Mon, 17 Nov 2025 12:12:40 +0200
Message-ID: <20251117101242.4018208-2-claudiu.beznea.uj@bp.renesas.com>
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

Deassert the reset signal of the SDHI controller during probe to avoid
relying on the previous bootloaders. Without deasserting the reset signal,
the SDHI controller will not function.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- collected tags

 drivers/mmc/host/renesas_sdhi_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index f56fa2cd208d..c4aaf534868c 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1103,7 +1103,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (IS_ERR(priv->clk_cd))
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk_cd), "cannot get cd clock");
 
-	priv->rstc = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
+	priv->rstc = devm_reset_control_get_optional_exclusive_deasserted(&pdev->dev, NULL);
 	if (IS_ERR(priv->rstc))
 		return PTR_ERR(priv->rstc);
 
-- 
2.43.0

