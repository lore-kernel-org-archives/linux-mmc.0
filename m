From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCH 1/1] mmc:Extension of MMC Block IOCTL Command support for
 testing of non read/write Commands
Date: Thu, 17 Nov 2011 16:04:38 +0530
Message-ID: <CANfBPZ93C1JSqLJNvO==O_Rg4h_6p6Q3Nmcx+M9NFUtMOgVYbg@mail.gmail.com>
References: <1321441734-24191-1-git-send-email-shashidharh@vayavyalabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:38090 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755511Ab1KQKfD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 17 Nov 2011 05:35:03 -0500
Received: by mail-yw0-f47.google.com with SMTP id 2so939216ywt.20
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2011 02:35:01 -0800 (PST)
In-Reply-To: <1321441734-24191-1-git-send-email-shashidharh@vayavyalabs.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Jaehoon Chung <jh80.chung@samsung.com>, Philip Rakity <prakity@marvell.com>, Girish K S <girish.shivananjappa@linaro.org>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Aries Lee <arieslee@jmicron.com>, Arindam Nath <arindam.nath@amd.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Arnd Bergmann <arnd@arndb.de>, Kyungmin Park <kyungmin.park@samsung.com>, Andrei Warkentin <awarkentin@vmware.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, pk <pavitra@vayavyalabs.com>, Sandeep <sandeep@vayavyalabs.com>, Rayagond <rayagond@vayavyalabs.com>

On Wed, Nov 16, 2011 at 4:38 PM, Shashidhar Hiremath
<shashidharh@vayavyalabs.com> wrote:
> The patch provides An infrastructure to test commands other than Read=
/Write commands using the IOCTL interface.The Patch can be useful incas=
e of validating the device to verify whether device support a given com=
mand or not. The result of the sent command will be written to the =A0r=
esult element of the mmc_ioc_cmd structure passed through IOCTL interfa=
ce.
>
> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
> ---
> =A0drivers/mmc/card/Makefile =A0 =A0| =A0 =A02 +-
> =A0drivers/mmc/card/block.c =A0 =A0 | =A0 28 ++
> =A0drivers/mmc/card/test_cmds.c | =A0743 ++++++++++++++++++++++++++++=
++++++++++++++
> =A0drivers/mmc/card/test_cmds.h | =A0 53 +++
> =A0drivers/mmc/core/core.c =A0 =A0 =A0| =A0 =A04 +
> =A0drivers/mmc/core/mmc.c =A0 =A0 =A0 | =A0 =A04 +
> =A0drivers/mmc/core/mmc_ops.c =A0 | =A0 =A01 +
> =A0drivers/mmc/core/sd.c =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0include/linux/mmc/ioctl.h =A0 =A0| =A0 =A01 +
> =A09 files changed, 837 insertions(+), 1 deletions(-)
> =A0create mode 100644 drivers/mmc/card/test_cmds.c
> =A0create mode 100644 drivers/mmc/card/test_cmds.h
>
> diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
> index c73b406..ea52ee1 100644
> --- a/drivers/mmc/card/Makefile
> +++ b/drivers/mmc/card/Makefile
> @@ -3,7 +3,7 @@
> =A0#
>
> =A0obj-$(CONFIG_MMC_BLOCK) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D mmc_bl=
ock.o
> -mmc_block-objs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D block.o queue.o
> +mmc_block-objs =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 :=3D block.o queue.o =
test_cmds.o

Why should it be included by default ?
I think it belongs under CONFIG_MMC_TEST

> =A0obj-$(CONFIG_MMC_TEST) =A0 =A0 =A0 =A0 +=3D mmc_test.o
>
