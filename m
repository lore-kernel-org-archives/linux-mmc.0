From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Re: [PATCH 1/5] ARM: sunxi: Add driver for SD/MMC
 hosts found on Allwinner sunxi SoCs
Date: Mon, 16 Dec 2013 12:59:31 +0100
Message-ID: <CAOMqctTdasLxJki0xu4aq_sEgujDt3Jdu=BXy9WvQeji282_Rg@mail.gmail.com>
References: <1387058295-20641-1-git-send-email-hdegoede@redhat.com>
 <1387058295-20641-2-git-send-email-hdegoede@redhat.com> <20131215134415.GE3651@lukather>
 <CAOMqctRspBPmNsyXye_gpfwGoZ=gMcCzEjM+hD3g+ZfQix7G6Q@mail.gmail.com> <20131216100551.GD3037@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCQMLUOX54MBBS6WXOKQKGQEI3QQL5Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20131216100551.GD3037@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, =?UTF-8?Q?David_Lanzend=C3=B6rfer?= <david.lanzendoerfer-Z7Kmv9EsliU@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 16 December 2013 11:05, Maxime Ripard
<maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> On Sun, Dec 15, 2013 at 11:01:17PM +0100, Michal Suchanek wrote:
>> On 15 December 2013 14:44, Maxime Ripard
>> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>> >> --- a/drivers/mmc/host/Kconfig
>> >> +++ b/drivers/mmc/host/Kconfig
>> >> @@ -665,3 +665,11 @@ config MMC_REALTEK_PCI
>> >>       help
>> >>         Say Y here to include driver code to support SD/MMC card interface
>> >>         of Realtek PCI-E card reader
>> >> +
>> >> +config MMC_SUNXI
>> >> +     tristate "Allwinner sunxi SD/MMC Host Controller support"
>> >> +     depends on ARCH_SUNXI
>> >> +     default y
>> >
>> > I'm not that fond of these "default y" patterns. It forces the driver
>> > down to every user of the multiplatform kernels. I'd suggest removing
>> > the default and adding the driver to the defconfigs we have.
>>
>> And why would you build support for sunxi without building support for
>> sunxi mmc?
>
> Because you can?

But does that need to be the default? And is that sane default?

>
> And where am I actually suggesting to do so?

Just a few lines above. You suggest it should not be built by default.

>
>> Like 90%+ sunxi devices actually have a SD slot or an eMMC or a SDIO
>> card connected so what's the point of supporting sunxi without sunxi
>> mmc?
>
> And does your assumption still stand if you take into account all the
> other ARM boards?

Sure. It depends on sunxi platform so if you compile in support for
that 90%+ boards you just added have something connected to a mmc
controller so the sane thing is to also add the mmc controller.

Thanks

Michal
