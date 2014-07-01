From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC 1/2] pwrseq: Add subsystem to handle complex power sequences
Date: Tue, 1 Jul 2014 18:42:51 +0200
Message-ID: <CAPDyKFqi2NH1r=Q13iOu2ruuvaj1xJeoERiy2WJBVbQ2b1tc_A@mail.gmail.com>
References: <1403183091-27876-1-git-send-email-ulf.hansson@linaro.org>
	<1403183091-27876-2-git-send-email-ulf.hansson@linaro.org>
	<CAOesGMj6xp_cXZRuqL5HOPX4AeDuCkj69E32xuPVgGk4xABLbQ@mail.gmail.com>
	<53A3E256.8090307@redhat.com>
	<CAOesGMgRw_=ppC3zhDtuYBUsrnd9wwsu26az=4kMXJDBmNgmjw@mail.gmail.com>
	<53A3ED65.80605@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53A3ED65.80605-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 20 June 2014 10:14, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> Hi,
>
> On 06/20/2014 10:02 AM, Olof Johansson wrote:
>> On Fri, Jun 20, 2014 at 12:27 AM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>> Hi,
>>>
>>> On 06/19/2014 07:18 PM, Olof Johansson wrote:
>>>> Hi,
>>>>
>>>>
>>>>
>>>> On Thu, Jun 19, 2014 at 6:04 AM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>>>>> The pwrseq subsystem handles complex power sequences, typically useful
>>>>> for subsystems that makes use of discoverable buses, like for example
>>>>> MMC and I2C.
>>>>>
>>>>> The pwrseq subsystem is dependant on CONFIG_OF to be able to parse a DT
>>>>> childnode to find out what power sequence method to bind for a device.
>>>>>
>>>>> From the DT childnode, the pwrseq DT parser tries to locate a
>>>>> "power-method" property, which string is matched towards the list of
>>>>> supported pwrseq methods.
>>>>>
>>>>> Each pwrseq method implements it's own power sequence and interfaces
>>>>> the pwrseq core through a few callback functions.
>>>>>
>>>>> To instantiate a pwrseq method, clients shall use the devm_pwrseq_get()
>>>>> API. If needed, clients can explicity drop the references to a pwrseq
>>>>> method using devm_pwrseq_put() API.
>>>>>
>>>>> Besides instantiation, the pwrseq API provides clients opportunity to
>>>>> select a certain power state. In this intial version, PWRSEQ_POWER_ON
>>>>> and PWRSEQ_POWER_OFF are supported. Those are also mandatory for each
>>>>> pwrseq method to support.
>>>>>
>>>>> Signed-off-by: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>> ---
>>>>>  .../devicetree/bindings/pwrseq/pwrseq.txt          |   48 ++++++
>>>>>  drivers/Makefile                                   |    2 +-
>>>>>  drivers/pwrseq/Makefile                            |    2 +
>>>>>  drivers/pwrseq/core.c                              |  175 ++++++++++++++++++++
>>>>>  drivers/pwrseq/core.h                              |   37 +++++
>>>>>  drivers/pwrseq/method.c                            |   38 +++++
>>>>>  include/linux/pwrseq.h                             |   50 ++++++
>>>>>  7 files changed, 351 insertions(+), 1 deletion(-)
>>>>>  create mode 100644 Documentation/devicetree/bindings/pwrseq/pwrseq.txt
>>>>>  create mode 100644 drivers/pwrseq/Makefile
>>>>>  create mode 100644 drivers/pwrseq/core.c
>>>>>  create mode 100644 drivers/pwrseq/core.h
>>>>>  create mode 100644 drivers/pwrseq/method.c
>>>>>  create mode 100644 include/linux/pwrseq.h
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/pwrseq/pwrseq.txt b/Documentation/devicetree/bindings/pwrseq/pwrseq.txt
>>>>> new file mode 100644
>>>>> index 0000000..80848ae
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/pwrseq/pwrseq.txt
>>>>> @@ -0,0 +1,48 @@
>>>>> +Power sequence DT bindings
>>>>> +
>>>>> +Each power sequence method has a corresponding "power-method" property string.
>>>>> +This property shall be set in a subnode for a device. That subnode should also
>>>>> +describe resourses which are specific to that power method.
>>>>> +
>>>>> +Do note, power sequences as such isn't encoded through DT. Instead those are
>>>>> +implemented by each power method.
>>>>> +
>>>>> +Required subnode properties:
>>>>> +- power-method: should contain the string for the power method to bind.
>>>>> +
>>>>> +       Supported power methods: None.
>>>>> +
>>>>> +Example:
>>>>> +
>>>>> +Note, the "clock" power method in this example isn't actually supported, but
>>>>> +used to visualize how a childnode could be described.
>>>>> +
>>>>> +// WLAN SDIO channel
>>>>> +sdi1_per2@80118000 {
>>>>> +       compatible = "arm,pl18x", "arm,primecell";
>>>>> +       reg = <0x80118000 0x1000>;
>>>>> +       interrupts = <0 50 IRQ_TYPE_LEVEL_HIGH>;
>>>>> +
>>>>> +       dmas = <&dma 32 0 0x2>, /* Logical - DevToMem */
>>>>> +              <&dma 32 0 0x0>; /* Logical - MemToDev */
>>>>> +       dma-names = "rx", "tx";
>>>>> +
>>>>> +       clocks = <&prcc_kclk 2 4>, <&prcc_pclk 2 6>;
>>>>> +       clock-names = "sdi", "apb_pclk";
>>>>> +
>>>>> +       arm,primecell-periphid = <0x10480180>;
>>>>> +       max-frequency = <100000000>;
>>>>> +       bus-width = <4>;
>>>>> +       non-removable;
>>>>> +       pinctrl-names = "default", "sleep";
>>>>> +       pinctrl-0 = <&sdi1_default_mode>;
>>>>> +       pinctrl-1 = <&sdi1_sleep_mode>;
>>>>> +
>>>>> +       status = "okay";
>>>>> +
>>>>> +       pwrseq: pwrseq1 {
>>>>> +               power-method = "clock";
>>>>> +               clocks = <&someclk 1 2>, <&someclk 3 4>;
>>>>> +               clock-names = "pwrseq1", "pwrseq2";
>>>>> +       };
>>>>
>>>> I am strongly against the subnode approach as a general framework. We
>>>> don't have a subnode for interrupts, nor for clocks or pinctrl. So why
>>>> should we have it for the power sequencing?
>>>>
>>>> Sure, that fits the linux driver model better, but that's irrelevant
>>>> w.r.t. describing the hardware.
>>>
>>> Actually this is about describing the hardware, when you have e.g. an
>>> mmc device which needs pwrseq, there will be 2 sets of certain
>>> resources, ie clocks for the host controller and clocks going directly
>>> to the mmc device. I think putting those both in the same subnode is
>>> a BAD idea, so we really do need a subnode to group the pwrseq resources
>>> together.
>>
>> I disagree.
>>
>> The clock is the input to the module, and it is what needs to be
>> enabled for the module to work. It's not the input to some
>> power-sequence component on the module, or next to the module on the
>> bus.
>
> Right, it is an input to the sdio-module, not to the mmc-host, so its an
> input to a different piece of hardware (at different ends of the mmc bus),
> but since the mmc-bus normally is fully discoverable we've no node for the
> other end of the bus.
>
> So from the mmc-host pov, which is the one which needs to bind the pwrseq
> driver, as that needs to be done before it can probe its bus, this is
> a different piece of hardware, hence a subnode to the host makes perfect
> sense.  This is in no way part of the host, so certainly it does not belong
> inside the hosts subnode.

I fully agree with you Hans here.

If we were to put this information in the host's DT node, that would
be a wrong description of the hardware. Currently, I can't think of
anything better than a subnode, but I am open to suggestions.

Kind regards
Uffe

>
>> It probably makes sense to not use the standard names for the new
>> resources.
>
> I disagree, being able to use standard names is very useful, and actually
> is a must if we don't want to have to have special versions of devm_get_clk,
> and all other devm_get_xxx esp. for pwrseq stuff.
>
> Regards,
>
> Hans
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
