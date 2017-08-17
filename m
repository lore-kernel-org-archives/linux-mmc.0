From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFT] arm64: dts: renesas: salvator-common: enable SDR104 for SD
 cards
Date: Thu, 17 Aug 2017 10:44:39 +0200
Message-ID: <20170817084439.GH26170@verge.net.au>
References: <20170802201311.1394-1-wsa+renesas@sang-engineering.com>
 <20170803074351.GC19671@verge.net.au>
 <20170803155357.GA3826@verge.net.au>
 <20170803155520.GB3826@verge.net.au>
 <20170808185445.GA2170@katana>
 <20170814051022.GC5654@verge.net.au>
 <20170814154654.uwtgoya6oroeulgm@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170814154654.uwtgoya6oroeulgm@ninjato>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Mon, Aug 14, 2017 at 05:46:54PM +0200, Wolfram Sang wrote:
> Hi Simon,
> 
> On Mon, Aug 14, 2017 at 07:10:23AM +0200, Simon Horman wrote:
> > On Tue, Aug 08, 2017 at 08:54:45PM +0200, Wolfram Sang wrote:
> > > 
> > > > As it is an "RFT" I'm happy to apply it if you repost
> > > > it or otherwise indicate that is what you would like to happen.
> > > 
> > > As discussed in a chat, I tried SDR104 with my SDIO WiFi cards:
> > > 
> > > H3:
> > > - one slot worked flawlessly
> > > - one slot could load FW but failed to read status
> > > (with SDR50: both slots work)
> > > 
> > > M3-W:
> > > - both slots could not load the firmware
> > > (with SDR50: one slot works, one fails to load FW)
> > > 
> > > The cards, however, were correctly identified as SDR104 and there were
> > > no tuning errors and no other SDHI related warnings.
> > > 
> > > Changing TDSEL in the PFC did not change anything.
> > > 
> > > The manual of the WiFi card (u-blox EMMY-W1) mentions a maximum line
> > > length of 100mm. Measuring a direct line from the SoC to the slots,
> > > I'd think we are very much on the edge of that. And given the length
> > > of the SDIO adapter, we are surely exceeding that :(
> > > 
> > > Maybe we should do more tests with more boards? On the other hand, it
> > > seems the WiFi card is running out of the specs.
> > > 
> > > So much for now. I'll sleep over it and try to get more data tomorrow.
> > 
> > Thanks. Unfortunately my H3 is out of arms length but I can arrange
> > some testing if it is helpful.
> 
> Do you have UHS-SDIO cards? Otherwise, some more testing in Spain will
> be good.

I am unable to locate my SDIO card :(

> > Is one possibility to enable it for the slots listed above that are now
> > thought to work but not for the other one?
> 
> I don't think so. We'd need more test coverage. My gut feeling is that
> it varies from board to board. Or more precisely: from environment
> around the board to environment around the board. I'd like to test a)
> more boards) and b) a resoldered WLAN card to skip the extra cabling
> there. I still think the wire length of ~23cm (exceeding the spec of max
> 10cm) is a factor here, so resoldering would save ~6cm. That all sounds
> to me like a hacking sprint for our next meeting.
> 
> Maybe ULCB has less line lengths? Would be interesting to check, too.
> 
> I could also try to apply more shielding here at home, too.

More testing is fine by me.

> > The SDR50 failure on M3-W seems particularly troubling as that
> > has been enabled in upstream for a while, right?
> 
> Not nice, yes. Yet, until this thread, there have been no issues
> reported. So, it doesn't look like a substantial fault to me (famous
> last words?)

More testing need here too :)
