From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc-rockchip: parse
 rockchip,default-num-phases from DT
Date: Tue, 2 May 2017 14:58:10 +0800
Message-ID: <da486fac-e37a-c249-7400-8efa73c08505@rock-chips.com>
References: <1492592434-81312-1-git-send-email-shawn.lin@rock-chips.com>
 <1492592434-81312-3-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=X6PRe1u+s4Nnt=9gJD2T4=YyLdMWnKe5rZg2KgWGNAvg@mail.gmail.com>
 <58609a89-3413-3383-4bd5-271868500f7d@rock-chips.com>
 <CAD=FV=Uyqvzg5H+Mg5RtQAWiCxVARx7uB4jxPe=2fcSmJQoOjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=Uyqvzg5H+Mg5RtQAWiCxVARx7uB4jxPe=2fcSmJQoOjw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ziyuan Xu <xzy.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Doug,

在 2017/4/25 0:18, Doug Anderson 写道:
> Hi,
>
> On Wed, Apr 19, 2017 at 6:21 PM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
>> Hi Doug,
>>
>> 在 2017/4/20 4:19, Doug Anderson 写道:
>>>
>>> Hi,
>>>
>>> On Wed, Apr 19, 2017 at 2:00 AM, Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>> wrote:
>>>>
>>>> Currently we unconditionally do tuning for each degree, which
>>>> costs 900ms for each boot and resume.
>>>>
>>>> May someone argue that this is a question of accuracy VS time. But I
>>>> would say it's a trick of how we need to do decision for our boards.
>>>> If we don't care the time we spend at all, we could definitely do tuning
>>>> for each degree. But when we need to improve the user experience, for
>>>> instance, speed up resuming from S3, we should also have the right to
>>>> do that. This patch add parsing "rockchip,default-num-phases", for folks
>>>> to specify the number of doing tuning. If not specified, 360 will be used
>>>> as before.
>>>>
>>>> Signed-off-by: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
>>>>
>>>> ---
>>>>
>>>>  drivers/mmc/host/dw_mmc-rockchip.c | 48
>>>> ++++++++++++++++++++++++--------------
>>>>  1 file changed, 30 insertions(+), 18 deletions(-)
>>>
>>>
>>> No huge objection here, but I do remember we ended up at the 360
>>> phases due to some of the craziness with dw_mmc delay elements on
>>> rk3288.  IIRC one of the big problems was that the delay elements
>>> changed _a lot_ with the "LOGIC" voltage and we tweaked the voltage at
>>> runtime for DDR DVFS.  That imposed an extra need to be very accurate
>>> on that SoC, at least on any board that was designed to support DDR
>>> DVFS.
>>>
>>
>> Not just with the vdd_logic but also with the process of Soc.
>> To better guaratee the accuracy, firstly we use delay element to do
>> tuning and then convert it to be combination of degree + delay element.
>> But as the dalay elements aren't accuracy themself, so all the math we
>> do here is trick.
>
> Yup.  I brought up the vdd logic specifically because it's something
> that can make the phases change quite dramatically on the same machine
> between the time you tuned and the time you used it.
>
>
>>> I also remember there being some weirdness on the Rockchip
>>> implementation where there was a certain set of phases that the MMC
>>> controller was essentially "blind".  This blind spot was in the middle
>>> of an otherwise good range of points.  Unfortunately this blind spot
>>> was somewhat hard to detect properly because it was not very big.
>>> ...the variability of the delay elements meant that there could be big
>>> ranges where we weren't getting any good test coverage, but also the
>>> fact that they changed with the LOGIC voltage might mean that we
>>> weren't in the "blind" spot and then suddenly we were.
>>
>>
>> I undertand all of these as I was suffering from it when bringing up
>> RK3288.
>>
>>>
>>> One other note is that i remember that the vast majority of time spent
>>> tuning was dealing with "bad" phases, not dealing with "good" phases.
>>> If you're looking to speed things up, maybe finding a way to make
>>> "bad" phases fail faster would be wise?  I think one of the reasons
>>> bad phases failed so slowly is because the dw_mmc timeouts are all so
>>> long.
>>
>>
>> Good point. I haven't thought of speeding up the handle of bad phases,
>> but I will take a look at this.
>>
>>>
>>> Oh, and I guess one last note is that I have no idea if folks will
>>> like the device bindings here.  Part of me thinks it should be
>>> something more "symbolic" like "rockchip,need-accurate-tuning" or
>>> something like that.  I guess I'd let the DT experts chime in.
>>>
>>>
>>> So I guess to summarize:
>>> * On rk3288 boards w/ DDR DVFS (or any other similar boards), 360
>>> seems to provide real benefit.
>>> * On other boards, probably you can get by with fewer phases.
>>>
>>
>> I would try to say it's a question of "900ms for a single time" VS.
>> "some of discrete tuning cost for more chance to do retune".
>>
>> (1)We could try to do a more accurate tuning process and spends 900ms.
>> Then we have less chance to do retune later.
>>
>> (2)We do a rough tuning and have more chance to do retune later.
>
> Ah, interesting point.  I haven't used newer versions of Linux much,
> but I seem to remember that they will automatically retune sometimes
> if they see errors.  That makes your strategy a bit more valid.
>
>
>> I also would say that this is a game , and we can't say which
>> one is better. Obvious now the "900ms" alwyas happens in the spot
>> routine, for instance, booting and resuming from S3.
>
> Is it really 900 ms?  I don't quite remember it being that long, but I
> could be remembering incorrectly.

I saw the worst case was nearly 900ms. But mostly we need 600ms there.

>
> -Doug
>
>
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
