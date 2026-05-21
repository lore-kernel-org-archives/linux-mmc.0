Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B8D361DBF
	for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 08:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352529; cv=none; b=S3a3R2YfdVvi7BFP0RDPgHshsVzz2w3MxmYrTw5oQSlattQT3RxE2LCXx/FUcys7tmaESdZzAR61jIzHhZBqrtb+sy5oU9KpdrZc77Xh99ezX0vPWB5bs/3OZV7Ihlj3Wfem8tdSv9H5d30rvPpX/3D3eYy6qLJp+9m1MpbuawM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352529; c=relaxed/simple;
	bh=wGXmQcXBJ4CLnbRRvSwkahCMlI0m3Tzi/ONd8+kGBFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TG+jhK8v5UYhivgqj7Yw0VNcR10cR3YFe++ZixNp4gf3GVblW5GhuvqCDDYSaRYeKTOdidvltigg11+Al+mL638eiAaurAdfP34k+2So6h232OUUGA+7rxnxEeqeBY6d8J46+byWMiCAONUC6zXyj/4Rn73+TAhzvAsChiNx8TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmYPKqSq; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmYPKqSq"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39393ec4ed0so54218131fa.0
        for <linux-mmc@vger.kernel.org>; Thu, 21 May 2026 01:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779352525; x=1779957325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vtxH5AimZIUuzoz3MkwL//rulf0WcV2FAeSBCKU/bDc=;
        b=GmYPKqSqfi9ZKtEHj942eGeo8ij6L+8aSH0rzEE7Jpq0KfqAy+zv1pW6jjilZAJhrO
         xW0cfhNUeBdUM6KKzQG+ThnPdTuP3kiUPB5VGxYSlMUfMfW5WjEKOpSzU50MiEPb4Fs5
         pK7T/464nMGbiNa8zdYw1trOrWl5HEGFDCgPxX338oSla7H6LgMMUJVb3ks/WxUDwuPi
         wKM7ID6xDW63+ZheQ/xFisPNtHfiwTi+UyHyoUnH0kHwH+r3dMbIYXePW+2Dal+xU6wX
         c+3FoSbt6LBhbC/CEyQwuRMYvNig/7zEKxolDaDv3XnmvrWQyDWVe269zXZesW6KzDTl
         Ml5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352525; x=1779957325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vtxH5AimZIUuzoz3MkwL//rulf0WcV2FAeSBCKU/bDc=;
        b=Ntz10tVkS1hhWqrGZMC8VEnDcDPQ9WAha2aVncWcrfh1B9xvStwFKAFfUh7yvAbx8o
         LrFM6V0Ev68PoZZPhWlQ8xkItuUNTVSKrd5BRx/I6ze7UiF5TU5C1ESLsE4PYngI5HlG
         Qsczy3OFqBLs9PL9VcD4TMjU7UUCF+fd+lHiMZfcrDQH5mjSIMtI1S/aJVPWpsofRDi2
         ILAboQL7F4/Y/Ab4M//Q4ljYq3NLymxSOL9JSiAcFcz3BDCSpj1qWCpt7ntDWk2k6Wnx
         wjBdbuDMQLn4ztiojGDk/rK6/ayOj9oclFLE7Lsfpa4ozWdPFm2BdVIfiiz9acXTEz9H
         6dPA==
X-Forwarded-Encrypted: i=1; AFNElJ+NXteMe3hetX6wy7WUIuOMcE22+8218oMsjy4DDSFYkpy0xwcXOXl7cyWuPp1otuihxe3EABLph3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDC30yI4mkXaYJSay0I3vQxkzIukL0isTWxpDtdFpT3x23nHxa
	zcCCYClH3JqlC39vryVWkYGKdhIkxqvoFoZnoraxfZIZR6OfmTAv+HK8
X-Gm-Gg: Acq92OEWlN9ROLCntNLkHXMYHlT831/w/ZoIZbol1OrMgb3oGMGS+t1mbJy/OdrazZs
	wIVx+Go3wi5hGIPGQjgmBWUbesfiz+Ov4RZXXfb6y0TdGL//IwZun1NGMBPxpjYjR/tRKXAo3Sr
	lQ9xuKVYR94IEf+/TY8R5y/kPCxsGeOO/FbGCg8JIGp0uCXvm/Ixf/nam2ppxj51z/xT0rv9rW2
	PZoJY+QD0EN3wVdK4hJnSoE2KdhYrbRWnoaerqBBpJEySwShYVV8LmjewyUrspfVchodFlaYdSk
	30u2/hPOr9NTXjT05zOnuRNKn/8dnAQv8QAgZLltxEtc4+vfIv1C3T056/J3oE7i3DVcDyC5u/k
	SvFebtLBoGhPPxN3ZWOUSyk96wLZdeeNDzdD6uOYuLOGvV7RMfPgu7loUHV7Q+XrolsBQthRvTG
	vbfwWPOJ5D4n92sNmXDHSk9yNoaaZ9lPVPhlNUzkKs
X-Received: by 2002:a2e:9581:0:b0:38e:96b5:2f45 with SMTP id 38308e7fff4ca-395ca55a41cmr5599741fa.8.1779352524344;
        Thu, 21 May 2026 01:35:24 -0700 (PDT)
Received: from NB-6746.corp.yadro.com ([91.132.132.206])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395d0b68afcsm917611fa.32.2026.05.21.01.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:35:23 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@intel.com,
	adrian.hunter@intel.com,
	ulfh@kernel.org,
	p.zabel@pengutronix.de
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] mmc: sdhci-of-dwcmshc: remove redundant IS_ERR() check
Date: Thu, 21 May 2026 11:35:03 +0300
Message-ID: <20260521083506.356422-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260521083506.356422-1-a.shimko.dev@gmail.com>
References: <20260521083506.356422-1-a.shimko.dev@gmail.com>
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

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 4cccd6e42e60..925fff1c0f3a 100644
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

