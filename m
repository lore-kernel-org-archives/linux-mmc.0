From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 08/12] doc: binding: pwrseq-usb-generic: add binding doc
 for generic usb power sequence driver
Date: Fri, 24 Jun 2016 10:25:05 -0500
Message-ID: <CAL_Jsq+1r0r1NONoyeU5=jSJR9tEV=1rN8CidWroqA+a_OrYAw@mail.gmail.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
 <1466158165-9380-9-git-send-email-peter.chen@nxp.com> <CAL_JsqLvs0s2TyfqPM5vtmyY81_X84VjCGjsGYbTgT4syOfp9Q@mail.gmail.com>
 <20160620112651.GA26936@shlinux2> <20160620161607.GA11427@rob-hp-laptop>
 <20160621021117.GD26936@shlinux2> <20160621212653.GA22764@rob-hp-laptop> <CAPDyKFroH6AGObKGZoZ-6=Sb3Zii6gXdm_wO3fuc2BAx6fpFHg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFroH6AGObKGZoZ-6=Sb3Zii6gXdm_wO3fuc2BAx6fpFHg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Peter Chen <hzpeterchen@gmail.com>, Peter Chen <peter.chen@nxp.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Stephen Boyd <stephen.boyd@linaro.org>, oscar@naiandei.net, Arnd Bergmann <arnd@arndb.de>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Linux USB List <linux-usb@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, troy.kisky@boundarydevices.com, Javier Martinez Canillas <javier@osg.samsung.com>, Philipp Zabel <p.zabel@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jun 22, 2016 at 4:09 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 21 June 2016 at 23:26, Rob Herring <robh@kernel.org> wrote:
>> On Tue, Jun 21, 2016 at 10:11:17AM +0800, Peter Chen wrote:
>>> On Mon, Jun 20, 2016 at 11:16:07AM -0500, Rob Herring wrote:
>>> > On Mon, Jun 20, 2016 at 07:26:51PM +0800, Peter Chen wrote:
>>> > > On Fri, Jun 17, 2016 at 12:16:48PM -0500, Rob Herring wrote:
>>> > > > On Fri, Jun 17, 2016 at 5:09 AM, Peter Chen <peter.chen@nxp.com> wrote:
>>> > > > > Add binding doc for generic usb power sequence driver, and update
>>> > > > > generic usb device binding-doc accordingly.
>>
>> [...]
>>
>>> > >           clocks = <&clks IMX6SX_CLK_CKO>;
>>> > >
>>> > >           #address-cells = <1>;
>>> > >           #size-cells = <0>;
>>> > >           ethernet: asix@1 {
>>> > >                   compatible = "usbb95,1708";
>>> > >                   reg = <1>;
>>> > >
>>> > >                   power-sequence;
>>> > >                   reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* ethernet_rst */
>>> > >                   reset-duration-us = <15>;
>>> > >                   clocks = <&clks IMX6SX_CLK_IPG>;
>>> > >           };
>>> > >   };
>>> > > };
>>> > >
>>> > > If the node has property "power-sequence", the pwrseq core will create
>>> > > related platform device, and the driver under pwrseq driver will handle
>>> > > power sequence stuffs.
>>> >
>>> > This I have issue with. If you are creating a platform device here, you
>>> > are trying to work-around limitations in the linux driver model.
>
> I somewhat understand your point.
>
> Although, having the option to use a driver (which requires a device)
> has turned out to be quite convenient from many aspects - at least in
> the mmc case.
>
> Certainly one can do without it, but in the end using a driver avoids
> open coding.

Why would it be open coded? Just create library functions to parse the
node and implement the generic pwr-seq steps.

>>> My current solution like below, but it seems you didn't agree with that.
>>> I just double confirm here, if you don't, I give up the solution for
>>> using generic power sequence framework.
>>>
>>> In drivers/usb/core/hub.c
>>>
>>>       for_each_child_of_node(parent->of_node, node) {
>>>               hdev_pwrseq = pwrseq_alloc(node, "usb_pwrseq_generic");
>>>               if (!IS_ERR_OR_NULL(hdev_pwrseq)) {
>>>                       pwrseq_node = kzalloc(sizeof(pwrseq_node), GFP_KERNEL);
>>>                       if (!pwrseq_node) {
>>>                               ret = -ENOMEM;
>>>                               goto err1;
>>>                       }
>>>                       /* power on sequence */
>>>                       ret = pwrseq_pre_power_on(hdev_pwrseq);
>>
>> Why does this function need to do anything more than:
>>
>> - Check if the child has a "power-sequence" property
>> - Get the "reset-gpios" GPIO
>> - Assert reset for specified/default time
>> - Deassert reset
>>
>> Then continue on as normal. That seems straight-forward to me.
>>
>> There is no reason you need a platform device in the mix. Perhaps trying
>> to move the MMC pwr-seq code is pointless as it adds needless
>> complexity.
>
> Complexity?
>
> The problem we are tying to solve, is to make the various platform/SoC
> specific power sequences to be able to live in generic drivers.
>
> One could decide to encode the sequences inside the driver code
> itself, but it will soon turn into a mess and more importantly, lots
> of open coding as to support different platforms/SoCs. To most kernel
> hackers I don't think this is an option to consider.

I'm not proposing open coding, but having generic library functions.
I'm not saying the mmc pwr-seq has to change from being a driver
either. Leave it as is. I'm only talking about Krzysztof's new
proposal.

> The MMC pwr-seq code/drivers tries to address these issues - in a
> somewhat generic way.
> Initially we have decided to start with only a few flavours of
> supported sequences and so far these have been sufficient.

Only a few because we've pushed back against defining state machines in DT.

> Finally, I am indeed concerned that it so hard to agree on a solution
> to deal with generic power sequences. There have been many attempts
> throughout the last ~4-5 years, but peoples strong opinions about
> different approaches mad them all fail. Isn't it time to finally just
> pick a solution and stick with it, even if it doesn't meet all peoples
> expectations?

No. I'm pretty that is not how kernel development works. Features get
merged when all are happy (or not paying attention).

>From what I recall, all attempts have worked around the problem that
the driver model has no way to either force probe or provide a
pre-probe hook on probeable buses. This then leads to the work-around
defining the DT binding.

Rob
