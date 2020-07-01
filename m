Return-Path: <SRS0=joLi=AM=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C5DC433DF
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 10:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5090206CB
	for <linux-mmc@archiver.kernel.org>; Wed,  1 Jul 2020 10:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="aEWV5zfe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgGAK5k (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:57:40 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:56245 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729908AbgGAK53 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Jul 2020 06:57:29 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200701105728euoutp0169d6cc06281ef9a0ef1d3e5e4d121ad6~dm7XRPOg_2367123671euoutp01e
        for <linux-mmc@vger.kernel.org>; Wed,  1 Jul 2020 10:57:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200701105728euoutp0169d6cc06281ef9a0ef1d3e5e4d121ad6~dm7XRPOg_2367123671euoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1593601048;
        bh=icvmKZlOU5pUcij0b272NhBKag+tDSBjCIMXA7qt81Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aEWV5zfedTA9v9I93VgF0IUtC6bPAfSVTRxf50A3bVkDvUSpw1jZYZd6D18LvYIY3
         nEDgYJnRVrriup6lJUxNvhJxuf7c8ezH0kihLszrrWzaIBc2iDNlSH3VgfeN7nJlUr
         x0U5MqCOj9JDoAL/8VY2+FThcdSZFFme/htqM9YY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200701105728eucas1p1f9997ea064dfbc262731bd60596b8f2b~dm7W9gkpR0832308323eucas1p1f;
        Wed,  1 Jul 2020 10:57:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C8.14.05997.71C6CFE5; Wed,  1
        Jul 2020 11:57:27 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200701105727eucas1p1aef1f9b683ea10e1aaee65e43969af82~dm7WnKQtg2957329573eucas1p1I;
        Wed,  1 Jul 2020 10:57:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200701105727eusmtrp2c0f4c97603f5d20e9dd58bf67dc9acc1~dm7Wme7K60954909549eusmtrp2o;
        Wed,  1 Jul 2020 10:57:27 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-7f-5efc6c175183
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id AF.95.06314.71C6CFE5; Wed,  1
        Jul 2020 11:57:27 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200701105727eusmtip15b72dd43a3f99cf35a1891d34900e0ff~dm7WGOeZj0072300723eusmtip1i;
        Wed,  1 Jul 2020 10:57:27 +0000 (GMT)
Subject: Re: [PATCH] mmc: host: dereference null return value
To:     haibo.chen@nxp.com, adrian.hunter@intel.com,
        ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        jh80.chung@samsung.com, kgene@kernel.org, krzk@kernel.org,
        michal.simek@xilinx.com, linux-samsung-soc@vger.kernel.org
Cc:     linux-imx@nxp.com
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <78c6f493-eb0f-d451-22db-aa1836b33018@samsung.com>
Date:   Wed, 1 Jul 2020 12:57:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592885209-25839-1-git-send-email-haibo.chen@nxp.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0hTYRju2zk7Ow4nxznZi5rBCikp79SB1K7E/GUQZUjTVh5UnFM2rwUh
        SV6WOrEf2rpoE0mnVopT81aaOLxOjERiQaFZGlvCDHJq5jyz/Pc8z/u83/M+8JGY8B3Xh0xV
        ZjEqpVwhIfh458ia+ZhYsZEQUjoaSY8utBC09kMTouccRVxaO/8Do83mVzxa42jC6OEtLaJr
        zAMc2rZ0lTa1xp3mS+v7ljjSdkMpIbXM9hHSNls3R1rRYUBSe7u/tN++jl/kxfMjkxhFag6j
        Co6+zk8xdv3CMzeIPM1EFSpAg1wNciOBioAti4OnQXxSSDUi6H3UjbFkFYF+Us9liR1BS+9b
        3u7K2Piqa+U5gvnmTRf5iaCtcBlzuryoKFiw1++si6hPCBaNNsI5wChvKLcUc5yYoEJBY9Xs
        6AIqGkqsWtyJceoQ1E7U7MR5UzKoaKhzeTxh9OHCjseNOgdltmdc9s0D0GV9jLFYDB8Xajns
        qTM8aO4/zOLzUDvZ76rgBcumDhf2g63XTj9/Gxci+DLVymNJGYL3d2sQ6zoJlinH9hXkdsIR
        eNkTzMpn4MlyNe6UgfKAOasne4MHVHVWY6wsgJIiIesOAJ3pxb/YwekZrBJJdHua6fa00e1p
        o/ufW4dwAxIz2er0ZEYdpmRyg9TydHW2MjnoZkZ6O9r+WuN/TKvdqGfjxhCiSCRxF5TsX08Q
        cuU56vz0IQQkJhEJzk6OJwgFSfL8W4wqI1GVrWDUQ8iXxCViQbh+SSakkuVZTBrDZDKq3SmH
        dPMpQEGNmwMxQ2OW5W9wNN5qzF+8ZCQmW1Y6YvXlUTqPExbN97x7n/etHww3uYfwj1/Ta55e
        sf0OGU+8LQwIMz0QTcw6siLWRobro/0RXDCeosZyU6Zld9LiDH2jW8WplYG11QGiYh/dfV9F
        31d6xY8wyUq0880XlW8aYi8PGmLCJLg6RR4aiKnU8r/j7tnZVgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsVy+t/xu7riOX/iDPa1q1mcfLKGzaL/6kpG
        ixu/2lgt+h+/ZrY4f34Du0XXr5XMFkf+9zNazDi/j8ni3csIi+Nrwx24PBbvecnksWlVJ5vH
        nWt72Dw2vtvB5NG3ZRWjx+dNch57P/9mCWCP0rMpyi8tSVXIyC8usVWKNrQw0jO0tNAzMrHU
        MzQ2j7UyMlXSt7NJSc3JLEst0rdL0MvYuv0rS8EftoquM5MYGxgPsnYxcnJICJhInDr9hb2L
        kYtDSGApo0Tv2qlQCRmJk9MaoGxhiT/Xutggit4ySpyY/IcZJCEsYCvx5PNiVpCEiMBdRonJ
        9x4zgSSYBUQleu+0M0F0TGOUeDJxFyNIgk3AUKLrLcgoTg5eATuJjrf9LCA2i4CKxPwzM9hB
        bFGBWIlv97ZA1QhKnJz5BKyGU8BZoufdQlaIBWYS8zY/ZIaw5SW2v50DZYtL3Hoyn2kCo9As
        JO2zkLTMQtIyC0nLAkaWVYwiqaXFuem5xYZ6xYm5xaV56XrJ+bmbGIFxuu3Yz807GC9tDD7E
        KMDBqMTD2yH7O06INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWlOanFhxhNgZ6byCwl
        mpwPTCF5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6mDg4pRoYnSe51Av0
        KkwTWGHk4yO94Vy2b97FZNO66atlGndNW1u2f7KOy1t9g+oZd/boJu0SfrMq6snf3cwHlPLN
        Eo40pLpJJKieCQrsfCn5rvBu/Z59bfaPVky4Yj7rSMjqZXePyfDP36wbdpv9WwxnULPPQjuz
        LFFpA5/3be1XTFQWsXCsV5xZ1fxfiaU4I9FQi7moOBEAcAutBukCAAA=
X-CMS-MailID: 20200701105727eucas1p1aef1f9b683ea10e1aaee65e43969af82
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200623041836eucas1p2792e1fe062f8dd59af0ec18b8af1c1ef
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200623041836eucas1p2792e1fe062f8dd59af0ec18b8af1c1ef
References: <CGME20200623041836eucas1p2792e1fe062f8dd59af0ec18b8af1c1ef@eucas1p2.samsung.com>
        <1592885209-25839-1-git-send-email-haibo.chen@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 23.06.2020 06:06, haibo.chen@nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
>
> of_match_node() has the opportunity to return NULL, so need to
> dereference null return value.
> This is reported by Coverity.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

There is no point in such check for a NULL. The driver won't be 
instantiated/probed if there is no matching node found first by the 
upper level framework. If you really want to make this code cleaner, 
please change it to use of_device_get_match_data().

> ---
>   drivers/mmc/host/dw_mmc-exynos.c   | 5 +++--
>   drivers/mmc/host/dw_mmc-k3.c       | 5 +++--
>   drivers/mmc/host/dw_mmc-pltfm.c    | 3 ++-
>   drivers/mmc/host/sdhci-of-arasan.c | 2 ++
>   4 files changed, 10 insertions(+), 5 deletions(-)

 > ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

