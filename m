Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5FA3AEF50;
	Wed,  2 Sep 2026 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332623; cv=none; b=BC/N87lrejmgosrURJ2N9PfGJG04UGAOkWR9qaa2MhVlZ/NRv/5+ary+/75Rh+5ioPf8EVnBA1VD9AKfUehjpacwocuyzynzSfLuYG8KjaBSooXdn1mENs2MM4pfM+f5srdxxhsx97GrVRgrnG38reEBj6OJTOVa0TNtIuaR5oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332623; c=relaxed/simple;
	bh=wNnXMrDdOxHejNmyQRFidvrM5LD4N1jh6TmhbacrzSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tUF87HU1PYYNTNLrhAnekggY32f6ITzrd7endyI441gBBzR6FhL2VzjjfxphO3sZP4k2l4ns9+3/rKobhsisdxaFGaTeYSWu0/LPmW3FjMsIP84CXK9624Ed72PDACJy1fYpQi4/1/ztdVKxte5rBoj2UG7dKCPkL9c7ZQhORbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I24mCWb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I24mCWb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5D161F000E9;
	Wed,  2 Sep 2026 07:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788332622;
	bh=lUttOokVdaj+xlO1pDebMWBeyODxm2bzShBudFtyHbM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I24mCWb/BPe5tiVm1lrby+PVvZO5BE9EtKZsXibdWR0uKT1lgovPgUpjyeVowbFf0
	 wKnF5CdGtd1WkXsIuN9BQ892LSdpHkuaTFfcpFT1o7P2x7zoplLETHDKHBaIC8BqIo
	 6LDNuaTJ0LTcp8q4n3ca21WqfaBxzH2KVa6od56Io8KGiDvtBXyoUEFBshd6HO+HFa
	 4CNfZSqrNHy3iWMqkxmAe6nHbLgzIAn/40I3pYJTZJyBYiMmYEokpTqZaKxOEC7ljL
	 EigvMjV3qeiVwXEZi1gtjgovNJzbR9rkeCphraCdA32Zv8htPEDr70SfdNNEdJ4Cen
	 JnqU9/WoqPbWQ==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 02 Sep 2026 07:03:14 +0000
Subject: [PATCH 3/4] mmc: sdhci-of-k1: Set clock-frequency of io clock
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-07-k3-sdhci-dts-v1-3-4e7909cf4233@kernel.org>
References: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
In-Reply-To: <20260902-07-k3-sdhci-dts-v1-0-4e7909cf4233@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
Cc: Long Wan <long.wan@linux.spacemit.com>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1164; i=dlan@kernel.org;
 h=from:subject:message-id; bh=xLGXanQt+d9K9+P5rpjtsNcl/WcWw+QwPd2e++Q7VjM=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBql8o8rJIxMWXSKnNvhZvGCO0ghhMa9Q6qdWv73
 oR2x/igg3qJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCapfKPBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+31TBAAhWDD4M27o3x0ygiN+MRZ3wkdJUMBRSV00di/rNxC8ItISahX2JFZz
 Eewi8vTxlD53D24Wmli7vui+zsTOZWZi6AZcJr5g75vl69dHSAaWCKzRh6SGqwPrEOVc2hWwJWI
 tu89GCmhM/6EMwSLqifEJA3FWkje5Y+/TbNvQXXYFWKt2PEMYdvH+rtFIp/0yi/eBZRxBdpxWV4
 mZvHXW5E8hwi9eSUENGi27OHRm54oITiea2JnRY67SvW7scoUUljYBkWLVUOz5SF8DIgLiYYRHD
 cLcwOg36UYvNYYaCyf2YFDy5ESlhcp0YlEXZSwX+MWUJUjrq66/0SX6xO1zLH7oiUb3OiHjqx8R
 HQE5NQciAwGjBGW+8aa/czQxa0ZmjTPVKJPUlT0z641LQDgMj0pjt6yrjFb8SJcBWXiG7iVzqzg
 5NDb2ruX1D5wsL9eJ6GicvzcGsZX+06S2KyxoRNTJU6mOgsTAlPZXYUcSkqVdqDayGEQBhYJQYB
 fFb5W5NMcE8L437V20M5G1wtmfRl7ZrvMjkoYwa+KgwJw7rEcDMD4/Un2WWn+Ob2PpKd1Z+rvFp
 4nDimBhzbNzcVartgA8fvDCpkqMAYdDaXDBw78tGE4ow6LZhbApKF3hmiOGVV36YkV2Posz13Lf
 vFns3EmN3Pu301Q+4o6nhrNFj8xI0M=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

From: Long Wan <long.wan@linux.spacemit.com>

Add a clock-frequency property to set the rate of io clock, for SDIO
case, a clock frequency need to propagate down early.

Signed-off-by: Long Wan <long.wan@linux.spacemit.com>
Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 drivers/mmc/host/sdhci-of-k1.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-k1.c b/drivers/mmc/host/sdhci-of-k1.c
index 37b0911e7cf2..e6ab40c9a555 100644
--- a/drivers/mmc/host/sdhci-of-k1.c
+++ b/drivers/mmc/host/sdhci-of-k1.c
@@ -438,6 +438,8 @@ static inline int spacemit_sdhci_get_clocks(struct device *dev,
 					    struct sdhci_pltfm_host *pltfm_host)
 {
 	struct spacemit_sdhci_host *sdhst = sdhci_pltfm_priv(pltfm_host);
+	struct device_node *np = dev->of_node;
+	u32 freq;
 
 	sdhst->clk_core = devm_clk_get_enabled(dev, "core");
 	if (IS_ERR(sdhst->clk_core))
@@ -447,6 +449,9 @@ static inline int spacemit_sdhci_get_clocks(struct device *dev,
 	if (IS_ERR(sdhst->clk_io))
 		return -EINVAL;
 
+	if (!of_property_read_u32(np, "clock-frequency", &freq))
+		clk_set_rate(sdhst->clk_io, freq);
+
 	pltfm_host->clk = sdhst->clk_io;
 
 	return 0;

-- 
2.55.0

