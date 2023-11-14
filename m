Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9B62FC29
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iKkcRUNU"
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3ADEC1
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 13:08:07 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41e58a33ec9so36625601cf.1
        for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 13:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699996087; x=1700600887; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bVfZqFoQfSFxFV4SokjDO2x1oFiuMyw4rUeKlbXA8wA=;
        b=iKkcRUNUpYkIKLkmAXmt6sw565yy/Ib0gdSjqk9hvGp4ujaj03DcI4EypjwMllHFnZ
         r60zrx41SaWeMhRAJKws7gaWUGvhv2kuBX3iFHQXvzbNqZVzdJKOxh2MofHHDB778iOE
         nS95V7P7rRivz3wKBdKNGCFPk59h26ss9JmDNlrh+N99vEiaZSANKroXjhYC8BD2SNTX
         aSnz1wxJEYzkw6L6YyORQrZsdWozyqP+96RgZvs/6meFN5EggQBKqTIicsHOFxQ0mtj2
         tg4yY0Ydr0thCRnWMErKL2IrNnKaFs+A/Y3chDL1UDwECUTzfVrT5maaeCRakcKkyHoZ
         +TVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699996087; x=1700600887;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bVfZqFoQfSFxFV4SokjDO2x1oFiuMyw4rUeKlbXA8wA=;
        b=jXyxIY00xqbTcss3m9USuWiQcSCUq3F32hpnuvNyzUW4Zu6U6UO+MxkcO6pq4jOThp
         hN8k2uy+npV3TgaEuVVgLb2ltDVLRBPNT/7MRSTYcpz5CZzfnyrK1DL0LAP9k7kErsne
         mczMvUr0RnC3+chaQ0BekrcjELmGdLFV/pjAHdeJvbeJ9Nud97BGvbIEfPoDbxOdcGuc
         2fkPqSK32XxqoteqxGPGEpev8w6w6XGZrdkcltivZv3Z6iA4F8sNmYYYPAS8ZCtO9L/W
         XR2glU+2btJZpNnmdbeaAoERuWgRZ5H8YujUPe/J/5HWN9SSA3eLupD069Hsm864vkDx
         g2pQ==
X-Gm-Message-State: AOJu0YyK66izQPxR4ScGEW4FyYLguSOmFe7gnL1RsF1Off4DNJaCeAZe
	qLZlBgfBq5Y/slYz7PXAH+0JMA==
X-Google-Smtp-Source: AGHT+IFbtE9CwIndoeJRTRvJiPKdvNVyfdVZv/ztDEXt8MeM8LfI1MhzcF2EytFUfZ/JcGgG/rTQMw==
X-Received: by 2002:a05:622a:1009:b0:41c:b617:8529 with SMTP id d9-20020a05622a100900b0041cb6178529mr3992208qte.21.1699996086857;
        Tue, 14 Nov 2023 13:08:06 -0800 (PST)
Received: from [127.0.1.1] ([12.186.190.1])
        by smtp.gmail.com with ESMTPSA id x16-20020ac85390000000b004198d026be6sm3027549qtp.35.2023.11.14.13.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 13:08:06 -0800 (PST)
From: Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v6 0/7] RISC-V: Add MMC support for TH1520 boards
Date: Tue, 14 Nov 2023 16:07:54 -0500
Message-Id: <20231114-th1520-mmc-v6-0-3273c661a571@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKvhU2UC/03MQQ6CMBCF4auQWVszLVCpK+9hWNAyyCSWmpYQC
 eHuVty4/F/yvg0SRaYE12KDSAsnDlMOfSrAjd30IMF9blCoSomlFPMoa4XCeydsRU2lB9KNNpA
 Pr0gDvw/s3uYeOc0hroe91N/1x0g0/8xSCxQoG9tjadwgLzfbrU+2kc4ueGj3ff8A6J1QV6cAA
 AA=
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Drew Fustini <dfustini@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699996085; l=6344;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=VuAG8WUc3nD8UqAChXAVi+/Hned3GYCDhorscuGxNno=;
 b=dh3BpKYFyDk9Us4BhY3MWKxSHHJRzzM1mdQ35wJx0bFsHU1BhxLMZO+z7Nae+mRnpUn0MmD9t
 7sV2YivthezAypbm3BVCZSXKT0iWMIz4zX8IpYgvC8hn6N+DU78lhxE
X-Developer-Key: i=dfustini@baylibre.com; a=ed25519;
 pk=p3GKE9XFmjhwAayAHG4U108yag7V8xQVd4zJLdW0g7g=

This series adds support for the MMC controller in the T-Head TH1520
SoC, and it enables the eMMC and microSD slot on both the BeagleV
Ahead and the Sipeed LicheePi 4A.

I tested on top of v6.6 with riscv defconfig. I was able to boot the
Ahead [1] and LPi4a [2] from eMMC. This patch series also exists as a
git branch [3].

Note: I have only tested eMMC and microSD. I have not yet configured
or tested the mmc controller used for SDIO WiFi yet.

References:
[1] https://gist.github.com/pdp7/881342620ec1509685f23a387e2fc8d7
[2] https://gist.github.com/pdp7/97017ad88d83fccac18eba69bff817b7
[3] https://github.com/pdp7/linux/tree/b4/th1520-mmc

Changes in PATCH v6:
- set the mmc nodes to disabled in the th1520.dtsi

Changes in PATCH v5:
https://lore.kernel.org/r/20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com
- fix logic in th1520_sdhci_set_phy() to correctly check that both
  MMC_CAP2_NO_SD and MMC_CAP2_NO_SDIO are set in host->mmc->caps2
- add Acked-by's from Adrian

Changes in PATCH v4:
https://lore.kernel.org/linux-riscv/20231101-th1520-mmc-v4-0-86e0216b5994@baylibre.com/
- set DWCMSHC_CARD_IS_EMMC when (MMC_CAP2_NO_SD | MMC_CAP2_NO_SDIO)
  as checking MMC_CAP_NONREMOVABLE is not sufficient
- change prefix of phy functions from th1520 to dwcmshc as they are not
  th1520 specific
- remove unneeded check of priv in dwcmshc_phy_1_8v_init()
- remove unneeded check of auto-tuning in th1520_execute_tuning()
- fix order of new nodes in th1520-beaglev-ahead.dts: move sdhci_clk
  before uart_sclk, move mmc0 and mmc1 before uart0
- fix comment typos pointed out by Adrian
- add trailers that I missed from v2

Changes in PATCH v3:
https://lore.kernel.org/r/20231023-th1520-mmc-v3-0-abc5e7491166@baylibre.com
- always call th1520_sdhci_set_phy() in th1520_set_uhs_signaling()
  and not only when timing is MMC_TIMING_MMC_HS400. This allows the
  microSD slot to work as th1520_phy_3_3v_init() is called from
  th1520_sdhci_set_phy().
- add mmc1 node for mmc controller connected to the microSD slot
- add enable mmc1 and add properties for microSD on the Ahead and LPi4A

Changes in PATCH v2:
https://lore.kernel.org/r/20231017-th1520-mmc-v2-0-4678c8cc4048@baylibre.com
- make use of BIT(), GENMASK(), FIELD_PREP(), FIELD_GET()
- add EXPORT_SYMBOL_GPL(__sdhci_execute_tuning)
- call th1520_phy_1_8v_init() when FLAG_IO_FIXED_1V8 is set
- set DWCMSHC_CARD_IS_EMMC when mmc caps contains MMC_CAP_NONREMOVABLE
- remove manipulation of AT_CTRL_AT_EN from th1520_set_uhs_signaling()
- remove unneccessary cycle of enabling and disabling AT_CTRL_AT_EN in
  th1520_execute_tuning()
- remove th1520_phy_1_8v_init_no_pull()
- remove th1520_phy_3_3v_init_no_pull()
- remove FLAG_PULL_UP_EN from priv->flags
- remove thead,phy-pull-up device tree property

Changes in PACH v1:
https://lore.kernel.org/all/20230921-th1520-mmc-v1-0-49f76c274fb3@baylibre.com/
- ADMA mode now works correctly due to a patch from Jisheng on the list
  ("riscv: dts: thead: set dma-noncoherent to soc bus") and this commit
  from Icenowy that is now merged: 8eb8fe67e2c8 ("riscv: errata: fix
  T-Head dcache.cva encoding").
- Expose __sdhci_execute_tuning from sdhci.c so that it can be called
  from th1520_execute_tuning()
- Refactor the define macros for all the PHY related registers to make
  it easier to understand the bit fields that the code is manipulating
- Replace magic numbers in the PHY register writes with proper defines
- Replace non_removable in dwcmshc_priv with check of mmc_host.caps
- Drop dt prop "thead,io-fixed-1v8" and instead check for existing
  properties: "mmc-ddr-1_8v", "mmc-hs200-1_8v", or "mmc-hs400-1_8v"
- Rename dt prop from "thead,pull-up" to "thead,phy-pull-up" and
  improve the description in the dt binding
- Replace pull_up_en in dwcmshc_priv with bit field in new flags field
- Create th1520_set_uhs_signaling() and call dwcmshc_set_uhs_signaling()
  from it instead of adding th1520 code to dwcmshc_set_uhs_signaling()
- Return -EIO instead of -1 upon errors in th1520_execute_tuning()

Changes in RFC v2:
https://lore.kernel.org/linux-riscv/20230724-th1520-emmc-v2-0-132ed2e2171e@baylibre.com/
- Expand dwcmshc_priv based on driver in the T-Head 5.10 kernel:
  delay_line, non_removable, pull_up_en, io_fixed_1v8
- New boolean property "thead,pull-up" indicates phy pull-up config
- New boolean property "thead,io-fixed-1v8" indicates that io voltage
  should be set to 1.8V during reset
- Add th1520_phy_1_8v_init() as voltage_switch op
- Add th1520_execute_tuning() as the platform_execute_tuning op
- Added th1520_sdhci_reset() as the .reset op. This function will set
  io voltage to 1.8V after calling the standard sdhci_reset() function.
- Modified dwcmshc_set_uhs_signaling() to enable SDHCI_CTRL_VDD_180 when
  io_fixed_1v8 is true
- Add many defines for register offsets and settings based on the mmc
  support in the T-Head downstream v5.10 kernel

RFC v1 series:
https://lore.kernel.org/r/20230724-th1520-emmc-v1-0-cca1b2533da2@baylibre.com

Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
Drew Fustini (7):
      dt-bindings: mmc: sdhci-of-dwcmhsc: Add T-Head TH1520 support
      mmc: sdhci: add __sdhci_execute_tuning() to header
      mmc: sdhci-of-dwcmshc: Add support for T-Head TH1520
      riscv: defconfig: Enable mmc and dma drivers for T-Head TH1520
      riscv: dts: thead: Add TH1520 mmc controllers and sdhci clock
      riscv: dts: thead: Enable BeagleV Ahead eMMC and microSD
      riscv: dts: thead: Enable LicheePi 4A eMMC and microSD

 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   1 +
 arch/riscv/boot/dts/thead/th1520-beaglev-ahead.dts |  20 ++
 .../boot/dts/thead/th1520-lichee-module-4a.dtsi    |  20 ++
 arch/riscv/boot/dts/thead/th1520.dtsi              |  25 ++
 arch/riscv/configs/defconfig                       |   2 +
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 349 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |   3 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 8 files changed, 420 insertions(+), 1 deletion(-)
---
base-commit: 8cfd133bee055fb537d2338b808079a77de60052
change-id: 20231031-th1520-mmc-b4e846fe6869

Best regards,
-- 
Drew Fustini <dfustini@baylibre.com>

