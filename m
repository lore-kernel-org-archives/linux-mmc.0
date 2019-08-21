From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V5 3/4] PCI: Add Genesys Logic, Inc. Vendor ID
Date: Wed, 21 Aug 2019 15:05:00 +0300
Message-ID: <f1975e6e-b7fe-3fb0-bbd9-256462d686c8@intel.com>
References: <20190820020650.8334-1-benchuanggli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190820020650.8334-1-benchuanggli@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ben Chuang <benchuanggli@gmail.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, johnsonm@danlj.org, ben.chuang@genesyslogic.com.tw
List-Id: linux-mmc@vger.kernel.org

On 20/08/19 5:06 AM, Ben Chuang wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> Add the Genesys Logic, Inc. vendor ID to pci_ids.h.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>

Acked-by: Adrian Hunter <adrian.hunter@intel.com>

> ---
>  include/linux/pci_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 70e86148cb1e..4f7e12772a14 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2403,6 +2403,8 @@
>  #define PCI_DEVICE_ID_RDC_R6061		0x6061
>  #define PCI_DEVICE_ID_RDC_D1010		0x1010
>  
> +#define PCI_VENDOR_ID_GLI		0x17a0
> +
>  #define PCI_VENDOR_ID_LENOVO		0x17aa
>  
>  #define PCI_VENDOR_ID_QCOM		0x17cb
> 
