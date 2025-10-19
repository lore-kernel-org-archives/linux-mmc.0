Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17EE0223323;
	Sun, 19 Oct 2025 11:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760874736; cv=none; b=cxIZuVXtHPsuaPSlCHQz+BD2ojr47kE6AKEhMRa4IlR9opqppYJOYHECy/DihW40NSLCnuxai9FKnAxM15WVahYQ5jJACXqnqTSYEHl/q1plIP7AwWtwAxRJfqT3/GdkAUAhVMrS69B/24rgnnl2sKVSdJRnNg3nJ9crhPrYJpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760874736; c=relaxed/simple;
	bh=1SpdrSn2bQqdg11G1CWv4rOZ0FihP4kExe0C1yk1Lgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ebZA15XQnvxjzaYIYyvSi/tVk4tdLkzACiU7656tZr9ub4kDPqB4s3QfiKOvurez+dMPgeuzowmnfho7Lm2LHc7yR1oCmVMW6lgwJusoJugSqbKqhxKF1TNI2X2xD1pLVjRwLKnxXBjuVq7C3diRGOYFubpA1dpqnCKRWjieSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005154LT.eswin.cn (unknown [10.100.73.96])
	by app2 (Coremail) with SMTP id TQJkCgAXtpTM0PRoYEMYAQ--.46151S2;
	Sun, 19 Oct 2025 19:51:45 +0800 (CST)
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
Subject: [PATCH v5 0/2] Add support for Eswin EIC7700 SD/eMMC controller
Date: Sun, 19 Oct 2025 19:51:32 +0800
Message-ID: <20251019115133.300-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAXtpTM0PRoYEMYAQ--.46151S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4ruFykJF1UArykuF15Jwb_yoW5KryUpF
	WUK348Gr13JryIvF4v9a4093W3Xan7Wry7Kw13Xw15Xw4qva4qqrWIka4Y9FZ8Cr97Xw45
	Z3yavr45CF12vrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBq14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
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

  Changes in v5:
  - Update snps,dwcmshc-sdhci.yaml
    - Update description for eswin,hsp-sp-csr
    - Fix eswin,hsp-sp-csr property structure to use nested items format
    - Remove unnecessary '|' symbol from description field
    - Wrap description lines to 80-chars
  - Update sdhci-of-dwcmshc.c
    - Remove inappropriate Reported-by and Closes tags, as the fixes are part
      of this patch
    - Fix error code return in eic7700_init() when syscon_node_to_regmap()
      fails (return PTR_ERR(hsp_regmap))
    - Remove unnecessary clock disable/enable operations when changing clock
      rates
    - Remove unnecessary parentheses around ~PHY_CNFG_RSTN_DEASSERT in
      sdhci_eic7700_config_phy()
    - Update misleading comments: change "SDIO specific" to "SD specific" in
      tuning logic
    - Fix multi-line comment format
  - Link to v4: https://lore.kernel.org/all/20251011111039.533-1-hehuan1@eswincomputing.com/

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
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 502 +++++++++++++++++-
 2 files changed, 542 insertions(+), 17 deletions(-)

-- 
2.25.1

