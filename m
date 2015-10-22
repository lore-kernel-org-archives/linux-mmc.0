From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: pwrseq: Use highest priority for eMMC restart handler
Date: Thu, 22 Oct 2015 10:33:10 -0700
Message-ID: <CAD=FV=UBY1wB0wCV_v2H2thT6015Lr0=r4+uDZ5GxFZRqGoVWw@mail.gmail.com>
References: <1445440540-21525-1-git-send-email-javier@osg.samsung.com>
	<56282F71.2070408@samsung.com>
	<562839F7.3040005@osg.samsung.com>
	<56283F27.9060804@samsung.com>
	<CAD=FV=VZJ9Tc4G-Xiw60DmfC4izU_6dVwwa0N0ePM0eaJfcqkg@mail.gmail.com>
	<562909DE.1000202@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <562909DE.1000202@osg.samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Markus Reichl <m.reichl@fivetechno.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Thu, Oct 22, 2015 at 9:07 AM, Javier Martinez Canillas
<javier@osg.samsung.com> wrote:
>> Note that personally I would only choose the "highest" priority as an
>> absolute last resort.  Leaving a little extra slack in there means
>> that when the next person comes up with a really good reason to run
>> before you do that they can do it without changing your code.  All
>> good BASIC programmers know to skip "10" in their first version for
>> just this reason.  ;)
>>
>> If I were to pick a number, I suppose I'd pick something like "220",
>> but that's pretty arbitrary.  I would have picked 200 except that it
>> appears that would race with veyron's choice.
>>
>
> Yes, I actually gave some thought about choosing a number since I didn't
> want to come with another arbitrary one. That's why I tried to understand
> the policy as I mentioned before but I didn't find anything besides the
> values listed in the register_restart_handler() doc: 0, 128 and 255.
>
> It seems that most default system restart handlers use 128 and that's
> the reason why gpio-restart and mmc-pwrseq-emmc use 129 and other restart
> handlers that can be registered via DT use 192 (which is in the middle of
> 128 and 255).
>
> So I actually thought to use a number in between 192 and 255 (i.e: 220)
> but then there could be another platform that uses 221 instead of 200
> so eMMC restart won't work there. That's why I finally chose the highest.
>
> Do you know why the priority 200 was chosen for veyron gpi-restart ooi?

In David Riley's original patch the example had 200:
    https://patchwork.kernel.org/patch/4784611/

In the ChromeOS 3.14 kernel tree I believe we're still using the old
patch (we still have /bits/ 8).  ...it looks like I'm the one who
originally added it to the veyron dts file and I set it to 200, so I'd
presume that I just copied the example and called it "good enough".

I'm sure the upstream dts just used the number from the ChromeOS 3.14 tree...

Note that the GPIO-restart definitely need to be higher priorities
than others in the system.  The two I know of off the top of my head
are the "dw watchdog" and the one in the CRU.  The "dw watchdog" has a
priority of 128 and so does the one in "rockchip/clk.c".  Hrm,
actually, the Rockchip-specific one should probably have its priority
bumped up since it seems better not to just randomly pick between
these two...


-Doug
