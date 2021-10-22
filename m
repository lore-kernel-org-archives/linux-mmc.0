Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F47C433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 11:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CF1610A4
	for <linux-mmc@archiver.kernel.org>; Fri, 22 Oct 2021 11:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbhJVLiA (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 Oct 2021 07:38:00 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59875 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbhJVLiA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Oct 2021 07:38:00 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20211022113541euoutp0126d4356197b4d8fac6ff1de0bcadce1a~wVzMZON7Z0199501995euoutp01g
        for <linux-mmc@vger.kernel.org>; Fri, 22 Oct 2021 11:35:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20211022113541euoutp0126d4356197b4d8fac6ff1de0bcadce1a~wVzMZON7Z0199501995euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1634902541;
        bh=cNBu1itC6Uv1IW5llRzcAE9MH5mk4vAB5Z6oRWkvcPU=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=MWbcJjRVDNBX7BtzprHCCtur4L9OugNuFg41o2WMVII9tpBWRcQA0GrXPCQWsGigR
         h8I17R+35HoSHV7HfgdwQn7BWDV8Vyl8Nhm494i02uH+tTTv1WJrvuGTohzsS1ZGmO
         DoPEpIZ8E4cI4DUYKD/dWkWxBtQu9QXA7kX9lAPo=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20211022113541eucas1p1b78959142a702f2020c7fd5f38ebffd1~wVzMNpExx0747307473eucas1p1B;
        Fri, 22 Oct 2021 11:35:41 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 90.F4.45756.D02A2716; Fri, 22
        Oct 2021 12:35:41 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20211022113540eucas1p2f877fb4f60ddfca84f49cc9620af681b~wVzLoN_e40528005280eucas1p2B;
        Fri, 22 Oct 2021 11:35:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20211022113540eusmtrp2948f01aaf12837364618ea8d2560c6c8~wVzLniFbc1969919699eusmtrp2Z;
        Fri, 22 Oct 2021 11:35:40 +0000 (GMT)
X-AuditID: cbfec7f2-7bdff7000002b2bc-32-6172a20dcec5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 64.5A.31287.C02A2716; Fri, 22
        Oct 2021 12:35:40 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20211022113540eusmtip23b29acf6f0a527572367aa7daaec7734~wVzLJ8MgZ1124211242eusmtip2r;
        Fri, 22 Oct 2021 11:35:40 +0000 (GMT)
Message-ID: <9792ea4f-2696-484d-a5d7-04da270684cd@samsung.com>
Date:   Fri, 22 Oct 2021 13:35:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.2.0
Subject: Re: [PATCH V2] mmc: dw_mmc: exynos: fix the finding clock sample
 value
Content-Language: en-US
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        krzysztof.kozlowski@canonical.com,
        Marian Mihailescu <mihailescu2m@gmail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <8DD814C1-8534-4762-BD41-DE941C16DC92@gmail.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se1BMcRj123vv7m3ZXLfUNzTUGoyM0tSwo61hiPUaGa8ZmcnN3llGz91S
        +YO0I2aH0LtFeYyWktgphDEstTU1UR6lbERejW1sJbZs6e716L/zne+cOd/5zY/E6AJiGrkn
        NpFVxzLRUqEYv1lrf7JAckHNLLxX5ibrac/GZG1DGYTshvWnQPZ49ASSVeTZCZm5fNtSoUKf
        dlyoqNZbRIrXL+8JFZmVpUjRb5wRTmwXy5Vs9J59rNo/dKd498grIn7QNaXzxzuUhuwTdciF
        BCoIdO3FSIfEJE1dRmCpqcP4YQCBttmBcSqa6kdw0hj611GVm/fHYUBQmP1ZxA82BDnDw06H
        hAoFhzlLxGGcmg0lozqC56dAfWE3zuGpVBQUn37r1LhRG6GkJMeJMcoT2ruLBRx2pyLA/LEI
        5wIwKg9B1cX3zoWQCgCdVSfksAsVAoZmrYA3z4Rb1jPODkA9J2H0/QWMv3sFNNobcB67QY+5
        UsRjLxit5tI4gxZBV1O5iB+OIXiWXoB4VTC8bhoaiyPHIuZBxR1/nl4GBouD4GigXKHNOoU/
        whWybuZjPC2Boxk0r54DevO1f7EPn7ZgJ5FUP+5d9OP668fV0f/PPYfwUuTJJmliVKwmIJZN
        9tMwMZqkWJXfrrgYIxr7PA0j5r7b6GyPzc+EBCQyISAxqbvkbkocQ0uUTOp+Vh0XqU6KZjUm
        NJ3EpZ6S0tNXI2lKxSSye1k2nlX/3QpIl2lpgvN7fcNmjVgCpocne72Kf3NcafBOrVfl4tcG
        X7xpru64HmE4sM5KR9kPl6sC05tKFMln66psHQ8Jj6j1dfNxR5GsrN2S/iVk/Sa5d9Fqscvw
        gf6vax71FnyRZyk/TV1yyVjb8lldMPnBoqUZR64kHLHOTs3JDJq00NGVSw90eBh3EveHl3vu
        WLxyUB4YFjG3L/J20TbLt/peW2t+Z26I9+YPlWUTti45kfk9qM3AVNT4DKQVvhwKNSWo1pK/
        jGG931b9MLXSW6yHTikndlYJfI0tFRNmZidoaZUPe3TfZK+aPsLdvVh+sCfc1vhI27KI9TGe
        uxHsPSlFusEtcLG2OjzrkhTX7GYCfDG1hvkNcHWElqsDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNIsWRmVeSWpSXmKPExsVy+t/xe7o8i4oSDTZ261q8ujWZ2eLGrzZW
        i41vfzBZHPnfz2ixftpPVovja8Md2DxmNfSyeeycdZfd4861PWwefVtWMXp83iQXwBqlZ1OU
        X1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl/HvJmvBN76K
        e98fMTYw/uTuYuTkkBAwkdg6dRpjFyMXh5DAUkaJy7dbWSASMhInpzWwQtjCEn+udbFBFL1n
        lPi1bRJYEa+AncTf45PYQWwWAVWJZf+7WCHighInZz4BqxEVSJL4uGEGM4gtLBAosWzZFLB6
        ZgFxiVtP5jOB2CIC0RL3j/1iB1nALDCFUeL33bNQJx1klJj4qgmsik3AUKLrLcgZnBycArYS
        yy82M0FMMpPo2trFCGHLS2x/O4d5AqPQLCSHzEKycBaSlllIWhYwsqxiFEktLc5Nzy021CtO
        zC0uzUvXS87P3cQIjLVtx35u3sE479VHvUOMTByMhxglOJiVRHh3V+QnCvGmJFZWpRblxxeV
        5qQWH2I0BYbGRGYp0eR8YLTnlcQbmhmYGpqYWRqYWpoZK4nzbp27Jl5IID2xJDU7NbUgtQim
        j4mDU6qBqUwvSH1BHXO6/pWGvOnveY/yz1fuu7H5eLr2poznC+1vP0ud+emizl6XlI0L6iK3
        Ok7+GPn4sbuVh4iI0wORQwlR1xYszy1We2X65MRp66krzkd7Fu14V35gssKxkF06O27xXzls
        x7hJkPXJB1fhKl6d7VqVkY2zpZeaC9Ql6k/6cX1mmPcZY1a+liB7Q8nkY09q/tmtk1pXbBQf
        n1/3OmdT0JRK5+uL2T5frDdZtGnr/gOPu8J5BZKCC+5/LA+bO1PL3fm6jbfTPvbz/stFbby+
        p0eeX+C1beqapQ0cHD915GL786vUVUwcu83uezRsXeKwaq3OkrvOy3a4C9yKm9p2JDdUd8bO
        daxKji/UlFiKMxINtZiLihMBYl7bUT4DAAA=
X-CMS-MailID: 20211022113540eucas1p2f877fb4f60ddfca84f49cc9620af681b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20211022082025epcas1p3a4f5908ec149414ff985d7d3ec414910
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20211022082025epcas1p3a4f5908ec149414ff985d7d3ec414910
References: <CGME20211022082025epcas1p3a4f5908ec149414ff985d7d3ec414910@epcas1p3.samsung.com>
        <20211022082106.1557-1-jh80.chung@samsung.com>
        <8DD814C1-8534-4762-BD41-DE941C16DC92@gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 22.10.2021 12:53, Christian Hewitt wrote:
>> On 22 Oct 2021, at 12:21 pm, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>>
>> Even though there are candiates value if can't find best value, it's
>> returned -EIO. It's not proper behavior.
>> If there is not best value, use a first candiate value to work eMMC.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Christian Hewitt <christianshewitt@gmail.com>
>
> v2 patch working fine with the module that triggered the original report:
>
> [    2.902144] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
> [    2.912118] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 400000Hz, actual 396825HZ div = 63)
> [    3.142474] mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot req 200000000Hz, actual 200000000HZ div = 0)
> [    3.239339] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
> [    3.241388] mmc_host mmc0: Bus speed (slot 0) = 266666666Hz (slot req 200000000Hz, actual 133333333HZ div = 1)

I wonder why 266666666Hz bus speed is selected instead of the 
400000000Hz one. Did you remove the workaround patch which changed the 
divider value from your kernel tree? I didn't analyze the code, so maybe 
this change is intentional result of this patch? On my XU4 I get 
400000000Hz bus clock for the eMMC dw-mmc controller.

> [    3.243310] mmc0: new HS400 MMC card at address 0001
> [    3.259191] mmcblk0: mmc0:0001 8GME4R 7.28 GiB
> [    3.302621]  mmcblk0: p1 p2
> [    3.311541] mmcblk0boot0: mmc0:0001 8GME4R 4.00 MiB
> [    3.327737] mmcblk0boot1: mmc0:0001 8GME4R 4.00 MiB
> [    3.340919] mmcblk0rpmb: mmc0:0001 8GME4R 512 KiB, chardev (246:0)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

