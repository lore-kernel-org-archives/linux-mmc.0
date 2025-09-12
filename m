Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C1D27280F;
	Fri, 12 Sep 2025 09:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757669742; cv=none; b=mceI9YHR3fT71lyprm2ZELgT74rWJo46HBZI7HTIi6YD8pLIhsZAlxB6CeOs58aDUDX2yU1YbRadUXK6agOGGheIasSegvkZUwOz40/NkHCXz0QS97SRglAn2OzeJ50JY9AhPUfYPrj5Gqb171imttXuGNLytGVtA0Nj1AsC0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757669742; c=relaxed/simple;
	bh=xYeK3h6MGi3CXQpHgY6UYQw/twkgBe+IwSqxaTRTghw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rU+GeaPnZ5ihGl1Hd7ggtk6rQfixkzFM4GnnuFYKX9OQEuLQtTdtDdbkhR+wg3YlOenBhtdGjrHtm02sMPCRPJJn/v3XkA5MlRhi07yzwF5eq1j406cLourwozeseFiJRsorf43a7lHnRr/WdYVNw0SPWINIy8YX5/OiN5Kj85w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0005154LT.eswin.cn (unknown [10.12.96.103])
	by app2 (Coremail) with SMTP id TQJkCgAHppQ+6cNoQsjOAA--.23710S2;
	Fri, 12 Sep 2025 17:34:57 +0800 (CST)
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
Subject: [PATCH v2 0/2] Add support for Eswin EIC7700 SD/eMMC controller
Date: Fri, 12 Sep 2025 17:34:50 +0800
Message-ID: <20250912093451.125-1-hehuan1@eswincomputing.com>
X-Mailer: git-send-email 2.49.0.windows.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAHppQ+6cNoQsjOAA--.23710S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF45Jr1xurWDXrWkuF17Jrb_yoW8Xr4xpF
	W5KryfGrs8CryxZFs3G34v9a4fXw4xWry5Kr43J3W8X3yDZF1jqrWIka4YqFW3Jr4xXws8
	Z3y0gF1fCa1Yv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r4a6rW5MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0pRkwIhUUUUU=
X-CM-SenderInfo: 5khk3tzqr6v25zlqu0xpsx3x1qjou0bp/

From: Huan He <hehuan1@eswincomputing.com>

Updates:

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

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml      |  81 +-
 drivers/mmc/host/sdhci-of-dwcmshc.c           | 770 ++++++++++++++++++
 2 files changed, 845 insertions(+), 6 deletions(-)

-- 
2.25.1

