From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V8 2/2] mmc: OCTEON: Add host driver for OCTEON MMC controller.
Date: Tue, 23 Aug 2016 21:46:14 +0200
Message-ID: <CAPDyKFp047jKEZngegTxk1grvwPivqj+tqAX1ekF82s1zDE53Q@mail.gmail.com>
References: <57853474.9050108@cavium.com> <CAPDyKFqaGLWxkG+CqViqDfPqeffKE5rutgR0gduuGs9F0DX+zg@mail.gmail.com>
 <57BC8ACA.1040506@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <57BC8ACA.1040506-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: "Steven J. Hill" <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 23 August 2016 at 19:41, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org> wrote:
> On 08/23/2016 07:53 AM, Ulf Hansson wrote:
>>
>> On 12 July 2016 at 20:18, Steven J. Hill <steven.hill-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org> wrote:
>
> [...]
>
>>> +#include <asm/byteorder.h>
>>> +#include <asm/octeon/octeon.h>
>>
>>
>
> OK, we will duplicate any needed definitions from octeon.h into the driver
> source file.

Why can't you share it via a platfrom data header at
include/linux/platform_data/* ?

[...]

>>
>
> I guess we will put it in arch/mips/cavium-octeon/octeon-mmc-platform.c or
> something.

There is also drivers/soc/* to consider. I am not sure what suits you best.

[...]

>>> +       emm_dma.u64 = 0;
>>> +       emm_dma.s.bus_id = slot->bus_id;
>>> +       emm_dma.s.dma_val = 1;
>>> +       emm_dma.s.sector = mmc_card_blockaddr(mmc->card) ? 1 : 0;
>>> +       emm_dma.s.rw = (data->flags & MMC_DATA_WRITE) ? 1 : 0;
>>> +       if (mmc_card_mmc(mmc->card) ||
>>> +           (mmc_card_sd(mmc->card) &&
>>> +               (mmc->card->scr.cmds & SD_SCR_CMD23_SUPPORT)))
>>> +               emm_dma.s.multi = 1;
>>
>>
>> Could you elaborate on exactly what you are doing here. I don't
>> understand why you need to check whether the card supports CMD23.
>
>
>
> The MMC host hardware doesn't issue single commands, because that would
> require the driver and OS MMC core to do work to determine the proper
> sequence of commands.  Instead, this hardware is superior to most other MMC
> bus hosts, the sequence of MMC command required to execute a transfer are
> issued automatically by the bus hardware.

Oh, nice! Actually I have heard of similar HW, although I am not sure
whether there is some mmc driver that has deployed support for this.

Anyway, perhaps we at a later point can think of if there is a clever
way to optimize the request path for these kind of HWs.

>
> Because the interface expected by the Linux MMC core is at a lower level
> than what the OCTEON MMC host can accept we need to examine the the
> mmc_request and card capabilities to determine which operations most closely
> match what is being requested.
>
> In the case of emm_dma.s.multi above, the bus hardware will automatically
> issue CMD23 when this bit is set, so we only set it if we think it is a
> valid thing to do.

I noticed that the similar check is done in the mmc block layer,
perhaps we should add a helper function like mmc_card_cmd23() which
tells whether the cards supports CMD23.

If you like to add a helper as part of this series, it would be nice -
although we can also deal with that later if you prefer so.

>
>
>>
>> Moreover you must not access mmc->card unless you make sure there is a
>> valid pointer for it.
>
>
> OK, it has never been found to be invalid in the wild.  When a transfer is
> requested, it always targets some card, but we can add a check at the top to
> return an error code if the card is somehow NULL.

That's probably because you also requires a multi block transfer for
dma jobs, which is when the card has been created...

I would have verified that the card exists...

[...]

>>> +
>>> +       /* Alternatively a GPIO may be specified to control slot power */
>>> +       slot->pwr_gpiod = devm_gpiod_get_optional(dev, "power",
>>> GPIOD_OUT_LOW);
>>
>>
>> No, I am not happy with this as we discussed earlier. You need to
>> parse the DTB from SoC specifc code and manage the power GPIO from
>> there.
>>
>> Ideally you should register the power GPIO as a GPIO regulator for the
>> cavium mmc slot device.
>
>
> What do we do if the GPIO doensn't really control power to the card, but
> rather is just a bus isolator on the data bus lines?  The device tree will

That more sounds like a pinctrl to me then.

> still have a property called "power" (as that is a legacy binding that
> cannot be changed), but no power control is done.
>
> In this case, is it still appropiate to use the  regulator framework?

Probably not.

>
> I don't see what is gained.  This is an SoC specific MMC controller that is
> connected in a manner that doesn't really match the Linux regulator
> framework.  Is it really cleaner to put 100 lines of ugly hacks in the
> platform code instead of a couple of lines here in the driver?  What is
> achieved?  We arn't creating an elegant framework, but instead jumping
> through hoops to make an archectual mismatch between various Linux driver
> frameworks be bent to fit as a matter of principle.
>
> If that is what you require to merge the driver we will do it.

We have cleaned up lots of mmc hacks that dealt with "regulators" in
all kind of home-brewed manners. It was a mess.

In this particular case it also seems a little bit unclear what the
regulators (power GPIOs) is really used for. Very similar to the
experience I had with the earlier hacks.

So, please try to describe in detail about what the power GPIO are and
how/if they connects to the card. if they are considered as to control
I/O voltage level or power to the card, then those shall be modelled
as regulators.

Sorry if you find me being stubborn on this, although I hope the
background described above makes you understand a bit better.

[...]

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
