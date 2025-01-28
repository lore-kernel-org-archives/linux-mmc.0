Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01E1D932F
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jan 2025 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738015935; cv=none; b=MArTVJdWqaMyICeOkbDUOAVlVNAd2VFBD6Z/yr09mrB49LppMo3py/PX23YxnkJyXwgqNSZohc0ZsST3CmXvxhSVl3Y+pROXd/VJDfeJBJiM+FDyJqx7MwUpBsnd4dStT83QhPV4N97Z5JnXa3MSWVCtt6XZzdxJhUlu47iJGbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738015935; c=relaxed/simple;
	bh=/OZJ5nZbrRAlE19otGPqzJXN0XugB2gAMhb6M/0yjws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DqXVFHn0RmebfCDeyU7u4WIozXhiJAbhRJPBmAbyXFQ9D/8YeKMT7l+4Bf5EqVG2/60lbUk7E3MzIuwfpfNGCbUFjQFF1uXh4LP1r6pNl8Crh9eAxBhCFP8k4Xr3vAySlTXBtRGcaMmW7njJz/MgNuT/zlp77QhJDgYMYTMaSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTx4alUM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTx4alUM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2166f1e589cso11739615ad.3
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jan 2025 14:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738015933; x=1738620733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xBn/vpa6bvh6++2BQkveffqsgeJvNmt2L4vG7ORqn8k=;
        b=BTx4alUMsfLaIQ7Ek7Xu9U/XlYcdRiIIhIbGpzSlBIbAHRpO07bIjRqZLD5IFbohN9
         Ec4Vci497t+AnsfyS4tBgPDgA7EJROkBmFRzifSCpBdYQTIJsKtSrNfwCInR8XBTAMuX
         k50RPL6ZKt79h8t2+TIhmxZd4Du5aNOKYGOrRiZ2n6Vqzrk5GkwaW1BBskdqNBNGdzlF
         V4UqizU/YIMY3DUf1ZBld/qttnf4O+wV/O+VWezgzLjegcICxCeX810SXGnORavs0Yjx
         ID5xk19XqfDHEusU/6h05+DvTxwqJLGyosQrh+aE/rvvTi9hxl51JEF89Y/QL62BgmX4
         6cgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738015933; x=1738620733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xBn/vpa6bvh6++2BQkveffqsgeJvNmt2L4vG7ORqn8k=;
        b=KjcFCYubD/wTHMdKmzIRJVh0VYj4OxYyiYcXX6YntBtdDkakRVzr0XR1GXZLCxTQ+X
         OxAVBag7gVocXOjjw+U+2gmRNrWvoHnt+1TW7ukjA7K8BAPuKWwkTPDgLKjCbu7Aca59
         fy8XmoGy51BXhk/o4yBqRtE0BT5o+8RfV/vuOPq+R5a7ATePyP/akMcKiRowei612a/N
         cpZ4uJ7w9O2MAC0ioAio4mdoUyK0xLbtkoXQ/LFXe808vAO0qlSKpxrOcLoJYe/ANOn8
         n+xF7bnmFgecADvMqSa1ZMiXoc3SGLoXnVMsJgJtmL1wDDJ0xEKLgQHAW4E4begwgxih
         iPvw==
X-Gm-Message-State: AOJu0Yw7bu/R/NZSxp+Vhi48bYRTE72Zh1IlWSMQRSnUBuH+sgesobc7
	3+DulYAs6L8Jy8vSAXfrDvyjqDKk6ryIS+nqfW/FyLkteI81s2g+X6z1ua6NjdQ=
X-Gm-Gg: ASbGncsXImhNnGp8y4Oufi/nJH0esFd1ngssB/g3kceVGlJO+RKv8yTWVOQ86r7MenV
	qg4/qXHl7KDHox+C9phTmXQx6zPMQAYqHw103nkxXpEy8Z+7LeCbRi5N+otYvhRIybc4641q+8z
	4c6vTf9EMGDXHaZ+fWb4WX9ef+wTbzO0GRFVE3hKNlIN9uC++lj9zbcxDGkLxg1ju4gfUR/GJG4
	qAK4JWFqNxDx/84CW4xyl5plimYr8TOTha0DG3UYlabIn1sZ+efUHn2V7BwAaDMV49jCb1sjcks
	0eY=
X-Google-Smtp-Source: AGHT+IFfqBHFcALjGAEe+ktMEu6ipX2xwyZ8x18GP/34kF8B4TyBbDr3Sunbj+7Ohzc0mKN8fhgntQ==
X-Received: by 2002:a17:902:cec6:b0:215:a3fb:b4d6 with SMTP id d9443c01a7336-21c3553b55dmr479415785ad.8.1738015932891;
        Mon, 27 Jan 2025 14:12:12 -0800 (PST)
Received: from localhost ([103.28.246.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21da3ea3032sm68400165ad.80.2025.01.27.14.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 14:12:12 -0800 (PST)
From: sooraj <sooraj20636@gmail.com>
To: linux-mmc@vger.kernel.org
Cc: sooraj <sooraj20636@gmail.com>
Subject: [PATCH] mmc: sd: Fix incorrect capacity calculation for SDHC/SDXC/SDUC cards
Date: Tue, 28 Jan 2025 03:42:26 -0500
Message-ID: <20250128084226.15873-1-sooraj20636@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The capacity calculation for high-capacity SD cards (SDHC/SDXC/SDUC) used
an incorrect bit shift (10 bits instead of 19 or 22), leading to severely
underestimated storage capacities.

- For SDHC/SDXC (CSD structure version 1), the capacity is defined as:
  `(C_SIZE + 1) * 512 KiB` (SD Physical Layer Spec v3.01, section 5.3.3).
  This requires a left shift by 19 bits (2^19 = 512 KiB).

- For SDUC (CSD structure version 2), the capacity is:
  `(C_SIZE + 1) * 4096 KiB` (SD Physical Layer Spec v7.10, section 5.3.3),
  requiring a left shift by 22 bits (2^22 = 4096 KiB).

Update the shifts to 19 and 22 bits for versions 1 and 2 respectively,
ensuring accurate capacity reporting. This resolves issues where cards
(e.g., 64GB) were incorrectly identified as 1-4GB.

Signed-off-by: sooraj <sooraj20636@gmail.com>
---
 drivers/mmc/core/sd.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index cc757b850e79..b60de859e978 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -172,7 +172,11 @@ static int mmc_decode_csd(struct mmc_card *card, bool is_sduc)
 		else if (csd->c_size >= 0xFFFF)
 			mmc_card_set_ext_capacity(card);
 
-		csd->capacity     = (1 + (typeof(sector_t))m) << 10;
+		/* Correct the capacity calculation based on CSD structure version */
+		if (csd_struct == 1)
+			csd->capacity = (1 + (typeof(sector_t))m) << 19; /* SDHC/SDXC: (C_SIZE + 1) * 512KB */
+		else
+			csd->capacity = (1 + (typeof(sector_t))m) << 22; /* SDUC: (C_SIZE + 1) * 4096KB */
 
 		csd->read_blkbits = 9;
 		csd->read_partial = 0;
-- 
2.45.2

