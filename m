From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH 01/11] pinctrl: sunxi: create irq/pin
 mapping during init
Date: Wed, 28 May 2014 10:53:19 +0200
Message-ID: <CACRpkdbJJWXyO-beDCed5rBfAx0aMmdXLTUDtYuyWZGfABXzpA@mail.gmail.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>
	<1401090486-4414-2-git-send-email-hdegoede@redhat.com>
	<CACRpkdZpy2aT_kFp01bnrviVB3SOggiNUJB46wbWAY_bqW8=gg@mail.gmail.com>
	<CAGb2v65NW61+BV2hR3wn_xRvCyPo+AhcMU7hmFjQxKWj49G=Bw@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDE6RCFOWIARBAGIS2OAKGQESIU5B5Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CAGb2v65NW61+BV2hR3wn_xRvCyPo+AhcMU7hmFjQxKWj49G=Bw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, May 27, 2014 at 4:21 PM, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> On Tue, May 27, 2014 at 10:11 PM, Linus Walleij

>> I tried to hack the sunxi driver to even use the gpiolib
>> irqchip helpers but exactly this complex map thing in
>> ->irq_array[] git me stuck. If any of you guys could be so
>> nice to take a stab at this (compare to other commits
>> converting drivers to use gpiolibs irqchip helpers) then
>> I'd be very happy.
>
> We still need to rework the whole irqchip stuff for sun6i/sun8i,
> which have 1 parent interrupt per EINT capable pin bank.
>
> Earlier discussions with Maxime (on IRC IIRC) suggested moving this
> over to gpiolib irqchip helpers might be more work than using our own
> irqchip implementation, requiring 1 gpiochip per pin group? (not sure)

OK then keep your current code. I do not intend to cover all
cases in the world with these helpers, just the simple cases.
Complex hardware merits complex code.

Yours,
Linus Walleij
