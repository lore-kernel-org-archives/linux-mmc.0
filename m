Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C737C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 08:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 537F96113A
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Sep 2021 08:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245464AbhIQIsa (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Sep 2021 04:48:30 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:61561 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245459AbhIQIs3 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Sep 2021 04:48:29 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210917084706epoutp038aef38183dbd44a28dd5ee9d4fd031d0~lj7AAq3371613616136epoutp03N
        for <linux-mmc@vger.kernel.org>; Fri, 17 Sep 2021 08:47:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210917084706epoutp038aef38183dbd44a28dd5ee9d4fd031d0~lj7AAq3371613616136epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1631868426;
        bh=8Gxrk1S9d2ijCmTPideQeF61jv+I9XTJOeUHGT0hwcg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=SlYw6DyvrgZjfSUHcVlkvRwi/E04o9A8CD55gpl5NflE2VQ5cbNr31LRDc/W3VQy3
         bCxHBONmHQwb2R7cvNH8VTNvBIdb5O/aKiApPLHOiJWTu4qEKqNEeK1FH06yToo3mO
         xdWeSnYoY9yuZ6lOculBuQKpqrurqAOgpaz8Ih7c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210917084705epcas1p1a2e95d2a1f415bf7e46b1e7665173692~lj6-eluZ72199221992epcas1p1c;
        Fri, 17 Sep 2021 08:47:05 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.38.237]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4H9nd06gFwz4x9QC; Fri, 17 Sep
        2021 08:47:00 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        56.90.13888.00654416; Fri, 17 Sep 2021 17:46:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210917084656epcas1p408e3c7055701fc81481bdf364f2ed893~lj62xAnxm0631406314epcas1p46;
        Fri, 17 Sep 2021 08:46:56 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210917084656epsmtrp24b675d5029e68fbb60f3768353afad30~lj62wWbSp1886318863epsmtrp2m;
        Fri, 17 Sep 2021 08:46:56 +0000 (GMT)
X-AuditID: b6c32a39-211ff70000003640-6c-614456009c33
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        17.09.09091.FF554416; Fri, 17 Sep 2021 17:46:56 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210917084655epsmtip210c313d874c2bbc15890cae740bb6d1a~lj62horX72575425754epsmtip2g;
        Fri, 17 Sep 2021 08:46:55 +0000 (GMT)
Subject: Re: [PATCH] mmc: sdhci-s3c: drop unneeded MODULE_ALIAS
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <90d3b41d-d5db-33a2-7b61-7e8046c7ce07@samsung.com>
Date:   Fri, 17 Sep 2021 17:47:40 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210916170511.137915-1-krzysztof.kozlowski@canonical.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAJsWRmVeSWpSXmKPExsWy7bCmgS5DmEuiwfFuA4uTT9awWUxad4DJ
        YuPbH0wWl3fNYbM48r+f0eL42nAHNo9ZDb1sHn9XvWD2WLznJZPHnWt72Dw+b5ILYI3KtslI
        TUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBOkBJoSwxpxQo
        FJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BaoFecmFtcmpeul5daYmVoYGBkClSYkJ2xcbl/
        wTe2iuPT7jI3MH5h7WLk5JAQMJGYvvsCWxcjF4eQwA5GifsnXzCCJIQEPjFKrP4TBJH4xiix
        8OJxRpiOpX9vs0Mk9jJKrLm/gxnCec8o8WLGarAqYQF7idmf1gPZHBwiAtESt3frgNQwC0xk
        lLh+dwE7SA2bgI7E9m/HmUBsXgE7iS/vz4PFWQRUJTrvbmIBsUUFIiX+ntzFClEjKHFy5hOw
        OKeAh8SSdxvBbGYBcYlbT+YzQdjyEtvfzgE7SEKglUNiy/oNTCBHSAi4SGzZyQbxgbDEq+Nb
        2CFsKYnP7/ZCxasldjWfgertYJS4ta2JCSJhLLF/6WSwOcwCmhLrd+lDhBUldv6eywixl0/i
        3dceVohVvBIdbUIQJSoSl16/ZIJZdffJf2iwe0gcWdjJNoFRcRaSz2Yh+WYWkm9mISxewMiy
        ilEstaA4Nz212LDAFB7Xyfm5mxjBSVPLcgfj9Lcf9A4xMnEwHmKU4GBWEuG9UOOYKMSbklhZ
        lVqUH19UmpNafIjRFBjWE5mlRJPzgWk7ryTe0MTSwMTMyNjEwtDMUEmc99hry0QhgfTEktTs
        1NSC1CKYPiYOTqkGpphrsw1f7Fyx7yiX+5bJ3Fcs1St7HCaz2F6wMmLMn2oockfj5nadNwW8
        9lvfFkYtPW254Wv91xWWgctfpXHmLL3NzCwmHR/7fk7HfBGOe9dV97k/7dj94JiO+46Lh/Kk
        D7EaPLJz/xSYrxAkK/99p8eP2ez+2tfmn3ZlF+fl6q4/YjA7SDo3LNvzi6F41/LUxwmfzKY1
        65dFZOs8Olanfud08vyPiVn/V+7Xs5bm/Zo988PTiJiQNh/r6H9rZFv5H7u3rEm5136mStpm
        2qyvXlv6bh683Gz13Nz3zY4YK9Vzz2y2H3sTe1jNpOSb5e+zeWKzlfoElddPnGGUyHPO8lNf
        +Z5nh7sFDptcZ+f+osRSnJFoqMVcVJwIAKi7GgIjBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrALMWRmVeSWpSXmKPExsWy7bCSvC5DmEuiwY69jBYnn6xhs5i07gCT
        xca3P5gsLu+aw2Zx5H8/o8XxteEObB6zGnrZPP6uesHssXjPSyaPO9f2sHl83iQXwBrFZZOS
        mpNZllqkb5fAlbFxuX/BN7aK49PuMjcwfmHtYuTkkBAwkVj69zZ7FyMXh5DAbkaJnnfHmCES
        UhKfn05l62LkALKFJQ4fLoaoecsosfVDA1izsIC9xOxP6xlBbBGBaImuW41sIDazQD+jxKNV
        ohANsxklVi1dD9bAJqAjsf3bcSYQm1fATuLL+/PsIDaLgKpE591NLCC2qECkRNOJrWwQNYIS
        J2c+AYtzCnhILHm3kQVigbrEn3mXmCFscYlbT+YzQdjyEtvfzmGewCg0C0n7LCQts5C0zELS
        soCRZRWjZGpBcW56brFhgWFearlecWJucWleul5yfu4mRnCkaGnuYNy+6oPeIUYmDsZDjBIc
        zEoivBdqHBOFeFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRq
        YDKO2mr7cs+ZUlPtlzUL1FSaV7yUWdtz+8w09RcBqkp/Mg+tW2UtPLle+oK6Tt6SzaUPLS5a
        1u3YwW6nm6m3l+2kacaHSR6r6zSfZx15seRk26eT9m4nfoe+rNb4fj17kopJkmrjl8f6e2S+
        2DxVv5S4UPaM7+pfX4T6p9XPSvHb+T4nvGjXnblf5bMW3hXf0Hc2oeSZp4PmS+b5S8oOaa65
        PCH+6Zfg1s9Ki04GPEpXfHb/jVvHZdX+377u/mG5Wgn+qzY+mbx9y+QjxTt3FJ6fvOnDFluG
        UG193W3ldzjDsuLbf873F+7Vs/iupFrqY9Sl99W90ZQpMyR2L5tE7jNHLVdzrl3r193NYIhP
        nKDEUpyRaKjFXFScCADZUlcUAwMAAA==
X-CMS-MailID: 20210917084656epcas1p408e3c7055701fc81481bdf364f2ed893
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210916172004epcas1p2319884c6fcc67551399a4d0e2ba19cee
References: <CGME20210916172004epcas1p2319884c6fcc67551399a4d0e2ba19cee@epcas1p2.samsung.com>
        <20210916170511.137915-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 9/17/21 2:05 AM, Krzysztof Kozlowski wrote:
> The MODULE_DEVICE_TABLE already creates proper alias for platform
> driver.  Having another MODULE_ALIAS causes the alias to be duplicated.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsunhg.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/host/sdhci-s3c.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 862f033d235d..9085f3932443 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -791,4 +791,3 @@ module_platform_driver(sdhci_s3c_driver);
>  MODULE_DESCRIPTION("Samsung SDHCI (HSMMC) glue");
>  MODULE_AUTHOR("Ben Dooks, <ben@simtec.co.uk>");
>  MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("platform:s3c-sdhci");
> 

