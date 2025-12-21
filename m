Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE5B244692;
	Sun, 21 Dec 2025 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766305270; cv=none; b=gk6ReFDWtYMyjuUQ6SWSj0FV7WX6OOmg8v5TJFUpgWFI8oX9zGn9+//lPJQ1nRfo+7gNswIx5UmaPGHNWCIxhkvY6yM4F/PZRwXgBw+LXXxJirICiLZ95mT5K/ZnvdQkDNaIl5V4AMwgJAsxqS9Xid65kZ6jdskc1RSyjGgP/64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766305270; c=relaxed/simple;
	bh=Z3iYIOPo0NShh3wxil77tWS3egeNeNJQQuOhwb4xrME=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AR/12RVnUtI56m3Q8d5TtGkKqLKXxx3rCjwjY0UbpP7l7ni9gd/khrfZmQpioSdJ/mQA1yFv58BVrb6YyJoimMbfcreZwz5a4l0PqauX68EvGAwME1C2PGJsbb62NmnurxsbVLptBWU2cosrFxG4pNum2Mo/R3tJ2Vu6po5pKEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 0B7A8340FA3;
	Sun, 21 Dec 2025 08:21:02 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Sun, 21 Dec 2025 16:20:27 +0800
Subject: [PATCH 2/3] mmc: sdhci-of-k1: add reset support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251221-07-k1-sdhci-reset-v1-2-6780af7fa6e7@gentoo.org>
References: <20251221-07-k1-sdhci-reset-v1-0-6780af7fa6e7@gentoo.org>
In-Reply-To: <20251221-07-k1-sdhci-reset-v1-0-6780af7fa6e7@gentoo.org>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@gentoo.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1560; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=Z3iYIOPo0NShh3wxil77tWS3egeNeNJQQuOhwb4xrME=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpR63Z1gUXGLoBEzoNgFK+4yuLCXK+1AQv9r22Z
 Q396AjO+y6JAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaUet2RsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0GXg/+JDplF5Mat9kwt9zddoUs6PY0KPaGtXYn+vy7mXm5MDd3DqSLaSzAd
 mO8jsQ0rnCIFzrxbG8Uz8RNgKR4hAHjXyvQjAoE8S1yuZh3rxjBBVjjQcSBdP0+Yq7u1eW766gR
 cUfClbMy4pNrU4CbOoICXik3AF9OQQqxMS7Ns8U2S8UGpIAuBmGPVgA1UXI3cYMGq1jEcL1IuBw
 Jizy9PvJrfar6CZKm7mPTTDDCNquX4NdmHbxH7D28vMqdYFGiqoe5rQpMssEdGVSc+MUvYrunZQ
 zMj5ET0ASrdjdCPMl+MLx9JctaMMlQgbvf7Qn+dkXLuSH5jjbdzl2Nc1t8FnGjUpoBHl/DDUF6y
 JAMHpJbRpOPmc99JnBnPg5VPdTUhInwRfKAETlUI+tNYcmv0FvTU4A76vOEsHgUneGoOwXDTYrm
 f5L5PkdijG/rAOrYYGup41rpMVAXNe9heilxCp6gCu2gqsiBOFwteCNP2y2TIhbcBOpKDTxDWoX
 fKr4n9hAZVEuSy+ytRQV8Ap5rzE6jC51EVotsIgToIA5vYBOmE9c97MfAN/CkDgBEk+Qk6UkgNt
 NsKpGAqjudW6wdF+4G5x4XPdCYvFlUE6/HvbeSeW0FKOFMaKb40lJ+VOSyoVnDduVL5UbldCFUJ
 OVmitAzqxIONf87cDS6+WR4HSyrj6k=
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

The SDHCI controller of SpacemiT K1 SoC requires two resets, add
support to explicitly request the reset line and deassert during
initialization phase.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 0cc97e23a2f9..f8330cff5b2a 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/reset.h>
 #include <linux/platform_device.h>
 
 #include "sdhci.h"
@@ -223,6 +224,21 @@ static inline int spacemit_sdhci_get_clocks(struct device *dev,
 	return 0;
 }
 
+static inline int spacemit_sdhci_get_resets(struct device *dev)
+{
+	struct reset_control *rst;
+
+	rst = devm_reset_control_get_shared_deasserted(dev, "axi");
+	if (IS_ERR(rst))
+		return PTR_ERR(rst);
+
+	rst = devm_reset_control_get_exclusive_deasserted(dev, "sdh");
+	if (IS_ERR(rst))
+		return PTR_ERR(rst);
+
+	return 0;
+}
+
 static const struct sdhci_ops spacemit_sdhci_ops = {
 	.get_max_clock		= spacemit_sdhci_clk_get_max_clock,
 	.reset			= spacemit_sdhci_reset,
@@ -284,6 +300,10 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_pltfm;
 
+	ret = spacemit_sdhci_get_resets(dev);
+	if (ret)
+		goto err_pltfm;
+
 	ret = sdhci_add_host(host);
 	if (ret)
 		goto err_pltfm;

-- 
2.52.0

