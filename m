From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC 1/3] DT: bindings: mmc: Add property for 3.3V only support
Date: Sat,  6 Aug 2016 12:55:38 +0000
Message-ID: <1470488140-10104-2-git-send-email-stefan.wahren@i2se.com>
References: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1470488140-10104-1-git-send-email-stefan.wahren@i2se.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Fabio Estevam <fabio.estevam@nxp.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Marek Vasut <marex@denx.de>, Otavio Salvador <otavio@ossystems.com.br>, devicetree@vger.kernel.org, Holger Schurig <holgerschurig@gmail.com>, Stefan Wahren <stefan.wahren@i2se.com>, linux-mmc@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Currently there is no proper way to define that a MMC host supports
only 3.3V. The property no-1-8-v is broken and has different meanings
for different sdhci variants. So add a new property for 3.3V only
support and mark no-1-8-v as deprecated.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 22d1e1f..b2b8960 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -27,8 +27,6 @@ Optional properties:
   logic it is sufficient to not specify wp-gpios property in the absence of a WP
   line.
 - max-frequency: maximum operating clock frequency
-- no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
-  this system, even if the controller claims it is.
 - cap-sd-highspeed: SD high-speed timing is supported
 - cap-mmc-highspeed: MMC high-speed timing is supported
 - sd-uhs-sdr12: SD UHS SDR12 speed is supported
@@ -40,6 +38,7 @@ Optional properties:
 - cap-mmc-hw-reset: eMMC hardware reset is supported
 - cap-sdio-irq: enable SDIO IRQ signalling on this interface
 - full-pwr-cycle: full power cycle of the card is supported
+- mmc-ddr-3_3v: eMMC high-speed DDR mode(3.3V I/O) is supported
 - mmc-ddr-1_8v: eMMC high-speed DDR mode(1.8V I/O) is supported
 - mmc-ddr-1_2v: eMMC high-speed DDR mode(1.2V I/O) is supported
 - mmc-hs200-1_8v: eMMC HS200 mode(1.8V I/O) is supported
@@ -53,6 +52,10 @@ Optional properties:
 - no-sd: controller is limited to send sd cmd during initialization
 - no-mmc: controller is limited to send mmc cmd during initialization
 
+Deprecated properties:
+- no-1-8-v: when present, denotes that 1.8v card voltage is not supported on
+  this system, even if the controller claims it is.
+
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
 line levels. We choose to follow the SDHCI standard, which specifies both those
-- 
1.7.9.5
