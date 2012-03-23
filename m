From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] mmc: fix card block compile warnings
Date: Fri, 23 Mar 2012 10:05:37 +0100
Message-ID: <CACRpkdbjxoAR5GvFNc9nMNhFdZJxHwBmndRtyojKv8WdXex=6g@mail.gmail.com>
References: <1332401709-25513-1-git-send-email-linus.walleij@linaro.org>
	<4F6B05BB.3080109@stericsson.com>
	<CACRpkda7icH2E+394Aj0tkAoZG+2xMUOnd1KxnO=4Xz6TtvQEQ@mail.gmail.com>
	<CAH+eYFBvY0yJXKmDgRyKzS8ez8Q9OUkcOe2oebVdh+0xNbXqXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50388 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910Ab2CWJFh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Mar 2012 05:05:37 -0400
Received: by yenl12 with SMTP id l12so2533659yen.19
        for <linux-mmc@vger.kernel.org>; Fri, 23 Mar 2012 02:05:37 -0700 (PDT)
In-Reply-To: <CAH+eYFBvY0yJXKmDgRyKzS8ez8Q9OUkcOe2oebVdh+0xNbXqXQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Rabin Vincent <rabin@rab.in>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Fri, Mar 23, 2012 at 6:46 AM, Rabin Vincent <rabin@rab.in> wrote:
> On Thu, Mar 22, 2012 at 23:32, Linus Walleij <linus.walleij@linaro.org> wrote:
>> By reading the code you can easily see that the variables aren't
>> actually used uninitialized, it's juts GCC that is unable to
>> follow the code path and determine that they are initialized in
>> all paths.
>
> If the mmc_switch(..SANITIZE_START..) returns -EIO and mmc_blk_reset()
> returns 0, then the variables _are_ used uninitialized.

Argh! You're right. (As usual.)

But that makes me wonder if the code flow is even correct
for sanitize.

I'll have a closer look and come up with something better!

Thanks,
Linus Walleij
