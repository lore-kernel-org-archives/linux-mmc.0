From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH RESEND] mmc: sdhci-pci: Fix BYT sd card getting stuck
 in runtime suspend
Date: Wed, 11 Dec 2013 14:43:38 +0200
Message-ID: <52A85DFA.4080505@intel.com>
References: <1386764492-26444-1-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1386764492-26444-1-git-send-email-adrian.hunter@intel.com>
Sender: stable-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, stable <stable@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi

For some reason this email doesn't seem to get
onto the mailing lists.  I am trying to figure out
why.


On 11/12/13 14:21, Adrian Hunter wrote:
> A host controller for a SD card may need a GPIO
> for card detect in order to wake up from runtime
> suspend when a card is inserted.  If that GPIO is
> not configured, then the host controller will not
> wake up.  Fix that for the affected devices by not
> enabling runtime PM unless the GPIO is successfully
> set up.
> 
> This affects BYT sd card host controller which had
> runtime PM enabled from v3.11.  For completeness,
> the MFD sd card host controller is flagged also.
> 
> Tested on v3.11.10 and v3.12.4 although the patch
> applies with some offsets and fuzz.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> Cc: stable <stable@vger.kernel.org> # 3.11+
> ---
>  drivers/mmc/host/sdhci-pci.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index 8f75381..7b930e6 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -65,6 +65,7 @@ struct sdhci_pci_fixes {
>  	unsigned int		quirks;
>  	unsigned int		quirks2;
>  	bool			allow_runtime_pm;
> +	bool			own_cd_for_runtime_pm;
>  
>  	int			(*probe) (struct sdhci_pci_chip *);
>  
> @@ -296,6 +297,7 @@ static const struct sdhci_pci_fixes sdhci_intel_mrst_hc1_hc2 = {
>  static const struct sdhci_pci_fixes sdhci_intel_mfd_sd = {
>  	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
>  	.allow_runtime_pm = true,
> +	.own_cd_for_runtime_pm = true,
>  };
>  
>  static const struct sdhci_pci_fixes sdhci_intel_mfd_sdio = {
> @@ -360,6 +362,7 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_sdio = {
>  static const struct sdhci_pci_fixes sdhci_intel_byt_sd = {
>  	.quirks2	= SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON,
>  	.allow_runtime_pm = true,
> +	.own_cd_for_runtime_pm = true,
>  };
>  
>  /* Define Host controllers for Intel Merrifield platform */
> @@ -1457,6 +1460,14 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
>  
>  	sdhci_pci_add_own_cd(slot);
>  
> +	/*
> +	 * Check if the chip needs a separate GPIO for card detect to wake up
> +	 * from runtime suspend.  If it is not there, don't allow runtime PM.
> +	 * Note sdhci_pci_add_own_cd() sets slot->cd_gpio to -EINVAL on failure.
> +	 */
> +	if (chip->fixes->own_cd_for_runtime_pm && !gpio_is_valid(slot->cd_gpio))
> +		chip->allow_runtime_pm = false;
> +
>  	return slot;
>  
>  remove:
> 
