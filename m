From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Tue, 21 Aug 2012 10:03:42 -0500
Message-ID: <5033A34E.7040201@gmail.com>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org> <CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com> <87k3ws5uhs.fsf@octavius.laptop.org> <201208211208.49987.arnd@arndb.de> <87393g5mic.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <87393g5mic.fsf@octavius.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

On 08/21/2012 09:48 AM, Chris Ball wrote:
> Hi, adding Shawn and Wolfram,

snip...

> Rob Herring said:
>> This makes the most sense to me. However, I prefer broken-cd over
>> cd-internal. The binding should add properties for exceptions, not SDHCI
>> spec compliant implementations.
> 
> Agreed, I was going to say the same thing.  Putting it all together, it
> sounds like we want:
> 
> no extra properties:  the CD pin on the host just works.
> broken-cd:            the CD pin on the host is broken; use polling.
> cd-gpios:             the GPIO listed is the CD pin on the host being
>                       brought out directly to a GPIO.
> cd-external:          when used with cd-gpios, specifies that the GPIO
>                       in cd-gpios is external to the CD pin on the host.
> 
> cd-gpios and cd-external can be present on the same node.  if broken-cd
> is present, it must be the only one of these nodes used.

I don't see the point of cd-external. Either you just use the CD
interrupt defined within the SDHCI or you have a gpio line independent
of the SDHCI and use cd-gpios.

Rob
