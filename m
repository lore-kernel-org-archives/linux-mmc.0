Return-Path: <linux-mmc+bounces-7-linux-mmc=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7E0C4167D
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:47:58 +0000 (UTC)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B13031C20CD6
	for <linux-mmc@archiver.kernel.org>; Fri, 10 Nov 2023 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEA932C6C;
	Fri, 10 Nov 2023 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dK8XYg2w"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670403A294
	for <linux-mmc@vger.kernel.org>; Fri, 10 Nov 2023 17:46:39 +0000 (UTC)
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597BA4EFE
	for <linux-mmc@vger.kernel.org>; Thu,  9 Nov 2023 22:13:58 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id ada2fe7eead31-45da94f4b90so761179137.3
        for <linux-mmc@vger.kernel.org>; Thu, 09 Nov 2023 22:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1699596837; x=1700201637; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+XcC9jhP/bGq7aC/UoHPwAPHEM/GXNVyFdjZVSpXIVk=;
        b=dK8XYg2we4Uzj6uceGZ2BlWvE4OMnkuJpVtL4OcAqMjZCYhfQZ/FLu38xsVmCs84w8
         t0a+je0SObZbC5nGlyQYN80wRwpl0eMb/LZWaausXJJlQ0/Ypwdfgt2gQ/IkA5Pp6Eh+
         nLh32dYsikk5ukVx9zTFG6t2qJo/2onANjnqx6VYeUBgDOFDAGzq1msbPFaW54klLKff
         kw9/TMqWLx37MGsqdeRtLqdZVTu+H7xRWku2EqUv/GdvGlcy3Y65aSIdb294fD6YAKVj
         nVSNZdl2863pgu+QqELI92FLOwA3ePX1dKmwwfz0ac9fQ6GW9QwZ3gKMVjN/1X4mQpYx
         zSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699596837; x=1700201637;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XcC9jhP/bGq7aC/UoHPwAPHEM/GXNVyFdjZVSpXIVk=;
        b=fzBjZbx8YLTT60tF1C4xkQkQT71s5U7vel+YokBcOpXtcXn9MGEtA5Vevpmo6xVMDV
         qUkBXDLow4pfjRH3ogkdfjjGuxGadj1R4hgHZtlEBTbZfFJwc8LIlXJmbQnpKoBdznc8
         eO2VVys5Gz4xNYW04Wc5C7f6jWPmu9Vr500PcmigTSLb/7aJMf7YqJscXhAxgCKiZo3x
         wN8WkOTgNZ0OlcoVWO1r/KFSTXR7ykkqeuTmU8k3SsB8WLK02aH2/LaaJj5ixLyRh4Nm
         TEAUA9btU2eDwJJq3dzK6OP6w0VlLb9LhP1Z1Oifo9W3AQlGwMQde1ww06ARzAGDXRLU
         x25w==
X-Gm-Message-State: AOJu0YwDkm7kOwZPdML4q8womnMoU+kjCSrLXTGsLu4R8cOZBNctJiSG
	ptu42wK1lHLGdlS+ZJJ+ChVT6xkHsk/ejky86ZAQ2Q==
X-Google-Smtp-Source: AGHT+IFkQpr0eaXWEhDr21mdSAtBP0kGg5lYXmYv1+D4154UOsr+qeTrAtZAzTwbIvE2xTtyDvJC4A==
X-Received: by 2002:a17:902:7084:b0:1c9:bca2:d653 with SMTP id z4-20020a170902708400b001c9bca2d653mr3086970plk.11.1699594945459;
        Thu, 09 Nov 2023 21:42:25 -0800 (PST)
Received: from [127.0.1.1] ([2601:1c2:1800:f680:2071:4479:98b8:cc69])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm4498845plb.9.2023.11.09.21.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 21:42:25 -0800 (PST)
From: Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v5 0/7] RISC-V: Add MMC support for TH1520 boards
Date: Thu, 09 Nov 2023 21:41:10 -0800
Message-Id: <20231109-th1520-mmc-v5-0-018bd039cf17@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHbCTWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDI2NDA2ND3ZIMQ1MjA93c3GTdJJNUCxOztFQzCzNLJaCGgqLUtMwKsGHRsbW
 1AOy3IMZcAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699594943; l=6190;
 i=dfustini@baylibre.com; s=20230430; h=from:subject:message-id;
 bh=m+hSYoMizlNfFoD70CP0rvM+rJPjrC2/jGP5h5E7auY=;
 b=+kVfNZUJ/yL4kzpJ4UTre/gKwRHh0FCK0PeDAaVn5Fmmu+H1uCqdJGe/3xaeF8eEaGeYAj8fc
 o3aHLPRHUMVAFJJJ1fCSWSdyGrQElfHtLh7LfCQoeOpGVzP68v/bcZC
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

Changes in PATCH v5:
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
 arch/riscv/boot/dts/thead/th1520.dtsi              |  23 ++
 arch/riscv/configs/defconfig                       |   2 +
 drivers/mmc/host/sdhci-of-dwcmshc.c                | 349 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |   3 +-
 drivers/mmc/host/sdhci.h                           |   1 +
 8 files changed, 418 insertions(+), 1 deletion(-)
---
base-commit: 8cfd133bee055fb537d2338b808079a77de60052
change-id: 20231031-th1520-mmc-b4e846fe6869

Best regards,
-- 
Drew Fustini <dfustini@baylibre.com>


