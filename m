From: Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: Re: [PATCH v2 2/9] mmc: tmio, sh_mobile_sdhi: Add support for
 variable input clock frequency
Date: Tue, 12 Apr 2016 17:19:38 +0100
Message-ID: <1460477978.32355.14.camel@codethink.co.uk>
References: <1459525479-20842-1-git-send-email-wsa@the-dreams.de>
	 <1459525479-20842-3-git-send-email-wsa@the-dreams.de>
	 <CAMuHMdWdJ2AoCrwC5K2QEfuf=w=q8=XnJRzoyg99EurJBDwbTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWdJ2AoCrwC5K2QEfuf=w=q8=XnJRzoyg99EurJBDwbTg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Linux MMC List <linux-mmc@vger.kernel.org>, linux-renesas-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, 2016-04-12 at 14:55 +0200, Geert Uytterhoeven wrote:
> On Fri, Apr 1, 2016 at 5:44 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> > From: Ben Hutchings <ben.hutchings@codethink.co.uk>
> >
> > Currently tmio_mmc assumes that the input clock frequency is fixed and
> > only its own clock divider can be changed.  This is not true in the
> > case of sh_mobile_sdhi; we can use the clock API to change it.
> >
> > In tmio_mmc:
> > - Delegate setting of f_min from tmio to the clk_enable operation (if
> >   implemented), as it can be smaller than f_max / 512
> > - Add an optional clk_update operation called from tmio_mmc_set_clock()
> >   that updates the input clock frequency
> > - Rename tmio_mmc_clk_update() to tmio_mmc_clk_enable(), to avoid
> >   confusion with the clk_update operation
> >
> > In sh_mobile_sdhi:
> > - Make the setting of f_max conditional; it should be set through the
> >   max-frequency property in the device tree in future
> > - Set f_min based on the input clock's minimum frequency
> > - Implement the clk_update operation, selecting the best input clock
> >   frequency for the bus frequency that's wanted
> >
> > sh_mobile_sdhi_clk_update() is loosely based on Kuninori Morimoto's work
> > in sh_mmcif.
> >
> > Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> This is now commit 2e21101df4fe8bdc ("mmc: tmio, sh_mobile_sdhi: Add support
> for variable input clock frequency") in the next branch of Ulf's mmc.git.
> 
>   1. The SDHI/MMC clocks now run much slower than before. Perhaps this is
>      intentional, and a consequence of finding the best way to drive the SD
>      card at the target frequency?

I don't think is generally a problem.  Probably even saves a little
power.

>   2. On r8a7740, the situation is worse: the HP ("High-speed Peripheral")
>      clock is also scaled down from 99 MHz to 12.375 MHz.
>      As the HP clock is the parent of lots of on-chip devices, this may affect
>      performance for all of them.
>
> On r8a73a4, r8a7791, and sh73a0, the SDHI clocks are children of the pll1_div2
> clocks, which are fixed.
> On r8a7740, the SDHI and MMC clocks are children of the HP clock,
> which is also scaled down, affecting all other siblings.
[...]

That seems like a bug in the clock driver.  If it doesn't have
independent dividers for each clock client then it shouldn't allow any
client to change the frequency.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
