From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: SDIO runtime crash on resume
Date: Fri, 29 Oct 2010 17:10:42 +0200
Message-ID: <AANLkTikti+UeYTer6h65c=3AqastJ5rg3Ohh1YmYTdcU@mail.gmail.com>
References: <AANLkTikVuQx+hUX8onLVdHW1mhfbH7MZJqsHt0s-baiA@mail.gmail.com>
 <AANLkTi=0oL38cmbGJ3sfE876ZxJUfrKK+wTs5+JBTR_r@mail.gmail.com>
 <AANLkTinjXQy9Hcu68DmQ-Xq59P=PNq==m1FYKviz1Pe3@mail.gmail.com> <AANLkTik6y-_=TZb9qbDf66C4q+eoiZbvCZtrtcAAKYpj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:38908 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757323Ab0J2PLE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2010 11:11:04 -0400
Received: by yxk8 with SMTP id 8so1684381yxk.19
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2010 08:11:03 -0700 (PDT)
In-Reply-To: <AANLkTik6y-_=TZb9qbDf66C4q+eoiZbvCZtrtcAAKYpj@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On Fri, Oct 29, 2010 at 4:48 PM, Daniel Drake <dsd@laptop.org> wrote:
>> - Just for general knowledge - as soon as you load your driver
>> (libertas, right ?) - was your card powered up and correctly
>> configured (sdio clock/voltage/bus width. again check with
>> /sys/kernel/debug/mmc2/ios) ?
>
> No driver for this hardware was loaded.

Yeah, still that question is relevant because both scenarios have very
similar code paths.

> Config is here:
> http://dev.laptop.org/~dsd/20101029/xo1p5-config
> Note that anything built as a module is not available on the setup in
> question where the bug was found. So =m may as well say "is not set"

OK, thanks !

> If you still need it, I'll try and get the other info to you soon.

I'm anxious to get it :), but Chris will have an XO-1.5 at LPC, which
is just around the corner, so I don't mind waiting a bit. Having a
setup with a reproducible bug in front of me would make life very
easy.

Thanks again,
Ohad.
