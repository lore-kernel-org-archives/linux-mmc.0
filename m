Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795647898;
	b=U6sZogqyIcuFVOPDcmz4mfY6Hn5HmWku3M6USuivOCzQzsq+Z2POCTMuqdzTNomxsBFk
	 nnJJ8VASLeYuc/V5Ajo3Y2PLZeQJRkYrsvI1Z0j5afhxG1sOM094GdyDS8VU1cCE1lqZT
	 sP3oYMp0H9VnHObxJbjq0T7ySjYLhDf9jZ8mdfTCbpIwqYOqHIkUc5LI4d4Z2alEvgm5S
	 RYrDOujl6rs0MA9gaMe5j6+9HBpAqKClqGP/mKzpLeCQGcPGVzmlObnUNFg4x55vzdopF
	 Tn0L9Y+XBoAt894s1OyONhOLheCxJU/KmZVW+uo+Nz5BaUEwnnMin1K9UEhlTHpYblA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647898;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=pby6ROZEcPP/akhHNpSuVe8cP7V1dKMFwkUigrfM6Dc=;
	b=UqX5riboG4wSIOeKsra2/8cIkgGNKU+QJSubwMa4S2FJ3Od4wKy8tvKM6H8heSY6vRhJ
	 1plN7UklTnpVLlH8g+khppT9I8LXD1iBIge46c8BYBd5V7XbcwEIN/iOwgdDyxlVPXAMN
	 kFUPjdzd8lkMQWNfQs05xLEXec4O+/BWw1GOhFzHk0ZuE+xkKZ2EIwg+d+xCWE4FSxEJU
	 1vODsnFiAec+tAV8/zhPu3fSnWmlxuDnMURVhIzsdsr5MwurKkNhHnPTJBqzdXyAhztB4
	 EW/rXmxgyl+SRdXj1YXcbdyAWsym6UXC+8sn0ObFgwlpr1hCeXKE2hrvci+DulHjbGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gf+kZ96c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C749606A31E;
	Wed, 25 Nov 2026 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gf+kZ96c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6101F000C4;
	Wed, 25 Nov 2026 23:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795647897;
	bh=pby6ROZEcPP/akhHNpSuVe8cP7V1dKMFwkUigrfM6Dc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gf+kZ96cMQj7Xh+u1vk0ntuXeSYE7xknTtR0mnnrxSZLpneP9XgrWGLjX/wKiv8Ej
	 6aAupjkobui5/nK38UtCV+52tPW/rv6vujcka8gCsmpEYgj6KegTQLA+poTPEJHuKC
	 bUAobJE5lbBj2Yrt/4LkDMdN4m4Njlg7PEMfZdv6Jjk1AdiD7APZKNpLQSxZsh8n+S
	 ZlrlX1QfpTaMiWQwRIwt9KhHqfUbxr4JxKim9C63fuejQUD/+sBXgwnsOruVkOPE5W
	 r1H1cwTk2ruHwUklKHo3SutMkb9KIPLwj6AENbONynTC3iBQy6UqzfawR6MSSXY/iJ
	 q8kNDlT+OCZ1A==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 25 Nov 2026 23:04:38 +0000
Subject: [PATCH v2 2/2] mmc: sdhci-of-k1: Add TX tuning parameter
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-07-k3-sdhci-dts-v2-2-a069659ba025@kernel.org>
References: <20261125-07-k3-sdhci-dts-v2-0-a069659ba025@kernel.org>
In-Reply-To: <20261125-07-k3-sdhci-dts-v2-0-a069659ba025@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2618; i=dlan@kernel.org;
 h=from:subject:message-id; bh=BPnZzVNxRpMqynOCa0hbZmnCfAwLs4G7uVoGSv+TTbg=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBrB2mOPrDesfxBHBCsd/snwLAsnSpooR6owqqBf
 bdcdl3VoGeJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCawdpjhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3QDhAAlUZQez7Xqb7KeA+vAEigusHmQyq1LUwJNYfMTCcUsH4kS1Z5cgCUm
 faXd4DaHxhud6H9pX1wNgu+wEkHvJ7GtmKZZ0KGO/JSxqXpQmvLm8/bydRL2507U8gWO5bMGqUZ
 szHIXT3Z/l17/2dusoYh7fgsi9swhOwHYFyrk2xOQ8GMobP5lW94uO3GmEDG/6a/Qs2msfMkYti
 LceGwfUWTpUHik8OpakBmP+/o/bOE0H7OfzVKNu+0/t2TnWulbvKMHMm3Sp427AbzRO7ZQoeCTB
 GP+3ArZ+6rILtGFN3oaVgtKPlwFFGA10DJiYJMAc7d/fK9PLfi6i8ssYbJYmYkv7zPkup7cvQxE
 0DG4P/D0hJDiUE7rakF1mFKBWX2Jje8JACSPEzFkCR5tCRY+dBofQs8uP+gskYnrTshTCDVVfVO
 sd1vTl2vGcN6pg3CpeUv1l33sbjNxvn7x9RRnsPFwmA1WrXI/s3gdJwvz9K0c3198VgnjGN8G+j
 Z+fnVXQMLZAoXDFx5UXOfiP3rvEEmRoQugG1pQYLe7d3UstrXVQ33JmTqgspylV/c3h3nu0H+Mb
 V7RaqCnJBvwNeiFLK6gpHKU0MiUFAilrPy3PU4kWJnrNL7accBMlfpfpYJOpNfZlxQ3qrAFelhs
 ogNjfOwXPLpwJ1e7BRGqn/eqopE0Yo=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Long Wan <long.wan@linux.spacemit.com>

Instead of setting the TX delay code via hardcoded parameter, configuring
it via device tree property, which make it able to adapt according to
board specific tuning requirement.

Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 37b0911e7cf2..ee613e1417fa 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -97,6 +97,7 @@ struct spacemit_sdhci_host {
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *pinctrl_default;
 	struct pinctrl_state *pinctrl_uhs;
+	u8 tx_delaycode;
 };
 
 /* All helper functions will update clr/set while preserve rest bits */
@@ -278,12 +279,15 @@ static int spacemit_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 		return 0;
 
 	if (mmc->caps2 & MMC_CAP2_NO_MMC) {
+		struct spacemit_sdhci_host *sdhst;
+
+		sdhst = sdhci_pltfm_priv(sdhci_priv(host));
 		spacemit_sdhci_set_tx_dline_reg(host, SPACEMIT_TX_TUNING_DLINE_REG);
-		spacemit_sdhci_set_tx_delay(host, SPACEMIT_TX_TUNING_DELAYCODE);
+		spacemit_sdhci_set_tx_delay(host, sdhst->tx_delaycode);
 		spacemit_sdhci_tx_tuning_prepare(host);
 
 		dev_dbg(mmc_dev(host->mmc), "TX tuning: dline_reg=%d, delaycode=%d\n",
-			SPACEMIT_TX_TUNING_DLINE_REG, SPACEMIT_TX_TUNING_DELAYCODE);
+			SPACEMIT_TX_TUNING_DLINE_REG, sdhst->tx_delaycode);
 	}
 
 	spacemit_sdhci_prepare_tuning(host);
@@ -491,6 +495,17 @@ static inline void spacemit_sdhci_get_pins(struct device *dev,
 		sdhst->pinctrl_default, sdhst->pinctrl_uhs);
 }
 
+static void spacemit_sdhci_get_tuning_params(struct device *dev,
+					     struct sdhci_pltfm_host *pltfm_host)
+{
+	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
+
+	sdhst->tx_delaycode = SPACEMIT_TX_TUNING_DELAYCODE;
+
+	/* Override if valid from DT property */
+	device_property_read_u8(dev, "spacemit,tx-delay", &sdhst->tx_delaycode);
+}
+
 static const struct sdhci_ops spacemit_sdhci_ops = {
 	.get_max_clock		= spacemit_sdhci_clk_get_max_clock,
 	.reset			= spacemit_sdhci_reset,
@@ -566,6 +581,8 @@ static int spacemit_sdhci_probe(struct platform_device *pdev)
 
 	spacemit_sdhci_get_pins(dev, pltfm_host);
 
+	spacemit_sdhci_get_tuning_params(dev, pltfm_host);
+
 	host->mmc_host_ops.start_signal_voltage_switch = spacemit_sdhci_start_signal_voltage_switch;
 
 	ret = spacemit_sdhci_get_clocks(dev, pltfm_host);

-- 
2.56.0

