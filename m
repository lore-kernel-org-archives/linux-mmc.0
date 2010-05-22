From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 3/8] drivers/mmc/host: Use ERR_CAST
Date: Sat, 22 May 2010 12:00:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1005221159480.13021@ask.diku.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

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

---
 drivers/mmc/host/sdhci-pci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -u -p a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
--- a/drivers/mmc/host/sdhci-pci.c
+++ b/drivers/mmc/host/sdhci-pci.c
@@ -628,7 +628,7 @@ static struct sdhci_pci_slot * __devinit
 	host = sdhci_alloc_host(&pdev->dev, sizeof(struct sdhci_pci_slot));
 	if (IS_ERR(host)) {
 		dev_err(&pdev->dev, "cannot allocate host\n");
-		return ERR_PTR(PTR_ERR(host));
+		return ERR_CAST(host);
 	}
 
 	slot = sdhci_priv(host);
