Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20520C433EF
	for <linux-mmc@archiver.kernel.org>; Sat,  4 Sep 2021 14:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF972610C8
	for <linux-mmc@archiver.kernel.org>; Sat,  4 Sep 2021 14:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbhIDOrB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sat, 4 Sep 2021 10:47:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230039AbhIDOrA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Sat, 4 Sep 2021 10:47:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E10F460F4C;
        Sat,  4 Sep 2021 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630766758;
        bh=02xpBFyuzgwp7S6L0Iqal/dDd/DT6q3WHYxs8cFwA6w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NIxuckaQIAiDthSzpKV/N2kDEkuJs5//k/eivUHgjZJROAZ8noZe70hJtAhoFRf02
         pmAzMcKBuJbsnMFz7s34vO6qQdxnIK63d1WU95TTCKHe0X0+by2FaGwuGjqIGs8QAM
         u1OIdlHORpkSQmTkjKu71rbi1Pro8cBUp/bQpPwA80tb4OtMGxJBUnUfdSUqGjI0R9
         ENjeYLWWFAes7RVJkYvSHnOp7DUvtoZN5Yzl4qX9kqVI2+U7fr6Z4TL/LrjVbn2XKK
         mGyHdSzZvTY+zjJ98dWDV1/qMzBCBpxkvm4f9uxHPYT+Bz8Lz31oXbrGtlY6aWMZ+t
         uaMmGxgTyoWzA==
Message-ID: <5e204d7a3c915f9e1308928e908f058c2a522c14.camel@kernel.org>
Subject: Re: [PATCH V2 00/10] ARM: dts: Add Raspberry Pi CM4 & CM4 IO Board
 support
From:   nicolas saenz julienne <nsaenz@kernel.org>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Rob Herring <robh+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <maxime@cerno.tech>, iivanov@suse.de,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Sat, 04 Sep 2021 16:45:53 +0200
In-Reply-To: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
References: <1628334401-6577-1-git-send-email-stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Stefan,

On Sat, 2021-08-07 at 13:06 +0200, Stefan Wahren wrote:
> This series add support for the Raspberry Pi Compute Module 4 and its
> IO board.

Sorry for the late review. I finally got some time to review/test this
properly. The devicetree patches look really good, dtbs_check's shows no new
errors, and all peripherals work. The only thing I can't verify is PCIe as I
have nothing to plug into it, but it should work.

I'll apply the series (modulo the mmc patches) for-next soon.

Thanks!

> Changes in V2:
> - drop emmc2bus patch as it affects userspace (thanks to Marc Zyngier)
> - tested with CM4 and integrate sdhci patches from Nicolas (just include kHz fixups)
> - add Rob's Acked-by
> - add HS200 property to emmc2 node for a slight performance gain
> - move antenna comment to the proper position
> 
> Nicolas Saenz Julienne (2):
>   mmc: sdhci-iproc: Cap min clock frequency on BCM2711
>   mmc: sdhci-iproc: Set SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN on BCM2711
> 
> Stefan Wahren (8):
>   ARM: dts: bcm2711: fix MDIO #address- and #size-cells
>   ARM: dts: bcm2711-rpi-4-b: fix sd_io_1v8_reg regulator states
>   dt-bindings: display: bcm2835: add optional property power-domains
>   ARM: dts: bcm283x-rpi: Move Wifi/BT into separate dtsi
>   dt-bindings: arm: bcm2835: Add Raspberry Pi Compute Module 4
>   ARM: dts: Add Raspberry Pi Compute Module 4
>   ARM: dts: Add Raspberry Pi Compute Module 4 IO Board
>   arm64: dts: broadcom: Add reference to RPi CM4 IO Board
> 
>  .../devicetree/bindings/arm/bcm/bcm2835.yaml       |   1 +
>  .../bindings/display/brcm,bcm2835-dsi0.yaml        |   3 +
>  .../bindings/display/brcm,bcm2835-hdmi.yaml        |   3 +
>  .../bindings/display/brcm,bcm2835-v3d.yaml         |   3 +
>  .../bindings/display/brcm,bcm2835-vec.yaml         |   3 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts              |  42 ++-----
>  arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts           | 138 +++++++++++++++++++++
>  arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi             | 113 +++++++++++++++++
>  arch/arm/boot/dts/bcm2711.dtsi                     |   4 +-
>  arch/arm/boot/dts/bcm2835-rpi-zero-w.dts           |  31 ++---
>  arch/arm/boot/dts/bcm2837-rpi-3-a-plus.dts         |  36 ++----
>  arch/arm/boot/dts/bcm2837-rpi-3-b-plus.dts         |  36 ++----
>  arch/arm/boot/dts/bcm2837-rpi-3-b.dts              |  36 ++----
>  arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi         |  34 +++++
>  arch/arm64/boot/dts/broadcom/Makefile              |   1 +
>  .../arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts |   2 +
>  drivers/mmc/host/sdhci-iproc.c                     |  21 +++-
>  18 files changed, 366 insertions(+), 142 deletions(-)
>  create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4-io.dts
>  create mode 100644 arch/arm/boot/dts/bcm2711-rpi-cm4.dtsi
>  create mode 100644 arch/arm/boot/dts/bcm283x-rpi-wifi-bt.dtsi
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
> 


