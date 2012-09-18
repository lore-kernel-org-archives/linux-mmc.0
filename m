From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 00/34] i.MX multi-platform support
Date: Tue, 18 Sep 2012 16:05:43 +0800
Message-ID: <20120918080541.GA6377@S2101-09.ap.freescale.net>
References: <1347860103-4141-1-git-send-email-shawn.guo@linaro.org>
 <20120918075213.GD24458@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20120918075213.GD24458@pengutronix.de>
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
Cc: alsa-devel@alsa-project.org, linux-usb@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, linux-fbdev@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, rtc-linux@googlegroups.com, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, Paulius Zaleckas <paulius.zaleckas@teltonika.lt>, Chris Ball <cjb@laptop.org>, linux-media@vger.kernel.org, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, linux-arm-kernel@lists.infradead.org, Fabio Estevam <fabio.estevam@freescale.com>, Vinod Koul <vinod.koul@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, Javier Martin <javier.martin@vista-silicon.com>, Andrew Morton <akpm@l>
List-Id: linux-mmc@vger.kernel.org

On Tue, Sep 18, 2012 at 09:52:13AM +0200, Sascha Hauer wrote:
> I just had a look at the remaining initcalls in arch-imx. Most of them
> are protected with a cpu_is_*, but this one should be fixed before i.MX
> is enabled for multi platform:
> 
> arch/arm/mach-imx/devices/devices.c:48:core_initcall(mxc_device_init);
> 
Ah, I missed that.  Thanks for reminding, Sascha.

Shawn
