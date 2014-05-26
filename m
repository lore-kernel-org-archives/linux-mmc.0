From: Arend van Spriel <arend@broadcom.com>
Subject: Re: RFC: representing sdio devices oob interrupt, clks, etc. in device
 tree
Date: Mon, 26 May 2014 11:08:01 +0200
Message-ID: <53830471.3040301@broadcom.com>
References: <537DC832.3020006@redhat.com> <CAGb2v64VZac2KvAALrScecN89sRnBQoDrKxKMvkte+3G04NXeA@mail.gmail.com> <537DE1AA.5050606@redhat.com> <537E31F7.1030505@gmail.com> <537F1148.3010102@redhat.com> <20140523112239.GB12304@sirena.org.uk> <537F3610.3050104@redhat.com> <20140523162718.GE22111@sirena.org.uk> <53806F26.6050706@redhat.com> <20140525123452.GS22111@sirena.org.uk> <53824294.1090609@redhat.com> <5382F276.8090305@broadcom.com> <CAGb2v64Siixnds9fXGWfTotjq0zGmeqNa-52FNNOcbxFcCjkCg@mail.gmail.com> <5382F651.9010506@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:47819 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751548AbaEZJIH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 May 2014 05:08:07 -0400
In-Reply-To: <5382F651.9010506@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc <linux-mmc@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>, Olof Johansson <olof@lixom.net>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Fabio Estevam <festevam@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jyri Sarha <jsarha@ti.com>

On 05/26/14 10:07, Hans de Goede wrote:
> Hi,
>
> On 05/26/2014 09:59 AM, Chen-Yu Tsai wrote:
>> On Mon, May 26, 2014 at 3:51 PM, Arend van Spriel<arend@broadcom.com>  wrote:
>>> + Russell
>
> <snip>
>
>>> Hi Hans,
>>>
>>> I recalled a recent patchset from Russell King. He was working on i.MX6
>>> platform with brcmfmac device and ended reworking sdhci/mmc host controller
>>> code in a series of patches [1]. Patch 34 might be similar to what you are
>>> trying to accomplish.
>>
>> I believe that is a resend of Olof's patch I mentioned early in this
>> discussion. :)

Ok,

I meant to refer to this thread [1]. Indeed, the patch is from Olof.

Regards,
Arend

[1] http://thread.gmane.org/gmane.linux.documentation/22805

> Ok, assuming that is the case, then it seems to me that we are all moving
> somewhat in the same direction, which is good :)
>
> What I would like to propose is to move forward with Olof's patch with
> 2 changes made to it:
>
> 1) Store the clocks / resets / whatever in childnodes of the mmc host node,
> with the childnodes using the addressing scheme described in the patch
> from Sascha Hauer titled: "mmc: Add SDIO function devicetree subnode parsing",
> as this is where they really belong (and in some cases the sdio function driver
> may need access to them too).
>
> 2) Make Olof's code only do the powerup if the child node has a compatible of
> "simple-sdio-powerup", to avoid it getting in the way of more complex poweron
> scenarios (which may require a separate pmic driver or some such) later.
>
> Regards,
>
> Hans

