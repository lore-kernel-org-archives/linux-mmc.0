From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH] mmc: dw_mmc: setpower on MMC_POWER_{UP,OFF}
Date: Thu, 14 Mar 2013 19:34:01 +0900
Message-ID: <002101ce209f$716f1fc0$544d5f40$%jun@samsung.com>
References: <1363085012-9220-1-git-send-email-james.hogan@imgtec.com>
 <002301ce1ff5$e42f8090$ac8e81b0$%jun@samsung.com> <51408F1D.8010600@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <51408F1D.8010600@imgtec.com>
Content-language: ko
Sender: linux-kernel-owner@vger.kernel.org
To: 'James Hogan' <james.hogan@imgtec.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'Chris Ball' <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

On Wednesday, March 13, 2013, James Hogan wrote:
> On 13/03/13 14:20, Seungwon Jeon wrote:
> > Hi James,
> >
> > On Tuesday, March 12, 2013, James Hogan wrote:
> >> Call the setpower platform callback in response to set_ios with
> >> ios->power_mode == MMC_POWER_UP or MMC_POWER_OFF, instead of from the
> >> card detect work function.
> >>
> >> This appears to fix a problem I have where a card stuck in a funny state
> >> doesn't get properly cleared by the power being turned off, presumably
> >> due to lack of power sequencing. This resulted in the following log
> >> messages after boot:
> >>
> >> mmc0: error -110 whilst initialising SD card
> >> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 300000Hz, actual 298922HZ div = 167)
> >> mmc0: error -110 whilst initialising SD card
> >> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 200000Hz, actual 199680HZ div = 250)
> >> mmc0: error -110 whilst initialising SD card
> >> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 195765Hz, actual 195764HZ div = 255)
> >> mmc0: error -110 whilst initialising SD card
> >> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 400000Hz, actual 399360HZ div = 125)
> >> mmc0: error -110 whilst initialising SD card
> >> mmc_host mmc0: Bus speed (slot 0) = 99840000Hz (slot req 300000Hz, actual 298922HZ div = 167)
> >>
> >> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> >> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> >
> > This patch is reasonable.
> > I just want to know though.
> > I guess this problem is happened when card is inserted as soon as card is removed.
> > If not, could you explain your situation more?
> 
> Hi,
> 
> It initially started happening after the patch by Yuvaraj CD ("mmc:
> dw_mmc: enable controller interrupt before calling mmc_start_host").
> Basically after hard resetting the board the card would be in a dodgy
> state, and I'd get these elusive errors after boot (see the above patch
> thread for details). It was specifically the position of the prink that
> it was sensitive to (I have a JTAG console turned on which adds big
> latencies to prinks, so it's clearly some kind of race). Unplugging the
> card cleared the problem, as did cutting the power to the card for a
> sufficient amount of time. While trying to debug the messages I saw
> these power callbacks and thought I'd try them as they seem like a much
> better place to control the card power, and seem to match other host
> drivers too, and it fixed the problem, I presume due to the intentional
> delays around those calls. It is of course possible that the race is
> just hiding again, but I think the patch is an improvement regardless.
Thank you for your description.
I think the reason is insufficiency of power-on time.
Voltage level shall be below 0.5V at least 1ms when card power-on (from SD spec).
I'm adding...

Acked-by: Seungwon Jeon <tgih.jun@samsung.com>

Thanks,
Seungwon Jeon
