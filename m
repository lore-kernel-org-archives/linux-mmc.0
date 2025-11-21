Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF11ACEDF;
	Fri, 21 Nov 2025 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763742433; cv=none; b=aKVA2aBbDn1srPPLpnEIKUXBF6t4VFJTF05wSRvojPNZ0MKeLEk/0f1z6SY4l6mnjo9R6FVAGEWW0lioz4cQXEE5XJUjbUFYPlDUVVCO5pIeYfObz5pqOYwjCaDZM1+qb3IDlJVscfFqXmY7NDkkfHYVa8X8NvkP8uxI4sc+ILI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763742433; c=relaxed/simple;
	bh=SEOXBTXLBu4wbKauLYSnxna7hHnG1GHnaPiynnav4zQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MBmB3r4wtvmetaq5XV5CVdzqC8kF9x8O3v3ahYtw3dDvawiDW7VukOIgq1OzzEqE87/IEtmXhKvnuYysaHTWMhucfkh2Tpsgyfk3ClNeue3OvUbW2iH4zexp8VCFw792pyVIhgZSgCAVQYJNSmUv6tZDOec4xymWe6ID0bc4+D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JXWwtmk4; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JXWwtmk4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1763742429;
	bh=SEOXBTXLBu4wbKauLYSnxna7hHnG1GHnaPiynnav4zQ=;
	h=From:Date:Subject:To:Cc:From;
	b=JXWwtmk4lBLonzeNCGbEjhzxWBBxTkJWpRu8DsmfqWkTSs/VxpQ5rmf/7Urp4KtcV
	 4xNcECIfaF3FBbipyOCO4MoPeZ0fjYQ0/hy6oj49nlBrPk0MtWHaBG0aVmdd1zCge3
	 fI8dbyxFIzquYWnE/YDPI63NkAUqjTU/2gH0sjJlnmYnu9Y5c04+gKVr+z+XFUBPYH
	 WCIlvrNltIOONT/DSPtvG7h32DpTff4xyEygieRxuerRM7hiIMeL0i+7sol3C52kmZ
	 MMd29xgIU/EI8m2OYuymlsK9fMHPpxXr4Llu1HgGXZYninwD3KlTXUPaETJf2QNIBq
	 XUDlueshm0/VQ==
Received: from jupiter.universe (dyndsl-091-248-208-149.ewe-ip-backbone.de [91.248.208.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B77DF17E10E9;
	Fri, 21 Nov 2025 17:27:09 +0100 (CET)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 56B44480044; Fri, 21 Nov 2025 17:27:09 +0100 (CET)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 21 Nov 2025 17:26:59 +0100
Subject: [PATCH] mmc: sdhci-of-dwcmshc: Fix command queue support for
 RK3576
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-rockchip-emmc-cqe-rk3576-fix-v1-1-a77805f40072@collabora.com>
X-B4-Tracking: v=1; b=H4sIANKSIGkC/x3MywqDQAxG4VeRrA10Io6lr1JcSPrbCeKlGRBBf
 PcOLr+zOCdluCHTqzrJsVu2dSkIdUWahuULtk8xyUPaECSwrzppso0xz8r6A/vUtF3k0Q6GPgf
 tBBGNUFlsjpLv/bu/rj/GJ489bgAAAA==
X-Change-ID: 20251121-rockchip-emmc-cqe-rk3576-fix-ec8ac72e6e32
To: Shawn Lin <shawn.lin@rock-chips.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2507;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=SEOXBTXLBu4wbKauLYSnxna7hHnG1GHnaPiynnav4zQ=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGkgkt2dR/Mk0wcjrGt5Z7YAtdFpjvb126MHP
 BpU76nI6bTva4kCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJpIJLdAAoJENju1/PI
 O/qa1mgP/RoxhIKpzhiVcCW9sduTsWgBlcRSl1WqtVWKdC05Z7V5MWpWLN9QaFgZiRlxPWRwz7q
 xWPZIFrfHsIArF7H1+38kA5bBdq+0eMfPddlLKhEoEWBHWgb0VVG35VzshHoCJv1O4/MkaiPjLy
 uuqf5R36BMO7wH2+94pV3CYawNFjSP9X2wwOKTlwiFjbuXJVhh9vdFIZHbT0JZFXsRD3q34xIqf
 HNOStKJ2ewWBt6YZvIUfJS7VP8U8StJ9F6lFA5noBWWdAw/y+yk/FIEErZoKth7EzH+HF08Send
 XP99odpzlL0A1idHtCxE9jwrhL8K6kA5faqRnmWUmVZvZ9GbLEQFhCtEbT3I2e2r1szFAjuja4s
 t0WTQ864/MfvLMENn47Ux83BoBfrzr5DcI3071sc23ZqQqqB+h3VCslkZJl9mxkBHKCWnnOVEeT
 p92I+1p1wWpQRsd+6r3uln86+e4pGgw0v2E7OyvHP5R7dlTGfa8HZHQLnTUX1VhL247AtfwZ7xf
 9eJ0lKaANoo3S0cblkIlnz+2w3/91pMFJwUySwbp6eeoJ8Z5Bl0VAg5IMAoUeuMLE5WU+VTMv9h
 h2fC9S9JG0XmWLllV8Ktdt567q0kV9OIhnN46gzQMsvFhcqWlyUOv6OEdUnFgum6gycRpkudB/V
 8PJmKjgFgL+zPTsxLVAYwKg==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

When I added command queue engine (CQE) support for the Rockchip eMMC
controller, I missed that RK3576 has a separate platform data struct.
While things are working fine on RK3588 (I tested the ROCK 5B) and
the suspend issue is fixed on the RK3576 (I tested the Sige5), this
results in stability issues. By also adding the necessary hooks for
the RK3576 platform the following problems can be avoided:

[   15.606895] mmc0: running CQE recovery
[   15.616189] mmc0: running CQE recovery
[...]
[   25.911484] mmc0: running CQE recovery
[   25.926305] mmc0: running CQE recovery
[   25.927468] mmc0: running CQE recovery
[...]
[   26.255719] mmc0: running CQE recovery
[   26.257162] ------------[ cut here ]------------
[   26.257581] mmc0: cqhci: spurious TCN for tag 31
[   26.258034] WARNING: CPU: 0 PID: 0 at drivers/mmc/host/cqhci-core.c:796 cqhci_irq+0x440/0x68c
[   26.263786] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.18.0-rc6-gd984ebbf0d15 #1 PREEMPT
[   26.264561] Hardware name: ArmSoM Sige5 (DT)
[...]
[   26.272748] Call trace:
[   26.272964]  cqhci_irq+0x440/0x68c (P)
[   26.273296]  dwcmshc_cqe_irq_handler+0x54/0x88
[   26.273689]  sdhci_irq+0xbc/0x1200
[   26.273991]  __handle_irq_event_percpu+0x54/0x1d0
[...]

Note that the above problems do not necessarily happen with every boot.

Reported-by: Adrian Hunter <adrian.hunter@intel.com>
Closes: https://lore.kernel.org/linux-rockchip/01949bc9-4873-498b-ac7d-f008393ccc4c@intel.com/
Fixes: fda1e0af7c28f ("mmc: sdhci-of-dwcmshc: Add command queue support for rockchip SOCs")
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
Sorry for the delay in sending this :)
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index c66a8dfad47c..ee0008d91b98 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -1767,6 +1767,7 @@ static const struct dwcmshc_pltfm_data sdhci_dwcmshc_rk3576_pdata = {
 		.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 			   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 	},
+	.cqhci_host_ops = &rk35xx_cqhci_ops,
 	.init = dwcmshc_rk35xx_init,
 	.postinit = dwcmshc_rk3576_postinit,
 };

---
base-commit: dcbce328d3a2d87770133834210cf328c083d480
change-id: 20251121-rockchip-emmc-cqe-rk3576-fix-ec8ac72e6e32

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

