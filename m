Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7528C126F35
	for <linux-mmc@vger.kernel.org>; Wed, 21 Feb 2024 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550592; cv=none; b=tBJXxzlXGCWHiKOLF7X/WA5lgJrnR4SNkU4R3K4Xlkxo9qA0e+caIjHNnp52bzI5IRRKTSJA8+sqCfmjxto8pUHQeqRpQ07oZJ9UdCJPery8+6yOsTjWY2mCTdSqSusoq/GP9+Owq2ucPFxiNijsZsKicB0ThIOgrZ7FO/eIKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550592; c=relaxed/simple;
	bh=Q97GKjG618rmqzYhuKBwtMVC+Xp1EdypCJVY/5vfUc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpwZEXZTTUZtwWPqJHSSAbpqwhebIDHvpKVwuOWT0yYx9RQGmyQds31FEzJYnZbRyurBjFYoRviyDyGJXZasKO3LrsHqlvAepZITd4bYrUj+r2CuHk0T7oSbyIO+0auyCtIHHaUOdXYmRBwz+YoHUOqahQlxYc/fxBjnOtqPkpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EihzY5jA; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EihzY5jA"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-564d9b0e96dso2816334a12.2
        for <linux-mmc@vger.kernel.org>; Wed, 21 Feb 2024 13:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708550588; x=1709155388; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SSSSEzfunpVKo3VA6iNBnH3HhYtnjVDxAPoRZgjZUQ=;
        b=EihzY5jAsxL8fZz8P2tCF4cQT2GaF5bo/XJZrTehc8gltRmqiCU5QtV3c+14kki8b6
         6fxn+LhdhhgpPkjy5W1i6kakUe14QhDMzU6RhONg2zo6bCXP4rLqZvS9rqQVPXuu3BTT
         dMxQeAFiCspT59Sm1ygXneojtZGCLanNgHn0NoovtbPndbK4Re8DjrntuvvEp3vKCnhS
         yvERnGG11hHezSrea65BN/wnD7BgcR14skMVdwfnszYWb9XsN6KixIEzBzGoe6qcPzTY
         +27JZlr2x5w5v2n0mUD3B6NjvoEiP2n4sFweNypOU4LnRGXwXpEDcvGxaApGjsnHIIEv
         IhIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708550588; x=1709155388;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2SSSSEzfunpVKo3VA6iNBnH3HhYtnjVDxAPoRZgjZUQ=;
        b=gZJceKJohdBJ4WcFAoWDHhswx1nFP/KNwxjs5UzP64u5JVtfuMg7lQZiviAWNsZTV4
         n15ep2NkYdCMpNusymt5Ddw4rgDZOdOTGy5mo9tSSKIPlAhpEdDoO5iFgd/in/veemgw
         T7pyUv6MNex+9po/fOjpIWkQtLkUJu+DPGoMeJJowegmxE/G48iCEMEMHNgYkdGM/UMr
         2dFmm52N+vFiWEiK9UBzNaNbjLe195oRPp/7LgpqcLSH8WE3ILi259C0avqhhAa3FBgQ
         ScJPPG/tIBtFRTwAT3nEBlIOSqEMhcA3Qxs1aF5oVoUeqpMsi3lNmfWr0TiQ48zDqXz/
         ilMA==
X-Gm-Message-State: AOJu0YyIOCTGdaaG3oe9iIJg35/x4kScF8nxLcrV7PVZVeuAGXaZqaQK
	Pp91x3dTsimStgzBWvm8lI3HcKbai9W6E1HjIpjg+I3uCP6OMK/0/eUa1+AcY7I=
X-Google-Smtp-Source: AGHT+IETkKAOcMl6EOtyDkXpzlXf09WLA7KktxIAQUyZJqVUTFRkn9d1Km8IRmcUakvpCDMyUAyXkQ==
X-Received: by 2002:aa7:d609:0:b0:565:26f7:4bf8 with SMTP id c9-20020aa7d609000000b0056526f74bf8mr357391edr.8.1708550587743;
        Wed, 21 Feb 2024 13:23:07 -0800 (PST)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id h14-20020a056402094e00b005644221a3desm4018764edz.3.2024.02.21.13.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:23:07 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 21 Feb 2024 22:23:01 +0100
Subject: [PATCH v2 2/2] mmc: sh_mmcif: Advance sg_miter before reading
 blocks
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240221-fix-sh-mmcif-v2-2-5e521eb25ae4@linaro.org>
References: <20240221-fix-sh-mmcif-v2-0-5e521eb25ae4@linaro.org>
In-Reply-To: <20240221-fix-sh-mmcif-v2-0-5e521eb25ae4@linaro.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: b4 0.12.4

The introduction of sg_miter was a bit sloppy as it didn't
exactly mimic the semantics of the old code on multiblock reads
and writes: these like you to:

- Advance to the first sglist entry *before* starting to read
  any blocks from the card.

- Advance and check availability of the next entry *right after*
  processing one block.

Not checking if we have more sglist entries right after
reading a block will lead to this not being checked until we
return to the callback to read out more blocks, i.e. until the
next interrupt arrives. Since the last block is the last one
(no more data will arrive) there will not be a next interrupt,
and we will be waiting forever resulting in a timeout for
command 18 when reading multiple blocks.

The same bug was fixed also in the writing of multiple blocks.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: 27b57277d9ba ("mmc: sh_mmcif: Use sg_miter for PIO")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/sh_mmcif.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 669555b5e8fa..08b4312af94e 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -653,6 +653,7 @@ static bool sh_mmcif_read_block(struct sh_mmcif_host *host)
 static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 				struct mmc_request *mrq)
 {
+	struct sg_mapping_iter *sgm = &host->sg_miter;
 	struct mmc_data *data = mrq->data;
 
 	if (!data->sg_len || !data->sg->length)
@@ -661,9 +662,15 @@ static void sh_mmcif_multi_read(struct sh_mmcif_host *host,
 	host->blocksize = sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
 		BLOCK_SIZE_MASK;
 
-	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
+	sg_miter_start(sgm, data->sg, data->sg_len,
 		       SG_MITER_TO_SG);
 
+	/* Advance to the first sglist entry */
+	if (!sg_miter_next(sgm)) {
+		sg_miter_stop(sgm);
+		return;
+	}
+
 	host->wait_for = MMCIF_WAIT_FOR_MREAD;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
@@ -684,11 +691,6 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 		return false;
 	}
 
-	if (!sg_miter_next(sgm)) {
-		sg_miter_stop(sgm);
-		return false;
-	}
-
 	p = sgm->addr;
 
 	for (i = 0; i < host->blocksize / 4; i++)
@@ -698,6 +700,11 @@ static bool sh_mmcif_mread_block(struct sh_mmcif_host *host)
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFREN);
 
+	if (!sg_miter_next(sgm)) {
+		sg_miter_stop(sgm);
+		return false;
+	}
+
 	return true;
 }
 
@@ -756,6 +763,7 @@ static bool sh_mmcif_write_block(struct sh_mmcif_host *host)
 static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 				struct mmc_request *mrq)
 {
+	struct sg_mapping_iter *sgm = &host->sg_miter;
 	struct mmc_data *data = mrq->data;
 
 	if (!data->sg_len || !data->sg->length)
@@ -764,9 +772,15 @@ static void sh_mmcif_multi_write(struct sh_mmcif_host *host,
 	host->blocksize = sh_mmcif_readl(host->addr, MMCIF_CE_BLOCK_SET) &
 		BLOCK_SIZE_MASK;
 
-	sg_miter_start(&host->sg_miter, data->sg, data->sg_len,
+	sg_miter_start(sgm, data->sg, data->sg_len,
 		       SG_MITER_FROM_SG);
 
+	/* Advance to the first sglist entry */
+	if (!sg_miter_next(sgm)) {
+		sg_miter_stop(sgm);
+		return;
+	}
+
 	host->wait_for = MMCIF_WAIT_FOR_MWRITE;
 
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
@@ -787,11 +801,6 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 		return false;
 	}
 
-	if (!sg_miter_next(sgm)) {
-		sg_miter_stop(sgm);
-		return false;
-	}
-
 	p = sgm->addr;
 
 	for (i = 0; i < host->blocksize / 4; i++)
@@ -799,6 +808,11 @@ static bool sh_mmcif_mwrite_block(struct sh_mmcif_host *host)
 
 	sgm->consumed = host->blocksize;
 
+	if (!sg_miter_next(sgm)) {
+		sg_miter_stop(sgm);
+		return false;
+	}
+
 	sh_mmcif_bitset(host, MMCIF_CE_INT_MASK, MASK_MBUFWEN);
 
 	return true;

-- 
2.34.1

