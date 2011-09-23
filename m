From: "Andrei E. Warkentin" <andrey.warkentin@gmail.com>
Subject: Re: [PATCH 1/2] mmc: block: fix boot partition switch error path
Date: Fri, 23 Sep 2011 09:20:16 -0400
Message-ID: <CANz0V+4GtyYLNEJdZp4MFoXGs8ZbfKScdFjHR0Wm6u1_C1hCJw@mail.gmail.com>
References: <1316771301-12323-1-git-send-email-adrian.hunter@intel.com>
	<1316771301-12323-2-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45222 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753520Ab1IWNUR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Sep 2011 09:20:17 -0400
Received: by wwf22 with SMTP id 22so3655902wwf.1
        for <linux-mmc@vger.kernel.org>; Fri, 23 Sep 2011 06:20:16 -0700 (PDT)
In-Reply-To: <1316771301-12323-2-git-send-email-adrian.hunter@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc <linux-mmc@vger.kernel.org>

Hi Adrian,

2011/9/23 Adrian Hunter <adrian.hunter@intel.com>:
> In the case of a switch error, do not update partition
> config as though the switch succeeded, and ensure
> blk_end_request is called on the failed request.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> =C2=A0drivers/mmc/card/block.c | =C2=A0 16 +++++++++++++---
> =C2=A01 files changed, 13 insertions(+), 3 deletions(-)
>

Thanks for catching these.

Acked-by: Andrei Warkentin <andrey.warkentin@gmail.com>
