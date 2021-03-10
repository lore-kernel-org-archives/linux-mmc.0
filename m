Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE50C433E0
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 03:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D777564FEE
	for <linux-mmc@archiver.kernel.org>; Wed, 10 Mar 2021 03:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhCJD5P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 9 Mar 2021 22:57:15 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:62154 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231263AbhCJD4s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 9 Mar 2021 22:56:48 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20210310035646epoutp01445cdb92dfd7db8f7b5c3020206ac025~q3v-KBpY01984319843epoutp01d
        for <linux-mmc@vger.kernel.org>; Wed, 10 Mar 2021 03:56:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20210310035646epoutp01445cdb92dfd7db8f7b5c3020206ac025~q3v-KBpY01984319843epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1615348606;
        bh=IL30nS3++05iZdIZdOEVbgo1TkFRTJNLqY8BhWIU6Nw=;
        h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
        b=iExbroulFJopeTwlmAgSI9Ucxi07iWKvT9DB/k5cCoyPDnLD0YEfnEKGQMVDiZHbV
         TQuT+boJHGWAxP6nv6yp8gbVA2dFu00kLn5BvNQsHdgGjyAwwiUT2vKQUiGNaYwsNl
         ScS82RGLMlNBGOzabrZiaAhKpoRk1VQs+3MiL2TU=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210310035646epcas2p46bc4e3db574400b3202f945d32171fe8~q3v_9Oa_N3139931399epcas2p40;
        Wed, 10 Mar 2021 03:56:46 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.189]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4DwJDD07nyz4x9Q6; Wed, 10 Mar
        2021 03:56:44 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.E2.52511.B7348406; Wed, 10 Mar 2021 12:56:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20210310035643epcas2p1be2a7534585656a0034e62cee9947e8d~q3v8IE4O42171921719epcas2p1B;
        Wed, 10 Mar 2021 03:56:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210310035643epsmtrp1efc4f8af36fe60da09deb98389c7983c~q3v8HeYKI1187711877epsmtrp1-;
        Wed, 10 Mar 2021 03:56:43 +0000 (GMT)
X-AuditID: b6c32a48-4f9ff7000000cd1f-91-6048437bc55c
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.4E.08745.B7348406; Wed, 10 Mar 2021 12:56:43 +0900 (KST)
Received: from KORCO011456 (unknown [12.36.185.54]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20210310035643epsmtip1182b488d787ae8b24d9a0f41410d2b12~q3v7--qM42048220482epsmtip1e;
        Wed, 10 Mar 2021 03:56:43 +0000 (GMT)
From:   "Kiwoong Kim" <kwmad.kim@samsung.com>
To:     "'Ulf Hansson'" <ulf.hansson@linaro.org>
Cc:     <linux-mmc@vger.kernel.org>
In-Reply-To: <CAPDyKFoEGp1CHo1OuTTeGqKkPG1Nke0k_rLBLSwmLH_BCcDDtA@mail.gmail.com>
Subject: RE: About a possibility of long latency to claim host
Date:   Wed, 10 Mar 2021 12:56:42 +0900
Message-ID: <002401d71561$62112220$26336660$@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: ko
Thread-Index: AQHnYJw8NfxlhPim0I9Ql9ljwqb6fAGpovOjAi+Gw34Bm2jqN6owXLJg
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNKsWRmVeSWpSXmKPExsWy7bCmuW61s0eCwY0XyhZH/vczWhxfG+7A
        5HHn2h42j8+b5AKYonJsMlITU1KLFFLzkvNTMvPSbZW8g+Od403NDAx1DS0tzJUU8hJzU22V
        XHwCdN0yc4CmKymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKDA0L9IoTc4tL89L1
        kvNzrQwNDIxMgSoTcjI+LrjBWrBJvOL8xdfMDYwLhLoYOTkkBEwkmj+tZOli5OIQEtjBKHHx
        9kImkISQwCdGif6D+hD2Z0aJRS/kYRpWf33ECNGwi1Fi0+P7UN0vGCVe975hBaliE9CWmPZw
        N5gtIqAjMeNNM5jNLCAv8fbKCjCbUyBQ4vOLR0DNHBzCAnYS6/5GgIRZBFQlXk1bwwJi8wpY
        Sjxff5UJwhaUODnzCQvMmO1v5zBDHKQg8fPpMqjxIhKzO9uYQUaKCLhJXNifAlFyjV3iaTfU
        /S4SZ3cfY4KwhSVeHd/CDmFLSbzsb4Oy6yX2TW1gBXlLQqCHUeLpvn+MEAljiVnP2hlB5jML
        aEqs36UPYkoIKEscuQV1GZ9Ex+G/7BBhXomONmgwK0v8mjQZaoikxMybd9gnMCrNQvLXLCR/
        zULyyyyEXQsYWVYxiqUWFOempxYbFZggR/QmRnCq0/LYwTj77Qe9Q4xMHIyHGCU4mJVEeP2O
        uyUI8aYkVlalFuXHF5XmpBYfYjQFhvREZinR5Hxgss0riTc0NTIzM7A0tTA1M7JQEuctMngQ
        LySQnliSmp2aWpBaBNPHxMEp1cCUVCNUluPf4qa2o77EJnTjzH+abybIx60SVfFZ/XOJavvm
        sw/luWbsl/ZUrHXq/jnztUHTJBOHKTeDpAROPHl01OFV8IS/MvlXPjs0Rd0791v4zUqZlOol
        D5xvr6w6NqlE86vQiy9nZy15ff3RYz7pp+cuBh27UBbKfu/U04Jctu6or53h06I3eX2sZJjL
        rW+6sS/aYstbD/lFCXybpC3n92wTX7OnsPF4p/fz8qkT2Px5PLYzMb7LO+fYVtujLJTSnHTs
        +MdbnVsWKO9zzdysvDfc17WtbgVDcvV23jnxcscfGl65taZyqkDczUlzA6+vmtsqb/VjXziX
        yf5gn8tr41XD9n95n3L+51GTti8HlFiKMxINtZiLihMBERDFH/4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJLMWRmVeSWpSXmKPExsWy7bCSnG61s0eCwf4J/BZH/vczWhxfG+7A
        5HHn2h42j8+b5AKYorhsUlJzMstSi/TtErgyPi64wVqwSbzi/MXXzA2MC4S6GDk5JARMJFZ/
        fcTYxcjFISSwg1HiwaMHrBAJSYkTO58zQtjCEvdbjrBCFD1jlDi1YjEzSIJNQFti2sPdYA0i
        AjoSM940g9nMAvISb6+sgGqYyiTxddodJpAEp0CgxOcXj1i6GDk4hAXsJNb9jQAJswioSrya
        toYFxOYVsJR4vv4qE4QtKHFy5hMWiJnaEr0PWxlh5m9/O4cZ4jgFiZ9Pl0HtFZGY3dnGDDJe
        RMBN4sL+lAmMwrOQTJqFZNIsJJNmIelewMiyilEytaA4Nz232LDAKC+1XK84Mbe4NC9dLzk/
        dxMjOPS1tHYw7ln1Qe8QIxMH4yFGCQ5mJRFev+NuCUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwGSgFtXtWz2jufyBjszBpur9h1lefqP9MeR4tbK9u
        Z/iJiXzczPs/+ffCXRmrupnlBBYILVbk7HVqjPrt0ti4U2iz8stH4nO/lVvafw2xSWtKNlws
        fWal3NMvR/RzhAxPrZm75crK/Uw6CROa0k7d+akSuNfp/srrxuf10u6nnb58r3G25oNlG1ZV
        bF6x9nR2ccDsh3mabEHMwUFXhDbJqiis4nD9xfwq5e2s4r8rcvLTvjWdus4mZZ6bW1X9/JSa
        247nTW5b+hUe+FrPMg5avqnhi+Gu/3FiFx4Upq9/8OvkvOig338jih4+XH30SEPTmZIdh8Qt
        l/D7H5D5KLj1bfCJv+X+d5Y0R8xVsvH3VGIpzkg01GIuKk4EAP3XFM3sAgAA
X-CMS-MailID: 20210310035643epcas2p1be2a7534585656a0034e62cee9947e8d
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
        <CAPDyKFoEGp1CHo1OuTTeGqKkPG1Nke0k_rLBLSwmLH_BCcDDtA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> On Tue, 9 Mar 2021 at 14:07, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Tue, 9 Mar 2021 at 05:11, Kiwoong Kim <kwmad.kim@samsung.com> wrote:
> > >
> > > Dear All
> > >
> > > I want to discuss about this topic with you guys.
> > >
> > > There is an application to put many IO requests to a SD card right
> after completion of system resume.
> > > Current MMC stack invokes mmc_rescan asynchronously for
> PM_POST_SUSPEND.
> > > As reported to me, there could be a race between an IO thread and
> > > the kworker for mmc_rescan, especially when the application
> > > mentioned before is installed and the function of mmc_rescan is run
> later than expected For a series of IO requests, mmc_rescan, particularily
> at __mmc_claim_host called in mmc_sd_detect, didn't acquire a host for
> longer than expected.
> >
> > That's not a problem, in general.
> >
> > As long as the card is inserted and functional, the I/O operations
> > should be completed successfully. It doesn't matter if mmc_rescan() is
> > waiting to claim the host, as it's not important that it gets to run
> > as long as the card remains inserted/functional.
> >
> > >
> > > Below is the call stacks shown after the symptom happened and the
> system tried to enter into suspend again.
> > > In this case, mmc pm notifier is called with PM_SUSPEND_PREPARE, so it
> waits for completion or cancelling the work for mmc_rescan.
> > > For the latency, mobile users can see black screen for a long time
> sometimes, even with pushing a power button to wake up the system.
> >
> > I think I understand what you are saying, but please correct me if I am
> wrong.
> >
> > The I/O requests keep flowing into the blk queue even after
> > PM_SUSPEND_PREPARE has been fired, thus preventing the earlier
> > scheduled mmc_rescan() from claiming the host?
> >
> > This sounds quite reasonable that it could happen, at least
> > theoretically. Although, I am a bit surprised that nobody has reported
> > about this problem, until now. The design in the mmc core, has
> > remained unchanged in regards to this behaviour, for a very very long
> > time.
> >
> > Let me try to reproduce the problem, I will get back to you soon. In
> > the meantime, I would also appreciate it if you could share, more
> > exactly, how to trigger this problem at your side.
> 
> I have managed to reproduce the problem!  Wow, I wonder how this could
> have slipped through without anybody reporting about this, until now.
> So, thanks for bringing this to my attention!
> 
> My rough guess is that SD cards, used in these kinds of configurations
> (Android), are actually set to non removable. This would prevent
> mmc_rescan() from claiming the host.
> 
> In any case, this needs to be fixed properly. I will continue to work on a
> solution and get back to you with a patch. 

Okay and I'll also thing about its fix.

Thanks.
Kiwoong Kim

> 
> [...]
> 
> Kind regards
> Uffe

