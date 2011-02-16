From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v2 1/7] mmc: mxs-mmc: add mmc host driver for i.MX23/28
Date: Thu, 17 Feb 2011 04:28:19 +0800
Message-ID: <20110216202818.GA11467@S2100-06.ap.freescale.net>
References: <1297650746-12841-1-git-send-email-shawn.guo@freescale.com>
	<1297650746-12841-2-git-send-email-shawn.guo@freescale.com>
	<20110214165958.GH10709@pengutronix.de>
	<20110215223941.GJ10990@S2100-06.ap.freescale.net>
	<20110215171341.GD10770@pengutronix.de>
	<20110215171917.GQ4152@n2100.arm.linux.org.uk>
	<20110215172948.GE10770@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20110215172948.GE10770@pengutronix.de>
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
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, arnd@arndb.de, s.hauer@pengutronix.de, linux-mmc@vger.kernel.org, cjb@laptop.org, linux-arm-kernel@lists.infradead.org, LW@KARO-electronics.de
List-Id: linux-mmc@vger.kernel.org

Hi Wolfram,

Thanks for testing.

On Tue, Feb 15, 2011 at 06:29:48PM +0100, Wolfram Sang wrote:
> On Tue, Feb 15, 2011 at 05:19:17PM +0000, Russell King - ARM Linux wrote:
> > On Tue, Feb 15, 2011 at 06:13:41PM +0100, Wolfram Sang wrote:
> > > 
> > > > Ah, yes.  I can also see the problem here after turning on
> > > > DEBUG_SPINLOCK.
> > > 
> > > Ah, okay. After turning it off, it works a lot better :)
> > 
> > That doesn't mean the problem is fixed. [...]
> 
> Yes, I know that. I should have put the 'works' above in quotes, sorry.
> 
It's caused by spinlock recursion introduced by mxs-dma functions
mxs_dma_tx_submit and mxs_dma_tasklet.  We have mmc_request_done
invoked in the dma callback tasklet.  At the meantime,
mmc_request_done will issue retries in some case, which will call in
mxs_dma_tx_submit.

I added the lock by referring to other dma driver implementation, but
now I'm considering to remove the lock completely, as I do not see
any global data needs to be protected there.  Comments?

> > > MMC fails for me (note: the card works fine with an mx35-based board)
> > > 
> > > 	mmc0: new high speed MMC card at address 0001
> > > 	mmcblk0: mmc0:0001 AF HMP 247 MiB 
> > > 	mmcblk0: retrying using single block read
> > > 	mmcblk0: error -84 transferring data, sector 0, nr 8, card status 0x900
> > > 	end_request: I/O error, dev mmcblk0, sector 0
> > 
> > EILSEQ means CRC failure.  Probably unrelated.
> 
> Even if it works in another setup? As a result of the above, I can't read the
> partition table of that MMC. The mx35 can do so.
> 
First of all, it's not a problem that partition table of the card
can not be read.  For example, I have every card giving unknown
partition table message after performing mmc host driver test on the
cards, but they are working good.

I guess you will also get the unknown partition table message if you
test this card on mx35 right now.

I just tested 7 mmc cards in total.  6 cards work fine, and 1 card
(Transcend MMC plus 1GB) has the exactly same problem as yours. And
if I remove the 8 bit cap, this card also works fine.  So I would
agree with Russell that it's unrelated to the driver.

mmc1: new high speed MMC card at address 0001
mmcblk1: mmc1:0001 MMC    3.75 GiB
 mmcblk1: unknown partition table
mmc1: card 0001 removed

mmc1: new MMC card at address 0001
mmcblk1: mmc1:0001 SMIMMC 122 MiB
 mmcblk1: unknown partition table
mmc1: card 0001 removed

mmc1: new high speed MMC card at address 0001
mmcblk1: mmc1:0001 NCard  967 MiB
 mmcblk1: p1
mmc1: card 0001 removed

mmc1: new high speed MMC card at address 0001
mmcblk1: mmc1:0001 MMC512 483 MiB
 mmcblk1: p1 < p5 >
mmc1: card 0001 removed

mmc1: new high speed MMC card at address 0001
mmcblk1: mmc1:0001 000000 980 MiB
 mmcblk1: unknown partition table
mmc1: card 0001 removed

mmc1: new high speed MMC card at address 0001
mmcblk1: mmc1:0001 AF HMP 490 MiB
 mmcblk1: p1 < p5 >
mmc1: card 0001 removed

mmc1: new high speed MMC card at address 0001
mmcblk1: mmc1:0001 MMC    967 MiB
mmcblk1: retrying using single block read
mmcblk1: error -84 transferring data, sector 0, nr 8, card status 0x900
end_request: I/O error, dev mmcblk1, sector 0
mmcblk1: error -84 transferring data, sector 1, nr 7, card status 0x900
end_request: I/O error, dev mmcblk1, sector 1
mmcblk1: error -84 transferring data, sector 2, nr 6, card status 0x900
end_request: I/O error, dev mmcblk1, sector 2
...

> > > SDIO card locks the machine. Is it supposed to work already?
> > 
> > Guess it's the spinlock causing that problem.
> 
> Yeah, that could be. In addition, I was just generally interested if SDIO has
> been tested by Shawn.
> 
I tested the SDIO, but probably in different way from yours.  I had
two card slots on my board, rootfs on mmc0 and SDIO card on mmc1.
It seems working fine in this way.  However, when I use nfs and test
SDIO on mmc0, my systems hangs too.  I will look into it.

-- 
Regards,
Shawn
