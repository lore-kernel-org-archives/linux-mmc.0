From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Subject: [PATCH v2 0/2] R-Car D3 (r8a77995) SDHI (eMMC) integration
Date: Wed, 29 Nov 2017 17:06:44 +0100
Message-ID: <1511971606-580-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: horms@verge.net.au, geert@linux-m68k.org
Cc: linux-renesas-soc@vger.kernel.org, wsa@the-dreams.de, magnus.damm@gmail.com, linux-mmc@vger.kernel.org, marek.vasut@gmail.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi!

This integrates the SDHI hardware on R-Car D3 and enables the Draak board's
eMMC drive.

This revision dumps the two patches that have been applied already, fixes
the sdhi2_pins voltage, removes the redundant SDHI compatible string and
makes the internal DMAC whitelisting pattern more conservative.

CU
Uli


Ulrich Hecht (2):
  mmc: renesas_sdhi: enable R-Car D3 (r8a77995) support
  arm64: dts: r8a77995: draak: enable SDHI2

 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 44 ++++++++++++++++++++++++++
 drivers/mmc/host/renesas_sdhi_internal_dmac.c  |  1 +
 2 files changed, 45 insertions(+)

-- 
2.7.4
