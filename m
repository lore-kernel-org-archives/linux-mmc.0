From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v2 0/8] mmc: sunxi: Add runtime PM support
Date: Thu,  8 Mar 2018 15:52:46 +0100
Message-ID: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
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
To: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>, ulf.hansson@linaro.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, linux-mmc@vger.kernel.org, Quentin Schulz <quentin.schulz@bootlin.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

Since it's introduction, our MMC controller has had its external clocks
running all the time.

While that was working great, the power usage and most importantly the EMI
that it generated was pretty bad.

Let's implement some runtime_pm hooks with an autosuspend to shut down the
whole block when the MMC is not active.

However, some SDIO devices will not probe properly if we keep shutting down
the controller, so the autosuspend is disabled for the SDIO devices.

Let me know what you think,
Maxime

Changes from v1:
  - Disable entirely the controller
  - Made sure the driver would work with CONFIG_PM off
  - Fixed an issue with the SDIO devices
  - Rebased on top of 4.16

Maxime Ripard (8):
  mmc: sunxi: Reorder the headers
  mmc: sunxi: Move the power off action in a separate function
  mmc: sunxi: Move the power on action in a separate function
  mmc: sunxi: Move the power up action in a separate function
  mmc: sunxi: Move resources management to separate functions
  mmc: sunxi: Move the reset deassertion before enabling the clocks
  mmc: sunxi: Set our device drvdata earlier
  mmc: sunxi: Add runtime_pm support

 drivers/mmc/host/sunxi-mmc.c | 346 ++++++++++++++++++++++--------------
 1 file changed, 216 insertions(+), 130 deletions(-)

base-commit: 661e50bc853209e41a5c14a290ca4decc43cbfd1
-- 
git-series 0.9.1
