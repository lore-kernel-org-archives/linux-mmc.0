From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [RFC] Mobile Storage Host support
Date: Tue, 21 Sep 2010 20:46:34 +0900
Message-ID: <AANLkTimCe5fWhE1hj7ggemed54Rvvq2wr5vD+Ua+OC3u@mail.gmail.com>
References: <AANLkTim-8G00qO=PkHVn3ytH-Akc0x1zuO_4iUYQXWPS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:50332 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab0IULqf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Sep 2010 07:46:35 -0400
Received: by wwi18 with SMTP id 18so51279wwi.1
        for <linux-mmc@vger.kernel.org>; Tue, 21 Sep 2010 04:46:34 -0700 (PDT)
In-Reply-To: <AANLkTim-8G00qO=PkHVn3ytH-Akc0x1zuO_4iUYQXWPS@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org, =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>

Are there anyone who interest in Mobile Storage Host?

On Fri, Sep 17, 2010 at 1:45 PM, Kyungmin Park <kmpark@infradead.org> wrote:
> Hi,
>
> Now we implemented the mobile storage and want to posting it to mmc.
> But during code review I know that it's almost similar with sdhci core
> except register offset and fifo support.
>
> So I wonder what's the better way to implement it.
> 1) create the mstorage.[ch]
> 2) override the existing sdhci using io accessors function.
>
> Basic Mobile Storage Host controller register is following.
>
> CTRL: 0x0000
> PWREN: 0x0004
> CLKDIV: 0x0008
> CLKSRC: 0x000C
> CLKENA: 0x0010
> TMOUT: 0x0014
> CTYPE: 0x0018
> BLKSIZ: 0x001C
> BYTCNT: 0x0020
> INTMASK: 0x0024
> CMDARG: 0x0028
> CMD: 0x002C
> ...
>
> Any comments are welcome.
>
> Thank you,
> Kyungmin Park
>
