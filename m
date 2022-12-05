Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B38EC4321E
	for <linux-mmc@archiver.kernel.org>; Mon,  5 Dec 2022 19:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiLETDb (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 5 Dec 2022 14:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbiLETDZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 5 Dec 2022 14:03:25 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEE582BD1;
        Mon,  5 Dec 2022 11:03:21 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E809BD6E;
        Mon,  5 Dec 2022 11:03:24 -0800 (PST)
Received: from [10.57.71.118] (unknown [10.57.71.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 592FA3F71A;
        Mon,  5 Dec 2022 11:03:14 -0800 (PST)
Message-ID: <0df4bfa7-4e76-b6b2-c8cf-a0776ec0fbfa@arm.com>
Date:   Mon, 5 Dec 2022 19:03:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v12 2/6] iommu/tegra: Add tegra_dev_iommu_get_stream_id()
 helper
Content-Language: en-GB
To:     Thierry Reding <thierry.reding@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20221202152644.29450-1-thierry.reding@gmail.com>
 <20221202152644.29450-3-thierry.reding@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221202152644.29450-3-thierry.reding@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2022-12-02 15:26, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Access to the internals of struct iommu_fwspec by non-IOMMU drivers is
> discouraged. Many drivers for Tegra SoCs, however, need access to their
> IOMMU stream IDs so that they can be programmed into various hardware
> registers.
> 
> Formalize this access into a common helper to make it easier to audit
> and maintain.

In many ways I'd be happier if this could go somewhere in 
include/soc/tegra/ rather than the generic IOMMU API header, but I see 
the argument for keeping fwspec usage close to home as well, so no 
overwhelming preference one way or the other. Mostly I'd just like to 
get something landed so that all those other drivers can be cleaned up 
as well, and I reckon this counts as good enough.

Unless Joerg has a stronger opinion,

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   include/linux/iommu.h | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index dc5e6f5c14fc..f0d72acad7db 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1186,4 +1186,25 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>   }
>   #endif /* CONFIG_IOMMU_SVA */
>   
> +/*
> + * Newer generations of Tegra SoCs require devices' stream IDs to be directly programmed into
> + * some registers. These are always paired with a Tegra SMMU or ARM SMMU, for which the contents
> + * of the struct iommu_fwspec are known. Use this helper to formalize access to these internals.
> + */
> +#define TEGRA_STREAM_ID_BYPASS 0x7f
> +
> +static inline bool tegra_dev_iommu_get_stream_id(struct device *dev, u32 *stream_id)
> +{
> +#ifdef CONFIG_IOMMU_API
> +	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +	if (fwspec && fwspec->num_ids == 1) {
> +		*stream_id = fwspec->ids[0] & 0xffff;
> +		return true;
> +	}
> +#endif
> +
> +	return false;
> +}
> +
>   #endif /* __LINUX_IOMMU_H */
