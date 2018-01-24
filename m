From: "Cunningham, Joel" <Joel.Cunningham@garmin.com>
Subject: [PATCH] mmc: update sdio_claim_irq documentation
Date: Wed, 24 Jan 2018 22:57:46 +0000
Message-ID: <7464B52C8785D749B3908E8649D517950151D5340A@OLAWPA-EXMB02.ad.garmin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-co1nam03on0137.outbound.protection.outlook.com ([104.47.40.137]:54110
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932884AbeAXW5v (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 24 Jan 2018 17:57:51 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>

I have a 3rd party driver which calls sdio_claim_host (and sdio_release_hos=
t) in its IRQ handler, the comment documentation for sdio_claim_irq() cause=
d confusion about whether this was allowed, even though the implementation =
supports recursive claims and the driver is functioning without issue.

If the intention is that recursive claims are supported, the below patch (b=
ased on mmc-next) updates the documentation to demote the "must not" to a "=
does not need to"

Joel

From: Joel Cunningham <joel.cunningham@garmin.com>

Update documentation for sdio_claim_irq to relax the wording which
describes whether or not its safe to call sdio_claim/release_host in
an IRQ handler registered via sdio_claim_irq. The sdio_claim_host
implementation has support (via __mmc_claim_host) to be recursively
claimed

Signed-off-by: Joel Cunningham <joel.cunningham@garmin.com>
---
 drivers/mmc/core/sdio_irq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
index 7a2eaf8410a3..37a1a4bcb778 100644
--- a/drivers/mmc/core/sdio_irq.c
+++ b/drivers/mmc/core/sdio_irq.c
@@ -277,8 +277,8 @@ static void sdio_single_irq_set(struct mmc_card *card)
  *
  *	Claim and activate the IRQ for the given SDIO function. The provided
  *	handler will be called when that IRQ is asserted.  The host is always
- *	claimed already when the handler is called so the handler must not
- *	call sdio_claim_host() nor sdio_release_host().
+ *	claimed already when the handler is called so the handler does not
+ *	need to call sdio_claim_host() or sdio_release_host().
  */
 int sdio_claim_irq(struct sdio_func *func, sdio_irq_handler_t *handler)
 {
--=20
2.14.1

