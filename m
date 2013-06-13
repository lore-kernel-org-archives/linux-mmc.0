From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v2 06/10] mmc: omap_hsmmc: add support for pbias configuration
 in dt
Date: Thu, 13 Jun 2013 20:31:52 +0530
Message-ID: <51B9DEE0.1060305@ti.com>
References: <20130523184045.GD13507@atomide.com> <1370546059-24181-1-git-send-email-balajitk@ti.com> <1370546059-24181-7-git-send-email-balajitk@ti.com> <CACRpkdZAzAJW0UxGCSj-PWXTSi2Q6T8fqL9SQ+Y-91sELQ3SRQ@mail.gmail.com> <20130613104715.GC16677@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20130613104715.GC16677@laptop>
Sender: linux-omap-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, ext Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Thursday 13 June 2013 04:17 PM, Lee Jones wrote:
> On Thu, 13 Jun 2013, Linus Walleij wrote:
>
>> On Thu, Jun 6, 2013 at 9:14 PM, Balaji T K <balajitk@ti.com> wrote:
>>
>>> PBIAS register configuration is based on the regulator voltage
>>> which supplies these pbias cells, sd i/o pads.
>>> With PBIAS register address and bit definitions different across
>>> omap[3,4,5], Simplify PBIAS configuration under three different
>>> regulator voltage levels - O V, 1.8 V, 3 V. Corresponding pinctrl states
>>> are defined as pbias_off, pbias_1v8, pbias_3v.
>>>
>>> pinctrl state mmc_init is used for configuring speed mode, loopback clock
>>> (in devconf0/devconf1/prog_io1 register for omap3) and pull strength
>>> configuration (in control_mmc1 for omap4)
>>>
>>> Signed-off-by: Balaji T K <balajitk@ti.com>
>>
>> You *need* Lee Jones and Mark Brown to review this.
>> Maybe Laurent has something to add too.
>>
>> Ux500 had the very same thing, and there this was solved using
>> a GPIO regulator for "vqmmc" a level-shifter. I vaguely remember
>> Laurent doing something similar with the SH stuff.
>
> I haven't seem much of this patch-set, but this certainly looks like
> it should be handled by a GPIO regulator instead of pinctrl. States
> are easily declared in a 'struct gpio_regulator_state', which the
> framework then uses to set the correct pins for the required voltage.
>

Thanks for the pointer, but wondering why is it named as gpio-regulator
and how it is different from fixed-regulator.
After going through git log description, I understand that voltage/current level
for a particular regulator is controlled by a set of pad/pin on the POWER IC
and pad/pin may be usually connected to gpio pins if it is needs to be
configurable and ground/pulled for constant voltage.

Collection of gpios logic level are modeled as state for particular voltage.
But gpio is not used in my case.

> And yes, 'vqmmc' is a good place to store the this regulator.
>

