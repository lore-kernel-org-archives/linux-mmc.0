From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 03/11] pinctrl: sunxi: Move setting of mux
 to irq type from unmask to set_type
Date: Tue, 27 May 2014 11:01:03 +0200
Message-ID: <5384544F.6000806@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com> <1401090486-4414-4-git-send-email-hdegoede@redhat.com> <20140527080952.GC4730@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBXFISGOAKGQEFWZSEYI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140527080952.GC4730@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 05/27/2014 10:09 AM, Maxime Ripard wrote:
> On Mon, May 26, 2014 at 09:47:58AM +0200, Hans de Goede wrote:
>> With level triggered interrupt mask / unmask will get called for each
>> interrupt, doing the somewhat expensive mux setting on each unmask thus is
>> not a good idea. Instead move it to the set_type callback, which is typically
>> done only once for each irq.
> 
> *This* is the bad idea. Nothing prevents you from calling
> gpio_get_value whenever you just got your interrupt, that will change
> the muxing, and never change it back, effectively breaking the
> interrupts.

Hmm, interesting point, but your assuming 2 things which are both not true:

1) That calling gpiod_get_value changes the muxing, which is not true, all
gpiod_get_value variants end up in drivers/gpio/gpiolib.c _gpiod_get_raw_value()
which does no such thing

2) That unmask will always get called after the gpio_get_value to restore the mux
setting for us, which is not guaranteed at all. Before this patch set pinctrl-sunxi.c
was using handle_simple_irq which does not mask / unmask at all.

And even with an irq-handler which masks / unmasks, what if the irq wakes up
a thread and that thread then does the gpio_get_value ?

Note this is *exactly* what e.g. the mmc gpio card-detect code does, it uses
a thread to read the gpio for debouncing.

Luckily 2. is not a problem, since 1. means that the mux won't get changed at all
so we don't need to change it back.

Regards,

Hans
