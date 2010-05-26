From: akpm@linux-foundation.org
Subject: [patch 022/203] drivers/mmc/host: use ERR_CAST
Date: Wed, 26 May 2010 14:42:11 -0700
Message-ID: <201005262142.o4QLgB21015399@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36100 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752952Ab0EZVyG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 26 May 2010 17:54:06 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, julia@diku.dk, linux-mmc@vger.kernel.org

From: Julia Lawall <julia@diku.dk>

Use ERR_CAST(x) rather than ERR_PTR(PTR_ERR(x)).  The former makes more
clear what is the purpose of the operation, which otherwise looks like a
no-op.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
type T;
T x;
identifier f;
@@

T f (...) { <+...
- ERR_PTR(PTR_ERR(x))
+ x
 ...+> }

@@
expression x;
@@

- ERR_PTR(PTR_ERR(x))
+ ERR_CAST(x)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/sdhci-pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mmc/host/sdhci-pci.c~drivers-mmc-host-use-err_cast drivers/mmc/host/sdhci-pci.c
--- a/drivers/mmc/host/sdhci-pci.c~drivers-mmc-host-use-err_cast
+++ a/drivers/mmc/host/sdhci-pci.c
@@ -628,7 +628,7 @@ static struct sdhci_pci_slot * __devinit
 	host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pci_slot));
 	if (IS_ERR(host)) {
 		dev_err(&pdev->dev, "cannot allocate host\n");
-		return ERR_PTR(PTR_ERR(host));
+		return ERR_CAST(host);
 	}
 
 	slot = sdhci_priv(host);
_
