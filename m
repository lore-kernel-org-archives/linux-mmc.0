From: Greg KH <gregkh@suse.de>
Subject: [09/34] mmc: atmel-mci: remove data error interrupt after xfer
Date: Mon, 24 May 2010 15:59:41 -0700
Message-ID: <20100524230350.146100807@clark.site>
References: <20100524230418.GA12770@kroah.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100524230418.GA12770@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: stable-review@kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

2.6.34-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Nicolas Ferre <nicolas.ferre@atmel.com>

commit abc2c9fdf636c4335a8d72ac3c5ae152bca44b68 upstream.

Disable data error interrupts while we are actually recording that there
is not such errors.  This will prevent, in some cases, the warning message
printed at new request queuing (in atmci_start_request()).

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/mmc/host/atmel-mci.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -1230,6 +1230,7 @@ static void atmci_tasklet_func(unsigned
 			} else {
 				data->bytes_xfered = data->blocks * data->blksz;
 				data->error = 0;
+				mci_writel(host, IDR, ATMCI_DATA_ERROR_FLAGS);
 			}
 
 			if (!data->stop) {
