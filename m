Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74B0C432BE
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 22:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A5C46054E
	for <linux-mmc@archiver.kernel.org>; Wed, 25 Aug 2021 22:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhHYWvp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 25 Aug 2021 18:51:45 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:44462 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbhHYWvo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Aug 2021 18:51:44 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210825225056epoutp035819e82c3c6aec1cf8cc34dc7636db7e~ermNTHnqk0218902189epoutp036
        for <linux-mmc@vger.kernel.org>; Wed, 25 Aug 2021 22:50:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210825225056epoutp035819e82c3c6aec1cf8cc34dc7636db7e~ermNTHnqk0218902189epoutp036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629931856;
        bh=d4QfZmk+Z+A6mbLvaht4OWfneHLqo8l4AoP6A33HAps=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=BVV6BwqAHr6QtsfhOQOBw5o0i6a88GFf5U9z/tmJ3/j/q9qxUUmBwe5GhnUtZbFas
         rlRJ8gqwgTuaqcuCeKg/HA/aMP/r2JINjwLWzjN93AUTA8SkiSiYAxj+PpD3mB1BJV
         MqbCe6V0p67BAiL6h2TkPrqPA4lv0w4X8cq75vao=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210825225056epcas1p20eea023931b83216ae44e4e4c0e5f89a~ermNHiOM31420114201epcas1p20;
        Wed, 25 Aug 2021 22:50:56 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.38.232]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Gw1RG3bcCz4x9Pr; Wed, 25 Aug
        2021 22:50:50 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D4.4C.10095.049C6216; Thu, 26 Aug 2021 07:50:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210825225040epcas1p2f08c81209095eb610c7ea4ac0afd94d1~erl9t_uV01420614206epcas1p2P;
        Wed, 25 Aug 2021 22:50:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210825225040epsmtrp29337df376754a35f24cad6166d2ddc29~erl9tQm1v0504005040epsmtrp2H;
        Wed, 25 Aug 2021 22:50:40 +0000 (GMT)
X-AuditID: b6c32a38-691ff7000000276f-1b-6126c94052d7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.DA.09091.F39C6216; Thu, 26 Aug 2021 07:50:39 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210825225039epsmtip260f578b730ab81edf281c8a046a6733b~erl9iP9zh1065010650epsmtip2c;
        Wed, 25 Aug 2021 22:50:39 +0000 (GMT)
Subject: Re: [PATCH] mmc: dw_mmc: Only inject fault before done/error
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@axis.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <df051894-eb4a-2b45-601a-ddec6e6aa974@samsung.com>
Date:   Thu, 26 Aug 2021 07:51:29 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210825114213.7429-1-vincent.whitchurch@axis.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPKsWRmVeSWpSXmKPExsWy7bCmga7DSbVEgysNKhafWlQtLu+aw2Zx
        5H8/o8XxteEW57f5O7B6XF8X4HHn2h42j8+b5AKYo7JtMlITU1KLFFLzkvNTMvPSbZW8g+Od
        403NDAx1DS0tzJUU8hJzU22VXHwCdN0yc4DWKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0ts
        lVILUnIKTAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM37f28FasEKw4sjhC6wNjE18XYwcHBIC
        JhL91zy7GDk5hAR2MEpsma7RxcgFZH9ilLg4bzk7hPONUeLmy8nsIFUgDXMfb2KDSOxllNh8
        dBpU1XtGiUnHjzCCVAkLuEoseXSBFcQWEYiReNqzkQ3EZhbwkbg65TBYDZuAjsT2b8eZQGxe
        ATuJ67O7wGwWAVWJXa3XwepFBSIlzu9ewAJRIyhxcuYTMJtTwEFiyasfrBAzxSVuPZnPBGHL
        S2x/O4cZ5CAJgUfsEosfLmKCONtF4lzjBqgXhCVeHd8CZUtJfH63lw3CrpbY1XwGqrmDUeLW
        tiaoZmOJ/UsnM4ECjFlAU2L9Ln2IsKLEzt9zGSEW80m8+9rDCglTXomONiGIEhWJS69fMsGs
        uvvkPyuE7SHRNO8Z0wRGxVlIXpuF5J1ZSN6ZhbB4ASPLKkax1ILi3PTUYsMCE3hkJ+fnbmIE
        p0Qtix2Mc99+0DvEyMTBeIhRgoNZSYT3L5NyohBvSmJlVWpRfnxRaU5q8SFGU2BgT2SWEk3O
        ByblvJJ4QxNLAxMzI2MTC0MzQyVxXsZXMolCAumJJanZqakFqUUwfUwcnFINTKluB/P3b0lV
        82AqXq7NxJ5XMq9B6EZdtYlshxOn7C6PtXU87a/Mr/JOnlC3hcO4Kj/g6tMjQvpBx0pExYye
        TH2qkHXwlrLsDzE+vilF4aYXWZzKrGWnpPjltTbVnGx757GIpXf5gb4/vnrWU3sYvj3dopqq
        KfVyU4VMjfL51vpZGecaitfNbJqwfouS5YTfqXurNx+cvLuiRaCIbfJ9h+urn5/pnJX41cNw
        3YqWd6wVKnnn/1u5ZPGI8pzzCxJT7ZynIn5NsMn0mGRN6p1KhhkrtitvV4ycLCnhvDP9h0Pk
        59bWL7GdaySuOdfd+fx2W1d6nVDhXNUZtyNc9m3fftM5Pnn10T2Jhaeun2hTYinOSDTUYi4q
        TgQAD0rqxhIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSvK79SbVEgzuNVhafWlQtLu+aw2Zx
        5H8/o8XxteEW57f5O7B6XF8X4HHn2h42j8+b5AKYo7hsUlJzMstSi/TtErgyft/bwVqwQrDi
        yOELrA2MTXxdjJwcEgImEnMfb2LrYuTiEBLYzSjxtvMeK0RCSuLz06lACQ4gW1ji8OFiiJq3
        jBIrp18EqxEWcJVY8ugCmC0iECOx89UzNhCbWcBH4uqUw4wQDZMZJZ6dmMoIkmAT0JHY/u04
        E4jNK2AncX12F5jNIqAqsav1OlizqECkxOcFr1ghagQlTs58wgJicwo4SCx59YMVYoG6xJ95
        l5ghbHGJW0/mM0HY8hLb385hnsAoNAtJ+ywkLbOQtMxC0rKAkWUVo2RqQXFuem6xYYFhXmq5
        XnFibnFpXrpecn7uJkZwHGhp7mDcvuqD3iFGJg7GQ4wSHMxKIrx/mZQThXhTEiurUovy44tK
        c1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamBa3+ClsvqTVN76XTkT1DymHuNK
        tz70lduKV2mPvuTTuNwV7+9Lp1z/5t0d1RrsMK2Acf3Dz2ulDpk5GG+xrYtcG3qTOzTaRa23
        Z/PnC57npswVu5dzeyGX6haXwzadCltF4o3D2/x1lp1WcncujbdYGcmyLorzW9CmlvPFV+0+
        RSxnbXomvyJ1gci2Lx+93i+N0syufqn55HxLeJ1HxGOBb8sm+okbZlUodr24aKK3wvbzhWP8
        bBuj/Lg99XyucQQE1C5b8Klvfp+e9mUpnlvMafk8JtHFF8tNwg7drTAoMq6SLzWblqQ6IUJL
        U+fB7alWP6ulRdzEH4vPnS7DbfGN1y3oeFLLh55+puUaSizFGYmGWsxFxYkAg4FWUvICAAA=
X-CMS-MailID: 20210825225040epcas1p2f08c81209095eb610c7ea4ac0afd94d1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210825114239epcas1p30b69652c975c001082e729fc27ef04c1
References: <CGME20210825114239epcas1p30b69652c975c001082e729fc27ef04c1@epcas1p3.samsung.com>
        <20210825114213.7429-1-vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On 8/25/21 8:42 PM, Vincent Whitchurch wrote:
> The fault injection function can set EVENT_DATA_ERROR but skip the
> setting of ->data_status to an error status if it hits just after a data
> over interrupt.  This confuses the tasklet which can later end up
> triggering the WARN_ON(host->cmd || ..) in dw_mci_request_end() since
> dw_mci_data_complete() would return success.
> 
> Prevent the fault injection function from doing this since this is not a
> real case, and ensure that the fault injection doesn't race with a real
> error either.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>

Reviewed-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung

> ---
>  drivers/mmc/host/dw_mmc.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6578cc64ae9e..380f9aa56eb2 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1802,10 +1802,15 @@ static enum hrtimer_restart dw_mci_fault_timer(struct hrtimer *t)
>  
>  	spin_lock_irqsave(&host->irq_lock, flags);
>  
> -	if (!host->data_status)
> +	/*
> +	 * Only inject an error if we haven't already got an error or data over
> +	 * interrupt.
> +	 */
> +	if (!host->data_status) {
>  		host->data_status = SDMMC_INT_DCRC;
> -	set_bit(EVENT_DATA_ERROR, &host->pending_events);
> -	tasklet_schedule(&host->tasklet);
> +		set_bit(EVENT_DATA_ERROR, &host->pending_events);
> +		tasklet_schedule(&host->tasklet);
> +	}
>  
>  	spin_unlock_irqrestore(&host->irq_lock, flags);
>  
> @@ -2721,12 +2726,16 @@ static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>  		}
>  
>  		if (pending & DW_MCI_DATA_ERROR_FLAGS) {
> +			spin_lock(&host->irq_lock);
> +
>  			/* if there is an error report DATA_ERROR */
>  			mci_writel(host, RINTSTS, DW_MCI_DATA_ERROR_FLAGS);
>  			host->data_status = pending;
>  			smp_wmb(); /* drain writebuffer */
>  			set_bit(EVENT_DATA_ERROR, &host->pending_events);
>  			tasklet_schedule(&host->tasklet);
> +
> +			spin_unlock(&host->irq_lock);
>  		}
>  
>  		if (pending & SDMMC_INT_DATA_OVER) {
> 

