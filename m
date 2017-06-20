From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v3 1/9] mtd: sharpslpart: add sharpslpart MTD partition
 parser
Date: Tue, 20 Jun 2017 15:05:30 -0700
Message-ID: <20170620220530.GA21579@google.com>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
 <1496270458-6479-2-git-send-email-andrea.adami@gmail.com>
 <20170609013048.GK102137@google.com>
 <CAAQYJAuX-=xJ0XKc+KPzOcetthtEKz0RY3_b53ban5sJUR6PgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAQYJAuX-=xJ0XKc+KPzOcetthtEKz0RY3_b53ban5sJUR6PgA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On Tue, Jun 20, 2017 at 10:52:44AM +0200, Andrea Adami wrote:
> Brian,
> thanks for the review and for the unvaluable advices.
> 
> I have almost fixed the problems you spotted and I am almost ready to
> send the new v4 of the patchset.

Great!

> Some doubts are still present: I'll comment under your remarks:

Perfect. I've trimmed, and responded to a few things. Let me know if you
hvae more questions.

> On Fri, Jun 9, 2017 at 3:30 AM, Brian Norris
> <computersforpeace@gmail.com> wrote:
> > Hi,
> >
> > On Thu, Jun 01, 2017 at 12:40:50AM +0200, Andrea Adami wrote:
> >> The Sharp SL Series (Zaurus) PXA handhelds have 16/64/128M of NAND flash
> >> and share the same layout of the first 7M partition, managed by Sharp FTL.
> >>
> >> The purpose of this self-contained patch is to add a common parser and
> >> remove the hardcoded sizes in the board files (these devices are not yet
> >> converted to devicetree).
> >> Users will have benefits because the mtdparts= tag will not be necessary
> >> anymore and they will be free to repartition the little sized flash.
> >>
> >> The obsolete bootloader can not pass the partitioning info to modern
> >> kernels anymore so it has to be read from flash at known logical addresses.
> >> (see http://www.h5.dion.ne.jp/~rimemoon/zaurus/memo_006.htm )
> >>
> >> In kernel, under arch/arm/mach-pxa we have already 8 machines:
> >> MACH_POODLE, MACH_CORGI, MACH_SHEPERD, MACH_HUSKY, MACH_AKITA, MACH_SPITZ,
> >> MACH_BORZOI, MACH_TOSA.
> >> Lost after the 2.4 vendor kernel are MACH_BOXER and MACH_TERRIER.
> >>
> >> Almost every model has different factory partitioning: add to this the
> >> units can be repartitioned by users with userspace tools (nandlogical)
> >> and installers for popular (back then) linux distributions.
> >>
> >> The Parameter Area in the first (boot) partition extends from 0x00040000 to
> >> 0x0007bfff (176k) and contains two copies of the partition table:
> >> ...
> >> 0x00060000: Partition Info1     16k
> >> 0x00064000: Partition Info2     16k
> >> 0x00668000: Model               16k
> >> ...
> >>
> >> The first 7M partition is managed by the Sharp FTL reserving 5% + 1 blocks
> >> for wear-leveling: some blocks are remapped and one layer of translation
> >> (logical to physical) is necessary.
> >>
> >> There isn't much documentation about this FTL in the 2.4 sources, just the
> >> MTD methods for reading and writing using logical addresses and the block
> >> management (wear-leveling, use counter).
> >> For the purpose of the MTD parser only the read part of the code was taken.
> >>
> >> The NAND drivers that can use this parser are sharpsl.c and tmio_nand.c.
> >>
> >> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> >> ---
> >>  drivers/mtd/Kconfig       |   8 ++
> >>  drivers/mtd/Makefile      |   2 +
> >>  drivers/mtd/sharpsl_ftl.c | 216 ++++++++++++++++++++++++++++++++++++++++++++++
> >>  drivers/mtd/sharpsl_ftl.h |  34 ++++++++
> >>  drivers/mtd/sharpslpart.c | 132 ++++++++++++++++++++++++++++
> >>  5 files changed, 392 insertions(+)
> >>  create mode 100644 drivers/mtd/sharpsl_ftl.c
> >>  create mode 100644 drivers/mtd/sharpsl_ftl.h
> >>  create mode 100644 drivers/mtd/sharpslpart.c
> >>

...

> >> diff --git a/drivers/mtd/sharpsl_ftl.c b/drivers/mtd/sharpsl_ftl.c
> >> new file mode 100644
> >> index 0000000..1796d03
> >> --- /dev/null
> >> +++ b/drivers/mtd/sharpsl_ftl.c
> >> @@ -0,0 +1,216 @@

...

> >> +static u_int sharpsl_nand_get_logical_num(u_char *oob)
> >> +{
> >> +     u16 us;
> >> +     int good0, good1;
> >> +
> >> +     if (oob[NAND_NOOB_LOGADDR_00] == oob[NAND_NOOB_LOGADDR_10] &&
> >> +         oob[NAND_NOOB_LOGADDR_01] == oob[NAND_NOOB_LOGADDR_11]) {
> >> +             good0 = NAND_NOOB_LOGADDR_00;
> >> +             good1 = NAND_NOOB_LOGADDR_01;
> >> +     } else if (oob[NAND_NOOB_LOGADDR_10] == oob[NAND_NOOB_LOGADDR_20] &&
> >> +                oob[NAND_NOOB_LOGADDR_11] == oob[NAND_NOOB_LOGADDR_21]) {
> >> +             good0 = NAND_NOOB_LOGADDR_10;
> >> +             good1 = NAND_NOOB_LOGADDR_11;
> >> +     } else if (oob[NAND_NOOB_LOGADDR_20] == oob[NAND_NOOB_LOGADDR_00] &&
> >> +                oob[NAND_NOOB_LOGADDR_21] == oob[NAND_NOOB_LOGADDR_01]) {
> >> +             good0 = NAND_NOOB_LOGADDR_20;
> >> +             good1 = NAND_NOOB_LOGADDR_21;
> >> +     } else {
> >> +             return UINT_MAX;
> >> +     }
> >
> > These seems like a pretty weird form of error protection. IIUC, there
> > are just 3 copies of the 2-byte sequence number, and we take the first
> > pair that matches at least one of the others? Could use a comment above
> > the if/else block, to explain what the logic is. Or perhaps even some
> > comments at the top of the file, to roughly describe this FTL.
> >
> 
> I am sorry I don't know much about error correction.
> No info, no comments in the 2.4 sources.
> 
> My tests did indeed show that only the first condition is matched
> (good0=8 good1=9) so I'll retry and then I'll simplify the code..

I don't think removing the secondary conditions above is a good idea; it
seems to provide some value as a backup, in case of (for example)
bitflips in the OOB. I was just commenting that it was a little strange,
and that it might be good to write up a comment based on our
understanding of this OOB header format. Either text, or some small
ASCII art. (Along the lines of "logical block number assigned to a
physical block is stored in OOB of the first page, in 3 16-bit copies
layed out as <foo>; in case of errors, we check that a 2 or more of
these copies agree. Reserved values <bar> mean <blah>.")

IOW, your job isn't just to prune down the vendor's code, but to make it
cleaner and clearer to the reader/reviewer.

...

> >> +
> >> +     /* create physical-logical table */
> >> +     for (block_num = 0; block_num < logical->phymax; block_num++) {
> >> +             block_adr = block_num * mtd->erasesize;
> >> +
> >> +             if (mtd_block_isbad(mtd, block_adr))
> >> +                     continue;
> >> +
> >> +             readretry = 3;
> >> +read_retry:
> >> +             if (sharpsl_nand_read_oob(mtd, block_adr, mtd->oobsize, oob))
> >> +                     continue;
> >> +
> >> +             /* get logical block */
> >> +             log_num = sharpsl_nand_get_logical_num(oob);
> >> +
> >> +             /* skip out of range and not unique values */
> >> +             if ((int)log_num >= 0  && (log_num < logical->logmax)) {

...

> >> +                     if (logical->log2phy[log_num] == UINT_MAX)
> >> +                             logical->log2phy[log_num] = block_num;
> >> +             } else {
> >> +                     readretry--;
> >> +                     if (readretry)
> >> +                             goto read_retry;
> >
> > What's the idea on the retries? Is this somehow supposed to make NAND
> > more reliable? That seems unlikely to work... Although notably, OOB is
> > often not covered by ECC, so maybe this is a really poor attempt at
> > making up for that?
> >
> 
> :)
> Yes, it seems poor-man's solution but is indeed in the 2.4 sources.
> Not needed (tested). Removed.

Caveat: a simple test of one or a few device(s) is not exactly
verification that this wasn't useful at all, but given we can't figure
out a proper reason for it, removing it seems prudent.

> >> +             }
> >> +     }
> >> +     kfree(oob);
> >> +     sharpsl_mtd_logical = logical;
> >> +
> >> +     pr_info("Sharp SL FTL: %d blocks used (%d logical, %d reserved)\n",
> >> +             logical->phymax, logical->logmax,
> >> +             logical->phymax - logical->logmax);
> >> +
> >> +     return 0;
> >> +}
> >> +

...

> >> +int sharpsl_nand_read_laddr(struct mtd_info *mtd,
> >> +                         loff_t from,
> >> +                         size_t len,
> >> +                         u_char *buf)
> >> +{
> >> +     struct mtd_logical *logical;
> >> +     u_int log_num, log_new;
> >> +     u_int block_num;
> >> +     loff_t block_adr;
> >> +     loff_t block_ofs;
> >> +     size_t retlen;
> >> +     int ret;
> >> +
> >> +     logical = sharpsl_mtd_logical;
> >> +     log_num = (u32)from / mtd->erasesize;
> >> +     log_new = ((u32)from + len - 1) / mtd->erasesize;
> >> +
> >> +     if (len <= 0 || log_num >= logical->logmax || log_new > log_num)
> >> +             return -EINVAL;
> >> +
> >> +     block_num = logical->log2phy[log_num];
> >> +     block_adr = block_num * mtd->erasesize;
> >> +     block_ofs = (u32)from % mtd->erasesize;
> >> +
> >> +     ret = mtd_read(mtd, block_adr + block_ofs, len, &retlen, buf);
> >> +     if (ret != 0 || len != retlen)
> >
> > What about ret == -EUCLEAN? Do you want to handle corrected bitflips?
> >
> 
> I have changed the checks here and have taken the code of mtdtest_read()
> so to ignorer bitflips and pass the error through.

Yes, I suppose that is a fine pattern. You can't really do anything
about high numbers of bitflilps, unless you really want to add in write
support (in which case you could probably try to copy/migrate the table
to an available block).

> >> +             return -EINVAL;
> >> +
> >> +     return 0;
> >> +}

...

> >> diff --git a/drivers/mtd/sharpslpart.c b/drivers/mtd/sharpslpart.c
> >> new file mode 100644
> >> index 0000000..40aebe9
> >> --- /dev/null
> >> +++ b/drivers/mtd/sharpslpart.c
> >> @@ -0,0 +1,132 @@
> >> +/*
> >> + * MTD partition parser for NAND flash on Sharp SL Series
> >> + *
> >> + * Copyright (C) 2017 Andrea Adami <andrea.adami@gmail.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License as published by
> >> + * the Free Software Foundation; either version 2 of the License, or
> >> + * (at your option) any later version.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + *
> >> + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/module.h>
> >> +#include <linux/mtd/mtd.h>
> >> +#include <linux/mtd/partitions.h>
> >> +#include "sharpsl_ftl.h"
> >> +
> >> +/* factory defaults */
> >> +#define SHARPSL_NAND_PARTS           3
> >> +#define SHARPSL_FTL_PARTITION_SIZE   (7 * 1024 * 1024)
> >> +#define PARAM_BLOCK_PARTITIONINFO1   0x00060000
> >> +#define PARAM_BLOCK_PARTITIONINFO2   0x00064000
> >> +
> >> +#define BOOT_MAGIC                   be32_to_cpu(0x424f4f54)   /* BOOT */
> >> +#define FSRO_MAGIC                   be32_to_cpu(0x4653524f)   /* FSRO */
> >> +#define FSRW_MAGIC                   be32_to_cpu(0x46535257)   /* FSRW */
> >> +
> >> +/*
> >> + * Sample values read from SL-C860
> >> + *
> >> + * # cat /proc/mtd
> >> + * dev:    size   erasesize  name
> >> + * mtd0: 006d0000 00020000 "Filesystem"
> >> + * mtd1: 00700000 00004000 "smf"
> >> + * mtd2: 03500000 00004000 "root"
> >> + * mtd3: 04400000 00004000 "home"
> >> + *
> >> + * PARTITIONINFO1
> >> + * 0x00060000: 00 00 00 00 00 00 70 00 42 4f 4f 54 00 00 00 00  ......p.BOOT....
> >> + * 0x00060010: 00 00 70 00 00 00 c0 03 46 53 52 4f 00 00 00 00  ..p.....FSRO....
> >> + * 0x00060020: 00 00 c0 03 00 00 00 04 46 53 52 57 00 00 00 00  ........FSRW....
> >> + * 0x00060030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> >> + *
> >> + */
> >> +
> >> +struct sharpsl_nand_partitioninfo {
> >> +     u32 start;
> >> +     u32 end;
> >> +     u32 magic;
> >> +     u32 reserved;
> >> +};
> >> +
> >> +static int sharpsl_parse_mtd_partitions(struct mtd_info *master,
> >> +                                     const struct mtd_partition **pparts,
> >> +                                     struct mtd_part_parser_data *data)
> >> +{
> >> +     struct sharpsl_nand_partitioninfo buf1[SHARPSL_NAND_PARTS];
> >> +     struct sharpsl_nand_partitioninfo buf2[SHARPSL_NAND_PARTS];
> >> +     struct mtd_partition *sharpsl_nand_parts;
> >> +
> >> +     /* init logical mgmt (FTL) */
> >
> > Do you have any kind of validation logic, to ensure that this parser
> > actually matches? What if the flash was erased? Or what if somebody
> > managed to reformat to some other flash layout?
> >
> 
> The bootloader loads and launches the zImage1 found at a specific
> logical address.
> If mtd1 were invalid there would be no boot.
> 
> See, 10yrs ago there was an unofficial u-boot port for experienced users.
> That was requiring to full-erase the nand, so removing the maintenance
> and diag code
> This would be the only case of modified partition layout I can think of.

My point wasn't really just for well-handled devices, or even Sharp
devices at all. What if this partition parser ends up in the parser list
for some other random device? e.g., when we add better device tree
support for other parsers, it'll start becoming easier for arbitrary
platforms to utilize arbitrary parsers; I wouldn't expect people to want
to use this parser, but if we have a quick way to say "this doesn't
match, skip me", then that would be helpful.

Or maybe another case: what if someone utilizes some completely
different partition layout (and gets their bootloader to handle it) but
is still otherwise using the same kernel/platform support? We don't want
to waste too much time scanning for this partition table if possible.

> > I suppose for many cases like that, the logical mapping will turn up
> > with a lot of UINT_MAX entries, and then sharpsl_nand_read_laddr() will
> > return -EINVAL? It'd be nice if there were some more clear sanity
> > checks though, if possible. Does this FTL have a header we should be
> > looking for?
> 
> I expect -EINVAL in that case.
> BUT if one would be usingh u-boot then he'd have partitions in
> u-boot.env or in cmdline.
> 
> The (infamous)  header is copied here:
> 
> https://github.com/LinuxPDA/Sharp_FTL_2.4.20/blob/master/linux/drivers/mtd/nand/sharp_sl_logical.c

That doesn't seem to have much more that can help us. Maybe your current
version is the best we can do.

> Full sources available at
> http://support.ezaurus.com/developer/source/source_dl.asp
> 
> >
> >> +     if (sharpsl_nand_init_logical(master, SHARPSL_FTL_PARTITION_SIZE))
> >> +             return -EINVAL;
> >> +
> >> +     /* read the two partition tables */
> >> +     if (sharpsl_nand_read_laddr(master,
> >> +                                 PARAM_BLOCK_PARTITIONINFO1,
> >> +                                 sizeof(buf1), (u_char *)&buf1) ||
> >> +         sharpsl_nand_read_laddr(master,
> >> +                                 PARAM_BLOCK_PARTITIONINFO2,
> >> +                                 sizeof(buf2), (u_char *)&buf2))
> >> +             return -EINVAL;
...

Brian
