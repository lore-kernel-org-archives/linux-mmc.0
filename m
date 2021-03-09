Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C04C433E0
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 04:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E89E6518A
	for <linux-mmc@archiver.kernel.org>; Tue,  9 Mar 2021 04:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbhCIELG (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 8 Mar 2021 23:11:06 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:42924 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhCIELF (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Mar 2021 23:11:05 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210309041103epoutp0259f39c3f27b4b32e39c85aa52b2fceb6~qkTLLk41H2170621706epoutp02U
        for <linux-mmc@vger.kernel.org>; Tue,  9 Mar 2021 04:11:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210309041103epoutp0259f39c3f27b4b32e39c85aa52b2fceb6~qkTLLk41H2170621706epoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615263063;
        bh=8GkOMlF98fn6VRxZ5PyQjOlvWLeJWQqe/BlaFen5BnQ=;
        h=From:To:Subject:Date:References:From;
        b=lVCurYWZzY8iJQECSWMhvNbC6waA8+Bs6tKo5v0kBIW0wUpnk8CU/stX5wOETWXvt
         3pFLDEPiihn8f4wlppisLsAAnlKcPj6d+7v3kCRRfEsxJzBBL2iDP0m3fnmXfXC9hK
         MUWp3dhHdLxwaUf4ptje/tJCaojrQgQ6b0XSE1Tg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20210309041103epcas2p2ed518ad668c97f1e467d09592dd4e046~qkTK-Vz200395003950epcas2p2_;
        Tue,  9 Mar 2021 04:11:03 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.188]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Dvhb92J1Qz4x9Q9; Tue,  9 Mar
        2021 04:11:01 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        3B.D0.56312.355F6406; Tue,  9 Mar 2021 13:10:59 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20210309041059epcas2p49567b092c8d82bb80aa76ad26f8d212b~qkTHGJcit3246432464epcas2p4w;
        Tue,  9 Mar 2021 04:10:59 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210309041059epsmtrp238d393efc03e57925fde4b640e7a2c8a~qkTHFIAkB0934009340epsmtrp2o;
        Tue,  9 Mar 2021 04:10:59 +0000 (GMT)
X-AuditID: b6c32a46-1d9ff7000000dbf8-91-6046f553dab5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C6.5E.08745.355F6406; Tue,  9 Mar 2021 13:10:59 +0900 (KST)
Received: from KORCO011456 (unknown [12.36.185.54]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210309041059epsmtip1a25e3df42a351f68254dc5b851f60044~qkTG9cf813267832678epsmtip1v;
        Tue,  9 Mar 2021 04:10:59 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "Ulf Hansson" <ulf.hansson@linaro.org>, <linux-mmc@vger.kernel.org>
Subject: About a possibility of long latency to claim host
Date:   Tue, 9 Mar 2021 13:10:58 +0900
Message-ID: <02da01d7149a$35dec530$a19c4f90$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AdcUmg2/2rnB/HKyQ6OL6Mow+CruMQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrPKsWRmVeSWpSXmKPExsWy7bCmmW7wV7cEg+/ztC2O/O9ntDi+NtyB
        yePOtT1sHp83yQUwReXYZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoq
        ufgE6Lpl5gBNV1IoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUWpOQUGBoW6BUn5haX5qXr
        JefnWhkaGBiZAlUm5GRMfHSTtWCVQcX9lTNZGxh3qncxcnJICJhITHtxghXEFhLYwSjxZrJR
        FyMXkP2JUWJ/xxdWCOczo8TTW5uYYDo6jzRAJXYxSvzbc58ZwnnBKHHyyDKwWWwC2hLTHu4G
        s0UE3CXe7zrJDGILC1hJtO1tAZvEIqAi8fHCMzYQm1fAUuL5xyXMELagxMmZT1hAbGagOcsW
        vmaG2Kwg8fMpxHxmARGJ2Z1tzBDz9SRmfN/KBnKEhMA6doln705AneoicePybqhmYYlXx7ew
        Q9hSEp/f7WWDsOsl9k2FeEdCoAfoz33/GCESxhKznrUD2RxA2zQl1u/SBzElBJQljtyCuo1P
        ouPwX3aIMK9ER5sQRKOyxK9Jk6GGSErMvHkHaquHxMSDbxkhQR0rsXvdL8YJjAqzkHw8C8nH
        s5B8OQvhhgWMLKsYxVILinPTU4uNCoyQI3sTIzjlabntYJzy9oPeIUYmDsZDjBIczEoivH7H
        3RKEeFMSK6tSi/Lji0pzUosPMZoC42Ais5Rocj4w6eaVxBuaGpmZGViaWpiaGVkoifMWGzyI
        FxJITyxJzU5NLUgtgulj4uCUamAq1N3l9GaFDVvevJusHjo32WbmeGgI1a5W1kuuUefYdduX
        KcXY2i3ifb9y3isNr7NHyyT61z/ZmCW3N9O1p3eVfZj/Pp81Ddzn+z4rf+Y+P19gReG0G30b
        DD0UBObsu2d6ovnoBVkv5taewgmJNhLPZwiwpTRH29Sp/77D7G6r/nsPt3Ah03Yn2SeTffxC
        lr9526ioFZ3zbZrNpg9x1sw689uut2iZH9jh9mvrooMM7EoVP5V2TdBZZ/n6S/FdXmamliWP
        Hn8NPjxNaurZ7EVev7c47DwfFma27UplyCnDlM4LaYdea1nsnx3tdvNx1R/F7Hep+zVM0pNV
        bFY9a3ZeFnpUJId5puvtPNfISCWW4oxEQy3mouJEALWyUQkCBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSnG7wV7cEg1MTBSyO/O9ntDi+NtyB
        yePOtT1sHp83yQUwRXHZpKTmZJalFunbJXBlzJ60m7Vgkk7FmpW3WBsYFyp3MXJySAiYSHQe
        aWDtYuTiEBLYwSjRd+IQK0RCUuLEzueMELawxP2WI1BFzxglJs3byQSSYBPQlpj2cDdYg4iA
        p0Tb926wBmEBK4m2vS1gNSwCKhIfLzxjA7F5BSwlnn9cwgxhC0qcnPmEBcRmBprz9OZTOHvZ
        wtfMEIsVJH4+XcYKEReRmN3ZxgyxS09ixvetbBMYBWYhGTULyahZSEbNQtK+gJFlFaNkakFx
        bnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcNBqae1g3LPqg94hRiYOxkOMEhzMSiK8fsfdEoR4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgkpZwNFoT1p++
        WObOjwW/A1ksg6M9+96dvV50MeGydeGD29LVLE/syuovqi3zlSlu/fF+l9UKRVPH9z4zH/4V
        VNISZHuQEuiSt6djG++/Fg+x5a5H03xfa64qfnfwyrxFF6SWH2w8Whp4e5VqxH+HE2JpT0MP
        qVb/+r1G88eZ40/6DLLU2POmrgv54Vm8bUv5QwatF8liCa8WCGTac9RUTNu6ctvez+dFtXjZ
        TvKe3rLE8XHYLQHz6q5pSn1bnWaIborb/+nHFhWfrHjZ/8c+eDdrnF54dFngrL2ZwguVHkx6
        n/l+2YvHW4/P0f7sri17tmTWkhvOCw1f9T+oXThz/rNwNwn9etHTYvP5F9oG1SuxFGckGmox
        FxUnAgAjbaDryQIAAA==
X-CMS-MailID: 20210309041059epcas2p49567b092c8d82bb80aa76ad26f8d212b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210309041059epcas2p49567b092c8d82bb80aa76ad26f8d212b
References: <CGME20210309041059epcas2p49567b092c8d82bb80aa76ad26f8d212b@epcas2p4.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dear All

I want to discuss about this topic with you guys.

There is an application to put many IO requests to a SD card right after co=
mpletion of system resume.
Current MMC stack invokes mmc_rescan asynchronously for PM_POST_SUSPEND.
As reported to me, there could be a race between an IO thread and the kwork=
er for mmc_rescan,
especially when the application mentioned before is installed and the funct=
ion of mmc_rescan is run later than expected=20
For a series of IO requests, mmc_rescan, particularily at __mmc_claim_host =
called in mmc_sd_detect, didn't acquire a host for longer than expected.

Below is the call stacks shown after the symptom happened and the system tr=
ied to enter into suspend again.
In this case, mmc pm notifier is called with PM_SUSPEND_PREPARE, so it wait=
s for completion or cancelling the work for mmc_rescan.
For the latency, mobile users can see black screen for a long time sometime=
s, even with pushing a power button to wake up the system.

If there is another way to fix it w/o any change, please let me know.
Or I want to post a patch not to do _mmc_detect_change conditionally
because it helps remove the race and the case assumes SD card initializatio=
n is already done.

--
<6>=5B 3965.259816=5D I=5B0:      swapper/0:    0=5D    22631        0     =
 227    3902403994884 D(2)   3  ffffffc0007ee338                0  ffffffc8=
5678e000 *    kworker/u16:4 =5B__mmc_claim_host=5D
<6>=5B 3965.259839=5D I=5B0:      swapper/0:    0=5D Workqueue: kmmcd mmc_r=
escan
<0>=5B 3965.259854=5D I=5B0:      swapper/0:    0=5D Call trace:
<4>=5B 3965.259870=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc00013e674>=
=5D __switch_to+0x80/0x90
<4>=5B 3965.259886=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000b137f4>=
=5D __schedule+0x530/0x76c
<4>=5B 3965.259902=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000b13a9c>=
=5D schedule+0x6c/0x7c
<4>=5B 3965.259919=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0007ee338>=
=5D __mmc_claim_host+0xb8/0x188
<4>=5B 3965.259937=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0007eebfc>=
=5D mmc_get_card+0x24/0x38
<4>=5B 3965.259956=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0007f5c44>=
=5D mmc_sd_detect+0x90/0xe8
<4>=5B 3965.259973=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0007f08d8>=
=5D mmc_rescan+0xa0/0x2ec
<4>=5B 3965.259991=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0001688e0>=
=5D process_one_work+0x26c/0x434
<4>=5B 3965.260008=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000168dc8>=
=5D worker_thread+0x320/0x444
<4>=5B 3965.260026=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc00016dac0>=
=5D kthread+0xdc/0xec
..
<0>=5B 3965.259854=5D I=5B0:      swapper/0:    0=5D Call trace:
<4>=5B 3965.259870=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc00013e674>=
=5D __switch_to+0x80/0x90
<4>=5B 3965.259886=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000b137f4>=
=5D __schedule+0x530/0x76c
<4>=5B 3965.259902=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000b13a9c>=
=5D schedule+0x6c/0x7c
<4>=5B 3965.259919=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0007ee338>=
=5D __mmc_claim_host+0xb8/0x188
<4>=5B 3965.259937=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0007eebfc>=
=5D mmc_get_card+0x24/0x38
<4>=5B 3965.259956=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0007f5c44>=
=5D mmc_sd_detect+0x90/0xe8
<4>=5B 3965.259973=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0007f08d8>=
=5D mmc_rescan+0xa0/0x2ec
<4>=5B 3965.259991=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0001688e0>=
=5D process_one_work+0x26c/0x434
<4>=5B 3965.260008=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000168dc8>=
=5D worker_thread+0x320/0x444
<4>=5B 3965.260026=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc00016dac0>=
=5D kthread+0xdc/0xec
..
<0>=5B 3965.203379=5D I=5B0:      swapper/0:    0=5D Call trace:
<4>=5B 3965.203397=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc00013e674>=
=5D __switch_to+0x80/0x90
<4>=5B 3965.203414=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000b137f4>=
=5D __schedule+0x530/0x76c
<4>=5B 3965.203430=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000b13a9c>=
=5D schedule+0x6c/0x7c
<4>=5B 3965.203448=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000b160e8>=
=5D schedule_timeout+0x28/0x214
<4>=5B 3965.203464=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000b145a0>=
=5D wait_for_common+0x114/0x15c
<4>=5B 3965.203482=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000b14710>=
=5D wait_for_completion+0x10/0x20
<4>=5B 3965.203498=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000169990>=
=5D flush_work+0xf0/0x11c
<4>=5B 3965.203516=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000169ad0>=
=5D __cancel_work_timer+0x114/0x1a0
<4>=5B 3965.203533=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000169c44>=
=5D cancel_delayed_work_sync+0xc/0x1c
<4>=5B 3965.203554=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0007f1000>=
=5D mmc_pm_notify+0x78/0x12c
<4>=5B 3965.203573=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc00016ebf4>=
=5D notifier_call_chain+0x7c/0xec
<4>=5B 3965.203590=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc00016ef08>=
=5D __blocking_notifier_call_chain+0x44/0x68
<4>=5B 3965.203608=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc00016ef3c>=
=5D blocking_notifier_call_chain+0x10/0x20
<4>=5B 3965.203628=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0001964ec>=
=5D pm_notifier_call_chain+0x1c/0x44
<4>=5B 3965.203644=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000197ad0>=
=5D pm_suspend+0x2e0/0x5fc
<4>=5B 3965.203662=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0001961cc>=
=5D state_store+0x4c/0x8c
<4>=5B 3965.203683=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0003f35ec>=
=5D kobj_attr_store+0x14/0x2c
<4>=5B 3965.203703=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0002aac2c>=
=5D sysfs_kf_write+0x40/0x50
<4>=5B 3965.203721=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc0002aa000>=
=5D kernfs_fop_write+0xfc/0x148
<4>=5B 3965.203739=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000249b4c>=
=5D vfs_write+0xb8/0x190
<4>=5B 3965.203755=5D I=5B0:      swapper/0:    0=5D =5B<ffffffc000249cf0>=
=5D SyS_write+0x44/0x88

Thanks.
Kiwoong Kim



