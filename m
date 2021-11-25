Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0182BC433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Nov 2021 23:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbhKYXnG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Nov 2021 18:43:06 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:54608 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhKYXlE (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Nov 2021 18:41:04 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211125233751epoutp0184f27c4081736dda003800f2f6e2df52~67lb0eoKT1818118181epoutp01N
        for <linux-mmc@vger.kernel.org>; Thu, 25 Nov 2021 23:37:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211125233751epoutp0184f27c4081736dda003800f2f6e2df52~67lb0eoKT1818118181epoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637883471;
        bh=iAT+mgTKP0qSLr5wH6L2x4B35cuACZi9WnO1ZnH4DRI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=jSLQN4jPtLgFXtYQt8ew8EzcQ1eqIUAmrU+HwdY+PVxNt6TWLm08/x277HZREd8Q1
         K4OErvgKb31bW7JV57D2NfuzKUGrQxklgfnB1GdVnSW8msvsUnvDgE7cN0vShAwcKi
         05r5hEhHiWqFpXU6Sj0km7GusIJlicrBrofFe/Xg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211125233751epcas1p38b5410fc9ddd8ca7ded02132daf4ab34~67lbRSqNi1794117941epcas1p3K;
        Thu, 25 Nov 2021 23:37:51 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.233]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4J0Z6v01QCz4x9QL; Thu, 25 Nov
        2021 23:37:43 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.D2.21932.E0E10A16; Fri, 26 Nov 2021 08:36:46 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211125233738epcas1p3c2cdae5ccb402eb3fd6fe5d74d8bade5~67lPtflmC1794917949epcas1p3-;
        Thu, 25 Nov 2021 23:37:38 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211125233738epsmtrp133189c996986116c7ad5265b24e1d91e~67lPsr9un0822408224epsmtrp1c;
        Thu, 25 Nov 2021 23:37:38 +0000 (GMT)
X-AuditID: b6c32a38-93fff700000255ac-24-61a01e0e79a9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.6A.08738.24E10A16; Fri, 26 Nov 2021 08:37:38 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211125233738epsmtip22a482fe529c2d57410b48c70651556e0~67lPbuV8T0085900859epsmtip2N;
        Thu, 25 Nov 2021 23:37:38 +0000 (GMT)
Subject: Re: [PATCH 4/4] mmc: dw_mmc: exynos: use common_caps
To:     John Keeping <john@metanate.com>, linux-mmc@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <bfb7cc7f-d01a-f99e-2085-d1b3e252d7dd@samsung.com>
Date:   Fri, 26 Nov 2021 08:38:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124184603.3897245-5-john@metanate.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmgS6f3IJEg+bHzBb/H71mtXi/aQqr
        xca3P5gsNj2+xmpxedccNosj//sZLT49+M9sMeP8PiaL42vDHTg9ZjX0snncubaHzWPzknqP
        TVNusXpsvzaP2ePzJrkAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
        3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BaYFesWJucWl
        eel6eaklVoYGBkamQIUJ2Rlbvn9jKTjJU7FhUwtbA+MCri5GTg4JAROJF3OaGbsYuTiEBHYw
        Shz59YUVwvnEKNF24QYzhPOZUWLLk1csMC1Xll9kgkjsYpR49rQPynnPKLFtwTM2kCphAVuJ
        PQ29YB0iAvYSXS/eg8WZBaYwSWzY7w5iswnoSGz/dpwJxOYVsJNoWnkCzGYRUJXofDWPGcQW
        FYiUuP9jOTtEjaDEyZlPwGZyClhKdO3YzQgxU1zi1pP5TBC2vMT2t3OYIS5dyiHx4FRBFyMH
        kO0isemuPkRYWOLV8S3sELaUxMv+NnaQ+yUEljFK3Ln9lw3CWc8ocWD7EjaIKmOJ/UsnM4EM
        YhbQlFi/C2qQosTO33OhbuCTePe1hxViF69ER5sQRImKxKXXL5lgdt198p8VwvaQWLnvOdsE
        RsVZSD6bheSbWUi+mYWweAEjyypGsdSC4tz01GLDAhN4bCfn525iBKdXLYsdjHPfftA7xMjE
        wXiIUYKDWUmE1zlwfqIQb0piZVVqUX58UWlOavEhRlNgWE9klhJNzgcm+LySeEMTSwMTMyNj
        EwtDM0Mlcd7n/tMThQTSE0tSs1NTC1KLYPqYODilGpiCjUIUPRJv+ekWTfmebvKl69oxhdNW
        iS+5mEpXvXt0R70u4aGH6LPymjnmHNH39scWbuISyf9QrRIxIT1cZNErzfzC79O+cZzqam+W
        L+f5m9Z9byffrZnsBdZ/nOVXJ566K7Y3wbHksc6+m01/lZJlKizz3l67IXIgbYbG9169qLCP
        m5imFFnviZ3XoXJMTrOjVNG4JD+bvUfd1/yROlPTVaEHGkZBrXH/JDszt9w9McEximURx6zK
        HxFeZ3s0bS4rif3bLndP+T6/mJDyvTX1dV+yufs/X04T+WrGWPR522TvqPDrqtO9Qu8vPrYq
        1lJf09zRXObq5Jl1uy8/3l9huvnnateUE+bJlx58VGIpzkg01GIuKk4EALLneoE4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXtdJbkGiQf93ZYv/j16zWrzfNIXV
        YuPbH0wWmx5fY7W4vGsOm8WR//2MFp8e/Ge2mHF+H5PF8bXhDpwesxp62TzuXNvD5rF5Sb3H
        pim3WD22X5vH7PF5k1wAWxSXTUpqTmZZapG+XQJXxpbv31gKTvJUbNjUwtbAuICri5GTQ0LA
        ROLK8otMXYxcHEICOxglLv9fyQ6RkJL4/HQqWxcjB5AtLHH4cDFEzVtGiZur9jKD1AgL2Ers
        aehlAbFFBOwlul68ZwMpYhaYxiTxde1jqKm7GSUOPvzMClLFJqAjsf3bcSYQm1fATqJp5Qkw
        m0VAVaLz1TywqaICkRLrji9jh6gRlDg58wnYBk4BS4muHbsZQWxmAXWJP/MuMUPY4hK3nsxn
        grDlJba/ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k
        /NxNjOCY0tLawbhn1Qe9Q4xMHIyHGCU4mJVEeJ0D5ycK8aYkVlalFuXHF5XmpBYfYpTmYFES
        573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwMRzmsHP7VSe0cu48oql+Sa3e9sC4pZp+Zee+a5q
        Odvz4bKVL3L0rfY+X17iV7BOVkDp8dF99/eVcTL3KH5eonT2jaywcnOCyPy6n2FfPNgyF24M
        zeWtfsx16Nv+uwle275wVddsPb7p12XL+SoLV/ZvecC0YE/ZE4uVYbZarssXpLZsylksn5z0
        YGZ00yttUa4b9lfvfV6/YJfXYoVJ0oWFol+v/LScZz8t+oS1UvfVFCntuqVvK0MzPnOvDCpS
        CLtTuyYud9XP5cdiBTe51T2Pu3Fo5dw57OdXX7yVLqu3xjkqrfmnvVD+sqze7QY88ysfvT6y
        +chOduYZa2ujNjOJTk4K8c/XDt3Ft8xmtpISS3FGoqEWc1FxIgCBs5duGAMAAA==
X-CMS-MailID: 20211125233738epcas1p3c2cdae5ccb402eb3fd6fe5d74d8bade5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211124184628epcas1p4130e325d30e2e32113f5c5cdf2d6c85d
References: <20211124184603.3897245-1-john@metanate.com>
        <CGME20211124184628epcas1p4130e325d30e2e32113f5c5cdf2d6c85d@epcas1p4.samsung.com>
        <20211124184603.3897245-5-john@metanate.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/25/21 3:46 AM, John Keeping wrote:
> Move the common MMC_CAP_CMD23 capability to common_caps so that only the
> special case of MMC_CAP_1_8V_DDR and MMC_CAP_8_BIT_DATA are set via
> caps/num_caps.  Both of those can, and should, be set via device tree
> properties instead, so we can now say that exynos_dwmmc_caps is only
> used for backwards compatibility.
> 
> Signed-off-by: John Keeping <john@metanate.com>


Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Added minor comment..

> ---
>  drivers/mmc/host/dw_mmc-exynos.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index c2dd29ef45c6..f76eeeb0cc53 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -526,15 +526,16 @@ static int dw_mci_exynos_prepare_hs400_tuning(struct dw_mci *host,
>  
>  /* Common capabilities of Exynos4/Exynos5 SoC */
>  static unsigned long exynos_dwmmc_caps[4] = {
> -	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA | MMC_CAP_CMD23,
> -	MMC_CAP_CMD23,
> -	MMC_CAP_CMD23,
> -	MMC_CAP_CMD23,
> +	MMC_CAP_1_8V_DDR | MMC_CAP_8_BIT_DATA,
> +	0,
> +	0,
> +	0,
>  };

It can be removed all things.

Best Regards,
Jaehoon Chung

>  
>  static const struct dw_mci_drv_data exynos_drv_data = {
>  	.caps			= exynos_dwmmc_caps,
>  	.num_caps		= ARRAY_SIZE(exynos_dwmmc_caps),
> +	.common_caps		= MMC_CAP_CMD23,
>  	.init			= dw_mci_exynos_priv_init,
>  	.set_ios		= dw_mci_exynos_set_ios,
>  	.parse_dt		= dw_mci_exynos_parse_dt,
> 

