From: Greg KH <gregkh@suse.de>
Subject: [114/116] s3cmci: initialize default platform data no_wprotect and no_detect with 1
Date: Tue, 30 Mar 2010 15:56:32 -0700
Message-ID: <20100330225714.754838073@linux.site>
References: <20100330230600.GA28802@kroah.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100330230600.GA28802@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: stable-review@kernel.org, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Lars-Peter Clausen <lars@metafoo.de>, linux-mmc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>
List-Id: linux-mmc@vger.kernel.org

2.6.32-stable review patch.  If anyone has any objections, please let us know.

------------------

commit c212808a1ba6bfba489006399b8152a047305acf upstream.

If no platform_data was givin to the device it's going to use it's default
platform data struct which has all fields initialized to zero.  As a
result the driver is going to try to request gpio0 both as write protect
and card detect pin.  Which of course will fail and makes the driver
unusable

Previously to the introduction of no_wprotect and no_detect the behavior
was to assume that if no platform data was given there is no write protect
or card detect pin.  This patch restores that behavior.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/mmc/host/s3cmci.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1361,6 +1361,8 @@ static struct mmc_host_ops s3cmci_ops =
 static struct s3c24xx_mci_pdata s3cmci_def_pdata = {
 	/* This is currently here to avoid a number of if (host->pdata)
 	 * checks. Any zero fields to ensure reaonable defaults are picked. */
+	.no_wprotect = 1,
+	.no_detect = 1,
 };
 
 #ifdef CONFIG_CPU_FREQ
