From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH 2/2] mmc: Add mmc_force_detect_change_begin / _end
 functions
Date: Tue, 9 Oct 2018 16:03:12 +0200
Message-ID: <d44615b8-32e0-1c71-97bb-13c1994239fb@exceet.de>
References: <CAPDyKFqDrdD+N+foLCwsVABtboz1Vn=OtJs14gp07zJfXHVKSA@mail.gmail.com>
 <f9028dcb-c217-4efc-60a7-d0a2c1804a08@exceet.de>
 <d9795fde-6bdd-b6fa-da41-839d44df6435@redhat.com>
 <20180927081452.a2xw25sdoqtadntu@flea>
 <85c2baea-8dbb-ef1b-93d2-7749c5a100e6@exceet.de>
 <20181009075230.aaxne3z247yc3lu6@qschulz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009075230.aaxne3z247yc3lu6@qschulz>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@bootlin.com>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>, Hans de Goede <hdegoede@redhat.com>, quentin.schulz@free-electrons.com, ulf.hansson@linaro.org, gregkh@linuxfoundation.org, linus.walleij@linaro.org, shawn.lin@rock-chips.com, adrian.hunter@intel.com, baolin.wang@linaro.org, thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devel@driverdev.osuosl.org, icenowy@aosc.xyz, wens@csie.org
List-Id: linux-mmc@vger.kernel.org

Hi Quentin,

On 09.10.2018 09:52, Quentin Schulz wrote:
> Hi Frieder,
> 
> On Mon, Oct 08, 2018 at 11:53:21AM +0200, Frieder Schrempf wrote:
>> Hi,
>>
>> On 27.09.2018 10:14, Maxime Ripard wrote:
>>> On Wed, Sep 26, 2018 at 10:19:22PM +0200, Hans de Goede wrote:
>>>> On 26-09-18 16:44, Frieder Schrempf wrote:
>>>>> Hi,
>>>>>
>>>>> On Fri, Feb 09, 2018 at 03:01:00PM +0100, Ulf Hansson wrote:
>>>>>> [...]
>>>>>>
>>>>>>>>> I'd like to know if any progress has been made on that problem
>>>>> (I may
>>>>>>>>> have missed patches).
>>>>>>>>> Had you had the time to look at the issue?
>>>>>>>>
>>>>>>>> I have looked at the issue, but not manage to cook some patches
>>>>> for it.
>>>>>>>>
>>>>>>>> However, it's on my top of my TODO list for mmc. No promises, but
>>>>>>>> perhaps and hopefully I manage to get something posted during the
>>>>>>>> coming release cycle.
>>>>>
>>>>> I would be interested in a ESP8089 driver in mainline and that's why I want to pick up this discussion.
>>>>>
>>>>> What is the current status of the "mmc_reprobe_device" implementation, that Hans was explaining and Ulf wanted to provide some months ago?
>>>>
>>>> Ulf did eventually write a new way to deal with this and then Quentin
>>>> did manage to get the esp8089 driver to work with it, the new function
>>>> to use for this is added by this commit:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/core?id=1433269c4d2461be1f36db5dbb453976b38996ff
>>>>
>>>> I'm not sure what the status of upstreaming the ep8089 driver is now
>>>> that we've this in place.
>>>>
>>>> Quentin, do you have a version of the esp8089 driver somewhere
>>>> which will work correctly with the new mmc_sw_reset() function?
>>>>
>>>> Also what is the status of adding this driver to say staging?
>>>
>>> IIRC, we tried to get it into staging, and we got told that it was too
>>> nice for staging at this point. So we're basically stuck somewhere
>>> between staging and !staging, with the driver being too nice for the
>>> former, and not nice enough for the latter :)
>>
>> Ok, and is there someone willing to continue upstreaming the driver? Maybe
>> someone can rebase and resend the latest approach?
>>
>> After all it looks like a lot of work has already been done.
>>
> 
> There's clean up to do. It's time consuming but shouldn't be too hard to
> do.
> 
> Then, we stressed the driver with an iperf test and it crashes very
> often so we first need to identify if it happened with the "original"
> driver before Icenowy's, Hans's and my clean-up. If it happened, since
> we don't have a datasheet, it might be not that easy to fix. If it
> didn't happen, then we have to find out where I cleaned up too much :D
> 
> I'm not currently working on this topic so anyone willing to take over
> the work is free to do so.

Thanks a lot for providing the details. It is currently not clear on our 
side, if the project with the ESP8089 will happen, but if that's the 
case we might pick up the work.

Thanks
Frieder
