Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5A6C6FA86
	for <linux-mmc@archiver.kernel.org>; Thu, 22 Sep 2022 22:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbiIVWDU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 22 Sep 2022 18:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIVWDT (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 22 Sep 2022 18:03:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3446F8C01;
        Thu, 22 Sep 2022 15:03:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3238B8361C;
        Thu, 22 Sep 2022 22:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAF0C433D6;
        Thu, 22 Sep 2022 22:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663884195;
        bh=nT5iFuX8ZK8R+77l1ynrssOj6kSp85P9Cz0rwUSNG2o=;
        h=From:To:Cc:Subject:Date:From;
        b=ImgIa4LELFyaJ9GPe9yDK4qZYwHWk+q4aX65Fk/UwZMMfEOanwB9f6N6OUeIWWXyz
         45STjCSv0vzjVc3YfsjevMGRG5og6+OE4PVPHdV05sMP+4aOrZyJ3pwwiVzcc1RJgU
         ByOCmwGlJUcAqPcGKJh5LHCoM4jVZUGSAfApviZ5pmqUXf9laAreQiNvEvZZHTektB
         aLans1rs6BenJC35tm0HnDIItlLe0TVToq5nQ/OltK7vXXQfLqrTePVnQm9NBYePf2
         DnZMaYzQX8VnJ+eOkgd+b3dpLUbTcWJAHSinxipb4mGemBWKQhy5ylVPl4WTiEApxD
         4c0iuLzgp7I5g==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     jh80.chung@samsung.com
Cc:     dinguyen@kernel.org, ulf.hansson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCHv2 0/3] mmc: socfpga: add method to configure clk-phase
Date:   Thu, 22 Sep 2022 17:03:05 -0500
Message-Id: <20220922220308.609422-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

This is version 2 of the patchset to configure the clk-phase for the
SDMMC controller on SoCFPGA platforms.

Updates from v1:
- Documented "altr,sysmgr-syscon" binding
- Cleaned up dw_mci_socfpga_priv_init() to get the "clk-phase-sd-hs"
  from the DTS. Ulf Hanson recommended using mmc_of_parse_clk_phase() in
  this function, however, I found that using mmc_of_parse_clk_phase() is a
  bit more complicated than just reading the "clk-phase-sd-hs" from the
  DTS. Here are the reasons:
 	- The call to mmc_of_parse_clk_phase() takes the struct mmc_host
 	  *host structure, and in the dw_mmc driver, and this structure
	  does not get populated until at the very end of the dw_mci_probe
	  function, after dw_mci_init_slot() gets called.
	- Also, in order to correctly extract the
	  phase_map.phase[timing], we need to wait until set_ios() is
	  called in order to get the host->timing parameter so it can be used for
	  the clock phase array.

Dinh Nguyen (3):
  dt-bindings: mmc: synopsys-dw-mshc: document "altr,sysmgr-syscon"
  arm64: dts: socfpga: Add clk-phase-sd-hs property to the sdmmc node
  mmc: dw_mmc-pltfm: socfpga: add method to configure clk-phase

 .../bindings/mmc/synopsys-dw-mshc.yaml        |  8 ++++
 .../boot/dts/altera/socfpga_stratix10.dtsi    |  1 +
 .../dts/altera/socfpga_stratix10_socdk.dts    |  1 +
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |  1 +
 .../boot/dts/intel/socfpga_agilex_socdk.dts   |  1 +
 .../boot/dts/intel/socfpga_n5x_socdk.dts      |  1 +
 drivers/mmc/host/dw_mmc-pltfm.c               | 41 ++++++++++++++++++-
 7 files changed, 53 insertions(+), 1 deletion(-)

-- 
2.25.1

