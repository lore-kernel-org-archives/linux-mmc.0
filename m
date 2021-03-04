Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93A32C433E9
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 07:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7260264F0A
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 07:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbhCDHo3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 02:44:29 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:12547 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234393AbhCDHoP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 02:44:15 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210304074334epoutp01db0c434d48f957af1fdb1f1f36575872~pE_ShjhyI0463304633epoutp010
        for <linux-mmc@vger.kernel.org>; Thu,  4 Mar 2021 07:43:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210304074334epoutp01db0c434d48f957af1fdb1f1f36575872~pE_ShjhyI0463304633epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614843814;
        bh=f6z1KjukkPmDFowDYbXQ5aH8USh6cvoy28n+DQI3I7c=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=Z+JJoX8WUvyMjCBWS1KGNBmCBopgmLTGQvFw22hIoLC5gvRlliGNNZfKZ1sleAT7I
         SrrjpGLb94Mvc6floK8adyuSGCeGCkeTO1eGZJBM+vqSCPJhnS5IAebxdBbbNdh4Vz
         CCgKtNimgyNBHMLrOAwncbgPXQKE/61hgr3AF5sQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20210304074333epcas2p2391be15ee5835cebddcae0d2c1de8815~pE_SB0oT91628716287epcas2p2p;
        Thu,  4 Mar 2021 07:43:33 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4DrjXg1NpCz4x9Q2; Thu,  4 Mar
        2021 07:43:31 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.DB.56312.2AF80406; Thu,  4 Mar 2021 16:43:30 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20210304074330epcas2p1d44724ca5e6c2892873e20e001178a33~pE_PFAlRX0613606136epcas2p1t;
        Thu,  4 Mar 2021 07:43:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210304074330epsmtrp1d5388e8d17f99b6ae38ab81073b48c4d~pE_PEa4W30394603946epsmtrp1b;
        Thu,  4 Mar 2021 07:43:30 +0000 (GMT)
X-AuditID: b6c32a46-1d9ff7000000dbf8-3e-60408fa25c1e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        BC.1D.08745.2AF80406; Thu,  4 Mar 2021 16:43:30 +0900 (KST)
Received: from KORCO011456 (unknown [12.36.185.54]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210304074330epsmtip280c49674777bdd016329b3a6f8b8c1fc~pE_O8oy6H1971519715epsmtip2f;
        Thu,  4 Mar 2021 07:43:30 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Ulf Hansson'" <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>
In-Reply-To: <CAPDyKFr0x7vinYpy=AHcYfqxO-Q_S+SuU_SUb+kRTxRkNm4G6A@mail.gmail.com>
Subject: RE: About SD initialization at resume time
Date:   Thu, 4 Mar 2021 16:43:29 +0900
Message-ID: <008b01d710ca$1207fab0$3617f010$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQKRzA59woR7UZh8YcjBzEvw7y0zfQFaIJ2IAjxzo+So4UG5QA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmme7ifocEg182Fkf+9zNaHF8b7sDk
        cefaHjaPz5vkApiicmwyUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVc
        fAJ03TJzgIYrKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoMDQv0ihNzi0vz0vWS
        83OtDA0MjEyBKhNyMmZ+m89c8NS44vH1acwNjFO0uhg5OSQETCRubz7C3MXIxSEksINR4tyW
        TVDOJ0aJa0cPsUA4nxklbn9bzdrFyAHW8vWcHER8F6PEqw1/oTpeMErMXnebBWQum4C2xLSH
        u1lBbBEBHYkZb5rBbGYBeYm3V1aA2ZwCgRJz22cwgtjCAsYSP9cvZwOxWQRUJCZ93gRm8wpY
        SjzseM8KYQtKnJz5hAVijrbEsoWvmSF+UJD4+XQZ1C4nidf/PjBB1IhIzO5sAztOQuASu8Si
        zsdMEA0uEpP/32aFsIUlXh3fwg5hS0m87G+Dsusl9k1tYIVo7mGUeLrvHyNEwlhi1rN2RlBQ
        MAtoSqzfpQ8JFWWJI7egbuOT6Dj8lx0izCvR0SYE0ags8WvSZKghkhIzb95hn8CoNAvJZ7OQ
        fDYLyQezEHYtYGRZxSiWWlCcm55abFRghBzZmxjBCU/LbQfjlLcf9A4xMnEwHmKU4GBWEuEV
        f2mbIMSbklhZlVqUH19UmpNafIjRFBjWE5mlRJPzgSk3ryTe0NTIzMzA0tTC1MzIQkmct9jg
        QbyQQHpiSWp2ampBahFMHxMHp1QDE796Wc+q4CcNkifcvOMsDofvE7/WqdRjqKDZ+jSbaW/b
        qsPca86bTVG+eGXG1m0LnSbffLWYS3ByLEekwcyLT0MmJu2Y6BspuqIhKPDVUZF8ow7F8M+7
        eTQUbzxaGejGGZf695ugw5UqoVlzDii9XjYj0//NPM1TX7fPuCdtZj1h4tkSryl/b8j9XvVo
        3e3dk38a2ut9DToWkXz4lVrOdJ6uPs1fAus9WBO35N5bdmPD6kJrvwb+ruebKyriO81byvjO
        Gv0zC1SqiJHdEBiRk5a6Kzf+8KMpTzKFLn04cCrqUZPzjWgdiV1fFc+qNuQU7dcRfX9yj5fR
        TqNnC2aGcK82a5/xzWZBZLJgRshSfyWW4oxEQy3mouJEAHd7qJMBBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSvO6ifocEg1lbhS2O/O9ntDi+NtyB
        yePOtT1sHp83yQUwRXHZpKTmZJalFunbJXBl9DU8ZCs4oV/xedcM9gbGn6pdjBwcEgImEl/P
        yXUxcnEICexglHhyYwl7FyMnUFxS4sTO54wQtrDE/ZYjrBBFzxglmifeYAJJsAloS0x7uJsV
        xBYR0JGY8aYZzGYWkJd4e2UFVMMFRonDK1+AJTgFAiXmts8AmyosYCzxc/1yNhCbRUBFYtLn
        TWA2r4ClxMOO96wQtqDEyZlPWCCGaks8vfkUzl628DUzxHUKEj+fLoM6wkni9b8PTBA1IhKz
        O9uYJzAKz0IyahaSUbOQjJqFpGUBI8sqRsnUguLc9NxiwwKjvNRyveLE3OLSvHS95PzcTYzg
        4NfS2sG4Z9UHvUOMTByMhxglOJiVRHjFX9omCPGmJFZWpRblxxeV5qQWH2KU5mBREue90HUy
        XkggPbEkNTs1tSC1CCbLxMEp1cDU6KSrtDsz//KtBZZPZrwTKOgJtnU7k1L+uuskd97y/zMO
        rUnQrTZetGyX0BkLUdnjbm8VrkZnqf6+U5elFOV2e0/4Ucv4nTPW3PmuO/tOu4/EHKu97mtZ
        FDjn3nl8LL/n7b5FjmKhuxkUzdcG/FtQrjIl7JZ+9Me0KYa7lmzYyLXj3sPrub9/SzJYzLFe
        Xicg/iLgEmdLevntHu1a3+oppqd7DwVO8Wj9X5/PaGKQGrM1ernF3hMqF7Njp//w8r/CwPKb
        ++Aru/A/FpkvolljX598nhM8bW7+RpFZGz7KdlR8ZnVttdry7s703WxnA0OOXXjHoqhRNN3F
        5+3ug/NO+XTeLZT4sNVNqrdCPO6JEktxRqKhFnNRcSIA/ZcN9+0CAAA=
X-CMS-MailID: 20210304074330epcas2p1d44724ca5e6c2892873e20e001178a33
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210303092222epcas2p11fbb2697a53b54dbc138d741893c9f07
References: <CGME20210303092222epcas2p11fbb2697a53b54dbc138d741893c9f07@epcas2p1.samsung.com>
        <000001d7100e$b7380f50$25a82df0$@samsung.com>
        <CAPDyKFr0x7vinYpy=AHcYfqxO-Q_S+SuU_SUb+kRTxRkNm4G6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> > This is what had actually happened and was fixed with some code in
> commercial products.
>=20
> The above code in the mmc core was introduced around kernel v3.11, even i=
f
> it has been fine tuned since then.
>=20
> Maybe you have been using even older kernels?
>=20
Dear Uffe

First, you give me what I want.
We've used higher versions than 3.11 but applied our own changes for some r=
easons.
Anyway, thanks =21

That is the first problem for me on SD.
The 2nd thing is very long latency issue for a race between an IO thread an=
d a kworker to run mmc_rescan.

There is an application to put many IO requests to a SD card right after co=
mpletion of system resume.
Current MMC stack invokes mmc_rescan is invoked asynchronously for PM_POST_=
SUSPEND.
As reported to me, however, there could be a race between an IO thread and =
the kworker for mmc_rescan
especially the function of mmc_rescan is run later than expected and the ap=
plication mentioned before is installed.

For a series of IO requests, mmc_rescan, particularily at __mmc_claim_host =
called in mmc_sd_detect,
doesn't acquire a host for longer than expected.
Below is the call stacks shown after the symptom happened and the system tr=
ied to enter into suspend again.
In this case, mmc pm notifier is called with PM_SUSPEND_PREPARE, so it wait=
s for completion or cancelling the work for mmc_rescan.
For the latency, users can see black screen for a long time sometimes.

So I want to post a patch not to do _mmc_detect_change conditionally
because it helps remove the race and the case assumes SD card initializatio=
n is already done.
If you have your different views, please let me know.

Thanks.

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

