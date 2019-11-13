From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/3] MMCI odd buffer alignment fixes
Date: Wed, 13 Nov 2019 08:53:32 +0100
Message-ID: <20191113075335.31775-1-linus.walleij@linaro.org>
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
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephan Gerhold <stephan@gerhold.net>
Cc: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

This is an attempt to fix the three independent issues seen
by Ulf in the MMCI driver.

I am unable to test patches 2 & 3 since I can't provoke the
right traffic, but I hope Stephan can try it with his
Broadcom WiFi.

Linus Walleij (2):
  mmc: mmci: Bail out from odd DMA on Ux500
  mmc: mmci: Proper PIO residue handling

Ulf Hansson (1):
  mmc: mmci: Support odd block sizes for ux500v2 and qcom variant

 drivers/mmc/host/mmci.c | 166 ++++++++++++++++++++++++++++++++++++----
 drivers/mmc/host/mmci.h |  18 ++++-
 2 files changed, 169 insertions(+), 15 deletions(-)

-- 
2.21.0
