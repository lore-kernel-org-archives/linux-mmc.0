From: "Gao, Yunpeng" <yunpeng.gao@intel.com>
Subject: RE: [PATCH] mmc: core: export more sysfs for debugging purpose
Date: Wed, 13 Aug 2014 06:18:34 +0000
Message-ID: <0AA7DC03D52A654FA5AF208AE38A967D01D7B8DA@shsmsx102.ccr.corp.intel.com>
References: <1407828534-15846-1-git-send-email-yunpeng.gao@intel.com>
 <53E9D537.6080104@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:39149 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750757AbaHMGSi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Aug 2014 02:18:38 -0400
In-Reply-To: <53E9D537.6080104@samsung.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: "Dong, Chuanxiao" <chuanxiao.dong@intel.com>

HI Jaehoon,

I have not tried mmc-utils yet.
Actually, our validation team developed their own test cases of eMMC features and requested us to export these sysfs interfaces.

Thanks.

Regards,
Yunpeng

-----Original Message-----
From: Jaehoon Chung [mailto:jh80.chung@samsung.com] 
Sent: Tuesday, August 12, 2014 4:50 PM
To: Gao, Yunpeng; linux-mmc@vger.kernel.org
Cc: Dong, Chuanxiao
Subject: Re: [PATCH] mmc: core: export more sysfs for debugging purpose

Hi,

On 08/12/2014 04:28 PM, Yunpeng Gao wrote:
> Add some more sysfs export related to eMMC BK Ops, HPI and Hardware 
> Reset features. It'll be helpful for debugging.

Did you use "mmc-utils"?

Best Regards,
Jaehoon Chung
> 
> Signed-off-by: Yunpeng Gao <yunpeng.gao@intel.com>
> Signed-off-by: Chuanxiao Xiao <chuanxiao.dong@intel.com>
> ---
>  drivers/mmc/core/mmc.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index 
> 793c6f7..15b7ab0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -710,6 +710,12 @@ MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",  
> MMC_DEV_ATTR(enhanced_area_size, "%u\n", 
> card->ext_csd.enhanced_area_size);
>  MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", 
> card->ext_csd.raw_rpmb_size_mult);
>  MMC_DEV_ATTR(rel_sectors, "%#x\n", card->ext_csd.rel_sectors);
> +MMC_DEV_ATTR(hpi_support, "%d\n", card->ext_csd.hpi); 
> +MMC_DEV_ATTR(hpi_enable, "%d\n", card->ext_csd.hpi_en); 
> +MMC_DEV_ATTR(hpi_command, "%d\n", card->ext_csd.hpi_cmd); 
> +MMC_DEV_ATTR(hw_reset_support, "%d\n", card->ext_csd.rst_n_function); 
> +MMC_DEV_ATTR(bkops_support, "%d\n", card->ext_csd.bkops); 
> +MMC_DEV_ATTR(bkops_enable, "%d\n", card->ext_csd.bkops_en);
>  
>  static struct attribute *mmc_std_attrs[] = {
>  	&dev_attr_cid.attr,
> @@ -728,6 +734,12 @@ static struct attribute *mmc_std_attrs[] = {
>  	&dev_attr_enhanced_area_size.attr,
>  	&dev_attr_raw_rpmb_size_mult.attr,
>  	&dev_attr_rel_sectors.attr,
> +	&dev_attr_hpi_support.attr,
> +	&dev_attr_hpi_enable.attr,
> +	&dev_attr_hpi_command.attr,
> +	&dev_attr_hw_reset_support.attr,
> +	&dev_attr_bkops_support.attr,
> +	&dev_attr_bkops_enable.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(mmc_std);
> 

