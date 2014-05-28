From: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 02/11] pinctrl: sunxi: add
 IRQCHIP_SKIP_SET_WAKE flag for pinctrl irq chip
Date: Wed, 28 May 2014 12:51:11 +0200
Message-ID: <5385BF9F.8060808@gmail.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com> <1401090486-4414-3-git-send-email-hdegoede@redhat.com> <20140527080746.GB4730@lukather> <5384B9E7.1070405@gmail.com> <20140528102912.GP4730@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBCCYVXM26EFRBIP7S2OAKGQEWWDFCJI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140528102912.GP4730@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 28.05.2014 12:29, Maxime Ripard wrote:
> On Tue, May 27, 2014 at 06:14:31PM +0200, Tomasz Figa wrote:
>> On 27.05.2014 10:07, Maxime Ripard wrote:
>>> On Mon, May 26, 2014 at 09:47:57AM +0200, Hans de Goede wrote:
>>>> From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>>>> 
>>>> The sunxi pinctrl irq chip driver does not support wakeup at
>>>> the moment. Adding IRQCHIP_SKIP_SET_WAKE lets the irqs work
>>>> with drivers using wakeup.
>>>> 
>>>> Also add a name to the irq chip.
>>>> 
>>>> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> Signed-off-by:
>>>> Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> --- 
>>>> drivers/pinctrl/sunxi/pinctrl-sunxi.c | 2 ++ 1 file changed,
>>>> 2 insertions(+)
>>>> 
>>>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c 
>>>> b/drivers/pinctrl/sunxi/pinctrl-sunxi.c index
>>>> db9ccd6..ec60c2e 100644 ---
>>>> a/drivers/pinctrl/sunxi/pinctrl-sunxi.c +++ 
>>>> b/drivers/pinctrl/sunxi/pinctrl-sunxi.c @@ -646,6 +646,8 @@ 
>>>> static struct irq_chip sunxi_pinctrl_irq_chip = {
>>>> .irq_mask_ack	= sunxi_pinctrl_irq_mask_ack, .irq_unmask	= 
>>>> sunxi_pinctrl_irq_unmask, .irq_set_type	= 
>>>> sunxi_pinctrl_irq_set_type, +	.name		= "sunxi-pio", +	.flags
>>>> = IRQCHIP_SKIP_SET_WAKE,
>>> 
>>> I'd rather see the name set to dev_name() or something like
>>> that. This will not work that great with multiple pin
>>> controller supporting interrupts.
>> 
>> Correct me if I'm wrong, but I've always thought that struct
>> irq_chip describes a class of IRQ controllers, not particular
>> instances.
> 
> It's not said as such in <linux/irq.h>, but maybe..

It is not said the otherwise as well, so hopefully someone could
clarify this. Thomas?

My conclusion about the purpose of this struct is based on its
contents - name, flags and a number of callbacks, nothing that could
be per-instance of identical chips. Moreover there is per interrupt
chip_data, which is usually used to store per-instance data by irqchip
drivers.

Best regards,
Tomasz
