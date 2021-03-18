Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAF0C433DB
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Mar 2021 05:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD01464E33
	for <linux-mmc@archiver.kernel.org>; Thu, 18 Mar 2021 05:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbhCRFM3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 18 Mar 2021 01:12:29 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:22656 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhCRFLv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Mar 2021 01:11:51 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210318051149epoutp03a167abffe66e6a302ae3678a0ed1059e~tV7ys8cPH1766817668epoutp038
        for <linux-mmc@vger.kernel.org>; Thu, 18 Mar 2021 05:11:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210318051149epoutp03a167abffe66e6a302ae3678a0ed1059e~tV7ys8cPH1766817668epoutp038
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616044309;
        bh=Maz2gzBeG8Ar9nIKmEg6l8Ds+kNMlT5vGVumq7wmVCI=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=RI0ezcMcah92niEj7qCrMTIhEqF1eO4cATk14VNXHM+Squ0xYxTzXAPnQmIhTeAuU
         8cGaUan9DRurje66+eu6jUd/dv2qrFDbe5fBxfAX5i0odfYH8s+Jq1/c5vNJpSsOFQ
         JfF2gUnIbMpN4Yl544qCFYh4kLD+11gGX56svzqU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20210318051148epcas2p2c77f5bc4b1b1a4d47e641e2247d6bcd6~tV7x15Mi52273522735epcas2p2D;
        Thu, 18 Mar 2021 05:11:48 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.183]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4F1FW55HwVz4x9Q5; Thu, 18 Mar
        2021 05:11:45 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.BD.52511.F01E2506; Thu, 18 Mar 2021 14:11:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20210318051143epcas2p419b8162af1c6b4fcf269735cb478e0b0~tV7tFi2tS0768407684epcas2p4u;
        Thu, 18 Mar 2021 05:11:43 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210318051143epsmtrp29c35ff77c28bcc475c36a108e09be372~tV7tEj9RJ0834308343epsmtrp2d;
        Thu, 18 Mar 2021 05:11:43 +0000 (GMT)
X-AuditID: b6c32a48-50fff7000000cd1f-88-6052e10fd8c9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        78.EC.13470.E01E2506; Thu, 18 Mar 2021 14:11:42 +0900 (KST)
Received: from KORCO011456 (unknown [12.36.185.54]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210318051142epsmtip27de352491011465a85194df6785c6078~tV7s2_KA31284212842epsmtip2X;
        Thu, 18 Mar 2021 05:11:42 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Ulf Hansson'" <ulf.hansson@linaro.org>
Cc:     "'linux-mmc'" <linux-mmc@vger.kernel.org>,
        =?UTF-8?B?7J207IOB7ZiE?= <sh425.lee@samsung.com>,
        =?UTF-8?B?7ISc7Iq57LKg?= <sc.suh@samsung.com>,
        =?UTF-8?B?7ISc7Zi47JiB?= <hy50.seo@samsung.com>,
        =?UTF-8?B?6rmA67OR7ZuI?= <bhoon95.kim@samsung.com>
In-Reply-To: <CAPDyKFqAXejhr4yytY7KwLycSTnyC0Y4AD3DErxbYMuXUJhVbg@mail.gmail.com>
Subject: RE: [PATCH] mmc: core: Fix hanging on I/O during system suspend for
 removable cards
Date:   Thu, 18 Mar 2021 14:11:42 +0900
Message-ID: <010301d71bb5$2f6d6d10$8e484730$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHdOhUB196LQ3U1VfE+AnKrSxL4AwI5OEDFAjtGX74CZaB2VapGJBUQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkk+LIzCtJLcpLzFFi42LZdljTVJf/YVCCwbXZqhZflz5jtVi9+AGL
        xZH//YwWXXdvMFos/feWxeL42nAHNo871/awefRtWcXo8XmTXABzVI5NRmpiSmqRQmpecn5K
        Zl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtBaJYWyxJxSoFBAYnGxkr6dTVF+
        aUmqQkZ+cYmtUmpBSk6BoWGBXnFibnFpXrpecn6ulaGBgZEpUGVCTsbfCW9ZCnqYKjaffcnU
        wHiBsYuRg0NCwETi0gqtLkYuDiGBHYwSe/esYIFwPjFKrF/1jwnC+cYo8f7UW7YuRk6wjtUf
        X7BDJPYySrw51QbV8oJRYu2XTWBVbALaEtMe7mYFsUUEdCRmvGlmBSliFvjJKPH20mUmkASn
        QKDE3R+9YA3CAnESazbsYQGxWQRUJdr+vmIGsXkFLCVen5gEZQtKnJz5BKyGGWjBsoWvmSFO
        UpD4+XQZ1DI3iWeX9zJC1IhIzO5sYwZZLCHwkV3i5Nc+RogGF4lLs09D2cISr45vYYewpSQ+
        v9sL9We9xL6pDawQzT2MEk/3/YNqMJaY9awdHHzMApoS63fpQ0JSWeLILajb+CQ6Dv9lhwjz
        SnS0CUE0Kkv8mjQZaoikxMybd9gnMCrNQvLZLCSfzULywSyEXQsYWVYxiqUWFOempxYbFZgg
        x/YmRnCa1PLYwTj77Qe9Q4xMHIyHGCU4mJVEeE3zAhKEeFMSK6tSi/Lji0pzUosPMZoCw3oi
        s5Rocj4wUeeVxBuaGpmZGViaWpiaGVkoifMWGTyIFxJITyxJzU5NLUgtgulj4uCUamDaf7Cl
        c6PssyM9J/pOnlba4RtobqTEdKVAvo3fanJsm3yh1+Ymn9tL3i7wz2XW0zzGPXu1hJq+gxL/
        ZCYnPZ/D1eWbjF1Ny2es9d54cPrjJ9c4nv35tkg22y+n7smmO/2nBTJDbss17hHV/1ru4vnk
        YOSX+288Hu1pvxJnuVBA7zu/YpN4zy3WRxyrnjUunDX9sIn8JB/Dpku/EwucVk8uLkxkmDfn
        cVXAz+PiS1/0v2FVbmqJv/Lz/s5rpTIbrh897+T6cE2VrqT2/LNVOyOPLT9nsmut3xlflQ/n
        /2brBq97pbk/OVXuOXfwC7mVG5fm63JUTZQp2W2ckFvSwVP7psG1w/Ur19HsnPYMvTwlluKM
        REMt5qLiRABoaJtVHAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWy7bCSvC7fw6AEg8bfNhZflz5jtVi9+AGL
        xZH//YwWXXdvMFos/feWxeL42nAHNo871/awefRtWcXo8XmTXABzFJdNSmpOZllqkb5dAldG
        895l7AU9TBUvt0U3MF5g7GLk5JAQMJFY/fEFexcjF4eQwG5GiX2v1jJDJCQlTux8DlUkLHG/
        5QgrRNEzRolzi7aBJdgEtCWmPdzNCmKLCOhIzHjTDFbELPCbUaL722lmiI5GJol7L3azgFRx
        CgRK3P3RywZiCwvESLw6+w1sEouAqkTb31dgq3kFLCVen5gEZQtKnJz5BKyXGWhb78NWRhh7
        2cLXUKcqSPx8ugzqCjeJZ5f3QtWISMzubGOewCg8C8moWUhGzUIyahaSlgWMLKsYJVMLinPT
        c4sNCwzzUsv1ihNzi0vz0vWS83M3MYIjRktzB+P2VR/0DjEycTAeYpTgYFYS4TXNC0gQ4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgWl5HcO9Hemb1q/w
        N4lepNdf8FMlStJyoVddd/rkbtfeLsWtLN562c2frBKbL4R0xmbaalpruTr95+yNnqxZ5GHM
        Z5nV+W9L59flqscrzvQfjhJdPrVM7vi1fQL9rKeO3TSyTd0uaeQuL/1TweXz7gCrXzty3sjd
        CJ+pGdV6mW9pp+PinM/TGRx2tuyxPPpb76dOXuvRS8scFvEfuG+h4O209A6jQLvXjKfq8fOm
        tfmveHPFYtu/iFmf5s3qCSnaYFL89r95Rf3VbZXMdw88vBS6mOO1xc4DtpbnRPvmdX++FcqQ
        VHVed/fOlTa+rtdKVJbtMjj0laHuwVw2v+dulh56W9N4JS7Pe8X/XD9FQ4mlOCPRUIu5qDgR
        AMStvroHAwAA
X-CMS-MailID: 20210318051143epcas2p419b8162af1c6b4fcf269735cb478e0b0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210310152931epcas2p1be7719eeaca8d14bf7a8244ff389bd39
References: <CGME20210310152931epcas2p1be7719eeaca8d14bf7a8244ff389bd39@epcas2p1.samsung.com>
        <20210310152900.149380-1-ulf.hansson@linaro.org>
        <000001d7195e$8122ca00$83685e00$@samsung.com>
        <CAPDyKFqAXejhr4yytY7KwLycSTnyC0Y4AD3DErxbYMuXUJhVbg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> Did you try out the patch at your side, to see if it resolves your
> problems?

I've already done it and am discussing about this with some guys who first =
reported me.
Obviously, this patch can prevent from something like deadlock.

Thanks.
Kiwoong Kim

