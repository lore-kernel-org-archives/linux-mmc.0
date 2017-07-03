From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFT] mmc: tmio: fix CMD12 (STOP) handling
Date: Mon,  3 Jul 2017 21:28:23 +0200
Message-ID: <20170703192823.8116-1-wsa+renesas@sang-engineering.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:45925 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753369AbdGCT2f (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 3 Jul 2017 15:28:35 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, =?UTF-8?q?Jan=20Kl=C3=B6tzke?= <jan.kloetzke@technisat.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Masaharu Hayakawa <masaharu.hayakawa.ry@renesas.com>, Kouei Abe <kouei.abe.cp@renesas.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>

I always anticipated this code to be not correct, but now I had a test
case to prove it. According to all documentation I have, setting the
TMIO_STOP_STP bit ever only worked during block transfers. This bit is
like manually enforcing an autocmd12 during a so far seamless transfer.
It does NOT work when the block transfer had errors. It also does NOT
work with any other cmd except block commands. For all those, CMD12 has
to be treated like any other command. So, basically, we could use this
bit only for mrq->data->stop cmds. But for these, we happily use the
autocmd12 feature using the TMIO_STOP_SEC bit. As a result, the above
bit is not useful for us and we need to treat CMD12 as a regular cmd
always. Just remove the special handling code. Note that the BSP
recognized this issue as well yet had a more cautious solution to the
problem [1]. Which is understandable but makes CMD12 handling even more
complicated.

Checked with a Renesas Salvator-X/M3-W which needed to send CMD12 when
retuning one of my SD cards.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas-bsp.git/commit/?id=2838a2ff8ca776f6d18b7fbbe75f3df8dd64183a

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

So, this is a friendly call for further testing to make sure no regressions
happen. I also put the authors of the BSP patch to CC to check if this patch
also matches their use case. I hope this is fine for these people, please
accept my apologies if not. I just really like to have your opinion on this
patch.

Geert, Simon: any chance you can run this patch on your board farms?

In any case: as far as my understanding goes, if I am wrong with my
assumptions, the worst case is that for older SoCs CMD12 handling might become
a tad more inefficient because we now do in software what was expected to be
done in hardware. However, I am quite sure that the HW feature was always
over-estimated and CMD12 support is simply broken. For my test case and the BSP
patch above, it definately was.

Thanks for any assistance,

   Wolfram


 drivers/mmc/host/tmio_mmc_core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 1851c883bfc82a..fbcd56c58bce24 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -355,12 +355,6 @@ static int tmio_mmc_start_command(struct tmio_mmc_host *host,
 	int c = cmd->opcode;
 	u32 irq_mask = TMIO_MASK_CMD;
 
-	/* CMD12 is handled by hardware */
-	if (cmd->opcode == MMC_STOP_TRANSMISSION && !cmd->arg) {
-		sd_ctrl_write16(host, CTL_STOP_INTERNAL_ACTION, TMIO_STOP_STP);
-		return 0;
-	}
-
 	switch (mmc_resp_type(cmd)) {
 	case MMC_RSP_NONE: c |= RESP_NONE; break;
 	case MMC_RSP_R1:
-- 
2.11.0

