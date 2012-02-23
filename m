From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v2 0/6] mmc: omap_hsmmc: Clean up use/abuse of pdev->id
Date: Thu, 23 Feb 2012 16:56:43 +0530
Message-ID: <1329996409-26861-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Re-sending as these patches did not make it to the lists due to
issues with my 'git send-email'

This series mainly cleans up all instances of hardcoding's in
the driver based on pdev->id. This is cleanup leading to the
DT adaptation of omap_hsmmc driver.

v2 mainly has some minor changes to get rid of a debug print
which was still using host->id and getting rid of 'id' field
entirely from omap_hsmmc_host struct.

The series is tested on OMAP4SDP, OMAP4panda, OMAP3beagle and OMAP2430SDP
boards.

regards,
Rajendra

Balaji T K (3):
  mmc: omap_hsmmc: use platform_get_resource_byname for tx/rx DMA
    channels
  mmc: omap_hsmmc: remove unused .set_sleep function
  mmc: omap_hsmmc: Use OMAP_HSMMC_SUPPORTS_DUAL_VOLT flag to remove
    host->id based hardcoding

Rajendra Nayak (3):
  mmc: omap_hsmmc: Get rid of omap_hsmmc_1_set_power function
  mmc: omap_hsmmc: Get rid of omap_hsmmc_4_set_power function
  mmc: omap_hsmmc: Don't expect MMC1 to always have vmmc supply

 arch/arm/plat-omap/include/plat/mmc.h |    2 -
 drivers/mmc/host/omap_hsmmc.c         |  175 +++------------------------------
 2 files changed, 16 insertions(+), 161 deletions(-)
