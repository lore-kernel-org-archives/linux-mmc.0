From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Wed, 16 Feb 2011 05:27:18 +0800
Message-ID: <20110215212717.GF10990@S2100-06.ap.freescale.net>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
	<1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
	<20110213192609.GA21429@void.printf.net>
	<201102132335.54868.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201102132335.54868.arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: s.hauer@pengutronix.de, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, LW@karo-electronics.de
List-Id: linux-mmc@vger.kernel.org

On Sun, Feb 13, 2011 at 11:35:54PM +0100, Arnd Bergmann wrote:
> On Sunday 13 February 2011, Chris Ball wrote:
> > On Mon, Feb 14, 2011 at 10:32:20AM +0800, Shawn Guo wrote:
> > > This adds the mmc host driver for Freescale MXS-based SoC i.MX23/28.
> > > The driver calls into mxs-dma via generic dmaengine api for both pio
> > > and data transfer.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
> > 
> > Please add a Reviewed-by: from Arnd and a Tested-by: from Lothar.
> > Could you add a MODULE_AUTHOR() field, too?
> 
> In general, these tags should not simply be added by the author without
> having the person who did the reviewing or testing specifically provide
> them!
> 
> In this particular case, I'm happy with the driver in version 2, good job!
> Please do add my
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
Will do.  Appreciate the review effort.

Regards,
Shawn
