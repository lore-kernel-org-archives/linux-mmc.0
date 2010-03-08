From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: Re: [PATCH] mmc-omap: Add support for 16-bit and 32-bit registers
Date: Sun, 7 Mar 2010 16:16:06 -0800
Message-ID: <6cb013311003071616k7b975e93oc9af9a6a3f0f9c83@mail.gmail.com>
References: <1267984078-6036-1-git-send-email-darkstar6262@gmail.com>
	<20100307225901.GU10014@trinity.fluff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20100307225901.GU10014@trinity.fluff.org>
Sender: linux-omap-owner@vger.kernel.org
To: Ben Dooks <ben@fluff.org>
Cc: linux-mmc@vger.kernel.org, akpm@linux-foundation.org, Ladislav Michl <ladis@linux-mips.org>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Marek Belisko <marek.belisko@open-nandra.com>
List-Id: linux-mmc@vger.kernel.org

On Sun, Mar 7, 2010 at 2:59 PM, Ben Dooks <ben@fluff.org> wrote:
> On Sun, Mar 07, 2010 at 09:47:58AM -0800, Cory Maccarrone wrote:
>> From: Marek Belisko <marek.belisko@open-nandra.com>
>>
>> The omap850 and omap730 use 16-bit registers instead of 32-bit, requ=
iring
>> a modification of the register addresses in the mmc-omap driver. =C2=
=A0To resolve
>> this, a bit shift is performed on base register addresses, either by=
 1 or 2
>> bits depending on the CPU in use. =C2=A0This yields the correct regi=
sters for
>> each CPU.
>
> merged the previous one into my tree earlier today.
>
>> Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
>> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
>> Signed-off-by: Tony Lindgren <tony@atomide.com>
>> ---
>> =C2=A0drivers/mmc/host/omap.c | =C2=A0 62 +++++++++++++++++++++++++-=
---------------------
>> =C2=A01 files changed, 33 insertions(+), 29 deletions(-)
>>
>> This is a resubmit of a patch I sent in several months ago. =C2=A0To=
ny Lindgren merged
>> this into linux-omap's master and testing branches but has stated th=
at he will not
>> merge it further as linux-mmc needs to approve this. =C2=A0There has=
n't been any comments
>> raised on either of the linux-omap or linux-mmc mailing lists about =
problems. =C2=A0Due to
>> the unique nature of the omap7xx platform, this patch is required fo=
r MMC card access.
>> Is there any chance this can be included into the next -rc cycle, as=
 it is a fix for
>> devices that have 16-bit registers?
>>
>> diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
>> index c6d7e8e..53362c4 100644
>> --- a/drivers/mmc/host/omap.c
>> +++ b/drivers/mmc/host/omap.c
>> @@ -38,30 +38,30 @@
>> =C2=A0#include <plat/fpga.h>
>>
>> =C2=A0#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_CMD =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x00
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_ARGL =C2=A0 =C2=A0 =C2=A0 =
0x04
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_ARGH =C2=A0 =C2=A0 =C2=A0 =
0x08
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_CON =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x0c
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_STAT =C2=A0 =C2=A0 =C2=A0 =
0x10
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_IE =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x14
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_CTO =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x18
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_DTO =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x1c
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_DATA =C2=A0 =C2=A0 =C2=A0 =
0x20
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_BLEN =C2=A0 =C2=A0 =C2=A0 =
0x24
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_NBLK =C2=A0 =C2=A0 =C2=A0 =
0x28
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_BUF =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x2c
>> -#define OMAP_MMC_REG_SDIO =C2=A0 =C2=A00x34
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_REV =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x3c
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP0 =C2=A0 =C2=A0 =C2=A0 =
0x40
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP1 =C2=A0 =C2=A0 =C2=A0 =
0x44
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP2 =C2=A0 =C2=A0 =C2=A0 =
0x48
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP3 =C2=A0 =C2=A0 =C2=A0 =
0x4c
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP4 =C2=A0 =C2=A0 =C2=A0 =
0x50
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP5 =C2=A0 =C2=A0 =C2=A0 =
0x54
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP6 =C2=A0 =C2=A0 =C2=A0 =
0x58
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP7 =C2=A0 =C2=A0 =C2=A0 =
0x5c
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_IOSR =C2=A0 =C2=A0 =C2=A0 =
0x60
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_SYSC =C2=A0 =C2=A0 =C2=A0 =
0x64
>> -#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_SYSS =C2=A0 =C2=A0 =C2=A0 =
0x68
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_ARGL =C2=A0 =C2=A0 =C2=A0 =
0x01
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_ARGH =C2=A0 =C2=A0 =C2=A0 =
0x02
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_CON =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x03
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_STAT =C2=A0 =C2=A0 =C2=A0 =
0x04
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_IE =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 0x05
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_CTO =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x06
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_DTO =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x07
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_DATA =C2=A0 =C2=A0 =C2=A0 =
0x08
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_BLEN =C2=A0 =C2=A0 =C2=A0 =
0x09
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_NBLK =C2=A0 =C2=A0 =C2=A0 =
0x0a
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_BUF =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x0b
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_SDIO =C2=A0 =C2=A0 =C2=A0 =
0x0d
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_REV =C2=A0 =C2=A0 =C2=A0 =C2=
=A00x0f
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP0 =C2=A0 =C2=A0 =C2=A0 =
0x10
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP1 =C2=A0 =C2=A0 =C2=A0 =
0x11
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP2 =C2=A0 =C2=A0 =C2=A0 =
0x12
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP3 =C2=A0 =C2=A0 =C2=A0 =
0x13
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP4 =C2=A0 =C2=A0 =C2=A0 =
0x14
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP5 =C2=A0 =C2=A0 =C2=A0 =
0x15
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP6 =C2=A0 =C2=A0 =C2=A0 =
0x16
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_RSP7 =C2=A0 =C2=A0 =C2=A0 =
0x17
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_IOSR =C2=A0 =C2=A0 =C2=A0 =
0x18
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_SYSC =C2=A0 =C2=A0 =C2=A0 =
0x19
>> +#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_REG_SYSS =C2=A0 =C2=A0 =C2=A0 =
0x1a
>>
>> =C2=A0#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_STAT_CARD_ERR =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(1 << 14)
>> =C2=A0#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_STAT_CARD_IRQ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0(1 << 13)
>> @@ -77,8 +77,9 @@
>> =C2=A0#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_STAT_CARD_BUSY =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (1 << =C2=A02)
>> =C2=A0#define =C2=A0 =C2=A0 =C2=A0OMAP_MMC_STAT_END_OF_CMD =C2=A0 =C2=
=A0 =C2=A0 =C2=A0(1 << =C2=A00)
>>
>> -#define OMAP_MMC_READ(host, reg) =C2=A0 =C2=A0 __raw_readw((host)->=
virt_base + OMAP_MMC_REG_##reg)
>> -#define OMAP_MMC_WRITE(host, reg, val) =C2=A0 =C2=A0 =C2=A0 __raw_w=
ritew((val), (host)->virt_base + OMAP_MMC_REG_##reg)
>> +#define OMAP_MMC_REG(host, reg) =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(OMAP_MMC_REG_##reg << (host)->reg_shift)
>> +#define OMAP_MMC_READ(host, reg) =C2=A0 =C2=A0 __raw_readw((host)->=
virt_base + OMAP_MMC_REG(host, reg))
>> +#define OMAP_MMC_WRITE(host, reg, val) =C2=A0 =C2=A0 =C2=A0 __raw_w=
ritew((val), (host)->virt_base + OMAP_MMC_REG(host, reg))
>>
>> =C2=A0/*
>> =C2=A0 * Command types
>> @@ -132,6 +133,7 @@ struct mmc_omap_host {
>> =C2=A0 =C2=A0 =C2=A0 int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 irq;
>> =C2=A0 =C2=A0 =C2=A0 unsigned char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 bus_mode;
>> =C2=A0 =C2=A0 =C2=A0 unsigned char =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 hw_bus_mode;
>> + =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
reg_shift;
>>
>> =C2=A0 =C2=A0 =C2=A0 struct work_struct =C2=A0 =C2=A0 =C2=A0cmd_abor=
t_work;
>> =C2=A0 =C2=A0 =C2=A0 unsigned =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0abort:1;
>> @@ -679,9 +681,9 @@ mmc_omap_xfer_data(struct mmc_omap_host *host, i=
nt write)
>> =C2=A0 =C2=A0 =C2=A0 host->data->bytes_xfered +=3D n;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (write) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writesw(host->virt=
_base + OMAP_MMC_REG_DATA, host->buffer, n);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_writesw(host->virt=
_base + OMAP_MMC_REG(host, DATA), host->buffer, n);
>> =C2=A0 =C2=A0 =C2=A0 } else {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_readsw(host->virt_=
base + OMAP_MMC_REG_DATA, host->buffer, n);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 __raw_readsw(host->virt_=
base + OMAP_MMC_REG(host, DATA), host->buffer, n);
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0}
>>
>> @@ -899,7 +901,7 @@ mmc_omap_prepare_dma(struct mmc_omap_host *host,=
 struct mmc_data *data)
>> =C2=A0 =C2=A0 =C2=A0 int dst_port =3D 0;
>> =C2=A0 =C2=A0 =C2=A0 int sync_dev =3D 0;
>>
>> - =C2=A0 =C2=A0 data_addr =3D host->phys_base + OMAP_MMC_REG_DATA;
>> + =C2=A0 =C2=A0 data_addr =3D host->phys_base + OMAP_MMC_REG(host, D=
ATA);
>> =C2=A0 =C2=A0 =C2=A0 frame =3D data->blksz;
>> =C2=A0 =C2=A0 =C2=A0 count =3D sg_dma_len(sg);
>>
>> @@ -1492,6 +1494,8 @@ static int __init mmc_omap_probe(struct platfo=
rm_device *pdev)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 }
>>
>> + =C2=A0 =C2=A0 host->reg_shift =3D (cpu_is_omap7xx() ? 1 : 2);
>> +
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>>
>> =C2=A0err_plat_cleanup:
>> --
>> 1.6.3.3
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-mmc"=
 in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>
> --
> --
> Ben
>
> Q: =C2=A0 =C2=A0 =C2=A0What's a light-year?
> A: =C2=A0 =C2=A0 =C2=A0One-third less calories than a regular year.
>
>

Which branch?  I can find the I2C patch, but not this mmc patch.

Thanks
- Cory
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
