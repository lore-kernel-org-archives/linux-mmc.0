From: Shawn Lin <shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 2/2] dt-bindings: rockchip-dw-mshc: add
 rockchip,default-drv-phase
Date: Wed, 11 May 2016 10:50:17 +0800
Message-ID: <e202f663-88d7-693b-a765-c130e68d1c2d@rock-chips.com>
References: <1462527648-24443-1-git-send-email-shawn.lin@rock-chips.com>
 <1462527673-24711-1-git-send-email-shawn.lin@rock-chips.com>
 <CAD=FV=WSkBwBjVsRoDsfjD+sNfR70mKGRA0khjPKKW0zS2=PTw@mail.gmail.com>
 <b15dcb4f-1584-8219-2fe0-97eecb0c64a6@rock-chips.com>
 <CAD=FV=XToSzqSh=SShHuQU9W_m7gfyQn8wRXkLy79t+tnqZknA@mail.gmail.com>
 <1f2f43c7-2672-e448-eddb-2d613bb8dc48@rock-chips.com>
 <CAD=FV=UGbrJRyUbbgzbcYf9GjPG+Fh_gpQ3rX2G=wi2w5Lw=Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=UGbrJRyUbbgzbcYf9GjPG+Fh_gpQ3rX2G=wi2w5Lw=Sg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, Jaehoon Chung <jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 2016/5/10 23:57, Doug Anderson wrote:
> (again, but not HTML)
>

------8<------------------

>
> I have less faith than you in the TRM.  The TRM is full of minor
> errors and is often wrong about the default state of things.  IMHO the
> only true way to find out is to boot up some SoCs and check.
>

Okay, I should not have too much confidence on my TRM maybe :).

Again, We SHOULD refer to the Mobile Storage Host section (Variable
Delay/Clock Generation) instead of CRU section, otherwise even you will
see inconsistent decription of mmc_clock->shift.



> As far as whether code touches these values:
>

---------8<-----------------

>>
>> maybe. But I think 180(downside) is the better.

NAK my previous comments here. Downside is better for SRD, but won't
work for DDR mode. When running in DDR mode, we should use 90 instead.

So let me elaborate a bit more here.
For DDR mode, one single clk cycle should sending two data bits outside
to the devices. We need a hold time for both. If 180 is used, the first
bit occurs around the downside area, which won't be sampled by devices
on the upside.  So on the upside, the devices will see a zero bit if you
actually send a one-bit, which makes the devices  generate CRC finally.


For this above, 180 for all SDR mode is ok, but 90 should be deployed
for DDR mode. So simply checking the timing to hardcode it should be
fine.

>
> I'm OK with using 180 always as long as SD cards continue to work OK.
> Best would be if someone could actually run a protocol analyzer for
> all the different speed modes.
>
>
>>> Also: I still haven't heard whether there is any downside to using 180
>>> degrees for modes that only require 90 degrees.  Does it cause
>>> problems to just always use 180 degrees?  If not, we could possibly
>>> use 180 degrees everywhere and just hardcode it?
>>
>>



-- 
Best Regards
Shawn Lin

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
