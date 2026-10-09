Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8743546EB;
	Fri,  9 Oct 2026 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565402; cv=none; b=p1wnU30iryCVyAO2K1A3tuexBDt9t/36ChfVlTTL8a3AJbksBCtRPDXJbaF1dYQEQ1OnTIis/BB/z2jK2SnGoA4wlVJU/f7J9Cg2OkV2WEuUzFtJoTI4VdKWSsW6CG/OlrfzLqgEnVy29RxOUtxn/C0i9YBfAlY4KkMdR1kxwrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565402; c=relaxed/simple;
	bh=5DwUWAKSr1Fz3uVRimgAXIltZpEF1NVgVNHWQpWXomw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P8kGK0nci5MtEgtHCL/E44IrGkIGMa5Gfkx1repop8zUx21hEXAO53Yx7K+ZRfZWUPHmuYNGd5yOSSoZTpOg+SP0SXhfLpN+uyrgD6YYzruWPEo3uzfLShmy4PCRSpfSCDp2Akyp8gY1xHzJRAibBQrGrhcp6vZA9eqQFIZYy1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oFO+oIqE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oFO+oIqE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21AAFC2BCFD;
	Fri,  9 Oct 2026 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791565402;
	bh=5DwUWAKSr1Fz3uVRimgAXIltZpEF1NVgVNHWQpWXomw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=oFO+oIqEISM77myiwY+C0bbGF0hGdh3Wyc11/cWL19O+52g3ytciQBjw0uzDVDzc2
	 jpJaj3X+v/K+SojmVnGKsd7F+iALAxt2306CaHkwUQiyU7Y4CAd4bNZuu0bwk4HjyX
	 suAM63pHhOucvlp5q6vJLyTHtEZhThgeXCLEQiDf8YMC5ZYYmCtg07iEop5u8rwCx3
	 Wblo/4Ca9FEhCjZo/bon+OrenzRss72IyA/HFC+S5NbNC7+Z9udwKMKLBnflqqlFyy
	 o/vvIvXw2AS6KZbewp+kaYb0yqqnT1kQwOMsD1eExj78TDsGXdJ8mgm/c5QLQ67AzB
	 iua6eHbGmgiGA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E49CA9EC0;
	Fri,  9 Oct 2026 17:03:22 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Fri, 09 Oct 2026 17:02:59 +0000
Subject: [PATCH v3 3/4] mmc: meson-gx: report busy from DAT0 alone
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-meson-gx-busy-timeout-v3-3-67d0db3a8328@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1695; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=jh1AZNUCPxbuGI+CXY/RnKTV+4AipmL8U9W5vOACE7M=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFkn5cK3HWOXEvz5MMZ9x4c7XzquWghoLu0puGMyUTNgt
 9+aDf7TOkpZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBEzvgz/JWt3DTB9fS0P/xZ
 t0Svie3YJ6PS5fBE+GXBup9/ztz+8f4aw//SGVzaTmGBu89MnnThzfpuz/qED///qB04tfL+qiL
 nlmlsAA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

From: Igor Velkov <iav@iav.lv>

meson_mmc_card_busy() reports busy only while DAT0..3 are all low. A
busy card drives DAT0 low and leaves DAT1..3 to the pull-ups, and the
callback is defined as "Check if the card is pulling dat[0] low". So a
busy card is reported free, and the core, which prefers card_busy over
CMD13 in mmc_busy_cb(), stops polling after CMD6 and erase at once. The
controller hides this on R1b commands, where it waits for busy itself.
Once max_busy_timeout is reported, the core sends the longer waits, the
120 s BKOPS and 240 s sanitize switches among them, as R1 and has only
the polling left.

Look at DAT0 only, as sdhci_card_busy() does. The checks around the
voltage switch in mmc_set_uhs_voltage() still hold: the card drives
DAT0..3 low together after CMD11 and keeps them low together on
failure.

Fixes: 186cd8b7f586 ("mmc: meson-gx: implement card_busy callback")
Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
 drivers/mmc/host/meson-gx-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index dd246ad63653..abdb12e5f997 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1095,8 +1095,8 @@ static int meson_mmc_card_busy(struct mmc_host *mmc)
 
 	regval = readl(host->regs + SD_EMMC_STATUS);
 
-	/* We are only interrested in lines 0 to 3, so mask the other ones */
-	return !(FIELD_GET(STATUS_DATI, regval) & 0xf);
+	/* The card signals busy on DAT0 alone. */
+	return !(FIELD_GET(STATUS_DATI, regval) & BIT(0));
 }
 
 static int meson_mmc_voltage_switch(struct mmc_host *mmc, struct mmc_ios *ios)

-- 
2.43.0


