From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH v3 00/10] ARM: sun8i: a83t: Add support for MMC controllers
Date: Fri, 4 Aug 2017 10:16:48 +0800
Message-ID: <CAGb2v67O2SECXPeq3Q2rE7wMG54rnXNCq_+pJoeh18CEpae-VA@mail.gmail.com>
References: <20170724135905.28855-1-wens@csie.org> <CAGb2v66DQ3H2Mta7h+t1P+UzSRLnMABRebeYcopaPkN0gOiwxA@mail.gmail.com>
 <20170726194522.7d64f7c2danrknfi@flea> <CAPDyKFrssySjKW0E7sB3D-UjVea8_Yxvrkkr7sKf47x6jwgVSQ@mail.gmail.com>
 <CAGb2v648K1Nguf8nVjfunow7+xwS0MHazzMXJd1xZ3uNM2WesA@mail.gmail.com> <CAPDyKFrBfQ-mNTNitcpgo1FCa1068ZzC_J4efsxmU2X6tOJgzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrBfQ-mNTNitcpgo1FCa1068ZzC_J4efsxmU2X6tOJgzw@mail.gmail.com>
Sender: linux-clk-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-clk <linux-clk@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-sunxi <linux-sunxi@googlegroups.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 3, 2017 at 8:02 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 3 August 2017 at 13:25, Chen-Yu Tsai <wens@csie.org> wrote:
>> On Thu, Aug 3, 2017 at 7:19 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 26 July 2017 at 21:45, Maxime Ripard
>>> <maxime.ripard@free-electrons.com> wrote:
>>>> On Wed, Jul 26, 2017 at 10:09:41PM +0800, Chen-Yu Tsai wrote:
>>>>> On Mon, Jul 24, 2017 at 9:58 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>>>>> > Hi everyone,
>>>>> >
>>>>> > This is v3 of my MMC controller support series.
>>>>> >
>>>>>
>>>>> [...]
>>>>>
>>>>> > Chen-Yu Tsai (10):
>>>>> >   clk: sunxi-ng: Add interface to query or configure MMC timing modes.
>>>>> >   clk: sunxi-ng: Add MP_MMC clocks that support MMC timing modes
>>>>> >     switching
>>>>> >   clk: sunxi-ng: a83t: Support new timing mode for mmc2 clock
>>>>> >   mmc: sunxi: Support controllers that can use both old and new timings
>>>>> >   mmc: sunxi: Support MMC DDR52 transfer mode with new timing mode
>>>>> >   mmc: sunxi: Add support for A83T eMMC (MMC2)
>>>>>
>>>>> So this series seems to be ready for inclusion, unless Ulf has further
>>>>> concerns about the clk usage.
>>>>>
>>>>> The first mmc patch have build time dependencies on the first clk patch.
>>>>> Shall we put the clk patch on a separate immutable branch for both trees
>>>>> to pull? Or we could just merge everything through the mmc tree? I don't
>>>>> think we'll touch this part of the sunxi-ng clk driver for the remainder
>>>>> of this cycle.
>>>>
>>>> I guess the easiest would be for it to go through Ulf tree, unless he
>>>> says otherwise of course :)
>>>
>>> Okay, I have picked up the series and applied it for my next branch.
>>
>> I guess I wasn't very clear. When I meant "everything" I meant the mmc
>> and clk patches. We will take the dts patches through the sunxi tree.
>>
>> Can you drop the four dts patches from your tree? That would be the
>> last four patches on mmc/next at the moment.
>
> Done!

Thanks! I applied the remaining dts patches to the sunxi tree.

ChenYu
