Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FDB39A067;
	Thu,  8 Oct 2026 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791469687; cv=none; b=Sc3/ICyKcalKbgpzdlL8xrlUWlYwJ6GhEUGJs3ikm+qjSdAFBE6CpEaC7AHDiJAZFiJAtQBENSXOIXtVc9rTwcyOpRBZirxawXsDF1UkzbzcjgGfZw1icmEhBvuGrH3ycdfaSPvkdXTv9kBF7b/9F6CV974ih5Ajvkq18Y4oZLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791469687; c=relaxed/simple;
	bh=DrHdRsl5OaG1ReiVzaV8FBPEMya2B3gIklm4dNe/3Z4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XfZ9gHdXB/afJ5nC7twFthLOoPDexc1UfyhsLZS/XO+7jZohInPLRFpkan3hNs+aNKfXPe6PdTM2RLisAnEDNRkGnDhOYnCe0UiUnN4A6llZm+3mv1k/cRSGmCedwNgXPvxeqtWwCP9HGeZrtOI0RjUg1MeyOFSZ0wkWrkYD0As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NETPE0MA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NETPE0MA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A589CC2BCF5;
	Thu,  8 Oct 2026 14:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791469686;
	bh=DrHdRsl5OaG1ReiVzaV8FBPEMya2B3gIklm4dNe/3Z4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NETPE0MApWoqCn+Q3CzxnqbYZPHrMMUf75jrYbe9uPFuhTfPtBA6kPqlhy5oLHwCr
	 uW/PuMvk7RtFit0J5mDa/vsvor57YmHBP/paoQWc5i5ocmv6EiZctOmTHuMA7HGzVF
	 tgAfZq4wlADX8K7U0MvPZOKKKyZlrcrFZh8HRLwPu483TArNMJu+VjaTJdpNR6Pw7y
	 M5XS2GVr+ylc1Q1EGGZJSeaSre/hsJbVPMmSXUpKMxEFIfzhP3h5z8Mfw1Svlbpq0r
	 90Qs+iuJ6Zr+9kBdoc6edVHrirA8gjxuM9YEm1P97J/iVzcxTN0R8LniqeHae8bJhb
	 Hsc2/hhMplubQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AEBCA6007;
	Thu,  8 Oct 2026 14:28:06 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Thu, 08 Oct 2026 14:28:01 +0000
Subject: [PATCH v2 3/3] mmc: meson-gx: report the longest busy wait the
 controller can do
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-meson-gx-busy-timeout-v2-3-8bde1adfb5b4@iav.lv>
References: <20261008-meson-gx-busy-timeout-v2-0-8bde1adfb5b4@iav.lv>
In-Reply-To: <20261008-meson-gx-busy-timeout-v2-0-8bde1adfb5b4@iav.lv>
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
 bh=/StF9gcFvUuHJEY80/0V9uXgKqu0N64QncOwWv4fwhE=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFnHV5Rka+6/LFU2qb5wV95ljQstz215ZwU9XcN1LyHr+
 5Wvc6ZwdZSyMIhxMciKKbJMOKRxK2PJ1b/+HuYPYOawMoEMYeDiFICJ/L/KyLD7w3sjpjj1NrGJ
 2cYFixzX27tfWvJx9w0fx5QWcaaEbcsZGToyxSam6TZkTKyb7m390egMc98e7f/bKq1q8pbkfU3
 YyQAA
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
index dd7d3d67f029..8de3eb65ccb0 100644
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


