From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v3 02/12] MAINTAINERS: Retain Ulf Hansson as the same
 maintainer of pwrseq
Date: Wed, 01 Jun 2016 10:02:11 +0200
Message-ID: <1464768141-25420-3-git-send-email-k.kozlowski@samsung.com>
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
