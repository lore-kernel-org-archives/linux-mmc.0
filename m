From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 03/11] pinctrl: sunxi: Move setting of mux
 to irq type from unmask to set_type
Date: Sat, 31 May 2014 11:13:05 +0200
Message-ID: <53899D21.3000008@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com> <1401090486-4414-4-git-send-email-hdegoede@redhat.com> <CACRpkdZcGJTXfcxN_sogm+hYHM56d_VxtuZqth0t-c2mgAJ0vA@mail.gmail.com> <20140528093653.GN4730@lukather> <5385B1B8.8070803@redhat.com> <20140528103351.GQ4730@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Return-path: <linux-sunxi+bncBDRZXY4CYYORBLN2U2OAKGQE76RYLLI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140528103351.GQ4730@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On 05/28/2014 12:33 PM, Maxime Ripard wrote:
> On Wed, May 28, 2014 at 11:51:52AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 05/28/2014 11:36 AM, Maxime Ripard wrote:
>>> On Tue, May 27, 2014 at 04:18:29PM +0200, Linus Walleij wrote:
>>>> On Mon, May 26, 2014 at 9:47 AM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>>>>
>>>>> With level triggered interrupt mask / unmask will get called for each
>>>>> interrupt, doing the somewhat expensive mux setting on each unmask thus is
>>>>> not a good idea. Instead move it to the set_type callback, which is typically
>>>>> done only once for each irq.
>>>>>
>>>>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>>>
>>>> Yes move it out of mask/unmask but no, not into set_type().
>>>>
>>>> Can you not use the irqchip startup()/shutdown() callbacks
>>>> instead?
>>>
>>> I think we can use irq_request_resources then
>>> https://lkml.org/lkml/2014/3/12/307
>>
>> Sounds good, I'll modify the patch to move it here before posting a v2 of
>> this series. Note v2 likely won't happen till this weekend, -ENOTIME.
>>
>>> We could even merge the gpio_to_irq code into it.
>>
>> Erm, no we need that as a separate function for the gpio_chip's to_irq
>> callback.
>
> Linus sent a patch stating otherwise a few weeks ago, and was
> suggesting moving it to irq_startup.
>
> https://lkml.org/lkml/2014/5/9/50

That is not going to work, that patch uses gpiochip_irqchip_add,
which in turn uses gpiochip_to_irq as to_irq handler, which
assumes that gpio offset == irq offset, which is not true for
sunxi-pinctrl.

Specifically gpio_chio_to_irq does:

static int gpiochip_to_irq(struct gpio_chip *chip, unsigned offset)
{
         return irq_find_mapping(chip->irqdomain, offset);
}

Where as the sunxi code does (simplified):

static int sunxi_pinctrl_gpio_to_irq(struct gpio_chip *chip, unsigned offset)
{
	struct sunxi_desc_function *desc = sunxi_pinctrl_desc_find_function_by_pin(pctl, offset, "irq");
	return irq_find_mapping(pctl->domain, desc->irqnum);\
}

Note the extra level of indirection.

Regards,

Hans
