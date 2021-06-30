Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB4A7C11F65
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 22:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9619F613EC
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Jun 2021 22:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbhF3WIM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Jun 2021 18:08:12 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:17447 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbhF3WIM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Jun 2021 18:08:12 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210630220541epoutp018063823fd8cff7d4b4b559c7e198e3e4~Ne2tMh22X0901009010epoutp01G
        for <linux-mmc@vger.kernel.org>; Wed, 30 Jun 2021 22:05:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210630220541epoutp018063823fd8cff7d4b4b559c7e198e3e4~Ne2tMh22X0901009010epoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1625090741;
        bh=BR73RmqbEaP237kkvr/LYqGx1H6FT4VALLOeKZXpSnk=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=hwFQTrz8pPrIUpPDB+puWakrkFFUD2O1WxT1r57fxe29OoQHzaFJMYGtR97rS+r80
         kvx7RiqxOGlnLsjb2j9XagyyCnmryzPSh9eypVS3TphhHVkWzMGd5B2NxsPziMkiwd
         bAoO7N/pLCJpvQELYZ6+1JTq4gAw3Pea4NmeO+j8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210630220541epcas1p24cba918b578bfb86078de06abb73a5f3~Ne2s6LNDi2798527985epcas1p2j;
        Wed, 30 Jun 2021 22:05:41 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4GFb4y4WTvz4x9Pt; Wed, 30 Jun
        2021 22:05:38 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        BF.B5.09952.2BAECD06; Thu,  1 Jul 2021 07:05:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210630220537epcas1p45ba67803d51e11a32fe9808e1a06293a~Ne2p7Nd-d2543825438epcas1p4x;
        Wed, 30 Jun 2021 22:05:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210630220537epsmtrp17b0f7a0b8245dc369113b910e0d29cf2~Ne2p6lTGq2776227762epsmtrp11;
        Wed, 30 Jun 2021 22:05:37 +0000 (GMT)
X-AuditID: b6c32a35-45dff700000026e0-ce-60dceab29674
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AE.A6.08289.1BAECD06; Thu,  1 Jul 2021 07:05:37 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210630220537epsmtip1f6b2c1376ddc9c33f0f9539eafadef99~Ne2puA3YU3060330603epsmtip1r;
        Wed, 30 Jun 2021 22:05:37 +0000 (GMT)
Subject: Re: [PATCH] mmc: dw_mmc: Fix hang on data CRC error
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel@axis.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <81c1b56d-e1be-b3fb-6b44-fc8054f1dd8b@samsung.com>
Date:   Thu, 1 Jul 2021 07:06:31 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630102232.16011-1-vincent.whitchurch@axis.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTT3fTqzsJBgtny1t8alG1uLxrDpvF
        kf/9jBbH14ZbnN/m78DqcX1dgMeda3vYPD5vkgtgjsq2yUhNTEktUkjNS85PycxLt1XyDo53
        jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFap6RQlphTChQKSCwuVtK3synKLy1JVcjILy6x
        VUotSMkpsCzQK07MLS7NS9dLzs+1MjQwMDIFKkzIzug59IWxYLdQxfGm3cwNjDP4uhg5OSQE
        TCTmPH3E3sXIxSEksINR4uSPO8wQzidGifV7DkM5nxkl9t/7zw7TMn3mI1aIxC5GiSXfdzOC
        JIQE3jNKnLptBGILC9hIXLx3hQ3EFhGIkXjasxHMZhbwkbg65TBYPZuAjsT2b8eZQGxeATuJ
        a3sWsIDYLAIqEi0PdoLZogKREud3Q8R5BQQlTs58AmZzCjhKTJixDWqmuMStJ/OZIGx5ie1v
        54BdLSHwkl3i1YkZLBBXu0hM/vYI6gNhiVfHt0DZUhIv+9ug7GqJXc1noJo7GCVubWtigkgY
        S+xfOhnI5gDaoCmxfpc+RFhRYufvuYwQi/kk3n3tYQUpkRDglehoE4IoUZG49PolE8yqu0/+
        s0LYHhKTlsxgmcCoOAvJa7OQvDMLyTuzEBYvYGRZxSiWWlCcm55abFhgiBzbmxjBSVHLdAfj
        xLcf9A4xMnEwHmKU4GBWEuGN2nk7QYg3JbGyKrUoP76oNCe1+BCjKTCwJzJLiSbnA9NyXkm8
        oamRsbGxhYmhmamhoZI47062QwlCAumJJanZqakFqUUwfUwcnFINTAH/5twLVHtQ4en+N5hj
        nglj8Y4Cg9tn74qm7b8y3fpDRVv2t9vPOaZzeylLH5vIfLX0+w4Z51myM701ZHUXidpvPBD/
        N3drwaKaE4aymrJq6ie6ftW6S/u4vuATLKuvKJJjV7p8ufvs7Jc5hv+OHa9fKfVPzbnk+wbz
        TPbeX4vOXNj8We0Xa9E6j6zuh9PWL1uakO1pEVA0L7jHbG/ZhngVBh8DB5n1/5dlCxuvFvR/
        pDt9X/OlbaJ/Xmocdzg9M+TQXXl2212n/77TsMmpYn2o/X6pRYil6frju99+UrBZ2S++kq+W
        r+B/vKXGy1n+fQsv5sif61z2y5eNUTjDNnLFAy5ZOxGGW4vezpysqMRSnJFoqMVcVJwIAIDt
        XPITBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnO7GV3cSDBrnaFl8alG1uLxrDpvF
        kf/9jBbH14ZbnN/m78DqcX1dgMeda3vYPD5vkgtgjuKySUnNySxLLdK3S+DK6Dn0hbFgt1DF
        8abdzA2MM/i6GDk5JARMJKbPfMTaxcjFISSwg1Fi34wbbBAJKYnPT6cC2RxAtrDE4cPFEDVv
        GSX+93Szg9QIC9hIXLx3BaxeRCBGYuerZ2A2s4CPxNUphxkhGqYwSkya8pYZJMEmoCOx/dtx
        JhCbV8BO4tqeBSwgNouAikTLg51gtqhApMTnBa9YIWoEJU7OfAIW5xRwlJgwYxvUAnWJP/Mu
        MUPY4hK3nsxngrDlJba/ncM8gVFoFpL2WUhaZiFpmYWkZQEjyypGydSC4tz03GLDAqO81HK9
        4sTc4tK8dL3k/NxNjOA40NLawbhn1Qe9Q4xMHIyHGCU4mJVEeKN23k4Q4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgUn06v9pLxh1Oa0jzlrrrrGcxi82
        OdWxarLiVR2ht6wSJRPbbxSarn7malp7ztjOW0OlQPCH9ZffHsd9DvZyS1mYC2lJqhbPmsDw
        kUHNLOzABUm1y3E2tcLtf5y2mbKeapL2X/dO4usv9adesmJztgV3vapdY+B5cm6SmmVEMOsF
        2d+1zyau/nxbQGCNqcKuGWl8J0Q/fmk+xZtzessv9aIlPzMrNpinFDn95T5Z3hqqLvJ48dQp
        Ow3ehX7WkHw8aenVxrnZ25+4dc4TvzPpZJbvFOacO1f+rsk4dvL9LOMfx0VDGUstduet7nob
        9KBr9T/+J2rPmO1WT9pZu0j628v7u2e5T/I8UXhy9cmSC1JKLMUZiYZazEXFiQAFzbKS8gIA
        AA==
X-CMS-MailID: 20210630220537epcas1p45ba67803d51e11a32fe9808e1a06293a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210630102240epcas1p33bbdffb5eb553a49badaffab756d482c
References: <CGME20210630102240epcas1p33bbdffb5eb553a49badaffab756d482c@epcas1p3.samsung.com>
        <20210630102232.16011-1-vincent.whitchurch@axis.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dear Vincent,

On 6/30/21 7:22 PM, Vincent Whitchurch wrote:
> When a Data CRC interrupt is received, the driver disables the DMA, then
> sends the stop/abort command and then waits for Data Transfer Over.
> 
> However, sometimes, when a data CRC error is received in the middle of a
> multi-block write transfer, the Data Transfer Over interrupt is never
> received, and the driver hangs and never completes the request.
> 
> The driver sets the BMOD.SWR bit (SDMMC_IDMAC_SWRESET) when stopping the
> DMA, but according to the manual CMD.STOP_ABORT_CMD should be programmed
> "before assertion of SWR".  Do these operations in the recommended
> order.  With this change the Data Transfer Over is always received
> correctly in my tests.

I will check with your patch. I didn't see any CRC error on my targets before.

Best Regards,
Jaehoon Chung

> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  drivers/mmc/host/dw_mmc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index f85271f5c4fa..845b0745ea37 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2083,8 +2083,8 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>  					continue;
>  				}
>  
> -				dw_mci_stop_dma(host);
>  				send_stop_abort(host, data);
> +				dw_mci_stop_dma(host);
>  				state = STATE_SENDING_STOP;
>  				break;
>  			}
> @@ -2108,10 +2108,10 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>  			 */
>  			if (test_and_clear_bit(EVENT_DATA_ERROR,
>  					       &host->pending_events)) {
> -				dw_mci_stop_dma(host);
>  				if (!(host->data_status & (SDMMC_INT_DRTO |
>  							   SDMMC_INT_EBE)))
>  					send_stop_abort(host, data);
> +				dw_mci_stop_dma(host);
>  				state = STATE_DATA_ERROR;
>  				break;
>  			}
> @@ -2144,10 +2144,10 @@ static void dw_mci_tasklet_func(struct tasklet_struct *t)
>  			 */
>  			if (test_and_clear_bit(EVENT_DATA_ERROR,
>  					       &host->pending_events)) {
> -				dw_mci_stop_dma(host);
>  				if (!(host->data_status & (SDMMC_INT_DRTO |
>  							   SDMMC_INT_EBE)))
>  					send_stop_abort(host, data);
> +				dw_mci_stop_dma(host);
>  				state = STATE_DATA_ERROR;
>  				break;
>  			}
> 

