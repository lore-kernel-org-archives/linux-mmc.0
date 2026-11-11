Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.136.65.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398980;
	b=mmkYUvhMq2/94pzAWWc0AGx7TU0B4mpvV+hkdYNDfB8+qcFvE1y/vhAuGUC/1aojhovo
	 n46H4x3b6fHSeGku4NLulVQdrTfQ5Gxj3gV/eIsbGZEPR6ER9kMIVrupMJEJ6Zh/nyVUv
	 LWWsIwwDbvQI44aQS+XYX8HOBAWYxCAOwaEfcQ7jDO5hWZMkACovK3BuvzG4eOluTFrit
	 bpLjMmIxhUO5c1jRABYt+HnFxEPTy4rzxiu6GHJVMdNVTGHrvyquIWZczIhhyt2466GJ2
	 a+MMQiQTihd9XWkoyhRnoP1YVQN2Yks7P/uFAFww+kZc0r5RCi9EtKOVCfrZbM6to/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398980;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Flowmailer-Platform:Feedback-ID;
	bh=dR4PGPQckLV9tTndULMkzgy4WYis6HK3fE/gJso4XPY=;
	b=TxwGJQ2jOx1SufkFwZWp5ickWVTZvOcstXZXAzDeOrqLIaHPvtkfkc3qa+7SH3iziT16
	 N3lHIzeMfllcA1lMVPWU47k/dsWxdygMRJ6f0pl9fsFAhZIWb7kMqjfNKNtR7O9yZavZP
	 zyMUvEOJTRdOtqbi1NLpIWCbzuI/YfnqKya2y31za/6GkOE1kUEzuldoip+UKkmkCT4MP
	 cIq1n1oPUdqxgxi8H2fbk1znCXR4Y3TWH1rBd/YyAlHrpMTa0iwKGEhsOpCaC/xwSIAdu
	 cT4NQRjI79WaO3bfU9NxQAtAdFUZEaigDdM9H3SRttAMVnUB8qyBxEVWb08YrZRZhyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=siemens.com;
	spf=pass smtp.mailfrom=rts-flowmailer.siemens.com;
	dkim=pass header.d=siemens.com header.i=michael.haener@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=YrXHGL17;
	arc=none smtp.remote-ip=185.136.65.226
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FE7606A33C
	for <linux-mmc@vger.kernel.org>; Wed, 11 Nov 2026 12:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7FE7606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=michael.haener@siemens.com header.a=rsa-sha256 header.s=fm1 header.b=YrXHGL17
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026111112093959ac34f55600020738
        for <linux-mmc@vger.kernel.org>;
        Wed, 11 Nov 2026 13:09:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dR4PGPQckLV9tTndULMkzgy4WYis6HK3fE/gJso4XPY=;
 b=YrXHGL17DFuR0z7nWtUKT+Uj2fowtv61rmp3WtNNuEZtAeWoxFFI0EfkbbXWXiIHlN8vv4
 i5j2Apd3yXaAuypGslndLfczAlC6Mu9zJbW8ToPDnUqhWSq95yEZ4/wVsiiUuYRp9z34Z2DW
 bNmgjJtksEhaFxZ62ihYIkQpO9kVFyDm92WhX7d74jzK4X/AHO4vizeVTdutfN9n3gRK22m7
 Tm5RR3tvp6KhpynQ3fkiv6pQQDsrhnFV5c494kEQnJ6WIOVqX27jKnvW8FmCACCpfoe+fbyK
 Xc4UM8nFXKL/lLi/jieU0AZeIlPpD6lQtPRs7jf3YHYoEnRc5I8B410g==;
From: Michael Haener <michael.haener@siemens.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Avri Altman <avri.altman@sandisk.com>,
	Luke Wang <ziniu.wang_1@nxp.com>,
	Michael Haener <michael.haener@siemens.com>
Subject: [PATCH 2/2] mmc: core: saturate erase timeout instead of overflowing
Date: Wed, 11 Nov 2026 13:07:59 +0100
Message-Id: <20261111120759.100830-3-michael.haener@siemens.com>
In-Reply-To: <20261111120759.100830-1-michael.haener@siemens.com>
References: <20261111120759.100830-1-michael.haener@siemens.com>
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer

With MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME, secure erase/trim requests
are no longer limited by max_discard, so mmc_mmc_erase_timeout() can be
called with a qty of several thousand erase groups. The timeout is then
computed as erase_timeout * sec_erase_mult * qty in 32-bit arithmetic.

With 512KiB erase groups the block layer limits a request to about 4096
groups, so the product overflows once ERASE_TIMEOUT_MULT * SEC_ERASE_MULT
exceeds about 3496. The wrapped value can be much shorter than the real
erase time, making the busy polling give up early with -ETIMEDOUT. No
card in the quirk list is known to reach that limit today.

Use check_mul_overflow() and saturate at UINT_MAX.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 drivers/mmc/core/core.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 677e445dc48c..9730633dfa81 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -24,6 +24,7 @@
 #include <linux/random.h>
 #include <linux/slab.h>
 #include <linux/of.h>
+#include <linux/overflow.h>
 
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -1568,13 +1569,21 @@ static unsigned int mmc_mmc_erase_timeout(struct mmc_card *card,
 
 	/* Multiplier for secure operations */
 	if (arg & MMC_SECURE_ARGS) {
-		if (arg == MMC_SECURE_ERASE_ARG)
-			erase_timeout *= card->ext_csd.sec_erase_mult;
-		else
-			erase_timeout *= card->ext_csd.sec_trim_mult;
+		unsigned int mult = arg == MMC_SECURE_ERASE_ARG ?
+				    card->ext_csd.sec_erase_mult :
+				    card->ext_csd.sec_trim_mult;
+
+		if (check_mul_overflow(erase_timeout, mult, &erase_timeout))
+			erase_timeout = UINT_MAX;
 	}
 
-	erase_timeout *= qty;
+	/*
+	 * With MMC_QUIRK_FIXED_SECURE_ERASE_TRIM_TIME, qty is no longer bound
+	 * by max_busy_timeout, so the product can exceed 32 bits. Saturate
+	 * instead of wrapping to a too short timeout.
+	 */
+	if (check_mul_overflow(erase_timeout, qty, &erase_timeout))
+		erase_timeout = UINT_MAX;
 
 	/*
 	 * Ensure at least a 1 second timeout for SPI as per
-- 
2.56.0

