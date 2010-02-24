From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH 0/2] mmc: omap_hsmmc: support SDIO cards (#2)
Date: Wed, 24 Feb 2010 12:07:17 +0200
Message-ID: <4B84FA55.5040804@compulab.co.il>
References: <cover.1266847842.git.david.vrabel@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <cover.1266847842.git.david.vrabel@csr.com>
Sender: linux-omap-owner@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, madhu.cr@ti.com, Mike Rapoport <mike@compulab.co.il>
List-Id: linux-mmc@vger.kernel.org

Hi David,

David Vrabel wrote:
> These patches add support for SDIO cards to the omap_hsmmc driver.
> Power management changes to prevent SDIO cards from being turned off
> and losing all state, and card interrupts.

I've tested your patches with libertas_sdio and after several small
additions I've made it work.

  drivers/mmc/host/omap_hsmmc.c |   19 +++++++++++++------
  1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 53fa85d..6ed71b7 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -82,6 +82,7 @@
  #define BWR_ENABLE		(1 << 4)
  #define BRR_ENABLE		(1 << 5)
  #define CTPL			(1 << 11)
+#define CLKEXTFREE		(1 << 16)
  #define INIT_STREAM		(1 << 1)
  #define DP_SELECT		(1 << 21)
  #define DDIR			(1 << 4)
@@ -189,6 +190,7 @@ struct omap_hsmmc_host {
  	int			protect_card;
  	int			reqs_blocked;
  	int			use_reg;
+	int			sdio_int;

  	struct	omap_mmc_platform_data	*pdata;
  };
@@ -763,16 +765,19 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
  	struct mmc_data *data)
  {
  	int cmdreg = 0, resptype = 0, cmdtype = 0;
+	int int_en_mask = INT_EN_MASK;

  	dev_dbg(mmc_dev(host->mmc), "%s: CMD%d, argument 0x%08x\n",
  		mmc_hostname(host->mmc), cmd->opcode, cmd->arg);
  	host->cmd = cmd;

  	if (host->use_dma)
-		OMAP_HSMMC_WRITE(host->base, IE,
-				 INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE));
-	else
-		OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
+		int_en_mask &= ~(BRR_ENABLE | BWR_ENABLE);
+
+	if (host->sdio_int)
+		int_en_mask |= CIRQ;
+
+	OMAP_HSMMC_WRITE(host->base, IE, int_en_mask);

  	host->response_busy = 0;
  	if (cmd->flags & MMC_RSP_PRESENT) {
@@ -1619,10 +1624,12 @@ static void omap_hsmmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
  	if (enable) {
  		clk_enable(host->fclk);
  		ie |= CIRQ_ENABLE;
-		con |= CTPL;
+		con |= CTPL | CLKEXTFREE;
+		host->sdio_int = 1;
  	} else {
  		ie &= ~CIRQ_ENABLE;
-		con &= ~CTPL;
+		con &= ~(CTPL | CLKEXTFREE);
+		host->sdio_int = 0;
  	}
  	OMAP_HSMMC_WRITE(host->base, CON, con);
  	OMAP_HSMMC_WRITE(host->base, IE, ie);
-- 
1.6.4.4


> I've been unable to test these exact patches as I only have an N900 for 
> testing and the N900 support in mainline is incomplete.
> 
> Changes since v1:
> - (hopefully) get all cards working again by removing a second call to
>   read MMCi_STAT in the interrupt handler.
> - flush posted writes after enabling/disabling SDIO interrupts.
> - tweak the FIXME commit on disabling FCLK to better match what really
>   going on (at least I think so anyway).
> 
> David Vrabel (2):
>   mmc: omap_hsmmc: don't turn SDIO cards off when idle
>   mmc: omap_hsmmc: enable SDIO card interrupts
> 
>  drivers/mmc/host/omap_hsmmc.c |  114 ++++++++++++++++++++++++++++-------------
>  1 files changed, 79 insertions(+), 35 deletions(-)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Sincerely yours,
Mike.

