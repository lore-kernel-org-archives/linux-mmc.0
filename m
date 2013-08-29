From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 0/6] dma: edma: Support scatter-lists of any length
Date: Thu, 29 Aug 2013 18:05:39 -0500
Message-ID: <1377817545-18015-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Matt Porter <matt-agtwNxEcTQJWk0Htik3J/w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Koen Kooi <koen-QLwJDigV5abLmq1fohREcCpxlwaOVQ5f@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Franklin Cooper <fcooper-l0cyMroinI0@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The following series adds support to EDMA driver to enable DMA of
scatter-gather lists of arbitrary length, but still make use of only
a certain MAX number of slots at a time for a given channel. Thus
free-ing up the rest of the slots to other slaves/channels.  With this
there is no need for slave drivers to query the EDMA driver about how
much is the MAX it can send at a time as done in [1]. Drivers can send
SG lists of any number of entries to DMA. Reference discussion at [2].

With this, all the patches for MMC and EDMA related to "sg limits" can be
dropped.

Tested omap-aes and omap_hsmmc drivers with different MAX number of slots,
even just 1. In the case where it is 1, only 1-slot is used to DMA an
entire scatter list of arbitrary length.
Since this series touches EDMA private API code also shared with davinci-pcm,
playback of a 16-bit 44.1KHz audio file with davinci-pcm has been tested.

Sample test run with 1 vs 16 (MAX number of slots/SG) in omap-aes driver:
MAX slots = 1:
 (128 bit key, 8192 byte blocks): 1266 operations in 1 seconds (10371072 bytes)
MAX slots = 16:
 (128 bit key, 8192 byte blocks): 1601 operations in 1 seconds (13115392 bytes)

Note: For the above test, 8K buffer is mapped into SG list of size 2 so
only 2 slots are required. So beyond size 2, there will not be any noticeable
performance improvement. But above experiment just shows as proof of concept
that even using 1 slot is managed by just DMA'ing 1 SG entry at a time.

Patch series history:
v1: The initial patch series
v2: Several style related cleanups.
v3: Rewrote major portions of the series to avoid usage of error interrupts.
v4: Go back to v1: After performing tests, it is determined that the v1
series is a good enough approach and that v3 triggers problems in certain cases.
Tests have shown that there is not any noticeable performance difference between
using vs not using error interrupts. v4 also squashes some patches in v1.
At this point, we are freezing the overall architecture of the patch series to v4.

[1] https://lkml.org/lkml/2013/7/18/432
[2] http://marc.info/?l=linux-omap&m=137416733628831&w=2

Joel Fernandes (6):
  dma: edma: Setup parameters to DMA MAX_NR_SG at a time
  dma: edma: Write out and handle MAX_NR_SG at a given time
  ARM: edma: Add function to manually trigger an EDMA channel
  dma: edma: Find missed events and issue them
  dma: edma: Leave linked to Null slot instead of DUMMY slot
  dma: edma: Remove limits on number of slots

 arch/arm/common/edma.c             |  17 ++++
 drivers/dma/edma.c                 | 164 ++++++++++++++++++++++++++++---------
 include/linux/platform_data/edma.h |   2 +
 3 files changed, 144 insertions(+), 39 deletions(-)

-- 
1.8.1.2
