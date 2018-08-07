From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [v0.1 PATCH 0/7] mmc: tmio: refactor TMIO core a bit and add UniPhier
 SD/eMMC controller support
Date: Tue,  7 Aug 2018 15:17:15 +0900
Message-ID: <1533622642-13989-1-git-send-email-yamada.masahiro@socionext.com>
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
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-mmc@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Jassi Brar <jaswinder.singh@linaro.org>, Rob Herring <robh+dt@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org


Add UniPhier SD/eMMC controller support.

As a preparation, I changed tmio_mmc_set_clock() to a platform hook.
The clock rate setting is platform-specific, and UniPhier variants
will add another way.  I thought it would be better to split this
to a hook to avoid a mess.



Masahiro Yamada (7):
  mmc: tmio: replace tmio_mmc_clk_stop() calls with tmio_mmc_set_clock()
  mmc: tmio: move tmio_mmc_set_clock() to platform hook
  dt-bindings: mmc: add DT binding for UniPhier SD/eMMC controller
  mmc: uniphier-sd: add UniPhier SD/eMMC controller driver
  mmc: renesas_sdhi: merge clk_{start,stop} functions to set_clock
  mmc: renesas_sdhi: refactor CLK_CTL bit calculation
  mmc: tmio: refactor CLK_CTL bit calculation

 .../devicetree/bindings/mmc/uniphier-sd.txt        |  60 ++
 MAINTAINERS                                        |   1 +
 drivers/mmc/host/Kconfig                           |  10 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/renesas_sdhi_core.c               |  40 +-
 drivers/mmc/host/tmio_mmc.c                        |  56 ++
 drivers/mmc/host/tmio_mmc.h                        |   4 +-
 drivers/mmc/host/tmio_mmc_core.c                   |  79 +--
 drivers/mmc/host/uniphier-sd.c                     | 694 +++++++++++++++++++++
 9 files changed, 869 insertions(+), 76 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/uniphier-sd.txt
 create mode 100644 drivers/mmc/host/uniphier-sd.c

-- 
2.7.4
