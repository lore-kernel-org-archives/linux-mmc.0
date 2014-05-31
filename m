From: Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>
Subject: Re: [PATCH v2 1/4] dt: bindings: mmc: Document the
 practice of using subnodes for slots
Date: Sat, 31 May 2014 13:13:53 -0700
Message-ID: <CAOesGMisqtPWKY6N5ch36c0VyBP1Pu725cehBU+2gYtKXQs=hQ@mail.gmail.com>
References: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
	<1401563014-13856-2-git-send-email-hdegoede@redhat.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDE5PA6ZWADBBAPQVCOAKGQEAZFXIXA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <1401563014-13856-2-git-send-email-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Sat, May 31, 2014 at 12:03 PM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> The following existing MMC host controller bindings use slot subnodes:
>
> Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> Documentation/devicetree/bindings/mmc/k3-dw-mshc.txt
> Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> Documentation/devicetree/bindings/mmc/socfpga-dw-mshc.txt
> Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
> Documentation/devicetree/bindings/mmc/rockchip-dw-mshc.txt
>
> This commit documents this practice in the standard mmc bindings documentation.
>
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>

There are today only two drivers that use this kind of binding, dw_mmc
and the at91 one. Neither seems to actually ever have been used with
more than one slot. I doubt anyone building an exynos-based system
will ever do a multi-slot solution, and it seems that the at91 driver
doesn't actually handle more than one slot.

I'm personally not that excited about complicating the bindings by
opening up for this -- I would rather work towards removing the
concept of slots if it's one of those things that are going to remain
unused. We have actually been talking about reworking the dw_mmc
binding to remove the slot concept (and simplify the driver by doing
so).


-Olof
