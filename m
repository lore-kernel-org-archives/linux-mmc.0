Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1E0199920;
	Mon, 24 Feb 2025 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740373213; cv=none; b=svKmqyHuNYsaGe8n0TmPvDmwfb0QEi+YYrqg8KtV+kQ2iRtgLk/9R4WIcYHqqHUj0L2LDwaYchgbD58+H3HhF/YiRedT8hDcsIctdPQybcIXMxXylLcVI27SOrfOQ4dwPk4pCvgs88U302vdL0zAqfxRXIwFElcQm27GT0vRVFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740373213; c=relaxed/simple;
	bh=7Tsgb1VlBaToqdFqXP6tBkBm+KcvCBhRo08kXNZs+Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sLecx0C/TOwlZkgYHGOT1ZFwS7mUstCE00tHflG20lr6euDXRKGDUE3U0bRLzkvhPGk+ONjK5+hD3qog/Wu55cLPhQd+Q+iRnIjzP4Ulz9aRyC9JCjUB979jrUBCdzuXUIxLU+LFQAVyP9/VFGQqndEnte37HOeXo2Sop/Oz2x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aBIc/zCb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBIc/zCb"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-222e8d07dc6so6446745ad.1;
        Sun, 23 Feb 2025 21:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740373211; x=1740978011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QdRQnj2hju2Gq755DtSZDoUs9iYpMcUoX/lshJNhNI=;
        b=aBIc/zCbqX1Lag0V36Yu3T8DIBsAXuKD0xOWc/s/Uvo+aGy4nnn+/hZhRCaek9wmr/
         +sRcLZ7C5TaHzxgeFOAKn/A7EEU4iphlfPtwFS8QJYderM/JVDa7cK/y+3JoWvvVPPjc
         Nyu5TrzPPYxa0sDGzHiZD/Z/HQx9e7s+k1pdm3+Zw1zr+9X915qr15b9tMtJo2sbFzOb
         KeVrk6idsk0kGHjRAtnn96T7Ct0dWxfTt0tu0jEi19Ms4d2foFnQbgrKdQYQB+0YqPnZ
         DLkxqxKX0oN0otdxPNY8CAtk3LcdpK/wfjSljVJtgBSCw5A5pplqN77GSikEnr+kkaMD
         1d4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740373211; x=1740978011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QdRQnj2hju2Gq755DtSZDoUs9iYpMcUoX/lshJNhNI=;
        b=pQoQ7Qw/RiqusMX5HkyaIKYDbWob/oF0oN+cyrlDAEgV3o90u/aRhw5rjTFoLK55gd
         YPI4ddvRUffcvqIATVydoJJC/k3pK75W8kpWHwmuVEBYszEOFMpnn2IJyBpwW1ga2g1d
         Npkz4tHrq9hTkCNm+bbTymPOtLW4JuWFL364qde3sGOjq0OimtMLe1jNvkY5BczYVBoE
         wmrE1vMQxB8uHUl1kFDI/QtdfaUpYBxv7KvTieTrOCQDGWlZpyX66LjH9h0C5D/OPZ7C
         aXCE3UN6lI8iJ7zereRnONdrgzT7cF43fVLUT/DcDdRx8Jh5iNnu5IntOql53WKOwLjy
         94iw==
X-Forwarded-Encrypted: i=1; AJvYcCWX7DfmFI/W0L5dUp840DT0XLOwI9VgeiFLDtNWNrbiMqlacMJFS9BeCfUXtWKs1oyZPGHq32MtjiX1GDY=@vger.kernel.org, AJvYcCXqg1SXTWNVGbo3Z0nFY5EiwSNKM+0q7PUX9SvXHw2v976RIIyOgBOLGZQ78QLxZFyoyL2CMmZ7nfwp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/r/CyUXz5ZVAVTPlRVZd/Fvd6nyZqMSzvfcVznXoB17TlpODU
	h904JKMU1SdEl4z6LIN2j7v434gKKThN0tzusmSbL7UZDY0mEJt1
X-Gm-Gg: ASbGncuLIFZkzmkR5tpOvDhCKhkQYCN+P/9M8n6uvS0DU/J9fh4hy+W78ncp8H7Yojy
	lXGWsyoxmss9VMQJwdBOVs17uirWWNcPj2iPnpqUbNyLkPesu3oG/0STtev+CFdv/H4EETy7KTb
	FpMfkj637sblI+YmjEXP3CyG0TsC4ehAYJTmDKNMSJLnmfsGHj87xH/atJvKDwLRqzpdA0HBT0I
	rH5D9Mryp3gxQqpakBn4PQeaNUq9m3K4ChssYPH6zQwS7GqGdDBMmoo833WOoqNMDt3Dv2Oy5j/
	SWb99oOPeToL4aydfR6AuFXnkP0ne/xYnoPgFlBIH+OTYDKmmGEb
X-Google-Smtp-Source: AGHT+IE4nGagFLEupnjXlfzHS9sWSptGRd1fldH/YrIat/6FgEJhQZvn9iqG8LUDaOP9Ap6sAX7XLA==
X-Received: by 2002:a17:902:e805:b0:220:cfb7:56eb with SMTP id d9443c01a7336-221a002cf37mr206594795ad.26.1740373211049;
        Sun, 23 Feb 2025 21:00:11 -0800 (PST)
Received: from rdbsd2.rdb.adwin.renesas.com ([128.1.49.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c8e7sm168547305ad.122.2025.02.23.21.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 21:00:10 -0800 (PST)
From: Guan Wang <guan.wang.jy@gmail.com>
X-Google-Original-From: Guan Wang <guan.wang.jy@renesas.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jens Axboe <axboe@kernel.dk>,
	guan.wang.jy@renesas.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: block: add reset workaround for partition switch failures
Date: Mon, 24 Feb 2025 12:59:17 +0800
Message-Id: <20250224045918.3321394-1-guan.wang.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some eMMC devices (e.g., BGSD4R and AIM20F) may enter an unresponsive state
after encountering CRC errors during RPMB writes (CMD25). This prevents the
device from switching back to the main partition via CMD6, blocking further
I/O operations.

The root cause is suspected to be a firmware/hardware issue in specific
eMMC models. A workaround is to perform a hardware reset via mmc_hw_reset()
when the partition switch fails, followed by a retry.

Add a workaround that:
1. If initial partition switch fails after rpmb access
2. Performs mmc card reset using mmc_hw_reset()
3. Retries switching to main partition
This helps resolve cases where the device becomes unresponsive after
RPMB operations.

Signed-off-by: Guan Wang <guan.wang.jy@renesas.com>
---
 drivers/mmc/core/block.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 4830628510e6..29388786624c 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1174,8 +1174,24 @@ static void mmc_blk_issue_drv_op(struct mmc_queue *mq, struct request *req)
 				break;
 		}
 		/* Always switch back to main area after RPMB access */
-		if (rpmb_ioctl)
-			mmc_blk_part_switch(card, 0);
+		if (rpmb_ioctl) {
+			if (mmc_blk_part_switch(card, 0)) {
+				pr_warn("%s: failed to switch back to main area, will reset and switch again\n",
+						md->disk->disk_name);
+
+				/*
+				 * Reset eMMC device if partition switch fails.
+				 * Some eMMC devices may get stuck by write CRC error in RPMB,
+				 * preventing switch back to main partition. This workaround
+				 * helps recover from this error state.
+				 */
+				mmc_hw_reset(card);
+
+				if (mmc_blk_part_switch(card, 0))
+					pr_err("%s: failed to switch back to main area even after reset\n",
+						   md->disk->disk_name);
+			}
+		}
 		else if (card->reenable_cmdq && !card->ext_csd.cmdq_en)
 			mmc_cmdq_enable(card);
 		break;
-- 
2.25.1

