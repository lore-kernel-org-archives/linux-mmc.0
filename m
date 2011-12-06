From: =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [MXS MMC 3/5] Add support for SSP/MMC ports 2 & 3
Date: Tue,  6 Dec 2011 14:41:28 +0100
Message-ID: <e668bb1ab5fbe406ef604a18f59292a05149ae51.1323177907.git.LW@KARO-electronics.de>
References: <cover.1323177907.git.LW@KARO-electronics.de>
 <1ebaeb7f7ed88b1d82f5fc3a01c0661f38e2a16d.1323177907.git.LW@KARO-electronics.de>
 <d935557e044d2ebc56b4e70487b519fe722e9017.1323177907.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d935557e044d2ebc56b4e70487b519fe722e9017.1323177907.git.LW@KARO-electronics.de>
In-Reply-To: <cover.1323177907.git.LW@KARO-electronics.de>
References: <cover.1323177907.git.LW@KARO-electronics.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <cjb@laptop.org>, =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-mmc@vger.kernel.org

i.MX28 has four SSP/MMC units, only two of which are currently
usable.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 arch/arm/mach-mxs/clock-mx28.c               |    4 ++++
 arch/arm/mach-mxs/devices/platform-mxs-mmc.c |    2 ++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-m=
x28.c
index fc86b04..b8cc458 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -625,6 +625,8 @@ static struct clk_lookup lookups[] =3D {
 	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
 	_REGISTER_CLOCK("mxs-mmc.0", NULL, ssp0_clk)
 	_REGISTER_CLOCK("mxs-mmc.1", NULL, ssp1_clk)
+	_REGISTER_CLOCK("mxs-mmc.2", NULL, ssp2_clk)
+	_REGISTER_CLOCK("mxs-mmc.3", NULL, ssp3_clk)
 	_REGISTER_CLOCK("flexcan.0", NULL, can0_clk)
 	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
 	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
@@ -774,6 +776,8 @@ int __init mx28_clocks_init(void)
 	 */
 	clk_set_parent(&ssp0_clk, &ref_io0_clk);
 	clk_set_parent(&ssp1_clk, &ref_io0_clk);
+	clk_set_parent(&ssp2_clk, &ref_io1_clk);
+	clk_set_parent(&ssp3_clk, &ref_io1_clk);
=20
 	clk_enable(&cpu_clk);
 	clk_enable(&hbus_clk);
diff --git a/arch/arm/mach-mxs/devices/platform-mxs-mmc.c b/arch/arm/ma=
ch-mxs/devices/platform-mxs-mmc.c
index 382dacb..bef9d92 100644
--- a/arch/arm/mach-mxs/devices/platform-mxs-mmc.c
+++ b/arch/arm/mach-mxs/devices/platform-mxs-mmc.c
@@ -41,6 +41,8 @@ const struct mxs_mxs_mmc_data mx23_mxs_mmc_data[] __i=
nitconst =3D {
 const struct mxs_mxs_mmc_data mx28_mxs_mmc_data[] __initconst =3D {
 	mxs_mxs_mmc_data_entry(MX28, 0, 0),
 	mxs_mxs_mmc_data_entry(MX28, 1, 1),
+	mxs_mxs_mmc_data_entry(MX28, 2, 2),
+	mxs_mxs_mmc_data_entry(MX28, 3, 3),
 };
 #endif
=20
--=20
1.5.6.5
