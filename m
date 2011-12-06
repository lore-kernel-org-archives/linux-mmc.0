From: =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [MXS MMC 5/5] Add an appropriate MODULE_ALIAS
Date: Tue,  6 Dec 2011 14:41:30 +0100
Message-ID: <b1c45bfdbc9323b2a6c50ce213a3e895aeea2b2f.1323177907.git.LW@KARO-electronics.de>
References: <cover.1323177907.git.LW@KARO-electronics.de>
 <1ebaeb7f7ed88b1d82f5fc3a01c0661f38e2a16d.1323177907.git.LW@KARO-electronics.de>
 <d935557e044d2ebc56b4e70487b519fe722e9017.1323177907.git.LW@KARO-electronics.de>
 <e668bb1ab5fbe406ef604a18f59292a05149ae51.1323177907.git.LW@KARO-electronics.de>
 <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323177907.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b4779523002ceef3e95887bbcf7ed570cdd93a95.1323177907.git.LW@KARO-electronics.de>
In-Reply-To: <cover.1323177907.git.LW@KARO-electronics.de>
References: <cover.1323177907.git.LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-mmc@vger.kernel.org


Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/mmc/host/mxs-mmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 0003d03..1ba08ae 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -886,3 +886,4 @@ module_exit(mxs_mmc_exit);
 MODULE_DESCRIPTION("FREESCALE MXS MMC peripheral");
 MODULE_AUTHOR("Freescale Semiconductor");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:mxs-mmc");
--=20
1.5.6.5
