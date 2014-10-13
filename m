From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 07/11] mmc: sdio: Convert to dev_pm_domain_attach|detach()
Date: Mon, 13 Oct 2014 13:44:44 +0200
Message-ID: <CAPDyKFpbZiCZMsLP+mq-1UWd1ifX1QZosv8UfnW__J26y+hupQ@mail.gmail.com>
References: <1411151264-16245-1-git-send-email-ulf.hansson@linaro.org>
	<1411151264-16245-8-git-send-email-ulf.hansson@linaro.org>
	<20141002002705.GA29177@dtor-ws>
	<543B3D80.1010704@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <543B3D80.1010704@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Daniel Lezcano <daniel.lezcano@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Boyd <sboyd@codeaurora.org>, Philipp Zabel <philipp.zabel@gmail.com>Mark Brown <br>
List-Id: linux-mmc@vger.kernel.org

On 13 October 2014 04:48, Aaron Lu <aaron.lu@intel.com> wrote:
> On 10/02/2014 08:27 AM, Dmitry Torokhov wrote:
>> Hi Ulf,
>>
>> On Fri, Sep 19, 2014 at 08:27:40PM +0200, Ulf Hansson wrote:
>>> Previously only the ACPI PM domain was supported by the sdio bus.
>>>
>>> Let's convert to the common attach/detach functions for PM domains,
>>> which currently means we are extending the support to include the
>>> generic PM domain as well.
>>>
>>> Cc: linux-mmc@vger.kernel.org
>>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> Reviewed-by: Kevin Hilman <khilman@linaro.org>
>>> ---
>>>  drivers/mmc/core/sdio_bus.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
>>> index 4fa8fef9..1df0fc6 100644
>>> --- a/drivers/mmc/core/sdio_bus.c
>>> +++ b/drivers/mmc/core/sdio_bus.c
>>> @@ -315,7 +315,7 @@ int sdio_add_func(struct sdio_func *func)
>>>      ret = device_add(&func->dev);
>>>      if (ret == 0) {
>>>              sdio_func_set_present(func);
>>> -            acpi_dev_pm_attach(&func->dev, false);
>>> +            dev_pm_domain_attach(&func->dev, false);
>>
>> Admittedly it is not brought in by your change, but I am a bit worried
>> about this code. In all other busses we attach power domain to a device
>> before probing it (and detach if probe fails). Why here we only attach
>> it to power domain after adding the device to the bus? If driver for the
>> function has already been loaded the probe() would run without device
>> being attached to a power domain...
>
> Sorry for replying late...
>
> I see your concern, but it should be safe here. The dev_pm_domain_attach
> does primarily two things(for ACPI based system): assign the pm_domian
> field so that later system and runtime PM transitions we have proper
> callbacks for this device; power on the device if needed.
>
> I was using Broadcom BCM43241 SDIO wifi card when developing the code,
> it doesn't need the pm_domain set in its probe function and since the
> SDIO wifi card is powered on after system boot, no power on is needed
> either. That's why I added the attach function after device_add to save
> a little code(detach if probe fails).
>
> Feel free to change the sequence if the current one is a bad one, I'm OK
> with either case.

Thanks for clarifying this. I plan to change the behaviour according
to how other buses handles it.

Though, the patch will be a part another patchset that handles a
related initialization problem for the generic PM domain. I will keep
you guys on cc when I post it.

Kind regards
Uffe
