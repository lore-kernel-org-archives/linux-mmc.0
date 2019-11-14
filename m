From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 0/2] mms: Use dma_request_chan() directly for channel
 request
Date: Thu, 14 Nov 2019 10:03:37 +0530
Message-ID: <20191114043337.GF952516@vkoul-mobl>
References: <20191113093616.32474-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191113093616.32474-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: ulf.hansson@linaro.org, ludovic.desroches@microchip.com, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com
List-Id: linux-mmc@vger.kernel.org

On 13-11-19, 11:36, Peter Ujfalusi wrote:
> Hi,
> 
> I'm going through the tree to remove dma_request_slave_channel_reason() as it
> is just:
> #define dma_request_slave_channel_reason(dev, name) \
> 	dma_request_chan(dev, name)

Reviewed-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
