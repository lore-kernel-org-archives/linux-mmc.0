From: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
Subject: Re: [PATCH 1/1] mmc:Extension of MMC Block IOCTL Command support for
 testing of non read/write Commands
Date: Thu, 17 Nov 2011 16:48:26 +0530
Message-ID: <CANYdXnoj-0-K=SRMnDhxVouS8eeD0kgEywCeHZsGWSuWoaF2UA@mail.gmail.com>
References: <1321441734-24191-1-git-send-email-shashidharh@vayavyalabs.com>
	<CANfBPZ93C1JSqLJNvO==O_Rg4h_6p6Q3Nmcx+M9NFUtMOgVYbg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41105 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab1KQLS1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Nov 2011 06:18:27 -0500
Received: by ggnb2 with SMTP id b2so886923ggn.19
        for <linux-mmc@vger.kernel.org>; Thu, 17 Nov 2011 03:18:26 -0800 (PST)
In-Reply-To: <CANfBPZ93C1JSqLJNvO==O_Rg4h_6p6Q3Nmcx+M9NFUtMOgVYbg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@stericsson.com>, Jaehoon Chung <jh80.chung@samsung.com>, Philip Rakity <prakity@marvell.com>, Girish K S <girish.shivananjappa@linaro.org>, Lucas De Marchi <lucas.demarchi@profusion.mobi>, Aries Lee <arieslee@jmicron.com>, Arindam Nath <arindam.nath@amd.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Arnd Bergmann <arnd@arndb.de>, Kyungmin Park <kyungmin.park@samsung.com>, Andrei Warkentin <awarkentin@vmware.com>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, pk <pavitra@vayavyalabs.com>, Sandeep <sandeep@vayavyalabs.com>, Rayagond <rayagond@vayavyalabs.com>

Hi Venkatraman,
   If I understand correctly, You want the test_cmds.c file to be
compiled conditionally based on the menuconfig option for
CONFIG_MMC_TEST right ?

On Thu, Nov 17, 2011 at 4:04 PM, S, Venkatraman <svenkatr@ti.com> wrote=
:
> On Wed, Nov 16, 2011 at 4:38 PM, Shashidhar Hiremath
> <shashidharh@vayavyalabs.com> wrote:
>> The patch provides An infrastructure to test commands other than Rea=
d/Write commands using the IOCTL interface.The Patch can be useful inca=
se of validating the device to verify whether device support a given co=
mmand or not. The result of the sent command will be written to the =C2=
=A0result element of the mmc_ioc_cmd structure passed through IOCTL int=
erface.
>>
>> Signed-off-by: Shashidhar Hiremath <shashidharh@vayavyalabs.com>
>> ---
>> =C2=A0drivers/mmc/card/Makefile =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
>> =C2=A0drivers/mmc/card/block.c =C2=A0 =C2=A0 | =C2=A0 28 ++
>> =C2=A0drivers/mmc/card/test_cmds.c | =C2=A0743 +++++++++++++++++++++=
+++++++++++++++++++++
>> =C2=A0drivers/mmc/card/test_cmds.h | =C2=A0 53 +++
>> =C2=A0drivers/mmc/core/core.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04 +
>> =C2=A0drivers/mmc/core/mmc.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A04 +
>> =C2=A0drivers/mmc/core/mmc_ops.c =C2=A0 | =C2=A0 =C2=A01 +
>> =C2=A0drivers/mmc/core/sd.c =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
2 +
>> =C2=A0include/linux/mmc/ioctl.h =C2=A0 =C2=A0| =C2=A0 =C2=A01 +
>> =C2=A09 files changed, 837 insertions(+), 1 deletions(-)
>> =C2=A0create mode 100644 drivers/mmc/card/test_cmds.c
>> =C2=A0create mode 100644 drivers/mmc/card/test_cmds.h
>>
>> diff --git a/drivers/mmc/card/Makefile b/drivers/mmc/card/Makefile
>> index c73b406..ea52ee1 100644
>> --- a/drivers/mmc/card/Makefile
>> +++ b/drivers/mmc/card/Makefile
>> @@ -3,7 +3,7 @@
>> =C2=A0#
>>
>> =C2=A0obj-$(CONFIG_MMC_BLOCK) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0+=3D mmc_block.o
>> -mmc_block-objs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 :=3D block.o queue.o
>> +mmc_block-objs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 :=3D block.o queue.o test_cmds.o
>
> Why should it be included by default ?
> I think it belongs under CONFIG_MMC_TEST
>
>> =C2=A0obj-$(CONFIG_MMC_TEST) =C2=A0 =C2=A0 =C2=A0 =C2=A0 +=3D mmc_te=
st.o
>>
>



--=20
regards,
Shashidhar Hiremath
