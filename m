From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC v4 04/14] MAINTAINERS: Retain Ulf Hansson as the same maintainer
 of pwrseq
Date: Thu, 09 Jun 2016 11:44:21 +0200
Message-ID: <1465465471-28740-5-git-send-email-k.kozlowski@samsung.com>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Before moving pwrseq drivers from drivers/mmc/core/ to drivers/power/,
they were maintained by Ulf Hansson.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4f2a75ce5442..71114607502a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9083,6 +9083,15 @@ F:	include/linux/power_supply.h
 F:	drivers/power/
 X:	drivers/power/avs/
 
+POWER SEQ CORE and DRIVERS
+M:	Ulf Hansson <ulf.hansson@linaro.org>
+L:	linux-mmc@vger.kernel.org
+T:	git git://git.linaro.org/people/ulf.hansson/mmc.git
+S:	Maintained
+F:	drivers/power/pwrseq/
+F:	include/linux/pwrseq.h
+F:	Documentation/devicetree/bindings/power/pwrseq/
+
 POWER STATE COORDINATION INTERFACE (PSCI)
 M:	Mark Rutland <mark.rutland@arm.com>
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
-- 
1.9.1
