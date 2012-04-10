From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] mmc: sdhci: Log what timeout was set if the timeout is too large
Date: Tue, 10 Apr 2012 10:28:46 -0400
Message-ID: <8762d7wti9.fsf@laptop.org>
References: <1334054163-25459-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46743 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752228Ab2DJO2q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 10 Apr 2012 10:28:46 -0400
In-Reply-To: <1334054163-25459-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	(Mark Brown's message of "Tue, 10 Apr 2012 11:36:03 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-mmc@vger.kernel.org

Hi Mark,

On Tue, Apr 10 2012, Mark Brown wrote:
> Rather than just logging that we came up with an excessively large timeout
> say what the timeout was, this may provide some clues as to what the issue
> is.
>
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> ---
>
> I'm seeing reams of these from my s3c64xx based system, looks like it's
> always coming out with a timeout of 0xf which is only just out of range.
>
>  drivers/mmc/host/sdhci.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 9aa77f3..8407a0b 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -680,8 +680,8 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
>  	}
>  
>  	if (count >= 0xF) {
> -		pr_warning("%s: Too large timeout requested for CMD%d!\n",
> -		       mmc_hostname(host->mmc), cmd->opcode);
> +		pr_warning("%s: Too large timeout %x requested for CMD%d!\n",
> +			   mmc_hostname(host->mmc), count, cmd->opcode);
>  		count = 0xE;
>  	}

Thanks, pushed to mmc-next for 3.5 with a trivial change:

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 8407a0b..6868893 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -680,7 +680,7 @@ static u8 sdhci_calc_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	if (count >= 0xF) {
-		pr_warning("%s: Too large timeout %x requested for CMD%d!\n",
+		pr_warning("%s: Too large timeout 0x%x requested for CMD%d!\n",
 			   mmc_hostname(host->mmc), count, cmd->opcode);
 		count = 0xE;
 	}

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
