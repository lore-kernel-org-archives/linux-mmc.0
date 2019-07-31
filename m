From: Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] mmc: atmel-mci: Mark expected switch fall-throughs
Date: Wed, 31 Jul 2019 09:06:07 -0700
Message-ID: <201907310905.B90C6E25@keescook>
References: <20190729000123.GA23902@embeddedor>
 <20190731113216.ztxckd54a74g2lw5@M43218.corp.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190731113216.ztxckd54a74g2lw5@M43218.corp.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 31, 2019 at 01:32:16PM +0200, Ludovic Desroches wrote:
> > drivers/mmc/host/atmel-mci.c:2426:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
> >    host->caps.need_notbusy_for_read_ops = 1;
> >    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> > drivers/mmc/host/atmel-mci.c:2427:2: note: here
> >   case 0x100:
> >   ^~~~
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> I don't know if there is a policy in the kernel about the expression to
> use. As this one does the job

Yup, documented here:
https://www.kernel.org/doc/html/latest/process/deprecated.html#implicit-switch-case-fall-through

> Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks!

-- 
Kees Cook
