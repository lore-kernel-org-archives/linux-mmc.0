Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2E517555
	for <linux-mmc@vger.kernel.org>; Tue,  3 Dec 2024 02:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193292; cv=none; b=Z8XA6YYY3I1YRa8og3DxnSx7Y2LnV6MLrpHkD9uEuyySiDRvbmEJ/CJmFx15lchDreFh59gXtqx0cnNwlv056WXtuDVdxMHYsd6enh1XOe7JnHh9FV4fpSrzMd/NHkKy0vwfrz3z68l6kbxAcbJSOS6uyX0LJdmY1mVkJs5IIZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193292; c=relaxed/simple;
	bh=KBno4d8Ri+5bkwhp+O4ZEaiQGH972Po1Uth8RjIikC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ekr6gyqP3pSnnbzY/2pJ9TuCrXVAjqyA7ol7eL5bUBi7yot72AermbhwbmdjfzzRTJG85LnlwsNS1kdTZiTHsAwBLS7oEuE9Ev/h+pHyK0RjDP7+h+cQW89k5nn2bnt5gCflyFtppNyMvJ8v62Uuk7QQgnUan9oXOqF7wyOZs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=MNZ/399d; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="MNZ/399d"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7251731d2b9so4300696b3a.1
        for <linux-mmc@vger.kernel.org>; Mon, 02 Dec 2024 18:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1733193289; x=1733798089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EnDwsulVaqZ2+plQwC8BxEf/6u08wgORMIoqPSHcn30=;
        b=MNZ/399dv6K3x2W+rRHFv/lqlA7r8CZjA3gTW4Q+Kj8fzTvGWQFCa36ZSfqvjX7tWh
         qRCTGyFfqQzGsBBIQR8XpE1xPm+Sq3oDLWxcUfP4cZjoMsUPVHkSf4/KR1aDb5G03w5E
         d767LgeIh+J2eJyxv6KTEsYx6XsFxtj5/sDVGOI0HdtDvZBVdXs+J+CK7bgCutlOPluh
         nAnSG2U86KioZDbVJMHNvuXbzdPYR9FkK5CxLKss1iQ9ZnzEIR7uRJK18r600CuOMDrE
         1R8UawYXTI/t9X50xDNC95P9CpitjqdzxMj1kcIcAM+bcrQty+1FntX0Zh86nnjj8UUK
         Mz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733193289; x=1733798089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EnDwsulVaqZ2+plQwC8BxEf/6u08wgORMIoqPSHcn30=;
        b=ttN0xIR6e44wcmJHRcbjtDajb0J2MiU2AjJ9HckDthz5awqj55xrgVbODZgsruKXwl
         vNRzGGffiT2yrB07bg/H4D43ARQpQjYCdtWCIZ/S85e836vY+aFjApafHSgrFL6l9g3E
         1ECBscW/nrVnjUiZnoKjRN0YlwH7iG+thB5unH98pjH627c5mI1zpMDKsYc6DlQ2Tdy9
         4AawslkKqemtWarUQuwZYn16L6p5ozpFbP/KqPXUjkrfMIdS/pXmfHmXvndB1b7OAidc
         sqec4avH3QzR0qNZx+AjJ7la5lNi9apOJsEVeYnyyOwdfYDbTpEMhSC4XDrIAfM5Zmsk
         Ss8w==
X-Gm-Message-State: AOJu0YyP+vuvyVkfbosp0Z5kj6wuN0aXEaMlhKyuvviz9kWDz2r91Bt3
	5EHCfXh/wzlPkIFcL1+fWCa7weAa2Ti51p9PZgd/zbkPfJtjN/C7W0K1sV1V62VtHpPKLzZIQfY
	6yJQ=
X-Gm-Gg: ASbGnculdp4qrXHJs4Xj9A5rBnibgTbQJkJtP+BKk7NyNX1WgXKaN4v66J2Aj2xia5A
	0U15fw2/kaxGfNsBzuQ1k8upOlWGCAcIVZLlgDnCnoZXCZHHQoj0Tq3AXZ7QePHPE++92x3/eIt
	LkKkDtfX0z+zcCDLHzHnWAtWQUNciOWGC3S6Cqb2D7fpaE1Nm+Tx4MBxtXKliQVn7zzF377bxA3
	10W8fjIJvPopY6sHLBQeb7ZJh2D8/djRdu2Yuf/OCnGFGhgWF/uGmDWIYisPpxltPda5VbD
X-Google-Smtp-Source: AGHT+IH0HNujKfslbwrocINWD/369RBD2eagU2fRKGDXsab0sv89K4a8AuKKpwpSvNia79ScwPzlXA==
X-Received: by 2002:a17:902:f610:b0:215:bd3e:613b with SMTP id d9443c01a7336-215bd3e62bfmr13633125ad.27.1733193289402;
        Mon, 02 Dec 2024 18:34:49 -0800 (PST)
Received: from localhost.localdomain ([2001:f70:39c0:3a00:f2b3:fe35:a658:80a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2157432818bsm38369785ad.154.2024.12.02.18.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 18:34:48 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: chaotian.jing@mediatek.com,
	ulf.hansson@linaro.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com
Cc: linux-mmc@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2] mmc: mtk-sd: disable wakeup in .remove() and in the error path of .probe()
Date: Tue,  3 Dec 2024 11:34:42 +0900
Message-Id: <20241203023442.2434018-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation leaves pdev->dev as a wakeup source. Add a
device_init_wakeup(&pdev->dev, false) call in the .remove() function and
in the error path of the .probe() function.

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Fixes: 527f36f5efa4 ("mmc: mediatek: add support for SDIO eint wakup IRQ")
---
 drivers/mmc/host/mtk-sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index efb0d2d5716b..af445d3f8e2a 100644
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
@@ -3103,6 +3104,7 @@ static void msdc_drv_remove(struct platform_device *pdev)
 			host->dma.gpd, host->dma.gpd_addr);
 	dma_free_coherent(&pdev->dev, MAX_BD_NUM * sizeof(struct mt_bdma_desc),
 			  host->dma.bd, host->dma.bd_addr);
+	device_init_wakeup(&pdev->dev, false);
 }
 
 static void msdc_save_reg(struct msdc_host *host)
-- 
2.34.1

