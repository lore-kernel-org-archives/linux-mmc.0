From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] leds-class: change back LEDS_CLASS to tristate instead
	of bool
Date: Thu, 29 Sep 2011 08:58:35 +0100
Message-ID: <20110929075835.GA26328@n2100.arm.linux.org.uk>
References: <1317113432-7299-1-git-send-email-bryan.wu@canonical.com> <CAK5ve-KoanwFGFJcxGQGmAW0yR+MYR1uVGM5q+=8u_ofHrhwOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK5ve-KoanwFGFJcxGQGmAW0yR+MYR1uVGM5q+=8u_ofHrhwOQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: tony@atomide.com, rpurdie@rpsys.net, manuel.lauss@gmail.com, cjb@laptop.org, cbou@mail.ru, dwmw2@infradead.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linus.walleij@linaro.org, akpm@google.com
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 29, 2011 at 10:00:58AM +0800, Bryan Wu wrote:
> Hiya,
> 
> Any comments and need I do anything to improve this patch?

No idea, I don't remember the original errors which this stuff spat out
and how they were caused.

The only thing I care about is that the conversion of the existing ARM
LEDs support to the NEW_LEDS stuff doesn't cause any breakage.
