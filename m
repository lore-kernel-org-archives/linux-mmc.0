Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0B928CF49;
	Fri, 10 Oct 2025 09:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760089133; cv=none; b=MKqKiQG4UHElAFSQA4vqYhqeQd9/2dzUZ3w6Ni5rYTPwYIub4R9x+WflYOqGj85X4d/kU56DOQ9fgtiCmoulnYlHnpUG8rvz977AbG5l4Z08LyrpsAg2O/XfuojbQZFqDt14LmgYynV6QqHphbX4uyAQdeeOY8WvCCNVpiebqYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760089133; c=relaxed/simple;
	bh=FtvEdaOVNeBt36y5xmuBmQSNskj9JHUU5VbtV9PuJdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lJI99UJRKvgySjPkiilG/AiPB9Hx3Qwcldk2FBqd/l/jZu7uynUeW4ayqu03DxJZwP0qXr25HXobCTL7b642FozXB5+yBgYvwV5nBOhvumJFrSyu1Yaglk/xm6Qcq+WybEJ8aWsxWaOk1ALBBv1P+NrdZVU219BgU9o654WL7AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005154LT.eswin.cn (unknown [10.12.96.103])
	by app1 (Coremail) with SMTP id TAJkCgAXOxED1OhodEIDAQ--.1303S2;
	Fri, 10 Oct 2025 17:38:13 +0800 (CST)
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
Subject: [PATCH v3 0/2] Add support for Eswin EIC7700 SD/eMMC controller
Date: Fri, 10 Oct 2025 17:38:07 +0800
Message-ID: <20251010093807.1579-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgAXOxED1OhodEIDAQ--.1303S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWfGFykCF4rWFWfKw4kWFg_yoW8tw1kpF
	W5G34fGr1YyryxZan3Ka4v9a4fXws7Wryjgw13Jw1UX3yqva4jqrWIka4YkFW5Jr1xXws0
	9ay2qF13C3WavrJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPa14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	M4IIrI8v6xkF7I0E8cxan2IY04v7M4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVW8ZVWrXw
	CY02Avz4vE-syl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6r
	W5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	WUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTR
	ZqXHDUUUU
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

Updates:

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

