From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH v3 00/10] ARM: sun8i: a83t: Add support for
 MMC controllers
Date: Thu, 3 Aug 2017 19:25:24 +0800
Message-ID: <CAGb2v648K1Nguf8nVjfunow7+xwS0MHazzMXJd1xZ3uNM2WesA@mail.gmail.com>
References: <20170724135905.28855-1-wens@csie.org> <CAGb2v66DQ3H2Mta7h+t1P+UzSRLnMABRebeYcopaPkN0gOiwxA@mail.gmail.com>
 <20170726194522.7d64f7c2danrknfi@flea> <CAPDyKFrssySjKW0E7sB3D-UjVea8_Yxvrkkr7sKf47x6jwgVSQ@mail.gmail.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBPEQRTGAKGQEHDM4N5Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAPDyKFrssySjKW0E7sB3D-UjVea8_Yxvrkkr7sKf47x6jwgVSQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Michael Turquette <mturquette-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Aug 3, 2017 at 7:19 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 26 July 2017 at 21:45, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> On Wed, Jul 26, 2017 at 10:09:41PM +0800, Chen-Yu Tsai wrote:
>>> On Mon, Jul 24, 2017 at 9:58 PM, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
>>> > Hi everyone,
>>> >
>>> > This is v3 of my MMC controller support series.
>>> >
>>>
>>> [...]
>>>
>>> > Chen-Yu Tsai (10):
>>> >   clk: sunxi-ng: Add interface to query or configure MMC timing modes.
>>> >   clk: sunxi-ng: Add MP_MMC clocks that support MMC timing modes
>>> >     switching
>>> >   clk: sunxi-ng: a83t: Support new timing mode for mmc2 clock
>>> >   mmc: sunxi: Support controllers that can use both old and new timings
>>> >   mmc: sunxi: Support MMC DDR52 transfer mode with new timing mode
>>> >   mmc: sunxi: Add support for A83T eMMC (MMC2)
>>>
>>> So this series seems to be ready for inclusion, unless Ulf has further
>>> concerns about the clk usage.
>>>
>>> The first mmc patch have build time dependencies on the first clk patch.
>>> Shall we put the clk patch on a separate immutable branch for both trees
>>> to pull? Or we could just merge everything through the mmc tree? I don't
>>> think we'll touch this part of the sunxi-ng clk driver for the remainder
>>> of this cycle.
>>
>> I guess the easiest would be for it to go through Ulf tree, unless he
>> says otherwise of course :)
>
> Okay, I have picked up the series and applied it for my next branch.

I guess I wasn't very clear. When I meant "everything" I meant the mmc
and clk patches. We will take the dts patches through the sunxi tree.

Can you drop the four dts patches from your tree? That would be the
last four patches on mmc/next at the moment.

Thanks and sorry for the confusion.

ChenYu
