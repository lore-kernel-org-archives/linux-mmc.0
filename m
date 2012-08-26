From: Hein Tibosch <hein_tibosch@yahoo.es>
Subject: [PATCH 0/2] mmc: atmel-mci: repair driver for use with AVR32 (AP7000)
Date: Mon, 27 Aug 2012 04:36:00 +0800
Message-ID: <503A88B0.30103@yahoo.es>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Ferre <nicolas.ferre@atmel.com>, "ludovic.desroches" <ludovic.desroches@atmel.com>
Cc: Havard Skinnemoen <havard@skinnemoen.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, linux-arm-kernel@lists.infradead.org, egtvedt@samfundet.no
List-Id: linux-mmc@vger.kernel.org

Due to changes after 2.6.38, the drivers atmel-mci and dw_dmac got broken
for the AVR32 platform: the AP7000.

These two patches repair the atmel-mci driver

Thanks to Ludovic for reviewing/styling!

Hein Tibosch (2):

  mmc: atmel-mci: DMA can be used with other controller
  mmc: atmel-mci: AP700x PDC is not connected to MCI

 drivers/mmc/host/atmel-mci-regs.h |    7 +++++++
 drivers/mmc/host/atmel-mci.c      |   23 ++++++++++-------------
 2 files changed, 17 insertions(+), 13 deletions(-)

-- 
