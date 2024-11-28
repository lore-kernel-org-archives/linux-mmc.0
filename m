Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C667383CC1
	for <linux-mmc@vger.kernel.org>; Thu, 28 Nov 2024 07:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732780310; cv=none; b=J3D9PYAGmf1Rhp2G1DtpwNtx53Dk/qb+ZY2J13WPXobk+jmiVaoYEN72BSkxyvz2LlAS+1DBqfqwEI76X1ADTyLNFuUQsLVMv3ZrKYdGdiwZ+3ZJtGaqWdbN4weipK2Ub+DMSLCrlogBj4ylQ5KVdTw5oeatJj+rNybQnYKXet8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732780310; c=relaxed/simple;
	bh=2ifAjsNfj5quiMLAXZbu7bKWX5+oDSQMp641j2j1fKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D1rUd7nlJZ5DoJQk0f0Y+HGF5gUBgP+P2GiiUu0agG18IPPoExxR7rFaact0ehiGLhiHY0mphTKZMo2mk6GYMfEAgZe54mYj4bsAtXK3NxDYaSGUV6OU25hsKi9EcYMLlvmgnyipW5xANua2c8PvLy9JAtEto+iFYNWo3GEgEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=A/v9YxaY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="A/v9YxaY"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7250844b0ecso577743b3a.1
        for <linux-mmc@vger.kernel.org>; Wed, 27 Nov 2024 23:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1732780307; x=1733385107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=22j0oUmAKERuJUfLHrozCyDWy7LxVKjI8m8X5sJfa1U=;
        b=A/v9YxaY1fn2lqg5I8h+1SnE3vvGRk/K9NmssEs5aZOoE/TipywE8OJQ7oAYcuwDyn
         gWzqEmTULeBrpSeOEnOSSAehz2NcR+9dZFZzaerNbCAlAl0UlHAaYYdlejcMexLlQuNp
         kwLEjbV3kfzjWFjjnttWKUBbgmcXQT3muneYLyjOP1H17hd0Zu7pIooPcJ46S9xAYN3w
         oU++wScNS07BzBlMoqd6Ab2yDh+P+OF/1kPNlCryYZ7eHjqGIxXgIee9yIGTJ2iYKUW/
         lwgL8fJLZNFbPhTIcxaqqa4EYcoGZ1j2/fSezrx2Gd4LCBK6khsucipPhXvwtuMfD3SK
         rRzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732780307; x=1733385107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22j0oUmAKERuJUfLHrozCyDWy7LxVKjI8m8X5sJfa1U=;
        b=BYZFNtZo9cn9rHAFV1WD8o8Wzf6+PTP11PzdyZsphZxknx1y0yvxDMiKMJo1qHjq6j
         M5Z6yyMZXzsZ8ZvPek9n9JwuaDBffjBN/Wl0iVqmfE4FXUG0x1Rs55Sds60WEiP2Fscf
         e4rYtFTJh9ZfwpwQXvmi4qy6Dgsu9jpdwF01QcxQ1VM0zWjkIkOK9tlfjywmK+6ZyNUO
         Mzf1AEMfALP4RfGm1ClYEX6CNMJL+1FH7+mdisYtzAt2AgqMvob17CIgUOoy7qyg7Zn7
         6rk7g2ySwUKy9qCnYytv4AZmzKykXave+Whocxdn6PfeaKy/lC73edPzpNyOBanqrh9x
         3sHQ==
X-Gm-Message-State: AOJu0YyHlCoP8F+Qaer85bhS7S3jCiGXMIPUyNCg4Ndu7bzavQUfU9/y
	943nO7O79AsWjLZSZ7c766LOV5LaGbd0i440+JBQ8fYrFjGeW3WEs4oh6HqetA4=
X-Gm-Gg: ASbGncvM3BwT0RinzAm9C8ANw0oCmtA/F8EBOS9M5R7rCaBNVlEO0In+SGu3xUhTFRH
	Y4WJwpNPKppW8s1bBkSn4DnHj2jF5RaTR1E38tcMfnRxMJ7snKVzApKXgvJjU2AugxVNvFADdy5
	TSud3L27ZkSMirI9VwMofUIkVBE3BndBUlSG0jsgcCnBd8hDUY0lfaxAsKlc2VjfW5QkbFmS+5S
	aMOX80+5SQScR8LpoBsx7DBz4wD+5I/XjOKd3hx91z7eYH0gBu3A7ZIm2JRGBilAC8S9FLVnO49
	7CA+D/I2MuH+lp/ykS5yZUN8zw7zSvHzIWWb
X-Google-Smtp-Source: AGHT+IHvEMlIEXasoIr5T+VeTy65zrOrbvBdZXtkivKNIVTD/3EAIztL42etlTl86zG/s3UC7LPx7Q==
X-Received: by 2002:a17:902:fc47:b0:20c:6bff:fcae with SMTP id d9443c01a7336-21501095f5fmr79589245ad.5.1732780307059;
        Wed, 27 Nov 2024 23:51:47 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21521982d08sm7503575ad.194.2024.11.27.23.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 23:51:46 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: chaotian.jing@mediatek.com,
	ulf.hansson@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-mmc@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] mmc: mtk-sd: call device_init_wakeup(&pdev->dev, false) on the error path of .probe()
Date: Thu, 28 Nov 2024 16:51:37 +0900
Message-Id: <20241128075137.2958211-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation leaves pdev->dev as a wakeup source. Add a
device_init_wakeup(&pdev->dev, false) call in the error path of the
.probe() function.

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Fixes: 527f36f5efa4 ("mmc: mediatek: add support for SDIO eint wakup IRQ")
---
 drivers/mmc/host/mtk-sd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index efb0d2d5716b..9c3cef4cf47e 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -3070,6 +3070,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 	msdc_gate_clock(host);
 	platform_set_drvdata(pdev, NULL);
 release_mem:
+	device_init_wakeup(&pdev->dev, false);
 	if (host->dma.gpd)
 		dma_free_coherent(&pdev->dev,
 			2 * sizeof(struct mt_gpdma_desc),
-- 
2.34.1

