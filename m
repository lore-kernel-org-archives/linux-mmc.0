From: Mitch Bradley <wmb-D5eQfiDGL7eakBO8gow8eQ@public.gmane.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Tue, 21 Aug 2012 08:32:54 -1000
Message-ID: <5033D456.9040808@firmworks.com>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
 <CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
 <87k3ws5uhs.fsf@octavius.laptop.org> <201208211208.49987.arnd@arndb.de>
 <87393g5mic.fsf@octavius.laptop.org> <5033A34E.7040201@gmail.com>
 <87pq6k46jg.fsf@octavius.laptop.org> <5033B0F0.7050506@gmail.com>
 <CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Thomas Abraham <thomas.abraham-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 8/21/2012 7:33 AM, Thomas Abraham wrote:
> On 21 August 2012 21:31, Rob Herring <robherring2-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On 08/21/2012 10:18 AM, Chris Ball wrote:
>>> Hi,
>>>
>>> On Tue, Aug 21 2012, Rob Herring wrote:
>>>>> cd-gpios and cd-external can be present on the same node.  if broken-cd
>>>>> is present, it must be the only one of these nodes used.
>>>>
>>>> I don't see the point of cd-external. Either you just use the CD
>>>> interrupt defined within the SDHCI or you have a gpio line independent
>>>> of the SDHCI and use cd-gpios.
>>>
>>> You've described two of the possible cases, but not the third.  In the
>>> third case, you have a gpio line that is not independent of the SDHCI,
>>> because it is the SDHCI's CD pin brought out to be directly accessible
>>> via a GPIO.
>>
>> That is covered by absence of cd-gpios and broken-cd. Any *-gpios
>> property means the signal is a GPIO line controlled by a GPIO controller.
>>
>> I suppose you could have the CD state readable via the SDHCI, but the
>> interrupt comes from a GPIO controller. Or vice-versa, but that's a
>> pretty broken use case if you can't pick which way you are going to use
>> things.
>>
>>>
>>> The difference is in the handling of the interrupt -- if you don't have
>>> "cd-external" then you're just using the SDHCI's interrupt, but if you
>>> have an independent line then you're going to need to register your own
>>> IRQ handler on it, and "cd-external" signifies that.
>>>
>>> Thomas wrote this explanation earlier in the thread:
>>>> "samsung,sdhci-cd-gpio" means that the cd-gpio line is not connected
>>>> to the card-detect pad of the sdhci controller. Instead, it identifies
>>>> cd-gpio as a gpio pin, connected to the card-detect pin of the "card
>>>> slot" and it can used as a source of external interrupt. The driver
>>>> can register card insert/remove handler for this interrupt and get
>>>> notified about the changes in card state.
>>>>
>>>> "sdhci-cd-internal" means that the "cd-gpio" line is used to connect
>>>> the card-detect pin of the card slot and the card-detect pad of the
>>>> sdhci controller. The controller is then aware of any changes in card
>>>> state and the controller generates appropriate interrupts to notify
>>>> changes in card-state.
>>>
>>
>> It seems you are mixing pin muxing and who controls/handles the CD
>> detect signal. Pin muxing is a separate issue and should be addressed by
>> pin mux bindings. Either the signal functions as a GPIO or it functions
>> as a CD as part of the SDHCI. You may have muxing on the CD pin that
>> allows it to function either way, but the DT binding should describe how
>> you want it to be configured and used.
> 
> Ok, I agree with Rob. I was mixing pin muxing here. So if we have
> 'cd-gpios' and 'broken-cd' as generic bindings, would the following be
> valid?
> 
> [A] cd-gpios not present ,  broken-cd not present : This means that
> there is no card detect pin available. Controller drivers are free to
> infer this as "card detection is broken" and use implementation
> specific behavior.
> 
> [B] cd-gpio not present , broken-cd present :  This means that there
> is nothing connected to the card-detect pad of the mmc host
> controller. Controller drivers are free to use implementation specific
> behavior to deal with card detection.
> 
> [C] cd-gpio present, broken-cd not present : This means that 'cd-gpio'
> line connects card-detect pad of the controller to the card-detect pin
> of the mmc slot.
> 
> [D] cd-gpio present, broken-cd present : This means that there is
> nothing connected to the card-detect pad of the mmc host controller.
> Controller drivers are free to use the 'cd-gpio' line in any
> implementation specific way.


Matrix encoding is too complicated; my brain froze when trying to decode
the message above.  I favor properties that can be understood in
isolation.  The following proberties are mutually-exclusive.

<no properties present>: The standard SDHCI register bit just works.  No
additional setup is necessary (either the system is hardwired to work
correctly or external software has already done any necessary setup).

broken-cd <no value>: CD is just not available - neither via the
standard SDHCI register bit/interrupt, nor by an external GPIO.

cd-gpios <&gpio, active_low> : The standard SDHCI register bit does not
work, but CD is available via the specified GPIO.  If active_low is 0,
reading 1 from the GPIO pin means that the card is present, otherwise
reading 0 from the GPIO pin means that the card is present.  I must
emphasize that this is an external GPIO, accessed via GPIO mechanisms,
not a connection of a multipurpose pin to the SDHCI core.

cd-pin <&pin> : The standard SDHCI register bit works, but the SDHCI
driver must ask for the indicated multipurpose pin to be connected to
the SDHCI controller as the CD pin.  I don't know what &pin is, exactly,
as I haven't been paying attention to the pinmux discussions.


> 
> Thanks,
> Thomas.
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
