From: Rabin Vincent <rabin@rab.in>
Subject: Re: [PATCH] mmc: fix card block compile warnings
Date: Fri, 23 Mar 2012 11:16:58 +0530
Message-ID: <CAH+eYFBvY0yJXKmDgRyKzS8ez8Q9OUkcOe2oebVdh+0xNbXqXQ@mail.gmail.com>
References: <1332401709-25513-1-git-send-email-linus.walleij@linaro.org>
 <4F6B05BB.3080109@stericsson.com> <CACRpkda7icH2E+394Aj0tkAoZG+2xMUOnd1KxnO=4Xz6TtvQEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41140 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941Ab2CWFrj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Mar 2012 01:47:39 -0400
Received: by iagz16 with SMTP id z16so4171486iag.19
        for <linux-mmc@vger.kernel.org>; Thu, 22 Mar 2012 22:47:38 -0700 (PDT)
In-Reply-To: <CACRpkda7icH2E+394Aj0tkAoZG+2xMUOnd1KxnO=4Xz6TtvQEQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, Chris Ball <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On Thu, Mar 22, 2012 at 23:32, Linus Walleij <linus.walleij@linaro.org> wrote:
> By reading the code you can easily see that the variables aren't
> actually used uninitialized, it's juts GCC that is unable to
> follow the code path and determine that they are initialized in
> all paths.

If the mmc_switch(..SANITIZE_START..) returns -EIO and mmc_blk_reset()
returns 0, then the variables _are_ used uninitialized.
