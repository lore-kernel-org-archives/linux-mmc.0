From: =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH v3 0/4] mmx: mxs-mmc: Some cleanups and fixes for the MXS MMC subsystem
Date: Thu,  8 Dec 2011 10:44:12 +0100
Message-ID: <cover.1323336236.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-mmc@vger.kernel.org

Lothar Wa=C3=9Fmann (4):
  Fix grammatical error in comment
  Some cleanups for the MMC driver
  Check the return codes of clk_enable() and mxs_reset_block()
  Add an appropriate MODULE_ALIAS

Changes wrt v2:
 - add missing Acked-by's
 - changed subject-prefix

 drivers/mmc/host/mxs-mmc.c |   87 +++++++++++++++++++++++++++---------=
---------
 1 file changed, 54 insertions(+), 33 deletions(-)
