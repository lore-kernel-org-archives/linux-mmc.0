Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1B343D64
	for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760706455; cv=none; b=M8c/HSbr4ZXHYlFMawTkU+IAKfrv7cN3V/ukoJyP49PdNIGnvt6bvH4ExESQcB/Fwa6VXh0DmHjhVrmkQQaO1u+YsodKcC9Y2A3FxBIc+jI6USAxGqj2AUFIyfJ7pkEpRHfb6Behm7frizWdzBPLgclsYddcomvo4mMwAOC7KEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760706455; c=relaxed/simple;
	bh=+/qLMtVBIWqwLGMAuHcsQDTwgVp463iJrpIJllPu/rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QS7a/JejhXh0ht6ZWQa+cq/hAuQ/iEYU6P9wZtjd/EnBDVauaLoKh8nHp8DAu2tCVeuZQS5bYZtICNxq/KlCJa1FAQsLHUY5yWr9gJxuKLDQo6fafXTpDBA1knHRc0azppe1BuGLEqDbwwree0Z2yZ9x8gEAEMrMgoBvra77gm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BkoM1ja+; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BkoM1ja+"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-635355713d9so2083727d50.3
        for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 06:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760706452; x=1761311252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=50cVqA2F5ClWFlvjEjCRe8At6ftPcm1Q3YVimsx0O/4=;
        b=BkoM1ja+UdrZQ5CS7envY+JXLsRcJeIcM+wPqd+s9bPNZCWAaQU0DJW3sIEOHikseA
         hCmRAJ8U2G3HBFiREKRMPAus/HyOFRPWY8iSQu6F1+gh+xdpTBEblHHKHoh+sf6Twc3e
         sV8idxrQukSIBIO0C2KBRA+bcDx10ko4J/1yx6GvPWmZM+6yPvdP8gZMTzLd8VarUcUr
         Y/oQWdV08xKcq7hJI3LJe8kvbludkzXn0oNZ9R5BP7zHFmIYqy8erKpihSZ6LiH0DKgS
         SMG76uptfwlxDEdcKPNBqDU/WOYhu6mXR7R1aUxkUrLySBKDniMru79cD7QvQ3FBzSqP
         Q8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760706452; x=1761311252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50cVqA2F5ClWFlvjEjCRe8At6ftPcm1Q3YVimsx0O/4=;
        b=VVUzIunYGqbnY/kDhMM81VQQ2aiz8YfOUM29wBdkioPT6fOYWDJdcLRBDOjkiVteHR
         pyoRMnon3ZZZpe4zvcSInpH4Opmm0WPxbfqvT9O87q0cOLeuHXyAc+apPDFcZXnGPYJs
         MKCipSX1GT4LXpB9Hrp+DEfgaGfSDldTLbVNm5R79uVeg6OuWE27D8uOPrbHN6YxwjLT
         zuCDDQ3IrqDdHSvK3qCJdhk7zgqoxmStEV+KN9T4MRJkdL8nmd8CR/bg3Zfu22CSMcHu
         0A1i0h12YMXLD5PZKsMo9wqMmWNEp5zqFsqMM1MlQX4O2PjjPoaPXQHPub9sZ5SCDtbQ
         m+Zw==
X-Forwarded-Encrypted: i=1; AJvYcCU1ClYKyGvTv0hZKhRGm3GX5JUaHIY5jTiX+oNZhcvdM0WSpQg9tgbWGKyETMEVd15Cl/I71WcXtdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCs7Dm4+dAWI5QCzD1kMJxE1e+HmCAMp1w89pMG0xwXg6ns4Eu
	0Rc/xbkHSCJahGXtgebTHMvHZ+AePmIFlFdoqDdtamr4KTV7zagDgkEgjyLOde/T0lxpMUV6/MT
	whDU2BsY/zb02GPUhzuK5vGrSUduqvnAjFaFnRO4K/0ziZqzAERTW
X-Gm-Gg: ASbGncu6hkwUKm9tatYCnJ06hfWJfRp5eTgQwI5fcmC60SSIlkdoEXZJdqIDvdpD/YR
	98dV4eDxCro9QEhFv+QH/OMG4UrY9HYOpwIcgT5gHebDftHgy3cSA49+vs0tZx5GuQO919vMvx1
	blcLSoBZRTuI9ai0bQn3gel6+Z8+j2qHVC8pF43I/QikVnrg758NVLUlobFLvEgu+uL3zw6KDUJ
	uk2xzwBjqMTfWPwgw5jJKgcVGVyeGwcvrMb7uW+0/GOaFcBxDAsnEQgxjBASQ==
X-Google-Smtp-Source: AGHT+IGSrS4HDocorfqEfmZwZOOsXvwvjCJbCOF3S3WNcbmbO5EGBeCiu+E3JHa3nXouVXCrJ5i9C50oOQd1adkQz88=
X-Received: by 2002:a05:690e:1598:10b0:636:1409:c497 with SMTP id
 956f58d0204a3-63e16168320mr2602070d50.3.1760706452091; Fri, 17 Oct 2025
 06:07:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014093503.347678-1-quic_mdalam@quicinc.com>
In-Reply-To: <20251014093503.347678-1-quic_mdalam@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:06:56 +0200
X-Gm-Features: AS18NWDjFAK_bFxixRqaZq-uFC_4ekgdVLwCh3tsP53Kf7WO5KoCxzvYk305ack
Message-ID: <CAPDyKFpYi+fRi+saBitmbFFci41K-pWAre80wQqyujuA9DrP-Q@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-msm: Enable ICE support for non-cmdq eMMC devices
To: Md Sadre Alam <quic_mdalam@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
	Eric Biggers <ebiggers@google.com>
Cc: adrian.hunter@intel.com, linux-arm-msm@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_varada@quicinc.com
Content-Type: text/plain; charset="UTF-8"

+ Abel, Eric

On Tue, 14 Oct 2025 at 11:35, Md Sadre Alam <quic_mdalam@quicinc.com> wrote:
>
> Enable Inline Crypto Engine (ICE) support for eMMC devices that operate
> without Command Queue Engine (CQE).This allows hardware-accelerated
> encryption and decryption for standard (non-CMDQ) requests.
>
> This patch:
> - Adds ICE register definitions for non-CMDQ crypto configuration
> - Implements a per-request crypto setup via sdhci_msm_ice_cfg()
> - Hooks into the request path via mmc_host_ops.request
> - Initializes ICE hardware during CQE setup for compatible platforms
>
> With this, non-CMDQ eMMC devices can benefit from inline encryption,
> improving performance for encrypted I/O while maintaining compatibility
> with existing CQE crypto support.
>
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Before applying this I want to get confirmation from the people who
implemented the inline crypto engine support, hence I have added Abel
and Eric.

Kind regards
Uffe

> ---
>
> Change in [v2]
>
> * Moved NONCQ_CRYPTO_PARM and NONCQ_CRYPTO_DUN register definitions into
>   sdhci-msm.c
>
> * Introduced use of GENMASK() and FIELD_PREP() macros for cleaner and more
>   maintainable bitfield handling in ICE configuration.
>
> * Removed redundant if (!mrq || !cq_host) check from sdhci_msm_ice_cfg()
>   as both are guaranteed to be valid in the current call path.
>
> * Added assignment of host->mmc_host_ops.request = sdhci_msm_request; to
>   integrate ICE configuration into the standard request path for non-CMDQ
>   eMMC devices.
>
> * Removed sdhci_crypto_cfg() from sdhci.c and its invocation in sdhci_request()
>
> Change in [v1]
>
> * Added initial support for Inline Crypto Engine (ICE) on non-CMDQ eMMC
>   devices.
>
>  drivers/mmc/host/sdhci-msm.c | 71 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 4e5edbf2fc9b..483aadaca262 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -157,6 +157,18 @@
>  #define CQHCI_VENDOR_CFG1      0xA00
>  #define CQHCI_VENDOR_DIS_RST_ON_CQ_EN  (0x3 << 13)
>
> +/* non command queue crypto enable register*/
> +#define NONCQ_CRYPTO_PARM              0x70
> +#define NONCQ_CRYPTO_DUN               0x74
> +
> +#define DISABLE_CRYPTO                 BIT(15)
> +#define CRYPTO_GENERAL_ENABLE          BIT(1)
> +#define HC_VENDOR_SPECIFIC_FUNC4       0x260
> +#define ICE_HCI_SUPPORT                        BIT(28)
> +
> +#define ICE_HCI_PARAM_CCI      GENMASK(7, 0)
> +#define ICE_HCI_PARAM_CE       GENMASK(8, 8)
> +
>  struct sdhci_msm_offset {
>         u32 core_hc_mode;
>         u32 core_mci_data_cnt;
> @@ -1885,6 +1897,48 @@ static void sdhci_msm_set_clock(struct sdhci_host *host, unsigned int clock)
>
>  #ifdef CONFIG_MMC_CRYPTO
>
> +static int sdhci_msm_ice_cfg(struct sdhci_host *host, struct mmc_request *mrq,
> +                            u32 slot)
> +{
> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
> +       struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
> +       struct mmc_host *mmc = msm_host->mmc;
> +       struct cqhci_host *cq_host = mmc->cqe_private;
> +       unsigned int crypto_params = 0;
> +       int key_index = 0;
> +       bool bypass = true;
> +       u64 dun = 0;
> +
> +       if (mrq->crypto_ctx) {
> +               dun = mrq->crypto_ctx->bc_dun[0];
> +               bypass = false;
> +               key_index = mrq->crypto_key_slot;
> +       }
> +
> +       crypto_params = FIELD_PREP(ICE_HCI_PARAM_CE, !bypass) |
> +                       FIELD_PREP(ICE_HCI_PARAM_CCI, key_index);
> +
> +       cqhci_writel(cq_host, crypto_params, NONCQ_CRYPTO_PARM);
> +
> +       if (mrq->crypto_ctx)
> +               cqhci_writel(cq_host, lower_32_bits(dun), NONCQ_CRYPTO_DUN);
> +
> +       /* Ensure crypto configuration is written before proceeding */
> +       wmb();
> +
> +       return 0;
> +}
> +
> +static void sdhci_msm_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +       struct sdhci_host *host = mmc_priv(mmc);
> +
> +       if (mmc->caps2 & MMC_CAP2_CRYPTO)
> +               sdhci_msm_ice_cfg(host, mrq, 0);
> +
> +       sdhci_request(mmc, mrq);
> +}
> +
>  static const struct blk_crypto_ll_ops sdhci_msm_crypto_ops; /* forward decl */
>
>  static int sdhci_msm_ice_init(struct sdhci_msm_host *msm_host,
> @@ -2131,6 +2185,8 @@ static int sdhci_msm_cqe_add_host(struct sdhci_host *host,
>         struct cqhci_host *cq_host;
>         bool dma64;
>         u32 cqcfg;
> +       u32 config;
> +       u32 ice_cap;
>         int ret;
>
>         /*
> @@ -2185,6 +2241,18 @@ static int sdhci_msm_cqe_add_host(struct sdhci_host *host,
>         if (ret)
>                 goto cleanup;
>
> +       /* Initialize ICE for non-CMDQ eMMC devices */
> +       config = sdhci_readl(host, HC_VENDOR_SPECIFIC_FUNC4);
> +       config &= ~DISABLE_CRYPTO;
> +       sdhci_writel(host, config, HC_VENDOR_SPECIFIC_FUNC4);
> +       ice_cap = cqhci_readl(cq_host, CQHCI_CAP);
> +       if (ice_cap & ICE_HCI_SUPPORT) {
> +               config = cqhci_readl(cq_host, CQHCI_CFG);
> +               config |= CRYPTO_GENERAL_ENABLE;
> +               cqhci_writel(cq_host, config, CQHCI_CFG);
> +       }
> +       sdhci_msm_ice_enable(msm_host);
> +
>         dev_info(&pdev->dev, "%s: CQE init: success\n",
>                         mmc_hostname(host->mmc));
>         return ret;
> @@ -2759,6 +2827,9 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>
>         msm_host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY | MMC_CAP_NEED_RSP_BUSY;
>
> +#ifdef CONFIG_MMC_CRYPTO
> +       host->mmc_host_ops.request = sdhci_msm_request;
> +#endif
>         /* Set the timeout value to max possible */
>         host->max_timeout_count = 0xF;
>
> --
> 2.34.1
>
