From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Rebasing mmc/next
Date: Tue, 20 Jun 2017 10:07:44 +0200
Message-ID: <CAPDyKFpuBJCArAHUL2i=zDL=-Bq908eDJ2_mRy7O=_4bJj2_dw@mail.gmail.com>
References: <CAMuHMdW=aasYmZz-z+BgT0Qoco6DTyQxN3G1wiWVPETsbkRZTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34200 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752432AbdFTIHq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 20 Jun 2017 04:07:46 -0400
Received: by mail-qk0-f182.google.com with SMTP id d14so51545222qkb.1
        for <linux-mmc@vger.kernel.org>; Tue, 20 Jun 2017 01:07:45 -0700 (PDT)
In-Reply-To: <CAMuHMdW=aasYmZz-z+BgT0Qoco6DTyQxN3G1wiWVPETsbkRZTQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>

On 20 June 2017 at 09:17, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> It looks like you rebase mmc/next almost daily. Is there any specific reason
> for that?

I don't do it daily, but often, yes. :-)

>
> I'm asking because I create a "renesas-drivers" tree on a regular basis
> (cfr. e.g. https://www.spinics.net/lists/linux-renesas-soc/msg15111.html).
> This tree is meant to ease development of platform support and drivers
> for Renesas ARM SoCs. It is created by merging (a) the for-next branches
> of various subsystem trees and (b) branches with driver code submitted
> or planned for submission to maintainers into the development branch of
> Simon Horman's renesas.git tree.

If you are asking me to keep my next branch immutable, then please no,
I don't like to do that. Reason explained below.

I don't have a problem to share specific renesas mmc branches with
you, if that helps?

>
> If for (b), people submit driver code based on mmc/next, it may start
> to conflict
> with subsequent mmc/next releases soon, requiring the submitter or me to
> rebase the code before including it in renesas-drivers.
>
> Most subsystem maintainers don't rebase their for-next branch, unless there's
> a very good reason for it (e.g. a serious breakage hindering bisection).

I do it for a couple of reasons.

First, sometimes I apply changes before people have provided enough
tested by tags, to instead allow the changes to be tested in
linux-next. This may lead to some situations when I need to re-base my
next branch.
*) Something breaks, then I need to drop the changes. Revert doesn't
play well here, especially if it's a series of changes.
**) Avoid breaking bisect.
***) I want to give people cred, adding peoples tested-by, reviewed-by
tags, after the changes have been queued on my next branch.

Second, even if the changes queued on next has been thoroughly tested,
sometimes error reports still show up. I most cases I prefer to avoid
breaking bisect, which then leaves me in no other option, but
re-basing my branch (to either drop changes or amend them).

I guess what I can do, is to host a pre-next branch, which serves as
my pre-integration branch, before I moves things to next. However,
this does put some more administrative work on me, so I would like to
avoid that.

I am trying to understand the purpose of your renesas integration
tree, and why it's a problem for you to pick up my re-based branch?
Could you perhaps elaborate on this?

Kind regards
Uffe
