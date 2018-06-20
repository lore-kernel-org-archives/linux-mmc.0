From: Helmut Grohne <h.grohne@intenta.de>
Subject: [PATCH v3 0/2] mmc: sdhci-of-arasan: workaround for broken clocks
Date: Wed, 20 Jun 2018 13:32:41 +0200
Message-ID: <cover.1529493667.git.h.grohne@intenta.de>
References: <20180615081830.zrgx6arwn6ga27gu@laureti-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180615081830.zrgx6arwn6ga27gu@laureti-dev>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Adrian Hunter <adrian.hunter@intel.com>, Michal Simek <michal.simek@xilinx.com>, =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Cc: Atul Garg <agarg@arasan.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

This patch series works around the internal clock indicating stability too
quickly to operate. It manifests itself as:

    mmc0: error -84 whilst initialising SD card

Changes since v2:
 * Ulf Hansson requested splitting the patch in accordance with
   Documentation/devicetree/bindings/submitting-patches.txt. Also update
   recipient list accordingly.
 * Added Acked-by from Adrian Hunter.

Helmut Grohne (2):
  dt-bindings: mmc: broken clock stable indicator on arasan controllers
  mmc: sdhci-of-arasan: Add quirk for unstable clocks

 Documentation/devicetree/bindings/mmc/arasan,sdhci.txt |  2 ++
 drivers/mmc/host/sdhci-of-arasan.c                     | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

-- 
2.11.0
