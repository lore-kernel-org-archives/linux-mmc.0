From: Sebastian Rasmussen <sebras@gmail.com>
Subject: Re: [PATCH] mmc: boot partition ro lock support
Date: Sun, 23 Oct 2011 02:51:13 +0200
Message-ID: <CAAgDR1P0F1oue29jj-N3AU60JkEJ7qQtt1oLURSNzptjaQLa7A@mail.gmail.com>
References: <1817564019.180377.1319247876337.JavaMail.root@zimbra-prod-mbox-2.vmware.com>
	<m24nz171vj.fsf@bob.laptop.org>
	<CACRpkdY5T+QoyLvsPmwQRcNPoV=U=46LRGzKvK_8fSL8kurSwA@mail.gmail.com>
	<m2vcrh55lm.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:38538 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753075Ab1JWAvO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Oct 2011 20:51:14 -0400
Received: by ggnb1 with SMTP id b1so4832686ggn.19
        for <linux-mmc@vger.kernel.org>; Sat, 22 Oct 2011 17:51:13 -0700 (PDT)
In-Reply-To: <m2vcrh55lm.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andrei Warkentin <awarkentin@vmware.com>, Ulf Hansson <ulf.hansson@stericsson.com>, Per Forlin <per.forlin@stericsson.com>, Lee Jones <lee.jones@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, John Beckett <john.beckett@stericsson.com>, linux-mmc@vger.kernel.org

Hi!

> What we're worried about is someone issuing the perm read-only command,
> and not realizing that it really means that they can never ever write
> any more changes to their eMMC -- it's a one-time fuse

I can see why you are worried that people may brick their devices.
How about only adding the read-only-until-power-cycled command?

> I'd rather leave it to specialized manufacturing equipment.

Sure, but then again permanent read-only commands seem to be
able to be sent by writing a userspace tool that issues a ioctl(fd, 0xb3, ...)
using the generic command interface by John Calixto mentioned by
Andrei. I assume that what reassures you in this case is
that CAP_SYS_RAWIO is required and perhaps also obscurity?

 / Sebastian
