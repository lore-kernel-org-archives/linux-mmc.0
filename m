From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 00/34] i.MX multi-platform support
Date: Mon, 17 Sep 2012 11:38:13 +0000
Message-ID: <201209171138.13327.arnd@arndb.de>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <20120917075138.GN6180@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120917075138.GN6180@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, linux-fbdev@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Chris Ball <cjb@laptop.org>, linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@freescale.com>, Vinod Koul <vinod.koul@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Javier Martin <javier.martin@vista-silicon.com>, Andrew Morton <akpm@linux-foundation.org>, Shawn
List-Id: linux-mmc@vger.kernel.org

On Monday 17 September 2012, Sascha Hauer wrote:
> On Mon, Sep 17, 2012 at 01:34:29PM +0800, Shawn Guo wrote:
> > The series enables multi-platform support for imx.  Since the required
> > frameworks (clk, pwm) and spare_irq have already been adopted on imx,
> > the series is all about cleaning up mach/* headers.  Along with the
> > changes, arch/arm/plat-mxc gets merged into arch/arm/mach-imx.
> > 
> > It's based on a bunch of branches (works from others), Rob's initial
> > multi-platform series, Arnd's platform-data and smp_ops (Marc's) and
> > imx 3.7 material (Sascha and myself).
> > 
> > It's available on branch below.
> > 
> >   git://git.linaro.org/people/shawnguo/linux-2.6.git imx/multi-platform
> > 
> > It's been tested on imx5 and imx6, and only compile-tested on imx2 and
> > imx3, so testing on imx2/3 are appreciated.
> 
> Great work! This really pushes the i.MX architecture one step closer to
> a clean code base.

I agree, this series is wonderful, I thought it would take much longer
to get this far.

Two small comments on the last two patches from me, but overall I really
love it.

Acked-by: Arnd Bergmann <arnd@arndb.de>
