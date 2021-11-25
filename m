Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C87C433F5
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Nov 2021 23:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351334AbhKYXl7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Nov 2021 18:41:59 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:17463 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350152AbhKYXj6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Nov 2021 18:39:58 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20211125233645epoutp0480d949c4a7b6bbb9b048f6124d3c491c~67keJ--Gi0048400484epoutp04S
        for <linux-mmc@vger.kernel.org>; Thu, 25 Nov 2021 23:36:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20211125233645epoutp0480d949c4a7b6bbb9b048f6124d3c491c~67keJ--Gi0048400484epoutp04S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1637883405;
        bh=W625ZNUaj7d3xUdQRsl5mee2E9F/JhrN5dIN9uTOYwU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VsSK7VHMt9bllYj21pmgeAJiut/g2oO9hUL7zjGYhNsORGITwgipmFv7GKDuIf8ol
         YMWskYSIOlpZHcHNkMFmgH1ZmefxCslgiGx/XWMmePMgkykTVrq9A/sqbK5u3msB/E
         eI5DK4JHVcqqnthmserbe+UH+w6h721CkGFilurs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211125233645epcas1p1dfbef5b1493549a120cd034e85c45786~67kdyjvmv1069210692epcas1p14;
        Thu, 25 Nov 2021 23:36:45 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.232]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4J0Z5h5rtKz4x9Pw; Thu, 25 Nov
        2021 23:36:40 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.39.08277.80E10A16; Fri, 26 Nov 2021 08:36:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211125233640epcas1p21be9cf23ef5d3e484dfc177edb3fdced~67kZS_cZb1766117661epcas1p2u;
        Thu, 25 Nov 2021 23:36:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20211125233640epsmtrp173ed78d4e5f876e052b6cf030457df68~67kZR6tGF0863608636epsmtrp1B;
        Thu, 25 Nov 2021 23:36:40 +0000 (GMT)
X-AuditID: b6c32a36-203ff70000002055-93-61a01e087c29
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        66.4D.29871.80E10A16; Fri, 26 Nov 2021 08:36:40 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211125233640epsmtip27a29f739605c631ed244c6cbd78c94b0~67kZFwnAK1070910709epsmtip2z;
        Thu, 25 Nov 2021 23:36:40 +0000 (GMT)
Subject: Re: [PATCH 3/4] mmc: dw_mmc: rockchip: use common_caps
To:     John Keeping <john@metanate.com>, linux-mmc@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <bf3d8c87-d6ab-6f88-0d1c-23bd91188a67@samsung.com>
Date:   Fri, 26 Nov 2021 08:37:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211124184603.3897245-4-john@metanate.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmni6H3IJEg99tehb/H71mtXi/aQqr
        xca3P5gsNj2+xmpxedccNosj//sZLT49+M9sMeP8PiaL42vDHTg9ZjX0snncubaHzWPzknqP
        TVNusXpsvzaP2ePzJrkAtqhsm4zUxJTUIoXUvOT8lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE
        3FRbJRefAF23zBygm5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqpBSk5BaYFesWJucWl
        eel6eaklVoYGBkamQIUJ2Rl7V+xkL5jAXfH48lmmBsY+zi5GTg4JAROJo18/MnYxcnEICexg
        lFj+/gsLhPOJUWLxty9sIFVCAt8YJT4f8oDp2PKjGapjL6PE2h/TmSGc94wSF/pfgXUIC9hL
        3P32hhHEFgGyu168B4szC0xhktiw3x3EZhPQkdj+7TgTiM0rYCfxo28eC4jNIqAqcef1TzBb
        VCBS4v6P5ewQNYISJ2c+AYtzClhKHPu1jQliprjErSfzoWx5ie1v54AdJCEwl0Ni8rMjjBBn
        u0gseneABcIWlnh1fAs7hC0l8bK/jR2iYRmjxJ3bf9kgnPWMEge2L2GDqDKW2L90MtAKDqAV
        mhLrd+lDhBUldv6eywixmU/i3dceVpASCQFeiY42IYgSFYlLr18ywey6++Q/K4TtIXFj2jbG
        CYyKs5D8NgvJP7OQ/DMLYfECRpZVjGKpBcW56anFhgVG8OhOzs/dxAhOsFpmOxgnvf2gd4iR
        iYPxEKMEB7OSCK9z4PxEId6UxMqq1KL8+KLSnNTiQ4ymwNCeyCwlmpwPTPF5JfGGJpYGJmZG
        xiYWhmaGSuK8L/ynJwoJpCeWpGanphakFsH0MXFwSjUwtcakLbj4/fK56M38EZs7/f231n7n
        8ZtnJ78mnK1/8TnRGMZ/jlvlxQta+JVcpyzLtRJ/3r5uz9n4kPJ1/R+FPfjWJ67XvKfyrFgt
        Sc7Eg/OX1D91iU/6+u0LJK6snJHXz3qD4+YOSZGyPu6X5ZYJs17sqkjhz3I/bK+QvMr3yPbp
        0io3tEQvndUp0FwuNLnV63lqia/YlXMaFw3/uSpf6lar3Xz0WuXa/Xa5P3UW7e69+LD4UcNq
        r0SlJWf3Mgc8vsx3L3jr8g+Ox3Z/nu7yp1wxiqeBbd121UZR5bz0qcczeCeteuZn+XVjA6PD
        F3fXoGkHn/wzXcX96GZi1u7fKv0rnep3JG6Ueamj5OKkxFKckWioxVxUnAgACJPvjjkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplkeLIzCtJLcpLzFFi42LZdlhJXpdDbkGiwaIzfBb/H71mtXi/aQqr
        xca3P5gsNj2+xmpxedccNosj//sZLT49+M9sMeP8PiaL42vDHTg9ZjX0snncubaHzWPzknqP
        TVNusXpsvzaP2ePzJrkAtigum5TUnMyy1CJ9uwSujL0rdrIXTOCueHz5LFMDYx9nFyMnh4SA
        icSWH82MXYxcHEICuxklpv3tZoZISEl8fjqVrYuRA8gWljh8uBii5i2jxMwPE9lAaoQF7CXu
        fnvDCGKLANldL96zgRQxC0xjkvi69jET3NRNL18zgVSxCehIbP92HMzmFbCT+NE3jwXEZhFQ
        lbjz+ieYLSoQKbHu+DJ2iBpBiZMzn4DFOQUsJY792gbWyyygLvFn3iVmCFtc4taT+VBxeYnt
        b+cwT2AUmoWkfRaSlllIWmYhaVnAyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4
        prQ0dzBuX/VB7xAjEwfjIUYJDmYlEV7nwPmJQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2M
        FxJITyxJzU5NLUgtgskycXBKNTC13dzGeTPP981vI++eNQdNr2eZxwtZeFy3vnuq773S15i4
        3IXVe8Mqts/cPPHFdFbLpawX179ySn7gd33lu13pifmLNtlqRcf3BLa4NCrPXe/W8HVte6d5
        yTwpV9kfL1vEtrrtONqeK7Byl8iZuJCVAkfXKX+8mL7y7OG5z55t87jT/cmh/1L6sbpw6fji
        2KrQL3HfmG5avuhk+/119UN/o6tHPVbo13QsuDR3Vuy2DM1orWd/3/3d0BiqUuO/zEPv+2xO
        w/wZ0+OMYwQzlqQcvfmC2TiG5VjywrMNr1Or2629VS4IJDmFrZR9uv6tueN/gW+3mB7cC8ow
        u36veGmb1f1DL9e1rD5s82my59FyJZbijERDLeai4kQAxIcqKRgDAAA=
X-CMS-MailID: 20211125233640epcas1p21be9cf23ef5d3e484dfc177edb3fdced
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20211124190359epcas1p13d32594c5e3ed042571ab267779c5aa3
References: <20211124184603.3897245-1-john@metanate.com>
        <CGME20211124190359epcas1p13d32594c5e3ed042571ab267779c5aa3@epcas1p1.samsung.com>
        <20211124184603.3897245-4-john@metanate.com>
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
>  drivers/mmc/host/dw_mmc-rockchip.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
> index d36991acd6df..95d0ec0f5f3a 100644
> --- a/drivers/mmc/host/dw_mmc-rockchip.c
> +++ b/drivers/mmc/host/dw_mmc-rockchip.c
> @@ -300,21 +300,12 @@ static int dw_mci_rockchip_init(struct dw_mci *host)
>  	return 0;
>  }
>  
> -/* Common capabilities of RK3288 SoC */
> -static unsigned long dw_mci_rk3288_dwmmc_caps[4] = {
> -	MMC_CAP_CMD23,
> -	MMC_CAP_CMD23,
> -	MMC_CAP_CMD23,
> -	MMC_CAP_CMD23,
> -};
> -
>  static const struct dw_mci_drv_data rk2928_drv_data = {
>  	.init			= dw_mci_rockchip_init,
>  };
>  
>  static const struct dw_mci_drv_data rk3288_drv_data = {
> -	.caps			= dw_mci_rk3288_dwmmc_caps,
> -	.num_caps		= ARRAY_SIZE(dw_mci_rk3288_dwmmc_caps),
> +	.common_caps		= MMC_CAP_CMD23,
>  	.set_ios		= dw_mci_rk3288_set_ios,
>  	.execute_tuning		= dw_mci_rk3288_execute_tuning,
>  	.parse_dt		= dw_mci_rk3288_parse_dt,
> 

