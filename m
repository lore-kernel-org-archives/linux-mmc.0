Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9C6C12002
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jul 2021 21:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7B5160C3D
	for <linux-mmc@archiver.kernel.org>; Wed, 14 Jul 2021 21:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhGNVsk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 14 Jul 2021 17:48:40 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:40482 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbhGNVsj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Jul 2021 17:48:39 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210714214546epoutp0177844eab46805c8d13a27cb038d14bca~RxnT0zjsE2948829488epoutp01t
        for <linux-mmc@vger.kernel.org>; Wed, 14 Jul 2021 21:45:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210714214546epoutp0177844eab46805c8d13a27cb038d14bca~RxnT0zjsE2948829488epoutp01t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1626299146;
        bh=Hk8XY5Qw0DnsZL6Vhvi4dqC+Go+d089gtAq84ur/LYg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=oDgchS+xYYzxdthJV0K4Zmf7TILhIKKa+jpISXh0ATmH3dQMMVZyUYKGZ4bvUy1MW
         HhxT+wLYVxcxVnazFuK2QG0T0B8D9jGRzutoJa2OVWby9wuxsI4nZskTDrHlrgGJn4
         Iog4KXdbSZ3Nanshwm3F7Q4t3Ri7xdeEBWw15RrU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210714214545epcas1p1cb8576ffe6c5e7094890cd264e543dd5~RxnTARsjY1177911779epcas1p1J;
        Wed, 14 Jul 2021 21:45:45 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.153]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4GQ9zW0dgbz4x9Pt; Wed, 14 Jul
        2021 21:45:43 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.98.09952.60B5FE06; Thu, 15 Jul 2021 06:45:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210714214541epcas1p26debc79a3994d74058acaec507447dd4~RxnP_BmOy0323503235epcas1p2n;
        Wed, 14 Jul 2021 21:45:41 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210714214541epsmtrp2f5c2e1571a712e28a1c94345cc330d26~RxnP9SDEJ2448924489epsmtrp2O;
        Wed, 14 Jul 2021 21:45:41 +0000 (GMT)
X-AuditID: b6c32a35-447ff700000026e0-37-60ef5b0630d9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.4E.08394.50B5FE06; Thu, 15 Jul 2021 06:45:41 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210714214541epsmtip17b5905f0ce96e26b00edf2af3fb11714~RxnPo1AN-0598805988epsmtip1E;
        Wed, 14 Jul 2021 21:45:41 +0000 (GMT)
Subject: Re: [PATCH] mmc: dw_mmc: Fix hang on data CRC error
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, kernel <kernel@axis.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <5c025295-fa14-d363-89a2-e96e3b278419@samsung.com>
Date:   Thu, 15 Jul 2021 06:46:34 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
        Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210714114921.GA22706@axis.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdlhTX5c9+n2CQVeIxacWVYvLu+awWRz5
        389ocXxtuMX5bf4OrB7X1wV43Lm2h83j8ya5AOaobJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4
        UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoG1KCmWJOaVAoYDE4mIlfTubovzSklSFjPziElul
        1IKUnALLAr3ixNzi0rx0veT8XCtDAwMjU6DChOyMltaYggdcFVv3HWFtYPzL0cXIySEhYCJx
        8WQfaxcjF4eQwA5GiQNvuqCcT4wSDy9uY4JwvjFKTF/0kxGmZdGhOywQib2MEhvu3WSGcN4z
        Smw+fpsNpEpYwEbi4r0rYLYIUMe2ya/A5jIL7GOUOL+3nRUkwSagI7H923EmEJtXwE7i+rcG
        sAYWAVWJ3oM7wdaJCkRKnN+9gAWiRlDi5MwnYDangJ7E0pVfmEFsZgFxiVtP5jNB2PIS29/O
        AbtIQuARu8SJo7uYIO52kdi4eyYLhC0s8er4FnYIW0ri87u9bBB2tcSu5jNQzR2MEre2NUE1
        G0vsXzoZyOYA2qApsX6XPkRYUWLn77mMEIv5JN597WEFKZEQ4JXoaBOCKFGRuPT6JRPMqrtP
        /rNC2B4Sk5bMYJnAqDgLyWuzkLwzC8k7sxAWL2BkWcUollpQnJueWmxYYIgc3ZsYwUlRy3QH
        48S3H/QOMTJxMB5ilOBgVhLhXWr0NkGINyWxsiq1KD++qDQntfgQoykwsCcyS4km5wPTcl5J
        vKGpkbGxsYWJoZmpoaGSOO9OtkMJQgLpiSWp2ampBalFMH1MHJxSDUzZ99aURS3mPe9kN6NO
        dOmzvNcTTqhmPpoWqq9syPYr7/WdyO8HClZtVVphn5+0VeTh+eTlrbGpGtUfrVJ9ls/pZD3g
        Wf3kMOOBKz8PGhdH2LQrRbK8fKHgxv5lxj62A+XdD2Wzg+Ui73zZu31Kk3tye3hFKHfLQ6Ym
        DdEWFzEeMS31ZN5rnRP5M+Nevb/5gaWPx+0004yQp9LHavkXRz48fl3S77/epfz4rFtMl35w
        /33n4friN0+9v9L7suADJyPWyUw2XFz+TE8z6/ahpT89P4bP2pppfrSF6dqq7lCtMONZfpl3
        GOc6/7l6N1RvTxTzRUPVb59knias6rCb2B2wmN/9T/XUUD55yWd7/yuxFGckGmoxFxUnAgA7
        G3dFEwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPLMWRmVeSWpSXmKPExsWy7bCSnC5r9PsEg9VNhhafWlQtLu+aw2Zx
        5H8/o8XxteEW57f5O7B6XF8X4HHn2h42j8+b5AKYo7hsUlJzMstSi/TtErgyWlpjCh5wVWzd
        d4S1gfEvRxcjJ4eEgInEokN3WLoYuTiEBHYzSlx+NI0JIiEl8fnpVLYuRg4gW1ji8OFiiJq3
        jBIX9kwEqxEWsJG4eO8KG4gtAjRo2+RXrCBFzAL7GCVebNjPAtdx9esSRpAqNgEdie3fjoN1
        8wrYSVz/1gDWzSKgKtF7cCdYjahApMTnBSCTQGoEJU7OfMICYnMK6EksXfmFGcRmFlCX+DPv
        EpQtLnHryXwmCFteYvvbOcwTGIVmIWmfhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMxLLdcr
        TswtLs1L10vOz93ECI4DLc0djNtXfdA7xMjEwXiIUYKDWUmEd6nR2wQh3pTEyqrUovz4otKc
        1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamA4vW3yrJ+PbSuOpEYt2fw67sUmo
        /b6kX4vsjfRo7oe224IqZvff8Cv5sd75ahyL16GVwmeeN3Jvz3Vaus2ML+OnZXDxJi3rF/8O
        ZjwPS/uTF/Hj8ZxfqQItxbwii3aHSzc6HDnYe1PR2V9SzLd8G9O2Pf6WTh25TZ1Xp0s8VOHg
        Cz+pmjg1KftSjZqSkZys45Pm3dpZ2kf+7JBMExAKi+44vPHSgbTUX1Zfp7lc4Y0/71IxcYe2
        feWpvfOXLwt3UIkNd1Cbtp7vgH2r48zDn7a1Re8LlDo/TSzj/32tY++8n+/Zujr+SNiri/WB
        4j9DkiRtLKrs3U8ll3D8iD0zbfWa3+IGjA3Wy4tNiqqUlViKMxINtZiLihMB2Wt+Z/ICAAA=
X-CMS-MailID: 20210714214541epcas1p26debc79a3994d74058acaec507447dd4
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
> 
>  https://protect2.fireeye.com/v1/url?k=96c33914-c958001f-96c2b25b-002590f5b904-9a89d187f33934b7&q=1&e=308eae3a-44b8-43d7-be54-24e9b850f4ad&u=https%3A%2F%2Flore.kernel.org%2Flinux-mmc%2F20210701080534.23138-1-vincent.whitchurch%40axis.com%2F
> 

