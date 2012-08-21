From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Tue, 21 Aug 2012 20:51:44 +0530
Message-ID: <CAJuYYwSNMvCctp2A7bizwXX7zMuSo64_9_Z4RUKLBZHRV4oSvA@mail.gmail.com>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
	<87k3ws5uhs.fsf@octavius.laptop.org>
	<201208211208.49987.arnd@arndb.de>
	<87393g5mic.fsf@octavius.laptop.org>
	<5033A34E.7040201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <5033A34E.7040201@gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

On 21 August 2012 20:33, Rob Herring <robherring2@gmail.com> wrote:
> On 08/21/2012 09:48 AM, Chris Ball wrote:
>> Hi, adding Shawn and Wolfram,
>
> snip...
>
>> Rob Herring said:
>>> This makes the most sense to me. However, I prefer broken-cd over
>>> cd-internal. The binding should add properties for exceptions, not SDHCI
>>> spec compliant implementations.
>>
>> Agreed, I was going to say the same thing.  Putting it all together, it
>> sounds like we want:
>>
>> no extra properties:  the CD pin on the host just works.
>> broken-cd:            the CD pin on the host is broken; use polling.
>> cd-gpios:             the GPIO listed is the CD pin on the host being
>>                       brought out directly to a GPIO.
>> cd-external:          when used with cd-gpios, specifies that the GPIO
>>                       in cd-gpios is external to the CD pin on the host.
>>
>> cd-gpios and cd-external can be present on the same node.  if broken-cd
>> is present, it must be the only one of these nodes used.
>
> I don't see the point of cd-external. Either you just use the CD
> interrupt defined within the SDHCI or you have a gpio line independent
> of the SDHCI and use cd-gpios.

There should be way to distinguish between the two types of 'cd-gpios' value.

(A) a 'cd-gpios' line that connects the card-detect pin of the mmc
physical slot to the card-detect pad to the mmc host controller.

(B) a 'cd-gpios' line that is connected to the card-detect pin of the
slot but not to the card-detect pad of the mmc host controller (used
either as gpio interrupt or polled gpio line).

So the binding 'cd-external' can act as an additional qualifier to
value of 'cd-gpios' to represent the second type. Hence, the bindings
proposed by Chris does support all the possible combinations of
card-detection used by the Samsung sdhci controller driver.

Thanks,
Thomas.





>
> Rob
>
