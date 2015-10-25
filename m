From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: CONFIG_CGROUP_WRITEBACK=y/n complexity (was: Re: Build
 regressions/improvements in v4.3-rc7)
Date: Sun, 25 Oct 2015 11:54:38 +0100
Message-ID: <CAMuHMdUcbE20kH7-gZ4i8978Smf7K3QYDwzRVRQoL3nOMYpurw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34745 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbbJYKyj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 25 Oct 2015 06:54:39 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@fb.com>, Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Oct 25, 2015 at 11:12 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.3-rc7[1] compared to v4.2[2].
>
> Summarized:
>   - build errors: +13/-8
>   - build warnings: +160/-100
>
> JFYI, when comparing v4.3-rc7[1] to v4.3-rc6[3], the summaries are:
>   - build errors: +12/-4
>   - build warnings: +42/-40

> [1] http://kisskb.ellerman.id.au/kisskb/head/9511/ (256 out of 254 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/head/9309/ (all 254 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/9487/ (255 out of 254 configs)

> *** WARNINGS ***
>
> 160 regressions:

>   + /home/kisskb/slave/src/mm/page-writeback.c: warning: 'filepages' is used uninitialized in this function:  => 1582, 1908
>   + /home/kisskb/slave/src/mm/page-writeback.c: warning: 'headroom' is used uninitialized in this function:  => 1582, 1908

Please refactor this code. It falls under the "so complicated that there are
no obvious deficiencies " category
(https://en.wikiquote.org/wiki/C._A._R._Hoare).

Thanks a lot!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
