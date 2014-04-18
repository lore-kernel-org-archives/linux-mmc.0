From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH 1/1] mmc: sdhci-pci-o2micro Add SeaBird SeaEagle SD3 support
Date: Fri, 18 Apr 2014 12:55:10 +0100
Message-ID: <86zjjiua1t.fsf@void.printf.net>
References: <1326159439be44efadec7d62612c3130@CO2PR04MB651.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:50589 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbaDRLzM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 18 Apr 2014 07:55:12 -0400
In-Reply-To: <1326159439be44efadec7d62612c3130@CO2PR04MB651.namprd04.prod.outlook.com>
	(Peter Guo's message of "Fri, 18 Apr 2014 07:11:58 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Peter Guo <peter.guo@bayhubtech.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Adam Lee <adam.lee@canonical.com>, Samuel Guan <samuel.guan@bayhubtech.com>

Hi Peter,

On Fri, Apr 18 2014, Peter Guo wrote:
> @@ -215,6 +251,25 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
>  
>  		scratch &= 0x7f;
>  		pci_write_config_byte(chip->pdev, O2_SD_LOCK_WP, scratch);
> +		if (chip->pdev->device == PCI_DEVICE_ID_O2_FUJIN2) {
> +			ret = pci_read_config_dword(chip->pdev,
> +						O2_SD_FUNC_REG0, &scratch_32);
> +			scratch_32 = ((scratch_32 & 0xFF000000) >> 24);
> +			if ((scratch_32 == 0x11) || (scratch_32 == 0x12)) {
> +				scratch_32 = 0x2c280000;

Can we get a comment added to the code about what the purpose of the
writes below is, and why you're writing this particular value?

Please use a #defined constant for the value, too.

> +				o2_pci_set_baseclk(chip, scratch_32);
> +				ret = pci_read_config_dword(chip->pdev,
> +						O2_SD_FUNC_REG4, &scratch_32);
> +				scratch_32 |= BIT(22);

Same -- what is the purpose of the value you're reading, and what does
adding this bit to it achieve?

> +				pci_write_config_dword(chip->pdev,
> +					O2_SD_FUNC_REG4, scratch_32);

Thanks,

- Chris.
-- 
Chris Ball   <http://printf.net/>
