From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-pci: only install voltage switch
 method when useful
Date: Fri, 16 Nov 2018 17:58:50 +0100
Message-ID: <20181116165850.GB5894@jaya>
References: <20181022134026.GB18413@jaya>
 <20181023100729.28864-4-anisse@astier.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181023100729.28864-4-anisse@astier.eu>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,

On Tue, Oct 23, 2018 at 12:07:29PM +0200, Anisse Astier wrote:
> If there's no ACPI DSM for voltage switch, it will just cause a lot of
> debug info down the line, we only need one at startup.
> 
> Signed-off-by: Anisse Astier <anisse@astier.eu>
> ---
>  drivers/mmc/host/sdhci-pci-core.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index f2c1fb339d66..95fdbb883c7e 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -723,6 +723,7 @@ static const struct dmi_system_id board_no_1_8v[] = {
>  static void byt_probe_slot(struct sdhci_pci_slot *slot)
>  {
>  	struct mmc_host_ops *ops = &slot->host->mmc_host_ops;
> +	struct intel_host *intel_host = sdhci_pci_priv(slot);
>  
>  	byt_read_dsm(slot);
>  
> @@ -733,6 +734,16 @@ static void byt_probe_slot(struct sdhci_pci_slot *slot)
>  				mmc_hostname(slot->host->mmc));
>  		slot->host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>  	}
> +	/* Check if we have the appropriate voltage switch DSM methods */
> +	if (!(intel_host->dsm_fns & (1 << INTEL_DSM_V18_SWITCH)) &&
> +	    !(intel_host->dsm_fns & (1 << INTEL_DSM_V33_SWITCH))) {
> +		/* No voltage switching supported at all, there's no
> +		 * point in installing the callback: return.
> +		 */
> +		pr_debug("%s: No voltage switching ACPI DSM helper\n",
> +				mmc_hostname(slot->host->mmc));
> +		return;
> +	}
>  	ops->start_signal_voltage_switch = intel_start_signal_voltage_switch;
>  }
>  
> -- 
> 2.17.2
> 

What do you think of picking this last patch ? Or maybe you had
different cleanups in mind when you said you wanted to rework this ?

Regards,

Anisse
