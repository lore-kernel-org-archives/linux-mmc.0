From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/2] mms: Use dma_request_chan() directly for channel request
Date: Thu, 14 Nov 2019 13:53:30 +0100
Message-ID: <CAPDyKFp15ZMq1f_xwrPSRbhU4M4SXhRzigA9-QMNBGSZj-YtJA@mail.gmail.com>
References: <20191113093616.32474-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191113093616.32474-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>, vkoul@kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, 13 Nov 2019 at 10:35, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>
> Hi,
>
> I'm going through the tree to remove dma_request_slave_channel_reason() as it
> is just:
> #define dma_request_slave_channel_reason(dev, name) \
>         dma_request_chan(dev, name)
>
> Regards,
> Peter
> ---
> Peter Ujfalusi (2):
>   mmc: atmel-mci: Use dma_request_chan() directly for channel request
>   mmc: moxart: Use dma_request_chan() directly for channel request
>
>  drivers/mmc/host/atmel-mci.c  | 3 +--
>  drivers/mmc/host/moxart-mmc.c | 4 ++--
>  2 files changed, 3 insertions(+), 4 deletions(-)

Applied for next, thanks!

Kind regards
Uffe
