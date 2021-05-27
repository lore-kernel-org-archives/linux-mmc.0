Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89971C4707F
	for <linux-mmc@archiver.kernel.org>; Thu, 27 May 2021 23:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B81961006
	for <linux-mmc@archiver.kernel.org>; Thu, 27 May 2021 23:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhE0X6q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 27 May 2021 19:58:46 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:47691 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234626AbhE0X6Y (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 27 May 2021 19:58:24 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210527235649epoutp04672ab7645d275a60e0b563686ff7c170~DEcB1N4VZ0470004700epoutp04E
        for <linux-mmc@vger.kernel.org>; Thu, 27 May 2021 23:56:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210527235649epoutp04672ab7645d275a60e0b563686ff7c170~DEcB1N4VZ0470004700epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1622159809;
        bh=gtFqU2NEdwUJBLT9EB4jGlkIEgKefFjqY20EY2DcedE=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=NIAFxju2i7lagxoZueaSaQTUq3gROquHr5UTedx7Z87K+H+1oWUL/zXZuYk15yXPw
         Y99O+cDc80f5X12HPy7/WW/DGTnaA6tAnY6/lLF9Kk7sSsuBAytb+069pz5OFGPyji
         UE45SYnheZSKeEkbj/Ts5IsWGaC+3yc8WeasRcWY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210527235648epcas1p2c0b32e03528a6aaee0f81502aaffe29b~DEcBnoevG2424324243epcas1p2k;
        Thu, 27 May 2021 23:56:48 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.158]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Frl8v5n6Xz4x9QF; Thu, 27 May
        2021 23:56:47 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.97.09736.FB130B06; Fri, 28 May 2021 08:56:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210527235647epcas1p1904b4d64482cff069060f900d0086c90~DEcADZr-Z0201902019epcas1p1Q;
        Thu, 27 May 2021 23:56:47 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210527235647epsmtrp2f4f7380a6b0ec5d666a1d1517fc7370c~DEcACqDO61405514055epsmtrp2E;
        Thu, 27 May 2021 23:56:47 +0000 (GMT)
X-AuditID: b6c32a39-8d9ff70000002608-62-60b031bfa7d5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.75.08163.FB130B06; Fri, 28 May 2021 08:56:47 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210527235646epsmtip182071fb446fb5dfae501d24a853f96a8~DEb-0lr0P2566225662epsmtip1Z;
        Thu, 27 May 2021 23:56:46 +0000 (GMT)
Subject: Re: [PATCH] mmc: dw_mmc-pltfm: Remove unused <linux/clk.h>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Addy Ke <addy.ke@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <f8d2c558-5f26-55e2-3e6d-5752b6643c38@samsung.com>
Date:   Fri, 28 May 2021 08:57:41 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210527194226.1705607-1-geert@linux-m68k.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdlhTT3e/4YYEg23r9CyW/f/OZPHs1l4m
        i8u75rBZHPnfz2hxfG24A6vHnWt72DwOHe5g9Pg7az+Lx+dNcgEsUdk2GamJKalFCql5yfkp
        mXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUBrlRTKEnNKgUIBicXFSvp2NkX5
        pSWpChn5xSW2SqkFKTkFlgV6xYm5xaV56XrJ+blWhgYGRqZAhQnZGW3dvSwFF9kqZl+0b2A8
        xNrFyMkhIWAicevaNKYuRi4OIYEdjBLXlz5mgXA+MUo8/LOKDcL5zCix7MEHRpiWs+c3Q7Xs
        YpT4unoPVNV7RomGCzuZuxg5OIQFnCVaGvxBGkQEyiWWd/4Da2YWsJb4+aMVbDebgI7E9m/H
        mUBsXgE7iY79X5hAWlkEVCVOPUsACYsKRErsfPqSHaJEUOLkzCcsIDangI1E+7IJrBAjxSVu
        PZnPBGHLS2x/O4cZ5BwJgY/sEk92rgWbKSHgIjHrox3E/cISr45vYYewpSQ+v9vLBmFXS+xq
        PgPV28EocWtbExNEwlhi/9LJYHOYBTQl1u/ShwgrSuz8PRfqLT6Jd197WCFW8Up0tAlBlKhI
        XHr9kglm1d0n/6FKPCSaXpVMYFScheSxWUiemYXkmVkIexcwsqxiFEstKM5NTy02LDBFjulN
        jODkqGW5g3H62w96hxiZOBgPMUpwMCuJ8B5sXpsgxJuSWFmVWpQfX1Sak1p8iNEUGNITmaVE
        k/OB6TmvJN7Q1MjY2NjCxNDM1NBQSZw33bk6QUggPbEkNTs1tSC1CKaPiYNTqoFJvd5/qZN5
        XuL5q+9+3ngY6sG9Yr7zVa06kcSQ1UI/vkzh3v9P2paj2887/fz3xqlzQpJDb0xd8kN21+qo
        kjM5CQGVc9518/9LSTutEe3iYHs48m/k89aWmDP7df6cl+SwTH737WJPRGOCwieOb68KfM8e
        3tFk+P38f8WplicZUkNu+4ZPFUtjkKzpT07eGuAaLrah5VuYkmHVK7vbxi5Xol/1/HYu+/H1
        v82jYGnjt/onRZ9tbxXmfpq3nF/ss9ritVpOpxlX/Pv7drupU59i4KOi1EiVtEf3zA8bbgt6
        esb78LMq65CQc4EKewIfV9y4csijOKUxrFrh2PH2ojRDDqZ551W//ZnLlf6+nEGJpTgj0VCL
        uag4EQB1r5xKFwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSnO5+ww0JBnuaWCyW/f/OZPHs1l4m
        i8u75rBZHPnfz2hxfG24A6vHnWt72DwOHe5g9Pg7az+Lx+dNcgEsUVw2Kak5mWWpRfp2CVwZ
        bd29LAUX2SpmX7RvYDzE2sXIySEhYCJx9vxmpi5GLg4hgR2MEpu/rGKCSEhJfH46la2LkQPI
        FpY4fLgYouYto8S5t2/YQeLCAs4SLQ3+IOUiAuUSEz/fZwaxmQWsJX7+aGWFqO9nlLiwZRkL
        SIJNQEdi+7fjYPN5BewkOvZ/YQKZwyKgKnHqWQKIKSoQKbFzhyVEhaDEyZlPwDo5BWwk2pdN
        YIUYry7xZ94lqFXiEreezGeCsOUltr+dwzyBUWgWkvZZSFpmIWmZhaRlASPLKkbJ1ILi3PTc
        YsMCo7zUcr3ixNzi0rx0veT83E2M4HjQ0trBuGfVB71DjEwcjIcYJTiYlUR4DzavTRDiTUms
        rEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampBahFMlomDU6qBycJ64sz55zjrRBPy
        96zkz8xaKecxzzbF6URL44H5Z9cLB2zY5fR/ulxmwPeO3fwXFljtvXWyXjUhSO73Oc9lxzKU
        9p03v6JhtmDHF0+DlVuTvtcekuFacIzxi86by5tCLVjuFD678qJiXcTiyLYgjhbr67ntT5L6
        d3P1/vC63vup78OMk9fs7RT/lp+skvc6f+abySRV2x3hQrujBVv+Kb04u0WMVZpRc+efb5vq
        /5zhFVobaJj9csbNyXLHoyXXxGcziB27d1h41rP/HFoVH17Lsc7b6Bb5TK8lte9UUq+9btWJ
        z4rsmye6f2Xrfnhod/93lkfBLnukFHPSRVw+yD226dc0uaw+vSNR7/QKeyWW4oxEQy3mouJE
        AP5RS//2AgAA
X-CMS-MailID: 20210527235647epcas1p1904b4d64482cff069060f900d0086c90
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210527194237epcas1p4c5213a3d5e6b1b7b87ba3d994f6ee122
References: <CGME20210527194237epcas1p4c5213a3d5e6b1b7b87ba3d994f6ee122@epcas1p4.samsung.com>
        <20210527194226.1705607-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 5/28/21 4:42 AM, Geert Uytterhoeven wrote:
> As of commit 4cdc2ec1da322776 ("mmc: dw_mmc: move rockchip related code
> to a separate file"), dw_mmc-pltfm.c no longer uses the clock API.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/host/dw_mmc-pltfm.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc-pltfm.c b/drivers/mmc/host/dw_mmc-pltfm.c
> index 73731cd3ba2315e3..9901208be7973f67 100644
> --- a/drivers/mmc/host/dw_mmc-pltfm.c
> +++ b/drivers/mmc/host/dw_mmc-pltfm.c
> @@ -17,7 +17,6 @@
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/mmc.h>
>  #include <linux/of.h>
> -#include <linux/clk.h>
>  
>  #include "dw_mmc.h"
>  #include "dw_mmc-pltfm.h"
> 

