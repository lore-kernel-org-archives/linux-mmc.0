Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95345C47E48
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jul 2021 21:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B70761358
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jul 2021 21:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbhGNVuI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Jul 2021 17:50:08 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:59728 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbhGNVuI (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jul 2021 17:50:08 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210714214714epoutp030bf6e3158cc1fe474b98098501d40afa~Rxomnkceg1198511985epoutp03E
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jul 2021 21:47:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210714214714epoutp030bf6e3158cc1fe474b98098501d40afa~Rxomnkceg1198511985epoutp03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626299235;
        bh=KJObnHtkeSAESc96eky/w3oBFrc7DK+2xxwelaEivVc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=doqkHOxz536dJGyiJ1hiYwF8yq97+ZTGcoaqsrxg16ZC2sjHItIsZsF/6aqlIeqSP
         ZoPsqkFHo6rqpURhVrXGXxJKyZzRH7mCs6NJKv+DKf8W+FvXFBbGmo4iW+stvQ57UP
         W+oJzUuMLwrUYezTYOGP9HTL/N4HTjTo4OdNx5xs=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210714214714epcas1p35942ec8d6f502380c33127c219e021b7~RxomCnYZu1552915529epcas1p3w;
        Wed, 14 Jul 2021 21:47:14 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GQB1D1pSsz4x9Pr; Wed, 14 Jul
        2021 21:47:12 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.3C.10119.06B5FE06; Thu, 15 Jul 2021 06:47:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210714214711epcas1p10fa8cb60947338ae4a56f10f44ee709f~RxojvbhSX2183421834epcas1p1D;
        Wed, 14 Jul 2021 21:47:11 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210714214711epsmtrp1b461ec9fc390980faf0f9f99c7471903~RxojuwQDD3022630226epsmtrp17;
        Wed, 14 Jul 2021 21:47:11 +0000 (GMT)
X-AuditID: b6c32a38-965ff70000002787-2a-60ef5b60bfcd
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.22.08289.F5B5FE06; Thu, 15 Jul 2021 06:47:11 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210714214711epsmtip102ca87ea37b9433ee7d639cb792d9a87~RxojMaQLI0599205992epsmtip1H;
        Wed, 14 Jul 2021 21:47:11 +0000 (GMT)
Subject: Re: [PATCH] mmc: dw_mmc: Fix hang on data CRC error
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <4e24a4ce-9991-48c4-3192-78016f6cb217@samsung.com>
Date:   Thu, 15 Jul 2021 06:48:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714114921.GA22706@axis.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkk+LIzCtJLcpLzFFi42LZdlhTVzch+n2CwYkV3BafWlQtLu+aw2Zx
        5H8/o8XxteEW57f5O7B6XF8X4HHn2h42j8+b5AKYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od
        403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0ts
        lVILUnIKLAv0ihNzi0vz0vWS83OtDA0MjEyBChOyM5Yt28pS0MxTcebVAaYGxu+cXYycHBIC
        JhKLF19g6WLk4hAS2MEo0bpsIzOE84lRYt+kM1DOZ0aJ05dbmWBa+u+uZYRI7GKUWDXrMyuE
        855R4knfRUaQKmEBG4mL966wgdgiQB3bJr8CK2IW2McocX5vOytIgk1AR2L7t+NAYzk4eAXs
        JB7+5AAJswioSizfO5UdxBYViJQ4v3sBC4jNKyAocXLmEzCbU0BPYunKL8wgNrOAuMStJ/OZ
        IGx5ie1v54CdLSHwll1iWU831NkuEtsOTmWBsIUlXh3fwg5hS0m87G+DsqsldjWfgWruYJS4
        ta0JqtlYYv/SyWCHMgtoSqzfpQ8RVpTY+XsuI8RiPol3X3tYQUokBHglOtqEIEpUJC69fskE
        s+ruk/+sELaHxKQlM1gmMCrOQvLaLCTvzELyziyExQsYWVYxiqUWFOempxYbFpggR/cmRnBa
        1LLYwTj37Qe9Q4xMHIyHGCU4mJVEeJcavU0Q4k1JrKxKLcqPLyrNSS0+xGgKDOyJzFKiyfnA
        xJxXEm9oamRsbGxhYmhmamioJM67k+1QgpBAemJJanZqakFqEUwfEwenVAOTXpnzi4udj1MY
        Y1iutL6zXXd+qs8FkWUGG1my5a+IROv7lPz/nvzSuZbD+1La19wXjG9eOAQ65WQUHVyg9vpp
        3Mdp7+9bP/Xflnr2hAqr9dQAIRb/I9M8szV//5tpLHh1zesdXJMkI1a77eu64D2dYatIkpyI
        4LbnEU3t9ZM1GzlW2118xhQo0VhkXtL10yd7X6rKlUf7ftSYlOgY3Q5a73v1kYTyASWDDaKP
        bZJbwv/b9Zlc8wo8mbNSMzs9eZFsuU7kI68XmmX5Hwu6e5+bG1qa9BvwL++ZY6Z17XV9iZm0
        x7KDc/r+2HOdmuRfpZOYWbXJ7Zvi9itqm5adC2e+Z+ufH9kUt1F4UYSOhRJLcUaioRZzUXEi
        AEGjbfIUBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnG589PsEg/2zdSw+tahaXN41h83i
        yP9+Rovja8Mtzm/zd2D1uL4uwOPOtT1sHp83yQUwR3HZpKTmZJalFunbJXBlLFu2laWgmafi
        zKsDTA2M3zm7GDk5JARMJPrvrmXsYuTiEBLYwSjxuO0uC0RCSuLz06lsXYwcQLawxOHDxRA1
        bxklPjXtYAWpERawkbh47wobiC0CNGjb5FesIEXMAvsYJV5s2M8C13H16xJGkCo2AR2J7d+O
        M4FM5RWwk3j4kwMkzCKgKrF871R2EFtUIFLi84JXYAt4BQQlTs58AnYQp4CexNKVX5hBbGYB
        dYk/8y5B2eISt57MZ4Kw5SW2v53DPIFRaBaS9llIWmYhaZmFpGUBI8sqRsnUguLc9NxiwwKj
        vNRyveLE3OLSvHS95PzcTYzgONDS2sG4Z9UHvUOMTByMhxglOJiVRHiXGr1NEOJNSaysSi3K
        jy8qzUktPsQozcGiJM57oetkvJBAemJJanZqakFqEUyWiYNTqoEpX2yN0C+mLdH73x+0fbJq
        qnHh0Qnm/EpPzuU1fVonnZfELeTb6OJTevZiiMw+/vmhOavilZSmvjPL2M64WO7W0VDBK8yf
        TL58fmB8SN352/eqWaei8rJiFu48vOFTdqyZeZI828bSadv61P5vcnlbrjjBoPV87cbMq3bC
        vYElXDtlGI+22kyVs71aJV7TfyjtRsPdvbYhZxr8uhmfvzo+3Vl5S0Crw0be5ys/mVYyGm/h
        WuXwdKL/j58zXopwVFVE88aE6avEvfi3UbCsZhtfzAX9NXm8TE77ecXso6W9TzlfO7MtZ13I
        zWkn3pydNNVzNXuhkfjxL1e18iVjVQ9NiJIzl2G5uty3ah2j52QlluKMREMt5qLiRADakUNl
        8gIAAA==
X-CMS-MailID: 20210714214711epcas1p10fa8cb60947338ae4a56f10f44ee709f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210630102240epcas1p33bbdffb5eb553a49badaffab756d482c
References: <CGME20210630102240epcas1p33bbdffb5eb553a49badaffab756d482c@epcas1p3.samsung.com>
        <20210630102232.16011-1-vincent.whitchurch@axis.com>
        <81c1b56d-e1be-b3fb-6b44-fc8054f1dd8b@samsung.com>
        <20210714114921.GA22706@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Vicent,

On 7/14/21 8:49 PM, Vincent Whitchurch wrote:
> On Thu, Jul 01, 2021 at 12:06:31AM +0200, Jaehoon Chung wrote:
>> On 6/30/21 7:22 PM, Vincent Whitchurch wrote:
>>> When a Data CRC interrupt is received, the driver disables the DMA, then
>>> sends the stop/abort command and then waits for Data Transfer Over.
>>>
>>> However, sometimes, when a data CRC error is received in the middle of a
>>> multi-block write transfer, the Data Transfer Over interrupt is never
>>> received, and the driver hangs and never completes the request.
>>>
>>> The driver sets the BMOD.SWR bit (SDMMC_IDMAC_SWRESET) when stopping the
>>> DMA, but according to the manual CMD.STOP_ABORT_CMD should be programmed
>>> "before assertion of SWR".  Do these operations in the recommended
>>> order.  With this change the Data Transfer Over is always received
>>> correctly in my tests.
>>
>> I will check with your patch. I didn't see any CRC error on my targets before.
> 
> Have you had a chance to check it?  You can use the fault-injection
> patch if you want to trigger aborted transfers without getting real CRC
> errors:

Sorry for too late. I did my other task. I will check yours on Today. 
Anyway, Thanks for checking this issue.

Best Regards,
Jaehoon Chung

> 
>  https://protect2.fireeye.com/v1/url?k=96c33914-c958001f-96c2b25b-002590f5b904-9a89d187f33934b7&q=1&e=308eae3a-44b8-43d7-be54-24e9b850f4ad&u=https%3A%2F%2Flore.kernel.org%2Flinux-mmc%2F20210701080534.23138-1-vincent.whitchurch%40axis.com%2F
> 

