From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: [PATCH 0/2] mmc: atmel-mci: introduce MCI2 support on at91
Date: Thu, 17 Sep 2009 18:29:25 +0200
Message-ID: <1253204967-30010-1-git-send-email-nicolas.ferre@atmel.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756956AbZIQPZu@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, haavard.skinnemoen@atmel.com, kernel@avr32linux.org
List-Id: linux-mmc@vger.kernel.org

This patchset introduces the support of a new revision of the MCI IP on AT91
SOCs. The use of an alternate DMA engine on those platforms introduces the need
of a generic way of handling dma slave interface.

Note: those patches goes on top of the following patch that is already in
mmotm:
        atmel-mci: Unified Atmel MCI drivers (AVR32 & AT91)

Nicolas Ferre (2):
      atmel-mci: change use of dma slave interface
      mmc: atmel-mci: New MCI2 module support in atmel-mci driver

 arch/avr32/mach-at32ap/at32ap700x.c |    6 +-
 drivers/mmc/host/atmel-mci.c        |  167 ++++++++++++++++++++++++++++-------
 include/linux/atmel-mci.h           |    3 +-
 3 files changed, 143 insertions(+), 33 deletions(-)
