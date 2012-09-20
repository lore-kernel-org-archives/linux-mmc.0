From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 00/34] i.MX multi-platform support
Date: Thu, 20 Sep 2012 15:56:56 +0000
Message-ID: <201209201556.57171.arnd@arndb.de>
References: <1348123547-31082-1-git-send-email-shawn.guo@linaro.org>
 <201209200739.34899.arnd@arndb.de>
 <20120920145342.GI2450@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20120920145342.GI2450@S2101-09.ap.freescale.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, linux-fbdev@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Chris Ball <cjb@laptop.org>, linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org, rtc-linux@googlegroups.com, Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Javier Martin <javier.martin@vista-silicon.com>, Andrew Morton <akpm@linux-foundation.org>, Guennadi
List-Id: linux-mmc@vger.kernel.org

On Thursday 20 September 2012, Shawn Guo wrote:
> 
> On Thu, Sep 20, 2012 at 07:39:34AM +0000, Arnd Bergmann wrote:
> > The first five branches are scheduled to go through the arm-soc tree, so
> > I'm fine with that. For the sound/for-3.7 branch, I'd like to know when
> > to expect that hitting mainline. If it always gets in very early during the
> > merge window, it's probably ok to put the imx/multi-platform patches into
> > the same branch as the other ones in arm-soc and wait for the sound stuff
> > to hit mainline first, otherwise I'd suggest we start a second
> > next/multiplatform-2 branch for imx and send the first part early on
> > but then wait with the second batch before sound gets in.
> > 
> It seems that we will have to go with next/multiplatform-2.  I just
> tried to merge the series with linux-next together, and got some
> non-trivial conflicts with media and mtd tree.  I might have to rebase
> my series on top of these trees to sort out those conflicts.  That said,
> I will have several dependencies outside arm-soc tree, and have to pend
> my series until all those trees get merged into mainline.

Ok, fair enough. I think we can put it in arm-soc/for-next as a staging
branch anyway to give it some exposure to linux-next, and then we can
decide whether a rebase is necessary before sending it to Linus.

	Arnd
