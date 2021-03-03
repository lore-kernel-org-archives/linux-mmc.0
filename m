Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89EF3C433E0
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682E964F69
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Mar 2021 00:02:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237483AbhCDAAU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:00:20 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:37017 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244351AbhCCLtB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Mar 2021 06:49:01 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210303092224epoutp045e2d18b6224b7a3d1fff278c574c6b26~oyrTOEJsF0273902739epoutp04V
        for <linux-mmc@vger.kernel.org>; Wed,  3 Mar 2021 09:22:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210303092224epoutp045e2d18b6224b7a3d1fff278c574c6b26~oyrTOEJsF0273902739epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1614763344;
        bh=DaETncI2WkGpIZPO84QI4EYoYPo0z0TkLlv7iwzyrzA=;
        h=From:To:Subject:Date:References:From;
        b=aOGFkF+zZbZdYO1dU1m88x47jmemN7d4sQJuSY7BH0FcRKIlZnKEyrtUq66AuHf4J
         Pp17plG5+1REDcN58+s1u45cpREpWb6kk2di6KxsOelMUkxw5guqjXqLSrxJaZ91nj
         fq9Pt+J2RVJZzqqKFh/JlNUV8XG2LcO5UnbtPIc8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210303092224epcas2p42cb867dec594a1f454ac4215463f6f70~oyrS8SNxp1054810548epcas2p4h;
        Wed,  3 Mar 2021 09:22:24 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.185]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Dr7nB6Gfhz4x9Q3; Wed,  3 Mar
        2021 09:22:22 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.E4.52511.E455F306; Wed,  3 Mar 2021 18:22:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20210303092222epcas2p11fbb2697a53b54dbc138d741893c9f07~oyrRRzFNj0245702457epcas2p1P;
        Wed,  3 Mar 2021 09:22:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210303092222epsmtrp1cb8a362f34f7ba5f9e230c99366f8dbb~oyrROasYc1961519615epsmtrp1x;
        Wed,  3 Mar 2021 09:22:22 +0000 (GMT)
X-AuditID: b6c32a48-50fff7000000cd1f-29-603f554e9ebf
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        13.AE.08745.E455F306; Wed,  3 Mar 2021 18:22:22 +0900 (KST)
Received: from KORCO011456 (unknown [12.36.185.54]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20210303092221epsmtip2145ee0fc3f51cc9502f327b243054839~oyrRCSI6e2440724407epsmtip2D;
        Wed,  3 Mar 2021 09:22:21 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     <linux-mmc@vger.kernel.org>, <ulf.hansson@linaro.org>
Subject: About SD initialization at resume time
Date:   Wed, 3 Mar 2021 18:22:21 +0900
Message-ID: <000001d7100e$b7380f50$25a82df0$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdcQDiu8DmibM2nsTySDHbARn+3GAA==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDKsWRmVeSWpSXmKPExsWy7bCmqa5fqH2CQfM6dYsj//sZLY6vDXdg
        8rhzbQ+bx+dNcgFMUTk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZK
        Lj4Bum6ZOUDTlRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFhoYFesWJucWleel6
        yfm5VoYGBkamQJUJORmtu/cxFvxjrbj0aRJrA+Mdli5GTg4JAROJjxfPM3YxcnEICexglPj+
        oY8RJCEk8IlR4tZREYjEZ0aJV02T2WE6rl/bC9Wxi1Gio2sDE4TzglHi4afHbCBVbALaEtMe
        7mYFsUUELCUuXTkM1MHBISygL7GsxxAkzCKgIvHozF2wM3iBSs51fGaDsAUlTs58AhZnBhqz
        bOFrZojFChI/ny5jBRkjIqAnsbDLE6JERGJ2ZxszyAkSAqvYJR6s2swKUe8iMW36LUYIW1ji
        1fEtUA9ISbzsb4Oy6yX2TW1ghWjuYZR4uu8fVIOxxKxn7WA3MwtoSqzfpQ9iSggoSxy5BXUa
        n0TH4b/sEGFeiY42IYhGZYlfkyZDDZGUmHnzDtQmD4nFr86DlQsJxEo8mSg8gVFhFpJ/ZyH5
        dxaSx2YhnLCAkWUVo1hqQXFuemqxUYEJckxvYgQnOy2PHYyz337QO8TIxMF4iFGCg1lJhFf8
        pW2CEG9KYmVValF+fFFpTmrxIUZTYAxMZJYSTc4Hptu8knhDUyMzMwNLUwtTMyMLJXHeIoMH
        8UIC6YklqdmpqQWpRTB9TBycUg1M24J/G5bd/ZjDfViDoW6isnxLhNrBS0udAgQMP17lfHRl
        8zbn/5v6bh+8ZLdo76RCvr1H9lZKntz/z/tmwfyNLw9PCKj56hscVK5zoamq9pHJ+vN7p3ny
        HJu5Zf3fdYFvXE1d+Ku4L+3IP5uV3jerwvdn/pbHcxKSfV3DpZwvPj+Xe3zR9d2fIs89fSu1
        Umrq+f67N/vFDnQe/7FK8uSu99Hi/GIq7vbnve3U48+Unf0UV/jL93oYw/Xes8Vq7u0ruoJX
        FNy4NaF9ovWrtFyFmhg17Shb3Rq2NMXQzPhCo8UT++aosVnp/5qjkNeQath/WWN9ya2JL8KY
        LhyTTmD7pHktR3xzldK9uw/4f2b5KbEUZyQaajEXFScCACj6iFn/AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsWy7bCSvK5fqH2CwbTTbBZH/vczWhxfG+7A
        5HHn2h42j8+b5AKYorhsUlJzMstSi/TtErgydr3Yw1jwj7Vi9/vDbA2Md1i6GDk5JARMJK5f
        28sIYgsJ7GCUWDk/BCIuKXFi53NGCFtY4n7LEVaImmeMEkdvOYLYbALaEtMe7gaLiwhYS2zY
        PY+pi5GDQ1hAX2JZjyFImEVAReLRmbtgq3gFLCXOdXxmg7AFJU7OfAIWZwYa8/TmUzh72cLX
        zBBrFSR+Pl3GCjJSREBPYmGXJ0SJiMTszjbmCYwCs5BMmoVk0iwkk2YhaVnAyLKKUTK1oDg3
        PbfYsMAoL7Vcrzgxt7g0L10vOT93EyM4WLW0djDuWfVB7xAjEwfjIUYJDmYlEV7xl7YJQrwp
        iZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTCpvfry+0zpzo/l
        wlEz31mvm74sod29Sbz1kP4b1SgDp01sZ7eJrNVS27q3Ncl38tdJpQqpL52tLaxS2kt/ZMw3
        bHFtlPrmVMesXvFVZJuwor2VKKfHDP5OwdklX69f7j+d9Mr5fZkH+8wl9m2+zL+MG87u25z7
        bc+DZJXu61qPbT7vONLLqKo0YbU/S8HiH3fYdJN/KizcF57j4s0QzuWbyyDQ73J+X3LUuQtB
        ifvndazeELbzXtaHKW80/a7qiDzLuLqM/WxOBHdi+8pv0dN3XL3/yHtdisurQ4tlEh8fjmDd
        YRD2yc2wudSg7uz7A4pGsxy/nalfGXzRYbb9xXmWE/yl1s9ffOBN8RbH5nglluKMREMt5qLi
        RACq/CnpxQIAAA==
X-CMS-MailID: 20210303092222epcas2p11fbb2697a53b54dbc138d741893c9f07
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210303092222epcas2p11fbb2697a53b54dbc138d741893c9f07
References: <CGME20210303092222epcas2p11fbb2697a53b54dbc138d741893c9f07@epcas2p1.samsung.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Dear all

I hope opinions from you guys.

For many users of mobile device, there is a possibility that issuing no IO =
request to
a SD card is rare during much of the device's lifetime.
Obviously the symptom would happen frequently among system suspend times, t=
oo.
In this situation, doing SD initialization at every system resume leads to =
long latency
and can make the users feel it, even when there is no IO request during the=
 period,
when a hardware architecture requires re-initialization at resume time.
This is what had actually happened and was fixed with some code in commerci=
al products.

Is there any way to avoid that symptom w/o any code change?
With no way, I hope to make soemthing to improve it.

Thanks.
Kiwoong Kim


