Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EB2199EAD;
	Tue, 23 Dec 2025 02:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766456770; cv=none; b=OTfiSg3hcmG4AgagQGWjacj3wqTF8X/T6t1Bs2aBnQmuiC1EOxUqoArLOkjnZeHXoOXlSimaXPIi4k/4/WRQaflZc45ZV8TgYIt1qHJ6jDY3IXOVbgXSlTt6iUX3Z5eRY5j0KUfHo1ZBAb89dAnK05s3hPFZBttXCQbRC61B7l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766456770; c=relaxed/simple;
	bh=ce4+Y523rDAIPKLiYiVpepgukJhlsG9n/nV8mNpv9ac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwMvIDCmEv/uTRb6I7x4ZZlzcTUA8xik+nXia9KYtoBXYV8nHbvSTgdgAQJOsiWMtAmpjE/ZSw+pnCi8qI8eqSDuAAIS41ewgOtMo8V/RuGKJvv6Itmp8u5auGzNBFjUp9jc6U0O93c01F1qUSryY5XofA5TWDFmRIkB7lbz7yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [127.0.0.1] (unknown [116.232.18.222])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C4511340EA8;
	Tue, 23 Dec 2025 02:25:49 +0000 (UTC)
From: Yixun Lan <dlan@gentoo.org>
Date: Tue, 23 Dec 2025 10:24:50 +0800
Subject: [PATCH v2 2/3] mmc: sdhci-of-k1: add reset support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-07-k1-sdhci-reset-v2-2-5b8248cfc522@gentoo.org>
References: <20251223-07-k1-sdhci-reset-v2-0-5b8248cfc522@gentoo.org>
In-Reply-To: <20251223-07-k1-sdhci-reset-v2-0-5b8248cfc522@gentoo.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=dlan@gentoo.org;
 h=from:subject:message-id; bh=ce4+Y523rDAIPKLiYiVpepgukJhlsG9n/nV8mNpv9ac=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBpSf2RfD2WwXFPXDLAErvhZvwCQk/JdthhMjeBu
 ZTBA+ana8iJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCaUn9kRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1j7w//WGx4F5u5HzGEmjh06B8CmVMVWyJYbEA9sutT2S4yyhY9+sfDGp/CW
 pShubJaaMJXUqQcBvOV1cugEmFLOQsYwEGhSuck5HScWZljcRkUyVf+QYjm8z0rJXlamzI7qu2x
 Iu6DGdvvnjkT39Px5+UdVpbQfsI5ESh5KC7oVuqSJM1i1AjclD62J5vpJtiyzZGqw13IM22x6Ka
 xXPVOzF1tuE9z0VpcRVsaQsdWn1jZSMr1I3Olwp6eJsZtwoKVgP/H4o7mIbTTMctiPnnlc20yAK
 vBK8ZbVOBtmRdMAyJ+3VtJOQC3J9rCFFojZLj8DGvEOAn3zckuOXi9oXz/1dC3ex+Z+BF28ndDp
 JFtZUKQs3/OD0v8Gyl16pYJ5USrZ2gLwLZNqVHFlZWDgb8Wlb93o2sIfoRI3V1Gor+hb56+blah
 vKmVdI4SluGKxdyGa6Fb6ifnHgrFXpDZFjN3RAxLf7+N5+kzRHf5mxqY+bnBkFZCahk6MGQ/69p
 Dp/n2xyccnexDvLaLucA5wZg/hdMugmvvZBf/u0AklAxM7P6ATct8/TMIS3JXz5eOz16m2DoBtC
 sYpdO2Nx1aARwRHlP41enF51owypBFg462pknnqKZw3PP9fgcpXddonGMPfn/GpkZURYM3jX0VI
 EoaFshwS6a0yuct3YjW5itkS83d+n0=
X-Developer-Key: i=dlan@gentoo.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

The SDHCI controller of SpacemiT K1 SoC requires two resets, add
support to explicitly request the reset line and deassert during
initialization phase. Still using devm_xx_get_optional() API to
make the request optional.

Signed-off-by: Yixun Lan <dlan@gentoo.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 0cc97e23a2f9..a160e1d5d9bd 100644
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
+	rst = devm_reset_control_get_optional_shared_deasserted(dev, "axi");
+	if (IS_ERR(rst))
+		return PTR_ERR(rst);
+
+	rst = devm_reset_control_get_optional_exclusive_deasserted(dev, "sdh");
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

