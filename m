From: Grant Grundler <grundler@chromium.org>
Subject: Re: [RFC PATCH 1/1 v6 ]mmc: Support-FFU-for-eMMC-v5.0
Date: Fri, 9 May 2014 09:44:54 -0700
Message-ID: <CANEJEGvPyHhWDSykx_zdEiA7WOYMkFtDwWjhF9kjo-7+Hp_EYQ@mail.gmail.com>
References: <FDD07FEB422EF948A392FDC201AEEAE641188997@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57294 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754465AbaEIQoy (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 May 2014 12:44:54 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so5081044obc.5
        for <linux-mmc@vger.kernel.org>; Fri, 09 May 2014 09:44:54 -0700 (PDT)
In-Reply-To: <FDD07FEB422EF948A392FDC201AEEAE641188997@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Avi Shchislowski <Avi.Shchislowski@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, Grant Grundler <grundler@chromium.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

Hi Avi,
Thanks for persistently following up on this. :)

Two nits below.

On Wed, Apr 23, 2014 at 12:40 AM, Avi Shchislowski
<Avi.Shchislowski@sandisk.com> wrote:
> Change the patch version number from V4 to v5 The Field Firmware Update (FFU)
> feature is new for eMMC 5.0 spec (Jedec: JESD84-B50.pdf)
>   http://www.jedec.org/standards-documents/technology-focus-areas/flash-memory-ssds-ufs-emmc/e-mmc
>
> An ioctl has been added to provide the new firmware image's file name to the
>  mmc driver and udev is then used to retrieve its data.
>
> Two new ioctls have been added:
> 1. FFU download firmware - transfer the new firmware data from user space to the eMMC device
> 2. FFU install - initializes the new firmware update
>
> This patch version (V5) provides udev (request_firmware) implementation as
> advised in patch v2 comments.

Dialog about patch versions don't belong in the commit log.
Add "---" after the Signed-off-by" lines and add patch revision
comments there so reviewers know what changed with each new patch
revision - should be a short list of one-liners for each version.
Example below.

> Signed-off-by: Avi Shchislowski <avi.shchislowski@sandisk.com>
> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>

Reviewed-by: Grant Grundler <grundler@chromium.org>

I'm working on testing this which is why pwclient found the next nit
on "line 678" (see below).

And add the patch version comments here:
----
V5:
- provides udev (request_firmware) implementation as advised in patch
v2 comments.

> diff --git a/drivers/mmc/card/Kconfig b/drivers/mmc/card/Kconfig index 5562308..19ba729 100644
> --- a/drivers/mmc/card/Kconfig
> +++ b/drivers/mmc/card/Kconfig
> @@ -68,3 +68,11 @@ config MMC_TEST
>
>           This driver is only of interest to those developing or
>           testing a host driver. Most people should say N here.
> +
> +config MMC_FFU
> +       bool "FFU SUPPORT"
> +       depends on MMC != n
> +       help
> +         This is an option to run firmware update on eMMC 5.0.
> +         Field firmware updates (FFU) enables features enhancment
> +         in the field.
> diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile index c73b406..1e9223b 100644
...
> diff --git a/include/linux/mmc/ffu.h b/include/linux/mmc/ffu.h new file mode 100644 index 0000000..be70880

This diff line "looks correct" to me. But pwclient reported this error:
$ pwclient list -p linux-mmc -w "Avi Shchislowski"
Patches submitted by Avi Shchislowski <Avi.Shchislowski@sandisk.com>:
...
4039281 New          [RFC,1/1,v6] mmc: Support-FFU-for-eMMC-v5.0
...
$ pwclient apply 4039281
...
patching file drivers/mmc/card/ffu.c
patch: **** malformed patch at line 678: diff --git
a/include/linux/mmc/ffu.h b/include/linux/mmc/ffu.h new file mode
100644 index 0000000..be70880

and then did not create the new file.  Is it obvious to anyone else
why this failed?

I'll fix-up by hand for now.

thanks,
grant

ps. for folks not familiar with pwclient, my 5 line ~/.pwclientrc is
all you need to get started:
grundler@firesword:~$ cat .pwclientrc
[base]
url: https://patchwork.kernel.org/xmlrpc/
project: linux-arm-kernel
project: LKML
project: linux-mmc
