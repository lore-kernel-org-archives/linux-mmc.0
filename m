From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] mmc: core: Do not pre-claim host in suspend
Date: Thu, 19 Apr 2012 09:48:36 -0600
Message-ID: <CAMLZHHQVrog2srUhOjH5T3bQN4DjjP04x0ko3Bv9CXYyo_8i9Q@mail.gmail.com>
References: <1334829325-3464-1-git-send-email-ulf.hansson@stericsson.com>
	<CAMJBoFNO7aKge9BqawRJdr=k_HxOOaeoPaif1sed_vN7kSF35g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:49539 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001Ab2DSPsh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Apr 2012 11:48:37 -0400
Received: by vbbff1 with SMTP id ff1so5781536vbb.19
        for <linux-mmc@vger.kernel.org>; Thu, 19 Apr 2012 08:48:36 -0700 (PDT)
In-Reply-To: <CAMJBoFNO7aKge9BqawRJdr=k_HxOOaeoPaif1sed_vN7kSF35g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Ulf Hansson <ulf.hansson@stericsson.com>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

On Thu, Apr 19, 2012 at 4:02 AM, Vitaly Wool <vitalywool@gmail.com> wrote:
> I think it looks like a hack. Can you provide a better description of
> where this deadlock actually happens?
>
> If libertas_sdio claims host as a part of its suspend operation from a
> context different from the suspend context, isn't it libertas_sdio
> that has to be fixed?

libertas_sdio performs work in a workqueue during the suspend routine.
It doesn't take long, but it is essential.

Technically it would be possible to do the same work from the suspend
thread without changing context. However, implementation-wise this is
quite difficult. We cannot simply blast commands off to the card
directly, we have to obey various rules and keep things in sync. This
is done with an abstraction layer in the driver which is also shared
with equivalent devices that connect over USB, SPI, etc. Sometimes we
send commands from atomic context, or asynchronously, so thats why we
do things in a workqueue.

Breaking this abstraction for the suspend corner-case would be a pain,
and I don't agree with the strange requirement that SDIO drivers can't
communicate from other contexts in the suspend routine. My thoughts
are here: http://article.gmane.org/gmane.linux.kernel.mmc/13899

Ulf, you have understood the problem correctly and your patch solves
the issue. Thanks for the fast response.

Daniel
