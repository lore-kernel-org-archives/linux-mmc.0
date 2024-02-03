Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265445D49F
	for <linux-mmc@vger.kernel.org>; Sat,  3 Feb 2024 10:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706957091; cv=none; b=nslwzcff3Z9KNKk6CdjqTmMofH/96YKZypcYphu1GE2YW3NRO065MRhgDiDtK8lsLTC3MPKCC2R1aE/kAB2h9ut6IvWvz3KX7sM5Yy3JARWjiALGemXc7UvsWCaFmUXTFwbHECguGeyd8grIw1zovoYdmm4B/edf8X8jJUVj8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706957091; c=relaxed/simple;
	bh=ovRF3vwSiWIiriOIkKb43wr5mzAZsXT4Kfr2KY9lhl0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SbM/6j6g6oexjXfXL2WpA41uTY9p3+WS4wYwNOTnROUTTKqmfW3EveRxJNmflSOWHF/XCzahU6rxcQy3HlffEi2bsHMtmEpSSI1ukBtXHJRZczKPCWKYpggBySsfT1+UpLSfwlPagdNgRwu6IG0DY1PIYXmYz9zaBRJMbFCd3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Lo4YHBba; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Lo4YHBba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mmhyn
	8VamvNkG07TWRsArWImoiIYiMN01DPQ4a0MW0M=; b=Lo4YHBbaGFmSDTlQ2ObqJ
	AYOgcydQo/BOaB9Q5huklwSsYZ9DElU4qf0H5Lx2knx9ufF5y5wou+k/4QNjtStY
	gxo0yv7WZdeFRFU7IG96FNYg9JelD1sfmXB+eP4EcpSBp7QBm5y/qndA9HgrkifV
	yG08jmq6yAQQu+ZENPzces=
Received: from DESKTOP-G2V7PLK.nt-fsrvr.o2micro.com (unknown [61.219.243.196])
	by gzga-smtp-mta-g0-3 (Coremail) with SMTP id _____wDXfwx1Fb5lUNVaAA--.7289S2;
	Sat, 03 Feb 2024 18:29:11 +0800 (CST)
From: fredaibayhubtech@126.com
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	linux.kernel@vger.kernel.org
Cc: shaper.liu@bayhubtech.com,
	chevron.li@bayhubtech.com,
	xiaoguang.yu@bayhubtech.com,
	Fred Ai <fred.ai@bayhubtech.com>
Subject: [PATCH V1 1/1] mmc: sdhci-pci-o2micro: Fix a warm reboot issue that disk can't be detected by BIOS
Date: Sat,  3 Feb 2024 02:29:08 -0800
Message-Id: <20240203102908.4683-1-fredaibayhubtech@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXfwx1Fb5lUNVaAA--.7289S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr1rZF18Aw13JrW7tw1UJrb_yoW8Kr48pF
	sYqwn8Ar4rtrWYvF9xt3W0vr15XrnYvrWUKrW3Gw1avF4UCrZ0qrZ7AFyjqr1UXrZ7Jw1S
	vFsYvFykWryUJwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-YFAUUUUU=
X-CM-SenderInfo: xiuhvtpled5x5xewvubk6rjloofrz/1tbinR15bWV2zlDzqgABsB

From: Fred Ai <fred.ai@bayhubtech.com>

Driver shall switch clock source from DLL clock to
OPE clock when power off card to ensure that card
can be identified with OPE clock by BIOS.

Signed-off-by: Fred Ai <fred.ai@bayhubtech.com>
---
Change in V1:
Implement the "set_power" callback in sdhci_ops,
then switch PCR register 0x354 clock source back to
OPE clock when power off card.
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 30 ++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-pci-o2micro.c
index 7bfee28116af..d4a02184784a 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -693,6 +693,35 @@ static int sdhci_pci_o2_init_sd_express(struct mmc_host *mmc, struct mmc_ios *io
 	return 0;
 }
 
+static void sdhci_pci_o2_set_power(struct sdhci_host *host, unsigned char mode,  unsigned short vdd)
+{
+	struct sdhci_pci_chip *chip;
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	u32 scratch_32 = 0;
+	u8 scratch_8 = 0;
+
+	chip = slot->chip;
+
+	if (mode == MMC_POWER_OFF) {
+		/* UnLock WP */
+		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+		scratch_8 &= 0x7f;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+
+		/* Set PCR 0x354[16] to switch Clock Source back to OPE Clock */
+		pci_read_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, &scratch_32);
+		scratch_32 &= ~(O2_SD_SEL_DLL);
+		pci_write_config_dword(chip->pdev, O2_SD_OUTPUT_CLK_SOURCE_SWITCH, scratch_32);
+
+		/* Lock WP */
+		pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch_8);
+		scratch_8 |= 0x80;
+		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch_8);
+	}
+
+	sdhci_set_power(host, mode, vdd);
+}
+
 static int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot)
 {
 	struct sdhci_pci_chip *chip;
@@ -1051,6 +1080,7 @@ static const struct sdhci_ops sdhci_pci_o2_ops = {
 	.set_bus_width = sdhci_set_bus_width,
 	.reset = sdhci_reset,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.set_power = sdhci_pci_o2_set_power,
 };
 
 const struct sdhci_pci_fixes sdhci_o2 = {

base-commit: 56897d51886fa7e9f034ff26128eb09f1b811594
-- 
2.25.1

