From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/1] mmc: sdhci-pci: add Support of Synopsys DWC_MSHC IP
Date: Tue, 19 Apr 2016 03:55:17 +0900
Message-ID: <20160418185517.GB10906@kroah.com>
References: <705D14B1C7978B40A723277C067CEDE2010A4B0DFB@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <705D14B1C7978B40A723277C067CEDE2010A4B0DFB@IN01WEMBXB.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prabu Thangamuthu <Prabu.T@synopsys.com>
Cc: "Ulf Hansson (ulf.hansson@linaro.org)" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Joshua Henderson <joshua.henderson@microchip.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Apr 18, 2016 at 10:30:39AM +0000, Prabu Thangamuthu wrote:
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 247da8c..01f743b 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2318,6 +2318,9 @@
>  #define PCI_DEVICE_ID_CENATEK_IDE	0x0001
>  
>  #define PCI_VENDOR_ID_SYNOPSYS		0x16c3
> +#define PCI_DEVICE_ID_MOBSTOR_HAPS51	0xc101
> +#define PCI_DEVICE_ID_MSHC_HAPS51	0xc201
> +#define PCI_DEVICE_ID_MSHC_HAPSDX	0xc202

Please read the top of this file for why you should not add any new
entries to it.

thanks,

greg k-h
