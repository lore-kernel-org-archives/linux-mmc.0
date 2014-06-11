From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 04/11] pinctrl: sunxi: Properly handle level
 triggered gpio interrupts
Date: Wed, 11 Jun 2014 11:13:02 +0200
Message-ID: <53981D9E.8010401@redhat.com>
References: <1401090486-4414-1-git-send-email-hdegoede@redhat.com>	<1401090486-4414-5-git-send-email-hdegoede@redhat.com> <CACRpkdZ5_21aFBSJBXDzgorcEKeR9Pv5fVgmeVrBw1zDawVptA@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDRZXY4CYYORBKN34COAKGQE7BN6FRI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <CACRpkdZ5_21aFBSJBXDzgorcEKeR9Pv5fVgmeVrBw1zDawVptA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arend van Spriel <arend-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, "John W. Linville" <linville-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-wireless <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Linus,

On 06/11/2014 11:00 AM, Linus Walleij wrote:
> On Mon, May 26, 2014 at 9:47 AM, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
>> For level triggered gpio interrupts we need to use handle_fasteoi_irq,
>> like we do with the irq-sunxi-nmi driver. This is necessary to give threaded
>> interrupt handlers a chance to actuall clear the source of the interrupt
>> (which may involve sleeping waitnig for i2c / spi / mmc transfers), before
>> acknowledging the interrupt.
>>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> 
> I haven't seen any feedback on the pin controller patches in this
> series from Maxime, I might have missed it due to being tied to
> some other patch in the series.
> 
> Anyway, this needs to be rebased and reposted anyway, I
> just merged some base patches from Maxime for external
> interrupts that will go in after the merge window, I need some
> help to figure out what and how to merge here.

No problem I plan to do a rebased v2 of the pinctrl bits in
this series (and only the pinctrl bits) with some remarks
from Maxime fixed soon.

Regards,

Hans
