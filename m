Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39075C433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078DD64F37
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350298AbhCDAAI (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:08 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:14994 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345130AbhCCGbe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 01:31:34 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210303063047epoutp0245d401aa164295cfc1928e376d9136e7~owVdn9gJC0566005660epoutp02O
        for <linux-mmc@vger.kernel.org>; Wed,  3 Mar 2021 06:30:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210303063047epoutp0245d401aa164295cfc1928e376d9136e7~owVdn9gJC0566005660epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614753047;
        bh=py6OZSm/Pq78AmVUxnSD2SACJrpI1MvkqnthLtcfGHM=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=nMXVLEJv0RbdOsLV6ByklrjzNnlTWcjmzOJxELPAapjzVr8fXuvpQ6Z+4waBSdwqF
         /2ZTufDAKhHu3cGYQQ4LM2u0qFtXUw0Lq4XshKm0388usvLrHb2yH/EydY4yXltKf0
         Y4XHcGuQybmI712gSyPbKoqPj7IOVGeU83GdNNYs=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210303063046epcas1p25c2a50a587efdeb400ddad45d713e7ce~owVcf618i1703717037epcas1p2e;
        Wed,  3 Mar 2021 06:30:46 +0000 (GMT)
Received: from epsmges1p4.samsung.com (unknown [182.195.40.163]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Dr3z81Mbtz4x9Q4; Wed,  3 Mar
        2021 06:30:44 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        EA.C0.10463.31D2F306; Wed,  3 Mar 2021 15:30:44 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210303063043epcas1p121cff24fd85543708c95cf6f27bae651~owVZquNDI1371513715epcas1p1d;
        Wed,  3 Mar 2021 06:30:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210303063043epsmtrp1ef95fffe399bacb40f0cecea1fd4b0f7~owVZprELi0466404664epsmtrp1O;
        Wed,  3 Mar 2021 06:30:43 +0000 (GMT)
X-AuditID: b6c32a38-f11ff700000028df-ef-603f2d13395d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.E6.08745.31D2F306; Wed,  3 Mar 2021 15:30:43 +0900 (KST)
Received: from dh0421hwang01 (unknown [10.253.101.58]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210303063043epsmtip2805a70e9bf599cc81afe6fac4d1bcfe0~owVZdReiQ0758707587epsmtip2i;
        Wed,  3 Mar 2021 06:30:43 +0000 (GMT)
From:   "DooHyun Hwang" <dh0421.hwang@samsung.com>
To:     "'Ulf Hansson'" <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>,
        "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
        "'Eric Biggers'" <ebiggers@google.com>,
        "'Wolfram Sang'" <wsa+renesas@sang-engineering.com>,
        "'Satya Tangirala'" <satyat@google.com>,
        "'Ludovic Barre'" <ludovic.barre@st.com>,
        "'Linus Walleij'" <linus.walleij@linaro.org>,
        <grant.jung@samsung.com>, <jt77.jang@samsung.com>,
        <junwoo80.lee@samsung.com>, <jangsub.yi@samsung.com>,
        <sh043.lee@samsung.com>, "'Chanwoo Lee'" <cw9316.lee@samsung.com>,
        <sh8267.baek@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <CAPDyKFpQyoNELdh3FrFF++HXKjH_Tn9oaY=PzUXHcE8o=KK-hg@mail.gmail.com>
Subject: RE: [PATCH] mmc: core: add a power cycle when CMD11 fails
Date:   Wed, 3 Mar 2021 15:30:43 +0900
Message-ID: <01df01d70ff6$bc9dd230$35d97690$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGOblsIe7vdZk8c0sfi2jsUpFOvKwL6qeaxAl7SNUWq2BSgYA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmvq6Irn2CwfobzBYzTrWxWlxc3cJq
        8evvenaLjq2TmSx2PD/DbrHrbzOTxZQ/y5ksLu+aw2Zx5H8/o8WRA44W/avvslk0/dnHYnHt
        zAlWi+Nrwy02X/rGYtF3zt1BwGPBplKPO9f2sHn0bVnF6PFs4XoWj6c/9jJ7fN4kF8AWlWOT
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3S0kkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA0KBArzgxt7g0L10vOT/XytDAwMgUqDIhJ+P7
        ki7mgp+xFRt3PGdtYJzs3cXIySEhYCKx4dc/1i5GLg4hgR2MErs+vmKDcD4xSkyYsIkNpEpI
        4DOjxJZ56TAdrZ82s0DEdzFKPG1wgGh4zSixZs1VsAY2AQOJycfegNkiAjoSM940g61gFljB
        InHx4ENWkASnQKDE8Zc/mEFsYQEnieufe8DiLAIqEt83rmEEsXkFLCW2rtnICmELSpyc+QRs
        M7OAtsSyha+ZIS5SkPj5dBkrxDIniUNX2hkhakQkZne2QdXc4JB4dpoDwnaR6Py8BCouLPHq
        +BZ2CFtK4mV/G5TdzSjRf8gO5GgJgQmMEpeP97BBJIwlPn3+DLSAA2iBpsT6XfoQYUWJnb/n
        Qu3lk3j3FeQXDqA4r0RHmxBEiZrE4n/fgUrYgWwZiUbuCYxKs5D8NQvJX7OQ3D8LYdUCRpZV
        jGKpBcW56anFhgUmyFG9iRGcnLUsdjDOfftB7xAjEwfjIUYJDmYlEV7xl7YJQrwpiZVVqUX5
        8UWlOanFhxhNgSE9kVlKNDkfmB/ySuINTY2MjY0tTMzMzUyNlcR5kwwexAsJpCeWpGanphak
        FsH0MXFwSjUw8Z3dbJg6R/D7/Iy8uEp93d3Pvhu5eWxuXi+5+Jb8q1CtF3u04qoTTQ98tl6w
        Ss3NUck+ULVvgua1qzNzBDIWr7ySNEHnL8fl19352swqhj5Oj53FVznvNPokzDSxM/69wfIu
        ngB7rTUm4StWTRB6w/Dm+uvXH2KDckNnfvm3rZ8/Zit3Uj2DQ3bSlL36f/NCZGbtkplZt97T
        K+Wj+JZ2rbrfvKENfPdWp4bqXH+8jPfdBe83f0qy2k+cSuN9uORq/sIYyfWlLqf49lexfS1w
        LWGaEehiq+htseK20X2ZTawprxx3q5vO+xS3TnZa1czpEwISs+YnWbjr7Dil//ZICvumT3Li
        bnJ3PgbO/memxFKckWioxVxUnAgACncRFlcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSvK6wrn2CwZaVfBYzTrWxWlxc3cJq
        8evvenaLjq2TmSx2PD/DbrHrbzOTxZQ/y5ksLu+aw2Zx5H8/o8WRA44W/avvslk0/dnHYnHt
        zAlWi+Nrwy02X/rGYtF3zt1BwGPBplKPO9f2sHn0bVnF6PFs4XoWj6c/9jJ7fN4kF8AWxWWT
        kpqTWZZapG+XwJWx7mkfU8GViIrzzQ9YGxjfuHYxcnJICJhItH7azNLFyMUhJLCDUeJQywFG
        iISMRPf9vexdjBxAtrDE4cPFEDUvGSVmTHzNAlLDJmAgMfnYGzYQW0RAR2LGm2ZWkCJmgW0s
        Em/ON7FCdFxmlDi37QvYVE6BQInjL38wg9jCAk4S1z/3sILYLAIqEt83rgGr4RWwlNi6ZiMr
        hC0ocXLmE7BtzALaEk9vPoWzly18zQxxqYLEz6fLWCGucJI4dKWdEaJGRGJ2ZxvzBEbhWUhG
        zUIyahaSUbOQtCxgZFnFKJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcrVpaOxj3rPqg
        d4iRiYPxEKMEB7OSCK/4S9sEId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqem
        FqQWwWSZODilGpjU94i3MF3YGFm5x89lzwVdplfVktEn/iX92dzazCc8n+Gjtcj1GHvhuDdf
        Xvxi5r75ceKvKNvKb83vl8VOyGiMYDNYt/vsGcHesLB3Si8iGi+HPuP02v8vnKX49tZfU+Ne
        Hjd17Q4N63nQ935ti/B9D+7He/26r6t7qraFrpNeclF0m5ZSBsu5rTUn1Ho3PftpXmVt/oah
        T2yHlH61uF3K+j3Vv7y0v9SHxaXZv70s0fR6vsQ+V/5tX961vORjWTOpckbo9eCP8bKRF279
        1W+cdbDHgk2IOTuvQqQ34qn+nsNbbVxKZXqusmmF3E51fLPI14pR5ck9RtVgqabw2ibbA27L
        qh713Xp3dvFGIyWW4oxEQy3mouJEAAQS1PxFAwAA
X-CMS-MailID: 20210303063043epcas1p121cff24fd85543708c95cf6f27bae651
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210210051209epcas1p3e55c0cbab7313731bc6e425da6189bb4
References: <CGME20210210051209epcas1p3e55c0cbab7313731bc6e425da6189bb4@epcas1p3.samsung.com>
        <20210210045936.7809-1-dh0421.hwang@samsung.com>
        <CAPDyKFpQyoNELdh3FrFF++HXKjH_Tn9oaY=PzUXHcE8o=KK-hg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 2 Mar 2021 at 10:38, Ulf Hansson <ulf.hansson=40linaro.org> wrote:
>On Wed, 10 Feb 2021 at 06:12, DooHyun Hwang <dh0421.hwang=40samsung.com>
>wrote:
>>
>> A power cycle is required if CMD11 fails.
>> CMD11 failure should be handled as no response.
>>
>> If there is a timeout error that means no response to the CMD11, do
>> not send the CMD11 again and the power cycle is required.
>> Any other errors for CMD11 are the same because CMD11 failed.
>>
>> On some bad SD Card, CMD11 may fail but the card may have already
>> invoked the voltage switch sequence.
>> In this case, it is necessary to retry without voltage switching after
>> power cycle.
>>
>> Signed-off-by: DooHyun Hwang <dh0421.hwang=40samsung.com>
>
>Applied for next, thanks=21
>
>I took the liberty of updating the commit message a bit, to try to clarify
>things. Moreover, I have tagged this for stable kernels.
>
>BTW, did you try to force the error to -EAGAIN, to keep retrying for a
>couple of times? If so, did it end up with the same kind of errors?

Thank you for reviewing this.

Yes. I tested with 2 SD cards.
I think the power cycle is needed before retrying
because SD card doesn't respond SD_ROCR_S18A when retrying without power cy=
cle.


=231. No change
// send ACMD41 + with SD_OCR_S18R (bit=5B24=5D)
<7>=5B  100.852818=5D  =5B0:    kworker/0:0:    5=5D mmc0: starting CMD41 a=
rg 51040000 flags 000000e1
// resp ACMD41 + with SD_ROCR_S18A (bit=5B24=5D)
<7>=5B  100.853177=5D I=5B0:  Binder:4670_3: 4705=5D mmc0: req done (CMD41)=
: 0: c1ff8000 00000000 00000000 00000000
// send CMD11 and error occurs
<7>=5B  100.853288=5D  =5B0:    kworker/0:0:    5=5D mmc0: starting CMD11 a=
rg 00000000 flags 00000015
<7>=5B  100.854009=5D I=5B0:  Binder:4670_3: 4705=5D mmc0: req done (CMD11)=
: -84: 00000000 00000000 00000000 00000000
// clear SD_OCR_S18R
<4>=5B  100.854145=5D  =5B0:    kworker/0:0:    5=5D mmc0: Skipping voltage=
 switch
<7>=5B  100.854179=5D  =5B0:    kworker/0:0:    5=5D mmc0: clock 400000Hz b=
usmode 2 powermode 2 cs 1 Vdd 18 width 1 timing 0
<7>=5B  100.855651=5D  =5B0:    kworker/0:0:    5=5D mmc0: starting CMD0 ar=
g 00000000 flags 000000c0
<7>=5B  100.855868=5D I=5B0:  Binder:4670_3: 4705=5D mmc0: req done (CMD0):=
 0: 00000000 00000000 00000000 00000000
<7>=5B  100.857234=5D  =5B0:    kworker/0:0:    5=5D mmc0: clock 400000Hz b=
usmode 2 powermode 2 cs 0 Vdd 18 width 1 timing 0
<7>=5B  100.858638=5D  =5B0:    kworker/0:0:    5=5D mmc0: starting CMD8 ar=
g 000001aa flags 000002f5
<7>=5B  100.859100=5D I=5B0:  Binder:4670_3: 4705=5D mmc0: req done (CMD8):=
 -84: 00000000 00000000 00000000 00000000
<7>=5B  100.859607=5D  =5B0:    kworker/0:0:    5=5D mmc0: starting CMD55 a=
rg 00000000 flags 000000f5
<7>=5B  100.860098=5D I=5B0:  Binder:4670_3: 4705=5D mmc0: req done (CMD55)=
: -84: 00000000 00000000 00000000 00000000
...
<3>=5B  100.861846=5D  =5B0:    kworker/0:0:    5=5D mmc0: error -84 whilst=
 initialising SD card


=232. I tried to force the error to -EAGAIN(without power cycle), has confi=
rmed
     that the normal operation but card responded without SD_ROCR_S18A from=
 ACMD41
     So, Voltage Switching was skipped and the SD card initialized to HS mo=
de.
// send ACMD41 + with SD_OCR_S18R (bit=5B24=5D)
<7>=5B  117.525089=5D  =5B0:    kworker/0:2:  375=5D mmc0: starting CMD41 a=
rg 51040000 flags 000000e1
// resp ACMD41 + with SD_ROCR_S18A (bit=5B24=5D)
<7>=5B  117.525438=5D I=5B0:id.app.reminder: 8908=5D mmc0: req done (CMD41)=
: 0: c1ff8000 00000000 00000000 00000000
// send CMD11 and complete
<7>=5B  117.525505=5D  =5B0:    kworker/0:2:  375=5D mmc0: starting CMD11 a=
rg 00000000 flags 00000015
<7>=5B  117.525866=5D I=5B0:id.app.reminder: 8908=5D mmc0: req done (CMD11)=
: 0: 00000320 00000000 00000000 00000000
<7>=5B  117.527296=5D  =5B0:    kworker/0:2:  375=5D mmc0: clock 0Hz busmod=
e 2 powermode 2 cs 0 Vdd 18 width 1 timing 0
<7>=5B  117.540116=5D  =5B0:    kworker/0:2:  375=5D mmc0: clock 400000Hz b=
usmode 2 powermode 2 cs 0 Vdd 18 width 1 timing 0
// set -EAGAIN
<3>=5B  117.541650=5D  =5B0:    kworker/0:2:  375=5D mmc_sd_get_cid: rocr=
=3D0xc1ff8000, retries=3D10. err=3D0 -> -11.
// retry without power cycle
<7>=5B  117.541683=5D  =5B0:    kworker/0:2:  375=5D mmc0: clock 400000Hz b=
usmode 2 powermode 2 cs 1 Vdd 18 width 1 timing 0
<7>=5B  117.543106=5D  =5B0:    kworker/0:2:  375=5D mmc0: starting CMD0 ar=
g 00000000 flags 000000c0
<7>=5B  117.543323=5D I=5B0:id.app.reminder: 8908=5D mmc0: req done (CMD0):=
 0: 00000000 00000000 00000000 00000000
<7>=5B  117.544679=5D  =5B0:    kworker/0:2:  375=5D mmc0: clock 400000Hz b=
usmode 2 powermode 2 cs 0 Vdd 18 width 1 timing 0
<7>=5B  117.546131=5D  =5B0:    kworker/0:2:  375=5D mmc0: starting CMD8 ar=
g 000001aa flags 000002f5
<7>=5B  117.546484=5D I=5B0:id.app.reminder: 8908=5D mmc0: req done (CMD8):=
 0: 000001aa 00000000 00000000 00000000
// send ACMD41 + with SD_OCR_S18R (bit=5B24=5D)
<7>=5B  117.559967=5D  =5B0:    kworker/0:2:  375=5D mmc0: starting CMD55 a=
rg 00000000 flags 000000f5
<7>=5B  117.560445=5D I=5B0:    ksoftirqd/0:   10=5D mmc0: req done (CMD55)=
: 0: 00000120 00000000 00000000 00000000
<7>=5B  117.560505=5D  =5B0:    kworker/0:2:  375=5D mmc0: starting CMD41 a=
rg 51040000 flags 000000e1
// resp ACMD41 + without SD_ROCR_S18A (bit=5B24=5D)
<7>=5B  117.560853=5D I=5B0:Runtime worker : 8942=5D mmc0: req done (CMD41)=
: 0: c0ff8000 00000000 00000000 00000000
<7>=5B  117.562093=5D  =5B0:    kworker/0:2:  375=5D mmc0: starting CMD2 ar=
g 00000000 flags 00000007


=233. Forced set error of CMD11 and the SD card initialized to HS mode.
// send ACMD41 + with SD_OCR_S18R (bit=5B24=5D)
<7>=5B  115.040643=5D  =5B0:    kworker/0:2:  690=5D mmc0: starting CMD41 a=
rg 51040000 flags 000000e1
// resp ACMD41 + with SD_ROCR_S18A (bit=5B24=5D)
<7>=5B  115.040990=5D I=5B0:Jit thread pool: 8904=5D mmc0: req done (CMD41)=
: 0: c1ff8000 00000000 00000000 00000000
// send CMD11 and error occurs
<7>=5B  115.041092=5D  =5B0:    kworker/0:2:  690=5D mmc0: starting CMD11 a=
rg 00000000 flags 00000015
<7>=5B  115.041789=5D I=5B0:Jit thread pool: 8904=5D mmc0: req done (CMD11)=
: -84: 00000000 00000000 00000000 00000000
// retry with power cycle (tested with this patch)
<7>=5B  115.041855=5D  =5B0:    kworker/0:2:  690=5D mmc0: Signal voltage s=
witch failed, power cycling card
<7>=5B  115.041898=5D  =5B0:    kworker/0:2:  690=5D mmc0: clock 0Hz busmod=
e 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
<7>=5B  115.045922=5D  =5B0:    kworker/0:2:  690=5D mmc0: clock 0Hz busmod=
e 2 powermode 1 cs 0 Vdd 18 width 1 timing 0
<7>=5B  115.064130=5D  =5B0:    kworker/0:2:  690=5D mmc0: clock 400000Hz b=
usmode 2 powermode 2 cs 0 Vdd 18 width 1 timing 0
// return error and retry after (retries =3D 0;)
<3>=5B  115.076912=5D  =5B0:    kworker/0:2:  690=5D mmc_sd_get_cid: rocr=
=3D0xc1ff8000, retries=3D10. err=3D-84.
// clear SD_OCR_S18R
<4>=5B  115.076943=5D  =5B0:    kworker/0:2:  690=5D mmc0: Skipping voltage=
 switch
<7>=5B  115.076973=5D  =5B0:    kworker/0:2:  690=5D mmc0: clock 400000Hz b=
usmode 2 powermode 2 cs 1 Vdd 18 width 1 timing 0
<7>=5B  115.078375=5D  =5B0:    kworker/0:2:  690=5D mmc0: starting CMD0 ar=
g 00000000 flags 000000c0
<7>=5B  115.078617=5D I=5B0:      swapper/0:    0=5D mmc0: req done (CMD0):=
 0: 00000000 00000000 00000000 00000000
<7>=5B  115.079980=5D  =5B0:    kworker/0:2:  690=5D mmc0: clock 400000Hz b=
usmode 2 powermode 2 cs 0 Vdd 18 width 1 timing 0
<7>=5B  115.081506=5D  =5B0:    kworker/0:2:  690=5D mmc0: starting CMD8 ar=
g 000001aa flags 000002f5
<7>=5B  115.081868=5D I=5B0:      swapper/0:    0=5D mmc0: req done (CMD8):=
 0: 000001aa 00000000 00000000 00000000
// send ACMD41 + without SD_OCR_S18R (bit=5B24=5D)
<7>=5B  115.190656=5D  =5B0:    kworker/0:2:  690=5D mmc0: starting CMD55 a=
rg 00000000 flags 000000f5
<7>=5B  115.191046=5D I=5B0:Jit thread pool: 4475=5D mmc0: req done (CMD55)=
: 0: 00000120 00000000 00000000 00000000
<7>=5B  115.191113=5D  =5B0:    kworker/0:2:  690=5D mmc0: starting CMD41 a=
rg 50040000 flags 000000e1
// resp ACMD41 + without SD_ROCR_S18A (bit=5B24=5D)
<7>=5B  115.191474=5D I=5B0:Jit thread pool: 4475=5D mmc0: req done (CMD41)=
: 0: c0ff8000 00000000 00000000 00000000
<7>=5B  115.191541=5D  =5B0:    kworker/0:2:  690=5D mmc0: starting CMD2 ar=
g 00000000 flags 00000007


=234. SD card responded with SD_ROCR_S18A from ACMD41 after power cycle, an=
d change CMD11's error value to -EAGAIN
// send ACMD41 + with SD_OCR_S18R (bit=5B24=5D)
<7>=5B  156.884623=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD41 a=
rg 51040000 flags 000000e1
// resp ACMD41 + with SD_ROCR_S18A (bit=5B24=5D)
<7>=5B  156.884975=5D I=5B0:    highpool=5B3=5D: 5440=5D mmc0: req done (CM=
D41): 0: c1ff8000 00000000 00000000 00000000
// send CMD11 and error occurs
<7>=5B  156.885051=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD11 a=
rg 00000000 flags 00000015
<7>=5B  156.885759=5D I=5B0:    highpool=5B3=5D: 5440=5D mmc0: req done (CM=
D11): -84: 00000000 00000000 00000000 00000000
// retry with power cycle (tested with this patch)
<7>=5B  156.885834=5D  =5B0:    kworker/0:1:    7=5D mmc0: Signal voltage s=
witch failed, power cycling card
<7>=5B  156.885875=5D  =5B0:    kworker/0:1:    7=5D mmc0: clock 0Hz busmod=
e 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
<7>=5B  156.920185=5D  =5B0:    kworker/0:1:    7=5D mmc0: clock 400000Hz b=
usmode 2 powermode 2 cs 0 Vdd 18 width 1 timing 0
// change CMD11's error value to -EAGAIN
<3>=5B  156.932288=5D  =5B0:    kworker/0:1:    7=5D mmc_sd_get_cid: rocr=
=3D0xc1ff8000, retries=3D10. err=3D-84 -> -11.
<7>=5B  156.932336=5D  =5B0:    kworker/0:1:    7=5D mmc0: clock 400000Hz b=
usmode 2 powermode 2 cs 1 Vdd 18 width 1 timing 0
<7>=5B  156.933834=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD0 ar=
g 00000000 flags 000000c0
<7>=5B  156.934101=5D I=5B0:ung.android.mdx:10229=5D mmc0: req done (CMD0):=
 0: 00000000 00000000 00000000 00000000
<7>=5B  156.935562=5D  =5B0:    kworker/0:1:    7=5D mmc0: clock 400000Hz b=
usmode 2 powermode 2 cs 0 Vdd 18 width 1 timing 0
<7>=5B  156.937009=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD8 ar=
g 000001aa flags 000002f5
<7>=5B  156.937372=5D I=5B0:ung.android.mdx:10229=5D mmc0: req done (CMD8):=
 0: 000001aa 00000000 00000000 00000000
// send ACMD41 + with SD_OCR_S18R (bit=5B24=5D)
<7>=5B  157.044190=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD55 a=
rg 00000000 flags 000000f5
<7>=5B  157.044924=5D I=5B0:ung.android.mdx:10229=5D mmc0: req done (CMD55)=
: 0: 00000120 00000000 00000000 00000000
<7>=5B  157.045023=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD41 a=
rg 51040000 flags 000000e1
// resp ACMD41 + with SD_ROCR_S18A (bit=5B24=5D)
<7>=5B  157.045389=5D I=5B0:ung.android.mdx:10229=5D mmc0: req done (CMD41)=
: 0: c1ff8000 00000000 00000000 00000000
// send CMD11 and complete
<7>=5B  157.045467=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD11 a=
rg 00000000 flags 00000015
<7>=5B  157.045855=5D I=5B0:   Binder:798_2:  805=5D mmc0: req done (CMD11)=
: 0: 00000320 00000000 00000000 00000000


>
>> ---
>>  drivers/mmc/core/core.c =7C 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
>> 1136b859ddd8..a6674df2a7bb 100644
>> --- a/drivers/mmc/core/core.c
>> +++ b/drivers/mmc/core/core.c
>> =40=40 -1207,7 +1207,7 =40=40 int mmc_set_uhs_voltage(struct mmc_host *h=
ost,
>> u32 ocr)
>>
>>         err =3D mmc_wait_for_cmd(host, &cmd, 0);
>>         if (err)
>> -               return err;
>> +               goto power_cycle;
>>
>>         if (=21mmc_host_is_spi(host) && (cmd.resp=5B0=5D & R1_ERROR))
>>                 return -EIO;
>> --
>> 2.29.0
>>
>
>Kind regards
>Uffe

Thanks and regards.
DooHyun Hwang.

