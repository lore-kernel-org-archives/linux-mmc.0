From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: Re: [PATCH] mmc: dt: Add 'broken-cd' DT binding
Date: Wed, 22 Aug 2012 16:21:33 +0530
Message-ID: <CAJuYYwQz00ZzB5MxRG66XEPZApAtS6bwJAafmw3b=7DD7u+Crg@mail.gmail.com>
References: <1345547371-6784-1-git-send-email-thomas.abraham@linaro.org>
	<CAJuYYwSv+dum8RP9xy+AZCH9pTU0peDpwjt7TA5zn3MFsG1uWA@mail.gmail.com>
	<87k3ws5uhs.fsf@octavius.laptop.org>
	<201208211208.49987.arnd@arndb.de>
	<87393g5mic.fsf@octavius.laptop.org>
	<5033A34E.7040201@gmail.com>
	<87pq6k46jg.fsf@octavius.laptop.org>
	<5033B0F0.7050506@gmail.com>
	<CAJuYYwR+oCQUcgoy6ZuHp0XAa+EAj9d-FvLtwsQcP3muFMrKLA@mail.gmail.com>
	<20120822055151.GT24242@S2101-09.ap.freescale.net>
	<877gsr5iz1.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <877gsr5iz1.fsf@octavius.laptop.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Shawn Guo <shawn.guo@linaro.org>, Rob Herring <robherring2@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org, grant.likely@secretlab.ca, patches@linaro.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

On 22 August 2012 15:47, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Wed, Aug 22 2012, Shawn Guo wrote:
>> The following is what I have on my mind.
>>
>> broken-cd     cd-gpios        implication
>> -------------------------------------------
>> no            no              SDHCI CD
>> no            yes             GPIO CD
>> yes           no              NO CD / Broken CD
>> yes           yes             Invalid
>>
>> yes: property presents
>> no: property does not present
>
> This matches Mitch's last suggestion exactly -- I think we're all agreed
> on these properties now.  The only remaining question is how to handle
> the pinctrl for CD in Thomas's case.

Hi Chris,

For sdhci-s3c driver, the 'broken-cd' and 'cd-gpios' bindings are
sufficient. But, are drivers free to use implementation specific
behavior when using these bindings. Or do we strictly adhere to the
table which Shawn has listed. For sdhci-s3c driver, I would like to
deviate from the "implication" column listed above.

On second thoughts, I now understand that gpio's terminate at the gpio
controller, not at the card-detect pad of the mmc host controller.
Those that terminate at the mmc controller pads are actually mux
functions. I do agree that the long term solution for sdhci-s3c driver
is to use the pinctrl driver.

If sdhci-s3c has to strictly adhere to the Shawn's table above, then I
prefer to postpone the device tree support in sdhci-s3c driver after
having proper support for Samsung pinctrl driver. But then, sdhci-s3c
driver is used on multiple Samsung SoC's, all of which might not get
pinctrl driver support anytime soon.

Hence, for sdhci-s3c driver, 'broken-cd' and 'cd-gpios' bindings are
sufficient, but sdhci-s3c driver should be free to use these bindings
in a implementation specific way.

Thanks,
Thomas.
