From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 02/11] pinctrl: sunxi: add
 IRQCHIP_SKIP_SET_WAKE flag for pinctrl irq chip
Date: Tue, 27 May 2014 11:09:17 +0200
Message-ID: <5384563D.2000000@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com> <1401090486-4414-3-git-send-email-hdegoede@redhat.com> <20140527080746.GB4730@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sunxi+bncBDRZXY4CYYORBRNMSGOAKGQEANRZYVA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20140527080746.GB4730@lukather>
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

On 05/27/2014 10:07 AM, Maxime Ripard wrote:
> On Mon, May 26, 2014 at 09:47:57AM +0200, Hans de Goede wrote:
>> From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>>
>> The sunxi pinctrl irq chip driver does not support wakeup at the
>> moment. Adding IRQCHIP_SKIP_SET_WAKE lets the irqs work with drivers
>> using wakeup.
>>
>> Also add a name to the irq chip.
>>
>> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> index db9ccd6..ec60c2e 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> @@ -646,6 +646,8 @@ static struct irq_chip sunxi_pinctrl_irq_chip = {
>>  	.irq_mask_ack	= sunxi_pinctrl_irq_mask_ack,
>>  	.irq_unmask	= sunxi_pinctrl_irq_unmask,
>>  	.irq_set_type	= sunxi_pinctrl_irq_set_type,
>> +	.name		= "sunxi-pio",
>> +	.flags		= IRQCHIP_SKIP_SET_WAKE,
> 
> I'd rather see the name set to dev_name() or something like that. This
> will not work that great with multiple pin controller supporting
> interrupts.

That would require moving the irq_chip struct to become a member of the
sunxi_pinctrl struct. Not undoable, but that seems like something which
should be done in a separate patch. So shall I just drop the .name part
of this patch for now ?

Regards,

Hans
