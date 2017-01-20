From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3 2/3] mmc: sh_mobile_sdhi: explain clock bindings
Date: Fri, 20 Jan 2017 18:12:28 +0100
Message-ID: <CAPDyKFqCa_evsr3a_xHNy2joodgP9xiOQ1jdD0=nY-cGTWd_Hg@mail.gmail.com>
References: <20170118172502.13876-1-chris.brandt@renesas.com>
 <20170118172502.13876-3-chris.brandt@renesas.com> <CAPDyKFq9psGMnKUx+SM_QGt6OKoMHgNFop6ANagtLOLwsMTT8w@mail.gmail.com>
 <SG2PR06MB1165B5BF4296DB866F3D418B8A710@SG2PR06MB1165.apcprd06.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <SG2PR06MB1165B5BF4296DB866F3D418B8A710@SG2PR06MB1165.apcprd06.prod.outlook.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms@verge.net.au>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 20 January 2017 at 17:05, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> Hello Ulf,
>
> Friday, January 20, 2017, Ulf Hansson wrote:
>> > +- clocks: Most controllers only have 1 clock source per channel.
>> However, some
>> > +         have a second clock dedicated to card detection. If 2 clocks
>> are
>> > +         specified, you must name them as "core" and "cd". If the
>> controller
>> > +         only has 1 clock, naming is not required.
>>
>> Could you please elaborate a bit on the card detection clock?
>>
>> I guess that there is some kind of internal card detection logic (native
>> card detect) in the SDHI IP, which requires a separate clock for it to
>> work? Perhaps you can state that somehow?
>
>
> The reality is that the chip guys cut up the standard SDHI IP to add a
> 'cool new feature', but all I want to do is put it back the way it was.
>
> NOTE: The design guys like to reuse IP blocks from previous designs that they
> know worked and didn't have bugs. So, there is a good chance you will see this
> change in future RZ/A devices (or even other future Renesas SoC devices).
> To remove an unwanted feature adds additional design risk of breaking
> something else....and given the cost of redoing silicon mask layers...no
> engineer wants that mistake on their hands.

So, one should be aware of that runtime PM support in these case is
going to be suboptimal.
For example, when using this native card detect, you will need to keep
the controller runtime PM resumed as the be able to keep the clock on
and to be able to fetch the irq. Wasting power.

Most SoC vendors are therefore using a GPIO card detect instead,
although I assume you already knew that. :-)

[...]

Kind regards
Uffe
