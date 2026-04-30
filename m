Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144AB374728
	for <linux-mmc@vger.kernel.org>; Thu, 30 Apr 2026 04:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525107; cv=none; b=INvrbDeZG8k/GKlSgEEVW6b4zz6AB51xSDbiWgXQ+tbKrwkKzNtX856RefLyRBne5VuaM7uRrHxoDVk5lCvUhHnuXHaW23v3uhM2Cosc3YcwgUPeAspnLYb8Qaz8nekJng8m519xSgxswRdNgku9UHG6Y6QsyrGkladLbG8rqLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525107; c=relaxed/simple;
	bh=oCc7gcXJeu51Lta7mt7R5GL/+eB6xIUqhxFp3xd2m34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fAAs+y6Ie1v3LMFvaZlORKiB0iMbiImVSwlAlCXiPCSJulCralJn9njpFODRHu7fEkBZzcibuVnPadV+VNCJj3GmIL8ZMLCB874GDhsDlZcdMdYnfGV0uV+UKY36HrxJuJ2ROhTkmm1hveHkSV3O9baSyQ1lPISRVoJM6yg2vZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=zPkTQ+bX; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="zPkTQ+bX"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82735a41920so197485b3a.2
        for <linux-mmc@vger.kernel.org>; Wed, 29 Apr 2026 21:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525105; x=1778129905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XP095ZhYw2b8rtfTp1Te2wsBKkizx72gLLNn2a1UW1A=;
        b=zPkTQ+bX/bbSzyFDp04IDLbdEMDQoIg6B/4YFAyvhHasCL7x6UVsxDgRcv0SFU6iFw
         4ZMFP8udO85YbnluzmRF7r2Tzh3R5pgmbc/H6vpH2v+iltK5FiKvlQ64HCHKB2P1qYbP
         eR58EiPhE3bZUeQ0buTIuyyc7hZPaTZvIocyLr6p/vZJhYLf2OJGgSiciroQoczxg17b
         5zHk94U+dstDYvVZUGRaB7LMmCjpmeIFgXSDUBLY7opXF7p4C4TvaYdH8k6FkHEp5pVh
         T4BT6MRFTB5zu8IVKOZjHq/2GyrrGcZaK0E3gwsdKWdxwAb9tFj+ebQeAKpjXLJX+c2T
         Lj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525105; x=1778129905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XP095ZhYw2b8rtfTp1Te2wsBKkizx72gLLNn2a1UW1A=;
        b=f7V/9Bbue4NJFm1fGNssKCSqpp4pqvQyBnWG50DKT9KMQGHKIRQ9nEKFM0SgDpWIpg
         INQTcv6ovndH+mvnC+avJEUGDvc/aOPKQ8zvR8aCBOqZ8UOGncK5N0WrCMuSxLFvdSMh
         sS0E5u+ueVMlk0wBO2/Qxa1qXkNsCJZ58tS1QEVszRHw0OvP0b+0ap7aN1dFhzWWiMRE
         qte2jsH4/HAa82gRY1KFxsAO70py9UAZNQEaUJrO0se/+b7tqPvKMM2bdsADgqHzt/6D
         ZT7GH0jGC17MEHeNimfAQgLALhftGEN2r2S//ZhrT1dGmC1J07DQqRV2osIwTvGL5Fdp
         Ieww==
X-Forwarded-Encrypted: i=1; AFNElJ+rSTRv3toB5BnLyvxEPI/TpI/zXoSwgwuItoiokfZUXO7dOkdNSae896ad/bCWJ7DB8IajjHE3U5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMleCGqe1DejvHWAV7ojH+2toPfhsqvoKvJF43GdWA0RMKioE/
	Ks+bTuZAXwoyPPZ84FGj41MTpvfrn/JrSJ+5/JwKvMTJQWNinyKPFlHcege6q2wQqKM=
X-Gm-Gg: AeBDiettwpxgNVTvhJoX2wYQBxeFL4oStdNeDPOQ90bJU3DTxJ7WXfOmR5gpMoKJG4P
	IgET64iE2A47qVZJstJft3rGhNCQlLglOB9lGR/V+qIied+40ViIrrqeyYsKts33YDMM94QnnKA
	hZJ+q346FnqXyXojW3XWpQVM/iCvxtEKmFIKa/aVekRHzPex4JNh5t5Vo/bFYxuWGFpoqsORsey
	ncbtvJwzzJR8+d/CFCyTqzrv0eGRQ9qsXg7XmB34U39m6UsyqC0OqCDhX5IRWrQXXtliGAR9AaR
	L7Os9Hf4PZk7jtnUZAjyRz9GKRkdptzAaPLUs3oijh0xYbgRpuUxlqd9mb63oUiGNiiJ/orrzfK
	DKzK7+YhSbbwdeX1nApT/c0CeQCDJv/sm+eUdWcWDtAsHPrDzrkAJPYQo1M17KDWV1J2RMo+oOf
	cvnOSiE8h/8xTCXBDiE94DcL/PYi9tuLZ1B7xIxf3FSv4qhdwWauDWHrulho+mjFBzpHnrxVt8a
	OJdUmZKExaOeNT232uHzZgBrvzXaJPo3qirKrUZfw==
X-Received: by 2002:a05:6a00:b605:b0:82f:453e:3863 with SMTP id d2e1a72fcca58-834fdbaca42mr1653172b3a.22.1777525105512;
        Wed, 29 Apr 2026 21:58:25 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:58:25 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Ulf Hansson <ulfh@kernel.org>
Cc: arien.judge@morsemicro.com,
	dan.callaghan@morsemicro.com,
	ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 21/31] mmc: sdio: add Morse Micro vendor ids
Date: Thu, 30 Apr 2026 14:55:47 +1000
Message-ID: <20260430045615.334669-22-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Morse Micro mm81x series vendor ids.

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---

v1 -> v2:

- Use a single VENDOR_ID
- Drop B2 chip which is not needed

Ulf, a mistake was made in v1 [1] listing multiple vendor IDs instead
of a single vendor ID and the subsequent device IDs. As for why
the series is structured as a series of singular patches is due to
how wireless driver submissions are as per [2] to simplify review
due to the size. The final submission will be sent as a pull request
with all driver files as a single commit and this SDIO commit
beforehand going through the wireless tree once you have acked.

[1] https://lore.kernel.org/linux-wireless/CAPDyKFp6dhmpkMCs=ejYTpR9oNbNz0urtFD2HTvRwOp2Y7H3DA@mail.gmail.com/
[2] https://wireless.docs.kernel.org/en/latest/en/developers/documentation/submittingpatches.html#new-driver

---
 include/linux/mmc/sdio_ids.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 0685dd717e85..111cb1758830 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -117,6 +117,9 @@
 #define SDIO_VENDOR_ID_MICROCHIP_WILC		0x0296
 #define SDIO_DEVICE_ID_MICROCHIP_WILC1000	0x5347
 
+#define SDIO_VENDOR_ID_MORSEMICRO		0x325b
+#define SDIO_DEVICE_ID_MORSEMICRO_MM81XB2	0x0809
+
 #define SDIO_VENDOR_ID_NXP			0x0471
 #define SDIO_DEVICE_ID_NXP_IW61X		0x0205
 
-- 
2.43.0

