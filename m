Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F97CC433FE
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Nov 2021 23:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351065AbhKYXlx (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Nov 2021 18:41:53 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:53654 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349130AbhKYXjw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Nov 2021 18:39:52 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20211125233639epoutp0197ec18895c641a4c25067e65a9177515~67kY0KMPn1745117451epoutp01D
        for <linux-mmc@vger.kernel.org>; Thu, 25 Nov 2021 23:36:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20211125233639epoutp0197ec18895c641a4c25067e65a9177515~67kY0KMPn1745117451epoutp01D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637883399;
        bh=JWonVlDSDmM3oiIE7KEKaGVT6BwRN7GTbMxpVTILinU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=merM3j9Dr4rv6k64w3rS92QvAWoBElaOwBj67jVEvFf4wfMjonqBqm3t8xMaNn9VR
         +9SGZc8S4XAzVrtsf4B+80oDIul6dSfZoRSUp7NQFz5l41r0DInO2O8CGFv70ZQt29
         wSEGWBKfwCXr1rvrJ5rIiKD3wwq17aYnr+bWjtt8=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20211125233639epcas1p3c2b0b580a87e545a424ca194d00fcda0~67kYOdlQq1794117941epcas1p3M;
        Thu, 25 Nov 2021 23:36:39 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.231]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4J0Z5Y1rLhz4x9Q2; Thu, 25 Nov
        2021 23:36:33 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A9.29.08277.CFD10A16; Fri, 26 Nov 2021 08:36:28 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20211125233628epcas1p352fa8cb6ff80f836a4e71cf2d5fb13c3~67kOFQcab2656726567epcas1p36;
        Thu, 25 Nov 2021 23:36:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211125233628epsmtrp1f4031a8ba95af217aea75585978c97e2~67kOEjRga0822408224epsmtrp1v;
        Thu, 25 Nov 2021 23:36:28 +0000 (GMT)
X-AuditID: b6c32a36-203ff70000002055-74-61a01dfc9903
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4F.4A.08738.CFD10A16; Fri, 26 Nov 2021 08:36:28 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211125233628epsmtip2f17c10da4bc7c7b9721a9dbdab6b55ac~67kN41BF21172711727epsmtip2c;
        Thu, 25 Nov 2021 23:36:28 +0000 (GMT)
Subject: Re: [PATCH 2/4] mmc: dw_mmc: hi3798cv200: use common_caps
To:     John Keeping <john@metanate.com>, linux-mmc@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <af210f7b-01ee-40f4-f6c0-4cbdafd87a3d@samsung.com>
Date:   Fri, 26 Nov 2021 08:37:09 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124184603.3897245-3-john@metanate.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmge4f2QWJBp8uq1n8f/Sa1eL9pims
        Fhvf/mCy2PT4GqvF5V1z2CyO/O9ntPj04D+zxYzz+5gsjq8Nd+D0mNXQy+Zx59oeNo/NS+o9
        Nk25xeqx/do8Zo/Pm+QC2KKybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPIS
        c1NtlVx8AnTdMnOAblJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgW6BUn5haX
        5qXr5aWWWBkaGBiZAhUmZGdc/H+NveAQd8XUD0tZGxgPc3YxcnBICJhI3J+l0cXIySEksINR
        Ym17aBcjF5D9iVFi352PjBDOZ0aJ17/nsoBUgTRMmdjEDJHYxSgx98AFFgjnPaNE7+5zYFXC
        Ak4Sp2Y9ZgexRQTsJbpevGcDsZkFpjBJbNjvDmKzCehIbP92nAnE5hWwk1j27CwjiM0ioCqx
        flILM4gtKhApcf/HcnaIGkGJkzOfgM3nFLCUePDzLivETHGJW0/mM0HY8hLb384Bu05CYCmH
        xOFXr1ghznaRmPqoFeoFYYlXx7ewQ9hSEi/729ghGpYxSty5/ZcNwlnPKHFg+xI2iCpjif1L
        JzOBQoxZQFNi/S59iLCixM7fcxkhNvNJvPvawwoJVF6JjjYhiBIViUuvXzLB7Lr75D/UPR4S
        m0/NY5rAqDgLyW+zkPwzC8k/sxAWL2BkWcUollpQnJueWmxYYASP7eT83E2M4PSqZbaDcdLb
        D3qHGJk4GA8xSnAwK4nwOgfOTxTiTUmsrEotyo8vKs1JLT7EaAoM7YnMUqLJ+cAEn1cSb2hi
        aWBiZmRsYmFoZqgkzvvCf3qikEB6YklqdmpqQWoRTB8TB6dUA9OClxtz2tRjDi5mWn/bgoV5
        0jfzKb05vh519t5GbVUPLylVOn8/3R/+LTXm1+XfelNZ/kTP/1DN/Xf6tQfVD4qFpmVF8jfN
        esTxT+DIXWejhS/ecc8t1Xw2XTDuuIDAeWeVR3WV76TaX+xIn7Jv0m35K+sntLR/Lsz+FFQ4
        1+MSF1OG7F2VAFbOj5/UdkxwOKxrtN9d17I7gO1V97qQgtmFOyufLvi5amletkqa4iFd29tZ
        j7lPmgZeTvzB+XmT2jqru6m9+/T3b2xxKg7bIPM4eU7exOaq3KkH86XdSyPuvFd3FvVnsa47
        uEEyqfZoYH+a/OW5F+b0t3/ckGnfGGcSHF3y6KfVB+Xrzcura5RYijMSDbWYi4oTAZM8ytY4
        BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXveP7IJEgzPXeSz+P3rNavF+0xRW
        i41vfzBZbHp8jdXi8q45bBZH/vczWnx68J/ZYsb5fUwWx9eGO3B6zGroZfO4c20Pm8fmJfUe
        m6bcYvXYfm0es8fnTXIBbFFcNimpOZllqUX6dglcGRf/X2MvOMRdMfXDUtYGxsOcXYycHBIC
        JhJTJjYxdzFycQgJ7GCUuHPoITNEQkri89OpbF2MHEC2sMThw8UQNW8ZJWb29jOB1AgLOEmc
        mvWYHcQWEbCX6Hrxng2kiFlgGpPE17WPmSA6djNKHNu4D6yDTUBHYvu342A2r4CdxLJnZxlB
        bBYBVYn1k1rANosKREqsO76MHaJGUOLkzCcsIDangKXEg593WUFsZgF1iT/zLjFD2OISt57M
        Z4Kw5SW2v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS9
        5PzcTYzgmNLS2sG4Z9UHvUOMTByMhxglOJiVRHidA+cnCvGmJFZWpRblxxeV5qQWH2KU5mBR
        Eue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cBk8DxVUefM9DCTaeoNd9zfbs3YZL/IRbZy19eZ
        V3++37iY7e7qSfGlnTlnM5ca+TFktt8X6l3+JJ1DLr+772VxSslfZqH50xfFHU0VbPui6Ziv
        v3A6z9IXXcbxS385dSwSitg7+4/B9JXqkoY6qbP7D/b/quyofbNVZN+sxX/95rbOKer6rCY8
        u4fjCee2eTP+u8zoOHJZ4fM+lpd6ioHG+icCbqVkNV4/uoL583YhDu+aN38Mp59nXOh+m7vQ
        xjxJzb5g4auSjpAHK8PE67tz5+iwzTD8fJBptbwNI6+eQfWpxNkhbzgmzTy29XjTnhK91CR1
        jbmvr1lEurFvTXgSI7AjY7XQvsOl7x2LN89QYinOSDTUYi4qTgQAolkB4hgDAAA=
X-CMS-MailID: 20211125233628epcas1p352fa8cb6ff80f836a4e71cf2d5fb13c3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211124184623epcas1p4d1eba3914cf6bd355d43e98cc2d3f5aa
References: <20211124184603.3897245-1-john@metanate.com>
        <CGME20211124184623epcas1p4d1eba3914cf6bd355d43e98cc2d3f5aa@epcas1p4.samsung.com>
        <20211124184603.3897245-3-john@metanate.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 11/25/21 3:46 AM, John Keeping wrote:
> The capabilities for all instances are the same, so use common_caps
> instead of caps/num_caps to remove the dependency on the mshcN device
> tree alias.
> 
> Signed-off-by: John Keeping <john@metanate.com>


Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/host/dw_mmc-hi3798cv200.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-hi3798cv200.c b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> index 39794f93826f..e9437ef8ef19 100644
> --- a/drivers/mmc/host/dw_mmc-hi3798cv200.c
> +++ b/drivers/mmc/host/dw_mmc-hi3798cv200.c
> @@ -23,12 +23,6 @@ struct hi3798cv200_priv {
>  	struct clk *drive_clk;
>  };
>  
> -static unsigned long dw_mci_hi3798cv200_caps[] = {
> -	MMC_CAP_CMD23,
> -	MMC_CAP_CMD23,
> -	MMC_CAP_CMD23
> -};
> -
>  static void dw_mci_hi3798cv200_set_ios(struct dw_mci *host, struct mmc_ios *ios)
>  {
>  	struct hi3798cv200_priv *priv = host->priv;
> @@ -166,8 +160,7 @@ static int dw_mci_hi3798cv200_init(struct dw_mci *host)
>  }
>  
>  static const struct dw_mci_drv_data hi3798cv200_data = {
> -	.caps = dw_mci_hi3798cv200_caps,
> -	.num_caps = ARRAY_SIZE(dw_mci_hi3798cv200_caps),
> +	.common_caps = MMC_CAP_CMD23,
>  	.init = dw_mci_hi3798cv200_init,
>  	.set_ios = dw_mci_hi3798cv200_set_ios,
>  	.execute_tuning = dw_mci_hi3798cv200_execute_tuning,
> 

