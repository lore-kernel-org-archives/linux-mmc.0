From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v2 3/5] mmc: dw_mmc: Add locking to the CTO timer
Date: Mon, 23 Oct 2017 10:59:02 -0700
Message-ID: <CAD=FV=XdWD1dk67yixy+5U7RubxKY2WAh-jhZfTOmb4ndf3b5g@mail.gmail.com>
References: <20171012201118.23570-1-dianders@chromium.org> <20171012201118.23570-4-dianders@chromium.org>
 <41ae1571-4723-2700-1f03-7215e874c42e@rock-chips.com> <CAD=FV=UMuJBKV2-pNo4yiyfxXxYJo_tX6RkxCCzm_UFg9XyjyQ@mail.gmail.com>
 <d6acce96-b292-ee4e-8f9b-1d524c14e0fc@rock-chips.com> <CAD=FV=W7u0_kr9HXHpKmw=Hgco2P=u3jeSb8v0OoVvD+2kJorw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:55151 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932180AbdJWR7E (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Oct 2017 13:59:04 -0400
Received: by mail-ua0-f173.google.com with SMTP id n38so13525470uai.11
        for <linux-mmc@vger.kernel.org>; Mon, 23 Oct 2017 10:59:04 -0700 (PDT)
In-Reply-To: <CAD=FV=W7u0_kr9HXHpKmw=Hgco2P=u3jeSb8v0OoVvD+2kJorw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ziyuan Xu <xzy.xu@rock-chips.com>, Alexandru M Stan <amstan@chromium.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Brian Norris <briannorris@chromium.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>

Hi,

On Tue, Oct 17, 2017 at 9:40 AM, Doug Anderson <dianders@chromium.org> wrote:
> ...
> ...
>> Yes, it looks hard to get concurrency right. I have a comment for your
>> DRTO case(patch 5). Let's do some brainstorm there.
>
> Since your comments in this patch are positive and you've now added
> your Reviewed-by to patch #5, I'm going to assume that you'd also like
> your Reviewed-by on this patch?
>
>
> Jaehoon: I think I have Shawn's review on all this series.  It would
> be great if you could review them yourself and/or pick them up in your
> tree.  Since they fix a regression on 4.14 we really don't want to
> delay too long.  If you're busy, please yell and we can figure out a
> way to get these in (either through Ulf directly or we should find
> someone else to make a git tree and send a pull request).

Ulf: I still haven't heard anything for Jaehoon.  Do you have any
interest in landing this series directly to your tree?  I think the
whole series has been reviewed by Shawn.  I'm happy to re-post with
collected tags or anything else you'd like.  It would be nice to get
the regression fixed sooner rather than later...

Thanks!  :)

-Doug
