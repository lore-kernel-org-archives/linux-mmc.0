From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3 2/3] PCI: Add Genesys Logic, Inc. Vendor ID
Date: Thu, 15 Aug 2019 14:30:53 +0300
Message-ID: <0b195576-48ef-0cff-80c1-b5da47452e96@intel.com>
References: <20190726020754.GA12078@people.danlj.org>
 <62a756ff-6432-fd43-5e90-038eb28045cd@intel.com>
 <20190812225730.GB30758@people.danlj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190812225730.GB30758@people.danlj.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael K. Johnson" <johnsonm@danlj.org>
Cc: ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>
List-Id: linux-mmc@vger.kernel.org

On 13/08/19 1:57 AM, Michael K. Johnson wrote:
> Add the Genesys Logic, Inc. verndor ID to pci_ids.h.

verndor -> vendor

> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Co-developed-by: Michael K Johnson <johnsonm@danlj.org>

Did you mean for this patch to be "From:" Ben Chuang because otherwise
"Co-developed-by" the author is redundant.

> Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
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
