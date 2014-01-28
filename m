From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/3] mmc: add support for power-on sequencing through DT
Date: Tue, 28 Jan 2014 11:06:38 +0100
Message-ID: <CAPDyKFpOhQtiyCmzie3=sfg42Vv5_rReRNgUf8kALoE6TBe2cw@mail.gmail.com>
References: <1390190215-22700-1-git-send-email-olof@lixom.net>
	<1390190215-22700-2-git-send-email-olof@lixom.net>
	<52DEBDA7.7030200@samsung.com>
	<52E54540.8080304@gmail.com>
	<CAPDyKFqpOLZiUSDvxVtYrBM8DtrZDLE27LKzyoWaf29Ni2vcFQ@mail.gmail.com>
	<52E700F0.7040708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f49.google.com ([209.85.216.49]:48968 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671AbaA1KGj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Jan 2014 05:06:39 -0500
Received: by mail-qa0-f49.google.com with SMTP id w8so172384qac.8
        for <linux-mmc@vger.kernel.org>; Tue, 28 Jan 2014 02:06:38 -0800 (PST)
In-Reply-To: <52E700F0.7040708@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Tomasz Figa <t.figa@samsung.com>, Olof Johansson <olof@lixom.net>, linux-mmc <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, robh+dt@kernel.org, mark.rutland@arm.com, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Chris Ball <chris@printf.net>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>

On 28 January 2014 01:59, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> On 27.01.2014 11:19, Ulf Hansson wrote:
>>
>> On 26 January 2014 18:26, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>>
>>> On 21.01.2014 19:34, Tomasz Figa wrote:
>>>>
>>>>
>>>> Hi,
>>>>
>>>> On 20.01.2014 04:56, Olof Johansson wrote:
>>>>>
>>>>>
>>>>> This patch enables support for power-on sequencing of SDIO peripherals
>>>>> through DT.
>>>>>
>>>>> In general, it's quite common that wifi modules and other similar
>>>>> peripherals have several signals in addition to the SDIO interface that
>>>>> needs wiggling before the module will power on. It's common to have a
>>>>> reference clock, one or several power rails and one or several lines
>>>>> for reset/enable type functions.
>>>>>
>>>>> The binding as written today introduces a number of reset gpios,
>>>>> a regulator and a clock specifier. The code will handle up to 2 gpio
>>>>> reset lines, but it's trivial to increase to more than that if needed
>>>>> at some point.
>>>>>
>>>>> Implementation-wise, the MMC core has been changed to handle this
>>>>> during
>>>>> host power up, before the host interface is powered on. I have not yet
>>>>> implemented the power-down side, I wanted people to have a chance for
>>>>> reporting back w.r.t. issues (or comments on the bindings) first.
>>>>>
>>>>> I have not tested the regulator portion, since the system and module
>>>>> I'm working on doesn't need one (Samsung Chromebook with Marvell
>>>>> 8797-based wifi). Testing of those portions (and reporting back) would
>>>>> be appreciated.
>>>>
>>>>
>>>>
>>>> While I fully agree that this is an important problem that needs to be
>>>> solved, I really don't think this is the right way, because:
>>>>
>>>> a) power-up sequence is really specific to the MMC device and often it's
>>>> not simply a matter of switching on one regulator or one clock, e.g.
>>>> specific time constraints need to be met.
>>>>
>>>> b) you can have WLAN chips in which SDIO is just one of the options to
>>>> use as host interface, which may be also HSIC, I2C or UART. Really. See
>>>> [1].
>>>>
>>>> c) this is leaking device specific details to generic host code, which
>>>> isn't really elegant.
>>>>
>>>> Now, to make this a bit more constructive, [2] is a solution that I came
>>>> up with (not perfect either), which simply adds a separate platform
>>>> device for the low level part of the chip. I believe this is a better
>>>> solution because:
>>>>
>>>> a) you can often see such WLAN/BT combo chip as a set of separate
>>>> devices, e.g. SDIO WLAN, UART BT and a simple PMIC or management IC,
>>>> which provides power/reset control, out of band signalling and etc. for
>>>> the first two, so it isn't that bad to have a separate device node for
>>>> the last one,
>>>>
>>>> b) you have full freedom of defining your DT binding with whatever data
>>>> you need, any number of clocks, regulators, GPIOs and even out of band
>>>> interrupts (IMHO the most important one).
>>>>
>>>> c) you can implement power-on, power-off sequences as needed for your
>>>> particular device,
>>>>
>>>> d) you have full separation of device-specific data from MMC core (or
>>>> any other subsystem simply used as a way to perform I/O to the chip).
>>>>
>>>> Now what's missing there is a way to signal the MMC core or any other
>>>> transport that a device showed up and the controller should be woken up
>>>> out of standby and scan of the bus initialized. This could be done by
>>>> explicitly specifying the device as a subnode of the
>>>> MMC/UART/USB(HSIC)/I2C or whatever with a link (phandle) to the power
>>>> controller of the chip or the other way around - a link to the
>>>> MMC/UART/... controller from the power controller node.
>>>
>>>
>>>
>>> I've looked a bit around MMC core code and got some basic idea how things
>>> look. I will definitely need some guidance, or at least some opinions,
>>> from
>>> MMC guys, as some MMC core changes are unavoidable.
>>>
>>> Now, the device-specific code is not really an issue, existing drivers
>>> usually already have their ways of powering the chips on and off, based
>>> on
>>> platform data. Everything needed here is to retrieve needed resources
>>> (GPIOs, clocks, regulators) using DT, which should be trivial.
>>>
>>> The worse part is the interaction between MMC and power controller driver
>>> (the platform driver part of WLAN driver, if you look at brcmfmac as an
>>> example). I believe that we need following things:
>>>
>>> a) A way to tell the MMC controller that there is no card detection
>>> mechanism available on given slot and it also should not be polling the
>>> slot
>>> to check card presence. Something like a "manual card detect" that would
>>> be
>>> triggered by another kernel entity that controls whether the MMC device
>>> is
>>> present (i.e. WLAN driver). We already have "broken-cd" property, but it
>>> only implies the former, wasting time on needless polling.
>>
>>
>> There is already a host capability that I think we could use to handle
>> this. MMC_CAP_NONREMOVABLE, the corresponding DT binding string is
>> "non-removable", and it may be set per host device.
>>
>> Using this cap means the mmc_rescan process that runs to detect new
>> cards, will only be executed once and during boot. So, we need to make
>> sure all resources and powers are provided to the card at this point.
>> Otherwise the card will not be detected.
>
>
> I don't quite like this requirement, especially if you consider
> multi-platform kernels where a lot of drivers is going to be provided as
> modules. WLAN drivers are especially good candidates. This means that even
> if the card is powered off at boot-up, if user (or init system) loads
> appropriate module, which powers the chip on, MMC core must be able to
> notice this.

To be able to detect the card, the WLAN driver doesn't have to be
probed, only the "power controller" driver. I suppose this is were it
becomes a bit tricky.

Somehow the mmc core needs to be involved in the probe process of the
power controller driver. Could perhaps the power controller bus be
located in the mmc core and thus the power controller driver needs to
register itself by using a new API from the mmc core? Similar how SDIO
func driver's register themselves.

I have one concern here though. Unless the SDIO func driver gets
probed, the SDIO card will be kept powered, which is not optimal from
a power management perspective.

To solve this, we need to change the policy about how to handle SDIO
cards after the initialization sequence (mmc_rescan) has been
completed. This will affect SDIO func driver's as well, since at the
moment those expects the card to be fully powered once they are being
probed.

>
>
>> In the SDIO case, to save power, the SDIO func driver may use runtime
>> PM to tell the mmc core power about whether the card needs to be
>> powered. Typically from the WLAN driver's probe() and "interface
>> up/down" the runtime PM reference for the SDIO func device, should be
>> adjusted with pm_runtime_get|put.
>
>
> I need to think a bit more about the power management control flow here. In
> case of such chips I'd tend to look at MMC merely as a host interface, which
> as I said, might be only one of available options. I'm not sure if it should
> be the host interface core that decides whether the whole device should be
> powered off. However there might be a solution that leverages SDIO func
> runtime PM, which wouldn't imply such control flow. Let me reconsider this.
>

Just to clarify things; it is not the "host interface" that decides
whether the whole device should be powered off. This is decided from
the SDIO func driver, by using runtime PM.

The "host interface" still needs to be in control of the power on/off
sequence, since the knowledge about the SDIO spec is required to
handle this.


>
>>
>>>
>>> b) A mechanism to bind the power controller to used MMC slot. Something
>>> like
>>> "mmc-bus = <&mmc2>;" property in device node of the power controller and
>>> a
>>> function like of_find_mmc_controller_by_node(), which would be an MMC
>>> counterpart of I2C's of_find_i2c_adapter_by_node(). To avoid races, it
>>> should probably take a reference on MMC host that would have to be
>>> dropped
>>> explicitly whenever it is not needed anymore.
>>
>>
>> I suppose an "MMC slot" can be translated to "MMC host"?
>
>
> Right.
>
>
>> What I am trying to understand is how the mmc core (or if we push it
>> to be handled from the mmc host's .set_ios callback) shall be able to
>> tell the power controller driver to enable/disable it's resources.
>> Somehow we need the struct device available to handle that. Then I
>> guess operating on it using runtime PM would be a solution that would
>> be quite nice!?
>
>
> As I wrote above, I'm not quite sure about this yet.
>
>
>>>
>>> c) A method to notify the MMC subsystem that card presence has changed.
>>> We
>>> already have something like this in drivers/mmc/core/slot-gpio.c, but
>>> used
>>> for a simple GPIO-based card detection. If the main part of
>>> mmc_gpio_cd_irqt() could be turned into an exported helper, e.g.
>>> mmc_force_card_detect(host) then basically we would have everything
>>> needed.
>>
>>
>> I am not sure I understand why this is needed. I think it would be
>> more convenient to use MMC_CAP_NONREMOVABLE instead as stated earlier.
>> But please elaborate, I might have missed something.
>
>
> See above. I'm not quite convinced that state of MMC interface should
> determine power state of the chip. I can easily imagine a situation where
> the MMC link is powered down (link power management) but the WLAN chip keeps
> operation. Keep in mind that those are usually complete SoCs that can keep
> processing network traffic autonomously and wake-up the application
> processor whenever anything interesting happens using extra out of bounds
> signalling, which might trigger re-enabling the MMC link.

Am not sure I understand what you mean with MMC link here.

We have the VCC regulator that the mmc host driver handles and the
resources by "power controller" driver. Do you want these to be
remained enabled during system suspend or are you saying we might need
even more fine grained power management?

Additionally, as Chris also pointed out in his reply; SDIO func
drivers can prevent the mmc core from powering off the card during
system suspend. Check for the flag, MMC_PM_KEEP_POWER in the code.

Kind regards
Uffe

>
>
>>>
>>> Unfortunately, I don't have more time left for today to create patches
>>> and
>>> test them, so for now, I'd like to hear opinion of MMC maintainers about
>>> this approach. Do you find this acceptable?
>>>
>>> By the way, it seems like slot-gpio.c could replace a lot of custom GPIO
>>> card detection code used in MMC host drivers, e.g. sdhci-s3c. Is there
>>> any
>>> reason why it couldn't?
>>
>>
>> I suppose most host driver's should convert to the slot-gpio API, it's
>> is just a matter of someone to send the patches. :-)
>
>
> OK, great. I'll add conversion of sdhci-s3c to my queue then.
>
> Best regards,
> Tomasz
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
