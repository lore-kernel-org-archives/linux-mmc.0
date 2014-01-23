From: Chris Ball <chris@printf.net>
Subject: Re: [PATCH] mmc-utils: add eMMC 5.0 FFU support
Date: Thu, 23 Jan 2014 18:42:39 +0000
Message-ID: <86ob321qw0.fsf@void.printf.net>
References: <1390501260-8730-1-git-send-email-grundler@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35675 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbaAWSmm (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 23 Jan 2014 13:42:42 -0500
In-Reply-To: <1390501260-8730-1-git-send-email-grundler@chromium.org> (Grant
	Grundler's message of "Thu, 23 Jan 2014 10:21:00 -0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Puthikorn Voravootivat <puthik@chromium.org>, Gwendal Grignou <gwendal@chromium.org>

Hi Grant,

On Thu, Jan 23 2014, Grant Grundler wrote:
> --- a/Makefile
> +++ b/Makefile
> @@ -1,7 +1,7 @@
>  CC ?= gcc
>  AM_CFLAGS = -D_FILE_OFFSET_BITS=64 -D_FORTIFY_SOURCE=2
>  CFLAGS ?= -g -O2
> -objects = mmc.o mmc_cmds.o
> +objects = mmc.o mmc_cmds.o mmc_cmds-emmc5.o
>  
>  CHECKFLAGS = -Wall -Werror -Wuninitialized -Wundef
>  
> @@ -44,7 +44,7 @@ clean:
>  	$(MAKE) -C man clean

The patch looks good, but doesn't apply because "$(MAKE) -C man clean"
does not exist in mainline mmc-utils and never has.  Could you check
for local patches (and ideally push them up to me too)?

Thanks,

- Chris.
-- 
Chris Ball   <chris@printf.net>   <http://printf.net/>
