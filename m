From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [FYI 0/4] arm: mmci: example implementation of double buffering
Date: Wed, 12 Jan 2011 19:19:39 +0100
Message-ID: <1294856383-14187-1-git-send-email-per.forlin@linaro.org>
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
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The mmci host driver implementation for double buffering is not intended
nor ready for mainline yet. It is only an example of how to implement
pre_req() and post_req(). The reason for this is that the basic DMA
support for MMCI is not complete yet.

This patch series depends on
"[PATCH 0/5] mmc: add double buffering for mmc block requests"

Linus Walleij (1):
  mmci: add PrimeCell generic DMA to MMCI/PL180

Per Forlin (1):
  ARM: mmci: add support for double buffering

Ulf Hansson (2):
  mmci: fixup broken_blockend variant patch
  MMCI: Corrections for DMA

 drivers/mmc/host/mmci.c   |  538 ++++++++++++++++++++++++++++++++++++++-------
 drivers/mmc/host/mmci.h   |   21 ++-
 include/linux/amba/mmci.h |   16 ++
 3 files changed, 496 insertions(+), 79 deletions(-)
