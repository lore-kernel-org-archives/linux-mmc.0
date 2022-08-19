Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943A4C00140
	for <linux-mmc@archiver.kernel.org>; Fri, 19 Aug 2022 00:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiHSA0U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Aug 2022 20:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiHSA0S (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Aug 2022 20:26:18 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF88883E7
        for <linux-mmc@vger.kernel.org>; Thu, 18 Aug 2022 17:26:09 -0700 (PDT)
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220819002603epoutp014b1d831ce04fe908e1caa95a23ff1fb3~Ml1dOLmB51463614636epoutp01c
        for <linux-mmc@vger.kernel.org>; Fri, 19 Aug 2022 00:26:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220819002603epoutp014b1d831ce04fe908e1caa95a23ff1fb3~Ml1dOLmB51463614636epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1660868763;
        bh=WrLe3VfsTx4ms5Ls+VKqLaFQJKQ0dz+oy4tZxRGwVXY=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=mnTZ3iJiHvgefSCIDKl4UJUJHz+RlZRh0zZb3W18EkiAygegxVk7QWsK3iz9ggEvW
         XFmFpGKseCrTkVLm7dOj+W61N+7ESR+0oIzVlA8ajI4UNcLXx8lij9s4I6iUqTS4Oz
         2P9cqDKIrsjywcsJhvVfsQHDb9Qb/THWfRL2Ld9k=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220819002603epcas1p1e3756730fc27297194ae9257d174fa6e~Ml1cv5vAo1268312683epcas1p1W;
        Fri, 19 Aug 2022 00:26:03 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.38.241]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4M82bt70nRz4x9Pr; Fri, 19 Aug
        2022 00:26:02 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        0A.6C.09657.A98DEF26; Fri, 19 Aug 2022 09:26:02 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220819002602epcas1p24acd8cd23ff7dd6fdca72bff79a599ea~Ml1cGXdDI3270732707epcas1p25;
        Fri, 19 Aug 2022 00:26:02 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220819002602epsmtrp15f5fbe68ab39ec30a0aa26cc0336ae3d~Ml1cFqUE60182901829epsmtrp16;
        Fri, 19 Aug 2022 00:26:02 +0000 (GMT)
X-AuditID: b6c32a35-f4312a80000025b9-73-62fed89a43a7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        FD.A2.08802.A98DEF26; Fri, 19 Aug 2022 09:26:02 +0900 (KST)
Received: from sh043lee03 (unknown [10.246.21.142]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220819002602epsmtip269cd8f0ca1bdeaf3ca581be36f6501e3~Ml1b6Jth_1540115401epsmtip2G;
        Fri, 19 Aug 2022 00:26:02 +0000 (GMT)
From:   "Seunghui Lee" <sh043.lee@samsung.com>
To:     "'Adrian Hunter'" <adrian.hunter@intel.com>,
        "'Ulf Hansson'" <ulf.hansson@linaro.org>
Cc:     "'linux-mmc'" <linux-mmc@vger.kernel.org>,
        "'DooHyun Hwang'" <dh0421.hwang@samsung.com>
In-Reply-To: <20220815073321.63382-2-adrian.hunter@intel.com>
Subject: RE: [PATCH 1/2] mmc: sd: Fix 1.8V workaround branch
Date:   Fri, 19 Aug 2022 09:26:02 +0900
Message-ID: <029901d8b362$4348c8c0$c9da5a40$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQNereAG552E3uwc9Rd5zVn2k6GeiwJ2q2IeAi3GyVeqhETyAA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTT3fWjX9JBq8uWFqcfLKGzWLftZPs
        Fkf+9zNaHF8b7sDisXjPSyaPO9f2sHn0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+SmZeuq2S
        d3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QRiWFssScUqBQQGJxsZK+nU1RfmlJqkJG
        fnGJrVJqQUpOgVmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdsbER0oFn/gqTvxOb2B8yN3FyMEh
        IWAiseVzZhcjF4eQwA5Gienf1rNBOJ8YJZ7OPMkO4XxmlHh35ShLFyMnWMfNjllQiV2MEsse
        bGKBcF4A9X++zwxSxSagI/Hm039WEFtEIFpi/6o5zCD7mAViJT6+FAQJcwrYSuyd8ooRxBYW
        sJHo+z0ZrJVFQFVi/rc/YDavgKVE/79TULagxMmZT8COYBYwkliyej4ThC0vsf3tHGaI4xQk
        fj5dxgqySkTASWLqOSmIEhGJ2Z1tzCBnSgh8ZJdofd4BVe8icW/DSqjHhCVeHd/CDmFLSbzs
        b4OyiyXa/v2Dqq+QONj3Bco2lvj0+TMjhK0osfP3XEaIZXwS7772sEKCl1eio00IokRZ4uWj
        ZUwQtqTEkvZbzBMYlWYh+WwWks9mIflsFpIXFjCyrGIUSy0ozk1PLTYsMIRHdXJ+7iZGcFLU
        Mt3BOPHtB71DjEwcjIcYJTiYlUR4b9z5kyTEm5JYWZValB9fVJqTWnyI0RQY2BOZpUST84Fp
        Oa8k3tDE0sDEzMjEwtjS2ExJnHfVtNOJQgLpiSWp2ampBalFMH1MHJxSDUxSpQyOulmrvzvP
        Way0hr0wcJ1R+pbky4e12mYs3RenqvtTvF52d8MD023znlw7+v11Q8WW44talbhzpwYF+hre
        51aYyMj+OVP7yjr72c3WPlYH7z7inHxyxn/7I/N/3POLNz1eZvU3XGflqU9RD/9ypvv9P1a8
        XbAu0YSj8eCca+zvlkeeibn+O7jzW+wTO8N7LW3hFneucXGwatXv/rJ5whPP6bdfc4Yv/ebd
        uNv6p0rLojmXojf61gg9+KwpoPB6y+nq2aZu2j/vP9sZaXxo5QqRq5luzu0vBNpTrETZb8+Z
        +Cve6Gucj9jxR0xhU++KTn6U8Yjjy/okfQcn/7f+RWbCD9yUsv0nNJ9ytmtRYinOSDTUYi4q
        TgQA8j1NDBMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvO6sG/+SDBbPV7Q4+WQNm8W+ayfZ
        LY7872e0OL423IHFY/Gel0wed67tYfPo27KK0ePzJrkAligum5TUnMyy1CJ9uwSujImPlAo+
        8VWc+J3ewPiQu4uRk0NCwETiZscs9i5GLg4hgR2MEpv2zWKDSEhKLH70EMjmALKFJQ4fLoao
        ecYoMWnaNlaQGjYBHYk3n/6D2SIC0RIHz84Hs5kFYiXeXzzPCNGwn1FiTs8sZpAEp4CtxN4p
        rxhBbGEBG4m+35PB4iwCqhLzv/0Bs3kFLCX6/52CsgUlTs58wgIx1ESi8XA3lC0vsf3tHGaI
        QxUkfj5dxgpyqIiAk8TUc1IQJSISszvbmCcwCs9CMmkWkkmzkEyahaRlASPLKkbJ1ILi3PTc
        YsMCo7zUcr3ixNzi0rx0veT83E2M4PjQ0trBuGfVB71DjEwcjIcYJTiYlUR4b9z5kyTEm5JY
        WZValB9fVJqTWnyIUZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD0xKBLu2tLR+WTQkJ
        uj5vE6OTSerzKLUsjsv5Swxe9eeKBx87aRV6aPXufRUVK+ufOuclzGZduOS76dK0WXeiN5cE
        1Oizvg66XeiygenPp78/tJ08xer8b9v1X+nO+sOSeyc2OY3J2PFki0IAE2tBk7zZdNkuxW2P
        hRokHNPeX/luEOk4RWhK1cv/T1z3JhxJK0k+96Q+58o02b23ljdbhMvuar1xoXOiUSbTMvMT
        vHe99sUWzDs+52bwogaZN2cvhITNnc/+btbOrgmvr05yW/b2MeuLW0e/61/5eFI6NK9hdc2m
        1M1vf9ko7zLp9yudJ318ST3XJckqy52+Kgv2qcx40tTxcGbq5DmGWSk5H5RYijMSDbWYi4oT
        ARy5N/P+AgAA
X-CMS-MailID: 20220819002602epcas1p24acd8cd23ff7dd6fdca72bff79a599ea
X-Msg-Generator: CA
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220815073348epcas1p3ae87eaa4a2885ff2bbb01b5fd3ec52a7
References: <20220815073321.63382-1-adrian.hunter@intel.com>
        <CGME20220815073348epcas1p3ae87eaa4a2885ff2bbb01b5fd3ec52a7@epcas1p3.samsung.com>
        <20220815073321.63382-2-adrian.hunter@intel.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: Adrian Hunter <adrian.hunter@intel.com>
> Sent: Monday, August 15, 2022 4:33 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc <linux-mmc@vger.kernel.org>; Seunghui Lee
> <sh043.lee@samsung.com>; DooHyun Hwang <dh0421.hwang@samsung.com>
> Subject: [PATCH 1/2] mmc: sd: Fix 1.8V workaround branch
> 
> When introduced, upon success, the 1.8V fixup workaround in
> mmc_sd_init_card() would branch to practically the end of the function, to
> a label named "done". Unfortunately, perhaps due to the label name, over
> time new code has been added that really should have come after "done" not
> before it. Move the label to the correct place and rename it "cont".
> 
> Fixes: 045d705dc1fb ("mmc: core: Enable the MMC host software queue for
> the SD card")
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/core/sd.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
> cee4c0b59f43..bc84d7dfc8e1 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -1498,7 +1498,7 @@ static int mmc_sd_init_card(struct mmc_host *host,
> u32 ocr,
>  					mmc_remove_card(card);
>  				goto retry;
>  			}
> -			goto done;
> +			goto cont;
>  		}
>  	}
> 
> @@ -1534,7 +1534,7 @@ static int mmc_sd_init_card(struct mmc_host *host,
> u32 ocr,
>  			mmc_set_bus_width(host, MMC_BUS_WIDTH_4);
>  		}
>  	}
> -
> +cont:
>  	if (!oldcard) {
>  		/* Read/parse the extension registers. */
>  		err = sd_read_ext_regs(card);
> @@ -1566,7 +1566,7 @@ static int mmc_sd_init_card(struct mmc_host *host,
> u32 ocr,
>  		err = -EINVAL;
>  		goto free_card;
>  	}
> -done:
> +
>  	host->card = card;
>  	return 0;
> 
> --
> 2.25.1

Looks good to me.
Reviewed-by: Seunghui Lee <sh043.lee@samsung.com>

