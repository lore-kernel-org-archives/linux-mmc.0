From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
Date: Tue, 11 Dec 2018 06:23:43 -0800
Message-ID: <20181211142343.GO6707@atomide.com>
References: <20181031155738.18367-1-tony@atomide.com>
 <CAPDyKFqtMHRjHsJXcKTTzGYSsyab=2SfWdYiETS4Bo2f7Zw2CQ@mail.gmail.com>
 <20181129191332.GY53235@atomide.com>
 <CAPDyKFpgOjr1Zp=31b-_+KVOnvRnXXdXt5e8b0X1pGNVAihtyA@mail.gmail.com>
 <20181211131336.GD9507@n2100.armlinux.org.uk>
 <b88f7a3f-ed0e-c6d7-6e18-afc2378524bf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <b88f7a3f-ed0e-c6d7-6e18-afc2378524bf@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Russell King - ARM Linux <linux@armlinux.org.uk>, Kishon <kishon@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [181211 13:47]:
> On 11/12/2018 15.13, Russell King - ARM Linux wrote:
> > The only thing I can think of doing is adding into omap_hsmmc:
> > 
> > 	mmc->max_seg_size = min(mmc->max_req_size,
> > 				min(dma_get_max_seg_size(host->rx_chan->device->dev),
> > 				    dma_get_max_seg_size(host->tx_chan->device->dev)));
> > 
> > to limit the maximum segment size to that of the device _and_ dma
> > engine's capabilities.
> 
> Make sense.
> 
> > Doing this solves the problem for me.

OK sounds good to me too.

Thanks,

Tony
