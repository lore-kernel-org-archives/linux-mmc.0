From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] mmc: atmel-mci: Mark expected switch fall-throughs
Date: Thu, 1 Aug 2019 09:11:36 +0200
Message-ID: <20190801071136.37yjjr3kmdhfyxna@M43218.corp.atmel.com>
References: <20190729000123.GA23902@embeddedor>
 <20190731113216.ztxckd54a74g2lw5@M43218.corp.atmel.com>
 <201907310905.B90C6E25@keescook>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <201907310905.B90C6E25@keescook>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kees Cook <keescook@chromium.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ulf Hansson <ulf.hansson@linaro.org>, Alexandre Belloni <alexandre.belloni@bootlin.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Jul 31, 2019 at 09:06:07AM -0700, Kees Cook wrote:
> On Wed, Jul 31, 2019 at 01:32:16PM +0200, Ludovic Desroches wrote:
> > > drivers/mmc/host/atmel-mci.c:2426:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
> > >    host->caps.need_notbusy_for_read_ops = 1;
> > >    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
> > > drivers/mmc/host/atmel-mci.c:2427:2: note: here
> > >   case 0x100:
> > >   ^~~~
> > > 
> > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > 
> > I don't know if there is a policy in the kernel about the expression to
> > use. As this one does the job
> 
> Yup, documented here:
> https://www.kernel.org/doc/html/latest/process/deprecated.html#implicit-switch-case-fall-through

Thanks for the pointer.

Regards

Ludovic

> 
> > Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> 
> Thanks!
> 
> -- 
> Kees Cook
