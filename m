From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: Re: [RFC] mmc: core: Set clock before switching to
 highspeed mode.
Date: Sun, 6 Sep 2015 08:12:56 +0800
Message-ID: <55EB8508.9030009@rock-chips.com>
References: <1441448358-13129-1-git-send-email-yszhou4tech@gmail.com>
 <55EAF712.8090203@rock-chips.com> <55EB02FD.5040403@redhat.com>
Reply-To: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDGZV5NVQEMRBE4KV2XQKGQESBLDJQY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <55EB02FD.5040403-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Yousong Zhou <yszhou4tech-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 2015/9/5 22:58, Hans de Goede wrote:
> Hi Shawn Lin,
>
> On 05-09-15 16:07, Shawn Lin wrote:
>> On 2015/9/5 18:19, Yousong Zhou wrote:
>>> A SD card with sunxi-mmc can fail with the following error message
>>> (RCD for
>>> response CRC error) when trying to switch to highspeed mode.  Setting
>>> the bus
>>> clock before the access mode switch fixed it.
>>
>> No, that's wrong!
>>
>> Before this card is switched to highspeed, it works under
>> identification mode(From spec: bus clock <= 400KHz). How could you
>> raise bus clock to higher clk rate which I _guess_ is 52MHz before you
>> notify sd cards to run into highspeed mode?
>>
>> Althought it works for this card, this patch will not please the other
>> cards that they might not reply CMDs any longer including the
>> following CMD6.
>
> Thanks for the feedback, this is exactly why I asked Yousong Zhou to
> take this
> to the mmc list.
>
> So if this is not the proper fix for the problem that Yousong Zhou is
> seeing, then
> what might be the proper fix ?
>

 From my knowledge of mmc, there hadn't have a way to deal with this 
"broken" case. In another word, IMO,it's ANTI-SPEC. We can't be too spec 
sometimes, but at least we shouldn't violate it.

> Could it be that the sunxi-mmc is doing some things in the wrong order when
> changing the clock, or is this all under control of the mmc core ?
>

all of this is under control of the mmc core.
So if Yongsong does want this card to work for any linux-based mmc 
stack, I guess something like that should be "better"?

if (switch to HS fail) {
	set_bus_clk
	goto retry switch to HS
}

BUT...I admit it seems strange as well.


> Regards,
>
> Hans
>
>
>>
>>
>>>
>>>      [    1.112060] mmc0: host does not support reading read-only
>>> switch, assuming write-enable
>>>      [    1.120203] ehci-platform 1c1c000.usb: irq 31, io mem 0x01c1c000
>>>      [    1.126527] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 6, RD RCE !!
>>>      [    1.132388] sunxi-mmc 1c0f000.mmc: data error, sending stop
>>> command
>>>      [    1.139451] sunxi-mmc 1c0f000.mmc: send stop command failed
>>>      [    1.145056] mmc0: error -110 whilst initialising SD card
>>>      [    1.150424] ehci-platform 1c1c000.usb: USB 2.0 started, EHCI
>>> 1.00
>>>      [    1.156533] sunxi-mmc 1c0f000.mmc: smc 0 err, cmd 1, RTO !!
>>>
>>> Signed-off-by: Yousong Zhou <yszhou4tech-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>> ---
>>>   drivers/mmc/core/sd.c |   10 +++++-----
>>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>>> index 4e7366a..402a8db 100644
>>> --- a/drivers/mmc/core/sd.c
>>> +++ b/drivers/mmc/core/sd.c
>>> @@ -366,6 +366,11 @@ int mmc_sd_switch_hs(struct mmc_card *card)
>>>           return -ENOMEM;
>>>       }
>>>
>>> +    /*
>>> +     * Set bus frequency to match highspeed mode.
>>> +     */
>>> +    mmc_set_clock(card->host, mmc_sd_get_max_clock(card));
>>> +
>>>       err = mmc_sd_switch(card, 1, 0, 1, status);
>>>       if (err)
>>>           goto out;
>>> @@ -969,11 +974,6 @@ static int mmc_sd_init_card(struct mmc_host
>>> *host, u32 ocr,
>>>               goto free_card;
>>>
>>>           /*
>>> -         * Set bus speed.
>>> -         */
>>> -        mmc_set_clock(host, mmc_sd_get_max_clock(card));
>>> -
>>> -        /*
>>>            * Switch to wider bus (if supported).
>>>            */
>>>           if ((host->caps & MMC_CAP_4_BIT_DATA) &&
>>>
>>
>>
>
>
>


-- 
Best Regards
Shawn Lin
