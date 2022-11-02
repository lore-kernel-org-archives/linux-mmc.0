Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C464C4332F
	for <linux-mmc@archiver.kernel.org>; Wed,  2 Nov 2022 15:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiKBP2K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 2 Nov 2022 11:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiKBP2H (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2022 11:28:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E75924BF2
        for <linux-mmc@vger.kernel.org>; Wed,  2 Nov 2022 08:28:01 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m14-20020a17090a3f8e00b00212dab39bcdso2482394pjc.0
        for <linux-mmc@vger.kernel.org>; Wed, 02 Nov 2022 08:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wP12hBLI/UjYflAvChPOlEUP0Fe9bcRv3GNq3jXeE+o=;
        b=oPg7EAxfhFVgkL5qNGfY4856C1CuYDrQT15DtL6CAfeFLX8YI4d839KNXQ4S+gqr3a
         jl0GyG/hjPYCfH8CFQOTECwjEjyDtxI5jMIWrIYga5TRq0kXfOXd9WDHC1Z//WkJKr9M
         Ad+DCW+vZTRC+nxDpNFkhVnFxaBoD0sK2hhdLLaaFhIVjXBbWRZtsm8j4QbOW5urUEsh
         QUwujKODHa/k883wtb2V2C6ovbNxfQKuOLJapf96fLqGvubzOHHsh3bsNDZTFiesw3Fj
         JKrcUe8+Fk9VgsGaOAMngyH68+2DM3jdLTjfELiAs3+3Jh7pfmiTrYtJePw+hvcxFtNv
         JbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wP12hBLI/UjYflAvChPOlEUP0Fe9bcRv3GNq3jXeE+o=;
        b=CK7mRrj5s0mWUyW5iM3KEUkq/i4Amowt7RvIVaEuOyhFfKN2V/gmJyNNBJ0p4J38ER
         wESAeXDODcaOzR9liLdquE+TWBJHzGFZSl5mdLi/C3LU8FQWC30tXPAuhLEBbtDO7PTM
         PTLxxztOSmBNIhgo0PDFivhQ3ee/Xo71BbA9DSckbA+dk4E+SkV5DeQ3pKFrf7aGMuK1
         /WGIz1plMQXddWeoX4b191hNgzFaaPBQLinzxt6sh5jlwmKkdtLt7P7UUiw5fUgxbuZP
         FVqwMC/YTBSLCICzHXPyibuKNIlTnNGuDE9W9SuTu7hOTrFol7coreheeawuBxqGatb2
         dU2g==
X-Gm-Message-State: ACrzQf2dgh2rBJh7qMuek3ADSeYIxaVW0wjgQaQdHwmvsJNzW4mIeMwZ
        ijQJnP9ZKJpfLvNUyQoI2wFGIKNKlJlXbESUucHDfQ==
X-Google-Smtp-Source: AMsMyM6A7lrylJay1xhevhaxJCaktaXQTaOKnMRfNs50tK6THAHyXvK0B1iPkGpZmNSeU8H+Mxp5/cQp8C9UHnx/UTU=
X-Received: by 2002:a17:902:b78b:b0:187:1623:827f with SMTP id
 e11-20020a170902b78b00b001871623827fmr18869518pls.165.1667402881129; Wed, 02
 Nov 2022 08:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFpG9ZjVTiK3HEqioDN8ksGpRYiXL_SLSmOfm9fjJfcrsw@mail.gmail.com>
 <20221028130242.20900-1-pshete@nvidia.com>
In-Reply-To: <20221028130242.20900-1-pshete@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 2 Nov 2022 16:27:24 +0100
Message-ID: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/4] iommu: Add dummy dev_iommu_fwspec_get() helper
To:     Prathamesh Shete <pshete@nvidia.com>
Cc:     joro@8bytes.org, adrian.hunter@intel.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        iommu@lists.linux.dev, robin.murphy@arm.com, anrao@nvidia.com,
        smangipudi@nvidia.com, kyarlagadda@nvidia.com,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 28 Oct 2022 at 15:02, Prathamesh Shete <pshete@nvidia.com> wrote:
>
> This dummy implementation is useful to avoid a dependency on the
> IOMMU_API Kconfig symbol in drivers that can optionally use the IOMMU
> API.
>
> In order to fully use this, also move the struct iommu_fwspec definition
> out of the IOMMU_API protected region.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

It seems like you claimed authorship of the patch [1], that was
authored by Thierry and updated the commit message header.

Can you please restore the patch to its original that was posted by Thierry?

Kind regards
Uffe

[1]
https://lore.kernel.org/linux-mmc/20221018105149.820062-1-thierry.reding@gmail.com/



> ---
>  include/linux/iommu.h | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ea30f00dc145..afa829bc4356 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -173,6 +173,25 @@ enum iommu_dev_features {
>
>  #define IOMMU_PASID_INVALID    (-1U)
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
> +       const struct iommu_ops  *ops;
> +       struct fwnode_handle    *iommu_fwnode;
> +       u32                     flags;
> +       unsigned int            num_ids;
> +       u32                     ids[];
> +};
> +
> +/* ATS is supported */
> +#define IOMMU_FWSPEC_PCI_RC_ATS                        (1 << 0)
> +
>  #ifdef CONFIG_IOMMU_API
>
>  /**
> @@ -600,25 +619,6 @@ extern struct iommu_group *generic_device_group(struct device *dev);
>  /* FSL-MC device grouping function */
>  struct iommu_group *fsl_mc_device_group(struct device *dev);
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
> -       const struct iommu_ops  *ops;
> -       struct fwnode_handle    *iommu_fwnode;
> -       u32                     flags;
> -       unsigned int            num_ids;
> -       u32                     ids[];
> -};
> -
> -/* ATS is supported */
> -#define IOMMU_FWSPEC_PCI_RC_ATS                        (1 << 0)
> -
>  /**
>   * struct iommu_sva - handle to a device-mm bond
>   */
> @@ -682,7 +682,6 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>
>  struct iommu_ops {};
>  struct iommu_group {};
> -struct iommu_fwspec {};
>  struct iommu_device {};
>  struct iommu_fault_param {};
>  struct iommu_iotlb_gather {};
> --
> 2.17.1
>
