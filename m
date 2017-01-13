From: Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH v3 0/2]  mmc: pwrseq: add support for Marvell SD8787 chip
Date: Thu, 12 Jan 2017 21:29:12 -0800
Message-ID: <20170113052914.12400-1-matt@ranostay.consulting>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: tony@atomide.com, Matt Ranostay <matt@ranostay.consulting>
List-Id: linux-mmc@vger.kernel.org

Changes from v1:
* split devictree docs from pwrseq changes
* rebase devicetree documents due to filename change
* rebase pwrseq patchset

Changes from v2:
* fix rookie mistake missing the main source file and docs

Matt Ranostay (2):
  devicetree: document new marvell-8xxx and pwrseq-sd8787 options
  mmc: pwrseq: add support for Marvell SD8787 chip

 .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt  |  14 +++
 .../bindings/net/wireless/marvell-8xxx.txt         |   7 +-
 drivers/mmc/core/Kconfig                           |  10 ++
 drivers/mmc/core/Makefile                          |   1 +
 drivers/mmc/core/pwrseq_sd8787.c                   | 117 +++++++++++++++++++++
 5 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-sd8787.txt
 create mode 100644 drivers/mmc/core/pwrseq_sd8787.c

-- 
2.10.2
