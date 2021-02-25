Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA24C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 07:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDD8D64ED9
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 07:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhBYHS3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Feb 2021 02:18:29 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:53977 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhBYHS0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Feb 2021 02:18:26 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210225071739epoutp023b03f9f9e8cf6bd509f129baef602bc4~m7GrHAov61954119541epoutp02p
        for <linux-mmc@vger.kernel.org>; Thu, 25 Feb 2021 07:17:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210225071739epoutp023b03f9f9e8cf6bd509f129baef602bc4~m7GrHAov61954119541epoutp02p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614237459;
        bh=fJg0zRzkXEQMUG5OalYDqSfSccHgkY0ApL62phtZOXw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=qAMMJwvm0KbFxsoSRUjKv51r7gqhHDHF1URnD8Gwr20pmYXpVdEuBN4ETrhs5Y64K
         VoMZ93N6mmIr/SCkCt6g0ffy32EtIhk+2bJbGBQExGwEeLMwelzBkBjmTCnb1Pcn0i
         SMjMziRH2PhpQCj8ZpimWlQf5XWcLrzaILMRjK/M=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210225071739epcas1p397c5d19066a6b70c60d586e40d7b9b4a~m7GqeigaH2786727867epcas1p3N;
        Thu, 25 Feb 2021 07:17:39 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.162]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DmPJ20l6qz4x9Q9; Thu, 25 Feb
        2021 07:17:38 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        89.C6.09577.11F47306; Thu, 25 Feb 2021 16:17:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20210225071737epcas1p3c94d78490b86a86a21840a3105316ed7~m7Gox3XGo2981929819epcas1p3R;
        Thu, 25 Feb 2021 07:17:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210225071737epsmtrp2a9d45efbd7c991a5cb92eb4f5041a648~m7GoxAmTI1199311993epsmtrp2N;
        Thu, 25 Feb 2021 07:17:37 +0000 (GMT)
X-AuditID: b6c32a39-bfdff70000002569-e8-60374f11ba76
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        83.7A.08745.11F47306; Thu, 25 Feb 2021 16:17:37 +0900 (KST)
Received: from sh043lee03 (unknown [10.253.101.72]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210225071737epsmtip283c5fbfe7937581864204a1a036a9f96~m7Gof6s5Q2589525895epsmtip2b;
        Thu, 25 Feb 2021 07:17:36 +0000 (GMT)
From:   =?utf-8?B?7J207Iq57Z2s?= <sh043.lee@samsung.com>
To:     <ulf.hansson@linaro.org>, <pali@kernel.org>, <huyue2@yulong.com>,
        <tiantao6@hisilicon.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Cc:     <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
        <dh0421.hwang@samsung.com>, <junwoo80.lee@samsung.com>,
        <jangsub.yi@samsung.com>, <cw9316.lee@samsung.com>,
        <sh8267.baek@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <20210222083156.19158-1-sh043.lee@samsung.com>
Subject: RE: [PATCH] mmc: core: set read only with permanent write protect
Date:   Thu, 25 Feb 2021 16:17:36 +0900
Message-ID: <000001d70b46$4b55a800$e200f800$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQLkAIFN/NEy3Z1t/BSdwJSVZvCFVQKLtnjLqDolyjA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIJsWRmVeSWpSXmKPExsWy7bCmvq6Qv3mCwbxDjBYzTrWxWuy7dpLd
        4tff9ewWe2bfZbbo2DqZyWLH8zPsFrv+NjNZXN41h83iyP9+RosFe06zWVw7c4LVYvXrfewW
        x9eGW2y+9I3Fgc/j8dyN7B6bVnWyedy5tofNo2/LKkaPz5vkPLauWcwcwBaVY5ORmpiSWqSQ
        mpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdK2SQlliTilQKCCxuFhJ
        386mKL+0JFUhI7+4xFYptSAlp8DQoECvODG3uDQvXS85P9fK0MDAyBSoMiEnY3HDXaaCl4IV
        r6d+ZG5gPMzXxcjBISFgIvHlP38XIxeHkMAORom/u26zQjifGCXu3boI5XxmlLj/qI+9i5ET
        rOPx3wtMEIldjBI7LsxkBkkICbxglGi9rg0ylk3ATOL5nSCQGhGB+YwSb+ffYQdxmAVuMUps
        ar8HNolTwFqi79pZJhBbWMBLYsG0LhYQm0VAVWLqyrdgNbwClhIfp71lg7AFJU7OfAJWwywg
        L7H97RxmiIsUJH4+XcYKYosIWEl8un+ICaJGRGJ2ZxszyGIJgSscEu9nPYFqcJH4PeUClC0s
        8er4FqjXpCQ+v9vLBtHQzShx+OU7Vginh1Fi8+JTrBBVxhKfPn9mBPmTWUBTYv0ufYiwosTO
        33MZITbzSbz72sMKCWFeiY42IYgSZYmXj5YxQdiSEkvabzFPYFSaheS3WUh+m4Xkh1kIyxYw
        sqxiFEstKM5NTy02LDBFju5NjOC0rGW5g3H62w96hxiZOBgPMUpwMCuJ8G7+Z5ogxJuSWFmV
        WpQfX1Sak1p8iNEUGNoTmaVEk/OBmSGvJN7Q1MjY2NjCxMzczNRYSZw3yeBBvJBAemJJanZq
        akFqEUwfEwenVAMTc93Vz8LPrkZWtuzfGb21f4J6qfvGfvPexK1i85K555w97NKWIKsl9JZ3
        5lV2xhXLU5S9u13fy8i35a6/vP9uwEHeZhZt9qfCty+3yL99YnOW71N+0d4pXXtDeP+5nTSS
        iHK+VqMu3nVd0urjNDeJLZX5O/9Ovj859/Edt6lfzK2n3ea1Ffr7mP3WnUnTQhrqXmzsuWNz
        9P7SpSdK/NodnHRPM689dI0hKyA01MNTxP/caea480mxDixyjloi6TI9K9VE3HimtQu/n+84
        UXbW4ZO75uY48q97ZvDnS5eYluuSrknhvzuMOMP8+XSO1dSsTfLaIcErUNcd/lsinluBh3mN
        SMyp2T1+Cy2v/FNiKc5INNRiLipOBACjSL/WVAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWy7bCSvK6gv3mCwcYWLosZp9pYLfZdO8lu
        8evvenaLPbPvMlt0bJ3MZLHj+Rl2i11/m5ksLu+aw2Zx5H8/o8WCPafZLK6dOcFqsfr1PnaL
        42vDLTZf+sbiwOfxeO5Gdo9NqzrZPO5c28Pm0bdlFaPH501yHlvXLGYOYIvisklJzcksSy3S
        t0vgyljccJep4KVgxeupH5kbGA/zdTFyckgImEg8/nuBCcQWEtjBKHG2jx0iLimx+NFDti5G
        DiBbWOLw4WKIkmeMEtueMIKE2QTMJJ7fCQIJiwgsZZTo2hraxcjFwSzwiFHi96IZLCCOkEAP
        o8T8T3sZQao4Bawl+q6dBdslLOAlsWBaFwuIzSKgKjF15VuwvbwClhIfp71lg7AFJU7OfAJW
        wyygLfH05lMoW15i+9s5zBB3Kkj8fLqMFeIKK4lP9w8xQdSISMzubGOewCg8C8moWUhGzUIy
        ahaSlgWMLKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIjU0trB+OeVR/0DjEycTAe
        YpTgYFYS4d38zzRBiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkm
        Dk6pBqbYedmOKm8/L5X12n7spcGrBXOWfFyav7BGLDV5OePLnFml+/cGGuvlTZwmf0nxVeXe
        r3o35jxcuefT5NnrPzOwH7QM2m7Q4yVzYIvj011cQldLRNyVpldWy4lNnL69MiZl0seNh60X
        CYSwf3J/cmjVttMha0TtGzfvrOd/d/LE4yM7K//eWb999779T2bElX2dvN0jLXnaH+b36utu
        xpk9qJMyf3R+xqt/nTomPx8XBwaFPU96MbFI+fzcFXcOHpvNp3zmQ3yOhaPUNeXD39Wscgsr
        lz7X1WF87hX5KaYmPbeNRVd218uel9dVd+7kZvq3eulvpQvRQrwFLjxPxbo+Xel7YH4lIOj9
        CXG5nAbXOUosxRmJhlrMRcWJAC0DaGw7AwAA
X-CMS-MailID: 20210225071737epcas1p3c94d78490b86a86a21840a3105316ed7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210222081517epcas1p37fef998684dc9eae0bcd2764a3f82fb1
References: <CGME20210222081517epcas1p37fef998684dc9eae0bcd2764a3f82fb1@epcas1p3.samsung.com>
        <20210222083156.19158-1-sh043.lee@samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dear Maintainer & commiters,

Please review the patch for updating.
I'm not sure if it's reviewed or not.

As you know, there are lots of defect SD cards in the market.
It's one of solution that reduces the system load.
The CSD register shows that it's permanent write protected
due to lifespan or internal problem.

Once host sets read only field, the upper layer doesn't issue
unnecessary write operation in it.

Thanks and regards,
Seunghui Lee.

> -----Original Message-----
> From: Seunghui Lee <sh043.lee@samsung.com>
> Sent: Monday, February 22, 2021 5:32 PM
> To: ulf.hansson@linaro.org; pali@kernel.org; huyue2@yulong.com;
> tiantao6@hisilicon.com; linux-mmc@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Cc: grant.jung@samsung.com; jt77.jang@samsung.com;
> dh0421.hwang@samsung.com; junwoo80.lee@samsung.com; jangsub.yi@samsung.com;
> cw9316.lee@samsung.com; sh8267.baek@samsung.com; wkon.kim@samsung.com;
> Seunghui Lee <sh043.lee@samsung.com>
> Subject: [PATCH] mmc: core: set read only with permanent write protect
> 
> Some of SD cards sets permanent write protection due to lifespan or
> internal problem.
> Host can find out it's protected permanantly during initialization.
> Once set read only during initialization, it could prevent unnecessary
> write operation in it.
> 
> Signed-off-by: Seunghui Lee <sh043.lee@samsung.com>
> ---
>  drivers/mmc/core/sd.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> 6fa51a6ed058..2c48d6504101 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -135,6 +135,9 @@ static int mmc_decode_csd(struct mmc_card *card)
>  			csd->erase_size = UNSTUFF_BITS(resp, 39, 7) + 1;
>  			csd->erase_size <<= csd->write_blkbits - 9;
>  		}
> +
> +		if (UNSTUFF_BITS(resp, 13, 1))
> +			mmc_card_set_readonly(card);
>  		break;
>  	case 1:
>  		/*
> @@ -169,6 +172,9 @@ static int mmc_decode_csd(struct mmc_card *card)
>  		csd->write_blkbits = 9;
>  		csd->write_partial = 0;
>  		csd->erase_size = 1;
> +
> +		if (UNSTUFF_BITS(resp, 13, 1))
> +			mmc_card_set_readonly(card);
>  		break;
>  	default:
>  		pr_err("%s: unrecognised CSD structure version %d\n",
> --
> 2.29.0


