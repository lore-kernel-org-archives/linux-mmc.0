Return-Path: <SRS0=h+Av=2K=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04472C43603
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Dec 2019 03:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B94AE24680
	for <linux-mmc@archiver.kernel.org>; Fri, 20 Dec 2019 03:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPzdJZcT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLTDvO (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Dec 2019 22:51:14 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:39744 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbfLTDvN (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2019 22:51:13 -0500
Received: by mail-lj1-f178.google.com with SMTP id l2so8511927lja.6
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2019 19:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8YLycFBQH4SnGMAqLWqxqkPhVwu4m6I6KhqF97eA2I=;
        b=OPzdJZcTed0HiaRSHQFGwvw75WIOaO04DPufOA/Siwaa3ihQ4x+r+4QwBQnR39BfbB
         mFgiQrg4Yv3u4G5bE2PhhRPS3A2+om/MLSrXQ0Ki4Aal6N7DXzB1aQ9na4lsLenwhE1k
         Mhwxk1oEd4Rfc7fsKCacSosbNs7c8p8O3YGWRPFjHZguG1mAwlesJCcVuCP8mF6g/5uM
         OZkntiNKf8Jhu0jmRARoUjINp50zqOhp8f0gQ/GkXXbs2uWcJ2Wp+1Lgo6w6Ob8V8fDe
         R7SoPR4m1zbVMKSKc8KvZIb2lsbajF8t7HToMvLFuCGlVSfYWlsDu6f6Ptb6VyjIVWBa
         Vg2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8YLycFBQH4SnGMAqLWqxqkPhVwu4m6I6KhqF97eA2I=;
        b=KNPAa/6JonmvqRWDy2fha/dp+L7l5/S3TTrZklehfPEOSZ7s7i5rowAZkGW0leDOwK
         QDluYXDSFUfqd+pvHQNUHUf+niy64WvnQOmFDVCMycjlcADFPZ3P3BkSHcVMn5ozmc4h
         VqK7Qw7IZQRu7TD3nDSYgyLzApGIwXBq/YgpeG6TOQfuszwyIMrAkBiDRwSCr5wK96mu
         Gt1Slvu+ixgTqBOgzzAPd52RDOW4mFTRZtZegZ8JpxLZ5aHGI2RKdViwkFXWXrQFaBh6
         8QDBG0qEOJu3wEw45y0c7YbKgrtSqgiLpXthHOmN98Ex6QamiVFhrlEw1WGodpJwpjDS
         h2bg==
X-Gm-Message-State: APjAAAXNncSOV3/8phTS8+RCL4E4FwDcN4/MiZuMyxmuxHZl3+AsA1Um
        12s9KhaP8aCKCXN4dk4ZXaNba1dudlL1BQQC9CgYaQ==
X-Google-Smtp-Source: APXvYqzTyV8JYG9XymAo9uYAUpTeUxgJmVkm2BlczkXM4QF6S9zRgBTSr1OKPWUrqG6q9GfDpKCVdNnPQxu4Fw+Py48=
X-Received: by 2002:a2e:8551:: with SMTP id u17mr3437218ljj.165.1576813871303;
 Thu, 19 Dec 2019 19:51:11 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574073572.git.baolin.wang7@gmail.com> <81d66ceaa2763cfc1e5ccb605bb3a4194b947f0d.1574073572.git.baolin.wang7@gmail.com>
 <CAK8P3a1bUt+HERWtGEKmhdD9ctX0GRQQbXHxtUnJ8KNu=v87aw@mail.gmail.com>
 <CADBw62qW46KyEuj-YOw21sKxLB_uWxxWa_0-0JOXi-6Y48g0hw@mail.gmail.com>
 <CADBw62qvkjrhpR7gKpf6NZNHai96Pc8GLHM+5sgNffbWS54WYA@mail.gmail.com>
 <CAMz4kuJ2q_=kEcpz2+GJANdPm5DmwWMLbqBmZHGgtBiEhNFqzw@mail.gmail.com>
 <CAPDyKFp95H4KVrhiMD9H-C9iZHzEHufNPP95_X7DroYiR+nhHg@mail.gmail.com>
 <CAMz4kuKRna4s1g3pbw=kCuEnX2voFSh+cQ-mHkrWUoXF9p21XA@mail.gmail.com>
 <CAPDyKFo3ysxbJr=3fpaEq0rM0qSeCCkLcfA+7mcANQVXYoQ9oA@mail.gmail.com>
 <CAMz4kuLQLWYGKTKcycDqWXFPt-aXZvV=geQWbF_aEoh9PE37Yw@mail.gmail.com>
 <CAMz4kuKe+Xg=-N2e7V0_GBcddKzfRkt7zRG_j-vjGyFvkXcTMA@mail.gmail.com> <CAPDyKFoGkkW7_4CHXduWVsRPJRXL6hQL2QYqHg0SwJp3ckbcSA@mail.gmail.com>
In-Reply-To: <CAPDyKFoGkkW7_4CHXduWVsRPJRXL6hQL2QYqHg0SwJp3ckbcSA@mail.gmail.com>
From:   "(Exiting) Baolin Wang" <baolin.wang@linaro.org>
Date:   Fri, 20 Dec 2019 11:50:59 +0800
Message-ID: <CAMz4kuK8V5Ng01GHWHhOCTmvm5wOyOBa+dtpmQVn5JbbV92DPw@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mmc: Add MMC host software queue support
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Ulf,

On Thu, 19 Dec 2019 at 23:22, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> + linux-mmc
>
> On Thu, 19 Dec 2019 at 08:26, (Exiting) Baolin Wang
> <baolin.wang@linaro.org> wrote:
> >
> > Hi Ulf,
> >
> > On Fri, 13 Dec 2019 at 09:53, (Exiting) Baolin Wang
> > <baolin.wang@linaro.org> wrote:
> > >
> > > Hi Ulf,
> > >
> > > On Thu, 12 Dec 2019 at 23:30, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > >
> > > > [...]
> > > >
> > > > > > > > > Ulf,
> > > > > > > > >
> > > > > > > > > I am not sure if there is any chance to merge this patch set into
> > > > > > > > > V5.5, I've tested for a long time and did not find any resession.
> > > > > > > > > Thanks.
> > > > > > > >
> > > > > > > > Could you apply this patchset if no objection from your side? Or do
> > > > > > > > you need me to rebase and resend? Thanks.
> > > > > > >
> > > > > > > Sorry for troubling you in this way. Just want to make sure you did
> > > > > > > not miss my V7 patchset for the MMC software queue, since it was
> > > > > > > pending for a while, and I got a consensus with Arnd and Adrian
> > > > > > > finally. Could you apply them if no objection from your side? As we
> > > > > > > talked before, there are some packed request support patches will
> > > > > > > depend on the MMC software queue. Thanks a lot.
> > > > > >
> > > > > > Thanks for reminding me! Apologize for the delays, just been too busy!
> > > > >
> > > > > No worries, I understood :)
> > > > >
> > > > > >
> > > > > > Sounds promising! Let me have a closer look, by the end of this week.
> > > > >
> > > > > OK. Thank you very much.
> > > >
> > > > Baolin, I am looking at your series, but I need some more time. Yes,
> > > > even more, sorry.
> > > >
> > > > I am out most of tomorrow and the entire weekend, so it seems like I
> > > > will have to continue reviewing on Monday.
> > >
> > > Thanks for letting me know the patches' status. OK, no problem.
> > >
> >
> > Apologize for reminding you again. :)
> >
> > I know next week will be your holiday, not sure if this patch set will
> > be still pending for another long time. And the idea of the solution
> > was discussed with Arnd and you, so I thought we all got a consensus
> > about how to add the packed request support step by step. Moreover
> > this patch set will not impact the normal routine without enabling MMC
> > software queue and I already did lots of stable testing (including
> > request handling, tuning and recovering).
>
> Did you test system suspend/resume, while also having an ongoing
> file/dd operations towards the mmc/sd card?

Yes, I did and it can work.

>
> In any case, I am aware of the consensus - it looks promising. More
> importantly, I appreciate the work you are doing here. Don't get me
> wrong on that, even if I am causing these long an unacceptable delays
> - sorry about that!
>
> I have spent most of my reviewing time this week, looking at your
> series, but it's not a trivial review and I want to take my time to

Thanks for spending time on this patch set.

> review it thoroughly. And fore sure, I fully respects Arnd and Adrian
> reviews that is made already.
>
> That said, I am sorry to disappoint you, but I am just not ready to
> apply it yet.
>
> In regards to the holidays, don't worry, I will be working. Well,
> except for those days that are public holidays in Sweden. :-)
>
> >
> > We really want to use the packed request support with adding ADMA3
> > transfer mode to improve the IO performance on our platform ASAP, and
> > I think we still have more work and potential discussion to add the
> > packed request support (maybe need optimize the blk-mq to support
> > batch requests handling), but as we discussed before, we should
> > introduce the MMC software queue first, then I can move on to the next
> > step. I am sorry again to troubling you.
>
> To help you out a bit in regards to this, I have hosted a separate
> branch in my git tree that have the series applied (based on today's
> "next" branch). The branch is namned "next_host_sq". I may decide to
> merge it to next, to get some test coverage, but let's see about that.
>
> In any case, feel free to base AMDA3 (packed command) support on the
> new branch, at least for now.

Great, thanks for your help.


--
Baolin Wang
Best Regards
