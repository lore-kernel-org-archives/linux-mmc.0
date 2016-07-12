From: "Steven J. Hill" <steven.hill@cavium.com>
Subject: [PATCH V8 0/2] mmc: OCTEON: Add OCTEON MMC controller.
Date: Tue, 12 Jul 2016 13:18:22 -0500
Message-ID: <5785346E.8020702@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mips-bounce@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-mips@linux-mips.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ralf Baechle <ralf@linux-mips.org>
List-Id: linux-mmc@vger.kernel.org

The OCTEON MMC controller is currently found on cn61XX and cnf71XX
devices. Device parameters are configured from device tree data.

The MMC controller can be connected to up to 4 "slots" which may be
eMMC, MMC or SD card devices. As there is a single controller, each
available slot is represented as a child node of the controller.

This MMC driver is the product of previous versions and discussions
which can be found at the below URLs.

[V7] https://patchwork.linux-mips.org/patch/12566/
     https://patchwork.linux-mips.org/patch/12567/
[V6] https://patchwork.linux-mips.org/patch/12538/
     https://patchwork.linux-mips.org/patch/12539/
     https://patchwork.linux-mips.org/patch/12540/
[V5] https://patchwork.linux-mips.org/patch/12533/
[V4] https://patchwork.linux-mips.org/patch/9558/
[V3] https://patchwork.linux-mips.org/patch/9462/
[V2] https://patchwork.linux-mips.org/patch/9086/
[V1] https://patchwork.linux-mips.org/patch/9079/

Steven J. Hill (2):
  mmc: OCTEON: Add DT bindings for OCTEON MMC controller.
  mmc: OCTEON: Add host driver for OCTEON MMC controller.

 .../devicetree/bindings/mmc/octeon-mmc.txt         |   72 ++
 drivers/mmc/host/Kconfig                           |   10 +
 drivers/mmc/host/Makefile                          |    1 +
 drivers/mmc/host/octeon_mmc.c                      | 1331 ++++++++++++++++++++
 4 files changed, 1414 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/octeon-mmc.txt
 create mode 100644 drivers/mmc/host/octeon_mmc.c

-- 
1.9.1
