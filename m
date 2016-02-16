From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH v4 00/13] mmc: use sdhci_pltfm_init for private
 allocation and clean up
Date: Tue, 16 Feb 2016 10:38:02 +0800
Message-ID: <20160216103802.266f356c@xhacker>
References: <1453803353-6266-1-git-send-email-jszhang@marvell.com>
	<CAPDyKFpFSTYsAUCG9nFnnzmVsA3zm4hAPO8+6REArt9BJtn+0Q@mail.gmail.com>
	<56B8A1A1.2080408@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56B8A1A1.2080408@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ludovic Desroches <ludovic.desroches@atmel.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Michal Simek <michal.simek@xilinx.com>, =?UTF-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice CHOTARD <patrice.chotard@st.com>, Thierry Reding <thierry.reding@gmail.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, kernel@stlinux.com, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-rpi-kernel@lists.infradead.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

Dear Adrian, Ulf,

On Mon, 8 Feb 2016 16:09:37 +0200 Adrian Hunter wrote:

> On 04/02/16 12:38, Ulf Hansson wrote:
> > + Adrian
> > 
> > On 26 January 2016 at 11:15, Jisheng Zhang <jszhang@marvell.com> wrote:  
> >> These patches are to complete the TODOs in Commit 0e748234293f ("mmc:
> >> sdhci: Add size for caller in init+register"), I.E:
> >>
> >> - todo: migrate clients to using allocation this way
> >> - todo: remove priv variable once migration is complete
> >>
> >> Since v3:
> >>  - based on v4.5-rc1
> >>  - add Ludovic's ack for sdhci-of-at91 changes
> >>  - fix use-after-free in some drivers: some host drivers still needs to
> >>    access sdhci_pltfm_host->private after sdhci_pltfm_unregister(), but
> >>    the private should be already freed by sdhci_pltfm_unregister.
> >>  - add patch5 to fix one clk bug in sdhci_arasan_remove(). IMHO, It's
> >>    better to add this patch to fixes rather than waiting for next merge
> >>    window
> >>
> >> Since v2:
> >>  - based on mmc next tree and remove all priv usage introduced in newly
> >>    commits in this tree
> >>  - don't break two lines if sdhci_pltfm_init() call could be put into
> >>    one line. Thank Ludovic Desroches.
> >>
> >> Since v1:
> >>  - add new patch03 to factorise sdhci_msm_pdata outisde of sdhci_msm_host.
> >>    This is to fix drivers/mmc/host/sdhci-msm.c:440:32: warning: 'msm_host'
> >>    is used uninitialized in this function [-Wuninitialized]
> >>  - Add Arnd's Ack for all patches except patch3 which is new in v2
> >>
> >>
> >> Jisheng Zhang (13):
> >>   mmc: sdhci-bcm2835: use sdhci_pltfm_init for private allocation
> >>   mmc: sdhci-esdhc-imx: use sdhci_pltfm_init for private allocation
> >>   mmc: sdhci-msm: factorise sdhci_msm_pdata outisde of sdhci_msm_host
> >>   mmc: sdhci-msm: use sdhci_pltfm_init for private allocation
> >>   mmc: sdhci-of-arasan: fix clk issue in sdhci_arasan_remove()
> >>   mmc: sdhci-of-arasan: use sdhci_pltfm_init for private allocation
> >>   mmc: sdhci-of-at91: use sdhci_pltfm_init for private allocation
> >>   mmc: sdhci-of-esdhc: use sdhci_pltfm_init for private allocation
> >>   mmc: sdhci-pxav3: use sdhci_pltfm_init for private allocation
> >>   mmc: sdhci-st: use sdhci_pltfm_init for private allocation
> >>   mmc: sdhci-tegra: use sdhci_pltfm_init for private allocation
> >>   mmc: sdhci-pxav2: remove unnecessary assignment of pltfm_host->priv
> >>   mmc: sdhci-pltfm: remove priv variable from sdhci_pltfm_host
> >>
> >>  drivers/mmc/host/sdhci-bcm2835.c   | 14 +++----------
> >>  drivers/mmc/host/sdhci-esdhc-imx.c | 38 ++++++++++++++++--------------------
> >>  drivers/mmc/host/sdhci-msm.c       | 25 +++++++++++-------------
> >>  drivers/mmc/host/sdhci-of-arasan.c | 33 +++++++++++++++----------------
> >>  drivers/mmc/host/sdhci-of-at91.c   | 33 ++++++++++++++-----------------
> >>  drivers/mmc/host/sdhci-of-esdhc.c  | 19 +++++++++---------
> >>  drivers/mmc/host/sdhci-pltfm.h     |  1 -
> >>  drivers/mmc/host/sdhci-pxav2.c     |  1 -
> >>  drivers/mmc/host/sdhci-pxav3.c     | 20 ++++++++-----------
> >>  drivers/mmc/host/sdhci-st.c        | 40 +++++++++++++++++++-------------------
> >>  drivers/mmc/host/sdhci-tegra.c     | 21 +++++++-------------
> >>  11 files changed, 106 insertions(+), 139 deletions(-)
> >>
> >> --
> >> 2.7.0
> >>  
> > 
> > To avoid confusions. I don't intend to pick up any further sdhci
> > patches, unless they are acked by Adrian Hunter.  
> 
> The patches look OK, although patch 6 doesn't apply cleanly anymore.
> Nevertheless:

Sorry for being late. I'm just back from vacation.
Thank you very much for reviewing! I'll send a new series based on Ulf's next
branch.

> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
