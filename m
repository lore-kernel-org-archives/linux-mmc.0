From: Johan Rudholm <jrudholm@gmail.com>
Subject: Re: [PATCH] mmc-utils: Support enable/disable of eMMC H/W Reset function
Date: Mon, 22 Oct 2012 09:11:47 +0200
Message-ID: <CA+20K0CnJvJ5wQ9=S4J5MQOqT5+0xp6swLAEk6gbVwe1OeKFyA@mail.gmail.com>
References: <87lif2tal8.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:34743 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059Ab2JVHLr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Oct 2012 03:11:47 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so3147721iea.19
        for <linux-mmc@vger.kernel.org>; Mon, 22 Oct 2012 00:11:47 -0700 (PDT)
In-Reply-To: <87lif2tal8.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

Hi,

2012/10/19 Chris Ball <cjb@laptop.org>:
> (Note: one-time programmable fuse.)
>
> $ mmc hwreset enable /dev/mmcblk0
> $ mmc hwreset disable /dev/mmcblk0
> ---
>  mmc.c      | 10 ++++++++++
>  mmc.h      |  4 ++++
>  mmc_cmds.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  mmc_cmds.h |  2 ++
>  4 files changed, 75 insertions(+)

we've played around with this feature a bit, and if the reset pin is
not connected to for instance a GPIO, enabling the reset can give
really interesting results :) But if it's connected on the other hand,
it works fine...

Acked-By: Johan Rudholm <johan.rudholm@stericsson.com>

Kind regards, Johan
