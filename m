Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com [209.85.217.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1DA48CFC
	for <linux-mmc@vger.kernel.org>; Thu, 23 Apr 2026 19:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776972071; cv=none; b=TmLIlP1S1yqi+My2bmsFfNAgKQZvHg2LcD+IoeuKS96eE748qm6tyj3xKFhjOEssG6ALuuF2OvsPrwdFhRdNSfhHgXPq2GrDX5NPuj6qVrN7wwdR8kwC1IMkbWR67U67mU10P5paVQCEFsJrPJZh97GOiu3eYMwW8eGeKN6l7eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776972071; c=relaxed/simple;
	bh=PClqCK07Ka0R4xHcNh3toinjUIw4MEIfybat0KZ60dE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TZLrU0o2pVJD7+4fwFJaAx8Te/o5111VEQ1KK86rXDntP9h1uTCmT0Bh0WjvKvegx71w6srumu/okYZMHSkNvtkNooMhzzAzz1pB1FjmW7IuePdbNGEYBeoynvEBKRhA7l5MUjIbOc3G1LD7MCrJJ5WLVpVTdZCVPG/om0xgTfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RBlztS1T; arc=none smtp.client-ip=209.85.217.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RBlztS1T"
Received: by mail-vs1-f98.google.com with SMTP id ada2fe7eead31-60fce51aa55so2094784137.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Apr 2026 12:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776972069; x=1777576869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PML/WCuMNBActDXtR6UnIdfaKpFVfv955aq7RWvn5cI=;
        b=nweDK18VhbW3Gx8k89zRTHi/ZoWzkg/UeUnm3foj+Vo2tS+z6+5tbJ7g3uixEzl9ol
         602RVh6GuLIovdOGR4Xp9mYtovNwHFm6Z9xvcbHiWkkh1RjRfGFUbtf4fHUuO1Yc2ngA
         9jKD8wXobLaj1AN+V++zKLt+V9Ewp7nRgrPUfMm/7JStzTv+e8CjTbt24a2OPVIRbT2o
         lP9W/IUABZTNHAlNmmxIkxBkWL/CAWvFPhw2o+j8aFMt4+01x5rNaQk0bxMbC0V5BDBZ
         92DPA+5dOpBck7QdKpU7gdwCrIdfly5ixCyJzQcAxjkgRD0D34W134WjOm9kob+1/qLh
         cG/w==
X-Forwarded-Encrypted: i=1; AFNElJ8Jml0HshQcyBWznVgetlYdeAtHI7l402Wr8dPAu0Gv1CpuOYLTbLf8l+xEXNp7qe8MQmJG6YDuTcE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ZVNAw4lpgHQLCRb/wapJms5TZiWfHlOVHquXIV9umRFx49v0
	X3n5Q7rzAZGaQCgFl7BDdawL6tpeVbtMewjpllveQ67EbGIOSXXdV7So8tZOhfgK1V59zotTltL
	gE+F3R6/L1Hg3P2/4GCo9y/DPNA1JJqx5CpL3TEZGv+4uGDfSI95HXZAx0DBiLA1dqAegl5Srcl
	YnHLmSKZeWv40sdeq7lopJTs7bFW1fjMlV4L7HdVDaqT8a4Wiy4Qx5gM2e2Z7aUwSzXthujs4sT
	SRGXrxSuY2E
X-Gm-Gg: AeBDiesXDOsgiTtHZGoOeNdIsHg05COjgcY+5LI3U+zKvIQmwOM8Nsb737m/COfd5Ks
	PG8dF2LIO59IpSP4CtytwuHQTTQ9JP4ITBN/CUSchfpX8HafpBcJ7AQwL+vMa8Kp7EHeKRQ74HN
	j0ehbzyrO3i/qqNaK31r0RX+N6GnQABKFq5b8z9pqvXUvehXj2niD6LP2O/OUzy5sO9TGOcRVRN
	6dQMhv9J2IR2Pfb2y5KGENf91bhUxyJ0fY4CUwC8UYF1YFAsJLTHStyc9Scwrsa8xiBg2KMfDg5
	inJUGz7LCvvWrkKZ2j5koJwqQLws8BQvzqXkUPLH8Z9GU4wXxSB6UCMRBdlvNXtDLAu8Ja51ps2
	4lIE7cKOg3U3+xYQt7wMkNgbZw369mUp2xoPvLbNhRlCNU6SWoBeRcG5Mel4D3Z4RjMzKs5a2Zs
	b2CVorGpC3dgMZDfuM23WzWfGlLVHj9J6Bok160T7JS54/SxJmy2X7ajUPvO9AEtKx
X-Received: by 2002:a05:6102:38cb:b0:608:a01d:f7e3 with SMTP id ada2fe7eead31-616f7c60edamr15483311137.31.1776972068796;
        Thu, 23 Apr 2026 12:21:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-61745c9d35dsm1631814137.12.2026.04.23.12.21.08
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Apr 2026 12:21:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8b02af4345fso237189226d6.1
        for <linux-mmc@vger.kernel.org>; Thu, 23 Apr 2026 12:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1776972068; x=1777576868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PML/WCuMNBActDXtR6UnIdfaKpFVfv955aq7RWvn5cI=;
        b=RBlztS1TxiQJ+hqZ4dYNAXyQwkXdr/4f+6LJgtIvlqIaxH1zyvV6JsrwAV2/vwmTHK
         JuMfIwiW4QWOnIrs2Cvxlyiqb39jG9DgPSGTVBUob8SUdycyKebCI3bmL1pPPtHOE/s5
         HqeV97Vrp1+fWm5kI+iD9VT1wEqzE1qHjNtEs=
X-Forwarded-Encrypted: i=1; AFNElJ/6k54+jW0THmRogr4JM0LmDkv/MCdM4ItEyKT4wpi3ilLl7+vvKfPw1iymhx/V4sF3QmfwFiSzAlM=@vger.kernel.org
X-Received: by 2002:a05:6214:2f07:b0:8a4:58ff:f0f7 with SMTP id 6a1803df08f44-8b03addd7a4mr366513196d6.44.1776972067898;
        Thu, 23 Apr 2026 12:21:07 -0700 (PDT)
X-Received: by 2002:a05:6214:2f07:b0:8a4:58ff:f0f7 with SMTP id 6a1803df08f44-8b03addd7a4mr366512406d6.44.1776972067326;
        Thu, 23 Apr 2026 12:21:07 -0700 (PDT)
Received: from mail.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02aa4f1f9sm163260006d6.0.2026.04.23.12.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 12:21:06 -0700 (PDT)
From: Kamal Dasu <kamal.dasu@broadcom.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Avri Altman <avri.altman@sandisk.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kamal Dasu <kamal.dasu@broadcom.com>
Subject: [PATCH v2] mmc: core: fix host controller programming for fixed driver type
Date: Thu, 23 Apr 2026 15:18:55 -0400
Message-Id: <20260423191853.1053936-1-kamal.dasu@broadcom.com>
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
Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
---
 drivers/mmc/core/mmc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 8846550a8892..05444ecf3909 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1371,7 +1371,9 @@ static void mmc_select_driver_type(struct mmc_card *card)
 
 	card->drive_strength = drive_strength;
 
-	if (drv_type)
+	if (fixed_drv_type >= 0 && drive_strength)
+		mmc_set_driver_type(card->host, drive_strength);
+	else if (drv_type)
 		mmc_set_driver_type(card->host, drv_type);
 }
 
-- 
2.34.1

