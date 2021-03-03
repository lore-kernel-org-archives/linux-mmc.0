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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB9A9C43381
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8219164FC2
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbhCDAAJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:09 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:27790 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347057AbhCCGkm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 01:40:42 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210303063956epoutp0324328c1a65433259b32a3a0437a2365c~owdcgLM6K2699726997epoutp03S
        for <linux-mmc@vger.kernel.org>; Wed,  3 Mar 2021 06:39:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210303063956epoutp0324328c1a65433259b32a3a0437a2365c~owdcgLM6K2699726997epoutp03S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614753596;
        bh=57jiLkfedtl+CGz1CoJrxuyPN0UuFnJN95hA3tTJLwg=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Ks2gxdEc72EaFxdHbA6E+wLETBU6fqbpA/qcl8hvUgbacb4r56bES/xb3Z4UdEC9u
         k0/HW9eli6NWL8pqKAEWqrf1e1/4mUuUiEo+q52jXxxK4e/wCiOl7qpe9EWVuiaYK4
         nYs6Y0TvGvzYSTwXLEzdoa8S+BC8GAAVZELHC+uk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210303063954epcas1p48b590cc24c0eb4e5a362a3397bc7b685~owdbV6HQ12656326563epcas1p4b;
        Wed,  3 Mar 2021 06:39:54 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.160]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Dr49j6Yk6z4x9Q6; Wed,  3 Mar
        2021 06:39:53 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        E1.4F.09577.93F2F306; Wed,  3 Mar 2021 15:39:53 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20210303063948epcas1p1a0c125f1a4a566b89db149f99035f510~owdVuTYE31790117901epcas1p1X;
        Wed,  3 Mar 2021 06:39:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210303063948epsmtrp1baae28799858de9824d1688f9ddabfe2~owdVtC-ho0860808608epsmtrp1v;
        Wed,  3 Mar 2021 06:39:48 +0000 (GMT)
X-AuditID: b6c32a39-c13ff70000002569-d0-603f2f39af47
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        51.18.08745.43F2F306; Wed,  3 Mar 2021 15:39:48 +0900 (KST)
Received: from dh0421hwang01 (unknown [10.253.101.58]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210303063948epsmtip12e7eaf917729413715f6dc8f89820d34~owdVbuV6U0921109211epsmtip1D;
        Wed,  3 Mar 2021 06:39:48 +0000 (GMT)
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
Date:   Wed, 3 Mar 2021 15:39:48 +0900
Message-ID: <021a01d70ff8$01ba94b0$052fbe10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGOblsIe7vdZk8c0sfi2jsUpFOvKwL6qeaxAl7SNUWq2EbE4A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOJsWRmVeSWpSXmKPExsWy7bCmvq6lvn2CwZc7hhYzTrWxWlxc3cJq
        8evvenaLjq2TmSx2PD/DbrHrbzOTxZQ/y5ksLu+aw2Zx5H8/o8WRA44W/avvslk0/dnHYnHt
        zAlWi+Nrwy02X/rGYtF3zt1BwGPBplKPO9f2sHn0bVnF6PFs4XoWj6c/9jJ7fN4kF8AWlWOT
        kZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA3S0kkJZYk4p
        UCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafA0KBArzgxt7g0L10vOT/XytDAwMgUqDIhJ2PW
        /6VMBd9jK34f3szUwDjZu4uRk0NCwESi+1AvexcjF4eQwA5GicaFX1ggnE+MEjMPToLKfGaU
        OHn+IxNMy9nre1ghErsYJaZcPQxV9ZpRYuGkfmaQKjYBA4nJx96wgdgiAjoSM940g3UwC6xg
        kbh48CErSIJTIFDi+MsfYA3CAk4S1z/3gMVZBFQkdj0/CbaOV8BSYumcjWwQtqDEyZlPWEBs
        ZgFtiWULXzNDnKQg8fPpMlaIZU4SXc/vMULUiEjM7mxjBlksIXCHQ+JQ/2KoBheJ5/f2sUPY
        whKvjm+BsqUkXva3QdndjBL9h+wgmicwSlw+3sMGkTCW+PT5M9AGDqANmhLrd+lDhBUldv6e
        C7WYT+LdV5BnOIDivBIdbUIQJWoSi/99ByphB7JlJBq5JzAqzULy2Cwkj81C8sAshFULGFlW
        MYqlFhTnpqcWGxaYIsf2JkZwitay3ME4/e0HvUOMTByMhxglOJiVRHjFX9omCPGmJFZWpRbl
        xxeV5qQWH2I0BQb1RGYp0eR8YJbIK4k3NDUyNja2MDEzNzM1VhLnTTJ4EC8kkJ5YkpqdmlqQ
        WgTTx8TBKdXAFFGgvkoy6+yEr0FC9WFuqZ3Cb9N+m4fOvsZhrfOePdR+28msa9dXFBbFv4r/
        pPv1RwRrAl/8wqutj8r/HFt/ZA9jQfk8B1GBfyp/vjFceCgoZF+nyaoY8+LoxvBvu2dt3H9R
        Q8Fj92Zur9y2jMRdk3f84/di3D+53LSm7HKs39fwtflbOTyW9OqaxyzKPORdKrdic9ib/M9u
        uh9fX5i5ZmvhTR2VgPdFBtr5JxTlbCZ0VnpmnDcxt9peU+kTm1dW3fzldZPT/e2G0vtPXPrC
        0x5wZ1L5lvXO3Re3dt1Kcbsem3tcydFUkOeMjuDd+vQ7mWI3svU8PlRsjVvxZU/08byECTcm
        iN8Q1txrmJ6kxFKckWioxVxUnAgAj+2OpFoEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIIsWRmVeSWpSXmKPExsWy7bCSnK6Jvn2CwcU/mhYzTrWxWlxc3cJq
        8evvenaLjq2TmSx2PD/DbrHrbzOTxZQ/y5ksLu+aw2Zx5H8/o8WRA44W/avvslk0/dnHYnHt
        zAlWi+Nrwy02X/rGYtF3zt1BwGPBplKPO9f2sHn0bVnF6PFs4XoWj6c/9jJ7fN4kF8AWxWWT
        kpqTWZZapG+XwJWxrekXY8GliIqjXy6yNTC+ce1i5OSQEDCROHt9D2sXIxeHkMAORokZp1Yz
        QSRkJLrv72XvYuQAsoUlDh8uBgkLCbxklNjVqQ5iswkYSEw+9oYNxBYR0JGY8aYZbA6zwDYW
        iTfnm6CGXmaUOLftCyNIFadAoMTxlz+YQWxhASeJ6597WEFsFgEViV3PT4It5hWwlFg6ZyMb
        hC0ocXLmExYQm1lAW+Lpzadw9rKFr5khDlWQ+Pl0GSvEFU4SXc/vMULUiEjM7mxjnsAoPAvJ
        qFlIRs1CMmoWkpYFjCyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCY1VLawfjnlUf
        9A4xMnEwHmKU4GBWEuEVf2mbIMSbklhZlVqUH19UmpNafIhRmoNFSZz3QtfJeCGB9MSS1OzU
        1ILUIpgsEwenVAMTj3R+/KlVIRe+Bt2aV/z38KopizqfrNtx0kj+6vS9X3IjnmX3r9nSpr3q
        hsiKmTUX3uw3cTL+2rNRrsqxZd1kD5OZmupzwgRzJDL11Y28Jx+wS7F0eypizBas9Pmsm/gC
        IYOjsflt53sSSovbnkwSEnW16Ihd4b33PZ+N+5y21U8vmBdv0fotuFOI+U+TIvejk3z6d569
        8l9aIXq+9dDX84f23TNvsSy/caP+3fVsY2kpQ1OJXD3Lyy0e4WU92WH+pdYabLpPFshz3ns+
        h2PPeisj64pW6Ux+6/LcZe86l9oobajfsaNvUWfDR9+yr1kvOWVrzCU+rTieseSXttx3HSUN
        xtNPO65Nk9iXKajEUpyRaKjFXFScCAAvJB2ERAMAAA==
X-CMS-MailID: 20210303063948epcas1p1a0c125f1a4a566b89db149f99035f510
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
>

Thank you for reviewing this.

Yes. I tested with 2 SD cards.
I think the power cycle is needed before retrying because SD card doesn't r=
espond SD_ROCR_S18A when retrying without power cycle.


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
: -84: 00000000 00000000 00000000 00000000 ...
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

