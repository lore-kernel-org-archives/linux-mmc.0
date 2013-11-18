From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v3 2/3] mmc: omap_hsmmc: Pin remux workaround to support
 SDIO interrupt on AM335x.
Date: Mon, 18 Nov 2013 21:52:10 +0530
Message-ID: <528A3EB2.1010103@ti.com>
References: <1384761240-11005-1-git-send-email-afenkart@gmail.com> <1384761240-11005-3-git-send-email-afenkart@gmail.com> <CAOf5uw=9KJ312PVzMVEHX-Lj=iYpeZOYFduB8iOu9o+-863CYw@mail.gmail.com> <CALtMJEBfeww=ymGMXWtwjtZrpqpFrkRPEOti_uPrE63SBk3Dtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CALtMJEBfeww=ymGMXWtwjtZrpqpFrkRPEOti_uPrE63SBk3Dtw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Andreas Fenkart <afenkart@gmail.com>
Cc: Michael Trimarchi <michael@amarulasolutions.com>, Chris Ball <cjb@laptop.org>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Felipe Balbi <balbi@ti.com>, Daniel Mack <zonque@gmail.com>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Monday 18 November 2013 05:45 PM, Andreas Fenkart wrote:
> 2013/11/18 Michael Trimarchi <michael@amarulasolutions.com>:
>> Hi Andreas
>>
>> On Mon, Nov 18, 2013 at 8:53 AM, Andreas Fenkart <afenkart@gmail.com> wrote:
>>> The am335x can't detect pending cirq in PM runtime suspend.
>>> This patch reconfigures dat1 as a GPIO before going to suspend.
>>> SDIO interrupts are detected with the GPIO, the GPIO will only wake
>>> the module from suspend, SDIO irq detection will still happen through the
>>> IP block.
>>>
>>> Idea of remuxing the pins by Tony Lindgren as well as the implementation
>>> of omap_hsmmc_pin_init.
>>>
>>> Signed-off-by: Andreas Fenkart <afenkart@gmail.com>
>>>
>>> diff --git a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> index 1136e6b..146f3ad 100644
>>> --- a/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> +++ b/Documentation/devicetree/bindings/mmc/ti-omap-hsmmc.txt
>>> @@ -21,8 +21,11 @@ ti,non-removable: non-removable slot (like eMMC)
>>>   ti,needs-special-reset: Requires a special softreset sequence
>>>   ti,needs-special-hs-handling: HSMMC IP needs special setting for handling High Speed
>>>   ti,quirk-swakup-missing: SOC missing the swakeup line, will not detect
>>> -SDIO irq while in suspend. Fallback to polling. Affected chips are
>>> -am335x,
>>> +SDIO irq while in suspend. The workaround is to reconfigure the dat1 line as a
>>> +GPIO upon suspend. Beyond this option and the GPIO config, you also need to set
>>> +named pinctrl states "default", "active" and "idle ", see example below.  The
>>> +MMC driver will then then toggle between default and idle during the runtime
>>> +Affected chips are am335x,
>>>
>>>                               ------
>>>                               | PRCM |
>>> @@ -49,3 +52,24 @@ Example:
>>>                  vmmc-supply = <&vmmc>; /* phandle to regulator node */
>>>                  ti,non-removable;
>>>          };
>>> +
>>> +[am335x with with gpio for sdio irq]
>>> +
>>> +       mmc1_cirq_pin: pinmux_cirq_pin {
>>> +               pinctrl-single,pins = <
>>> +                       0x0f8 0x3f      /* MMC0_DAT1 as GPIO2_28 */
>>> +               >;
>>> +       };
>>> +
>>> +       mmc1: mmc@48060000 {
>>> +               ti,non-removable;
>>> +               bus-width = <4>;
>>> +               vmmc-supply = <&ldo2_reg>;
>>> +               vmmc_aux-supply = <&vmmc>;
>>> +               ti,quirk-swakeup-missing;
>>> +               pinctrl-names = "default", "active", "idle";
>>> +               pinctrl-0 = <&mmc1_pins>;
>>> +               pinctrl-1 = <&mmc1_pins>;
>>> +               pinctrl-2 = <&mmc1_cirq_pin>;
>>> +               ti,cirq-gpio = <&gpio3 28 0>;
>>> +       };
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>>> index 6b0ec55..b94ab08 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -36,6 +36,7 @@
>>>   #include <linux/mmc/core.h>
>>>   #include <linux/mmc/mmc.h>
>>>   #include <linux/io.h>
>>> +#include <linux/irq.h>
>>>   #include <linux/gpio.h>
>>>   #include <linux/regulator/consumer.h>
>>>   #include <linux/pinctrl/consumer.h>
>>> @@ -213,11 +214,32 @@ struct omap_hsmmc_host {
>>>          int                     req_in_progress;
>>>          int                     flags;
>>>   #define HSMMC_SDIO_IRQ_ENABLED (1 << 0)        /* SDIO irq enabled */
>>> +#define HSMMC_SWAKEUP_QUIRK    (1 << 1)
>>> +#define HSMMC_CIRQ_GPIO_ENABLED (1 << 2)
>>>
>>>          struct omap_hsmmc_next  next_data;
>>> +       struct pinctrl          *pinctrl;
>>> +       struct pinctrl_state    *fixed, *active, *idle;
>>>          struct  omap_mmc_platform_data  *pdata;
>>>   };
>>>
>>> +static irqreturn_t omap_hsmmc_cirq(int irq, void *dev_id)
>>> +{
>>> +       struct omap_hsmmc_host *host = dev_id;
>>> +       unsigned long flags;
>>> +
>>> +       spin_lock_irqsave(&host->irq_lock, flags);
>>> +       if (host->flags & HSMMC_CIRQ_GPIO_ENABLED) {
>>> +               disable_irq_nosync(mmc_slot(host).sdio_irq);
>>> +               host->flags &= ~HSMMC_CIRQ_GPIO_ENABLED;
>>> +       }
>>> +       spin_unlock_irqrestore(&host->irq_lock, flags);
>>> +
>>> +       pm_request_resume(host->dev); /* no use counter */
>>> +
>>> +       return IRQ_HANDLED;
>>> +}
>>> +
>>>   static int omap_hsmmc_card_detect(struct device *dev, int slot)
>>>   {
>>>          struct omap_hsmmc_host *host = dev_get_drvdata(dev);
>>> @@ -452,10 +474,25 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
>>>          } else
>>>                  pdata->slots[0].gpio_wp = -EINVAL;
>>>
>>> +       if (gpio_is_valid(pdata->slots[0].gpio_cirq)) {
>>> +               pdata->slots[0].sdio_irq =
>>> +                               gpio_to_irq(pdata->slots[0].gpio_cirq);
>>
>> What is this? re-assign the platform data?
>
> Seems like, I didn't pay attention to this.
> Simply kept in line how the write protection/read only pins are managed.
> I'd rather not change this part, or not changing it as part of adding
> sdio IRQ support it.
>
> Maybe somebody else on the list can explain why the platform data
> contains elements
> that are modified during runtime.
>
> - set_power / get_ro function callbacks
> - ocr_mask.
>
Hi,

few params were passed via platform data in non-DT case and never cached
in internal data structure, with non-dt support going away soon, I am
planning to cleanup pdata usage in the driver when it gets to DT only support.

