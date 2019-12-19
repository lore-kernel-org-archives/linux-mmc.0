Return-Path: <SRS0=Rhqe=2J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A056DC43603
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 15:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6497A206EC
	for <linux-mmc@archiver.kernel.org>; Thu, 19 Dec 2019 15:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W1HPx7+R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfLSPWX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 19 Dec 2019 10:22:23 -0500
Received: from mail-vk1-f177.google.com ([209.85.221.177]:38944 "EHLO
        mail-vk1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfLSPWX (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Dec 2019 10:22:23 -0500
Received: by mail-vk1-f177.google.com with SMTP id t129so1727132vkg.6
        for <linux-mmc@vger.kernel.org>; Thu, 19 Dec 2019 07:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kO6ms9LM3KmfoRRpx0AlzK9cpjR/UV9EXQd+k4hjG5o=;
        b=W1HPx7+RjePl0i6vpLdmaEJQQa2FSVZfVhVXzVwlLRfLnWK8prySx4g8OF6IcXEg1h
         aXE7MDjSPqktzG7Ff4IkJK3V0BbDiEuPrxwSUDHv7ZYmebIiU7Vz2hQ70w6NV2uI3IE0
         OhqkGHOaKtPEbtdCsmM+UkKKJJcMZ1y4pmHDrui3zlZISjKFcbDWx63SOTL/auoH1fjR
         8r6NIAPHxqSZrfR1jZDOH4uqvcWf+rMF82SXe0fUuxjYJe4+koCdaG9pKJh6zAwZ3886
         5kT3rmXX5HJ8njsuRlG8JeDyKcDWYZsqFhv/txDriAsNDig5Sv8SG8amxzHV7WZPR4BC
         C8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kO6ms9LM3KmfoRRpx0AlzK9cpjR/UV9EXQd+k4hjG5o=;
        b=SQ5Wdc1xi/95La1alC7w/edqbeLUCmNdz9ZBd24pg5+JpTaIbSGAMarEPfqvLDESy/
         DoAI5gyMBEEdCK31o6Olc4kIrOT1kR1ykRJH6JJ5V/XStXVV4wubG9vjF6MOsJwogWBL
         0CV3yc55JAyItoDgdHO7ED14lh/v4lYsBzfTwGxyhd2KSnBnY5mziYuGwKkKTeO6ej+S
         JVsbAkQYQg7LUQuW7V50FBS0CtFGq1kP7ZclMsVi2Hn5gi0H1pqd0qHYY4TF59YCj4M/
         EsSX3YlykrIdeJEDTxfMrz/wIJxiGcbu1CtMczdtfjOH6mVMjl5l7mwyxLICSXKN37qj
         e7vw==
X-Gm-Message-State: APjAAAW1qzN/fen7pDX2psjqpEqvy6EaVDM8dqbG0lX9yoZ6dmixu1rV
        MCBo15FnhqatkQpeJZpRDr2doaUrN2VUHspGeobvCYi+LTo=
X-Google-Smtp-Source: APXvYqwNiLkGhTXqvuYV5DkX06ksK3gwdnFIK9P94D1JIO0P/gzi8AbBlH8EljkOEwL5qAQ701JjW4z0UzEgfwHYMk0=
X-Received: by 2002:a1f:4541:: with SMTP id s62mr6291838vka.59.1576768941885;
 Thu, 19 Dec 2019 07:22:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1574073572.git.baolin.wang7@gmail.com> <81d66ceaa2763cfc1e5ccb605bb3a4194b947f0d.1574073572.git.baolin.wang7@gmail.com>
 <CAK8P3a1bUt+HERWtGEKmhdD9ctX0GRQQbXHxtUnJ8KNu=v87aw@mail.gmail.com>
 <CADBw62qW46KyEuj-YOw21sKxLB_uWxxWa_0-0JOXi-6Y48g0hw@mail.gmail.com>
 <CADBw62qvkjrhpR7gKpf6NZNHai96Pc8GLHM+5sgNffbWS54WYA@mail.gmail.com>
 <CAMz4kuJ2q_=kEcpz2+GJANdPm5DmwWMLbqBmZHGgtBiEhNFqzw@mail.gmail.com>
 <CAPDyKFp95H4KVrhiMD9H-C9iZHzEHufNPP95_X7DroYiR+nhHg@mail.gmail.com>
 <CAMz4kuKRna4s1g3pbw=kCuEnX2voFSh+cQ-mHkrWUoXF9p21XA@mail.gmail.com>
 <CAPDyKFo3ysxbJr=3fpaEq0rM0qSeCCkLcfA+7mcANQVXYoQ9oA@mail.gmail.com>
 <CAMz4kuLQLWYGKTKcycDqWXFPt-aXZvV=geQWbF_aEoh9PE37Yw@mail.gmail.com> <CAMz4kuKe+Xg=-N2e7V0_GBcddKzfRkt7zRG_j-vjGyFvkXcTMA@mail.gmail.com>
In-Reply-To: <CAMz4kuKe+Xg=-N2e7V0_GBcddKzfRkt7zRG_j-vjGyFvkXcTMA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 19 Dec 2019 16:21:45 +0100
Message-ID: <CAPDyKFoGkkW7_4CHXduWVsRPJRXL6hQL2QYqHg0SwJp3ckbcSA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] mmc: Add MMC host software queue support
To:     "(Exiting) Baolin Wang" <baolin.wang@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ linux-mmc

On Thu, 19 Dec 2019 at 08:26, (Exiting) Baolin Wang
<baolin.wang@linaro.org> wrote:
>
> Hi Ulf,
>
> On Fri, 13 Dec 2019 at 09:53, (Exiting) Baolin Wang
> <baolin.wang@linaro.org> wrote:
> >
> > Hi Ulf,
> >
> > On Thu, 12 Dec 2019 at 23:30, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > [...]
> > >
> > > > > > > > Ulf,
> > > > > > > >
> > > > > > > > I am not sure if there is any chance to merge this patch set into
> > > > > > > > V5.5, I've tested for a long time and did not find any resession.
> > > > > > > > Thanks.
> > > > > > >
> > > > > > > Could you apply this patchset if no objection from your side? Or do
> > > > > > > you need me to rebase and resend? Thanks.
> > > > > >
> > > > > > Sorry for troubling you in this way. Just want to make sure you did
> > > > > > not miss my V7 patchset for the MMC software queue, since it was
> > > > > > pending for a while, and I got a consensus with Arnd and Adrian
> > > > > > finally. Could you apply them if no objection from your side? As we
> > > > > > talked before, there are some packed request support patches will
> > > > > > depend on the MMC software queue. Thanks a lot.
> > > > >
> > > > > Thanks for reminding me! Apologize for the delays, just been too busy!
> > > >
> > > > No worries, I understood :)
> > > >
> > > > >
> > > > > Sounds promising! Let me have a closer look, by the end of this week.
> > > >
> > > > OK. Thank you very much.
> > >
> > > Baolin, I am looking at your series, but I need some more time. Yes,
> > > even more, sorry.
> > >
> > > I am out most of tomorrow and the entire weekend, so it seems like I
> > > will have to continue reviewing on Monday.
> >
> > Thanks for letting me know the patches' status. OK, no problem.
> >
>
> Apologize for reminding you again. :)
>
> I know next week will be your holiday, not sure if this patch set will
> be still pending for another long time. And the idea of the solution
> was discussed with Arnd and you, so I thought we all got a consensus
> about how to add the packed request support step by step. Moreover
> this patch set will not impact the normal routine without enabling MMC
> software queue and I already did lots of stable testing (including
> request handling, tuning and recovering).

Did you test system suspend/resume, while also having an ongoing
file/dd operations towards the mmc/sd card?

In any case, I am aware of the consensus - it looks promising. More
importantly, I appreciate the work you are doing here. Don't get me
wrong on that, even if I am causing these long an unacceptable delays
- sorry about that!

I have spent most of my reviewing time this week, looking at your
series, but it's not a trivial review and I want to take my time to
review it thoroughly. And fore sure, I fully respects Arnd and Adrian
reviews that is made already.

That said, I am sorry to disappoint you, but I am just not ready to
apply it yet.

In regards to the holidays, don't worry, I will be working. Well,
except for those days that are public holidays in Sweden. :-)

>
> We really want to use the packed request support with adding ADMA3
> transfer mode to improve the IO performance on our platform ASAP, and
> I think we still have more work and potential discussion to add the
> packed request support (maybe need optimize the blk-mq to support
> batch requests handling), but as we discussed before, we should
> introduce the MMC software queue first, then I can move on to the next
> step. I am sorry again to troubling you.

To help you out a bit in regards to this, I have hosted a separate
branch in my git tree that have the series applied (based on today's
"next" branch). The branch is namned "next_host_sq". I may decide to
merge it to next, to get some test coverage, but let's see about that.

In any case, feel free to base AMDA3 (packed command) support on the
new branch, at least for now.

Kind regards
Uffe
