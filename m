Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730653;
	b=drUXo/5qknRsiP9Qhql4ta9aKeEIl9wuRDZ/dYMTBW2A+LnIWom8ZDmAHxrx1ZXeasCW
	 oMl8Yuqq2i0Fe4wHZWmIefUmP9wGDOV3L9qoql7sk3zakpioPh7LfCY3wx2eWDi3h7igE
	 vrLuFPe8M132OMseHcUKlo7HZswnI+UdHsqayJf7lX+/6zrIAltU77SvAoBNeW2Pqrn3R
	 0Tj4cwKEOgj1owjcUo4Jm2pgLhPq+M75b2/6U458/oBy/uzZkJKZdv6S06l916Dxezu03
	 c/dl+cRhIhLJLHN3R+zRyIebztbNxCLCmJPtgNcaeTsq1PybzGP+8j2/Yd1cD3gvdWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730653;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=3GsiDmClXUsZuQhYM79SYeH9oaXJBKEF/AnaKpHO+KY=;
	b=MDX7Xd2QodVv+byUf8HqltAffkRAZlVPx2Pz8TnxkszOQEdiJl3PHS3I07Qk6BRqOcGQ
	 yWsfnlFA6GYKjbWe44iJx6gwoI4wb+LCe0l6NTHVO2VjoHmrIUKOtmmRO9QrV+tGt7M1S
	 e23ODc4BS8nncPkMAY8OE82v9oiEsOIvWTUjOgxF7VXGGIKnWcVWpL61TZtkRVn+QnZcy
	 mlPnH1ovh1D7YbhSIU/qehm20R0RMHyXEsQIngcplG6lvYTTCMP4vaVnGTXDWooqvpHDq
	 anxQw027gQqsJ/N+sFg4geYzXls/DtU8HvkWwK/cBztAkFtyFYCEzl35eZlpBTdS6yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2796FpU;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC29606A32C
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 18:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CC29606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=d2796FpU
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a208d93758so48074405e9.3
        for <linux-mmc@vger.kernel.org>; Tue, 03 Nov 2026 10:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793730652; x=1794335452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3GsiDmClXUsZuQhYM79SYeH9oaXJBKEF/AnaKpHO+KY=;
        b=d2796FpU5fg7+pPLgDfZuaHg0vWJESQuG7eQifI/1ZPOBFdkWQ0rjuYLc8vkVZLg69
         tpT8e/G92EeQw+Xo2gMF0SrE2BU152EYO1VxuVt6is/sQa+huMcsafMf6ErjQ5qDYura
         XHPu9inmeYSQr3YAjdvU8Nz/fvGFH3HRXisW70RWAH6Fx8PaIoafhBfSgPN7ZjR/Wcrb
         yJFSe/Ko0vItmIZYukLKg4J7noxCvr1ZygvpuDhN7oNz8eUPdytB5NzNsBEwtW4nExxV
         vipdSwT3IsAy38FIyhg6yoEeRjZ+E6gGwNnL0OlHBsc+o1GWjTKxtnFVFJ6a6s3hWbo6
         Y1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730652; x=1794335452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3GsiDmClXUsZuQhYM79SYeH9oaXJBKEF/AnaKpHO+KY=;
        b=0jLqaE3dwy/z2ZAa34lt0ZHU0xyhXEy33tOZSmWkLJjqHr6G9iCw5XqkdK7fBMu0P2
         UmssLjszIwuwQFv/2pVIZMqIyEA/ic2bEXtdNaiErHt4V1RlbrROlDq1AxzMPfUu2thw
         55qbnAAQ7KqqN/Z8ZR9bbag7KUlYo+dA6g0Rp7Syxc9IzzCXSm+2YyGqfKd6T7h43fT5
         NqTEpzEo0tkOKD3Lc7zivY9KGue6IveoHeyK2ne+6PYb8gQcLcMCuRUNMEi3KPCEsjm8
         QRTy4T1ZrSLTHQiLl1pOvJhjA8PJ0w7oRjhNuRYOr0MODwXyyslAV23oeeISYqzOoYgG
         vl8g==
X-Forwarded-Encrypted: i=1; AKwUvByIVibMvFXlMQ6cr2Q7T7g/UWteenr88sOCeFpcOfuD+gi/dC4AbH+0XNH9JWicQ4ud+N+0GDVS2xI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FDQWmGtYQBDynTDsRR/gQZt/N/y2X8GcG08mVBF2AFz/n13jh
	ZlkyTlHXATTj107Zj4Cv2vJNRLebbJqv1JtClYBcf/biDsw9NIWzNMe2
X-Gm-Gg: AYBFou1hTyA5aSrYAjI42vqfpO9zquYj1ctlkahCktuOp8Btzc0cF2Kb3blq4BfSwxZ
	pXWRDRkTAmkEhkRbkg1Uwzadn60MQBpReXL7rd8tOsJ4F2lV/WJ4ZDrFgg5VGUAXDrGe0XsMrvz
	3RM4MigUzK6frQtZRpfwGcrogd041IKvA0Ut1FTRqDysoyQ6Nfb+O6p7DkOt3Yo3Ieb/YSnO943
	yqJw+QmQEi6st40WWJFrvQB/He3+Tt+rOiXZxb3RRM/erM7VXsQYAuLEHR7Yid8z7fO0XXyYl5w
	oykwFNZXgXNCn/tfynoufuocz5me8zDnbyguQ7Asn0N49AeLPpOXKhRQMJ2nHkDd2n6WmMkW/rU
	vCAKxfAOjWDErULGL2CvDspOIkACJgttgRgEFVgkaVgdorWyDyQBL6PegwEakuHmcM55PYsPvG/
	fBwlHdgpSTlSmD8RkGpg/rHX27VvnBnE6yGN5ppBRX9OG837VkrSeHmzSHZ73813m4pW8rHn6fX
	+em5ZFt6xrR15XRXOw7jeZcCxft8TfkezjDOqEx4iiP0Q5W7o2YkgnhshX3HETNCpJ4atZcSQd2
	SUklLK4WHj5svWuvDNZi6s0P7xlgO0V9wlu0TxB6W/yXNzb13xvTWQDm9DVFLpoN+2nWgx9CB/9
	o2zsmYoFxqMivj3tyfJhKo4rNa5d2WGD1CaRPgvovheEk21kvXclgP5a9mXvZv2S8OQUiyyUw2Q
	WY6UpiInK5MR5wwg+7xoF3aiXQdeyPK3wXZ8v5XxDQn/wfsYZ2l+s2SY+W8loGJK9GodMt0XXVI
	QY2OcfMZL0dTYkzbrJPFARkWwj7yI14xLebq7VCQ8bKYT0bRg==
X-Received: by 2002:a05:600c:1d29:b0:4a5:5fb9:5d35 with SMTP id 5b1f17b1804b1-4ac187a7678mr340616585e9.21.1793730651873;
        Tue, 03 Nov 2026 10:30:51 -0800 (PST)
Received: from jernej-laptop (194-152-27-116.dynamic.telemach.net. [194.152.27.116])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2ab00ff3dsm146339785e9.14.2026.11.03.10.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:30:51 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Anfernee Cao <anferneemelokc5@gmail.com>,
	linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH 1/4] mmc: sunxi: Report manual stop errors correctly
Date: Tue,  3 Nov 2026 19:30:27 +0100
Message-ID: <20261103183030.81078-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103183030.81078-1-jernej.skrabec@gmail.com>
References: <20261103183030.81078-1-jernej.skrabec@gmail.com>
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

When a data transfer fails, sunxi_mmc_finalize_request() sets the stop
command error to -ETIMEDOUT and the threaded interrupt handler sends a
manual stop command. This has two problems:

- If the manual stop command succeeds, its response is stored, but the
  provisional -ETIMEDOUT error is left in place. The request thus
  completes with a stop command error that didn't happen, and as the
  block layer only checks the card status in the stop response when
  the stop command didn't fail, errors reported there are ignored.
- If the manual stop command fails, -ETIMEDOUT is stored in the
  response instead of in the error field. The block layer then decodes
  it as an R1 card status with random error bits set.

Store the error of a failed stop command in the error field, and clear
the provisional error when the manual stop command succeeds.

Fixes: 3cbcb16095f9 ("mmc: sunxi: Add driver for SD/MMC hosts found on Allwinner sunxi SoCs")
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 drivers/mmc/host/sunxi-mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index fe4c0f6d73f3..9744b6b860ac 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -470,10 +470,12 @@ static void sunxi_mmc_send_manual_stop(struct sunxi_mmc_host *host,
 	if (!(ri & SDXC_COMMAND_DONE) || (ri & SDXC_INTERRUPT_ERROR_BIT)) {
 		dev_err(mmc_dev(host->mmc), "send stop command failed\n");
 		if (req->stop)
-			req->stop->resp[0] = -ETIMEDOUT;
+			req->stop->error = -ETIMEDOUT;
 	} else {
-		if (req->stop)
+		if (req->stop) {
 			req->stop->resp[0] = mmc_readl(host, REG_RESP0);
+			req->stop->error = 0;
+		}
 	}
 
 	mmc_writel(host, REG_RINTR, 0xffff);
-- 
2.43.0

