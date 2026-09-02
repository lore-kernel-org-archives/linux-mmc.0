Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB75390214;
	Wed,  2 Sep 2026 08:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336310; cv=none; b=Rsj8032cP4nGqQW1tFJAgJViRr+H4QRsvmM3ujRFKtxKhLwnfigdqMqscR8AOUgVcHx4ph1z4BgWfC2FZXz1yFOMTBPVd8yq/TsqiACHhCT2bfyfgUGbkPOF9EVqk/qe8UzjzxfrugBH7V1QkeqMWKQ1VVQbS2JgLA4Ys3QZBYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336310; c=relaxed/simple;
	bh=TG1nbZjuatmpnqUiwNEy45uI4OKsntHMwN6/FS38ozI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pVvpaP3LWjd+KrFC2qfAfQf8FXrhhIjtGeEbnqVXNh8Z0UXXCMTW5Zcz+LNXRrODEZ+qzBZF/mbiQ3VKjWDoAL9xTFh89QOaTF6NL+1d6HDXeGOTSXBjWdHDydCvtdGKvr4FgUyVLVQQnUhUmSVwgJjXRy2Akt7tG710KE7e/DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROO8Ih8P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROO8Ih8P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E801F000E9;
	Wed,  2 Sep 2026 08:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788336309;
	bh=VTBHZqMzNtfGu0/ii6nYXJrwVNlixijnWIIxoUCWQXk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ROO8Ih8PuAw0rLCyOMi8UQ8EKLb0OiVCrXqqpJfz4bOgRcjJE1MrJQqK0OIgtmLMF
	 CcOcDk6E4bB1g1N0fhYG10tQbnvCza1Np2UwW8hBfUkksiNEpSigXyVypds3QLEO3W
	 cHuE2cmI8MaOVv3JwbB7uq13KXZ1zUdvkD8eDOWEIVjF61HezQCRuqJrsbsHIX9sKE
	 YAp0GN3wrcEZ2Ovw0dr+XYm8DpF9S275O9A4iixW0cWG6e4ykKTSswxptKpm/9qyCG
	 W/Zr9HYr4j+Ad8pr0siACb9/P1FXIakgZ6Go10TsRRCKZoy8sNoK0sq552eTUoKb5g
	 ZIrkJlJjGli4A==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 02 Sep 2026 08:04:25 +0000
Subject: [PATCH 4/7] mmc: sdhci-of-k1: Improve power control
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-07-k3-sdhci-fix-v1-4-b15c5d0f64fd@kernel.org>
References: <20260902-07-k3-sdhci-fix-v1-0-b15c5d0f64fd@kernel.org>
In-Reply-To: <20260902-07-k3-sdhci-fix-v1-0-b15c5d0f64fd@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>
Cc: Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1065; i=dlan@kernel.org;
 h=from:subject:message-id; bh=ZZnwSyRWem1cufE+ykT/c74WDL6JDGMXan1pWqJy6GA=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBql9id5/j9bEGbznCN/oeX7c5UcrLyeiwrT9Z/N
 FnF9u2RecuJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCapfYnRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+2Enw/9FeHpWaCDIgagCZFIhkm8Y/pzQR5CPvoPpu7bpu+wTsDFQNtNR3IMz
 JQG9a+S9AyRyvNo7NVc8Dj1UhfFczYukpA4Q3BhkRMA50VxM1x7kYv0N/kjynX5jpvX1G44eiQX
 JbDfD7GqZ94q4KxXlemTVuWDytioeDIKwVsw3RAC2+mScY9cadb5Oe5ST8S6ZQZ3QPqDuTdonHC
 IPi2KvuJU23HuCD2sVQUADpc3JnW5AG/GuciRPRMQBwfj/B7hw0czRRamfhXnp1y+5jSxjXuzEh
 VaGh2DFcL4ZvDXiKUiFFfWcRyCOxFkeGLCKrYdJJDxPWsmcAwOyzyWYhTqFBbM79llVtEsR/dWk
 TSXNAI3KX6dAsNqev6VM5HEeTwHEtBHrnakr0MF+6lAhQIeLwXJ6Zv3AQo+wUFSI16FvBl7jfuj
 oS4b11PhrMvdJc0dWh2mi1AFhe5IjRG0nNX6ztWVXk/RWxyvFjW0UCn0ZqTNYUN8qmQcxOmOPjR
 MfWvlnY54ufkWsosPaGTuAs/tc4K1l6/wSmV/Xo36wzyMHfBILtHXcivTKU9EV0aG48C8ug1iDP
 Yge8qgd95ynZgTm/wVqvWPi6A2FeB11VnCE4iMeRxS1lzvvbqBD5LE430I/UaItbkaBtl/A/psc
 yi6O2byc8WesXkBwG6hWkp2xWhwYVI=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Long Wan <long.wan@linux.spacemit.com>

The default sdhci_set_power() skips the SD bus voltage select field
entirely when a vmmc regulator is present, leaving SD Bus Power in off
state of the power control register. To fix this, configure the bus
voltage explicitly.

Fixes: e5502d15b0f3 ("mmc: sdhci-of-k1: add support for SpacemiT K1 SoC")
Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 5dccdd4b217d..be770e8a9884 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -496,6 +496,7 @@ static const struct sdhci_ops spacemit_sdhci_ops = {
 	.reset			= spacemit_sdhci_reset,
 	.set_bus_width		= sdhci_set_bus_width,
 	.set_clock		= spacemit_sdhci_set_clock,
+	.set_power		= sdhci_set_power_and_bus_voltage,
 	.set_uhs_signaling	= spacemit_sdhci_set_uhs_signaling,
 	.platform_execute_tuning = spacemit_sdhci_execute_tuning,
 };

-- 
2.55.0

