From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2 0/7] fix build failure of mn10300
Date: Thu, 18 Jun 2015 17:47:46 +0530
Message-ID: <1434629873-11668-1-git-send-email-sudipm.mukherjee@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:36474 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754016AbbFRMSR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jun 2015 08:18:17 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Howells <dhowells@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Johan Hovold <johan@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-am33-list@redhat.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Hi,
This is an attempt to fix the build failures when building mn10300 with
allmodconfig. As I have never worked with arch files so I hope you will
point me to right direction to correct my mistakes in this attempt.

regards
sudip

Sudip Mukherjee (7):
  mn10300: fix build failure
  mn10300: Provide dummy dma_alloc_attrs() and dma_free_attrs()
  mmc: mediatek: build as module
  USB: mos7720: rename DCR
  samples: kdbus: disable for mn10300
  mn10300: kgdb_arch_set_pc
  mn10300: add early_init_dt_*

 arch/mn10300/include/asm/dma-mapping.h | 13 +++++++++++++
 arch/mn10300/include/asm/kprobes.h     | 12 ++++++++++++
 arch/mn10300/kernel/kgdb.c             |  5 +++++
 arch/mn10300/kernel/setup.c            | 15 +++++++++++++++
 drivers/mmc/host/mtk-sd.c              |  1 +
 drivers/usb/serial/mos7720.c           | 16 ++++++++--------
 samples/Kconfig                        |  2 +-
 7 files changed, 55 insertions(+), 9 deletions(-)

-- 
1.8.1.2

