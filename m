From: Simon Horman <horms@verge.net.au>
Subject: Re: [RFT] arm64: dts: renesas: salvator-common: enable SDR104 for SD
 cards
Date: Thu, 3 Aug 2017 17:54:00 +0200
Message-ID: <20170803155357.GA3826@verge.net.au>
References: <20170802201311.1394-1-wsa+renesas@sang-engineering.com>
 <20170803074351.GC19671@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170803074351.GC19671@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 03, 2017 at 09:43:51AM +0200, Simon Horman wrote:
> On Wed, Aug 02, 2017 at 10:13:11PM +0200, Wolfram Sang wrote:
> > Tests showed that SDHI driver problems have been solved and SDR104 works
> > now reliably on both Salvator-X SD card slots, both with an R-Car H3
> > (r8a7795 ES1.0) and R-Car M3 (r8a7796 ES 1.0). So, finally, enable it.
> > 
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > ---
> > 
> > Awesome, awesome! For the last two days, I did various tests with my boards and
> > SD cards and SDR104 worked absolutely reliably :D Even the problematic card I
> > had works flawlessly. I couldn't trigger the known failures anymore. Although I
> > tried, I can't point to a single patch which "fixed" the issue. It is the
> > constant work on dealing with smaller issues which makes SDR104 work at the end
> > of the day. However, two patches are likely a bigger part of the cake:
> > 
> > 43b0b361b01700 ("mmc: tmio: always get number of taps")
> > -> Already upstream. This fixed retuning on card changes.
> > 
> > 85b81aa16ec4ed ("mmc: tmio: fix CMD12 (STOP) handling")
> > -> In mmc/next. This allows to handle tuning errors gracefully and to retune.
> > 
> > With the freshly submitted Gen3 DMA patches, we also get nice transfer speeds :)
> > 
> > This patch is based on renesas-drivers/master as of today. A branch for testing
> > can be found here:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/v8-sdr104
> > 
> > All patches needed for reliable SDR104 are already upstream or in mmc/next. The
> > above branch only adds another patch to enable DMA on Gen3. It is not strictly
> > needed, but very nice to have. I think it would be cool to get both patches
> > into v4.14.
> > 
> > Looking forward to other testers. Simon, do you have some time for this?
> 
> Yes, I should be able to run this through my - until now thought to be
> broken - test case this week.
> 
> It would be very nice to be able to get closure on this :)

Awesome indeed!

I have tested this using my test-case which is to remove and then
re-insert a Samsung MB-SD32D/EU card. Slot SDHI3 was used although I expect
that is not an important parameter.

A bisection indicates the above test works since
85b81aa16ec4ed ("mmc: tmio: fix CMD12 (STOP) handling")
which was included in v4.12 and highlighted by you above.

Tested-by: Simon Horman <horms@verge.net.au>

I will apply this for v4.14 in the near future.
