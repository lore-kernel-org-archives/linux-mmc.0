From: Andrea Adami <andrea.adami@gmail.com>
Subject: Re: [PATCH v3 1/9] mtd: sharpslpart: add sharpslpart MTD partition parser
Date: Tue, 20 Jun 2017 10:52:44 +0200
Message-ID: <CAAQYJAuX-=xJ0XKc+KPzOcetthtEKz0RY3_b53ban5sJUR6PgA@mail.gmail.com>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
 <1496270458-6479-2-git-send-email-andrea.adami@gmail.com> <20170609013048.GK102137@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170609013048.GK102137@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Brian,
thanks for the review and for the unvaluable advices.

I have almost fixed the problems you spotted and I am almost ready to
send the new v4 of the patchset.
Some doubts are still present: I'll comment under your remarks:

On Fri, Jun 9, 2017 at 3:30 AM, Brian Norris
<computersforpeace@gmail.com> wrote:
> Hi,
>
> On Thu, Jun 01, 2017 at 12:40:50AM +0200, Andrea Adami wrote:
>> The Sharp SL Series (Zaurus) PXA handhelds have 16/64/128M of NAND flash
>> and share the same layout of the first 7M partition, managed by Sharp FTL.
>>
>> The purpose of this self-contained patch is to add a common parser and
>> remove the hardcoded sizes in the board files (these devices are not yet
>> converted to devicetree).
>> Users will have benefits because the mtdparts= tag will not be necessary
>> anymore and they will be free to repartition the little sized flash.
>>
>> The obsolete bootloader can not pass the partitioning info to modern
>> kernels anymore so it has to be read from flash at known logical addresses.
>> (see http://www.h5.dion.ne.jp/~rimemoon/zaurus/memo_006.htm )
>>
>> In kernel, under arch/arm/mach-pxa we have already 8 machines:
>> MACH_POODLE, MACH_CORGI, MACH_SHEPERD, MACH_HUSKY, MACH_AKITA, MACH_SPITZ,
>> MACH_BORZOI, MACH_TOSA.
>> Lost after the 2.4 vendor kernel are MACH_BOXER and MACH_TERRIER.
>>
>> Almost every model has different factory partitioning: add to this the
>> units can be repartitioned by users with userspace tools (nandlogical)
>> and installers for popular (back then) linux distributions.
>>
>> The Parameter Area in the first (boot) partition extends from 0x00040000 to
>> 0x0007bfff (176k) and contains two copies of the partition table:
>> ...
>> 0x00060000: Partition Info1     16k
>> 0x00064000: Partition Info2     16k
>> 0x00668000: Model               16k
>> ...
>>
>> The first 7M partition is managed by the Sharp FTL reserving 5% + 1 blocks
>> for wear-leveling: some blocks are remapped and one layer of translation
>> (logical to physical) is necessary.
>>
>> There isn't much documentation about this FTL in the 2.4 sources, just the
>> MTD methods for reading and writing using logical addresses and the block
>> management (wear-leveling, use counter).
>> For the purpose of the MTD parser only the read part of the code was taken.
>>
>> The NAND drivers that can use this parser are sharpsl.c and tmio_nand.c.
>>
>> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
>> ---
>>  drivers/mtd/Kconfig       |   8 ++
>>  drivers/mtd/Makefile      |   2 +
>>  drivers/mtd/sharpsl_ftl.c | 216 ++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/mtd/sharpsl_ftl.h |  34 ++++++++
>>  drivers/mtd/sharpslpart.c | 132 ++++++++++++++++++++++++++++
>>  5 files changed, 392 insertions(+)
>>  create mode 100644 drivers/mtd/sharpsl_ftl.c
>>  create mode 100644 drivers/mtd/sharpsl_ftl.h
>>  create mode 100644 drivers/mtd/sharpslpart.c
>>
>> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
>> index e83a279..5c96127 100644
>> --- a/drivers/mtd/Kconfig
>> +++ b/drivers/mtd/Kconfig
>> @@ -155,6 +155,14 @@ config MTD_BCM47XX_PARTS
>>         This provides partitions parser for devices based on BCM47xx
>>         boards.
>>
>> +config MTD_SHARPSL_PARTS
>> +     tristate "Sharp SL Series NAND flash partition parser"
>> +     depends on MTD_NAND_SHARPSL || MTD_NAND_TMIO
>
> Please include '|| COMPILE_TEST'.
>
>> +     help
>> +       This provides the read-only FTL logic necessary to read the partition
>> +       table from the NAND flash of Sharp SL Series (Zaurus) and the MTD
>> +       partition parser using this code.
>> +
>>  comment "User Modules And Translation Layers"
>>
>>  #
>> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
>> index 99bb9a1..89f707b 100644
>> --- a/drivers/mtd/Makefile
>> +++ b/drivers/mtd/Makefile
>> @@ -13,6 +13,8 @@ obj-$(CONFIG_MTD_AFS_PARTS) += afs.o
>>  obj-$(CONFIG_MTD_AR7_PARTS)  += ar7part.o
>>  obj-$(CONFIG_MTD_BCM63XX_PARTS)      += bcm63xxpart.o
>>  obj-$(CONFIG_MTD_BCM47XX_PARTS)      += bcm47xxpart.o
>> +obj-$(CONFIG_MTD_SHARPSL_PARTS)      += sharpsl-part.o
>> +sharpsl-part-objs := sharpsl_ftl.o sharpslpart.o
>>
>>  # 'Users' - code which presents functionality to userspace.
>>  obj-$(CONFIG_MTD_BLKDEVS)    += mtd_blkdevs.o
>> diff --git a/drivers/mtd/sharpsl_ftl.c b/drivers/mtd/sharpsl_ftl.c
>> new file mode 100644
>> index 0000000..1796d03
>> --- /dev/null
>> +++ b/drivers/mtd/sharpsl_ftl.c
>> @@ -0,0 +1,216 @@
>> +/*
>> + * MTD method for NAND accessing via logical address (SHARP FTL)
>> + *
>> + * Copyright (C) 2017 Andrea Adami <andrea.adami@gmail.com>
>> + *
>> + * Based on 2.4 sources: drivers/mtd/nand/sharp_sl_logical.c
>> + * Copyright (C) 2002  SHARP
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mtd/partitions.h>
>> +#include "sharpsl_ftl.h"
>> +
>> +/* oob structure */
>> +#define NAND_NOOB_LOGADDR_00         8
>> +#define NAND_NOOB_LOGADDR_01         9
>> +#define NAND_NOOB_LOGADDR_10         10
>> +#define NAND_NOOB_LOGADDR_11         11
>> +#define NAND_NOOB_LOGADDR_20         12
>> +#define NAND_NOOB_LOGADDR_21         13
>> +
>> +/* Logical Table */
>> +struct mtd_logical {
>> +     u32 size;               /* size of the handled partition */
>> +     int index;              /* mtd->index */
>> +     u_int phymax;           /* physical blocks */
>> +     u_int logmax;           /* logical blocks */
>> +     u_int *log2phy;         /* the logical-to-physical table */
>> +};
>> +
>> +static struct mtd_logical *sharpsl_mtd_logical;
>
> Please do not use a static variable like this. References should be
> dynamic.
>
> Can the pointer just be passed back to the caller, and passed back to
> the cleanup function when finished?
>

I'll fix this.

> Related: do you foresee this parsing code being useful for anything
> besides partitions? If not, then it seems like we should just merge the
> "ftl" and "part" files. Not a requirement, but it might be cleaner.
>

I think it makes sense to merge back together.
It was earlier split to better expose the read-only FTL.


>> +
>> +static int sharpsl_nand_read_oob(struct mtd_info *mtd, loff_t offs, size_t len,
>> +                              uint8_t *buf)
>> +{
>> +     loff_t mask = mtd->writesize - 1;
>> +     struct mtd_oob_ops ops;
>> +     int ret;
>> +
>> +     ops.mode = MTD_OPS_PLACE_OOB;
>> +     ops.ooboffs = offs & mask;
>> +     ops.ooblen = len;
>> +     ops.oobbuf = buf;
>> +     ops.datbuf = NULL;
>> +
>> +     ret = mtd_read_oob(mtd, offs & ~mask, &ops);
>> +     if (ret != 0 || len != ops.oobretlen)
>> +             return -1;
>> +
>> +     return 0;
>> +}
>> +
>> +static u_int sharpsl_nand_get_logical_num(u_char *oob)
>> +{
>> +     u16 us;
>> +     int good0, good1;
>> +
>> +     if (oob[NAND_NOOB_LOGADDR_00] == oob[NAND_NOOB_LOGADDR_10] &&
>> +         oob[NAND_NOOB_LOGADDR_01] == oob[NAND_NOOB_LOGADDR_11]) {
>> +             good0 = NAND_NOOB_LOGADDR_00;
>> +             good1 = NAND_NOOB_LOGADDR_01;
>> +     } else if (oob[NAND_NOOB_LOGADDR_10] == oob[NAND_NOOB_LOGADDR_20] &&
>> +                oob[NAND_NOOB_LOGADDR_11] == oob[NAND_NOOB_LOGADDR_21]) {
>> +             good0 = NAND_NOOB_LOGADDR_10;
>> +             good1 = NAND_NOOB_LOGADDR_11;
>> +     } else if (oob[NAND_NOOB_LOGADDR_20] == oob[NAND_NOOB_LOGADDR_00] &&
>> +                oob[NAND_NOOB_LOGADDR_21] == oob[NAND_NOOB_LOGADDR_01]) {
>> +             good0 = NAND_NOOB_LOGADDR_20;
>> +             good1 = NAND_NOOB_LOGADDR_21;
>> +     } else {
>> +             return UINT_MAX;
>> +     }
>
> These seems like a pretty weird form of error protection. IIUC, there
> are just 3 copies of the 2-byte sequence number, and we take the first
> pair that matches at least one of the others? Could use a comment above
> the if/else block, to explain what the logic is. Or perhaps even some
> comments at the top of the file, to roughly describe this FTL.
>

I am sorry I don't know much about error correction.
No info, no comments in the 2.4 sources.

My tests did indeed show that only the first condition is matched
(good0=8 good1=9) so I'll retry and then I'll simplify the code..


>> +
>> +     us = oob[good0] | oob[good1] << 8;
>> +
>> +     /* parity check */
>> +     if (hweight16(us) & 1)
>> +             return (UINT_MAX - 1);
>> +
>> +     /* reserved */
>> +     if (us == 0xffff)
>
> Magic number should get a descriptive macro?
>

done (BLOCK_IS_RESERVED)

>> +             return 0xffff;
>
> What does this mean? IIUC, this is essentially going to be an
> out-of-bounds value that gets ignored, right? Should this just be
> 'return UINT_MAX'?
>
Done.
it is the same with the simplified code we are using.
If you look in the 2.4 sources there was a further check to verify the usage [1]

[ 1] https://github.com/LinuxPDA/Sharp_FTL_2.4.20/blob/master/linux/drivers/mtd/nand/sharp_sl_logical.c#L453

>> +     else
>> +             return (us & 0x07fe) >> 1;
>
> 0x07fe could use a macro definition. (And since it seems complementary,
> I guess the 1 in 'hweight16(us) & 1' should also be a macro.)
>

Done
BLOCK_UNMASK            0x07fe
BLOCK_UNMASK_COMPLEMENT            1


>> +}
>> +
>> +int sharpsl_nand_init_logical(struct mtd_info *mtd, u32 partition_size)
>> +{
>> +     struct mtd_logical *logical = NULL;
>
> You don't need the NULL initialization.

Fixed (all these are remnants of the 2.4 conversion...)

>
>> +     u_int block_num, log_num;
>> +     loff_t block_adr;
>> +     u_char *oob = NULL;
>
> Same here.
>
Done

>> +     int i, readretry;
>> +
>> +     logical = kzalloc(sizeof(*logical), GFP_KERNEL);
>> +     if (!logical)
>> +             return -ENOMEM;
>> +
>> +     oob = kzalloc(mtd->oobsize, GFP_KERNEL);
>> +     if (!oob) {
>> +             kfree(logical);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     /* initialize management structure */
>> +     logical->size = partition_size;
>> +     logical->index = mtd->index;
>> +     logical->phymax = (partition_size / mtd->erasesize);
>> +
>> +     /* FTL reserves 5% of the blocks + 1 spare  */
>> +     logical->logmax = ((logical->phymax * 95) / 100) - 1;
>> +
>> +     logical->log2phy = NULL;
>> +     logical->log2phy = kcalloc(logical->logmax, sizeof(u_int), GFP_KERNEL);
>> +     if (!logical->log2phy) {
>> +             kfree(logical);
>> +             kfree(oob);
>> +             return -ENOMEM;
>> +     }
>> +
>> +     /* initialize logical->log2phy */
>> +     for (i = 0; i < logical->logmax; i++)
>> +             logical->log2phy[i] = UINT_MAX;
>
> The 0-initialized kcalloc() is a little superfluous, since you reinit
> here. I guess it's a matter of taste.
>
Well, right, my bad.

The original code [2] did kmalloc() + memset so checkpatch suggested
to use kcalloc().
But the simplified code we are using does not need it (we ignore 'usage').
I'll change back to kmalloc() and initialize to UINT_MAX.

[2] https://github.com/LinuxPDA/Sharp_FTL_2.4.20/blob/master/linux/drivers/mtd/nand/sharp_sl_logical.c#L395


>> +
>> +     /* create physical-logical table */
>> +     for (block_num = 0; block_num < logical->phymax; block_num++) {
>> +             block_adr = block_num * mtd->erasesize;
>> +
>> +             if (mtd_block_isbad(mtd, block_adr))
>> +                     continue;
>> +
>> +             readretry = 3;
>> +read_retry:
>> +             if (sharpsl_nand_read_oob(mtd, block_adr, mtd->oobsize, oob))
>> +                     continue;
>> +
>> +             /* get logical block */
>> +             log_num = sharpsl_nand_get_logical_num(oob);
>> +
>> +             /* skip out of range and not unique values */
>> +             if ((int)log_num >= 0  && (log_num < logical->logmax)) {
>
> Why the (int) cast? You should already be eliminating anything larger
> than INT_MAX, because they'll be larger than logmax. You should only
> need the second comparison.
>

Fixed both.
The cast is another remnant of the (many) checks done in the old sources.
My bad I have let some superfluous code during conversion....

>> +                     if (logical->log2phy[log_num] == UINT_MAX)
>> +                             logical->log2phy[log_num] = block_num;
>> +             } else {
>> +                     readretry--;
>> +                     if (readretry)
>> +                             goto read_retry;
>
> What's the idea on the retries? Is this somehow supposed to make NAND
> more reliable? That seems unlikely to work... Although notably, OOB is
> often not covered by ECC, so maybe this is a really poor attempt at
> making up for that?
>

:)
Yes, it seems poor-man's solution but is indeed in the 2.4 sources.
Not needed (tested). Removed.

>> +             }
>> +     }
>> +     kfree(oob);
>> +     sharpsl_mtd_logical = logical;
>> +
>> +     pr_info("Sharp SL FTL: %d blocks used (%d logical, %d reserved)\n",
>> +             logical->phymax, logical->logmax,
>> +             logical->phymax - logical->logmax);
>> +
>> +     return 0;
>> +}
>> +
>> +void sharpsl_nand_cleanup_logical(void)
>> +{
>> +     struct mtd_logical *logical = sharpsl_mtd_logical;
>
> Please make this take a pointer arg, instead of relying on a static var.
>
Sure, as above I'll avoid the static var.

>> +
>> +     sharpsl_mtd_logical = NULL;
>> +
>> +     kfree(logical->log2phy);
>> +     logical->log2phy = NULL;
>> +     kfree(logical);
>> +     logical = NULL;
>> +}
>> +
>> +int sharpsl_nand_read_laddr(struct mtd_info *mtd,
>> +                         loff_t from,
>> +                         size_t len,
>> +                         u_char *buf)
>> +{
>> +     struct mtd_logical *logical;
>> +     u_int log_num, log_new;
>> +     u_int block_num;
>> +     loff_t block_adr;
>> +     loff_t block_ofs;
>> +     size_t retlen;
>> +     int ret;
>> +
>> +     logical = sharpsl_mtd_logical;
>> +     log_num = (u32)from / mtd->erasesize;
>> +     log_new = ((u32)from + len - 1) / mtd->erasesize;
>> +
>> +     if (len <= 0 || log_num >= logical->logmax || log_new > log_num)
>> +             return -EINVAL;
>> +
>> +     block_num = logical->log2phy[log_num];
>> +     block_adr = block_num * mtd->erasesize;
>> +     block_ofs = (u32)from % mtd->erasesize;
>> +
>> +     ret = mtd_read(mtd, block_adr + block_ofs, len, &retlen, buf);
>> +     if (ret != 0 || len != retlen)
>
> What about ret == -EUCLEAN? Do you want to handle corrected bitflips?
>

I have changed the checks here and have taken the code of mtdtest_read()
so to ignorer bitflips and pass the error through.



>> +             return -EINVAL;
>> +
>> +     return 0;
>> +}
>> diff --git a/drivers/mtd/sharpsl_ftl.h b/drivers/mtd/sharpsl_ftl.h
>> new file mode 100644
>> index 0000000..2880cbe
>> --- /dev/null
>> +++ b/drivers/mtd/sharpsl_ftl.h
>> @@ -0,0 +1,34 @@
>> +/*
>> + * Header file for NAND accessing via logical address (SHARP FTL)
>> + *
>> + * Copyright (C) 2017 Andrea Adami <andrea.adami@gmail.com>
>> + *
>> + * Based on 2.4 sources: linux/include/asm-arm/sharp_nand_logical.h
>> + * Copyright (C) 2002  SHARP
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#ifndef __SHARPSL_NAND_LOGICAL_H__
>> +#define __SHARPSL_NAND_LOGICAL_H__
>> +
>> +#include <linux/types.h>
>> +#include <linux/mtd/mtd.h>
>> +
>> +int sharpsl_nand_init_logical(struct mtd_info *mtd, u32 partition_size);
>> +
>> +void sharpsl_nand_cleanup_logical(void);
>> +
>> +int sharpsl_nand_read_laddr(struct mtd_info *mtd, loff_t from, size_t len,
>> +                         u_char *buf);
>> +
>> +#endif
>> diff --git a/drivers/mtd/sharpslpart.c b/drivers/mtd/sharpslpart.c
>> new file mode 100644
>> index 0000000..40aebe9
>> --- /dev/null
>> +++ b/drivers/mtd/sharpslpart.c
>> @@ -0,0 +1,132 @@
>> +/*
>> + * MTD partition parser for NAND flash on Sharp SL Series
>> + *
>> + * Copyright (C) 2017 Andrea Adami <andrea.adami@gmail.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/slab.h>
>> +#include <linux/module.h>
>> +#include <linux/mtd/mtd.h>
>> +#include <linux/mtd/partitions.h>
>> +#include "sharpsl_ftl.h"
>> +
>> +/* factory defaults */
>> +#define SHARPSL_NAND_PARTS           3
>> +#define SHARPSL_FTL_PARTITION_SIZE   (7 * 1024 * 1024)
>> +#define PARAM_BLOCK_PARTITIONINFO1   0x00060000
>> +#define PARAM_BLOCK_PARTITIONINFO2   0x00064000
>> +
>> +#define BOOT_MAGIC                   be32_to_cpu(0x424f4f54)   /* BOOT */
>> +#define FSRO_MAGIC                   be32_to_cpu(0x4653524f)   /* FSRO */
>> +#define FSRW_MAGIC                   be32_to_cpu(0x46535257)   /* FSRW */
>> +
>> +/*
>> + * Sample values read from SL-C860
>> + *
>> + * # cat /proc/mtd
>> + * dev:    size   erasesize  name
>> + * mtd0: 006d0000 00020000 "Filesystem"
>> + * mtd1: 00700000 00004000 "smf"
>> + * mtd2: 03500000 00004000 "root"
>> + * mtd3: 04400000 00004000 "home"
>> + *
>> + * PARTITIONINFO1
>> + * 0x00060000: 00 00 00 00 00 00 70 00 42 4f 4f 54 00 00 00 00  ......p.BOOT....
>> + * 0x00060010: 00 00 70 00 00 00 c0 03 46 53 52 4f 00 00 00 00  ..p.....FSRO....
>> + * 0x00060020: 00 00 c0 03 00 00 00 04 46 53 52 57 00 00 00 00  ........FSRW....
>> + * 0x00060030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
>> + *
>> + */
>> +
>> +struct sharpsl_nand_partitioninfo {
>> +     u32 start;
>> +     u32 end;
>> +     u32 magic;
>> +     u32 reserved;
>> +};
>> +
>> +static int sharpsl_parse_mtd_partitions(struct mtd_info *master,
>> +                                     const struct mtd_partition **pparts,
>> +                                     struct mtd_part_parser_data *data)
>> +{
>> +     struct sharpsl_nand_partitioninfo buf1[SHARPSL_NAND_PARTS];
>> +     struct sharpsl_nand_partitioninfo buf2[SHARPSL_NAND_PARTS];
>> +     struct mtd_partition *sharpsl_nand_parts;
>> +
>> +     /* init logical mgmt (FTL) */
>
> Do you have any kind of validation logic, to ensure that this parser
> actually matches? What if the flash was erased? Or what if somebody
> managed to reformat to some other flash layout?
>

The bootloader loads and launches the zImage1 found at a specific
logical address.
If mtd1 were invalid there would be no boot.

See, 10yrs ago there was an unofficial u-boot port for experienced users.
That was requiring to full-erase the nand, so removing the maintenance
and diag code
This would be the only case of modified partition layout I can think of.


> I suppose for many cases like that, the logical mapping will turn up
> with a lot of UINT_MAX entries, and then sharpsl_nand_read_laddr() will
> return -EINVAL? It'd be nice if there were some more clear sanity
> checks though, if possible. Does this FTL have a header we should be
> looking for?

I expect -EINVAL in that case.
BUT if one would be usingh u-boot then he'd have partitions in
u-boot.env or in cmdline.

The (infamous)  header is copied here:

https://github.com/LinuxPDA/Sharp_FTL_2.4.20/blob/master/linux/drivers/mtd/nand/sharp_sl_logical.c

Full sources available at
http://support.ezaurus.com/developer/source/source_dl.asp

>
>> +     if (sharpsl_nand_init_logical(master, SHARPSL_FTL_PARTITION_SIZE))
>> +             return -EINVAL;
>> +
>> +     /* read the two partition tables */
>> +     if (sharpsl_nand_read_laddr(master,
>> +                                 PARAM_BLOCK_PARTITIONINFO1,
>> +                                 sizeof(buf1), (u_char *)&buf1) ||
>> +         sharpsl_nand_read_laddr(master,
>> +                                 PARAM_BLOCK_PARTITIONINFO2,
>> +                                 sizeof(buf2), (u_char *)&buf2))
>> +             return -EINVAL;
>
> You've failed to cleanup in the error case here:
> sharpsl_nand_cleanup_logical()
>
Argh, fixed.

> Also, consider passing through the actual error code?
>
Yes, done,

>> +
>> +     /* cleanup logical mgmt (FTL) */
>> +     sharpsl_nand_cleanup_logical();
>> +
>> +     /* compare the two buffers */
>> +     if (memcmp(&buf1, &buf2, sizeof(buf1))) {
>> +             pr_err("sharpslpart: PARTITIONINFO 1,2 differ. Quit parser.\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     /* check for magics (just in the first) */
>> +     if (buf1[0].magic != BOOT_MAGIC ||
>> +         buf1[1].magic != FSRO_MAGIC ||
>> +         buf1[2].magic != FSRW_MAGIC) {
>> +             pr_err("sharpslpart: magic values mismatch. Quit parser.\n");
>> +             return -EINVAL;
>> +     }
>> +
>> +     sharpsl_nand_parts = kzalloc(sizeof(*sharpsl_nand_parts) *
>> +                                  SHARPSL_NAND_PARTS, GFP_KERNEL);
>> +     if (!sharpsl_nand_parts)
>> +             return -ENOMEM;
>> +
>> +     /* original names */
>> +     sharpsl_nand_parts[0].name = "smf";
>> +     sharpsl_nand_parts[0].offset = buf1[0].start;
>> +     sharpsl_nand_parts[0].size = buf1[0].end - buf1[0].start;
>
> Want to sanity check that 'end > start'?
>

Done, I have added a sanity check.

>> +     sharpsl_nand_parts[0].mask_flags = 0;
>
> Don't need to zero this out, when you've used kzalloc(). Same comments
> apply below.
>
Yes, fixed.
(I have copied without much thinking from ar7part.c)


>> +
>> +     sharpsl_nand_parts[1].name = "root";
>> +     sharpsl_nand_parts[1].offset = buf1[1].start;
>> +     sharpsl_nand_parts[1].size = buf1[1].end - buf1[1].start;
>> +     sharpsl_nand_parts[1].mask_flags = 0;
>> +
>> +     sharpsl_nand_parts[2].name = "home";
>> +     sharpsl_nand_parts[2].offset = buf1[2].start;
>> +     /* discard buf1[2].end, was for older models with 64M flash */
>> +     sharpsl_nand_parts[2].size = master->size - buf1[2].start;
>> +     sharpsl_nand_parts[2].mask_flags = 0;
>> +
>> +     *pparts = sharpsl_nand_parts;
>> +     return SHARPSL_NAND_PARTS;
>> +}
>> +
>> +static struct mtd_part_parser sharpsl_mtd_parser = {
>> +     .parse_fn = sharpsl_parse_mtd_partitions,
>> +     .name = "sharpslpart",
>> +};
>> +module_mtd_part_parser(sharpsl_mtd_parser);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_AUTHOR("Andrea Adami <andrea.adami@gmail.com>");
>> +MODULE_DESCRIPTION("MTD partitioning for NAND flash on Sharp SL Series");
>
> Brian


Thanks for your time.

Regards
Andrea
