From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v4 1/3] mmc: dw_mmc: update clock after host reach a
 stable voltage
Date: Fri, 20 Feb 2015 00:02:13 +0000
Message-ID: <20150220000213.GD8656@n2100.arm.linux.org.uk>
References: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
 <1423894668-8886-1-git-send-email-addy.ke@rock-chips.com>
 <1423894668-8886-2-git-send-email-addy.ke@rock-chips.com>
 <CAGOxZ53ndi_hYDGBGhY-7q8aOrFid1=D=_5KEbUvzTsnybJQ3Q@mail.gmail.com>
 <CAD=FV=V9aK-78GJ_eWkpZZdVT_5Zu8ehxg_o3NtnpD2wyRuh7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=V9aK-78GJ_eWkpZZdVT_5Zu8ehxg_o3NtnpD2wyRuh7Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Alim Akhtar <alim.akhtar@gmail.com>, Addy Ke <addy.ke@rock-chips.com>, Tao Huang <huangtao@rock-chips.com>, lintao <lintao@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, Andrzej Hajda <a.hajda@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>, Eddie Cai <cf@rock-chips.com>, Olof Johansson <olof@lixom.net>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Feb 19, 2015 at 03:49:46PM -0800, Doug Anderson wrote:
> Alim and Addy,
> 
> On Sun, Feb 15, 2015 at 3:28 PM, Alim Akhtar <alim.akhtar@gmail.com> wrote:
> > Hi Addy,
> >
> > On Sat, Feb 14, 2015 at 11:47 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
> >> As show in mmc_power_up(), in MMC_POWER_UP state, the voltage isn't
> >> stable and we may get 'data busy' which can't be cleaned by resetting
> >> all blocks. So we should not send command to update clock in this state.
> >>
> >> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
> >> ---
> >>  drivers/mmc/host/dw_mmc.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> >> index 4d2e3c2..3472f9b 100644
> >> --- a/drivers/mmc/host/dw_mmc.c
> >> +++ b/drivers/mmc/host/dw_mmc.c
> >> @@ -1102,7 +1102,8 @@ static void dw_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >>                 drv_data->set_ios(slot->host, ios);
> >>
> >>         /* Slot specific timing and width adjustment */
> >> -       dw_mci_setup_bus(slot, false);
> >> +       if (ios->power_mode != MMC_POWER_UP)
> >> +               dw_mci_setup_bus(slot, false);
> >>
> > This looks a HACK to me.
> > If stabilizing host voltage regulator is the problem, can you try out
> > below patch, and see if this resolve your issue?
> 
> Actually, IMHO Alim's patch is more of a hack than Addy's.  There's
> already a 10ms delay between "power up" and "power on" in the MMC core
> in mmc_power_up() state.  That delay is commented as:
> 
>   /*
>    * This delay should be sufficient to allow the power supply
>    * to reach the minimum voltage.
>    */
>   mmc_delay(10);
> 
> That means that assuming that the voltage is stable in MMC_POWER_UP is
> not valid anyway.
> 
> 
> Addy's patch certainly needs more comments.  In another context Olof suggested:
> 
> /*
>  * Skip bus setup while voltage is still stabilizing. Instead,
>  * bus setup will be done at MMC_POWER_ON.
>  */
> 
> 
> ...thinking about this more, though: really the voltage should be
> stabilized when the regulator call returns (see my comments below).
> In actuality the "right" fix might be to just rearrange this function
> a little not to turn the clock on _before_ we even try to turn the
> voltage on.

This is exactly why I've been saying that we need to get away from the
POWER_UP vs POWER_ON stuff.  We instead need a _single_ call into
drivers to tell them to apply power and bring the card to a state
where it can be talked to.

That includes waiting for the power to stabilise, and sending the
initial clocks to allow the card to initialise.

In the case of extra GPIOs, host drivers will need to call back into
the MMC core at the point where they have stabilised the power.

The current situation where we split the power-up/power-on sequence
between the host drivers and the core is really a hinderance to getting
a working implementation - it's additional complexity where none is
needed.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
