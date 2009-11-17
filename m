From: Minchan Kim <minchan.kim@gmail.com>
Subject: Re: [PATCH 2/7] mmc: Don't use PF_MEMALLOC
Date: Tue, 17 Nov 2009 19:32:36 +0900
Message-ID: <28c262360911170232i307144cnb4ddea2a5389bd8e@mail.gmail.com>
References: <20091117161551.3DD4.A69D9226@jp.fujitsu.com>
	 <20091117161711.3DDA.A69D9226@jp.fujitsu.com>
	 <20091117102903.7cb45ff3@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pz0-f171.google.com ([209.85.222.171]:63994 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753150AbZKQKca convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Nov 2009 05:32:30 -0500
In-Reply-To: <20091117102903.7cb45ff3@lxorguk.ukuu.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

On Tue, Nov 17, 2009 at 7:29 PM, Alan Cox <alan@lxorguk.ukuu.org.uk> wr=
ote:
> On Tue, 17 Nov 2009 16:17:50 +0900 (JST)
> KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com> wrote:
>
>> Non MM subsystem must not use PF_MEMALLOC. Memory reclaim need few
>> memory, anyone must not prevent it. Otherwise the system cause
>> mysterious hang-up and/or OOM Killer invokation.
>
> So now what happens if we are paging and all our memory is tied up fo=
r
> writeback to a device or CIFS etc which can no longer allocate the me=
mory
> to complete the write out so the MM can reclaim ?
>
> Am I missing something or is this patch set not addressing the case w=
here
> the writeback thread needs to inherit PF_MEMALLOC somehow (at least f=
or
> the I/O in question and those blocking it)
>

I agree.
At least, drivers for writeout is proper for using PF_MEMALLOC, I think=
=2E


> Alan
>
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org. =C2=A0For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=3Dmailto:"dont@kvack.org"> email@kvack.org </a>
>



--=20
Kind regards,
Minchan Kim
