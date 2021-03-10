Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A50B5C433DB
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 03:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 795CA64FEE
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 03:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbhCJD4K (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 22:56:10 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:64915 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbhCJDzk (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 22:55:40 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210310035538epoutp03ac18f8d0d0a5295c367bf774faeb36ee~q3u-8b5_V0383703837epoutp03f
        for <linux-mmc@vger.kernel.org>; Wed, 10 Mar 2021 03:55:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210310035538epoutp03ac18f8d0d0a5295c367bf774faeb36ee~q3u-8b5_V0383703837epoutp03f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615348538;
        bh=UVK1kMtnoHnKVGkbhxLksBewBd1KLPzV69iuakVxlbg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=vjOZMqPu2XwdQlYYF76JHNlbN7g4PAw1l+KvIxpBIbJ8iGf65jDD1CDg88ZzP010E
         ous+kWSvUgsdb4hK3zuo/a6uOmzg8vzTFZrkjbOCWq/WyG3z1tZH0/GPnX3b90P01K
         mrzukfxUZLZS7CdS7amRaTV7PjqgJpkkPItd3Z5E=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210310035536epcas2p1053c58ce88498154422f9f6c6f503dd9~q3u_VFDEx1376213762epcas2p1n;
        Wed, 10 Mar 2021 03:55:36 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DwJBv46WDz4x9Q3; Wed, 10 Mar
        2021 03:55:35 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.6F.56312.73348406; Wed, 10 Mar 2021 12:55:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20210310035534epcas2p42954ede9bbb60651f755174baec412f0~q3u8Esq-71161611616epcas2p4H;
        Wed, 10 Mar 2021 03:55:34 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210310035534epsmtrp1adcf28ddfbbf130b733ed0df3769f27a~q3u8EGps11138411384epsmtrp1z;
        Wed, 10 Mar 2021 03:55:34 +0000 (GMT)
X-AuditID: b6c32a46-1efff7000000dbf8-b1-6048433743ef
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.3E.08745.63348406; Wed, 10 Mar 2021 12:55:34 +0900 (KST)
Received: from KORCO011456 (unknown [12.36.185.54]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210310035534epsmtip2dabfd9f3f315ae4b4472cc762be435a5~q3u75Wog21776517765epsmtip2i;
        Wed, 10 Mar 2021 03:55:34 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Ulf Hansson'" <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>
In-Reply-To: <CAPDyKFpeCWp6JUS4w9h1K7ZLjvE0JuREuWgrsuQSzD7dOJBHGw@mail.gmail.com>
Subject: RE: About a possibility of long latency to claim host
Date:   Wed, 10 Mar 2021 12:55:33 +0900
Message-ID: <002301d71561$390997e0$ab1cc7a0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQHnYJw8NfxlhPim0I9Ql9ljwqb6fAGpovOjAi+Gw36qPTe/AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmha65s0eCwZyX3BZH/vczWhxfG+7A
        5HHn2h42j8+b5AKYonJsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
        XHwCdN0yc4CmKymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKDA0L9IoTc4tL89L1
        kvNzrQwNDIxMgSoTcjK+3TnPWLCateLbjCesDYxzWLoYOTgkBEwk7j8K7WLk4hAS2MEocf7+
        LWYI5xOjxMqGj0BFnEDOZ0aJvQdyQGyQhmOzXkIV7WKUWNX7kQ3CecEo0f2nkQmkik1AW2La
        w92sILaIgI7EjDfNYDazgLzE2ysrwGxOgUCJHSc/sIKcISxgJ7HubwRImEVAVeLMvAfsIDav
        gKXE2UcXWCBsQYmTM5+wwIzZ/nYOM8RBChI/ny6DGi8iMbuzjRlirZPE0pPrGUFukxA4xy6x
        q3cHK8TLLhJLFmtD9ApLvDq+hR3ClpJ42d8GZddL7JvawArR28Mo8XTfP0aIhLHErGftjCBz
        mAU0Jdbv0ocYqSxx5BbUaXwSHYf/skOEeSU62oQgGpUlfk2aDDVEUmLmzTvsExiVZiF5bBaS
        x2YheWYWwq4FjCyrGMVSC4pz01OLjQqMkGN6EyM42Wm57WCc8vaD3iFGJg7GQ4wSHMxKIrx+
        x90ShHhTEiurUovy44tKc1KLDzGaAoN6IrOUaHI+MN3mlcQbmhqZmRlYmlqYmhlZKInzFhs8
        iBcSSE8sSc1OTS1ILYLpY+LglGpg2vbzwNqJOREifptVTl3kSVPy6jn9gMkto/d95hP5eYf/
        zZ25o9bwtbI817Uroa676jrjguxX8ydd86456PZnTsBToddJNUoK166+Ztgt2vB4oqG5fGrA
        kW33Gk3bHi9Z8eH0VvU7hzZNEOJcp/+BsW2iX52dh5BTccO3qFNtYTnMS7QrE/0nPuo8blKz
        mKXu3gFGbcsY6frqfdzzZ08/fXr175tv2ktP6G5w7e8trNq61zpL4GVDoqHMs087ZvLarL7g
        l7ImWO1ATrH5t8ZLz9KrvQRa1CPSn3IprJh0wdD1/gP21vlavD0b90zcfvBlsTXHu9pDjhtF
        4pkWpAYzNGbZi8w/Pav+IqfV/aw3SizFGYmGWsxFxYkATdUY7v8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSvK6Zs0eCwdaFkhZH/vczWhxfG+7A
        5HHn2h42j8+b5AKYorhsUlJzMstSi/TtErgyvt05z1iwmrXi24wnrA2Mc1i6GDk5JARMJI7N
        esncxcjFISSwg1Fi86vrUAlJiRM7nzNC2MIS91uOsEIUPWOUuL1iFTtIgk1AW2Law92sILaI
        gI7EjDfNYDazgLzE2ysroBouMEos33EcbBKnQKDEjpMfgBIcHMICdhLr/kaAhFkEVCXOzHsA
        NpNXwFLi7KMLLBC2oMTJmU9YIGZqS/Q+bGWEmb/97RxmiOMUJH4+XQa1V0RidmcbM8Q9ThJL
        T65nnMAoPAvJqFlIRs1CMmoWkvYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGC
        g19LawfjnlUf9A4xMnEwHmKU4GBWEuH1O+6WIMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJ
        eCGB9MSS1OzU1ILUIpgsEwenVANT4BKXBKbQBolbzc2Wn4LfnzC3//f9hewOkSndd33k37u1
        mHbcc3te1/eQhSfVmYubM3FWpEntFmWTmqZtscH+4m2XXOOey0x+OqG14AfjzvAPVQ5b5uTZ
        bj/yf16B+wHpGSH/o0rn7ebMberWDrebxLFQ9nBp1/1nF3uOSvbf5vn9dZeEyL2wBCuz9F9T
        stdNWmkhzy1eobfvB8u6ZPencUozlZ9bZuum3v7Ys2b2lN5+o41M3yYVVe4ubD500T9sRbyq
        3tWYW5c/1j7VtWyt/BI8bULba547oWl2GXapzh7pOyf0JK4vvHNWLmGHdXGE7YUNtsZ2nobq
        l9/4nfZqC5BL/WWeOHXy2wVa35VYijMSDbWYi4oTARvQhu3tAgAA
X-CMS-MailID: 20210310035534epcas2p42954ede9bbb60651f755174baec412f0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210309041059epcas2p49567b092c8d82bb80aa76ad26f8d212b
References: <CGME20210309041059epcas2p49567b092c8d82bb80aa76ad26f8d212b@epcas2p4.samsung.com>
        <02da01d7149a$35dec530$a19c4f90$@samsung.com>
        <CAPDyKFpeCWp6JUS4w9h1K7ZLjvE0JuREuWgrsuQSzD7dOJBHGw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> > Below is the call stacks shown after the symptom happened and the system
> tried to enter into suspend again.
> > In this case, mmc pm notifier is called with PM_SUSPEND_PREPARE, so it
> waits for completion or cancelling the work for mmc_rescan.
> > For the latency, mobile users can see black screen for a long time
> sometimes, even with pushing a power button to wake up the system.
> 
> I think I understand what you are saying, but please correct me if I am
> wrong.
> 
> The I/O requests keep flowing into the blk queue even after
> PM_SUSPEND_PREPARE has been fired, thus preventing the earlier scheduled
> mmc_rescan() from claiming the host?

Correct.

