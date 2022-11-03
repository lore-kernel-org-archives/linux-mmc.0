Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA71C4332F
	for <linux-mmc@archiver.kernel.org>; Thu,  3 Nov 2022 10:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiKCK7w (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 3 Nov 2022 06:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiKCK7u (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 3 Nov 2022 06:59:50 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F6C109F
        for <linux-mmc@vger.kernel.org>; Thu,  3 Nov 2022 03:59:50 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b29so1222513pfp.13
        for <linux-mmc@vger.kernel.org>; Thu, 03 Nov 2022 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tl6gvrKJpq1c2SMRIQkixJ9RHyBaATDZDYadUE36ADo=;
        b=bGNCz6BI/X3dSE94R0ba6QyEEWxSsYixsiRVc3eqYT+xOJrJYnFPcQEuOt5Xcx7/C+
         mXoyvj4knRHD2V8e2AhNKO2ehdnVWW5DGzf0i7GLopJLbJCzB1IOa4LxKlE03jL31aeP
         lGYxws+DjOh22jTEPQ1PPK7ijJbVvZDFRuR+IbRcPPfawZ/duXNrnhtdNbPKvaos5Qmh
         wQi/gL+CWGshJzmVyNXzucywYJE5kYvkx1+pPAlfVcHHLbDLMBZyyoIx7ygkZNIYkdet
         w6fnn1JgkShaj3tpsQZ/7Pje2xXci6FBs1QMXDnlHvJFRON8KWk4jFt2OTNdAkO1eGRW
         AqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tl6gvrKJpq1c2SMRIQkixJ9RHyBaATDZDYadUE36ADo=;
        b=WcpBjuQx5Nhldw1RtDmHdJujhdT7KuiZRSSYu+wB3oUuBIEa0vJFH26w/lD1C0gg1r
         ZUWKNgkPoT9fLyeBTSTr8w3F/QX5Fmc+DXbM7R0VrVVPKGsI3V8JbulQl+/eMP/AIKBT
         rN6BEHt7mZlTBJEKRskSF4DLbfeJT/eU/WqnAP1GL8u1D8Txrj2LpRAv2Ww9TZ+ezbQI
         M4wA4an02rvvAjWAFWTlT6B+7O6eiqZMaj4NVx2//yvVFTO+OECR5s18spYnRzcPdaIy
         ZUOyfvTJ/GrrWsyeRs7r1XuVrkQ7HrU+zEvpKrGs740a6KcIlJi83REmZ4PMJszJUO5Z
         6HdA==
X-Gm-Message-State: ACrzQf05XE0KN82P/SokI1+e2ppdXf8Yb+mPtT70SMexb4XbH83Cp9Aq
        J+udGiF/McTHmcaPXeItXWaZxudTWDosx/4kef36mg==
X-Google-Smtp-Source: AMsMyM5mH9Kbc/UTomJNMiJt8u9MMUAkTK5EumQHhGigQ8uemLyjJRlEChWmswJsa5eXfWYYXRrGMuDgD1V0RHHk1iM=
X-Received: by 2002:a63:9049:0:b0:46f:59b9:1645 with SMTP id
 a70-20020a639049000000b0046f59b91645mr25122160pge.541.1667473189454; Thu, 03
 Nov 2022 03:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAPDyKFqJdiCDkAfrONfnBVKw1v8=jZ+hEJiKGK70EQ4o7BSxaQ@mail.gmail.com>
 <20221103043852.24718-1-pshete@nvidia.com>
In-Reply-To: <20221103043852.24718-1-pshete@nvidia.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Nov 2022 11:59:12 +0100
Message-ID: <CAPDyKFrT46SXxiHw5=q8HwK5PMJCsp+iE8Wm4CsEqfBf6EWicA@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] iommu: Always define struct iommu_fwspec
To:     joro@8bytes.org, robin.murphy@arm.com, will@kernel.org
Cc:     Prathamesh Shete <pshete@nvidia.com>, adrian.hunter@intel.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        p.zabel@pengutronix.de, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, anrao@nvidia.com, smangipudi@nvidia.com,
        kyarlagadda@nvidia.com, Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Nov 2022 at 05:39, Prathamesh Shete <pshete@nvidia.com> wrote:
>
> In order to fully make use of the !IOMMU_API stub functions, make the
> struct iommu_fwspec always available so that users of the stubs can keep
> using the structure's internals without causing compile failures.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Joerg, Will, Robin - may I have an ack from some of you for $subject
patch, so I can funnel it via my mmc tree for v6.2?

Kind regards
Uffe

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
