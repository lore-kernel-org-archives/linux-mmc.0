From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v2 06/10] mmc: omap_hsmmc: add support for pbias configuration
 in dt
Date: Thu, 13 Jun 2013 20:11:52 +0530
Message-ID: <51B9DA30.1090308@ti.com>
References: <20130523184045.GD13507@atomide.com> <1370546059-24181-1-git-send-email-balajitk@ti.com> <1370546059-24181-7-git-send-email-balajitk@ti.com> <CACRpkdZAzAJW0UxGCSj-PWXTSi2Q6T8fqL9SQ+Y-91sELQ3SRQ@mail.gmail.com> <20130613095353.GX8164@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20130613095353.GX8164@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee.jones@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

On Thursday 13 June 2013 03:23 PM, Tony Lindgren wrote:
> * Linus Walleij <linus.walleij@linaro.org> [130613 02:42]:
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
>>
>>> +       /* 100ms delay required for PBIAS configuration */
>>> +       msleep(100);
>>> +       if (!vdd && host->pinctrl && host->pbias_off) {
>>> +               ret = pinctrl_select_state(host->pinctrl, host->pbias_off);
>>> +               if (ret < 0)
>>> +                       dev_err(host->dev, "pinctrl pbias_off select error\n");
>>> +       } else if (((1 << vdd) <= MMC_VDD_165_195) && host->pinctrl &&
>>> +                       host->pbias_1v8) {
>>> +               ret = pinctrl_select_state(host->pinctrl, host->pbias_1v8);
>>> +               if (ret < 0)
>>> +                       dev_err(host->dev, "pinctrl pbias_1v8 select error\n");
>>> +       } else if (((1 << vdd) > MMC_VDD_165_195) && host->pinctrl &&
>>> +                       host->pbias_3v) {
>>> +               ret = pinctrl_select_state(host->pinctrl, host->pbias_3v);
>>> +               if (ret < 0)
>>> +                       dev_err(host->dev, "pinctrl pbias_3v select error\n");
>>> +       }
>>
>> So why does the pin control API control bias voltage?
>
> I agree, it should be a regulator for the MMC driver and that's what I
> already suggested earlier. Having it as a regulator allows us to get
> rid of all the non-standard before and after calls in the omap_hsmmc.c.
> This way the omap_hsmmc.c code can handle the internal and external
> voltages the same way.
>
>> This seem so intuitively wrong as it can possibly get, clearly this
>> is regulator territory.
>

It is not really a regulator, CONTROL_PBIAS_LITE is just a register
in control module which configures pad/pin on SOC. In this case PBIAS cells
are powered down before any voltage changes and after the external voltage
supplied to VDDS_MMC of OMAP stabilizes pbias cells  is powered ON again
with specific Voltage which is given to OMAP for MMC io pins

For OMAP2430, OMAP3430 It additionally has a bit for speed mode control
which are set always (static config)

I am quoting pbias register field description from TRM for reference

BIT2 PBIASSPEEDCTRL0 Speed Control for MMC I/O
0b0 => 26 MHz I/O max speed
0b1 => 52 MHz I/O max speed

BIT26 MMC1_PWRDNZ PWRDNZ control to MMC1 IO
This bit is used to protect the MMC1 I/O cell when
SDMMC1_VDDS is not stable.
0x0: Software must clear this bit when SDMMC1_VDDS
changes.
0x1: Software must set this bit only when
SDMMC1_VDDS is stable.

BIT25 MMC1_PBIASLITE_HIZ_MODE HIZ_MODE from MMC1 PBIASLITE
0x0: PBIAS in normal operation mode
0x1: PBIAS output is in high impedence state

BIT24 MMC1_PBIASLITE_SUPPLY_HI SUPPLY_HI_OUT from MMC1 PBIASLITE
_OUT Read 0x0: SDMMC1_VDDS = 1.8V
Read 0x1: SDMMC1_VDDS = 3V

BIT23 MMC1_PBIASLITE_VMODE_ER VMODE ERROR from MMC1 PBIASLITE
ROR Read 0x0: VMODE level is same as SUPPLY_HI_OUT
Read 0x1: VMODE level is not same as
SUPPLY_HI_OUT

BIT22 MMC1_PBIASLITE_PWRDNZ PWRDNZ control to MMC1 PBIASLITE
This bit is used to protect the MMC1_PBIAS cell (MMC1
I/O cell associated) when SDMMC1_VDDS is not stable.
0x0: Software must clear this bit when SDMMC1_VDDS
changes.
0x1: Software must set this bit only when
SDMMC1_VDDS is stable.

BIT21 MMC1_PBIASLITE_VMODE VMODE control to MMC1 PBIASLITE
0x0: SDMMC1_VDDS = 1.8V
0x1: SDMMC1_VDDS = 3V

> The PBIAS for MMC1 is a mux + comparator for the MMC pin, so it makes
> sense for the regulator driver to access the register via pinctrl API.
> I think the reason why we have registers like this and the USB comparators
> in the omap SCM (System Control Module) as the all seem to relate to
> pin states.
>
>> This also looks strange from an MMC point of view.
>
> Yes I agree, it should be a regulator for MMC. Doing it this way just
> adds yet more code that's usable for only one of the omap MMC
> controllers.
>

the only other user for pbias which I can find is USB pin configuration in
arch/arm/mach-omap2/board-omap3logic.c where it is statically programmed for 3V
which can be modeled as well as  default pinctrl state.


>> It just seems these bits in these registers should be poked at
>> by the regulator world, not the pinctrl world.


You mean regulator via pinctrl APIs, I think It will just move the code
from omap_hsmmc to a new regulator file with it own init data for pinctrl.

Not sure if Regulator maintainer will agree to it.

Moreover what I needs is three different states 0V, 0 to 1.8V, 3 V to 3.3V
not 0, 1.8V, 3V. plus pbias register fields got moved around between omap3, omap4
and omap5, That was one of the reason for moving to pinctrl states.


 >> That the bits are
>> in the middle of pinctrl things does not really matter.

It thought pinctrl-single,bits in pinctrl-single.c is introduced
precisely for such misc control register which has bit configuration
affecting different module i/o pads.

>>
>>> +       usleep_range(350, 400);
>>
>> And the regulator framework supports power-on delays.
>
> Yes. And it seems that the delays should not be needed, but instead
> the comparator bits should be checked.

But, Not all OMAP has such support to read comparator bits.

>
> Regards,
>
> Tony
>
