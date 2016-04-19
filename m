From: Olliver Schinagl <oliver@schinagl.nl>
Subject: Re: [PATCH 1/2] mmc: core: Improve marking broken HPI through
 devicetree
Date: Tue, 19 Apr 2016 14:45:08 +0200
Message-ID: <57162854.5050109@schinagl.nl>
References: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
 <1461049934-12848-2-git-send-email-oliver@schinagl.nl>
 <CAPDyKFqftYtrHvcQB7te1fuWxjWtrhOGY=5DnRTnrRxHm2cQ-A@mail.gmail.com>
 <5715FD6B.5000809@schinagl.nl> <5716150D.7060200@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5716150D.7060200@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>, Michal Hocko <mhocko@suse.com>, Lars-Peter Clausen <lars@metafoo.de>, Sudeep Holla <Sudeep.Holla@arm.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Wenkai Du <wenkai.du@intel.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Jaehoon Chung <jh80.chung@samsung.com>, Michal Suchanek <hramrach@gmail.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Hey Hans,

On 19-04-16 13:22, Hans de Goede wrote:
> Hi,
>
> On 19-04-16 11:42, Olliver Schinagl wrote:
>> Hi Ulf,
>>
>> On 19-04-16 11:29, Ulf Hansson wrote:
>>> On 19 April 2016 at 09:12, Olliver Schinagl <oliver@schinagl.nl> wrote:
>>>> In patch 81f8a7be66 Hans de Goede added a patch to allow marking an 
>>>> mmc
>>>> device as to having an broken HPI implementation. After talking some
>>>> with Hans, we now think it is actually the mmc controller that can be
>>>> broken and not support broken HPI's.
> >>
>>> I don't want us to invent a DT binding for something you *think* is a
>>> HW controller issue.
>
> I agree we should not add a dt flag for this, we can simply set the
> flag in the host driver if we believe this is a host issue.
Okay, I can remove the dt flag
>
>>> Have you really excluded that this isn't a software issue? Me
>>> personally haven't been using HPI that much so I can't really tell
>>> about the code robustness from the mmc core (mmc protocol point of
>>> view).
>> Well this patch goes hand in hand so to speak with the broken-hpi 
>> patch introduced by him, he did most of the investigation. We just 
>> discussed how to handle it and asked me to cook up the patch.
>>
>> @hans, what do you think?
>
> When we discussed this a while back we had a pretty small sample
> set of sunxi boards with emmc, and it seemed that hpi was broken
> on all of them. But recently we've been seeing eMMC-s on a lot more
> boards and they all work fine, except the one on my Utoo A13 tablets,
> and the one you are using, so this does really seem be an eMMC
> specific problem. That or it is a problem with the host on 
> sun4i/sun5i/sun7i
> which is not present on sun6i, sun8i and later ...
Well I think we still have a very small sample size, the sun4i, sun5i 
and sun7i boards (all using the same mmc controller afaik) have the 
broken-hpi set, the sun6i and sun8i seem to be working fine (different 
mmc controller?).
I'm not so sure it is an eMMC specific problem though. The module we're 
using is a high-end micron part, industrial grade. Granted, it could be 
still broken there, but I find it less likely. Micron has an 
interessting technical document:
"TN-52-05 e.EMMC Linux Enablement"
talking specifically about HPI on eMMC.
It also mentions HPI is a mmc/jedic 4.41 thing, afaik our controller is 
only 4.3 (which might not even matter according to Ulf if it is just a 
command).

The datasheet of the chip I use, MTFC4GACAANA, also mentions explicitly 
that it supports HPI.

Granted, it could still be broken, but I have doubts.

>
> But given how rare eMMC-s are on sun4i/sun5i/sun7i I think the current
> solution where we set a flag on the emmc dt node rather then on the
> host node / in the host driver is fine.
Yeah it is very limited, that is true, and I suppose I can live with that.
>
> Taking your case into account too, that will bring us up to 2 cases
> where we set the broken-hpi flag on the emmc node, which does not
> really seem like a number to worry about.
Actually, 4 :), there are 3 sun5i (tablets?) devices that suffer from 
this and my device now. The sun6i and sun8i devices are only 2 (the 
sinlinx devices in the current kernel) that a very quick grep (mmc-card 
) showed. Grepping for non-removable yielded a bit more, like the chip 
sun5i-like device with a "non-removable" mmc, not sure what to make of 
that though.
>
> TL;DR: Thanks for writing this patch set, but given recent developments
> I believe that it is best to keep handling broken-hpi as we are doing
> in current kernels and no changes are necessary.
I would still recommend to add the capability and raise the flag for the 
sun[457]i devices though, as my gut thinks it's a problem with the sunxi 
IP there. But with the emmc-card level work around, it does solve/fix 
it, so what is the best way?

Olliver
>
> Regards,
>
> Hans
>
>
>>>
>>> Kind regards
>>> Uffe
>>>
>>>> This patch adds a new capability, mmc-broken-hpi, which allows us to
>>>> mark a broken hpi implementation on the host level.
>>>>
>>>> Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
>>>> ---
>>>>   drivers/mmc/core/host.c  | 2 ++
>>>>   drivers/mmc/core/mmc.c   | 2 +-
>>>>   include/linux/mmc/host.h | 1 +
>>>>   3 files changed, 4 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
>>>> index 6e4c55a..9b63b36 100644
>>>> --- a/drivers/mmc/core/host.c
>>>> +++ b/drivers/mmc/core/host.c
>>>> @@ -270,6 +270,8 @@ int mmc_of_parse(struct mmc_host *host)
>>>>                  host->caps |= MMC_CAP_HW_RESET;
>>>>          if (of_property_read_bool(np, "cap-sdio-irq"))
>>>>                  host->caps |= MMC_CAP_SDIO_IRQ;
>>>> +       if (of_property_read_bool(np, "mmc-broken-hpi"))
>>>> +               host->caps |= MMC_CAP_BROKEN_HPI;
>>>>          if (of_property_read_bool(np, "full-pwr-cycle"))
>>>>                  host->caps2 |= MMC_CAP2_FULL_PWR_CYCLE;
>>>>          if (of_property_read_bool(np, "keep-power-in-suspend"))
>>>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>>>> index 4dbe3df..9a19562 100644
>>>> --- a/drivers/mmc/core/mmc.c
>>>> +++ b/drivers/mmc/core/mmc.c
>>>> @@ -1592,7 +1592,7 @@ static int mmc_init_card(struct mmc_host 
>>>> *host, u32 ocr,
>>>>          /*
>>>>           * Enable HPI feature (if supported)
>>>>           */
>>>> -       if (card->ext_csd.hpi) {
>>>> +       if (card->ext_csd.hpi && !(host->caps & MMC_CAP_BROKEN_HPI)) {
>>>>                  err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>>>                                  EXT_CSD_HPI_MGMT, 1,
>>>> card->ext_csd.generic_cmd6_time);
>>>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>>>> index 8dd4d29..20f758e 100644
>>>> --- a/include/linux/mmc/host.h
>>>> +++ b/include/linux/mmc/host.h
>>>> @@ -264,6 +264,7 @@ struct mmc_host {
>>>>   #define MMC_CAP_DRIVER_TYPE_A  (1 << 23)       /* Host supports 
>>>> Driver Type A */
>>>>   #define MMC_CAP_DRIVER_TYPE_C  (1 << 24)       /* Host supports 
>>>> Driver Type C */
>>>>   #define MMC_CAP_DRIVER_TYPE_D  (1 << 25)       /* Host supports 
>>>> Driver Type D */
>>>> +#define MMC_CAP_BROKEN_HPI     (1 << 29)       /* Host support for 
>>>> HPI is broken */
>>>>   #define MMC_CAP_CMD23          (1 << 30)       /* CMD23 
>>>> supported. */
>>>>   #define MMC_CAP_HW_RESET       (1 << 31)       /* Hardware reset */
>>>>
>>>> -- 
>>>> 2.8.0.rc3
>>>>
>>
