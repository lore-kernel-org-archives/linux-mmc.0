Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 288CEC43217
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Nov 2022 12:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiKCMX3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Nov 2022 08:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiKCMX2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2022 08:23:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 938CD6475;
        Thu,  3 Nov 2022 05:23:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60E501FB;
        Thu,  3 Nov 2022 05:23:33 -0700 (PDT)
Received: from [10.57.37.13] (unknown [10.57.37.13])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5742A3F703;
        Thu,  3 Nov 2022 05:23:24 -0700 (PDT)
Message-ID: <6be39bae-f325-12e0-374b-a27c9ee2ef2b@arm.com>
Date:   Thu, 3 Nov 2022 12:23:20 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v10 1/4] iommu: Always define struct iommu_fwspec
Content-Language: en-GB
To:     Prathamesh Shete <pshete@nvidia.com>, joro@8bytes.org,
        adrian.hunter@intel.com, ulf.hansson@linaro.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     will@kernel.org, iommu@lists.linux.dev, anrao@nvidia.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com,
        Thierry Reding <treding@nvidia.com>
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221103043852.24718-1-pshete@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 2022-11-03 04:38, Prathamesh Shete wrote:
> In order to fully make use of the !IOMMU_API stub functions, make the
> struct iommu_fwspec always available so that users of the stubs can keep
> using the structure's internals without causing compile failures.

I'm really in two minds about this... fwspecs are an internal detail of 
the IOMMU API that are meant to be private between individual drivers 
and firmware code, so anything poking at them arguably does and should 
depend on CONFIG_IOMMU_API. It looks like the stub for 
dev_iommu_fwspec_get() was only added for the sake of one driver that 
was misusing it where it really wanted device_iommu_mapped(), and has 
since been fixed, so if anything my preference would be to remove that 
stub :/

I don't technically have much objection to this patch in isolation, but 
what I don't like is the direction of travel it implies. I see the 
anti-pattern is only spread across Tegra drivers, making Tegra-specific 
assumptions, so in my view the best answer would be to abstract that 
fwpsec dependency into a single Tegra-specific helper, which would 
better represent the nature of what's really going on here.

Thanks,
Robin.

> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>   include/linux/iommu.h | 39 +++++++++++++++++++--------------------
>   1 file changed, 19 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ea30f00dc145..afa829bc4356 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -173,6 +173,25 @@ enum iommu_dev_features {
>   
>   #define IOMMU_PASID_INVALID	(-1U)
>   
> +/**
> + * struct iommu_fwspec - per-device IOMMU instance data
> + * @ops: ops for this device's IOMMU
> + * @iommu_fwnode: firmware handle for this device's IOMMU
> + * @flags: IOMMU_FWSPEC_* flags
> + * @num_ids: number of associated device IDs
> + * @ids: IDs which this device may present to the IOMMU
> + */
> +struct iommu_fwspec {
> +	const struct iommu_ops	*ops;
> +	struct fwnode_handle	*iommu_fwnode;
> +	u32			flags;
> +	unsigned int		num_ids;
> +	u32			ids[];
> +};
> +
> +/* ATS is supported */
> +#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
> +
>   #ifdef CONFIG_IOMMU_API
>   
>   /**
> @@ -600,25 +619,6 @@ extern struct iommu_group *generic_device_group(struct device *dev);
>   /* FSL-MC device grouping function */
>   struct iommu_group *fsl_mc_device_group(struct device *dev);
>   
> -/**
> - * struct iommu_fwspec - per-device IOMMU instance data
> - * @ops: ops for this device's IOMMU
> - * @iommu_fwnode: firmware handle for this device's IOMMU
> - * @flags: IOMMU_FWSPEC_* flags
> - * @num_ids: number of associated device IDs
> - * @ids: IDs which this device may present to the IOMMU
> - */
> -struct iommu_fwspec {
> -	const struct iommu_ops	*ops;
> -	struct fwnode_handle	*iommu_fwnode;
> -	u32			flags;
> -	unsigned int		num_ids;
> -	u32			ids[];
> -};
> -
> -/* ATS is supported */
> -#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
> -
>   /**
>    * struct iommu_sva - handle to a device-mm bond
>    */
> @@ -682,7 +682,6 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>   
>   struct iommu_ops {};
>   struct iommu_group {};
> -struct iommu_fwspec {};
>   struct iommu_device {};
>   struct iommu_fault_param {};
>   struct iommu_iotlb_gather {};
