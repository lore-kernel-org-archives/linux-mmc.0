From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/3] mmc: sdhci-pci: allow 8-bit bus width for Intel PCH
Date: Tue, 13 Mar 2012 10:25:14 -0700
Message-ID: <20120313172514.GA28309@kroah.com>
References: <1331659002-13743-1-git-send-email-alexander.stein@systec-electronic.com>
 <1331659002-13743-3-git-send-email-alexander.stein@systec-electronic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1331659002-13743-3-git-send-email-alexander.stein@systec-electronic.com>
Sender: linux-pci-owner@vger.kernel.org
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Chris Ball <cjb@laptop.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Mar 13, 2012 at 06:16:42PM +0100, Alexander Stein wrote:
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2800,6 +2800,8 @@
>  #define PCI_DEVICE_ID_INTEL_82454NX     0x84cb
>  #define PCI_DEVICE_ID_INTEL_84460GX	0x84ea
>  #define PCI_DEVICE_ID_INTEL_IXP4XX	0x8500
> +#define PCI_DEVICE_ID_INTEL_PCH_SDIO0	0x8809
> +#define PCI_DEVICE_ID_INTEL_PCH_SDIO1	0x880a
>  #define PCI_DEVICE_ID_INTEL_IXP2800	0x9004
>  #define PCI_DEVICE_ID_INTEL_S21152BB	0xb152

Did you read the comment at the top of this file before adding your new
device ids?

If not, please do so, and redo your patch.

thanks,

greg k-h
