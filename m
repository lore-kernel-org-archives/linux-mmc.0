From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Tue, 21 Aug 2012 23:03:59 +0530
Message-ID: <CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA@mail.gmail.com>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
	<87k3ws5uhs.fsf@octavius.laptop.org>
	<201208211208.49987.arnd@arndb.de>
	<87393g5mic.fsf@octavius.laptop.org>
	<5033A34E.7040201@gmail.com>
	<87pq6k46jg.fsf@octavius.laptop.org>
	<5033B0F0.7050506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5033B0F0.7050506@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

On 21 August 2012 21:31, Rob Herring <robherring2@gmail.com> wrote:
> On 08/21/2012 10:18 AM, Chris Ball wrote:
>> Hi,
>>
>> On Tue, Aug 21 2012, Rob Herring wrote:
>>>> cd-gpios and cd-external can be present on the same node.  if broken-cd
>>>> is present, it must be the only one of these nodes used.
>>>
>>> I don't see the point of cd-external. Either you just use the CD
>>> interrupt defined within the SDHCI or you have a gpio line independent
>>> of the SDHCI and use cd-gpios.
>>
>> You've described two of the possible cases, but not the third.  In the
>> third case, you have a gpio line that is not independent of the SDHCI,
>> because it is the SDHCI's CD pin brought out to be directly accessible
>> via a GPIO.
>
> That is covered by absence of cd-gpios and broken-cd. Any *-gpios
> property means the signal is a GPIO line controlled by a GPIO controller.
>
> I suppose you could have the CD state readable via the SDHCI, but the
> interrupt comes from a GPIO controller. Or vice-versa, but that's a
> pretty broken use case if you can't pick which way you are going to use
> things.
>
>>
>> The difference is in the handling of the interrupt -- if you don't have
>> "cd-external" then you're just using the SDHCI's interrupt, but if you
>> have an independent line then you're going to need to register your own
>> IRQ handler on it, and "cd-external" signifies that.
>>
>> Thomas wrote this explanation earlier in the thread:
>>> "samsung,sdhci-cd-gpio" means that the cd-gpio line is not connected
>>> to the card-detect pad of the sdhci controller. Instead, it identifies
>>> cd-gpio as a gpio pin, connected to the card-detect pin of the "card
>>> slot" and it can used as a source of external interrupt. The driver
>>> can register card insert/remove handler for this interrupt and get
>>> notified about the changes in card state.
>>>
>>> "sdhci-cd-internal" means that the "cd-gpio" line is used to connect
>>> the card-detect pin of the card slot and the card-detect pad of the
>>> sdhci controller. The controller is then aware of any changes in card
>>> state and the controller generates appropriate interrupts to notify
>>> changes in card-state.
>>
>
> It seems you are mixing pin muxing and who controls/handles the CD
> detect signal. Pin muxing is a separate issue and should be addressed by
> pin mux bindings. Either the signal functions as a GPIO or it functions
> as a CD as part of the SDHCI. You may have muxing on the CD pin that
> allows it to function either way, but the DT binding should describe how
> you want it to be configured and used.

Ok, I agree with Rob. I was mixing pin muxing here. So if we have
'cd-gpios' and 'broken-cd' as generic bindings, would the following be
valid?

[A] cd-gpios not present ,  broken-cd not present : This means that
there is no card detect pin available. Controller drivers are free to
infer this as "card detection is broken" and use implementation
specific behavior.

[B] cd-gpio not present , broken-cd present :  This means that there
is nothing connected to the card-detect pad of the mmc host
controller. Controller drivers are free to use implementation specific
behavior to deal with card detection.

[C] cd-gpio present, broken-cd not present : This means that 'cd-gpio'
line connects card-detect pad of the controller to the card-detect pin
of the mmc slot.

[D] cd-gpio present, broken-cd present : This means that there is
nothing connected to the card-detect pad of the mmc host controller.
Controller drivers are free to use the 'cd-gpio' line in any
implementation specific way.

Thanks,
Thomas.
