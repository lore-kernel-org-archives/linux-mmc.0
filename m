From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: pass IRQF ONESHOT to request threaded
 irq
Date: Mon, 4 Jun 2012 11:19:44 +0100
Message-ID: <20120604101944.GB25646@sirena.org.uk>
References: <201206031529.56170.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201206031529.56170.heiko@sntech.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Heiko St??bner <heiko@sntech.de>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, Jun 03, 2012 at 03:29:55PM +0200, Heiko St??bner wrote:

>  		    request_threaded_irq(sc->ext_cd_irq, NULL,
>  					 sdhci_s3c_gpio_card_detect_thread,
> -					 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +					 IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>  					 dev_name(dev), sc) == 0) {
>  			int status = gpio_get_value(sc->ext_cd_gpio);

Separate issue but shouldn't this be request_any_context_irq()?  Most
GPIOs work just fine in atomic context, though I don't know if the MMC
core limits things.
