From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH 2/2] mmc: Add mmc_force_detect_change_begin / _end
 functions
Date: Mon, 8 Oct 2018 11:53:21 +0200
Message-ID: <85c2baea-8dbb-ef1b-93d2-7749c5a100e6@exceet.de>
References: <CAPDyKFqDrdD+N+foLCwsVABtboz1Vn=OtJs14gp07zJfXHVKSA@mail.gmail.com>
 <f9028dcb-c217-4efc-60a7-d0a2c1804a08@exceet.de>
 <d9795fde-6bdd-b6fa-da41-839d44df6435@redhat.com>
 <20180927081452.a2xw25sdoqtadntu@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
In-Reply-To: <20180927081452.a2xw25sdoqtadntu@flea>
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
To: Maxime Ripard <maxime.ripard@bootlin.com>, Hans de Goede <hdegoede@redhat.com>, quentin.schulz@free-electrons.com
Cc: devel@driverdev.osuosl.org, ulf.hansson@linaro.org, baolin.wang@linaro.org, gregkh@linuxfoundation.org, linus.walleij@linaro.org, linux-mmc@vger.kernel.org, adrian.hunter@intel.com, linux-kernel@vger.kernel.org, wens@csie.org, icenowy@aosc.xyz, shawn.lin@rock-chips.com
List-Id: linux-mmc@vger.kernel.org

Hi,

On 27.09.2018 10:14, Maxime Ripard wrote:
> On Wed, Sep 26, 2018 at 10:19:22PM +0200, Hans de Goede wrote:
>> On 26-09-18 16:44, Frieder Schrempf wrote:
>>> Hi,
>>>
>>> On Fri, Feb 09, 2018 at 03:01:00PM +0100, Ulf Hansson wrote:
>>>> [...]
>>>>
>>>>>>> I'd like to know if any progress has been made on that problem
>>> (I may
>>>>>>> have missed patches).
>>>>>>> Had you had the time to look at the issue?
>>>>>>
>>>>>> I have looked at the issue, but not manage to cook some patches
>>> for it.
>>>>>>
>>>>>> However, it's on my top of my TODO list for mmc. No promises, but
>>>>>> perhaps and hopefully I manage to get something posted during the
>>>>>> coming release cycle.
>>>
>>> I would be interested in a ESP8089 driver in mainline and that's why I want to pick up this discussion.
>>>
>>> What is the current status of the "mmc_reprobe_device" implementation, that Hans was explaining and Ulf wanted to provide some months ago?
>>
>> Ulf did eventually write a new way to deal with this and then Quentin
>> did manage to get the esp8089 driver to work with it, the new function
>> to use for this is added by this commit:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/core?id=1433269c4d2461be1f36db5dbb453976b38996ff
>>
>> I'm not sure what the status of upstreaming the ep8089 driver is now
>> that we've this in place.
>>
>> Quentin, do you have a version of the esp8089 driver somewhere
>> which will work correctly with the new mmc_sw_reset() function?
>>
>> Also what is the status of adding this driver to say staging?
> 
> IIRC, we tried to get it into staging, and we got told that it was too
> nice for staging at this point. So we're basically stuck somewhere
> between staging and !staging, with the driver being too nice for the
> former, and not nice enough for the latter :)

Ok, and is there someone willing to continue upstreaming the driver? 
Maybe someone can rebase and resend the latest approach?

After all it looks like a lot of work has already been done.

Thanks,
Frieder
