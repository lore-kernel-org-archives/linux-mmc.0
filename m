From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 0/3] omap_hsmmc: use mmc_regulator_get_supply() to get
 regulators
Date: Wed, 7 Jun 2017 14:06:09 +0530
Message-ID: <20170607083612.14224-1-kishon@ti.com>
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
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, nsekhar@ti.com
Cc: devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kishon@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This series deprecates "vmmc_aux" supply property and uses the generic
"vqmmc" property.

Not sure how exactly to handle omap3-overo-base.dtsi which already has
both vqmmc-supply and vmmc_aux-supply without breaking old dt
compatibility. (vqmmc-supply seems to have been added there by mistake
from 3.15).

In the dt series that will follow, will replace all vmmc_aux-supply
with vqmmc-supply (In omap3-overo-base.dtsi remove the existing
vqmmc-supply and then replace vmmc_aux-supply with vqmmc-supply).

Kishon Vijay Abraham I (3):
  mmc: host: omap_hsmmc: Do not initialize MMC regulators to NULL on
    error
  mmc: host: omap_hsmmc: use mmc_regulator_get_supply() to get
    regulators
  Documentation: dt-bindings: Document deprecation of "vmmc_aux" and
    using "vqmmc"

 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |  2 +-
 drivers/mmc/host/omap_hsmmc.c                      | 55 +++++++++-------------
 2 files changed, 24 insertions(+), 33 deletions(-)

-- 
2.11.0
