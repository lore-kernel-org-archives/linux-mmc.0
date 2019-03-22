From: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Subject: [PATCH v3 1/3] dt-bindings: mmc: Add disable-cqe-dcmd property.
Date: Fri, 22 Mar 2019 12:38:04 +0100
Message-ID: <20190322113808.16858-1-christoph.muellner@theobroma-systems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: robh+dt@kernel.org, mark.rutland@arm.com, heiko@sntech.de, shawn.lin@rock-chips.com, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: devicetree@vger.kernel.org, Lin Huang <hl@rock-chips.com>, linux-rockchip@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Randy Li <ayaka@soulik.info>, linux-mmc@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>, Vicente Bergas <vicencb@gmail.com>, Douglas Anderson <dianders@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>, Tony Xie <tony.xie@rock-chips.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, linux-arm-kernel@lists.infradead.org, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, Ezequiel Garcia <ezequiel@collabora.com>, linux-kernel@vger.kernel.org, Christoph Muellner <christoph.muellner@theobroma-systems.com>
List-Id: linux-mmc@vger.kernel.org

Add disable-cqe-dcmd as optional property for MMC hosts.
This property allows to disable or not enable the direct command
features of the command queue engine.

Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index cdbcfd3a4ff2..c269dbe384fe 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -64,6 +64,8 @@ Optional properties:
   whether pwrseq-simple is used. Default to 10ms if no available.
 - supports-cqe : The presence of this property indicates that the corresponding
   MMC host controller supports HW command queue feature.
+- disable-cqe-dcmd: This property indicates that the MMC controller's command
+  queue engine (CQE) does not support direct commands (DCMDs).
 
 *NOTE* on CD and WP polarity. To use common for all SD/MMC host controllers line
 polarity properties, we have to fix the meaning of the "normal" and "inverted"
-- 
2.11.0
