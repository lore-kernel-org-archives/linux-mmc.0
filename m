From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [RFC PATCH 1/7] mmc: sdhci: Add quirk to indicate no CRC
 stripping in MMC_RSP_136
Date: Tue, 15 Aug 2017 10:27:30 +0300
Message-ID: <872c7194-3d48-47e5-6396-7189bf841a42@intel.com>
References: <20170807160142.12134-1-kishon@ti.com>
 <20170807160142.12134-2-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170807160142.12134-2-kishon@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>
Cc: nsekhar@ti.com, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On 07/08/17 19:01, Kishon Vijay Abraham I wrote:
> TI's implementation of sdhci controller used in DRA7 SoC's doesn't
> strip CRC in responses with length 136 bits. Add quirk to indicate
> the controller does not strip CRC in MMC_RSP_136. If this quirk is
> set sdhci library shouldn't shift the response present in
> SDHCI_RESPONSE register.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 27 +++++++++++++++++++--------
>  drivers/mmc/host/sdhci.h |  2 ++
>  2 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ecd0d4350e8a..ece3751d2a25 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1182,14 +1182,25 @@ static void sdhci_finish_command(struct sdhci_host *host)
>  
>  	if (cmd->flags & MMC_RSP_PRESENT) {
>  		if (cmd->flags & MMC_RSP_136) {
> -			/* CRC is stripped so we need to do some shifting. */
> -			for (i = 0;i < 4;i++) {
> -				cmd->resp[i] = sdhci_readl(host,
> -					SDHCI_RESPONSE + (3-i)*4) << 8;
> -				if (i != 3)
> -					cmd->resp[i] |=
> -						sdhci_readb(host,
> -						SDHCI_RESPONSE + (3-i)*4-1);
> +			if (!(host->quirks2 & SDHCI_QUIRK2_NO_CRC_STRIPPING)) {

This is about the 136-bit response so let's put that in the quirk name.  How about SDHCI_QUIRK2_RSP_136_HAS_CRC

> +				/*
> +				 * CRC is stripped so we need to do some
> +				 * shifting.
> +				 */
> +				for (i = 0; i < 4; i++) {
> +					cmd->resp[i] =
> +						sdhci_readl(host, SDHCI_RESPONSE
> +							    + (3 - i) * 4) << 8;
> +					if (i != 3)
> +						cmd->resp[i] |=
> +						sdhci_readb(host, SDHCI_RESPONSE
> +							    + (3 - i) * 4 - 1);
> +				}
> +			} else {
> +				for (i = 0; i < 4; i++)
> +					cmd->resp[i] =
> +					sdhci_readl(host, SDHCI_RESPONSE +
> +						    (3 - i) * 4);
>  			}

This is all very jammed up against the 80 column margin.  Please make a new patch to separate it into a new function sdhci_read_rsp_136() and then another patch to add the quirk.
i.e. completely untested!

From: Adrian Hunter <adrian.hunter@intel.com>
Date: Tue, 15 Aug 2017 10:22:09 +0300
Subject: [PATCH] mmc: sdhci: Tidy reading 136-bit responses

Read each register only once and move the code to a separate function so
that it is not jammed against the 80 column margin.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 32a0e8f6fb04..21d0b36d642f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1173,6 +1173,23 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 }
 EXPORT_SYMBOL_GPL(sdhci_send_command);
 
+static void sdhci_read_rsp_136(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	int i, reg;
+
+	for (i = 0; i < 4; i++) {
+		reg = SDHCI_RESPONSE + (3 - i) * 4;
+		cmd->resp[i] = sdhci_readl(host, reg);
+	}
+
+	/* CRC is stripped so we need to do some shifting */
+	for (i = 0; i < 4; i++) {
+		cmd->resp[i] =<< 8;
+		if (i != 3)
+			cmd->resp[i] |= cmd->resp[i + 1] >> 24;
+	}
+}
+
 static void sdhci_finish_command(struct sdhci_host *host)
 {
 	struct mmc_command *cmd = host->cmd;
@@ -1182,15 +1199,7 @@ static void sdhci_finish_command(struct sdhci_host *host)
 
 	if (cmd->flags & MMC_RSP_PRESENT) {
 		if (cmd->flags & MMC_RSP_136) {
-			/* CRC is stripped so we need to do some shifting. */
-			for (i = 0;i < 4;i++) {
-				cmd->resp[i] = sdhci_readl(host,
-					SDHCI_RESPONSE + (3-i)*4) << 8;
-				if (i != 3)
-					cmd->resp[i] |=
-						sdhci_readb(host,
-						SDHCI_RESPONSE + (3-i)*4-1);
-			}
+			sdhci_read_rsp_136(host, cmd);
 		} else {
 			cmd->resp[0] = sdhci_readl(host, SDHCI_RESPONSE);
 		}
-- 
1.9.1




>  		} else {
>  			cmd->resp[0] = sdhci_readl(host, SDHCI_RESPONSE);
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0469fa191493..6905131f603d 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -435,6 +435,8 @@ struct sdhci_host {
>  #define SDHCI_QUIRK2_ACMD23_BROKEN			(1<<14)
>  /* Broken Clock divider zero in controller */
>  #define SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN		(1<<15)
> +/* Controller does not have CRC stripped in Command Response */
> +#define SDHCI_QUIRK2_NO_CRC_STRIPPING			(1<<16)
>  
>  	int irq;		/* Device IRQ */
>  	void __iomem *ioaddr;	/* Mapped address */
> 
