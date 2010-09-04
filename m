From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] MMC: move regulator handling closer to core v2
Date: Sat, 04 Sep 2010 09:10:23 +0300
Message-ID: <4C81E2CF.8070406@nokia.com>
References: <1283268367-3525-1-git-send-email-linus.walleij@stericsson.com> <AANLkTik-uLMUz2g2znaF0K43D8CONsGdjrRqxTCqpS_X@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTik-uLMUz2g2znaF0K43D8CONsGdjrRqxTCqpS_X@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Sundar Iyer <sundar.iyer@stericsson.com>, Daniel Mack <daniel@caiaq.de>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>, David Brownell <dbrownell@users.sourceforge.net>, Russell King <rmk+kernel@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>, Cliff Brake <cbrake@bec-systems.com>, "Lavinen Jarkko (Nokia-MS/Helsinki)" <jarkko.lavinen@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Linus Walleij wrote:
> 2010/8/31 Linus Walleij <linus.walleij@stericsson.com>:
> 
>> After discovering a problem in regulator reference counting I
>> took Mark Brown's advice to move the reference count into the
>> MMC core by making the regulator status a member of
>> struct mmc_host.
> 
> This has an Reveiwed-by from the regulator maintainer and
> seems to address all comments, noone is objection so Andrew
> can you pick it up?

One of our contractors had a look at the patch and had this comment:

One comment/question:
/host/mmci.c in function
"static int __devexit mmci_remove(struct amba_device *dev)" there is code:
         if (regulator_is_enabled(host->vcc))
             regulator_disable(host->vcc);
should "ret = mmc_regulator_set_ocr(mmc, host->vcc, 0);" be added here?

> 
> Yours,
> Linus Walleij
> 
