Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A82CEEA8;
	Mon, 24 Feb 2025 05:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740373249; cv=none; b=Qk2wjFOFgyHyeVeE8jpJXmVfg1UUj5axSYmNTbY2FVpPFPE/WYlEX5PpwaZbHDMD9sXZqOPpsrSPO20sI7A4IizZ9Upr1giys1DO2ThUteDBEudm1V6dcgMQHCLwDPbaOe1QgHzM+nvzb+4/Eywk3BxzoFxSyDRMGEGS4ykNcZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740373249; c=relaxed/simple;
	bh=7Tsgb1VlBaToqdFqXP6tBkBm+KcvCBhRo08kXNZs+Ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cap8z+KECtjLOy8BFnc4Pr4UxHVzwj6IrKOv8FjEkbVLwUaor30ntFhpT3m5nrcdgJbWR5mocMO1s4AIRRkHHfQ5zhN8bFClJXwEYEECYLK7DlVXWwKwavJRtorSMo1VuCXpqvmgbksviMpgdCwN+1UemcsXxGeWtJnZHD/Tdn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7kNwocy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7kNwocy"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22104c4de96so65754985ad.3;
        Sun, 23 Feb 2025 21:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740373247; x=1740978047; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QdRQnj2hju2Gq755DtSZDoUs9iYpMcUoX/lshJNhNI=;
        b=N7kNwocyEb9Fw3LtSdvcDqj3iwO5n8n7hJg4r0hKLp4WnK95go6N9bVYsrjn6tGs8u
         IZVW9lbD5wqbUxg4+mUihCj4+HUTeqsY3c37r1k/JTRP+Pu0C0WQ7pG9gcosgVENzFl4
         XVIghhoJCUe/sg1BGziOp7zws7963PYaYGgY2XVJfQp6tRyI0JDhNvEUq6pJ6jBZVrvG
         A7/V/Nz78t3wp4mxeh5HuU1dkQ/bdH82IpAOI3/uku3zZU9BftMSS7fpxhou90QOl16u
         YtKJh3tjDWcCcsuTd43APmEidjyAaT+f/DwfkTxrgE0HNsnRtp791JADITBfo5bDYk/u
         kn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740373247; x=1740978047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6QdRQnj2hju2Gq755DtSZDoUs9iYpMcUoX/lshJNhNI=;
        b=oV3AyyfOzEWVM5PUTAFRxW7liiQPcJxeextN7y77M87zjlLGQ3FaI2zCVbVmoufIVC
         +C50c3ZzUjuZk43DNUsNCCHTibvTWhRgm+BbchSJ5hgzax1z2ZP5OaLEya3P5fJPYjgR
         t65gAS/s8HY+dqsxzW4eIQmPvUsOwUBsvQccycrT5DvZ/pxcjUkroCsznaIO+I+/xqru
         EDYSkYLLvvMyRVgW7LljcjCfwOOBTqxqiH3bDvA2NlcoTiUxMW09NaFJ+9bkQiLo15FI
         hhyWDkS2HDBcw4UeXqK+g4wa9WsR3C8UCZXg5uuBvgi0Qcai+ObovjO7qVWWgqQr4wnO
         JisA==
X-Forwarded-Encrypted: i=1; AJvYcCVoWX9o7rPPwnEw4bWVwl7sznnSToGYmF9ty1vzRemq0gQdpZRgD3+3QjzG/XVKwxumW9cdWpHddFuVVNM=@vger.kernel.org, AJvYcCXIsFszQ8bg6Gsthny8uZNWL4KwOumAUj2DuTDpRU5r1ixKrtbFi/ibQjEwQMzzVDCOOavk1JIVz7oq@vger.kernel.org
X-Gm-Message-State: AOJu0YzxHyWVjyv+jffMXcWIk5lxmZax83wTw2DOf/mDTK5ENW4TrD3I
	3619qlpsqg0zMnHFOBrr3I/4EHYQYBI2e3zCX8lxL3ScCpX6oCvL
X-Gm-Gg: ASbGncsrVUFqc/AFwkUCC86XHiQqTdL+mS5AzOjwMyivLY93rbHI84UKDl8Lm78JHT0
	JL4Cf+sgg0e2CntrrITrKbxnnf3AzbSlc/ePelNiGa4uTW2zXOj5LlrgWIcgfCH8meInVLDzpsd
	2QQVlX+N0+uqb2tOuNpqiDbUQRzm5R+Ds9onHe2YtuWN8DCWtk+7hAx2psEwdwkKqumw1G+dkVT
	T6Sk+PKi1/NFMcyYn2e4vmga8AlXq5EIbNhILtlpFvCYe9sWF4vcpJ9xdaBl3h7kEiDjoD+ZYhs
	wOK6FxM6kEyknXLGez6wNRg/U8OgnVVyGTuNOaVInmbs2Sl4ef4R
X-Google-Smtp-Source: AGHT+IGsIF87TBSPJ3DZAxX8nALQtN3ooza/Y9c/kL86lpMIqw5PDJoF2uQac2kMFvONxXnK+jn/vw==
X-Received: by 2002:a17:902:f687:b0:216:7ee9:220b with SMTP id d9443c01a7336-2219ff61d84mr213737735ad.22.1740373247391;
        Sun, 23 Feb 2025 21:00:47 -0800 (PST)
Received: from rdbsd2.rdb.adwin.renesas.com ([128.1.49.169])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c8e7sm168547305ad.122.2025.02.23.21.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 21:00:46 -0800 (PST)
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
Date: Mon, 24 Feb 2025 12:59:18 +0800
Message-Id: <20250224045918.3321394-2-guan.wang.jy@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250224045918.3321394-1-guan.wang.jy@renesas.com>
References: <20250224045918.3321394-1-guan.wang.jy@renesas.com>
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

