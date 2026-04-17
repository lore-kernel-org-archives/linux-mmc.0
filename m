Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1032F1E1DF0
	for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 21:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459756; cv=none; b=Sbg0+vS/gN/If3XA3YFUQvY1OV8AnG4+YWdgjVZrXp0q2XBXvz7mBAYR0csNWe9SFxcHbAYuygzgh0sBkfswTpKy4XtIT6+MKNGHNtOxwbHzhFrWRGGBJoTREkfKk/4qowuKLhMLEWV1S6rYTLSLF3v6LC+gmCqW3U97K43KZ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459756; c=relaxed/simple;
	bh=n/dAZp2QEWFwelLKkJvUuH9OdyDrpa0B0cYnhOlrASM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JROIrEiUM2gcU71kmCW3fd23w2xEa6BT38A181qhA06egRzo4SY7VH/8HAYLmE5KZb+9i8ea/a2jHjtnUEtKIjIehIE1nkz65GCbw0DH94yXJoLkOEBX2bbOann+nqFTkInruXf3EMjG2YCHssEyfuTWf3iUBxcurBzEMKqJeAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TFMTaKyK; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TFMTaKyK"
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2b23fcf90b2so10980435ad.3
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 14:02:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776459754; x=1777064554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IlWUqFFMsgdGDEhE7tusFb33eRjEXTf5yDuw4u6ujk=;
        b=lB5GU+roUZPTJqYdnq0aeLTsPdqz6zUDW2wr2LNF9BK6/uUHGQ8GD5eYPnOC5EFSKS
         bxmkjKVmpu5wQdV8ITQzslZuSuP+ALLqyCVAWuhszcskq0+AmApUvpctAGT0fHu2Dzue
         KkwvhwGfo3dY+vCqniFfJsffx0qp+sUarpAlvgpyiWmsv0M6nYy5G1rz/LYG50wFr+eC
         ssb1ei6XA08SoaA3IevrH7VTpXu40qdExz301fEXNMyLlFZS90pS31zMH6nBmk7YcxaZ
         GzQUzbKbR/He5bWUIcFHYSbRt4KWy4iA0y+lZskaOIQDzSoL/0sc9pMtNHHW0+cs4Rig
         9RRg==
X-Forwarded-Encrypted: i=1; AFNElJ++gcNT1CDQlubgia2Y3Io6Fn+iK9Xhg8TXx9qCqaDeXEYEwDrQhf82Qo9MFP5K7ZT9Q8jX4PAebd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeIZLYFtv7Wtjuo4jFuzViOKcLjwqzJCzLMhcWbxURZBDCvVc5
	taTCCorEihc0PcOqGinJcs/wm4ULj0X3KZGbSLGW6oa+g7FXwTMsE00XysEZV76tBg6hrr0KDEJ
	EeoODDxDo518fgg23zsGpV3gqKd106fgFPL+3MWKG3DLsI8z0getyDzWE19YpuoBsl9ajAHBoVh
	bRoBOmQRmY7NwkPPcCYdWIXFID3R6OYT54NmkF113eG+shwuBO5WXAqHJ99ilMZStScL27AfAoW
	VVHTuuOggUx
X-Gm-Gg: AeBDietKRiWz241Ntmp04VKSKHe/wbfvuF0B4gWLMVO3oO/EDbkQNnEMkxFOOMgisJs
	HaisLSXbB1S8OmXu5EOWmANU5M1ELxFHKkcZu1hWaATUKZX12iCAvglyEUj/XQO9k2u1LeFpCN2
	agzuFFMGmfyl68sRnMRnfi42cT3bl/yBqsXrFJ2zsLR4akQKImAKAxeHHiX/Xqa3VnSiXSgm0C9
	Jbzu4M/y3u0Ydj12SImFK5cpt/s7y36H+4i5zKum3n80kj4FrD2bODHOJHKznHxmgLvGKafDo8P
	RXpTovii5oQzfkJF0Yow5VhyW31ebCeYE+kM1BIzTHubD/9cK5socylFG774aXL+pP5h8SzmnvZ
	ztMEnjugQ7JBiqcrC+4OOC6zLKuBOxgCUVyTGP866mDuEnmBdiVOhPgMG+spFm9gNl+MZgoIZbG
	ab7VeY3JoC2nLJWnrg4eAYfNViRSC8IkD/WNQ3o+/7BNTjm9v9i55vl5E0QMq00ots
X-Received: by 2002:a17:902:e195:b0:2b0:67a7:5c4b with SMTP id d9443c01a7336-2b5f9f402b2mr27378825ad.28.1776459754189;
        Fri, 17 Apr 2026 14:02:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-90.dlp.protect.broadcom.com. [144.49.247.90])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2b5faae2744sm2041845ad.30.2026.04.17.14.02.33
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2026 14:02:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-2dd1c74508cso2227065eec.0
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2026 14:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776459753; x=1777064553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4IlWUqFFMsgdGDEhE7tusFb33eRjEXTf5yDuw4u6ujk=;
        b=TFMTaKyK2Ep8C0fkaDswcIYB3Y1b0yzA5hz6yF+4CqdUtWNoA2KKLpq6ggIiVHJChS
         RuSMlMa5dmaAP0wfdx8/tP/CL7K752tq2ZA4VOM53cCKMCEDZqQGH4MTQERCYWVowxbf
         j2MxmC+hgrysK+8wSUIpwq5z4AS7s7EGhWTI0=
X-Forwarded-Encrypted: i=1; AFNElJ/+opA9N6N9nnE95W3ipIEn6b1tYzdPVQqXhV3bflK1iCoYrRp/OXFVbdOvQdiy/i+ro+YaG472ORc=@vger.kernel.org
X-Received: by 2002:a05:7022:90a:b0:127:33e0:ea40 with SMTP id a92af1059eb24-12c73f7fbaamr1852107c88.15.1776459752594;
        Fri, 17 Apr 2026 14:02:32 -0700 (PDT)
X-Received: by 2002:a05:7022:90a:b0:127:33e0:ea40 with SMTP id a92af1059eb24-12c73f7fbaamr1852085c88.15.1776459751948;
        Fri, 17 Apr 2026 14:02:31 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa5c86sm4617161eec.1.2026.04.17.14.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 14:02:30 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH] mmc: core: fix host controller programming for fixed driver type
Date: Fri, 17 Apr 2026 17:02:25 -0400
Message-Id: <20260417210225.3101961-1-kamal.dasu@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

When using the fixed-emmc-driver-type device tree property, the MMC core
correctly selects the driver strength for the card but fails to program
the host controller accordingly. This causes a mismatch where the card
uses the specified driver type while the host controller defaults to
Type B (since ios->drv_type remains zero).

Split the driver type programming logic to handle both fixed and dynamic
driver type selection paths. For fixed driver types, program the host
controller with the selected drive_strength value. For dynamic selection,
use the existing drv_type as before.

This ensures both the eMMC device and host controller use matching driver
strengths, preventing potential signal integrity issues.

Fixes: 6186d06c519e ("mmc: parse new binding for eMMC fixed driver type")
Signed-off-by: Kamal Dasu <kamal.dasu@broadcom.com>
---
 drivers/mmc/core/mmc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8846550a8892..3507a8d8610a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1371,8 +1371,12 @@ static void mmc_select_driver_type(struct mmc_card *card)
 
 	card->drive_strength = drive_strength;
 
-	if (drv_type)
+	if (fixed_drv_type >= 0) {
+		if (drive_strength)
+			mmc_set_driver_type(card->host, drive_strength);
+	} else if (drv_type) {
 		mmc_set_driver_type(card->host, drv_type);
+	}
 }
 
 static int mmc_select_hs400es(struct mmc_card *card)
-- 
2.34.1

