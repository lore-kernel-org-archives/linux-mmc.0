From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 5/5] MMC: mmci: Add required documentation for Device Tree bindings
Date: Wed, 14 Mar 2012 14:20:03 +0000
Message-ID: <1331734803-17954-6-git-send-email-lee.jones@linaro.org>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:45900 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030670Ab2CNOUQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Mar 2012 10:20:16 -0400
Received: by mail-wi0-f172.google.com with SMTP id hj6so7240835wib.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 Mar 2012 07:20:16 -0700 (PDT)
In-Reply-To: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: cjb@laptop.org, arnd@arndb.de, niklas.hernaeus@linaro.org, linux-mmc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>

This provides full documentation detailing each compulsory,
optional and device (variant) specific properties available
for use within the MMCI Device Tree.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mmc/mmci.txt |   27 ++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmci.txt

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
new file mode 100644
index 0000000..946f080
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -0,0 +1,27 @@
+* ARM PrimeCell MultiMedia Card Interface (MMCI) PL180/1
+
+The ARM PrimeCell MMCI PL180 and PL181 provides and interface for 
+reading and writing to MultiMedia and SD cards alike.
+
+Required properties:
+- compatible             : contains "arm,pl18x", "arm,primecell".
+- reg                    : contains pl18x registers and length.
+- interrupts             : contains the device IRQ(s).
+- arm,primecell-periphid : contains the PrimeCell Peripheral ID.
+
+Optional properties:
+- ocr_mask               : contains the regulator oscillator mask
+- wp-gpios               : contains any write protect (ro) gpios
+- cd-gpios               : contains any card detection gpios
+- cd-invert              : indicates whether the cd gpio is inverted 
+- clock_frequency        : contains the maximum operating frequency
+- mmc_cap_4_bit_data     : indicates whether device is 4 bit capable
+- mmc_cap_8_bit_data     : indicates whether device is 8 bit capable
+- mmc_cap_mmc_highspeed  : indicates whether MMC is high speed capable
+- mmc_cap_sd_highspeed   : indicates whether SD is high speed capable
+
+ux500 variant specific properties:
+- gpio-en                : contains the level-shifter enable gpio
+- gpio-vsel              : contains the level-shifter voltage select gpio
+- tx_dst_dev_type        : contains the tx destination device (DMA) 
+- rx_src_dev_type        : contains the rx source device (DMA)
-- 
1.7.5.4

