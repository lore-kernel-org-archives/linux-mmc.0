From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC PATCH v3 1/3] mmc: sprd: Add MMC host driver for Spreadtrum SoC
Date: Tue, 6 Oct 2015 11:18:13 +0200
Message-ID: <CAPDyKFo3xp3wU3XW3kMV7Xz7DFgkxts3CArthYY7-CyWk8cjXw@mail.gmail.com>
References: <1439571353-30165-1-git-send-email-wuht06@gmail.com>
	<1439571353-30165-2-git-send-email-wuht06@gmail.com>
	<CAPDyKFp=XH+Vo_diRyhrMuB+v1rmTmxo3Lid3Wc-u1ohqNisKw@mail.gmail.com>
	<CAG_R4_VTXCV4NVMOwv-9F56-_pVsK0hU4go79ZhV3OFxwcF0mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAG_R4_VTXCV4NVMOwv-9F56-_pVsK0hU4go79ZhV3OFxwcF0mA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hongtao Wu <wuht06@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shawn Lin <shawn.lin@rock-chips.com>, "Orson.Zhai@spreadtrum.com" <Orson.Zhai@spreadtrum.com>, "Chunyan.Zhang@spreadtrum.com" <Chunyan.Zhang@spreadtrum.com>, "Jason.Wu@spreadtrum.com" <Jason.Wu@spreadtrum.com>, Russell King <rmk+kernel@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

+Russell

On 28 September 2015 at 09:18, Hongtao Wu <wuht06@gmail.com> wrote:
>>>
>
> On Thu, Sep 10, 2015 at 9:28 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 14 August 2015 at 18:55, Hongtao Wu <wuht06@gmail.com> wrote:
>> > the Spreadtrum MMC host driver is used to supply EMMC, SD, and
>> > SDIO types of memory cards
>>
>> Perhaps some more information about the controller. Are there any
>> specific features it support or doesn't support!?
>
> Thanks for kindly reply.
> Yes, spreadtrum MMC host controllers have some specific features as follows:
> (1) We don't have controls for sampling clock tuning and re-tuning, we take
>       place of them with three registers as follows:
>        (a) CLK_WR_DL(Offset 080h): Data write clock delay line.
>        (b) CLK_RD_POS_DL(Offset 0x84h): Posedge data read clock delay line.
>        (c) CLK_RD_NEG_DL(Offset 088h): Negedge data read clock delay line.
>
> (2) We don't have Power Control Register(Offset 029h), all our controller's
> power
>       come from PMIC, rather than directly from CPU.
>
> (3) We don't have bit[6](Card Insertion), bit[7] (Card Removal), bit[8]
> (Card Interrupt)
> and bit[12:9] in Normal Interrupt Status Register(Offset 030h). Because the
> detect
> gpio pin doesn't connect to the register of our host controller. So we can't
> operate bit[18:16](Card Detect Pin Level, Card State stable and Card
> Inserted)
> in Present State Register(Offset 024h).

Thanks for clarifying!

You have some differences towards the "standard" sdhci variant, but
that doesn't mean you should go off and implement a new driver from
scratch, instead you should create a new sdhci variant and re-use code
from the generic sdhci driver.

The current problem with such approach, is that the sdhci driver isn't
designed as a library but instead a driver consisting of too many
quirks and callbacks. While you start to adopt your driver towards
sdhci, you will need to add yet another bunch of new quirks and
callbacks to suite your hw.

Now, as the number of callbacks and quirks continues to increase I
will sooner or later give up maintaining it, as each line of code will
depend on a quirk. So, we need to start turning sdhci into a library
*right now*! Russell King, has pointed out this several times as well,
but unfortunate I haven't yet seen anyone willing to help out in this
field.

I would of course be very happy if you would like to have a look at
that, but I realize it's a difficult task, So, unless you are happy
with taking on such a challenge, I suggest you go for an intermediate
step, which thus means convert your driver to a sdhci variant driver
and add the quirks/callbacks you need to suite your hw.

[...]

Kind regards
Uffe
