Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4445C1F947;
	Thu, 30 May 2024 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717106150; cv=none; b=M5b/WDLsOBt2ys095cq5IEDXi4QS2EoXPtAFTd0GolR2/yvdoRgiT4X3Z7FzIzUW0gO+3qX5pMnHZz+rExf6LLN3VBTQDsWqVu5S6ReTMi5zhQn9FVCH4kWslhdauGbJhtbMD4PwAVVswsopbIoMhrn68/kGveXhSlRUAIt3wp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717106150; c=relaxed/simple;
	bh=e0FSDs4dFZHFjikUFCD+WlF80AegijSM4DzeciT189Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YlpMHjti19tN1c9D82sP+TQ1F7Q0XnTOILlYQSenJSrbeZy7aXTgfHXZNQHfr8hr0pq1JwZTD/uaSfOqjycMoxHMPzfETOQIMZoTHPZCKbUTMbl6U4shHqr/lATjEfGj0PEE1obUiVpNdv9ye94VgQnuTuYMFxbVeJsQOzQyJgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875bfd.versanet.de ([83.135.91.253] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sCnkE-00068d-PZ; Thu, 30 May 2024 23:55:34 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: serghox@gmail.com,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	quentin.schulz@cherry.de,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH] mmc: sdhci-of-dwcmshc: don't enable CQE without a suitable irq handler
Date: Thu, 30 May 2024 23:55:32 +0200
Message-Id: <20240530215532.2192423-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

supports-cqe is an established dt property so can appear in devicetrees
at any time. CQE support in the sdhci-of-dwcmshc driver does require a
special irq handler in the platform-specific ops, to handle the CQE
interrupt.

Without this special handler we end up with a spew of unhandled interrupt
messages on devices with supports-cqe property but without irq handler:

[   11.624143] mmc0: Unexpected interrupt 0x00004000.
[   11.629504] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
[   11.636711] mmc0: sdhci: Sys addr:  0x00000008 | Version:  0x00000005
[   11.643919] mmc0: sdhci: Blk size:  0x00007200 | Blk cnt:  0x00000000
[   11.651128] mmc0: sdhci: Argument:  0x00018000 | Trn mode: 0x00000033
[   11.658336] mmc0: sdhci: Present:   0x13f700f0 | Host ctl: 0x00000034
[   11.665545] mmc0: sdhci: Power:     0x00000001 | Blk gap:  0x00000000
[   11.672753] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000407
[   11.679961] mmc0: sdhci: Timeout:   0x0000000e | Int stat: 0x00004000
[   11.687169] mmc0: sdhci: Int enab:  0x02ff4000 | Sig enab: 0x02ff4000
[   11.694378] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
[   11.701586] mmc0: sdhci: Caps:      0x226dc881 | Caps_1:   0x08000007
[   11.708794] mmc0: sdhci: Cmd:       0x00000d1e | Max curr: 0x00000000
[   11.716003] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x00000000
[   11.723211] mmc0: sdhci: Resp[2]:   0x328f5903 | Resp[3]:  0x000007cd
[   11.730419] mmc0: sdhci: Host ctl2: 0x0000000f
[   11.735392] mmc0: sdhci: ADMA Err:  0x00000000 | ADMA Ptr: 0xee28f008
[   11.742600] mmc0: sdhci: ============================================

So don't enable CQE if a usable interrupt handler is not defined and warn
instead about this fact.

Fixes: 53ab7f7fe412 ("mmc: sdhci-of-dwcmshc: Implement SDHCI CQE support")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
My rk3588-tiger and rk3588-jaguar devicetrees had an accidential
supports-cqe in their devicetree, which made me run into this problem
with 6.10-rc1 .

 drivers/mmc/host/sdhci-of-dwcmshc.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index 39edf04fedcf7..4410d4523728d 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -1254,10 +1254,14 @@ static int dwcmshc_probe(struct platform_device *pdev)
 
 	/* Setup Command Queue Engine if enabled */
 	if (device_property_read_bool(&pdev->dev, "supports-cqe")) {
-		priv->vendor_specific_area2 =
-			sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
+		if (pltfm_data && pltfm_data->ops && pltfm_data->ops->irq) {
+			priv->vendor_specific_area2 =
+				sdhci_readw(host, DWCMSHC_P_VENDOR_AREA2);
 
-		dwcmshc_cqhci_init(host, pdev);
+			dwcmshc_cqhci_init(host, pdev);
+		} else {
+			dev_warn(&pdev->dev, "can't enable cqe support without irq handler\n");
+		}
 	}
 
 	if (rk_priv)
-- 
2.39.2

