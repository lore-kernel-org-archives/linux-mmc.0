From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v3] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Tue, 22 Feb 2011 16:09:06 +0800
Message-ID: <20110222080905.GB16141@S2101-09.ap.freescale.net>
References: <1298284528-14761-1-git-send-email-shawn.guo@freescale.com>
	<20110221174016.GN2616@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110221174016.GN2616@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, arnd@arndb.de
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

On Mon, Feb 21, 2011 at 06:40:16PM +0100, Wolfram Sang wrote:
> Shawn,
> 
> On Mon, Feb 21, 2011 at 06:35:28PM +0800, Shawn Guo wrote:
> > This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> > The driver calls into mxs-dma via generic dmaengine api for both pio
> > and data transfer.
> > 
> > Thanks Chris Ball for the indentation patch.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> What throughput rates do you get on a mx28-regulated slot serving a card
> at 50Mhz? This is poor here (55kb/s) while it is OK at 25Mhz. Could be a

To make sure we are on the same page, can you share me the test you
ran?  And I can give it a try on my board.

> board issue though (or we can fix it later), rest works fine, thus:
> 
> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
> 

-- 
Regards,
Shawn
