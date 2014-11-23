From: Alim Akhtar <alim.akhtar@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix card read threshold for PIO mode
Date: Mon, 24 Nov 2014 03:36:13 +0530
Message-ID: <CAGOxZ50+k3Z5gHrRasveM=7V+GS+1dRmcz0u5WSyo=XBE9iT3g@mail.gmail.com>
References: <1416551950-8277-1-git-send-email-shawn.guo@linaro.org>
 <20141121233155.GC11253@dragon> <CAGOxZ51DPL+6HTSG6yeCqqRxtq7XBuWki7gdB-ieamVUKixCDQ@mail.gmail.com>
 <20141123153012.GH11253@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20141123153012.GH11253@dragon>
Sender: stable-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, stable@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hi Shawn,

On Sun, Nov 23, 2014 at 9:00 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Hi Alim,
>
> On Sat, Nov 22, 2014 at 06:56:46PM +0530, Alim Akhtar wrote:
>> Hi Shawn,
>>
>> On Sat, Nov 22, 2014 at 5:01 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> > Seungwon, Jaehoon,
>> >
>> > On Fri, Nov 21, 2014 at 02:39:10PM +0800, Shawn Guo wrote:
>> >> Commit f1d2736c8156 ("mmc: dw_mmc: control card read threshold")
>> >> introduces a regression for use case where PIO mode is used, i.e.
>> >> CONFIG_MMC_DW_IDMAC is not disabled.  It stops kernel from booting
>> >
>> > s/not disabled/disabled
>> >
>> >> like below.
>> >
>> > For understanding the problem better, can you guys please to test the
>> > dw_mmc driver on Samsung platforms with CONFIG_MMC_DW_IDMAC disabled.
>> > I'm wondering this is a problem specific to my platform or a common one.
>> >
>> I tested PIO mode on exynos5800-peach-pi board with Ulf's -next
>> branch, and it works fine.
>> To confirm PIO mode works, I ran iozone and it gave  low performance
>> number (as expected) then IDMA mode.
>
> Thanks a lot for testing and confirming that it works on exynos.
>
>>
>> One thing to note, is your controller version is 210a, so not sure if
>> something more in missing from driver.
>
> Unfortunately, I do not have the reference manual for the hardware I'm
> running so far.  But from the kernel log, the controller version is
> 210a.  What do you mean by "something more in missing from driver"?
> The driver has any limitation for any particular controller versions?
>
For that you need to check dw_mmc data book for 210a version. Sorry I
don't have it.

> One thing I need to check with hardware vendor is whether register
> CDTHRCTL is available on my dwmmc controller.  From my testing, even
> reading this register every time dw_mci_submit_data() is called causes
> problem for me.
>
yes, your guess is right, did you tested with ulf's -next branch?
Recently patch [1] is merged, that most likely to solve your platform
issue. Have a try.

[1] http://www.spinics.net/lists/stable/msg69884.html

>> Also from log its looks like you card clock is 26Mhz, did you tried
>> running at 52Mhz?
>
> I did not.  But it's unlikely the problem of clock frequency from what
> I've seen.
>
> Shawn



-- 
Regards,
Alim
