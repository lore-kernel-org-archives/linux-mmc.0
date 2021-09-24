Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5EEC433EF
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 09:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BA461076
	for <linux-mmc@archiver.kernel.org>; Fri, 24 Sep 2021 09:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245320AbhIXJuQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 24 Sep 2021 05:50:16 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:55830 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245228AbhIXJuQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 24 Sep 2021 05:50:16 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210924094841epoutp02414d97f9f8d8220d09e7a7cdf77d9981~nuRxe_ghs1357213572epoutp02V
        for <linux-mmc@vger.kernel.org>; Fri, 24 Sep 2021 09:48:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210924094841epoutp02414d97f9f8d8220d09e7a7cdf77d9981~nuRxe_ghs1357213572epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632476921;
        bh=B2bnLzJ3QkQSj39RXkjwjFPKKjTIBr004VpCE9ddMSo=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=OAUaphmC4tBu+dA93eZgwZt8evgIT9eGJnVdwrrVH8csbuBntUuxuloSJg2R2H5/e
         AekFxlQ5j9ZtN5Q371uMqU+JLzZyYm31w1U6Q71t2M4ZagzJCvNtdqET2gSDI6hulE
         9fXWfOfEb3JyefY2i+l5MMK1uCxyryuvfgE5mhUY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210924094841epcas1p3bba8fe6d7ebb86b765cfac506cfd5d87~nuRxQCpv-3028530285epcas1p3y;
        Fri, 24 Sep 2021 09:48:41 +0000 (GMT)
Received: from epsmges1p2.samsung.com (unknown [182.195.38.236]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4HG6fp55J4z4x9Pq; Fri, 24 Sep
        2021 09:48:34 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B8.13.62447.CEE9D416; Fri, 24 Sep 2021 18:48:28 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210924094827epcas1p40de9ed3b54561778d3f6110ee6326374~nuRkuFx_A1979719797epcas1p4j;
        Fri, 24 Sep 2021 09:48:27 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210924094827epsmtrp2b2982bb09ab7fbbe50a84ce9094f0fd3~nuRktZnwQ0052700527epsmtrp29;
        Fri, 24 Sep 2021 09:48:27 +0000 (GMT)
X-AuditID: b6c32a36-3b5ff7000001f3ef-43-614d9eec2e5a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CD.49.08750.BEE9D416; Fri, 24 Sep 2021 18:48:27 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210924094827epsmtip2f4077d64f75433018b78102d6dbd977d~nuRkg5rV-2447124471epsmtip2K;
        Fri, 24 Sep 2021 09:48:27 +0000 (GMT)
Subject: Re: [PATCH] mmc: dw_mmc: avoid long timeout if register invalid
To:     =?UTF-8?Q?Christian_L=c3=b6hle?= <CLoehle@hyperstone.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc:     "marten.lindahl@axis.com" <marten.lindahl@axis.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <a8031e66-77a0-ae9b-d78d-daebc1d7dc47@samsung.com>
Date:   Fri, 24 Sep 2021 18:49:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <bf19053cf6f547bcbb364975cda84c30@hyperstone.com>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplk+LIzCtJLcpLzFFi42LZdljTQPfNPN9Eg/Pv+Sxm3/a3uLxrDpvF
        kf/9jBYTrk5mtDi+NtyB1eP6ugCPM+seMHrcubaHzePzJrkAlqhsm4zUxJTUIoXUvOT8lMy8
        dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygpUoKZYk5pUChgMTiYiV9O5ui/NKS
        VIWM/OISW6XUgpScAtMCveLE3OLSvHS9vNQSK0MDAyNToMKE7IzJiwoLWjgr2hZuYW9gnMLe
        xcjJISFgIrHl7F62LkYuDiGBHYwSS45vZYJwPjFKTJ+9ASrzmVFizpdPLDAtExcdh6raxSix
        /No5ZgjnPaPE6nUgLZwcwgIeEjvezmMFsUUEdjJKXNov1sXIwcEskCMx51s+SJhNQEdi+zeQ
        QZwcvAJ2Evf7PoDdxCKgKnHtxmawVlGBSIm/J3exQtQISpyc+QTsCE6g+nMtM8BWMQuIS9x6
        Mp8JwpaXaN46G+weCYGv7BLthw8wQlztItF5uYMZwhaWeHV8CzQApCQ+v9vLBmFXS+xqPgPV
        3MEocWtbExNEwlhi/9LJTBAPaEqs36UPEVaU2Pl7LiPEYj6Jd197WEFKJAR4JTrahCBKVCQu
        vX7JBLPq7pP/rBC2h8TDT9dZJzAqzkLy2iwk78xC8s4shMULGFlWMYqlFhTnpqcWGxYYwSM7
        OT93EyM4PWqZ7WCc9PaD3iFGJg7GQ4wSHMxKIryfb3glCvGmJFZWpRblxxeV5qQWH2I0BQb2
        RGYp0eR8YILOK4k3NLE0MDEzMjaxMDQzVBLnPfbaMlFIID2xJDU7NbUgtQimj4mDU6qBKSfA
        2vYr4/ZKsUlbp50vbnWMzO8VUFT2PzZNbffc3kvFvo/nvw2avuSw2d8pEbuaZ/zfeq5x9zOO
        zfqT4mUOXBX1re/byiXzZNYChbIjS/wlK8Ml9zo1FjbavUpvkwlRnsvV8T7kyct9bjf23Ov4
        Na3xu+T7jwv3dGTITEisN+q3c7j8xP5gQgmnzp+LT1fWzWz47bPK/mvRry1pT1NEf9rfWpid
        pFPAop3mWhqg/er5syfuNkt3sfzm/XtzYczKqD2hh1W+HfnXZj/zuF15yPO9134oXVA9vF1n
        wmsWJsOJxZlzXmVca7jK3x7QqKUl23di9uvLF57Yrls+XYVfZsfU0JkCTNGJq+xi9/ZMv6vE
        UpyRaKjFXFScCAAmEpsdGAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMLMWRmVeSWpSXmKPExsWy7bCSvO7reb6JBrtfqFnMvu1vcXnXHDaL
        I//7GS0mXJ3MaHF8bbgDq8f1dQEeZ9Y9YPS4c20Pm8fnTXIBLFFcNimpOZllqUX6dglcGZMX
        FRa0cFa0LdzC3sA4hb2LkZNDQsBEYuKi40xdjFwcQgI7GCU27p/ICJGQkvj8dCpbFyMHkC0s
        cfhwMUhYSOAto8StPlsQW1jAQ2LH23msIL0iAjsZJRYvnscMUs8skCPR8TgWYuZERonpq7ex
        gTSwCehIbP8GsoyTg1fATuJ+3wewI1gEVCWu3djMCmKLCkRKNJ3YygZRIyhxcuYTFhCbE6j+
        XMsMsDizgLrEn3mXmCFscYlbT+YzQdjyEs1bZzNPYBSahaR9FpKWWUhaZiFpWcDIsopRMrWg
        ODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIzgetLR2MO5Z9UHvECMTB+MhRgkOZiUR3s83vBKF
        eFMSK6tSi/Lji0pzUosPMUpzsCiJ817oOhkvJJCeWJKanZpakFoEk2Xi4JRqYJK/5uTuaybE
        u/DGOQmLosSDml0hwXUL3vB9urva8Eh6+ffN+5Y0aViGaxhn2X5lOnl3Lw/r6vXs/hG/17nl
        nci63iyX0y5fHPC89bMqS+OJiwLlmdNfnZTQuhtYeuWnvd0ujxUGhU3t/H0di79HLGbPelZR
        /fuyS59LstQq/5OxZS5bX7xleP/0YWXhAdMMjp0es1eypzL8qiw/MT/mh3vlNuWTeyye/rTo
        e/HefPmR5lYWOdVbmYsEJ7se104JX5klLHe87Mkmn5+fX3aV3zn1yHvfzJnFHTuvOi8qau1x
        iXn6Zn7WupoFLPKf2c4rZl7sL1vEPKE45NhHD56putz3v2dl6N09btGR1nZyhxJLcUaioRZz
        UXEiAM9QvFr2AgAA
X-CMS-MailID: 20210924094827epcas1p40de9ed3b54561778d3f6110ee6326374
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210917075050epcas1p1962cd1c7c388b20ad17cb841461dae1b
References: <CGME20210917075050epcas1p1962cd1c7c388b20ad17cb841461dae1b@epcas1p1.samsung.com>
        <bf19053cf6f547bcbb364975cda84c30@hyperstone.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On 9/17/21 4:50 PM, Christian Löhle wrote:
> 
> Set the limit to 1s if the register is at reset value.
> 
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6578cc64ae9e..cd9a6e0a7449 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1983,6 +1983,14 @@ static void dw_mci_set_drto(struct dw_mci *host)
>  	/* add a bit spare time */
>  	drto_ms += 10;
>  
> +	/*
> +	 * If TMOUT register still holds the reset value the above calculation
> +	 * would yield a timeout of over 167 seconds, limit it to 1000ms.
> +	 * Normal reads/writes should not take anywhere close to 120s.
> +	 */
> +	if (drto_ms > 120000)
> +		drto_ms = 1000;
> +

If dtrt_ms is 167sec, it means that bus_hz should be 0 or 1.
What value is your host->bus_hz?

Best Regards,
Jaehoon Chung

>  	spin_lock_irqsave(&host->irq_lock, irqflags);
>  	if (!test_bit(EVENT_DATA_COMPLETE, &host->pending_events))
>  		mod_timer(&host->dto_timer,
> 

