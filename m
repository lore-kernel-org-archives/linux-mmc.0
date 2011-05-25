From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v3 0/4] Consolidate sdhci pltfm & OF drivers and get them self
	registered
Date: Wed, 25 May 2011 19:01:50 +0800
Message-ID: <1306321314-2493-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
	<mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Anton Vorontsov <cbouatmailru-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Saeed Bishara <saeed-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Xiaobo Xie <X.Xie-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Mike Rapoport <mike-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Albert Herranz <albert_herranz-mRCrAkd8dF0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Here are what the patch set does.

* Remove .probe and .remove hooks from sdhci-pltfm.c and make it be
  a pure common helper function providers.
* Add .probe and .remove hooks for sdhci pltfm drivers sdhci-cns3xxx,
  sdhci-dove, sdhci-tegra, and sdhci-esdhc-imx to make them self
  registered with calling helper functions created above.
* Migrate the use of sdhci_of_host and sdhci_of_data to
  sdhci_pltfm_host and sdhci_pltfm_data, so that OF version host and
  data structure works can be saved, and pltfm version works for both
  cases.
* Add OF common helper stuff into sdhci-pltfm.c, and make OF version
  sdhci drivers sdhci-of-esdhc and sdhci-of-hlwd become self
  registered as well, so that sdhci-of-core.c and sdhci-of.h can be
  removed.
* Eliminate include/linux/mmc/sdhci-pltfm.h with moving stuff into
  drivers/mmc/host/sdhci-pltfm.h.

And the benefits we gain from the changes are:

* Get the sdhci device driver follow the Linux trend that driver
  makes the registration by its own.
* sdhci-pltfm.c becomes simple and clean as it only has common helper
  stuff there now.
* All sdhci device specific things are going back its own driver.
* The dt and non-dt drivers are consolidated to use the same pair of
  .probe and .remove hooks.

Changes since v2:
* Drop imx mpc esdhc consolidation
* Fix checkpatch errors
* Add sdhci-of-core.c copyright into sdhci-pltfm.c

Changes since v1:
* Rebase on cjb's mmc-next tree
* Introduce helper function pair sdhci_pltfm_register and
  sdhci_pltfm_unregister
* Eliminate variable 'scratch' in .remove hook to make the code
  look simple
* Return ERR_PTR in sdhci_pltfm_init and use IS_ERR/PTR_ERR to check
  return value in .probe hooks
* Correct MODULE_AUTHOR statement
* Split esdhc conlidation patch to ease reviewing

Shawn Guo (4):
      mmc: sdhci: make sdhci-pltfm device drivers self registered
      mmc: sdhci: eliminate sdhci_of_host and sdhci_of_data
      mmc: sdhci: make sdhci-of device drivers self registered
      mmc: sdhci: merge two sdhci-pltfm.h into one

 drivers/mmc/host/Kconfig           |   47 +++----
 drivers/mmc/host/Makefile          |   18 +--
 drivers/mmc/host/sdhci-cns3xxx.c   |   43 ++++++-
 drivers/mmc/host/sdhci-dove.c      |   42 ++++++-
 drivers/mmc/host/sdhci-esdhc-imx.c |  114 +++++++++++-----
 drivers/mmc/host/sdhci-of-core.c   |  250 ---------------------------------
 drivers/mmc/host/sdhci-of-esdhc.c  |   85 +++++++++---
 drivers/mmc/host/sdhci-of-hlwd.c   |   66 ++++++++--
 drivers/mmc/host/sdhci-of.h        |   42 ------
 drivers/mmc/host/sdhci-pltfm.c     |  266 ++++++++++++++++++++----------------
 drivers/mmc/host/sdhci-pltfm.h     |   39 +++++-
 drivers/mmc/host/sdhci-tegra.c     |  116 +++++++++++-----
 include/linux/mmc/sdhci-pltfm.h    |   35 -----
 13 files changed, 578 insertions(+), 585 deletions(-)

Regards,
Shawn
