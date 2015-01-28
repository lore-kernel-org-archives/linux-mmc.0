From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Subject: [PATCH v2 6/6] ARM: dts: exynos5250-snow: Add cap-sdio-irq to wifi
 mmc node
Date: Wed, 28 Jan 2015 19:15:53 +0100
Message-ID: <1422468953-7594-7-git-send-email-javier.martinez@collabora.co.uk>
References: <1422468953-7594-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422468953-7594-1-git-send-email-javier.martinez@collabora.co.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Arend van Spriel <arend@broadcom.com>, Kukjin Kim <kgene@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Olof Johansson <olof@lixom.net>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Enabling SDIO IRQ signalling for the wifi MMC/SDIO slot
doubles the transmission transfer rate.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v1: None, new patch.
---
 arch/arm/boot/dts/exynos5250-snow.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index b78712058903..909edc3448d3 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -539,6 +539,7 @@
 	status = "okay";
 	num-slots = <1>;
 	broken-cd;
+	cap-sdio-irq;
 	card-detect-delay = <200>;
 	samsung,dw-mshc-ciu-div = <3>;
 	samsung,dw-mshc-sdr-timing = <2 3>;
-- 
2.1.3
