Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C0189BB6;
	Sun, 15 Mar 2026 05:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773553496; cv=none; b=ljegZXfCTQ/4RjvSEZFLZVHzaVdmVMoMsaONJF2TzTMfT53HPGIWHz1eBuIOsKLyUYa1ZSHldV3Qp2xXjDZM8MT7GmdRqVBtG1vmS5Ndfz5yJN88KfwiQj+J1G9oiuUKxSWIXnSEVTuvsJYxsYtpfdCSXtDPhTmcaSb/gvguhRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773553496; c=relaxed/simple;
	bh=dvWdzsAKAM6GCyzicYYcj2neKDLsOU5vShFVA8aEqtY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GF4BAGg2ZA95K5BMFb8XdB0cUTB725fgGALgS48UqbAKnc2TpDn8mGoIJ20OvfidynhcWGGSqFC5o4BzwcMfG8szOnW/3Y9/xqL8gyJ7uUSR3o6DYOGbxcy8wo93dVtoK1OSRUXSj55n5ppv72o+rpzE1FSOH7d5TWkncRUsLD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn; spf=pass smtp.mailfrom=isrc.iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=isrc.iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isrc.iscas.ac.cn
Received: from duge-virtual-machine (unknown [183.192.222.244])
	by APP-05 (Coremail) with SMTP id zQCowADXaQ1BR7Zp5WGACg--.20291S2;
	Sun, 15 Mar 2026 13:44:35 +0800 (CST)
From: Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
To: krzk@kernel.org,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	gaohan@iscas.ac.cn,
	me@ziyao.cc,
	Jiayu Du <jiayu.riscv@isrc.iscas.ac.cn>
Subject: [PATCH v4 0/3] Add SDHCI support for Canaan K230 SoC
Date: Sun, 15 Mar 2026 13:44:23 +0800
Message-ID: <20260315054426.18383-1-jiayu.riscv@isrc.iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADXaQ1BR7Zp5WGACg--.20291S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4fJF1fCw45Aw18tF1rXrb_yoW5WF1UpF
	WUurW3G3yDGF1ftF4xKa1ku3W3Zws5X34UGw1ag34UX390kFW5Xr97C3WYqFyDJFZ7Gw1j
	yw15XFyfCrZ8ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5mld534oul2uny6l223fol2u1dvotugofq/

This series is based on the k230 usbphy series[1].

This patch series adds SDHCI support for the Canaan K230 SoC,
which uses Synopsys DWCMSHC SDHCI controllers, include MMC0 and MMC1.
The hardware designs of these two controllers are different.
The MMC0 supports eMMC, while MMC1 only supports SDIO. Detailed
information can be found in the vendor's manual[2].

From the vendor's K230 manual:
 - MMC0 supports eMMC5.0 and SDIO3.0, usually for eMMC chips.
 - MMC1 only does SDIO3.0 in 4/1-bit mode up to SDR104, and the manual
   clearly says it can't handle eMMC because of pin count and limits.

Therefore, there are two separate compatibles and the driver treats them
differently.

Link: https://lore.kernel.org/all/20260121145526.14672-1-jiayu.riscv@isrc.iscas.ac.cn/ [1]
Link: https://github.com/kendryte/k230_docs/blob/main/en/00_hardware/K230_Hardware_Design_Guide.md#mmc-circuit [2]

Changes in v4:
- Drop the unnecessary line wrapping.
- Drop the extra match_data pointer that was added in v3.
- Add struct k230_pltfm_data which embeds struct dwcmshc_pltfm_data.
- Use container_of() to get k230_pltfm_data.
- Link to v3: https://lore.kernel.org/all/20260310064513.140093-1-jiayu.riscv@isrc.iscas.ac.cn/

Changes in v3:
- Drop the clock maxItems.
- Add a const void *match_data to the struct dwcmshc_priv
- Copy the match_data pointer to dwcmshc_priv in the common dwcmshc_probe
- Link to v2: https://lore.kernel.org/all/20260226115923.75670-1-jiayu.riscv@isrc.iscas.ac.cn/

Changes in v2:
- Change the clock minItems to 5.
- Add comments to explain the reason for setting SDHCI_PROG_CLOCK_MODE.
- Write the power selection logic in the phy init cleaner.
- Replace manual delay loop with read_poll_timeout.
- Drop unnecessarily braces where a single statement will do.
- Add the match_data pointer to dwcmshc_pltfm_data.
- Add dwcmshc_k230_match_data struct to separate eMMC/SDIO config data
- Split K230 into individual emmc/sdio platform data instances instead of
  sharing one.
- Remove redundant have_phy member in k230_priv.
- Replace of_find_compatible_node with of_parse_phandle to get USB PHY
  from DT phandle.
- Link to v1: https://lore.kernel.org/all/20260204082908.27501-1-jiayu.riscv@isrc.iscas.ac.cn/

Jiayu Du (3):
  dt-bindings: mmc: Add sdhci support for Canaan k230
  mmc: sdhci-dwcmshc: Add Canaan K230 DWCMSHC controller support
  riscv: dts: canaan: Add mmc nodes for K230

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  28 ++
 .../boot/dts/canaan/k230-canmv-dshanpi.dts    |  56 ++++
 .../dts/canaan/k230-canmv-module-dshanpi.dtsi |   7 +
 arch/riscv/boot/dts/canaan/k230.dtsi          |  28 ++
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 277 ++++++++++++++++++
 5 files changed, 396 insertions(+)

-- 
2.53.0

