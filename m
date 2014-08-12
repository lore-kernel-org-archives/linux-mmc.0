From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: core: export more sysfs for debugging purpose
Date: Tue, 12 Aug 2014 17:49:59 +0900
Message-ID: <53E9D537.6080104@samsung.com>
References: <1407828534-15846-1-git-send-email-yunpeng.gao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:57341 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752869AbaHLIuC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 12 Aug 2014 04:50:02 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout4.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0NA600FAOR7CAP70@mailout4.samsung.com> for
 linux-mmc@vger.kernel.org; Tue, 12 Aug 2014 17:50:00 +0900 (KST)
In-reply-to: <1407828534-15846-1-git-send-email-yunpeng.gao@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Yunpeng Gao <yunpeng.gao@intel.com>, linux-mmc@vger.kernel.org
Cc: Chuanxiao Xiao <chuanxiao.dong@intel.com>

Hi,

On 08/12/2014 04:28 PM, Yunpeng Gao wrote:
> Add some more sysfs export related to eMMC BK Ops,
> HPI and Hardware Reset features. It'll be helpful
> for debugging.

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
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 793c6f7..15b7ab0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -710,6 +710,12 @@ MMC_DEV_ATTR(enhanced_area_offset, "%llu\n",
>  MMC_DEV_ATTR(enhanced_area_size, "%u\n", card->ext_csd.enhanced_area_size);
>  MMC_DEV_ATTR(raw_rpmb_size_mult, "%#x\n", card->ext_csd.raw_rpmb_size_mult);
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

