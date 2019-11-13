From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] mms: Use dma_request_chan() directly for channel request
Date: Wed, 13 Nov 2019 11:36:14 +0200
Message-ID: <20191113093616.32474-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, ludovic.desroches@microchip.com
Cc: vkoul@kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
List-Id: linux-mmc@vger.kernel.org

Hi,

I'm going through the tree to remove dma_request_slave_channel_reason() as it
is just:
#define dma_request_slave_channel_reason(dev, name) \
	dma_request_chan(dev, name)

Regards,
Peter
---
Peter Ujfalusi (2):
  mmc: atmel-mci: Use dma_request_chan() directly for channel request
  mmc: moxart: Use dma_request_chan() directly for channel request

 drivers/mmc/host/atmel-mci.c  | 3 +--
 drivers/mmc/host/moxart-mmc.c | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
