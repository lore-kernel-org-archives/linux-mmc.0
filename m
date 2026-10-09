Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7DD346766;
	Fri,  9 Oct 2026 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565402; cv=none; b=C+meYbOXDjRNioQ7vOA2UP2hf/37OMqYfmDiQLOdC1GmxVtepAr+0z5YCHIxAzOBFqJ9nwNIIRbT2LXZX9yhOJLkQyec4ta5JCXqMKTBtdUCFfxKpHP2QIfFJ2zfJADcnTykVJxFqdnsdHtnihR04G2mKeJT4X80FY5d2GGmAOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565402; c=relaxed/simple;
	bh=6f1LpMsqYdXKKTwjt33dDc9gd5rIMbQHizaUf5m5oHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xr6OMZ3/Cxxb5QMpeP/K0hGv0UZeTYP+DFJPmzW5+cwkKm4gZeqpg4mzZgqccKasF5XvtXmRf7dLh9DCpBWMcf/OzKGKnqmAWqoEZKTlHk44J2uEq0BXjyH89QjainYIYANql/CHZQGM68RGWpn0d9l3WSzwIqqwQseVdsgUGqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdoBGbBQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdoBGbBQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A578C2BCFF;
	Fri,  9 Oct 2026 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791565402;
	bh=6f1LpMsqYdXKKTwjt33dDc9gd5rIMbQHizaUf5m5oHU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qdoBGbBQ6L1e7NCwyAParYqJLZUYJSqENhm8CpY+rQdxUGchaCI8+Byc/q6HnKOxN
	 TQBpQQI6pnDOoHVr3vI1NNP26A4/jP8ivMuOJg/iOoNz0YVn636zO+Y3/sDppiY+oh
	 ZdpFIkTOGg5KkMmKxMD6WxLE7fkSfJHRMniOizJwkeAyB4hApGZo0sNthiEZjzc7Do
	 W03KmJAa/2wp96p0n2omEzhZwcom1ZGXm5ob72dfN2rRoN09/U0fqa9B+qoI5kC5Ai
	 SwIv5BqUgATaBeHMi3aFDTJGCb9vIuOxjEiQ4OlKA29tVK8U42YFR6DAtry+sAlokG
	 QKNZsLgyaIG6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C34CA9EC1;
	Fri,  9 Oct 2026 17:03:22 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Fri, 09 Oct 2026 17:03:00 +0000
Subject: [PATCH v3 4/4] mmc: meson-gx: report the longest busy wait the
 controller can do
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-meson-gx-busy-timeout-v3-4-67d0db3a8328@iav.lv>
References: <20261009-meson-gx-busy-timeout-v3-0-67d0db3a8328@iav.lv>
In-Reply-To: <20261009-meson-gx-busy-timeout-v3-0-67d0db3a8328@iav.lv>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1174; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=TPNNS8dR7nsAXzxzryfYbpCXwKfJ5cMjVjbSsbsPxOY=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFkn5cJP7UhOvhl3pJC5+q+JlMjNHnf9cjaBTye3+HiX3
 PK5PF24o5SFQYyLQVZMkWXCIY1bGUuu/vX3MH8AM4eVCWQIAxenAEzk6B9Ghm36Cqdmbo/T2LWZ
 //H6+Y9mpC1xXH1ukvTRtjRztfV/HiQxMuzR9vGeeOt7c96zj4WrlI16ZQUUF7EFKx9U3CD583n
 vBh4A
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

From: Igor Velkov <iav@iav.lv>

The driver does not set max_busy_timeout, so the core takes the host
for one that can wait for busy indefinitely and sends erase and cache
flush as R1b with busy timeouts of up to 60 s and 30 s. The CMD_CFG
timeout field holds at most 32768 ms, so the controller times out first.

Report 32768 ms as max_busy_timeout. The core then sizes discards to
fit and, for a longer wait, sends R1 and polls for busy itself.

Fixes: 51c5d8447bd7 ("MMC: meson: initial support for GX platforms")
Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/mmc/host/meson-gx-mmc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index abdb12e5f997..49df33bbd8e5 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1183,6 +1183,9 @@ static int meson_mmc_probe(struct platform_device *pdev)
 
 	mmc->caps |= MMC_CAP_CMD23;
 
+	/* The longest busy wait the CMD_CFG timeout field can hold. */
+	mmc->max_busy_timeout = SD_EMMC_CMD_TIMEOUT_MAX;
+
 	if (mmc->caps & MMC_CAP_SDIO_IRQ)
 		mmc->caps2 |= MMC_CAP2_SDIO_IRQ_NOTHREAD;
 

-- 
2.43.0


