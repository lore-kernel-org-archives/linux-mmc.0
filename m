Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F85F3F20F9
	for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779102054; cv=none; b=UDhpt4/EKYFlHuO+wlQ8V0AyoYJxqDJrwjl5PHAp59dakNBNnBTvotuCTmCvhz5vlQwuhn5WoQax14IVW9B5tkQncwpabg5qUc2cNuy3aGf1jTTjXqSRLQn7xbpBnSZmt8w+pwOh++pxAc3V4VTzrwPaWCgmaPL4ifE4KJ7ujw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779102054; c=relaxed/simple;
	bh=CG4sNB/X7mYFR/iyKu3Bu+fMMI6VKefBNED4rCak/hM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRK+WT4tG7HEpVzC3uKoupo/iOqR9WLK4xHjNnFkBEV3wLBU8uaVBJBQAAk7Wn53dxEt8J85v8YmueVkRLIFHV+XBz68TEWWaxUk2SnzHO0j/3IlC4oQ+zaiwub9LXeN0IYdM7i/Kz8jwWUOL+t2OJ3gcABGBIMIXcpgzn5lElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p161nVdn; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p161nVdn"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a8e33556c0so2782813e87.0
        for <linux-mmc@vger.kernel.org>; Mon, 18 May 2026 04:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779102045; x=1779706845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvJX+slfx57snLGLCMB+OXIo54ykizFHdlL5Gp1Pnl4=;
        b=p161nVdnKqubVEVkuQbgIW5UM4PmIMDVRQdDChT8RvMlDAsHqyStl+b4w+H+2TIPhG
         MuVaMlVx6H+wglDlGnbwjx7kWS18hp+ehuv4jfrFhzu4sMCxiJf2aKeDs2YjmHyPDyQV
         F7d9TtXiETrMRU0hQKR0jHQKh8HhMulxiPwzCPtEGYg/kOe3EWyAL/oEXQdMnCM+bneH
         O5srq2x0WZZmTdhL1PgdUxQH6Hg0Y5ST6i5Eacn8gF1Xx1Qg0pWSeY6ktEEVly8V3kE1
         VrN1GNp4XCG6s5/2FqVau/dGldeKzVtyET7+Ks0rfMODaXkGkRVqjioz5MY4pn8W3g/a
         JzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779102045; x=1779706845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JvJX+slfx57snLGLCMB+OXIo54ykizFHdlL5Gp1Pnl4=;
        b=Lx81GhWBTx8tAdA6GvuR6LehvAoMV4I3vDWbu3wuzph5zeeg+9Nw+MbTMODizwz5Y2
         mz0Z8z4vQ/hwUSsJwvUsxDslWpa4Ss6UUC/KjaL+GH0wbT48uXtIaQ85Bfv9Iia1ye/W
         8ocNNPcHJq900y64yO36ULwJdRo8lHbJrdx3Z8APdYCUbS/6hkIf3mLlgoIQSxJXztB+
         mxNrR6TP96OP/SC9qHIy0x4CO/PwFw4233UmVEx8Vuzbx3+KBzTXVox0i88Xr+E3igxc
         8yuAe4nqzJM059yVlg6MjUSyZcrGC5UlESUiDrqR4cbicv3/cDnkYFCTBDRdRJ4cignC
         VCrA==
X-Forwarded-Encrypted: i=1; AFNElJ89QwS/w9y4MFLfMUNJGjoaFJaG6Xv6HgviDx+KLinQm8jG0gjWRaxAQzJTJcgmh+UkjCNAaZuZVCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTez2iyEA8doKJUSHcgUIDdMnHyN3QU7iqw2I8aC0K2y2Cr5sT
	Z8qlYuf3z9OVOvF9CDyTnW9nBkdHKZxDRENkyoQp98x6BIxNq2FFfuLI
X-Gm-Gg: Acq92OHi3mZOaFOrAu3AbzmFKzeM/Z1lFAsnu6ORRBQJ9EPko5MHA1LOogb3djq2cE9
	78eUI4/gUDJwsCRchDY9EWr/jOzB7y6jlfWK1G45RXXT+bG14FyhJhm2D1F5+l8ngue0nLaMtc/
	35v9QZJ/z2+BoKH7rvmjV8KyVCr7xR/eiRKs8jYMMC9j835FFc2HXQKBK1jnUhzoftcsOGtyC/d
	Glka58RPA8KQjZnqeGssf0l5hbH86iQCG0OB/ApSWt4yizQFR0hW3ncYaoq63A7+kJudOKzxAwK
	V6Q1WBvBnsNc/NsB+xbvYdjaBC9ou4NvT2iR72GlI+69GucKPTBBQxQsnwY5HzgFztoBejyYnJd
	Zlx5TFEWCYtIbYGkhaJoQT0NMEsMxJ41437ViON/2WO/kY+pN+OxgXKBsVBjEDTpsqAC2DN/ymL
	6QjOyUyQcrpZWxOxF9JuD+RljQ
X-Received: by 2002:a05:6512:114f:b0:5a4:175a:f821 with SMTP id 2adb3069b0e04-5aa0e09d0a6mr3470924e87.17.1779102043360;
        Mon, 18 May 2026 04:00:43 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.222])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a9164bc462sm3239263e87.45.2026.05.18.04.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 04:00:43 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@intel.com,
	adrian.hunter@intel.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] mmc: sdhci-of-dwcmshc: remove redundant IS_ERR() check
Date: Mon, 18 May 2026 14:00:32 +0300
Message-ID: <20260518110034.142587-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518110034.142587-1-a.shimko.dev@gmail.com>
References: <20260518110034.142587-1-a.shimko.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The clk_disable_unprepare() function has internal protection against
ERR_PTR and NULL pointers (IS_ERR_OR_NULL). Remove the redundant
IS_ERR() check for bus_clk in dwcmshc_suspend() and in the error
path of dwcmshc_resume() to simplify the code.

Note that the clk_prepare_enable() call in dwcmshc_resume() must retain
its IS_ERR() check because clk_prepare() only handles NULL pointers,
not ERR_PTR.

No functional change intended.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 8c3ca47c8060..29bb46783ee5 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -2564,8 +2564,7 @@ static int dwcmshc_suspend(struct device *dev)
 		return ret;
 
 	clk_disable_unprepare(pltfm_host->clk);
-	if (!IS_ERR(priv->bus_clk))
-		clk_disable_unprepare(priv->bus_clk);
+	clk_disable_unprepare(priv->bus_clk);
 
 	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 
@@ -2608,8 +2607,7 @@ static int dwcmshc_resume(struct device *dev)
 disable_other_clks:
 	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 disable_bus_clk:
-	if (!IS_ERR(priv->bus_clk))
-		clk_disable_unprepare(priv->bus_clk);
+	clk_disable_unprepare(priv->bus_clk);
 disable_clk:
 	clk_disable_unprepare(pltfm_host->clk);
 	return ret;
-- 
2.43.0

