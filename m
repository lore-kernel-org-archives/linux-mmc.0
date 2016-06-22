From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 08/12] doc: binding: pwrseq-usb-generic: add binding doc
 for generic usb power sequence driver
Date: Wed, 22 Jun 2016 11:09:13 +0200
Message-ID: <CAPDyKFroH6AGObKGZoZ-6=Sb3Zii6gXdm_wO3fuc2BAx6fpFHg@mail.gmail.com>
References: <1466158165-9380-1-git-send-email-peter.chen@nxp.com>
 <1466158165-9380-9-git-send-email-peter.chen@nxp.com> <CAL_JsqLvs0s2TyfqPM5vtmyY81_X84VjCGjsGYbTgT4syOfp9Q@mail.gmail.com>
 <20160620112651.GA26936@shlinux2> <20160620161607.GA11427@rob-hp-laptop>
 <20160621021117.GD26936@shlinux2> <20160621212653.GA22764@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160621212653.GA22764@rob-hp-laptop>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Peter Chen <hzpeterchen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Stephen Boyd <stephen.boyd-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, oscar-Bdbr4918Nnnk1uMJSBkQmQ@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Linux USB List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Maciej S. Szmigiero" <mail-APzI5cXaD1zVlRWJc41N0YvC60bnQu0Y@public.gmane.org>, troy.kisky-Q5RJGjKts06CY9SHAMCTRUEOCMrvLtNR@public.gmane.org, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 21 June 2016 at 23:26, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Jun 21, 2016 at 10:11:17AM +0800, Peter Chen wrote:
>> On Mon, Jun 20, 2016 at 11:16:07AM -0500, Rob Herring wrote:
>> > On Mon, Jun 20, 2016 at 07:26:51PM +0800, Peter Chen wrote:
>> > > On Fri, Jun 17, 2016 at 12:16:48PM -0500, Rob Herring wrote:
>> > > > On Fri, Jun 17, 2016 at 5:09 AM, Peter Chen <peter.chen-3arQi8VN3Tc@public.gmane.org> wrote:
>> > > > > Add binding doc for generic usb power sequence driver, and update
>> > > > > generic usb device binding-doc accordingly.
>
> [...]
>
>> > >           clocks = <&clks IMX6SX_CLK_CKO>;
>> > >
>> > >           #address-cells = <1>;
>> > >           #size-cells = <0>;
>> > >           ethernet: asix@1 {
>> > >                   compatible = "usbb95,1708";
>> > >                   reg = <1>;
>> > >
>> > >                   power-sequence;
>> > >                   reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>; /* ethernet_rst */
>> > >                   reset-duration-us = <15>;
>> > >                   clocks = <&clks IMX6SX_CLK_IPG>;
>> > >           };
>> > >   };
>> > > };
>> > >
>> > > If the node has property "power-sequence", the pwrseq core will create
>> > > related platform device, and the driver under pwrseq driver will handle
>> > > power sequence stuffs.
>> >
>> > This I have issue with. If you are creating a platform device here, you
>> > are trying to work-around limitations in the linux driver model.

I somewhat understand your point.

Although, having the option to use a driver (which requires a device)
has turned out to be quite convenient from many aspects - at least in
the mmc case.

Certainly one can do without it, but in the end using a driver avoids
open coding.

>>
>> My current solution like below, but it seems you didn't agree with that.
>> I just double confirm here, if you don't, I give up the solution for
>> using generic power sequence framework.
>>
>> In drivers/usb/core/hub.c
>>
>>       for_each_child_of_node(parent->of_node, node) {
>>               hdev_pwrseq = pwrseq_alloc(node, "usb_pwrseq_generic");
>>               if (!IS_ERR_OR_NULL(hdev_pwrseq)) {
>>                       pwrseq_node = kzalloc(sizeof(pwrseq_node), GFP_KERNEL);
>>                       if (!pwrseq_node) {
>>                               ret = -ENOMEM;
>>                               goto err1;
>>                       }
>>                       /* power on sequence */
>>                       ret = pwrseq_pre_power_on(hdev_pwrseq);
>
> Why does this function need to do anything more than:
>
> - Check if the child has a "power-sequence" property
> - Get the "reset-gpios" GPIO
> - Assert reset for specified/default time
> - Deassert reset
>
> Then continue on as normal. That seems straight-forward to me.
>
> There is no reason you need a platform device in the mix. Perhaps trying
> to move the MMC pwr-seq code is pointless as it adds needless
> complexity.

Complexity?

The problem we are tying to solve, is to make the various platform/SoC
specific power sequences to be able to live in generic drivers.

One could decide to encode the sequences inside the driver code
itself, but it will soon turn into a mess and more importantly, lots
of open coding as to support different platforms/SoCs. To most kernel
hackers I don't think this is an option to consider.

The MMC pwr-seq code/drivers tries to address these issues - in a
somewhat generic way.
Initially we have decided to start with only a few flavours of
supported sequences and so far these have been sufficient.

Finally, I am indeed concerned that it so hard to agree on a solution
to deal with generic power sequences. There have been many attempts
throughout the last ~4-5 years, but peoples strong opinions about
different approaches mad them all fail. Isn't it time to finally just
pick a solution and stick with it, even if it doesn't meet all peoples
expectations?

[...]

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
