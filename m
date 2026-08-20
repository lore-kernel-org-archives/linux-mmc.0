Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733F47F2E3
	for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787246226; cv=none; b=rAPLLzT7+yEQdeXxxixleuqSdbzLbrCdNT6K8A40UUP/BIgzszIZdkzyX9yRBQ7Ot6tJDSLwvD5aUr0Q4sAP+ZnQuwxok16PIwW/W9DXw9EdA+v+256ArqptFo5IfuSp3mBES1Ee41mZAItD1R4EDzU/fBfJo5/2L9TF6zs1o1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787246226; c=relaxed/simple;
	bh=ipr+MBhDJMbp5Zx5PlUAdWHCNAfdnVJiOsjptFpzaq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXyvyA662X6O8qtF905hbMoNLjdSZKwI+szYMpKjB+fBEz7AW9kxAtrOCTy8+rRed+YdTOdl73GHUaR57J+IWYjnDOg/9h1C15VP3+8tmUnJoDuR7dzIiRC6ktJtW/NfrYEYfDaMX5vlhIs0r/P6QwwgjWttB7uoGbaZ2nZYacY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKl7bFd9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKl7bFd9"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so627115e9.2
        for <linux-mmc@vger.kernel.org>; Thu, 20 Aug 2026 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787246221; x=1787851021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mu5nSbIV7ZVCPgjYekLBicE5GIjpuU6QCDUMJ/qyzLI=;
        b=XKl7bFd9eqmYkYGMe24uHacDeXKeNh1yMLHWAcXmcgUbsDDNj1BZ4qdSouR7kYo+GE
         QDZ7SGjgqGtmcxliprYe0vROB7QyjujfO99G+bVaUTK9zjbJmaqglyjsYhTih+vsM5gF
         aYnt876TCVShI6+TtOECRykGeCjkLEHEpj4rWZadphW/nYg1+spRS4xOpK1mIypAGAmG
         5QRPzKncpcs+KI1PbfUPSaCYK24dwNGB6FoVYKAg9uuWBOvYKQk+um9i23sAKqtsWxTG
         hi18cT2dlKyBwMA6J78mqjr+nSbGCrJeGYeYp6OP97OPqEhWwM9MKB7+HBNHWrb4EJTL
         9eiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787246221; x=1787851021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mu5nSbIV7ZVCPgjYekLBicE5GIjpuU6QCDUMJ/qyzLI=;
        b=VXpl1hYZ3XzPmcsR1g39W0JDsGaseCKWhuOlbDr6bIWpkpWR+8U5Q6AqIfcpXPpnXe
         fyJWXvWg6uUuKV0IHwNj04Q2u+g8O6GV4aU3+SvPFRZdqTLBDYGkHMEOR6b3nuMsa7TD
         sh/rrP/YKt/nWZtSGAjy0HrnfAlxDBH6AxDjc/B2SQxSbNRT43mblm2lLehOo/fpWlbQ
         uXqNN+imSi3LhYhScExdJtQ2bnhNfVfLitFBFB5mHFXLDWUDvsguQZBjuTXG5RtwpDkk
         mq96VbKreaIV98F6MCsWbtri4Uv+FLJhCY2BLXDZOf8h4ot+PcEubgscRBkVqoZKEvkA
         Gi/g==
X-Forwarded-Encrypted: i=1; AHgh+Rofjs52VaYgjPm4jWM5VZDYPw053u/gDMgOLyhGch0dT426Kc4C0fJk+l0kgCMgyUPbRBKHqxPQ+3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3AvbaZdgt3EN0PMFV/q2pT8FT+J6+Qj0R3/jKZ2Q9a2AxEY2
	8ljD11kt3JfJ7KDAzHu4EJ5Sjh4Xcmb5HKds1mxSzb/iyzB5kjuY5iBQ
X-Gm-Gg: AR+sD12XctaKOIOLuRNM5OkZHJfTHAT9zlx8HiCSciA/ml+AQJHqpbsklO8MO+JVrwR
	etAp455cdPKUQ9t/cQ+/LrU8mzUkwrGT6JpKxhfht3LcZXvahi3tg8caUKy0lEX1VzwYsoiVBHL
	oygrxT69z4hm8sO2rkH++vA97nKQHa7796gEFBtaqMgbUdD5xDiat165kl+mGNBZfIn69lfRVG6
	i/sWtYqbfOwujTvtsSNk7/LoJ4aj5ofKP6AZ/boKfP6iSPOZqQ1jUKBeLQq/wRN0jL8stUne0Uj
	9JZdibgE+O2N4gLbm0SY2AjU958kx6CqeD5Q2B3jzYwVhwksLNH+btzEKXyKZ7gDGGM/8KX7cco
	H/Jdw7zQqSGVOfRJ5XCxKcibIgqqR9977N6Ec7edfpVtzBNMSZYtDNxfWM+iuC9vjwXVP9X16rh
	VGus0fd8vgTpd3I5iw2uprZqzt9B5YfRJXu/q8cGwoj/0ElUwsV/sylpfLJ/8MHwoxlcIW
X-Received: by 2002:a05:600c:64c6:b0:499:afcb:24c1 with SMTP id 5b1f17b1804b1-499b82e8528mr9852195e9.5.1787246221245;
        Thu, 20 Aug 2026 10:17:01 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:eda0:8ef1:e1ab:c2b1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa0fd728sm219313495e9.3.2026.08.20.10.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 10:17:00 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v24 02/15] mmc: renesas_sdhi: Clean up whitespace and add OF table sentinels
Date: Thu, 20 Aug 2026 18:16:32 +0100
Message-ID: <20260820171657.62815-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
References: <20260820171657.62815-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Clean up coding style inconsistencies across the Renesas SDHI host driver
files. Remove redundant internal spacing in the struct definitions and
static initializers to enforce a single space separator or uniform tabs,
aligning the code with standard kernel formatting guidelines.

While at it, add a "Sentinel." comment block to the empty terminating
entries of the Open Firmware (OF) device matching tables to improve
code readability and explicitly mark the table boundaries.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v23->v24:
 * No change.
v22->v23:
 * No change.
v21->v22:
 * No change.
v20->v21:
 * No change.
v19->v20:
 * No change.
v18->v19:
 * Updated commit description.
v17->v18:
 * Merged patch#4 and #5
 * Updated commit description
 * Annotate the empty sentinel entries in the OF match tables with a
   "Sentinel." comment for clarity.
 * Retained the tag as it is trivial cleanups.
v1->v17:
 * No change.
---
 drivers/mmc/host/renesas_sdhi.h               | 2 +-
 drivers/mmc/host/renesas_sdhi_internal_dmac.c | 6 +++---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c      | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdhi.h
index afc36a407c2c..09bf9b24a8c3 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -25,7 +25,7 @@ struct renesas_sdhi_scc {
 
 struct renesas_sdhi_of_data {
 	unsigned long tmio_flags;
-	u32	      tmio_ocr_mask;
+	u32 tmio_ocr_mask;
 	unsigned long capabilities;
 	unsigned long capabilities2;
 	enum dma_slave_buswidth dma_buswidth;
diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
index 0c3967f758c2..b3f4a5f8dec0 100644
--- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
@@ -271,8 +271,8 @@ static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_nohs400_compat
 };
 
 static const struct renesas_sdhi_of_data_with_quirks of_rza2_compatible = {
-	.of_data	= &of_data_rza2,
-	.quirks		= &sdhi_quirks_fixed_addr,
+	.of_data = &of_data_rza2,
+	.quirks = &sdhi_quirks_fixed_addr,
 };
 
 static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
@@ -293,7 +293,7 @@ static const struct of_device_id renesas_sdhi_internal_dmac_of_match[] = {
 	{ .compatible = "renesas,rzg2l-sdhi", .data = &of_rzg2l_compatible, },
 	{ .compatible = "renesas,rcar-gen3-sdhi", .data = &of_rcar_gen3_compatible, },
 	{ .compatible = "renesas,rcar-gen4-sdhi", .data = &of_rcar_gen3_compatible, },
-	{},
+	{ /* Sentinel. */ }
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_internal_dmac_of_match);
 
diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 426308b73b49..7ae488e5c1e0 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -27,7 +27,7 @@
 #define TMIO_MMC_MIN_DMA_LEN 8
 
 static const struct renesas_sdhi_of_data of_default_cfg = {
-	.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 };
 
 static const struct renesas_sdhi_of_data of_rz_compatible = {
@@ -89,7 +89,7 @@ static const struct of_device_id renesas_sdhi_sys_dmac_of_match[] = {
 	{ .compatible = "renesas,rcar-gen1-sdhi", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,rcar-gen2-sdhi", .data = &of_rcar_gen2_compatible, },
 	{ .compatible = "renesas,sdhi-shmobile" },
-	{},
+	{ /* Sentinel. */ }
 };
 MODULE_DEVICE_TABLE(of, renesas_sdhi_sys_dmac_of_match);
 
-- 
2.43.0

