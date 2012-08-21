From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Tue, 21 Aug 2012 10:48:43 -0400
Message-ID: <87393g5mic.fsf@octavius.laptop.org>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
	<87k3ws5uhs.fsf@octavius.laptop.org>
	<201208211208.49987.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <201208211208.49987.arnd@arndb.de> (Arnd Bergmann's message of
	"Tue, 21 Aug 2012 12:08:49 +0000")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Abraham <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, patches@linaro.org, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

Hi, adding Shawn and Wolfram,

On Tue, Aug 21 2012, Arnd Bergmann wrote:
> On Tuesday 21 August 2012, Chris Ball wrote:
>> How about this?
>> 
>> broken-cd: No CD available, use polling.
>> 
>> cd-gpios: The CD pin on the host is working and brought out to a GPIO.
>> 
>> external-cd-gpios: The CD pin on the host is broken, but there's an
>>                    independent external GPIO available.
>> 
>> 
>> (Each host should only have one of these properties.)
>
> The fsl-imx-esdhc.txt binding already has all three cases, but
> describes them differently:
>
> fsl,cd-internal: when present, the CD pin on the host is working
> cd-gpios: when present, contains the gpio line that CD is connected to
> If both are absent, it has to use polling.

Aside: the bindings do not match the code.  The bindings document says
to use "fsl,cd-internal", and imx51-babbage.dts does so -- but the code
doesn't check for "fsl,cd-internal", it checks for "fsl,cd-controller":

        if (of_get_property(np, "fsl,cd-controller", NULL))
                boarddata->cd_type = ESDHC_CD_CONTROLLER;

The same confusion is present for fsl,wp-{controller,internal}.

Ignoring that, these bindings are similar, but not the same -- imx-esdhc
only allows one of the cd_type cases to be true, so you either have
cd-internal or you have cd-gpios:

        if (of_get_property(np, "fsl,cd-controller", NULL))
                boarddata->cd_type = ESDHC_CD_CONTROLLER;

        boarddata->cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
        if (gpio_is_valid(boarddata->cd_gpio))
                boarddata->cd_type = ESDHC_CD_GPIO;

This differs from Thomas's binding -- he wants a way to say "the cd-gpio
mentioned in cd-gpios is [internal/external] to the card's CD pin".

Rob Herring said:
> This makes the most sense to me. However, I prefer broken-cd over
> cd-internal. The binding should add properties for exceptions, not SDHCI
> spec compliant implementations.

Agreed, I was going to say the same thing.  Putting it all together, it
sounds like we want:

no extra properties:  the CD pin on the host just works.
broken-cd:            the CD pin on the host is broken; use polling.
cd-gpios:             the GPIO listed is the CD pin on the host being
                      brought out directly to a GPIO.
cd-external:          when used with cd-gpios, specifies that the GPIO
                      in cd-gpios is external to the CD pin on the host.

cd-gpios and cd-external can be present on the same node.  if broken-cd
is present, it must be the only one of these nodes used.

Shawn, I guess I'll leave it up to you on whether/when you'd like to
move away from the "fsl," properties to the new common ones?

If this looks okay to everyone, I'll send a patch soon.

Thanks!

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
