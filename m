From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v11 0/8] ] DMA Engine support for AM33XX
Date: Tue, 18 Jun 2013 15:07:40 +0200
Message-ID: <201306181507.40849.arnd@arndb.de>
References: <1371537499-12970-1-git-send-email-joelagnel@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1371537499-12970-1-git-send-email-joelagnel@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joel A Fernandes <joelagnel@ti.com>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source@linux.davincidsp.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Linux Documentation List <linux-doc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, Koen Kooi <koen@beagleboard.org>, Rob Herring <rob.herring@calxeda.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Vinod Koul <vinod.koul@intel.com>, Jason Kridner <jkridner@beagleboard.org>, Rob Landley <rob@landley.net>, Linux SPI Devel List <spi-devel-general@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, Linux OMAP List <linux-omap@vger.kernel.org>Linux ARM Kernel List <linux->
List-Id: linux-mmc@vger.kernel.org

On Tuesday 18 June 2013, Joel A Fernandes wrote:
> 
> This series is a repost of Matt Porter's EDMA patches for AM33XX EDMA support
> with changes for few pending review comments on v9 series.
> 
> Currently this is required for AM33XX (Beaglebone or EVM) to access MMC
> and be able mount to rootfs and boot till command prompt over MMC.
> Unless there are other pending review comments, I hope this series can
> make it into 3.11 merge window, the dependent series has been posted at [1]
> and completed review.
> 
> Tested EDMA on AM1808 EVM and AM33XX Beaglebone with MMC.
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

The binding looks good now.

My usual comment about the fact that we shouldn't use a filter function in
.xlate() applies here, but that is more about the missing interface of
the dmaengine layer than the particular driver.

	Arnd
