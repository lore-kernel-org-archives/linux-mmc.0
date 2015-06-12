From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V2 1/3] pci_ids: Add AMD KERNCZ device ID support
Date: Fri, 12 Jun 2015 15:34:18 -0500
Message-ID: <20150612203418.GJ23119@google.com>
References: <1434024707-6245-1-git-send-email-Vincent.Wan@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36824 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbbFLUeX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 12 Jun 2015 16:34:23 -0400
Received: by igbpi8 with SMTP id pi8so19074812igb.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jun 2015 13:34:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1434024707-6245-1-git-send-email-Vincent.Wan@amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wan ZongShun <Vincent.Wan@amd.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-i2c@vger.kernel.org, bp@alien8.de, jdelvare@suse.de, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mcuos.com@gmail.com

On Thu, Jun 11, 2015 at 08:11:45PM +0800, Wan ZongShun wrote:
> The KERNCZ is new AMD SB/FCH generation name, like HUDSON2.
> We will adopt 0x790b as device ID since from this gereration.

s/We will adopt 0x790b as device ID since from/0x790b is the device ID for/
s/gereration/generation/

> Signed-off-by: Wan ZongShun <Vincent.Wan@amd.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  include/linux/pci_ids.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 2f7b9a4..cb63a7b 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -579,6 +579,7 @@
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SATA_IDE	0x7800
>  #define PCI_DEVICE_ID_AMD_HUDSON2_SMBUS		0x780b
>  #define PCI_DEVICE_ID_AMD_HUDSON2_IDE		0x780c
> +#define PCI_DEVICE_ID_AMD_KERNCZ_SMBUS  0x790b
>  
>  #define PCI_VENDOR_ID_TRIDENT		0x1023
>  #define PCI_DEVICE_ID_TRIDENT_4DWAVE_DX	0x2000
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
