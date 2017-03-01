From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 0/4] mmc: pwrseq: post_ios power sequence
Date: Wed,  1 Mar 2017 15:53:06 +0100
Message-ID: <20170301145310.22813-1-romain.perier@collabora.com>
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
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Romain Perier <romain.perier@collabora.com>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Some devices, like WiFi chipsets AP6335 require a specific power-up
sequence ordering before being used. You must enable the vqmmc power supply
and wait until it reaches its minimum voltage, gate the clock and wait
at least two cycles and then assert the reset line.

See DS 1/

Currently, there is no generic manner for doing this with pwrseq_simple.
This set of patches proposes an approach to support this use case.

It is related to the old patch 2/

1. http://www.t-firefly.com/download/firefly-rk3288/hardware/AP6335%20datasheet_V1.3_02102014.pdf
2. http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/490681.html

Romain Perier (4):
  mmc: core: Add post_ios_power_on callback for power sequences
  mmc: pwrseq-simple: Add optional op. for post_ios_power_on callback
  mmc: pwrseq_simple: Add an optional pre-power-on-delay
  arm: dts: rockchip: Enable post_ios_power_on and pre-power-on-delay-ms

 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt   |  2 ++
 arch/arm/boot/dts/rk3288-rock2-square.dts           |  2 ++
 drivers/mmc/core/core.c                             |  1 +
 drivers/mmc/core/pwrseq.c                           |  8 ++++++++
 drivers/mmc/core/pwrseq.h                           |  2 ++
 drivers/mmc/core/pwrseq_simple.c                    | 21 ++++++++++++++++++++-
 6 files changed, 35 insertions(+), 1 deletion(-)

-- 
2.9.3
