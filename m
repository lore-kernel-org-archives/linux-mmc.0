From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: sunxi: Explicitly enable pull-ups
 for MMC pins
Date: Fri, 18 Nov 2016 10:18:43 +0100
Message-ID: <CACRpkdY-cO7f8Ad9=OiCfW4fy3oMFEF4ojhGxspijH5XWMSJnQ@mail.gmail.com>
References: <20161117093438.17988-1-wens@csie.org> <ea02ec937a12d6ca2a2e0d8bbea5c484@theobroma-systems.com>
Reply-To: linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDE6RCFOWIARB5UOXPAQKGQEHRXAFHA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <ea02ec937a12d6ca2a2e0d8bbea5c484-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: klaus.goger-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

[Notice this reply has little to do with the patch in question: I think
it should be applied. I just want to involve some MMC/SD people here]

On Thu, Nov 17, 2016 at 9:57 PM,  <klaus.goger-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org> wrote:
> On 2016-11-17 10:34, Chen-Yu Tsai wrote:
>>
>> Given that MMC starts in open-drain mode and the pull-ups are required,
>> it's best to enable it for all the pin settings.
>
> It's even more complicated than that with MMC. It starts in open-drain mode
> for
> CMD during initialization but changes to push-pull afterwards. The card has
> internal pull-ups to prevent bus floating during setup and will disable them
> after switching to 4bit mode (or 8bit for eMMC when available).
> But even after switching to push-pull drivers there are states the bus would
> float and pull ups have to ensure a high level on the bus.
>
> See JESD84-A441 chapter 7.15 ff as reference.
>
>   The difference between the P-bit and Z-bit is that a P-bit is actively
> driven
>   to HIGH by the card respectively host output driver, while Z-bit is driven
> to
>  (respectively kept) HIGH by the pull-up resistors Rcmd respectively Rdat.
>
> Enabling the pull ups on the CPU would be the right choice considering that
> most boards will not have external pull-ups. Even if they would have one,
> adding the internal in parallel would work in almost all cases and the
> increase in power consumption would be negligible.

I guess you are referring to software-controlled pull up on the pad ring of
the SoC. Nominally that should be handled by pin control like in this
patch.

It is not clear from context to me which of the lines need to be handled
like this? Just the data lines? DAT0 would be the critical line to pull up
in that case, since the others will not be used until bus switch anyways
right?

But what about CMD?

I assume CLK should always be push-pull?

Also: if the pins have an explicit Open Drain setting, should that
be used? I guess so?

Overall I think this construction is pretty common.

We essentially have two classes of connections:

- Those connecting the eMMC or even MMC/SD card directly to
  the SoC. No pull-ups on the board. Here it makes sense to have:

  1. A pin control default state with open drain and pull-ups
     enabled for those lines

  and it then needs

  2. A second "4/8bit mode" that will switch these
     pins to push-pull mode and turn off the pull-ups.

  If the OD+pull-up state is the default we should probably
  standardize a default name for the state when we kick in 4/8bit
  mode from the IOS operation.

- Those connection the MMC/SD on an external slot through a
  levelshifter/EMI filter. In that case I guess it is pretty much
  dependent on the levelshifter or EMI thing how the lines out
  of the SoC should be configured, and usually it is static so
  you do not need to worry about it after boot configuration
  of pins. (Mostly no bias, push-pull I think.)

I highly suspect a whole bunch of SoC drivers are not getting
this business right today. Not even in out-of-tree vendor kernels.

Yours,
Linus Walleij
