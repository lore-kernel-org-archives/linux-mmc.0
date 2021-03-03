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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770F0C4332E
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5436464F69
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237425AbhCDAAS (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:18 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:58361 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbhCCLjH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 06:39:07 -0500
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210303112929epoutp028aee6ddb69cf901388e8597e74ddd291~o0aQzy5Xk0356603566epoutp02M
        for <linux-mmc@vger.kernel.org>; Wed,  3 Mar 2021 11:29:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210303112929epoutp028aee6ddb69cf901388e8597e74ddd291~o0aQzy5Xk0356603566epoutp02M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614770969;
        bh=bUl1+uVfQC4XP89npXE5Ju5REsqBOBfuSMlfaE1uymo=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=pba3LC3UzRsjsUZdQ0gPM806zvslAf5GS35t4ircrj00LKTSqCyIAqnrkhC+xphx2
         c8keMeqe+SU/YFzXacuCXprSajiHtR9l6vPBn0xAfqOVrX4aB8m7Gz6cBQE+rXVLDJ
         iENcoBdluFU/LWW0p2KCnGZWWN1A3q3GDnV8ZrGk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210303112928epcas1p200ddfcf6d46fbd8579055710d8c3ca12~o0aPa5h9a0837008370epcas1p21;
        Wed,  3 Mar 2021 11:29:28 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.162]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DrBbq0xVsz4x9Q6; Wed,  3 Mar
        2021 11:29:27 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.4F.02418.6137F306; Wed,  3 Mar 2021 20:29:26 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210303112925epcas1p4084fb65bfe0de4e69074a3ee1335d3fc~o0aNOw7Ep2128621286epcas1p41;
        Wed,  3 Mar 2021 11:29:25 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210303112925epsmtrp1828ac9f02da5a4b3d322719a929e3072~o0aNNFy3B1404814048epsmtrp1E;
        Wed,  3 Mar 2021 11:29:25 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-7a-603f731600eb
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.1C.08745.5137F306; Wed,  3 Mar 2021 20:29:25 +0900 (KST)
Received: from dh0421hwang01 (unknown [10.253.101.58]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210303112925epsmtip171554200f6731f2c6292b6507f495c57~o0aM4S5z91382813828epsmtip1_;
        Wed,  3 Mar 2021 11:29:25 +0000 (GMT)
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
        "'Seunghui Lee'" <sh043.lee@samsung.com>,
        "'Chanwoo Lee'" <cw9316.lee@samsung.com>,
        <sh8267.baek@samsung.com>, <wkon.kim@samsung.com>
In-Reply-To: <CAPDyKFpVjxKziPmyF+MXG--LKNSVOYaCUuaNBHCzMGCvSzE--Q@mail.gmail.com>
Subject: RE: [PATCH] mmc: core: add a power cycle when CMD11 fails
Date:   Wed, 3 Mar 2021 20:29:25 +0900
Message-ID: <031201d71020$772329b0$65697d10$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGOblsIe7vdZk8c0sfi2jsUpFOvKwL6qeaxAl7SNUUBZtqE2gK+AWJ/qrds8GA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGJsWRmVeSWpSXmKPExsWy7bCmnq54sX2Cwatsixmn2lgtLq5uYbX4
        9Xc9u0XH1slMFjuen2G32PW3mcliyp/lTBaXd81hszjyv5/R4sgBR4v+1XfZLJr+7GOxuHbm
        BKvF8bXhFpsvfWOx6Dvn7iDgsWBTqceda3vYPPq2rGL0eLZwPYvH0x97mT0+b5ILYIvKsclI
        TUxJLVJIzUvOT8nMS7dV8g6Od443NTMw1DW0tDBXUshLzE21VXLxCdB1y8wBullJoSwxpxQo
        FJBYXKykb2dTlF9akqqQkV9cYquUWpCSU2BoUKBXnJhbXJqXrpecn2tlaGBgZApUmZCT8Xjp
        dPaCL7oVmxo6WRsYu1W6GDk5JARMJN6teM7WxcjFISSwg1Gi6dpaZgjnE6PEp5abUJnPjBId
        l8+ww7S8OP4FKrGLUWLt8x5GCOc1o8Te218YQarYBAwkJh97wwZiiwjoSMx408wKUsQssJtF
        YsfuLWBFnAKBEnN+ngCzhQWcJK5/7mEFsVkEVCRWvp8Oto5XwFJiX/d/ZghbUOLkzCcsIDaz
        gLbEsoWvmSFOUpD4+XQZK8QyP4nXs2FqRCRmd7aBPSQhcINDYtvJXqgGF4nuBxeYIGxhiVfH
        t0D9JiXxsr8Nyu5mlOg/ZAfRPIFR4vLxHjaIhLHEp8+fga7mANqgKbF+lz5EWFFi5++5jBCL
        +STefQV5hgMozivR0SYEUaImsfjfd6ASdiBbRqKRewKj0iwkj81C8tgsJA/MQli1gJFlFaNY
        akFxbnpqsWGBIXJsb2IEJ2gt0x2ME99+0DvEyMTBeIhRgoNZSYRX/KVtghBvSmJlVWpRfnxR
        aU5q8SFGU2BQT2SWEk3OB+aIvJJ4Q1MjY2NjCxMzczNTYyVx3iSDB/FCAumJJanZqakFqUUw
        fUwcnFINTHkWze89tl22uhPeu2J6T4dDvogCv1GMvqZwzNRXx9ct/1R4QOji6VeWsblOxSJv
        bRgabX4pewYXXNb7ev3HHya1q2q+5QU/MxbxnF5SemGy6Mwk4U+2U8Snzbg444lxAfuU66a/
        lzpxHZ4WPrPHcV9evU9FddC6zoNu+08ozuq/37RCeYtJ+EIBGcVMvcXCUl1zpFfsLr4ezGwl
        yBJxR1P11z+RBbklXw3VxJmqP992Xlg8i+tp+PUsqcK7F047n0qaP1uxuyu0gM3lM2/0M8sE
        5ncOUqxaUy6vM7D7JsKzoMokbblWt6IBR12MRuYXvo7QxRpOE5ad/dxxp8tjjv7ym7e9/Uti
        vWL45XmVWIozEg21mIuKEwHZDr55WQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsWy7bCSnK5osX2CwYZLChYzTrWxWlxc3cJq
        8evvenaLjq2TmSx2PD/DbrHrbzOTxZQ/y5ksLu+aw2Zx5H8/o8WRA44W/avvslk0/dnHYnHt
        zAlWi+Nrwy02X/rGYtF3zt1BwGPBplKPO9f2sHn0bVnF6PFs4XoWj6c/9jJ7fN4kF8AWxWWT
        kpqTWZZapG+XwJXxet9XpoJenYon8/4yNjCuUupi5OSQEDCReHH8C1sXIxeHkMAORok/F56w
        QSRkJLrv72XvYuQAsoUlDh8uhqh5yShxsvMRWA2bgIHE5GNvwGwRAR2JGW+aWUGKmAWOs0gs
        /f2EFaLjGJPE0kkXmEGqOAUCJeb8PMEIYgsLOElc/9zDCmKzCKhIrHw/nR3E5hWwlNjX/Z8Z
        whaUODnzCQuIzSygLfH05lM4e9nC18wQlypI/Hy6jBXiCj+J17Nh6kUkZne2MU9gFJ6FZNQs
        JKNmIRk1C0nLAkaWVYySqQXFuem5xYYFRnmp5XrFibnFpXnpesn5uZsYwdGqpbWDcc+qD3qH
        GJk4GA8xSnAwK4nwir+0TRDiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6HrZLyQQHpiSWp2ampB
        ahFMlomDU6qByft5+kvniSrmsy69n5KU3n/DcObFdy7v7jzu27zmFuvFDWb+1SwTVb99f7Xd
        yPpBv8FC8Xn3hW9xFp97rqkbknaF+Y5m8N2S81Gtock2RVIbvq1r+3k7On/Hl9LDF/yaZ22a
        cK6e7XlJUiKLl2R1RugU0RoG4zcKpxoCFeU0ZHRMFSqvMfZVie+w2vptv9X8NOOphsyuZpGb
        D+wLZbZmvF1vwlLxWXe/kO1Ti3vxeWXPJljFGM5luq+8NjptpUbyyvlG+ezSpVW7DzWxrTxt
        3bj7aHNR7nnWKTzlYlW/Ou/sWLnibn/YBUuLw5/9jO3nbqh0/sNxY2663+RYg3d8u0/+277E
        drPRjM+BsccnK7EUZyQaajEXFScCAK1PpWRFAwAA
X-CMS-MailID: 20210303112925epcas1p4084fb65bfe0de4e69074a3ee1335d3fc
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
        <01df01d70ff6$bc9dd230$35d97690$@samsung.com>
        <CAPDyKFpVjxKziPmyF+MXG--LKNSVOYaCUuaNBHCzMGCvSzE--Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On Wed, 3 Mar 2021 at 12:00, Ulf Hansson <ulf.hansson=40linaro.org> wrote:
>
>On Wed, 3 Mar 2021 at 07:30, DooHyun Hwang <dh0421.hwang=40samsung.com> wr=
ote:
>>
>> On Tue, 2 Mar 2021 at 10:38, Ulf Hansson <ulf.hansson=40linaro.org> wrot=
e:
>> >On Wed, 10 Feb 2021 at 06:12, DooHyun Hwang
>> ><dh0421.hwang=40samsung.com>
>> >wrote:
>> >>
>> >> A power cycle is required if CMD11 fails.
>> >> CMD11 failure should be handled as no response.
>> >>
>> >> If there is a timeout error that means no response to the CMD11, do
>> >> not send the CMD11 again and the power cycle is required.
>> >> Any other errors for CMD11 are the same because CMD11 failed.
>> >>
>> >> On some bad SD Card, CMD11 may fail but the card may have already
>> >> invoked the voltage switch sequence.
>> >> In this case, it is necessary to retry without voltage switching
>> >> after power cycle.
>> >>
>> >> Signed-off-by: DooHyun Hwang <dh0421.hwang=40samsung.com>
>> >
>> >Applied for next, thanks=21
>> >
>> >I took the liberty of updating the commit message a bit, to try to
>> >clarify things. Moreover, I have tagged this for stable kernels.
>> >
>> >BTW, did you try to force the error to -EAGAIN, to keep retrying for
>> >a couple of times? If so, did it end up with the same kind of errors?
>>
>> Thank you for reviewing this.
>>
>> Yes. I tested with 2 SD cards.
>> I think the power cycle is needed before retrying because SD card
>> doesn't respond SD_ROCR_S18A when retrying without power cycle.
>
>Thanks for sharing the logs and the details below=21
>
>If I understand correctly, forcing the error to -EAGAIN combined with the
>power cycle when the CMD11 fails, actually makes us succeed with the
>voltage switch in the second retry. Correct?

Yes, That's right.

>
>In that case, it seems like a good idea to extend =24subject patch to retu=
rn
>-EAGAIN in case we get an error from the CMD11, right?

Yes, I think so.
But it looks good to retry CMD11 only for a couple of times, and if it stil=
l fails,
it would be better to remove SD_OCR_S18R and retry ACMD41 as before.

>
>=5B...=5D
>
>>
>> =234. SD card responded with SD_ROCR_S18A from ACMD41 after power cycle,
>> and change CMD11's error value to -EAGAIN // send ACMD41 + with
>SD_OCR_S18R (bit=5B24=5D)
>> <7>=5B  156.884623=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD4=
1 arg
>51040000 flags 000000e1
>> // resp ACMD41 + with SD_ROCR_S18A (bit=5B24=5D)
>> <7>=5B  156.884975=5D I=5B0:    highpool=5B3=5D: 5440=5D mmc0: req done =
(CMD41): 0:
>c1ff8000 00000000 00000000 00000000
>> // send CMD11 and error occurs
>> <7>=5B  156.885051=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD1=
1 arg
>00000000 flags 00000015
>> <7>=5B  156.885759=5D I=5B0:    highpool=5B3=5D: 5440=5D mmc0: req done =
(CMD11): -84:
>00000000 00000000 00000000 00000000
>> // retry with power cycle (tested with this patch)
>> <7>=5B  156.885834=5D  =5B0:    kworker/0:1:    7=5D mmc0: Signal voltag=
e switch
>failed, power cycling card
>> <7>=5B  156.885875=5D  =5B0:    kworker/0:1:    7=5D mmc0: clock 0Hz bus=
mode 2
>powermode 0 cs 0 Vdd 0 width 1 timing 0
>> <7>=5B  156.920185=5D  =5B0:    kworker/0:1:    7=5D mmc0: clock 400000H=
z busmode 2
>powermode 2 cs 0 Vdd 18 width 1 timing 0
>> // change CMD11's error value to -EAGAIN
>> <3>=5B  156.932288=5D  =5B0:    kworker/0:1:    7=5D mmc_sd_get_cid: roc=
r=3D0xc1ff8000,
>retries=3D10. err=3D-84 -> -11.
>> <7>=5B  156.932336=5D  =5B0:    kworker/0:1:    7=5D mmc0: clock 400000H=
z busmode 2
>powermode 2 cs 1 Vdd 18 width 1 timing 0
>> <7>=5B  156.933834=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD0=
 arg
>00000000 flags 000000c0
>> <7>=5B  156.934101=5D I=5B0:ung.android.mdx:10229=5D mmc0: req done (CMD=
0): 0:
>00000000 00000000 00000000 00000000
>> <7>=5B  156.935562=5D  =5B0:    kworker/0:1:    7=5D mmc0: clock 400000H=
z busmode 2
>powermode 2 cs 0 Vdd 18 width 1 timing 0
>> <7>=5B  156.937009=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD8=
 arg
>000001aa flags 000002f5
>> <7>=5B  156.937372=5D I=5B0:ung.android.mdx:10229=5D mmc0: req done (CMD=
8): 0:
>> 000001aa 00000000 00000000 00000000 // send ACMD41 + with SD_OCR_S18R
>(bit=5B24=5D)
>> <7>=5B  157.044190=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD5=
5 arg
>00000000 flags 000000f5
>> <7>=5B  157.044924=5D I=5B0:ung.android.mdx:10229=5D mmc0: req done (CMD=
55): 0:
>00000120 00000000 00000000 00000000
>> <7>=5B  157.045023=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD4=
1 arg
>51040000 flags 000000e1
>> // resp ACMD41 + with SD_ROCR_S18A (bit=5B24=5D) <7>=5B  157.045389=5D
>> I=5B0:ung.android.mdx:10229=5D mmc0: req done (CMD41): 0: c1ff8000
>> 00000000 00000000 00000000 // send CMD11 and complete
>> <7>=5B  157.045467=5D  =5B0:    kworker/0:1:    7=5D mmc0: starting CMD1=
1 arg
>00000000 flags 00000015
>> <7>=5B  157.045855=5D I=5B0:   Binder:798_2:  805=5D mmc0: req done (CMD=
11): 0:
>00000320 00000000 00000000 00000000
>>
>>
>> >
>> >> ---
>> >>  drivers/mmc/core/core.c =7C 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
>> >> index 1136b859ddd8..a6674df2a7bb 100644
>> >> --- a/drivers/mmc/core/core.c
>> >> +++ b/drivers/mmc/core/core.c
>> >> =40=40 -1207,7 +1207,7 =40=40 int mmc_set_uhs_voltage(struct mmc_host
>> >> *host,
>> >> u32 ocr)
>> >>
>> >>         err =3D mmc_wait_for_cmd(host, &cmd, 0);
>> >>         if (err)
>> >> -               return err;
>> >> +               goto power_cycle;
>> >>
>> >>         if (=21mmc_host_is_spi(host) && (cmd.resp=5B0=5D & R1_ERROR))
>> >>                 return -EIO;
>> >> --
>> >> 2.29.0
>> >>
>
>Kind regards
>Uffe

Thanks and regards.
DooHyun Hwang.

