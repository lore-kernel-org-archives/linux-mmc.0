Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3562BC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 18 Nov 2022 08:08:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241313AbiKRII6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiKRII4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 18 Nov 2022 03:08:56 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0566B1C2
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 00:08:55 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id y13so4194827pfp.7
        for <linux-mmc@vger.kernel.org>; Fri, 18 Nov 2022 00:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HK+MyCShb+nHfuM6gVYf2CHmO8+y6qJHQoW3+GkzIAI=;
        b=JcDmZL9df9+Ge3smp3NbdqOqmwGX1d6ySubYsFaYc2L1e+s9WIRvZuC54Z9uHc5kTD
         CvXieTulujePESowDV3fWbjNQRyhf0Od/gBRL2RiSER9iN5k2I3Tu9biuRt/MRnitAkr
         6zS5zMykDqUPbg2lfwM1AH2Izx5jA/1IAP9gdn7Pzww+I6bC5zlYzyoenGLDmyf+hPll
         mDyPIemjFpPyj2kgJ05mgFCwG9bhK2R909+1ieSCanE8c4ywMlxRtpe2GLQdbU3RxUI1
         Eo5IY67lW9kv7yAroSou5g4y/U31bTa3/u3RaUNAqadG2S87Ud9K9jhBz9B3dhVfQsA/
         e6dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HK+MyCShb+nHfuM6gVYf2CHmO8+y6qJHQoW3+GkzIAI=;
        b=raRCGhHqRyojLlNmM5ufzMEG0SqmUA11f1dHcd2iZyN5LKsAAIwoaf4xgfu7g5Ah3x
         Q+KE+62xwrgHpoHQaJ7VwjjDFtVCk1/pgSiseWfRf7HuUwuFPHncStYOL+vlUWj/vZ/A
         4tsYYIINbuazmDSdVPULeTUb3hPdDSdLX/BEZ8r6tUoCwzHrl8AtR3y6hypYAzxLKIiN
         oA/Z2vuAicTy+hgcOHPO8NW3zijNCBz5UJlx24hq8Wkw4n3tRXrtaySxbp2ROkC6Q/oT
         xLLqZBo8E+r+lkzCTE+/eNex0zC6DuCh2QFW6/cN66nsPfATU8/j3l+Sj/3sO9OpTUm3
         m6rA==
X-Gm-Message-State: ANoB5pnCQ/8uv7r7gUeC9AV5GrBFK0UKXYe5g8UBniYQFhrgWXruOv9d
        m/Vy/HjAxZqx/OVbqzH3ZUE1SvAd215T6gFcBAssIg==
X-Google-Smtp-Source: AA0mqf5w4ScLyMXSluNz1fb5dK6/i0eWZxFkyYGlRvBVDM5jgeQuONmLttF72KlOEjxrzQWE6zC7mAku3prGjsYLV1I=
X-Received: by 2002:a63:4285:0:b0:477:15c8:cd8a with SMTP id
 p127-20020a634285000000b0047715c8cd8amr4250171pga.595.1668758935435; Fri, 18
 Nov 2022 00:08:55 -0800 (PST)
MIME-Version: 1.0
References: <20221117182720.2290761-1-thierry.reding@gmail.com> <20221117182720.2290761-3-thierry.reding@gmail.com>
In-Reply-To: <20221117182720.2290761-3-thierry.reding@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 18 Nov 2022 09:08:17 +0100
Message-ID: <CAPDyKFpGs4TvkV5FKnfpQH45qAiwhJfSiP60P2vMSX30GsMkQQ@mail.gmail.com>
Subject: Re: [PATCH v11 2/6] iommu/tegra: Add tegra_dev_iommu_get_stream_id() helper
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-mmc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 17 Nov 2022 at 19:27, Thierry Reding <thierry.reding@gmail.com> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> Access to the internals of struct iommu_fwspec by non-IOMMU drivers is
> discouraged. Many drivers for Tegra SoCs, however, need access to their
> IOMMU stream IDs so that they can be programmed into various hardware
> registers.
>
> Formalize this access into a common helper to make it easier to audit
> and maintain.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  include/linux/iommu.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index dc5e6f5c14fc..f0d72acad7db 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -1186,4 +1186,25 @@ static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
>  }
>  #endif /* CONFIG_IOMMU_SVA */
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
> +       struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> +
> +       if (fwspec && fwspec->num_ids == 1) {
> +               *stream_id = fwspec->ids[0] & 0xffff;
> +               return true;
> +       }
> +#endif

It's totally up to iommu maintainers to decide, but I personally would
prefer to replace the below part with a stub function, defined when
CONFIG_IOMMU_API is unset.

> +
> +       return false;
> +}
> +
>  #endif /* __LINUX_IOMMU_H */
> --
> 2.38.1
>

Other than that, both patch1 and patch2 look good to me. I can pick up
the series, after an ack from Robin or Joerg.

Kind regards
Uffe
