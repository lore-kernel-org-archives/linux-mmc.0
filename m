From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/4] gpiolib: Add gpiochip_find_by_name() and gpio_find_by_chip_name()
Date: Fri, 02 Mar 2012 00:58:04 -0700
Message-ID: <20120302075804.F28DB3E2DB4@localhost>
References: <20120301185044.29210.44521.stgit@kaulin.local> <20120301185524.29210.60381.stgit@kaulin.local>
Mime-Version: 1.0
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34437 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756362Ab2CBJcE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 2 Mar 2012 04:32:04 -0500
Received: by mail-pz0-f46.google.com with SMTP id r28so1796222daj.19
        for <linux-mmc@vger.kernel.org>; Fri, 02 Mar 2012 01:32:03 -0800 (PST)
In-Reply-To: <20120301185524.29210.60381.stgit@kaulin.local>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linuxkernel@vger.kernel.org
Cc: Linus Walleij <linus.walleij@stericsson.com>, Arnd Bergmann <arnd@arndb.de>, Rajendra Nayak <rnayak@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, 01 Mar 2012 10:55:24 -0800, Tony Lindgren <tony@atomide.com> wrote:
> Currently there is no way for drivers to request a GPIO on a particular
> gpio chip. This makes it hard to support multiple GPIO controllers
> with dynamic GPIO and interrupt numbering, such as with CONFIG_SPARSE_IRQ.
> 
> Make it easier for device drivers to find GPIOs on a specific gpio_chip
> by adding two functions: gpiochip_find_by_name() and gpio_find_by_chip_name().
> 
> Note that as gpiochip_find() is already exported, we may as well
> export gpiochip_find_by_name() too.

How is the device going to know the name of the gpio controller?  I
don't particularly like interfaces that find devices by-names since
I don't think device names can be relied to be stable when devices
are instantiated from device tree data.

> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Linus Walleij <linus.walleij@stericsson.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/gpio/gpiolib.c     |   47 ++++++++++++++++++++++++++++++++++++++++++++
>  include/asm-generic/gpio.h |    3 ++-
>  2 files changed, 49 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> index 17fdf4b..0e5bf55 100644
> --- a/drivers/gpio/gpiolib.c
> +++ b/drivers/gpio/gpiolib.c
> @@ -1173,6 +1173,53 @@ struct gpio_chip *gpiochip_find(void *data,
>  }
>  EXPORT_SYMBOL_GPL(gpiochip_find);
>  
> +static int match_name(struct gpio_chip *chip, void *data)

Even though this is a static, please keep the prefix to avoid
namespace conflicts.  gpiochip_match_name()

> +{
> +	const char *name = data;

This is unnecessary; the void* can be passed directly to sysfs_streq...
but why is sysfs_streq being used here instead of strcmp?  This is 
not sysfs related code.

> +
> +	return sysfs_streq(name, chip->label);
> +}
> +
> +/**
> + * gpiochip_find_by_name() - iterator for locating a gpio_chip by name
> + * @name: name of the gpio_chip
> + *
> + * Similar to bus_find_device_by_name. It returns a reference to the
> + * first gpio_chip with matching name. It ignores NULL and empty names.
> + * If you need to do something more complex, then use gpiochip_find.
> + */
> +struct gpio_chip *gpiochip_find_by_name(const char *name)
> +{
> +	if (!name || !strcmp(name, ""))
> +		return NULL;
> +
> +	return gpiochip_find((void *)name, match_name);

Nasty cast.  Can the signature for gpiochip_find be changed to accept
a (const void *)?

> +}
> +EXPORT_SYMBOL_GPL(gpiochip_find_by_name);
> +
> +/**
> + * gpio_find_by_chip_name() - find a gpio on a specific gpio_chip
> + * @chip_name: name of the gpio_chip
> + * @gpio_offset: offset of the gpio on the gpio_chip
> + *
> + * Note that gpiochip_find_by_name returns the first matching
> + * gpio_chip name. For more complex matching, see gpio_find.
> + */
> +int gpio_find_by_chip_name(const char *chip_name, unsigned gpio_offset)
> +{
> +	struct gpio_chip *chip;
> +	int gpio, res;
> +
> +	chip = gpiochip_find_by_name(chip_name);
> +	if (!chip)
> +		return -ENODEV;
> +
> +	gpio = chip->base + gpio_offset;
> +
> +	return gpio;
> +}
> +EXPORT_SYMBOL_GPL(gpio_find_by_chip_name);
> +
>  /* These "optional" allocation calls help prevent drivers from stomping
>   * on each other, and help provide better diagnostics in debugfs.
>   * They're called even less than the "set direction" calls.
> diff --git a/include/asm-generic/gpio.h b/include/asm-generic/gpio.h
> index 1ff4e22..d7a2100 100644
> --- a/include/asm-generic/gpio.h
> +++ b/include/asm-generic/gpio.h
> @@ -145,7 +145,8 @@ extern int __must_check gpiochip_remove(struct gpio_chip *chip);
>  extern struct gpio_chip *gpiochip_find(void *data,
>  					int (*match)(struct gpio_chip *chip,
>  						     void *data));
> -
> +extern struct gpio_chip *gpiochip_find_by_name(const char *name);
> +extern int gpio_find_by_chip_name(const char *chip_name, unsigned gpio_offset);
>  
>  /* Always use the library code for GPIO management calls,
>   * or when sleeping may be involved.
> 

-- 
email sent from notmuch.vim plugin
