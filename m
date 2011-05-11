From: Per Forlin <per.forlin-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: [PATCH v4] sdio: optimized SDIO IRQ handling for single irq
Date: Wed, 11 May 2011 09:53:35 +0200
Message-ID: <1305100416-5395-1-git-send-email-per.forlin@linaro.org>
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
To: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Optimize performance for single irq

Changes since v2.
 * Rebase on mmc-next, change of line numbers no code changes.

Stefan Nilsson XK (1):
  sdio: optimized SDIO IRQ handling for single irq

 drivers/mmc/core/sdio_irq.c |   33 ++++++++++++++++++++++++++++++++-
 include/linux/mmc/card.h    |    1 +
 2 files changed, 33 insertions(+), 1 deletions(-)

-- 
1.7.4.1
