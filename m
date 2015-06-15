From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH V2 2/3] i2c-piix4: Use Macro for AMD CZ SMBus device ID
Date: Mon, 15 Jun 2015 14:27:57 +0200
Message-ID: <20150615142757.0142351c@endymion.delvare>
References: <1434024707-6245-1-git-send-email-Vincent.Wan@amd.com>
	<1434024707-6245-2-git-send-email-Vincent.Wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48557 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753198AbbFOM2D (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 15 Jun 2015 08:28:03 -0400
In-Reply-To: <1434024707-6245-2-git-send-email-Vincent.Wan@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wan ZongShun <Vincent.Wan@amd.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-i2c@vger.kernel.org, bp@alien8.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mcuos.com@gmail.com

On Thu, 11 Jun 2015 20:11:46 +0800, Wan ZongShun wrote:
> Change AMD CZ SMBUS device ID from 0x790b to
> use Macro definition
> 
> Signed-off-by: Wan ZongShun <Vincent.Wan@amd.com>
> ---
>  drivers/i2c/busses/i2c-piix4.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
> index 67cbec6..630bce6 100644
> --- a/drivers/i2c/busses/i2c-piix4.c
> +++ b/drivers/i2c/busses/i2c-piix4.c
> @@ -245,7 +245,7 @@ static int piix4_setup_sb800(struct pci_dev *PIIX4_dev,
>  	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_HUDSON2_SMBUS &&
>  	     PIIX4_dev->revision >= 0x41) ||
>  	    (PIIX4_dev->vendor == PCI_VENDOR_ID_AMD &&
> -	     PIIX4_dev->device == 0x790b &&
> +	     PIIX4_dev->device == PCI_DEVICE_ID_AMD_KERNCZ_SMBUS &&
>  	     PIIX4_dev->revision >= 0x49))
>  		smb_en = 0x00;
>  	else
> @@ -545,7 +545,7 @@ static const struct pci_device_id piix4_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_HUDSON2_SMBUS) },
> -	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, 0x790b) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_KERNCZ_SMBUS) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,
>  		     PCI_DEVICE_ID_SERVERWORKS_OSB4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS,

Probably too late but anyway:

Acked-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
