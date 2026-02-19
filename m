Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FAF1B7F4
	for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 23:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771542995; cv=none; b=Ai+yK7bgzakD/Ko5gsJ3jmAPYLzjnG7t39X23oqn1KwEkdpVgvjA36AsPbTDQHfYccJL06xPj0FEnYUp+USCKqlTMGiIQoAZz7ZSs1smVQUXVWMLA1mWbk4hT2LKQLouxVq2Sxg3v2DYlrfG+hHdvExk1df/zE130Z17do9GEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771542995; c=relaxed/simple;
	bh=4EJuWggC5ynHFxILfFhxbh5SNzmvaoGDjGWGAhL/olg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WvIvGZDcCCoJoMo2Jz/6PCR6BSZ12pXtRFCrrVFrse/u6TZLR+L6Uo/gBVCJpGsJrzCpqAfRjnTb9kCYIziKTlOd9a1Rxs4syid3uJ77zAiblVxV2kMBRKP21PeGAAntnfd2punWCZ/dxrtHitBARNmVRVRM83D+alqrRZvWjaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-40f095f1036so1094716fac.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Feb 2026 15:16:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771542993; x=1772147793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOpRViDdy95oUvtjIbD1yNnLGcXCFi8ZfYmxd9/IW/Q=;
        b=Q5VoXqCXOC1kxX8UhMXRl3BGG1Tcjn55UaK9vK7ZIQiUBfZJX9C3TMebXPTsO70NM5
         xnvjIcEWgB+143v9PcPJlo6P1PBWL2kAZ1Po8dxt+JUyBmaZumrr5uS5XlKPx3m4ZV+i
         cgXG0TmTXElSO5B3wuWUMETSxqQuiYO0uU4xWbZrKYFyAPZl5KUH8ddbe23JiwYyzga6
         GzbDgd6wYr6A0MrKIW/zSn/9WMYg8MWcHIXv3ShIVmgk6XMVGaBCUeCkyImSWbg5GiKq
         IzTkbJTMqr4J3awr1iOEFFIdGAOoBdmgOVP4PMOQwP0gpm/UIHwA85Or1gcpUvQj+416
         X/Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVIeqD/C1Ni6zPeCnTn02tsf5DOx5gH6NiqeoFbLYFp7zT+xWv9N0blouGmzslhnxUQ0lvNi0nAZt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbPbS2iJo+xHih5X156spVhsR/FdEQi0spJHd64xrvkS1ErDDs
	iI6ZcSyr6W10CylFzq9TpObs4e0uqR2qJT8DZGKPux32ak/B4j5pM+m/
X-Gm-Gg: AZuq6aLneewOIH1bZRGJ7KD0Q1lvoh5ZqrVUz6m36Nk/mlHPxTa8IdiDXJdCK/m+dnk
	HDc9y/k8ubA24JPQxgJUzheN/lw6+WX0swCxbIAayfoNRMrFvg6EIQmDoC/vRoQIByfEw4VHDzQ
	q3F0J6nht+hAIJ+ftAs+25DYI8ByK6RmANBDwdKjfpHVnrfCXxBou6IYCfhoJMZZz9GYhNBCsgh
	Tlj5DfnuMLVXmEPRyodZaQzCWhOcsqu9PLN+J95TTaeU+oFq0zKbTh4g/keUR5TkfNL5edZDhFz
	XiXsCijX/HPPk4F7zwiMekiAe9F3UenNRY2HWoMa/NjrdiVGUwUALzjrHzSVLlob6Qu7niomY32
	FtwWe/CWxiRovVMN3mr+CmDWGNq1xTlOvyfuA9j7IjzNEy8nraEYT6xOH/nGP+B4x5DP1BqOB+1
	4flNfLw+yEEC/pbuyxiYrYKoZdd0boDvZhkkJQCXXAjXiohBE=
X-Received: by 2002:a05:6870:1405:b0:40e:9550:3242 with SMTP id 586e51a60fabf-40eeea800famr13275159fac.16.1771542992946;
        Thu, 19 Feb 2026 15:16:32 -0800 (PST)
Received: from sean-HP-EliteBook-830-G6.lan ([207.191.35.252])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-40eaee45d12sm26719644fac.1.2026.02.19.15.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 15:16:32 -0800 (PST)
From: Sean Wang <sean.wang@kernel.org>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	ulf.hansson@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH 1/4] mmc: sdio: add MediaTek MT7902 SDIO device ID
Date: Thu, 19 Feb 2026 17:16:21 -0600
Message-ID: <20260219231624.8226-1-sean.wang@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Wang <sean.wang@mediatek.com>

Add SDIO device ID (0x790a) for MediaTek MT7902 to sdio_ids.h.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 include/linux/mmc/sdio_ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 673cbdf43453..97cc834fb3d5 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -112,6 +112,7 @@
 #define SDIO_DEVICE_ID_MEDIATEK_MT7663		0x7663
 #define SDIO_DEVICE_ID_MEDIATEK_MT7668		0x7668
 #define SDIO_DEVICE_ID_MEDIATEK_MT7961		0x7961
+#define SDIO_DEVICE_ID_MEDIATEK_MT7902		0x790a
 
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
-- 
2.43.0

