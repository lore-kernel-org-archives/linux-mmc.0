From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH v4 0/4] Extend sdhci-esdhc-imx card_detect and
	write_protect support for mx5
Date: Mon, 27 Jun 2011 12:23:46 +0800
Message-ID: <20110627042345.GA21757@S2100-06.ap.freescale.net>
References: <1308667311-1855-1-git-send-email-shawn.guo@linaro.org>
	<20110627013826.GB21415@S2100-06.ap.freescale.net>
	<m27h88djf6.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <m27h88djf6.fsf@bob.laptop.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Chris Ball <cjb@laptop.org>
Cc: patches@linaro.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, Wolfram Sang <w.sang@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Eric Benard <eric@eukrea.com>, Philip Rakity <prakity@marvell.com>, Arnaud Patard <arnaud.patard@rtp-net.org>
List-Id: linux-mmc@vger.kernel.org

On Sun, Jun 26, 2011 at 11:47:57PM -0400, Chris Ball wrote:
> Hi Shawn,
> 
> On Sun, Jun 26 2011, Shawn Guo wrote: 
> >>  arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c     |    3 +-
> >>  arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c     |    3 +-
> >>  arch/arm/mach-imx/mach-mx25_3ds.c                  |    2 +
> >>  arch/arm/mach-imx/mach-pcm043.c                    |    2 +
> >>  arch/arm/mach-mx5/board-mx51_babbage.c             |   14 +-
> >>  arch/arm/mach-mx5/board-mx53_loco.c                |    4 +
> >>  .../plat-mxc/devices/platform-sdhci-esdhc-imx.c    |   12 ++
> >>  arch/arm/plat-mxc/include/mach/esdhc.h             |   25 +++-
> >>  drivers/mmc/host/sdhci-esdhc-imx.c                 |  140 ++++++++++++--------
> >>  drivers/mmc/host/sdhci.c                           |   29 ++++-
> >>  10 files changed, 165 insertions(+), 69 deletions(-)
> >
> > Is the series ready for being merged?  Or is there anything needs
> > to be done before you do so?
> 
> I'll need to rebase mmc-next onto linux-next before I can merge it,
> because the mach-imx/ board files you're modifying do not exist in
> Linus' tree.  (I don't mind doing that, but it might be easier if
> you had the ARM patches go in via a different tree instead.)
> 
I can ask Sascha to pick up patch #4 with your ack.  But the problem
is patch #4 has to work with #1 applied first, otherwise the CD
interrupt storm will freeze the system.

-- 
Regards,
Shawn
