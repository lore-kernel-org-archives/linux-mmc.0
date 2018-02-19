From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 10/16] mmc: sdhci: Fix to use data_timer only for data
 line commands
Date: Mon, 19 Feb 2018 10:03:42 +0200
Message-ID: <192a7c1e-9180-e473-8000-4a4aa806df91@intel.com>
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-11-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180205125029.21570-11-kishon@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Kishon Vijay Abraham I <kishon@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 05/02/18 14:50, Kishon Vijay Abraham I wrote:
> commit d7422fb489eee5587d3eec ("mmc: sdhci: Separate timer timeout for
> command and data requests") while separating timer timeout for
> command and data requests, passed cmd->mrq to sdhci_mod_timer (cmd is an
> argument to sdhci_send_command) and in sdhci_mod_timer used mrq->cmd
> to check if it is a data line command. This results in using
> data timer for commands like MMC_SET_BLOCK_COUNT (CMD23) though it is
> not a data line command. Fix it here.

I am not sure why you need this change, but it is not right actually.  There
are 2 timers because there can be 2 mrqs and we need to delete the correct
timer in sdhci_request_done() so it is better to make the selection based on
the mrq not the last command.

> 
> Fixes: commit d7422fb489eee5587d3eec ("mmc: sdhci: Separate timer timeout for
> command and data requests")
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/mmc/host/sdhci.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 1aa74b4682f3..0489572d1892 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1073,10 +1073,10 @@ static void sdhci_finish_data(struct sdhci_host *host)
>  	}
>  }
>  
> -static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
> +static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_command *cmd,
>  			    unsigned long timeout)
>  {
> -	if (sdhci_data_line_cmd(mrq->cmd))
> +	if (sdhci_data_line_cmd(cmd))
>  		mod_timer(&host->data_timer, timeout);
>  	else
>  		mod_timer(&host->timer, timeout);
> @@ -1135,7 +1135,7 @@ void sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
>  		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
>  	else
>  		timeout += 10 * HZ;
> -	sdhci_mod_timer(host, cmd->mrq, timeout);
> +	sdhci_mod_timer(host, cmd, timeout);
>  
>  	host->cmd = cmd;
>  	if (sdhci_data_line_cmd(cmd)) {
> 
