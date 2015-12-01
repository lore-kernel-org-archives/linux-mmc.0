From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC v02 04/15] dmaengine: edma: Add support for DMA filter
 mapping to slave devices
Date: Tue, 01 Dec 2015 21:20:28 +0100
Message-ID: <1589780.JL62pLTh05@wuerfel>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <1448891145-10766-5-git-send-email-peter.ujfalusi@ti.com>
 <20151201172212.GC1696@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151201172212.GC1696@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: nsekhar@ti.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, andy.shevchenko@gmail.com, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 01 December 2015 22:52:12 Vinod Koul wrote:
> On Mon, Nov 30, 2015 at 03:45:34PM +0200, Peter Ujfalusi wrote:
> > Add support for providing device to filter_fn mapping so client drivers
> > can switch to use the dma_request_chan() API.
> 
> Any reason why we dont want to go with DT based only for edma here?

I think the OMAP2 based platforms using edma are all DT-only, but mach-davinci
would need a lot of work for that.

	Arnd
