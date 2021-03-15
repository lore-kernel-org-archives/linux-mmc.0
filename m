Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F48C433E6
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 05:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD3F864E46
	for <linux-mmc@archiver.kernel.org>; Mon, 15 Mar 2021 05:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhCOFqr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 15 Mar 2021 01:46:47 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21706 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbhCOFqS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 15 Mar 2021 01:46:18 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210315054616epoutp03f717d6a0f5815e0860eafad4bebb2575~sbeBQG77I3058230582epoutp03W
        for <linux-mmc@vger.kernel.org>; Mon, 15 Mar 2021 05:46:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210315054616epoutp03f717d6a0f5815e0860eafad4bebb2575~sbeBQG77I3058230582epoutp03W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615787176;
        bh=5a8senQIad2AcmO85iXKhaoBvwt/JWlwQ2xkMibQi/c=;
        h=From:To:In-Reply-To:Subject:Date:References:From;
        b=lnCqTfLBlBclDENUUYhxPkmNA9HN5sD7MnAQbIb+Xkbz2fUIcvBZNfXafAhbFNFzo
         4U8pw7E2w8udhuJ5ZK5HYYDPmjnoZLR/nDlCiHAVWB8L8CaMI8g4vI/5PLn3fK4P6p
         LL9woQSDejlxP1LaFQJFhC8f7+FmM0qLOaQSh7UM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20210315054616epcas2p12492edf948c402cd73c4cc48a32a6692~sbeBBAg-01313313133epcas2p1T;
        Mon, 15 Mar 2021 05:46:16 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.184]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4DzQQG1vFZz4x9QG; Mon, 15 Mar
        2021 05:46:14 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        B2.1B.56312.3A4FE406; Mon, 15 Mar 2021 14:46:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20210315054611epcas2p32ffe428ca723fe7b33c39b3a2c6fd31e~sbd8tBt-Y1556215562epcas2p37;
        Mon, 15 Mar 2021 05:46:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210315054611epsmtrp2858bc308b0437511a1eb916857cb79e5~sbd8sc_Ca1114011140epsmtrp21;
        Mon, 15 Mar 2021 05:46:11 +0000 (GMT)
X-AuditID: b6c32a46-1d9ff7000000dbf8-87-604ef4a31f40
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9D.20.13470.3A4FE406; Mon, 15 Mar 2021 14:46:11 +0900 (KST)
Received: from KORCO011456 (unknown [12.36.185.54]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210315054611epsmtip214611305e04966c1b316b9c450867266~sbd8jELBm0697106971epsmtip2C;
        Mon, 15 Mar 2021 05:46:11 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Ulf Hansson'" <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>
In-Reply-To: <20210310152900.149380-1-ulf.hansson@linaro.org>
Subject: RE: [PATCH] mmc: core: Fix hanging on I/O during system suspend for
 removable cards
Date:   Mon, 15 Mar 2021 14:46:11 +0900
Message-ID: <000001d7195e$8122ca00$83685e00$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHdOhUB196LQ3U1VfE+AnKrSxL4AwI5OEDFqmZ1IPA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmhe7iL34JBltv2Vgc+d/PaHF8bbgD
        k8eda3vYPD5vkgtgisqxyUhNTEktUkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVV
        cvEJ0HXLzAGarqRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVUotSMkpMDQs0CtOzC0uzUvX
        S87PtTI0MDAyBapMyMm42Oxb8JW/4sHTJ6wNjA95uhg5OSQETCSm33zF3sXIxSEksINR4tqp
        RiYI5xOjxJf+p6wQzjdGiYWLTrPCtCxcsAeqai+jxKbdP5lBEkICLxglbn5SA7HZBLQlpj3c
        DdYgIuAp0fP5A5jNKWArsWDnNrB6YYE4iTUb9rCA2CwCqhKf381kB7F5BSwluja+YoSwBSVO
        znwCVsMsYCSxZPV8JghbXmL72znMEAcpSPx8ugxql5XEpMm7oGpEJGZ3tjGDHCohcIxdondR
        N9AgDiDHReL6XHWIXmGJV8e3sEPYUkA37GWDsOsl9k1tYIXo7WGUeLrvHyNEwlhi1rN2Rog5
        yhJHbkHdxifRcfgvO0SYV6KjTQiiWlni16TJUJ2SEjNv3oFa5SHxYPZzpgmMirOQfDkLyZez
        kHw5C8k3CxhZVjGKpRYU56anFhsVGCFH9iZGcMrTctvBOOXtB71DjEwcjIcYJTiYlUR4P+v4
        JgjxpiRWVqUW5ccXleakFh9iNAUG/ERmKdHkfGDSzSuJNzQ1MjMzsDS1MDUzslAS5y02eBAv
        JJCeWJKanZpakFoE08fEwSnVwHTgw+a9if4XLULbTnP8KBHePIc/PzR2alXgnV3rOJaoFvYY
        MYq/2JDrY7j0YKX/WtEKDfEXXwoNrJ4FyVrOuvD7XtU8BWGn5Z2BT4W40vaWBuXdCvrvHMas
        zNiuzHP2q+c+xvU2EVP9GZ2Dd/Hl1iax1+yqZV148LXjGn/BtW9nrt+68963FV//GVfmdKXe
        TtLwemrpNNNaxbPn1Dqg83qcois0lovmzdZ1tirsjddlTXbRP9Fd9VUqrfx21sPVF+b0L5Wc
        7Z3G981n2Sdxx2WTvurMrrBey/51t1uSTNGrj3tut2t3yGvNTzi38vbmm8Yp6fVGWZUiaddv
        qvmze7dEH3TQ0VGKNzqum6PEUpyRaKjFXFScCAAsGRdGAgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWy7bCSvO7iL34JBm3bFC2O/O9ntDi+NtyB
        yePOtT1sHp83yQUwRXHZpKTmZJalFunbJXBlXGz2LfjKX/Hg6RPWBsaHPF2MnBwSAiYSCxfs
        Yepi5OIQEtjNKPHx1GJ2iISkxImdzxkhbGGJ+y1HWCGKnjFKXH56khkkwSagLTHt4W5WEFtE
        wFti1vVVYM1CAn2MEhe/OoDYnAK2Egt2bgOrFxaIkXh19hvYUBYBVYnP72aC1fMKWEp0bXzF
        CGELSpyc+YQFxGYGuq7xcDeULS+x/e0cZoiDFCR+Pl0GtddKYtLkXUwQNSISszvbmCcwCs1C
        MmoWklGzkIyahaRlASPLKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4BDX0tzBuH3V
        B71DjEwcjIcYJTiYlUR4P+v4JgjxpiRWVqUW5ccXleakFh9ilOZgURLnvdB1Ml5IID2xJDU7
        NbUgtQgmy8TBKdXAVFjKf0hZ/Fnw3i2epySDtsYmHd2pPTFxdun8n6dvXJ0lFL3cNqklYcUk
        V2fdHNH/Gx7bG72PrEi4z9Vzr5L174/558QU6t5atrpJWdTNucNgsXjB6aMak+df3Tu17vIS
        u4tcDTo3Pws5KJ7c3zXNskTLgT1aWPfqfO4Hrrbz2/oYOKrXvPhjfaFntqhi6Nn0yTMSm1d/
        Dy7yec/Ye37hg/9/+urKSkoYjLe+vaBxn9Wt9uOlvrWF115dcrBy6jIU2P9j6rG75uZTXzjc
        Zl2iZOAUvM1m8gWhWb0n00yspT9lbl0mcujPXsZyr+OO10w/1IhOm8UlpbYmlZvFWUn5x9m9
        1UIyJwUanS62djFZKrEUZyQaajEXFScCACI0zfLgAgAA
X-CMS-MailID: 20210315054611epcas2p32ffe428ca723fe7b33c39b3a2c6fd31e
X-Msg-Generator: CA
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210310152931epcas2p1be7719eeaca8d14bf7a8244ff389bd39
References: <CGME20210310152931epcas2p1be7719eeaca8d14bf7a8244ff389bd39@epcas2p1.samsung.com>
        <20210310152900.149380-1-ulf.hansson@linaro.org>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> The mmc core uses a PM notifier to temporarily during system suspend, turn
> off the card detection mechanism for removal/insertion of (e)MMC/SD/SDIO
> cards. Additionally, the notifier may be used to remove an SDIO card
> entirely, if a corresponding SDIO functional driver don't have the system
> suspend/resume callbacks assigned. This behaviour has been around for a
> very long time.
> 
> However, a recent bug report tells us there are problems with this
> approach. More precisely, when receiving the PM_SUSPEND_PREPARE
> notification, we may end up hanging on I/O to be completed, thus also
> preventing the system from getting suspended.
> 
> In the end what happens, is that the cancel_delayed_work_sync() in
> mmc_pm_notify() ends up waiting for mmc_rescan() to complete - and since
> mmc_rescan() wants to claim the host, it needs to wait for the I/O to be
> completed first.
> 
> Typically, this problem is triggered in Android, if there is ongoing I/O
> while the user decides to suspend, resume and then suspend the system
> again. This due to that after the resume, an mmc_rescan() work gets punted
> to the workqueue, which job is to verify that the card remains inserted
> after the system has resumed.
> 
> To fix this problem, userspace needs to become frozen to suspend the I/O,
> prior to turning off the card detection mechanism. Therefore, let's drop
> the PM notifiers for mmc subsystem altogether and rely on the card
> detection to be turned off/on as a part of the system_freezable_wq, that
> we are already using.
> 
Dear Ulf

Do you think there is no possibility that claiming a host by mmc_rescan is
postponed by early IO requests?
E.g. the case where the work is executed later unexpectedly for something.

And it seems that cancelling the work before system suspend is removed in
the patch.
That means you might think there is no case with the pended the work, I
think.
Am I right?

If I mis-understand something, please let me know.

Thanks.
Kiwoong Kim

