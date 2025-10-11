Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185C933F6;
	Sat, 11 Oct 2025 11:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760181085; cv=none; b=Ywtwz7DfKuA4Vqnhh4fIcKyPscw+eArarxmFFaAzb+Xar0LG/drKTilqB9nx62QaWRWkMKSdMQ9C7sx91sVkziCahCE7KuTVO0/W7ZwmSXkdyF31S4jaUF54AeNh9Td79FmCNgUR27w9fjoHZ/aCaru857qjjqjRCWJj702/FZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760181085; c=relaxed/simple;
	bh=V3PxO90ix5Arwq53CQB519eznTSh0+i9HBUEfamTvOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dI9lf/gFY6uVr7rcHHHP3+d2OEAFxX5tqnm7Kq9x4C2D3U7juQCP+O2d8DnVS1SfWnLoj2f4rZob9CdN6zAivLlfO6Cm3qivfqh6YeMO1EGCXjLyvDHl3kYlHO4RBGlBH2s8/d5gFKegDpOTiP+KCXn7YXMEJtFnjFQ1wshmdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005154LT.eswin.cn (unknown [10.12.96.103])
	by app2 (Coremail) with SMTP id TQJkCgD3lZQyO+poD_IDAQ--.56190S2;
	Sat, 11 Oct 2025 19:10:44 +0800 (CST)
From: hehuan1@eswincomputing.com
To: ulf.hansson@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jszhang@kernel.org,
	adrian.hunter@intel.com,
	p.zabel@pengutronix.de,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	xuxiang@eswincomputing.com,
	luyulin@eswincomputing.com,
	dongxuyang@eswincomputing.com,
	zhangsenchuan@eswincomputing.com,
	weishangjuan@eswincomputing.com,
	lizhi2@eswincomputing.com,
	caohang@eswincomputing.com,
	hehuan1@eswincomputing.com
Subject: [PATCH v4 0/2] Add support for Eswin EIC7700 SD/eMMC controller
Date: Sat, 11 Oct 2025 19:10:38 +0800
Message-ID: <20251011111039.533-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgD3lZQyO+poD_IDAQ--.56190S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr48Cw4xWF15Gr1kXr4ktFb_yoW5GFW8pF
	W5K34xGr4ayryxZFsYga4v9a43Xws7Wry7Kr13J3W5Xw4qva4qqrWIka4YgFW5AryxXws0
	v3y2qF15C3Wavr7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK6svPMxAIw2
	8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
	x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrw
	CI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
	42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z2
	80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRiBT5PUUUUU==
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

Updates:

  Changes in v4:
  - Update sdhci-of-dwcmshc.c
    - Address the compile error from kernel test robot
      - Remove duplicate implementation of dwcmshc_enable_card_clk()
      - Add missing dwcmshc_disable_card_clk() function implementation
  - Link to v3: https://lore.kernel.org/all/20251010093807.1579-1-hehuan1@eswincomputing.com/

  Changes in v3:
  - Update snps,dwcmshc-sdhci.yaml
    - Delete clock-output-names, '#clock-cells' and eswin,syscrg-csr
    - Update description for eswin,hsp-sp-csr
    - Update drive-impedance-ohm
    - Update the item of reset-names
  - Update sdhci-of-dwcmshc.c
    - Add descriptions for PHY registers
    - Simplify clock management(remove custom clock provider, use
      standard clk API)
    - Replace magic numbers with GENMASK() or FIELD_PREP() macros
    - Add comments explaining HSP stability assertion writes
    - Adjust line wrapping to fit within 100-column
    - Delete forward declarations by moving function definitions
    - Rename variable is_sdio to is_sd
    - Replace unclear macros with meaningful alternatives
  - Link to v2: https://lore.kernel.org/all/20250912093451.125-1-hehuan1@eswincomputing.com/

  Changes in v2:
  - Delete the previous separate driver and yaml binding file
  - Update snps,dwcmshc-sdhci.yaml to add support for Eswin EIC7700
    - Add the new compautible string: "eswin,eic7700-dwcmshc"
    - Add new properties: clock-output-names, '#clock-cells',
      drive-impedance-ohm, eswin,hsp-sp-csr and eswin,syscrg-csr
    - Add customized reset-names for EIC7700 platform
  - Update sdhci-of-dwcmshc.c to add support for Eswin EIC7700
    - Add a new struct eic7700_priv to hold Eswin-specific data,
      including clock phases, register mappings, and drive
      impedance configuration
    - Implement EIC7700-specific sdhci_ops
      - set_clock: support core clock configuration with phase delay
      - reset: add PHY reset and configuration
      - set_uhs_signaling: support HS400 DLL lock
      - platform_execute_tuning: implement delay line tuning and phase
        code adjustment
    - Add initialization routine (eic7700_init)
    - Integrate the new platform data and ops into the driver's match table
  - Link to v1: https://lore.kernel.org/all/20250516091259.774-1-dongxuyang@eswincomputing.com/

Huan He (2):
  dt-bindings: mmc: sdhci-of-dwcmshc: Add Eswin EIC7700
  mmc: sdhci-of-dwcmshc: Add support for Eswin EIC7700

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  57 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 526 +++++++++++++++++-
 2 files changed, 555 insertions(+), 28 deletions(-)

-- 
2.25.1

