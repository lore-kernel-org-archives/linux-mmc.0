From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: Re: [PATCH 1/2] staging: net: wireless: add ESP8089 WiFi driver
Date: Fri, 21 Jul 2017 19:05:26 +0200
Message-ID: <37e6e8f9-8f36-cb78-276d-01f4656c6e47@free-electrons.com>
References: <20170721143502.1991-1-quentin.schulz@free-electrons.com>
 <20170721143502.1991-2-quentin.schulz@free-electrons.com>
 <20170721150133.GA18198@kroah.com>
 <ab1c22b6-9208-6f99-9422-688195ad98f7@free-electrons.com>
 <34C896A9-0FFE-4174-8E08-A07A12C4A7ED@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <34C896A9-0FFE-4174-8E08-A07A12C4A7ED@holtmann.org>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: devel@driverdev.osuosl.org, Ulf Hansson <ulf.hansson@linaro.org>, baolin.wang@linaro.org, Greg KH <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, kernel list <linux-kernel@vger.kernel.org>, Hans de Goede <hdegoede@redhat.com>, wens@csie.org, icenowy@aosc.xyz, maxime.ripard@free-electrons.com, shawn.lin@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Hi Marcel,

On 21/07/2017 18:52, Marcel Holtmann wrote:
> Hi Quentin,
> 
>>>> The Espressif ESP8089 WiFi chips can be often found in cheap tablets.
>>>> There is one in A23 Polaroid tablets for example.
>>>>
>>>> The chip is often embedded as an eMMC SDIO device.
>>>>
>>>> The code was taken from an out-of-tree repository and has seen a first
>>>> pass in the cleanup process.
>>>>
>>>> At the moment, there is no publicly available datasheet for this chip.
>>>>
>>>> Cc: Hans de Goede <hdegoede@redhat.com>
>>>> Cc: Icenowy Zheng <icenowy@aosc.xyz>
>>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>>
>>> Staging drivers need a TODO file that lists what has to be done to the
>>> code to get it out of staging.  Why not just take a day or so and fix up
>>> the remaining issues and get it into the "real" part of the kernel
>>> correctly?
>>>
>>
>> OK, I'll work on a TODO list. Is there anything else I should know about
>> staging drivers so I can address everything at the same time?
>>
>> From a driver that has already been cleaned up a bit by Icenowy and
>> Hans, it took me between 10 and 15 working days to this step, which I
>> estimate to be around 50% of total clean up (and we're only speaking
>> about coding style and dead code mainly, nothing about a bit of code
>> review, code robustness...). I find the code not really easy to follow
>> (might be because I'm a beginner in the subsystem as well).
>>
>> I might not be the most efficient person in cleaning up drivers but I'm
>> pretty sure this isn't a one day cleanup. (Would be happy to be proven
>> otherwise :) ), else I would have done it as you suggest.
> 
> even if it takes you 1 month to clean it up, get it reviewed on linux-wireless and target wireless-drivers instead of staging. When I had a brief a look at your patch, it didn't look like staging material to me.
> 

We don't have a client supporting this effort and I don't think the
company I work for would support this effort (maybe it would, but
definitely spread over a long long period), so we're talking about 10-15
working days spread over my free time/week-end, that isn't for in one
month :) I could use help for sure on this driver, that's why I posted
it in staging.

I've done the cleanup on a per-file basis so maybe you looked at one of
the cleaned up files?

Just to be sure, you're telling me that I should post it as is on
linux-wireless and then work with the reviews? Or are you telling me to
take "1 month to clean it up" and then post it on linux-wireless?

Thanks,
Quentin

> Regards
> 
> Marcel
> 

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
