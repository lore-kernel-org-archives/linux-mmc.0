Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64FFC433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 07:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 938C364E21
	for <linux-mmc@archiver.kernel.org>; Thu, 25 Feb 2021 07:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbhBYHoJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 25 Feb 2021 02:44:09 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:45949 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhBYHn6 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 25 Feb 2021 02:43:58 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210225074311epoutp01c3441d6e70a18ed83db9898313ae335e~m7c92eEgq1054410544epoutp01a
        for <linux-mmc@vger.kernel.org>; Thu, 25 Feb 2021 07:43:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210225074311epoutp01c3441d6e70a18ed83db9898313ae335e~m7c92eEgq1054410544epoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614238991;
        bh=ApUUX0U3FL/z2QAhbWg8fN+HyMr5gKeGL9JkkEIF2A0=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=JVRFC1hH/zNQs3Xs6ttyg88F+LfrzZ0nlGNyhMSwRhAnw6OFhdyPRJmzIKOZUwAK8
         tA8XK0GNOe7lxF8TsfaXI1GC8d+NoQ2dczxtmL2V10qTKwhLbqyHiJASKrC+4G/lg7
         ddR9zzo1cohKfYhg0yI3o5Y94Wfcr7K3nGttdtRs=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20210225074310epcas1p3f98c90846b72bc3e37f876dff595837c~m7c9AisAt2838828388epcas1p3d;
        Thu, 25 Feb 2021 07:43:10 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.162]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4DmPsV1jT9z4x9Q1; Thu, 25 Feb
        2021 07:43:10 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.33.10463.E0557306; Thu, 25 Feb 2021 16:43:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210225074309epcas1p2ed4a8c8961ca1e78321be678ea2014c4~m7c7uliu62628426284epcas1p2E;
        Thu, 25 Feb 2021 07:43:09 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210225074309epsmtrp165ea687e0363d71f71ce228faae86eea~m7c7tszly0123701237epsmtrp1C;
        Thu, 25 Feb 2021 07:43:09 +0000 (GMT)
X-AuditID: b6c32a38-efbff700000028df-40-6037550e31e9
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        62.1D.08745.D0557306; Thu, 25 Feb 2021 16:43:09 +0900 (KST)
Received: from dh0421hwang01 (unknown [10.253.101.58]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210225074309epsmtip13a064e24adbfcd239199358f9d7c1095~m7c7fV-8x0540805408epsmtip1z;
        Thu, 25 Feb 2021 07:43:09 +0000 (GMT)
From:   "DooHyun Hwang" <dh0421.hwang@samsung.com>
To:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <ebiggers@google.com>,
        <wsa+renesas@sang-engineering.com>, <satyat@google.com>,
        <ludovic.barre@st.com>, <linus.walleij@linaro.org>
Cc:     <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
        <junwoo80.lee@samsung.com>, <jangsub.yi@samsung.com>,
        <sh043.lee@samsung.com>, <cw9316.lee@samsung.com>,
        <sh8267.baek@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <20210210045936.7809-1-dh0421.hwang@samsung.com>
Subject: RE: [PATCH] mmc: core: add a power cycle when CMD11 fails
Date:   Thu, 25 Feb 2021 16:43:09 +0900
Message-ID: <000001d70b49$dca136f0$95e3a4d0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGOblsIe7vdZk8c0sfi2jsUpFOvKwL6qeaxquHfBCA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmni5fqHmCwaK1nBYzTrWxWlxc3cJq
        8evvenaLjq2TmSx2PD/DbrHrbzOTxZQ/y5ksLu+aw2Zx5H8/o8WRA44W/avvslk0/dnHYnHt
        zAlWi+Nrwy02X/rGYtF3zt1BwGPBplKPO9f2sHn0bVnF6PFs4XoWj6c/9jJ7fN4kF8AWlWOT
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3S0kkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA0KBArzgxt7g0L10vOT/XytDAwMgUqDIhJ2Pb
        g/3MBd1sFec+PWRrYPzI0sXIySEhYCKx8N9Hti5GLg4hgR2MEq37D7FDOJ8YJbZvm8AE4Xxm
        lNi7/SQbTMvFXRMYQWwhgV2MEqt+qkAUvWaU+Hx1BliCTcBAYvKxN2BzRQQeM0rMmz2ZGcRh
        FrjOKPHz3heguRwcnAK2EtOWZYM0CAs4SVz/3MMKEmYRUJXob8kECfMKWEp0bdvECGELSpyc
        +QTsbmYBeYntb+cwQxykIPHz6TJWEFtEwEpi0eQ97BA1IhKzO9vA1koI3OGQuLTtADtEg4tE
        8879UM3CEq+Ob4GKS0m87G+DsrsZJfoP2UE0T2CUuHy8B+p9Y4lPnz8zghzKLKApsX6XPkRY
        UWLn77mMEIv5JN59hfhFQoBXoqNNCKJETWLxv+9AJexAtoxEI/cERqVZSB6bheSxWUgemIWw
        agEjyypGsdSC4tz01GLDAhPkuN7ECE7PWhY7GOe+/aB3iJGJg/EQowQHs5II7+Z/pglCvCmJ
        lVWpRfnxRaU5qcWHGE2BIT2RWUo0OR+YIfJK4g1NjYyNjS1MzMzNTI2VxHmTDB7ECwmkJ5ak
        ZqemFqQWwfQxcXBKNTBp/d8z6clZ54jAfrvmvLdPmSQLkh036Pt6dnbmtD19vbhw2RyX1wrt
        jzX23PVUe86UYXXz1FE3ly0bVz9jFn4RwtZ39BTnu71TNTSX7ctNt86dN/8a7xYG11aX17NL
        9MSkJt7wSey6eG+GzyJV7t3x7JNZ9u3oneo2Saf0TJKR2/n1DFq+VqzHb+3ayh16kp+V47FF
        xYbc3zM9NoW7zlhc8nKd9lbBeSe3H7DqC5Q4sqK0OOPConzVLU0n15aqn5d79+xl3vcstQ/6
        fipn93oy5Bn9f/BvS2XS745L1WHZi08vjDIUCJ1WxhLgo8rOMTPKxi26XWBt2W72d4fbMm68
        u5/54olh3HR1p59m/dOUWIozEg21mIuKEwHqFZ7YWAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRmVeSWpSXmKPExsWy7bCSnC5vqHmCwfvXYhYzTrWxWlxc3cJq
        8evvenaLjq2TmSx2PD/DbrHrbzOTxZQ/y5ksLu+aw2Zx5H8/o8WRA44W/avvslk0/dnHYnHt
        zAlWi+Nrwy02X/rGYtF3zt1BwGPBplKPO9f2sHn0bVnF6PFs4XoWj6c/9jJ7fN4kF8AWxWWT
        kpqTWZZapG+XwJWx7cF+5oJutopznx6yNTB+ZOli5OSQEDCRuLhrAmMXIxeHkMAORonzS3az
        QSRkJLrv72XvYuQAsoUlDh8uhqh5ySjxcPlpZpAaNgEDicnH3oDViwi8ZpQ4uy0XpIhZ4D6j
        xKJtU9khOvoYJY5+XAw2iVPAVmLasmyQBmEBJ4nrn3tYQcIsAqoS/S2ZIGFeAUuJrm2bGCFs
        QYmTM5+AHcosoC3x9OZTKFteYvvbOcwQdypI/Hy6jBXiBiuJRZP3sEPUiEjM7mxjnsAoPAvJ
        qFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCI1VLawfjnlUf
        9A4xMnEwHmKU4GBWEuHd/M80QYg3JbGyKrUoP76oNCe1+BCjNAeLkjjvha6T8UIC6Yklqdmp
        qQWpRTBZJg5OqQamHaeDi+8YzL0Wr1vunZXltJY/xbku8t+c298v5k4uv81wvm9ppNfRk7Le
        muv0a1RzH7nbnjrvoxJ04lPHt5V7FrfJ7tOYHWP58ZDjsoibey/pnxJoMt1Uuev7pSdnwzUf
        PE48y+J24KXyVJYrr53Zog8s/KBmfHKFV8PhBqXtzVk/bj4tll03/8OVxO/bTE0eRZYeXciT
        s1yxrtRY4oS36vv/FnLH6/RCjK/N02x0nr2hKoN1/aLiyum2CteFGR+vufPn25sv7W9n3zUP
        eyO694RVkpjLaZeWj43OzPLSX1RX2kbJ6af+M7jZahwzKShO3zPeZmsh+09zT7X4axu9O/i4
        ub52H5ixYFeVwVYNJZbijERDLeai4kQAc1wt3kMDAAA=
X-CMS-MailID: 20210225074309epcas1p2ed4a8c8961ca1e78321be678ea2014c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210210051209epcas1p3e55c0cbab7313731bc6e425da6189bb4
References: <CGME20210210051209epcas1p3e55c0cbab7313731bc6e425da6189bb4@epcas1p3.samsung.com>
        <20210210045936.7809-1-dh0421.hwang@samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dear Maintainers and commiters.

Please review this patch for updating.

Thanks and regards.
DooHyun Hwang.

On 17/02/10 4:59 am, DooHyun Hwang wrote:
>Subject: [PATCH] mmc: core: add a power cycle when CMD11 fails
>
>A power cycle is required if CMD11 fails.
>CMD11 failure should be handled as no response.
>
>If there is a timeout error that means no response to the CMD11, do not
>send the CMD11 again and the power cycle is required.
>Any other errors for CMD11 are the same because CMD11 failed.
>
>On some bad SD Card, CMD11 may fail but the card may have already invoked
>the voltage switch sequence.
>In this case, it is necessary to retry without voltage switching after
>power cycle.
>
>Signed-off-by: DooHyun Hwang <dh0421.hwang@samsung.com>

