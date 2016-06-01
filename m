From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v3 03/12] power: pwrseq: Enable COMPILE_TEST for drivers
Date: Wed, 01 Jun 2016 10:02:12 +0200
Message-ID: <1464768141-25420-4-git-send-email-k.kozlowski@samsung.com>
References: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1464768141-25420-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: hzpeterchen@gmail.com, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.or, Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Allow build testing for power sequence drivers.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 drivers/power/pwrseq/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/pwrseq/Kconfig b/drivers/power/pwrseq/Kconfig
index 7ecd66ab61f3..c7e9271fd94f 100644
--- a/drivers/power/pwrseq/Kconfig
+++ b/drivers/power/pwrseq/Kconfig
@@ -10,7 +10,7 @@ if POWER_SEQ
 config POWER_SEQ_EMMC
 	tristate "HW reset support for eMMC"
 	default y
-	depends on OF
+	depends on OF || COMPILE_TEST
 	help
 	  This selects Hardware reset support aka pwrseq-emmc for eMMC
 	  devices. By default this option is set to y.
@@ -21,7 +21,7 @@ config POWER_SEQ_EMMC
 config POWER_SEQ_SIMPLE
 	tristate "Simple HW reset support for MMC"
 	default y
-	depends on OF
+	depends on OF || COMPILE_TEST
 	help
 	  This selects simple hardware reset support aka pwrseq-simple for MMC
 	  devices. By default this option is set to y.
-- 
1.9.1
