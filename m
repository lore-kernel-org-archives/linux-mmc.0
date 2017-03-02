From: Sergio Prado <sergio.prado@e-labworks.com>
Subject: [PATCH v4 0/2] mmc: host: s3cmci: add device tree support
Date: Wed,  1 Mar 2017 22:18:54 -0300
Message-ID: <1488417536-15110-1-git-send-email-sergio.prado@e-labworks.com>
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
To: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, ben-linux@fluff.org, linux-arm-kernel@lists.infradead.org
Cc: Sergio Prado <sergio.prado@e-labworks.com>
List-Id: linux-mmc@vger.kernel.org

This series adds support for configuring Samsung's S3C24XX MMC/SD/SDIO
controller via device tree.

Tested on FriendlyARM mini2440, based on s3c2440 SoC.

Changes since v3 (as suggested by Rob Herring)
- describing properties that wasn't documented and removing unnecessary
  comment in the device tree binding

Changes since v2:
- struct "s3cmci_drv_data" and flag "is2440" renamed
- copying the whole driver data struct instead of only its member so
  it will be easier to extend the information in the future
- using mmc_of_parse() to read "cd-gpios" and "wp-gpios" properties
  from device tree

Changes since v1:
- pinctrl description removed from DT binding
- unit and label on DT binding renamed to mmc

Sergio Prado (2):
  dt-bindings: mmc: add DT binding for S3C24XX MMC/SD/SDIO controller
  mmc: host: s3cmci: allow probing from device tree

 .../devicetree/bindings/mmc/samsung,s3cmci.txt     |  42 +++
 drivers/mmc/host/s3cmci.c                          | 298 +++++++++++----------
 drivers/mmc/host/s3cmci.h                          |   3 +-
 3 files changed, 200 insertions(+), 143 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt

-- 
1.9.1
