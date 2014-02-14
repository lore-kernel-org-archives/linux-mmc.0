From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 0/2] mmc: omap_hsmmc: fix for pre es3.0 OMAP3
Date: Thu, 13 Feb 2014 23:45:47 -0600
Message-ID: <1392356749-32091-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Balaji T K <balajitk@ti.com>, Chris Ball <chris@printf.net>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-mmc@vger.kernel.org

Originally reported in: https://patchwork.kernel.org/patch/3514851/
https://patchwork.kernel.org/patch/3514881/

ES3.0+ provides MMC controller which is fixed for multi-block reads,
however LDP platform

Looking at the various IP revision register information:
sdp2430: Revision: 1.2, Spec: 0.0, normal interrupt
OMAP3430-ldp: (ES2.1): Revision: 2.6, Spec: 0.0, normal interrupt
SDP3430:(ES3.0) Revision: 2.6, Spec: 0.0, normal interrupt
AM3517-evm: (ES1.1): Revision: 2.6, Spec: 0.0, normal interrupt
AM3517-crane:(ES1.1): Revision: 2.6, Spec: 0.0, normal interrupt
AM37x-evm: (ES1.2) Revision: 2.6, Spec: 0.0, normal interrupt
OMAP3630-beag-xm (ES1.2): Revision: 2.6, Spec: 0.0, normal interrupt
am335x-evm:(ES1.0): Revision: 3.1, Spec: 0.1, normal interrupt
am335x-sk: (ES2.1): Revision: 3.1, Spec: 0.1, normal interrupt
am335x-beaglebone-black:(ES2.0): Revision: 3.1, Spec: 0.1, normal
interrupt
sdp4430: (ES2.2): Revision: 3.1, Spec: 0.1, normal interrupt
OMAP4460-panda-es (ES1.1): Revision: 3.1, Spec: 0.1, normal interrupt
OMAP5uevm:(ES2.0): Revision: 3.3, Spec: 0.2, normal interrupt
dra7-evm (es1.1): Revision: 3.3, Spec: 0.2, normal interrupt

This series has been tested on the following platforms:
 1: BeagleBoard-XM:  Boot PASS: http://slexy.org/raw/s2ObUDfm5N
 2: BeagleBone-Black:  Boot PASS: http://slexy.org/raw/s2xmviGgFf
 3:       dra7:  Boot PASS: http://slexy.org/raw/s2Ad6rxaQk
 4:        ldp:  Boot PASS: http://slexy.org/raw/s20kEx9eHg
 5: PandaBoard-ES:  Boot PASS: http://slexy.org/raw/s2gHT1EWKF
 6:    sdp2430:  Boot PASS: http://slexy.org/raw/s20dvr8yQA (nfs)
 7:    sdp3430:  Boot PASS: http://slexy.org/raw/s2aUEsEemS
 8:    sdp4430:  Boot PASS: http://slexy.org/raw/s20nqL8gjz
 9: OMAP5432uEVM:  Boot PASS: http://slexy.org/raw/s20O0QfmZw
TOTAL = 9 boards, Booted Boards = 9, No Boot boards = 0

LDP platform prior to the series reports: http://slexy.org/raw/s20qVg17T0 

Series is based on v3.14-rc2

Nishanth Menon (2):
  mmc: omap_hsmmc: Add support for quirky omap3 hsmmc controller
  ARM: dts: omap3-ldp: fix mmc configuration

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |    1 +
 arch/arm/boot/dts/omap3-ldp.dts                    |   23 +++++++++++++++++
 drivers/mmc/host/omap_hsmmc.c                      |   26 +++++++++++++++++---
 3 files changed, 46 insertions(+), 4 deletions(-)

-- 
1.7.9.5
