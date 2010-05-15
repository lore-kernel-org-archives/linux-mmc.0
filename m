From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] sdio: add new function for RAW (Read after Write)
	operation
Date: Sat, 15 May 2010 23:46:31 +0300
Message-ID: <AANLkTimyIuNIUTnT5BVE_tJHGhwHMa8hBDd4yB4H-Zcu@mail.gmail.com>
References: <1272403088-4727-1-git-send-email-notasas@gmail.com>
	 <AANLkTinEGhNI_n25FVZ4NrLr6ClNw3JVusnJVDZdQchn@mail.gmail.com>
	 <20100514150620.70323c76.akpm@linux-foundation.org>
	 <AANLkTilCD2wylI_11B_S9-SbktXvUYgYB7d224XIMRt1@mail.gmail.com>
	 <AANLkTikSe8_KhkAzxRDizWB9o1FnCxulqvB2P3HVO7Gs@mail.gmail.com>
	 <AANLkTin5TMVmq92bueC-0zZZbjcYM1MObLzPPY4ucq0h@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65271 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab0EOUqc (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 May 2010 16:46:32 -0400
Received: by gyg13 with SMTP id 13so1573843gyg.19
        for <linux-mmc@vger.kernel.org>; Sat, 15 May 2010 13:46:31 -0700 (PDT)
In-Reply-To: <AANLkTin5TMVmq92bueC-0zZZbjcYM1MObLzPPY4ucq0h@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Shmidt <dimitrysh@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kalle Valo <kalle.valo@iki.fi>, linux-mmc@vger.kernel.org

On Sat, May 15, 2010 at 7:25 PM, Dmitry Shmidt <dimitrysh@google.com> wrote:
> Hi Grazvydas,
>
> You are right.
> mmc_io_rw_direct() implementation doesn't check R/W flag and returns
> data if "out" != NULL.
> So if SDIO spec "demands" WRITE flag and wl1251 ignores it anyway,
> then we should use WRITE.
> You function name is slightly confusing I would say, but I am fine
> with the patch.

I found it a bit hard to find a fitting name that would be similar to
other SDIO function names so I'm open to suggestions. Few other names:

sdio_read_after_write_b
sdio_rawb

Maybe our kernel veteran Andrew can suggest us something? :-)
