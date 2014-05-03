From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 4/5][RESENT] mmc: SDHI: update sh_mobile_sdhi_of_data
 for r8a7790
Date: Sun, 04 May 2014 01:30:45 +0400
Message-ID: <53656005.90200@cogentembedded.com>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>	<878ut5qo9d.wl%kuninori.morimoto.gx@gmail.com>	<8738jdqo78.wl%kuninori.morimoto.gx@gmail.com>	<5364305C.7090005@cogentembedded.com> <CANqRtoSmAcny1X_Qa67LQF9uASoVSPJUFcPuFvQdb4O-XnWtBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CANqRtoSmAcny1X_Qa67LQF9uASoVSPJUFcPuFvQdb4O-XnWtBQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hello.

On 05/03/2014 11:23 PM, Magnus Damm wrote:

>>> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

>>> This patch updates r8a7790 DT data to have SoC specific settings.

>>> Acked-by: Simon Horman <horms+renesas@verge.net.au>
>>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>>> ---
>>>    drivers/mmc/host/sh_mobile_sdhi.c |   10 +++++++++-
>>>    1 file changed, 9 insertions(+), 1 deletion(-)

>>> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c
>>> b/drivers/mmc/host/sh_mobile_sdhi.c
>>> index 38acf26..cfc37ec 100644
>>> --- a/drivers/mmc/host/sh_mobile_sdhi.c
>>> +++ b/drivers/mmc/host/sh_mobile_sdhi.c

>> [...]

>>> @@ -51,6 +52,12 @@ static const struct sh_mobile_sdhi_of_data
>>> of_rcar_gen1_compatible = {
>>>          .capabilities   = MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
>>>    };

>>> +static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
>>> +       .tmio_flags     = TMIO_MMC_HAS_IDLE_WAIT |
>>> TMIO_MMC_WRPROTECT_DISABLE,

>>     Hm, I think SDHI0/1 still have the WP signal, only SDHI2 on Koelsch lacks
>> it due to using micro-SD slot?..

> This has been design this way intentionally. Basically, we don't want
> any board specific code in any driver and the WP signal is a very
> board specific property. So we default to not using WP, but let the
> user hook in GPIO via DT in case it is used on a particular instance
> on a particular board. If we do it the other way around and enable by
> default then we would have to implement disabling of WP in DT which is
> just strange.

    I don't quite understand what's so strange about that. IMO, the device 
node properties are designed to carry the board specific info.

> If done wrong then the micro-SD cards may end up with
> incorrect WP signal state (read only?).

    Hm, isn't WP a read-only signal by design?

> So letting board code hook in
> board specific bits via DT seems like the only sane way forward in my
> mind.

    Yes, I'd agree to that but I can't agree that preferring GPIO to the 
native WP signal is the only sane way.

> Is there anything related to WP and CD that does not work for you?

    I don't think the legacy code handles CD correctly. The driver doesn't 
ever read the native CD signal, it expects CD to be always implemented via 
GPIO while the legacy code doesn't pass the GPIO to the driver.

> Thanks,

> / magnus

WBR, Sergei

