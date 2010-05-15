From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] sdio: add new function for RAW (Read after Write)
	operation
Date: Sat, 15 May 2010 15:16:53 +0300
Message-ID: <AANLkTikSe8_KhkAzxRDizWB9o1FnCxulqvB2P3HVO7Gs@mail.gmail.com>
References: <1272403088-4727-1-git-send-email-notasas@gmail.com>
	 <AANLkTinEGhNI_n25FVZ4NrLr6ClNw3JVusnJVDZdQchn@mail.gmail.com>
	 <20100514150620.70323c76.akpm@linux-foundation.org>
	 <AANLkTilCD2wylI_11B_S9-SbktXvUYgYB7d224XIMRt1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:60105 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab0EOMQz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 May 2010 08:16:55 -0400
Received: by gwj19 with SMTP id 19so1764295gwj.19
        for <linux-mmc@vger.kernel.org>; Sat, 15 May 2010 05:16:55 -0700 (PDT)
In-Reply-To: <AANLkTilCD2wylI_11B_S9-SbktXvUYgYB7d224XIMRt1@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kalle Valo <kalle.valo@iki.fi>, linux-mmc@vger.kernel.org

On Sat, May 15, 2010 at 3:02 AM, Dmitry Shmidt <dimitrysh@google.com> wrote:
> Hi Andrew,
>
> wl1251 has some HW problem for ELP register that demands to do
> something like "write during read" in order
> not to loose bits from this register during simple read.
> Fortunately it was enough just to add low 8 bits previous register
> value to the cmd.args during read operation
> and SD Controller will behave as needed. And it was tested on real
> wl1251 device that is used in G1 and MyTouch.
>
> However, patch author for some reason is using WRITE operation instead of READ.
>>>> ret = mmc_io_rw_direct(func->card, 1, func->num, addr, b, &val);
>>>> 1 means WRITE
>
> Maybe in case of wl1251 HW it is not important - to write during read,
> or to read during write, but the problem in wl1251 was during ELP
> register READ operation, so I do not understand why author used WRITE
> flag.

Well like you said, 'wl1251 [...] demands to do something like "write
during read"', and SDIO spec provides exactly this functionality with
the RAW flag (quoting SDIO spec):

"If this bit [RAW] is set to 1 and the R/W flag is set to 1, then the
command shall read the value of the register after the write. This is
useful to allow writing to a control register and reading the status
at the same address."

If you pass WRITE flag and a pointer for read value to
mmc_io_rw_direct(), it sets the R/W and RAW bits in the CMD52 request.
According to my tests wl1251 actually ignores both R/W and RAW flags,
but by the looks of it it is expecting the RAW request. With my patch
we can add a function that both conforms the SDIO spec and suits
wl1251 hardware.

Does that make sense to you?
