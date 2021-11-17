Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5973C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 22:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BA160EE5
	for <linux-mmc@archiver.kernel.org>; Wed, 17 Nov 2021 22:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbhKQWbx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 17 Nov 2021 17:31:53 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:36370 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S241234AbhKQWbw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 17 Nov 2021 17:31:52 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AHKt5Ko018539;
        Wed, 17 Nov 2021 14:28:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : mime-version : in-reply-to : references :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=HLM8Yr+Co8RdV6Vxg07CVlRMlj5TEV3a+mUrbRF9ccs=;
 b=NxgBw4yWXvZddSKHZWbYUe6vY/nQ7HANrKWEXMBk6/qkrsBRNvsJEQahWi879Crrhp0r
 5l/DRavKuX2+JkFQBk+N/Tp+hegZIjEcX2HvTKEI608QPANmWSCO3c1BimVE31ZK+EqT
 CSDCif1JbSO1WT1wh9LMK50zw36zbllU8eh8gAeVCHwFGcegD2It1dwI7cjOfuje2ymT
 tmBwqcGAlpeJyzoSkBVMeXrnOcfHJkIZX/eiEcmw26Mzf8QUWnX8OqbSzMFm3WDH86yy
 OxRk9Wp2JbVHjg85x20llI37z+vSg+MuD+CFcD4Vq+AARFoBSWVc916khiyRThuvvhUs Kg== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3cd34btexb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 17 Nov 2021 14:28:43 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Wed, 17 Nov
 2021 14:28:41 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Wed, 17 Nov 2021 14:28:41 -0800
Received: from localhost.localdomain (unknown [10.110.150.170])
        by maili.marvell.com (Postfix) with ESMTP id 7F7055B694D;
        Wed, 17 Nov 2021 14:28:41 -0800 (PST)
From:   Wojciech Bartczak <wbartczak@marvell.com>
To:     <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <beanhuo@micron.com>,
        <tanxiaofei@huawei.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wbartczak@marvell.com>
Subject: [PATCH 2/2] dt-bindings: mmc: Add vmmc/vqmmc for Cavium driver
Date:   Wed, 17 Nov 2021 14:28:01 -0800
Message-ID: <f1aa09f05ea34c2970785a79c3d791626da9bc32.1637186803.git.wbartczak@marvell.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
In-Reply-To: <cover.1637186803.git.wbartczak@marvell.com>
References: <cover.1637186803.git.wbartczak@marvell.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Vo_x-LER69sAzH9KcjzKJRpvhpuD39Fz
X-Proofpoint-GUID: Vo_x-LER69sAzH9KcjzKJRpvhpuD39Fz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_09,2021-11-17_01,2020-04-07_01
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Octeon/OcteonTX MMC supports up to 3 card slots.
Each slot can support SD or MMC cards with various speed.
However, any level-shifting to accommodate different signal voltages
for the cards is done by external hardware, under control of an optional
vqmmc regulator object, typically controlled by gpio.
The details of device-tree control of MMC signals via GPIO at reset
is available in this file.

If any mmc-slots have a vqmmc-supply property,
take it as a warning that we must switch carefully between
slots (unless they have the same vqmmc object), tri-stating
MMC signals to avoid any transient states as level-shifters
are enabled/disabled, by zeroing MIO_EMM_CFG[bus_id].

There's no need to list vqmmc property if all the mmc-slots
on a board run at same signal voltage, and have same width.
In this case the old behavior, enabling all probed slots in
MIO_EMM_CFG, allows faster slot-switching.

Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
---
 .../devicetree/bindings/mmc/cavium-mmc.txt    | 47 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/cavium-mmc.txt b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
index 1433e6201dff..d0b750e23332 100644
--- a/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/cavium-mmc.txt
@@ -28,6 +28,46 @@ Deprecated properties:
 - power-gpios : use vmmc-supply instead
 - cavium,octeon-6130-mmc-slot : use mmc-slot instead
 
+GPIO control via vmmc-supply & vqmmc-supply:
+  Two types of regulator object can be specified as mmc properties,
+  typically regulator-fixed controlled by GPIO pins.
+
+  Octeon/OcteonTX chips commonly use GPIO8 as an MMC-reset pin.
+  In systems which may boot from MMC, it starts as input, and is gently
+  pulled up/down by board logic to indicate the active sense of the
+  signal. Chip reset then drives the signal in the opposite direction
+  to effect a reset of target devices.
+  Device tree should model this with a vmmc-supply regulator, gated by
+  GPIO8, so GPIO8 is driven in the non-reset direction when MMC devices
+  are probed, and held there until rmmod/shutdown/suspend.
+  This allows a warm reboot to reset the MMC devices.
+
+  Octeon/OcteonTX MMC supports up to 3 mmc slots, but any
+  level-shifting to accommodate different signal voltages is
+  done by external hardware, under control of an optional
+  vqmmc regulator object, typically controlled by GPIO.
+
+  If any mmc-slots have a vqmmc-supply property, it is taken as a warning
+  that we must switch carefully between slots (unless they have the same
+  vqmmc object), tri-stating MMC signals to avoid any transient states
+  as level-shifters are enabled/disabled.
+
+  Even when so-called bi-directional level shifters are used,
+  this technique should be employed when using different bus-widths
+  on different slots, disabling level shifters to avoid presenting
+  non-uniform impedance across DATA0-7 & CMD when non-selected
+  4-wide slots are left enabled, while accessing 8-wide targets.
+
+  Note that it's not possible to specify multiple regulators
+  controlled by same GPIO pin, but with different active state.
+  If one GPIO line is require to switch voltage/routing between
+  different mmc-slots, specify a vqmmc-supply on one slot, but
+  not the other. The regulator_disable call on leaving that slot
+  will implicitly switch the state to support the unmarked slot.
+
+  There's no need to list vqmmc-supply if all the mmc-slots on
+  a board run at same voltage, and have same width.
+
 Examples:
 	mmc_1_4: mmc@1,4 {
 		compatible = "cavium,thunder-8390-mmc";
@@ -40,7 +80,8 @@ Examples:
 			compatible = "mmc-slot";
 			reg = <0>;
 			vmmc-supply = <&mmc_supply_3v3>;
-			max-frequency = <42000000>;
+			vqmmc-supply = <&vqmmc_3v3>;
+			max-frequency = <52000000>;
 			bus-width = <4>;
 			cap-sd-highspeed;
 		};
@@ -49,9 +90,11 @@ Examples:
 			compatible = "mmc-slot";
 			reg = <1>;
 			vmmc-supply = <&mmc_supply_3v3>;
-			max-frequency = <42000000>;
+			vqmmc-supply = <&vqmmc_1v8>;
+			max-frequency = <100000000>;
 			bus-width = <8>;
 			cap-mmc-highspeed;
 			non-removable;
 		};
 	};
+
-- 
2.17.1

