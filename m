From: reg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] mmc:sdhci-pci:Add O2Micor/BayHubTect PCI SD Host
Date: Tue, 24 Sep 2013 20:30:55 -0700
Message-ID: <20130925033055.GA29234@kroah.com>
References: <9ac149a4448d4d99a280a37b104da1e3@BN1PR04MB091.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <9ac149a4448d4d99a280a37b104da1e3@BN1PR04MB091.namprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Guo <peter.guo@bayhubtech.com>
Cc: Chris Ball <cjb@laptop.org>, Bjorn Helgaas <bhelgaas@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Bill Pemberton <wfp5p@virginia.edu>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Samuel Guan <samuel.guan@bayhubtech.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Sep 25, 2013 at 03:20:07AM +0000, Peter Guo wrote:
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1700,6 +1700,11 @@
>  #define PCI_DEVICE_ID_O2_8221		0x8221
>  #define PCI_DEVICE_ID_O2_8320		0x8320
>  #define PCI_DEVICE_ID_O2_8321		0x8321
> +#define PCI_DEVICE_ID_O2_8520		0x8520
> +#define	PCI_DEVICE_ID_O2_8420		0x8420
> +#define	PCI_DEVICE_ID_O2_8421		0x8421
> +#define	PCI_DEVICE_ID_O2_8620		0x8620
> +#define	PCI_DEVICE_ID_O2_8621		0x8621

Please read the top of this file for why you shouldn't be adding new
device ids to it.

thanks,

greg k-h
