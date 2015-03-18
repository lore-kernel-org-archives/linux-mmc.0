From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] gpio: pcf857x: restore the initial line state of all
 pcf lines
Date: Wed, 18 Mar 2015 18:51:57 +0530
Message-ID: <55097BF5.8080600@ti.com>
References: <1418371601-22658-1-git-send-email-kishon@ti.com>	<548F498F.7050202@ti.com>	<549271A9.5040701@ti.com>	<5492E09F.1000003@ti.com>	<54AA2EB1.8090501@ti.com>	<CACRpkdago2vWJYFmywULna6nkrbtciPZFESuuKixF0r8rSB1Sw@mail.gmail.com>	<5506987C.3060601@ti.com> <CACRpkdYQv4z68HWAq0KFV1WiSgJeNzm4sosnJxXHHvQp5AqsSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CACRpkdYQv4z68HWAq0KFV1WiSgJeNzm4sosnJxXHHvQp5AqsSg@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Linux-OMAP <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Benoit Parrot <bparrot@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Wednesday 18 March 2015 05:51 PM, Linus Walleij wrote:
> On Mon, Mar 16, 2015 at 9:46 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> On Wednesday 14 January 2015 05:28 PM, Linus Walleij wrote:
>
>>> #include <linux/reboot.h>
>>>
>>> static int foo_reboot_handler(struct notifier_block *this,
>>>                                   unsigned long code,
>>>                                   void *unused)
>>> {
>>>           pr_crit("do some last minute stuff\n");
>>>           return NOTIFY_OK;
>>> }
>>>
>>> static struct notifier_block foo_reboot_notifier = {
>>>           .notifier_call = foo_reboot_handler,
>>> };
>>>
>>> register_reboot_notifier(&foo_reboot_notifier);
>>
>>
>> Added debug prints and found the reboot notifier gets invoked before the
>> shutdown handler which means some stuff can be done after this reboot
>> notifier:-(
>
> Specify exactly what stuff may happen after the reboot notifier.

okay, it's assumed the device may be used (active) till the shutdown handler
of that particular device is called.

In this particular case we are restoring the initial line state of all pcf
lines even though we don't know if the devices connected to it are still being
active, which might cause a contention as explained by NM [1]

If the reboot notifier gets invoked after the shutdown handler then we could
be sure that restoring the initial line state of the pcf lines wouldn't affect
the devices connected to it.

Thanks
Kishon

[1] -> http://www.spinics.net/lists/linux-mmc/msg29855.html
>
> Of course stuff happens both before and after the reboot
> notifier, the question is exactly what, that may conflict with this.
>
> Yours,
> Linus Walleij
>
