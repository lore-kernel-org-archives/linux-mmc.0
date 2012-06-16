From: Roland Stigge <stigge@antcom.de>
Subject: Re: [PATCH v2] mmc: mmci.c: Defer probe() in case of yet uninitialized
 GPIOs
Date: Sat, 16 Jun 2012 21:04:17 +0200
Message-ID: <4FDCD8B1.5000407@antcom.de>
References: <1339865375-22314-1-git-send-email-stigge@antcom.de> <201206161723.23768.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201206161723.23768.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, rmk+kernel@arm.linux.org.uk, ulf.hansson@stericsson.com, linus.walleij@linaro.org, sebastian.rasmussen@stericsson.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, aletes.xgr@gmail.com
List-Id: linux-mmc@vger.kernel.org

On 16/06/12 19:23, Arnd Bergmann wrote:
> On Saturday 16 June 2012, Roland Stigge wrote:
>> +       if (of_get_property(np, "wp-gpios", NULL)) {
>> +               pdata->gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
>> +               if (pdata->gpio_wp == -ENODEV)
>> +                       pdata->gpio_wp = -EPROBE_DEFER;
>> +       } else {
>> +               pdata->gpio_wp = -ENODEV;
>> +       }
> 
> This is still very ugly and there is a certain danfer that we might
> have to duplicate this across more drivers. Can't we make
> of_get_named_gpio_flags return -EPROBE_DEFER in cases where we can't
> find the GPIO number yet but still have a chance of returning it at
> a later point?

OK, will post a new patch.

Roland
