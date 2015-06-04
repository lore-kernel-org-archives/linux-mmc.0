From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH] SDHCI: Change AMD SDHCI quirk application scope
Date: Thu, 4 Jun 2015 17:32:20 +0200
Message-ID: <20150604153220.GA4521@pd.tnic>
References: <1433428437-6067-1-git-send-email-Vincent.Wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433428437-6067-1-git-send-email-Vincent.Wan@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wan ZongShun <Vincent.Wan@amd.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Wan ZongShun <mcuos.com@gmail.com>, Wan ZongShun <linux@mcuos.com>
List-Id: linux-mmc@vger.kernel.org

On Thu, Jun 04, 2015 at 10:33:57PM +0800, Wan ZongShun wrote:
> From: Vincent Wan <vincent.wan@amd.com>
> 
> Change this quirk to apply to AMD Carrizo platform.
> 
> Signed-off-by: Vincent Wan <vincent.wan@amd.com>
> Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> Signed-off-by: Wan ZongShun <linux@mcuos.com>
> 
> Tested-by: Nath, Arindam <Arindam.Nath@amd.com>
> Tested-by: Ramesh, Ramya <Ramya.Ramesh@amd.com>
> ---
>  drivers/mmc/host/sdhci-pci.c | 25 ++++++++++++++++++++++++-
>  include/linux/pci_ids.h      |  1 +
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-pci.c b/drivers/mmc/host/sdhci-pci.c
> index f208f20..94f54d2 100644
> --- a/drivers/mmc/host/sdhci-pci.c
> +++ b/drivers/mmc/host/sdhci-pci.c
> @@ -724,14 +724,37 @@ static const struct sdhci_pci_fixes sdhci_rtsx = {
>  	.probe_slot	= rtsx_probe_slot,
>  };
>  
> +/*AMD chipset generation*/
> +enum amd_chipset_gen {
> +	AMD_CHIPSET_BEFORE_ML,
> +	AMD_CHIPSET_CZ,
> +	AMD_CHIPSET_NL,
> +	AMD_CHIPSET_UNKNOWN,
> +};
> +
>  static int amd_probe(struct sdhci_pci_chip *chip)
>  {
>  	struct pci_dev	*smbus_dev;
> +	enum amd_chipset_gen gen;
>  
>  	smbus_dev = pci_get_device(PCI_VENDOR_ID_AMD,
>  			PCI_DEVICE_ID_AMD_HUDSON2_SMBUS, NULL);
> +	if (smbus_dev) {
> +		gen = AMD_CHIPSET_BEFORE_ML;
> +	} else {
> +		smbus_dev = pci_get_device(PCI_VENDOR_ID_AMD,
> +				PCI_DEVICE_ID_AMD_KERNCZ_SMBUS, NULL);
> +		if (smbus_dev) {
> +			if (smbus_dev->revision < 0x51)
> +				gen = AMD_CHIPSET_CZ;
> +			else
> +				gen = AMD_CHIPSET_NL;
> +		} else {
> +			gen = AMD_CHIPSET_UNKNOWN;
> +		}
> +	}
>  
> -	if (smbus_dev && (smbus_dev->revision < 0x51)) {
> +	if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ)) {
>  		chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
>  		chip->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
>  	}
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 2f7b9a4..cb63a7b 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -579,6 +579,7 @@
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
>  #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
> +#define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b

KERNCZ?

Also, that device id is used only in sdhci-pci.c so it should be defined
there. Only when multiple drivers/compilation units need it, then it
should go to pci_ids.h.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
