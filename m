From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 4/5][RESENT] mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7790
Date: Sun, 4 May 2014 17:01:57 +0900
Message-ID: <CANqRtoSOLeX-jOo9wGi9rPrBVwc=mh09d+noujPXDxrRZpB5mA@mail.gmail.com>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
	<878ut5qo9d.wl%kuninori.morimoto.gx@gmail.com>
	<8738jdqo78.wl%kuninori.morimoto.gx@gmail.com>
	<5364305C.7090005@cogentembedded.com>
	<CANqRtoSmAcny1X_Qa67LQF9uASoVSPJUFcPuFvQdb4O-XnWtBQ@mail.gmail.com>
	<53656005.90200@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <53656005.90200@cogentembedded.com>
Sender: linux-sh-owner@vger.kernel.org
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Sun, May 4, 2014 at 6:30 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Hello.
>
>
> On 05/03/2014 11:23 PM, Magnus Damm wrote:
>
>>>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
>
>>>> This patch updates r8a7790 DT data to have SoC specific settings.
>
>
>>>> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>>> ---
>>>>    drivers/mmc/host/sh_mobile_sdhi.c |   10 +++++++++-
>>>>    1 file changed, 9 insertions(+), 1 deletion(-)
>
>
>>>> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c
>>>> b/drivers/mmc/host/sh_mobile_sdhi.c
>>>> index 38acf26..cfc37ec 100644
>>>> --- a/drivers/mmc/host/sh_mobile_sdhi.c
>>>> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
>
>
>>> [...]
>
>
>>>> @@ -51,6 +52,12 @@ static const struct sh_mobile_sdhi_of_data
>>>> of_rcar_gen1_compatible = {
>>>>          .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
>>>>    };
>
>
>>>> +static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
>>>> +       .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT |
>>>> TMIO_MMC_WRPROTECT_DISABLE,
>
>
>>>     Hm, I think SDHI0/1 still have the WP signal, only SDHI2 on Koelsch
>>> lacks
>>> it due to using micro-SD slot?..
>
>
>> This has been design this way intentionally. Basically, we don't want
>> any board specific code in any driver and the WP signal is a very
>> board specific property. So we default to not using WP, but let the
>> user hook in GPIO via DT in case it is used on a particular instance
>> on a particular board. If we do it the other way around and enable by
>> default then we would have to implement disabling of WP in DT which is
>> just strange.
>
>
>    I don't quite understand what's so strange about that. IMO, the device
> node properties are designed to carry the board specific info.

This is all about wanting sane defaults and keeping the code simple.
Using GPIOs covers 100% of all use cases on R-Car Gen2 and it allows
us to use generic DT properties in the board DTS to enable WP and CD.
Any other native CD or WP handling is just a corner case.

You may be confused by the difference between the R-Car Gen1 case and
the R-Car Gen2 case when it comes to CD and WP handling in the SDHI
driver. The reason why we don't rely 100% on GPIO for Gen1 is that the
GPIO hardware does not support IRQ trigger with both edges. In R-Car
Gen2 case the GPIO should cover all pins on the system and allows for
both edge trigger.

Using the native CD (and maybe WP) functionality of the SDHI hardware
may conflict with Runtime PM. Ideally we want to be able to disable
the clock and power domain when no card is inserted or the card is
in-use but idle. Using GPIO helps us with that.

>> If done wrong then the micro-SD cards may end up with
>> incorrect WP signal state (read only?).
>
>
>    Hm, isn't WP a read-only signal by design?

The _card_ may end up read-only if WP is used incorrectly.

>> So letting board code hook in
>> board specific bits via DT seems like the only sane way forward in my
>> mind.
>
>
>    Yes, I'd agree to that but I can't agree that preferring GPIO to the
> native WP signal is the only sane way.

So why would we want to have multiple overlapping ways of handling the
WP signal?

>> Is there anything related to WP and CD that does not work for you?
>
>
>    I don't think the legacy code handles CD correctly. The driver doesn't
> ever read the native CD signal, it expects CD to be always implemented via
> GPIO while the legacy code doesn't pass the GPIO to the driver.

Are you sure about this? If you find a bug then please report it,
otherwise I can think of more interesting things to spend time on.

Cheers,

/ magnus
