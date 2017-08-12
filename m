From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v4 1/9] mtd: sharpslpart: add sharpslpart MTD partition
 parser
Date: Sat, 12 Aug 2017 14:35:04 -0700
Message-ID: <20170812213504.GA90795@google.com>
References: <1498681836-3765-1-git-send-email-andrea.adami@gmail.com>
 <1498681836-3765-2-git-send-email-andrea.adami@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:37869 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752419AbdHLVfJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sat, 12 Aug 2017 17:35:09 -0400
Content-Disposition: inline
In-Reply-To: <1498681836-3765-2-git-send-email-andrea.adami@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Adami <andrea.adami@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Andrea,

I'm sorry this had to wait so long, but then...you didn't actually
address several of my comments from the last time :(

This does look better, but still quite a few smaller notes. Hopefully
next one will be merge-able...

On Wed, Jun 28, 2017 at 10:30:28PM +0200, Andrea Adami wrote:
> The Sharp SL Series (Zaurus) PXA handhelds have 16/64/128M of NAND flash
> and share the same layout of the first 7M partition, managed by Sharp FTL.
> 
> The purpose of this self-contained patch is to add a common parser and
> remove the hardcoded sizes in the board files (these devices are not yet
> converted to devicetree).
> Users will have benefits because the mtdparts= tag will not be necessary
> anymore and they will be free to repartition the little sized flash.
> 
> The obsolete bootloader can not pass the partitioning info to modern
> kernels anymore so it has to be read from flash at known logical addresses.
> (see http://www.h5.dion.ne.jp/~rimemoon/zaurus/memo_006.htm )
> 
> In kernel, under arch/arm/mach-pxa we have already 8 machines:
> MACH_POODLE, MACH_CORGI, MACH_SHEPERD, MACH_HUSKY, MACH_AKITA, MACH_SPITZ,
> MACH_BORZOI, MACH_TOSA.
> Lost after the 2.4 vendor kernel are MACH_BOXER and MACH_TERRIER.
> 
> Almost every model has different factory partitioning: add to this the
> units can be repartitioned by users with userspace tools (nandlogical)
> and installers for popular (back then) linux distributions.
> 
> The Parameter Area in the first (boot) partition extends from 0x00040000 to
> 0x0007bfff (176k) and contains two copies of the partition table:
> ...
> 0x00060000: Partition Info1     16k
> 0x00064000: Partition Info2     16k
> 0x00668000: Model               16k
> ...
> 
> The first 7M partition is managed by the Sharp FTL reserving 5% + 1 blocks
> for wear-leveling: some blocks are remapped and one layer of translation
> (logical to physical) is necessary.
> 
> There isn't much documentation about this FTL in the 2.4 sources, just the
> MTD methods for reading and writing using logical addresses and the block
> management (wear-leveling, use counter).
> For the purpose of the MTD parser only the read part of the code was taken.
> 
> The NAND drivers that can use this parser are sharpsl.c and tmio_nand.c.
> 
> Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
> ---
>  drivers/mtd/Kconfig       |   8 +
>  drivers/mtd/Makefile      |   1 +
>  drivers/mtd/sharpslpart.c | 391 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 400 insertions(+)
>  create mode 100644 drivers/mtd/sharpslpart.c
> 
> diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
> index e83a279..b196a69 100644
> --- a/drivers/mtd/Kconfig
> +++ b/drivers/mtd/Kconfig
> @@ -155,6 +155,14 @@ config MTD_BCM47XX_PARTS
>  	  This provides partitions parser for devices based on BCM47xx
>  	  boards.
>  
> +config MTD_SHARPSL_PARTS
> +	tristate "Sharp SL Series NAND flash partition parser"
> +	depends on MTD_NAND_SHARPSL || MTD_NAND_TMIO || COMPILE_TEST
> +	help
> +	  This provides the read-only FTL logic necessary to read the partition
> +	  table from the NAND flash of Sharp SL Series (Zaurus) and the MTD
> +	  partition parser using this code.
> +

This has conflicts now; probably should go in
drivers/mtd/parsers/Kconfig now. We should also probably move the other
parsers there, but that's not your problem.

>  comment "User Modules And Translation Layers"
>  
>  #
> diff --git a/drivers/mtd/Makefile b/drivers/mtd/Makefile
> index 99bb9a1..e5ef07f 100644
> --- a/drivers/mtd/Makefile
> +++ b/drivers/mtd/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_MTD_AFS_PARTS)	+= afs.o
>  obj-$(CONFIG_MTD_AR7_PARTS)	+= ar7part.o
>  obj-$(CONFIG_MTD_BCM63XX_PARTS)	+= bcm63xxpart.o
>  obj-$(CONFIG_MTD_BCM47XX_PARTS)	+= bcm47xxpart.o
> +obj-$(CONFIG_MTD_SHARPSL_PARTS)	+= sharpslpart.o

Also has conflicts now. Might as well move to drivers/mtd/parsers/?

>  
>  # 'Users' - code which presents functionality to userspace.
>  obj-$(CONFIG_MTD_BLKDEVS)	+= mtd_blkdevs.o
> diff --git a/drivers/mtd/sharpslpart.c b/drivers/mtd/sharpslpart.c
> new file mode 100644
> index 0000000..02b721b
> --- /dev/null
> +++ b/drivers/mtd/sharpslpart.c
> @@ -0,0 +1,391 @@
> +/*
> + * sharpslpart.c - MTD partition parser for NAND flash using the SHARP FTL
> + * for logical addressing, as used on the PXA models of the SHARP SL Series.
> + *
> + * Copyright (C) 2017 Andrea Adami <andrea.adami@gmail.com>
> + *
> + * Based on 2.4 sources:
> + *  drivers/mtd/nand/sharp_sl_logical.c
> + *  linux/include/asm-arm/sharp_nand_logical.h
> + *
> + * Copyright (C) 2002 SHARP
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/module.h>
> +#include <linux/types.h>
> +#include <linux/mtd/mtd.h>
> +#include <linux/mtd/partitions.h>
> +
> +/* oob structure */
> +#define NAND_NOOB_LOGADDR_00		8
> +#define NAND_NOOB_LOGADDR_01		9
> +#define NAND_NOOB_LOGADDR_10		10
> +#define NAND_NOOB_LOGADDR_11		11
> +#define NAND_NOOB_LOGADDR_20		12
> +#define NAND_NOOB_LOGADDR_21		13
> +
> +#define BLOCK_IS_RESERVED		0xffff
> +#define BLOCK_UNMASK			0x07fe
> +#define BLOCK_UNMASK_COMPLEMENT		1
> +
> +/* factory defaults */
> +#define SHARPSL_NAND_PARTS		3
> +#define SHARPSL_FTL_PARTITION_SIZE	(7 * 1024 * 1024)
> +#define PARAM_BLOCK_PARTITIONINFO1	0x00060000
> +#define PARAM_BLOCK_PARTITIONINFO2	0x00064000
> +
> +#define buf_start(x)			le32_to_cpu(buf1[x].start)
> +#define buf_end(x)			le32_to_cpu(buf1[x].end)
> +#define buf_magic(x)			be32_to_cpu(buf1[x].magic)

Sorry, these aren't good macros; they implicitly rely on a 'buf1'
variable, without using it as an argument to the macro. That hurts
readability. If you want this macro, give it 2 args.

> +
> +#define BOOT_MAGIC			0x424f4f54   /* BOOT */
> +#define FSRO_MAGIC			0x4653524f   /* FSRO */
> +#define FSRW_MAGIC			0x46535257   /* FSRW */
> +
> +/* Logical Table */
> +struct mtd_logical {
> +	u32 size;		/* size of the handled partition */
> +	int index;		/* mtd->index */
> +	u_int phymax;		/* physical blocks */
> +	u_int logmax;		/* logical blocks */
> +	u_int *log2phy;		/* the logical-to-physical table */
> +};
> +
> +struct mtd_logical *sharpsl_mtd_logical;

I asked you not to avoid making this variable static...and I suppose
technically you did this. But global is even worse! And you really don't
need to do this; just make sharpsl_nand_init_logical() return struct
mtd_logical, and then you don't need any global/static reference at all.

> +
> +/*
> + * SHARP SL FTL ancillary functions
> + *
> + */
> +
> +static int sharpsl_nand_read_oob(struct mtd_info *mtd, loff_t offs, size_t len,
> +				 uint8_t *buf)
> +{
> +	loff_t mask = mtd->writesize - 1;
> +	struct mtd_oob_ops ops;
> +	int ret;
> +
> +	ops.mode = MTD_OPS_PLACE_OOB;
> +	ops.ooboffs = offs & mask;
> +	ops.ooblen = len;
> +	ops.oobbuf = buf;
> +	ops.datbuf = NULL;
> +
> +	ret = mtd_read_oob(mtd, offs & ~mask, &ops);
> +	if (ret != 0 || len != ops.oobretlen)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +/*
> + * The logical block number assigned to a physical block is stored in the OOB
> + * of the first page, in 3 16-bit copies with the following layout:
> + *
> + * 01234567 89abcdef
> + * -------- --------
> + * ECC BB   xyxyxy
> + *
> + * When reading we check that the first two copies agree.
> + * In case of error, matching is tried using the following pairs.
> + * Reserved values 0xffff mean the block is kept for wear leveling.
> + *
> + * 01234567 89abcdef
> + * -------- --------
> + * ECC BB   xyxy    oob[8]==oob[10] && oob[9]==oob[11]   -> byte0=8   byte1=9
> + * ECC BB     xyxy  oob[10]==oob[12] && oob[11]==oob[13] -> byte0=10  byte1=11
> + * ECC BB   xy  xy  oob[12]==oob[8] && oob[13]==oob[9]   -> byte0=12  byte1=13
> + *
> + */

Thanks for this. Much nicer.

> +
> +static u_int sharpsl_nand_get_logical_num(u_char *oob)
> +{
> +	u16 us;
> +	int good0, good1;
> +
> +	if (oob[NAND_NOOB_LOGADDR_00] == oob[NAND_NOOB_LOGADDR_10] &&
> +	    oob[NAND_NOOB_LOGADDR_01] == oob[NAND_NOOB_LOGADDR_11]) {
> +		good0 = NAND_NOOB_LOGADDR_00;
> +		good1 = NAND_NOOB_LOGADDR_01;
> +	} else if (oob[NAND_NOOB_LOGADDR_10] == oob[NAND_NOOB_LOGADDR_20] &&
> +		   oob[NAND_NOOB_LOGADDR_11] == oob[NAND_NOOB_LOGADDR_21]) {
> +		good0 = NAND_NOOB_LOGADDR_10;
> +		good1 = NAND_NOOB_LOGADDR_11;
> +	} else if (oob[NAND_NOOB_LOGADDR_20] == oob[NAND_NOOB_LOGADDR_00] &&
> +		   oob[NAND_NOOB_LOGADDR_21] == oob[NAND_NOOB_LOGADDR_01]) {
> +		good0 = NAND_NOOB_LOGADDR_20;
> +		good1 = NAND_NOOB_LOGADDR_21;
> +	} else {
> +		/* wrong oob fingerprint, maybe here by mistake? */
> +		return UINT_MAX;
> +	}
> +
> +	us = oob[good0] | oob[good1] << 8;
> +
> +	/* parity check */
> +	if (hweight16(us) & BLOCK_UNMASK_COMPLEMENT)
> +		return (UINT_MAX - 1);
> +
> +	/* reserved */
> +	if (us == BLOCK_IS_RESERVED)
> +		return BLOCK_IS_RESERVED;
> +	else
> +		return (us & BLOCK_UNMASK) >> 1;
> +}
> +
> +int sharpsl_nand_init_logical(struct mtd_info *mtd, u32 partition_size)

static?

> +{
> +	struct mtd_logical *logical;
> +	u_int block_num, log_num;
> +	loff_t block_adr;
> +	u_char *oob;
> +	int i;
> +
> +	logical = kzalloc(sizeof(*logical), GFP_KERNEL);
> +	if (!logical)
> +		return -ENOMEM;
> +
> +	oob = kzalloc(mtd->oobsize, GFP_KERNEL);
> +	if (!oob) {
> +		kfree(logical);
> +		return -ENOMEM;
> +	}
> +
> +	/* initialize management structure */
> +	logical->size = partition_size;
> +	logical->index = mtd->index;
> +	logical->phymax = (partition_size / mtd->erasesize);
> +
> +	/* FTL reserves 5% of the blocks + 1 spare  */
> +	logical->logmax = ((logical->phymax * 95) / 100) - 1;
> +
> +	logical->log2phy = NULL;

What's this for? You're re-assigning it immediately following.

> +	logical->log2phy = kmalloc_array(logical->logmax, sizeof(u_int),
> +					 GFP_KERNEL);
> +	if (!logical->log2phy) {
> +		kfree(logical);
> +		kfree(oob);
> +		return -ENOMEM;
> +	}
> +
> +	/* initialize logical->log2phy */
> +	for (i = 0; i < logical->logmax; i++)
> +		logical->log2phy[i] = UINT_MAX;
> +
> +	/* create physical-logical table */
> +	for (block_num = 0; block_num < logical->phymax; block_num++) {
> +		block_adr = block_num * mtd->erasesize;
> +
> +		if (mtd_block_isbad(mtd, block_adr))
> +			continue;
> +
> +		if (sharpsl_nand_read_oob(mtd, block_adr, mtd->oobsize, oob))
> +			continue;
> +
> +		/* get logical block */
> +		log_num = sharpsl_nand_get_logical_num(oob);
> +
> +		/* FTL is not used? Exit here if the oob fingerprint is wrong */
> +		if (log_num == UINT_MAX) {
> +			pr_info("sharpslpart: Sharp SL FTL not found. Quit parser.\n");
> +			kfree(logical->log2phy);
> +			kfree(logical);
> +			kfree(oob);
> +			return -EINVAL;
> +		}
> +
> +		/* skip out of range and not unique values */
> +		if (log_num < logical->logmax) {
> +			if (logical->log2phy[log_num] == UINT_MAX)
> +				logical->log2phy[log_num] = block_num;
> +		}
> +	}
> +	kfree(oob);
> +	sharpsl_mtd_logical = logical;
> +
> +	pr_info("Sharp SL FTL: %d blocks used (%d logical, %d reserved)\n",
> +		logical->phymax, logical->logmax,
> +		logical->phymax - logical->logmax);
> +
> +	return 0;
> +}
> +
> +void sharpsl_nand_cleanup_logical(struct mtd_logical *sharpsl_mtd_logical)

static?

And why don't you just name the arg 'logical' and...

> +{
> +	struct mtd_logical *logical = sharpsl_mtd_logical;

...drop this?

> +
> +	sharpsl_mtd_logical = NULL;

If you kill the global, you don't need this.

> +
> +	kfree(logical->log2phy);
> +	logical->log2phy = NULL;

Not necessary.

> +	kfree(logical);
> +	logical = NULL;

Not necessary.

> +}
> +
> +int sharpsl_nand_read_laddr(struct mtd_info *mtd,

static?

> +			    loff_t from,
> +			    size_t len,
> +			    u_char *buf)
> +{
> +	struct mtd_logical *logical;

Make 'logical' a parameter, so you don't need the global.

> +	u_int log_num, log_new;
> +	u_int block_num;
> +	loff_t block_adr;
> +	loff_t block_ofs;
> +	size_t retlen;
> +	int err;
> +
> +	logical = sharpsl_mtd_logical;
> +	log_num = (u32)from / mtd->erasesize;
> +	log_new = ((u32)from + len - 1) / mtd->erasesize;
> +
> +	if (len <= 0 || log_num >= logical->logmax || log_new > log_num)
> +		return -EINVAL;
> +
> +	block_num = logical->log2phy[log_num];
> +	block_adr = block_num * mtd->erasesize;
> +	block_ofs = (u32)from % mtd->erasesize;
> +
> +	err = mtd_read(mtd, block_adr + block_ofs, len, &retlen, buf);
> +	/* Ignore corrected ECC errors */
> +	if (mtd_is_bitflip(err))
> +		err = 0;
> +	if (!err && retlen != len)
> +		err = -EIO;
> +	if (err)
> +		pr_err("sharpslpart: error, read failed at %#llx\n",
> +		       block_adr + block_ofs);
> +
> +	return err;
> +}
> +
> +/*
> + * MTD Partition Parser
> + *
> + */
> +
> +struct sharpsl_nand_partitioninfo {
> +	u32 start;
> +	u32 end;

Should the above 2 be '__le32'?

> +	u32 magic;

It's a little odd that the same on-flash structure would have both BE
and LE elements, but I guess judging by usage...this should be '__be32'.

> +	u32 reserved;
> +};
> +
> +/*
> + * Sample values read from SL-C860
> + *
> + * # cat /proc/mtd
> + * dev:    size   erasesize  name
> + * mtd0: 006d0000 00020000 "Filesystem"
> + * mtd1: 00700000 00004000 "smf"
> + * mtd2: 03500000 00004000 "root"
> + * mtd3: 04400000 00004000 "home"
> + *
> + * PARTITIONINFO1
> + * 0x00060000: 00 00 00 00 00 00 70 00 42 4f 4f 54 00 00 00 00  ......p.BOOT....
> + * 0x00060010: 00 00 70 00 00 00 c0 03 46 53 52 4f 00 00 00 00  ..p.....FSRO....
> + * 0x00060020: 00 00 c0 03 00 00 00 04 46 53 52 57 00 00 00 00  ........FSRW....
> + * 0x00060030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
> + *
> + */
> +
> +static int sharpsl_parse_mtd_partitions(struct mtd_info *master,
> +					const struct mtd_partition **pparts,
> +					struct mtd_part_parser_data *data)
> +{
> +	struct sharpsl_nand_partitioninfo buf1[SHARPSL_NAND_PARTS];
> +	struct sharpsl_nand_partitioninfo buf2[SHARPSL_NAND_PARTS];
> +	struct mtd_partition *sharpsl_nand_parts;
> +	int err;
> +
> +	/* init logical mgmt (FTL) */
> +	if (sharpsl_nand_init_logical(master, SHARPSL_FTL_PARTITION_SIZE))
> +		return -EINVAL;

Please propagate the error...

> +
> +	/* read the two partition tables */
> +	err = sharpsl_nand_read_laddr(master,
> +				      PARAM_BLOCK_PARTITIONINFO1,
> +				      sizeof(buf1), (u_char *)&buf1);
> +	if (!err) {
> +		sharpsl_nand_read_laddr(master,
> +					PARAM_BLOCK_PARTITIONINFO2,
> +					sizeof(buf2), (u_char *)&buf2);

You don't really need this block under the 'if'. You can just invert
this to 'if (err)', since the second block will return early.

Brian

> +	} else {
> +		sharpsl_nand_cleanup_logical(sharpsl_mtd_logical);
> +		return err;
> +	}
> +
> +	/* cleanup logical mgmt (FTL) */
> +	sharpsl_nand_cleanup_logical(sharpsl_mtd_logical);
> +
> +	/* compare the two buffers */
> +	if (memcmp(&buf1, &buf2, sizeof(buf1))) {
> +		pr_err("sharpslpart: PARTITIONINFO 1,2 differ. Quit parser.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* check for magics (just in the first) */
> +	if (buf_magic(0) != BOOT_MAGIC ||
> +	    buf_magic(1) != FSRO_MAGIC ||
> +	    buf_magic(2) != FSRW_MAGIC) {
> +		pr_err("sharpslpart: magic values mismatch. Quit parser.\n");
> +		return -EINVAL;
> +	}
> +
> +	/* fixup for hardcoded value 64 MiB (for older models) */
> +	buf1[2].end = cpu_to_le32(master->size);
> +
> +	/* extra sanity check */
> +	if (buf_end(0) <= buf_start(0) ||
> +	    buf_start(1) < buf_end(0) ||
> +	    buf_end(1) <= buf_start(1) ||
> +	    buf_start(2) < buf_end(1) ||
> +	    buf_end(2) <= buf_start(2)) {
> +		pr_err("sharpslpart: partition sizes mismatch. Quit parser.\n");
> +		return -EINVAL;
> +	}
> +
> +	sharpsl_nand_parts = kzalloc(sizeof(*sharpsl_nand_parts) *
> +				     SHARPSL_NAND_PARTS, GFP_KERNEL);
> +	if (!sharpsl_nand_parts)
> +		return -ENOMEM;
> +
> +	/* original names */
> +	sharpsl_nand_parts[0].name = "smf";
> +	sharpsl_nand_parts[0].offset = buf_start(0);
> +	sharpsl_nand_parts[0].size = buf_end(0) - buf_start(0);
> +
> +	sharpsl_nand_parts[1].name = "root";
> +	sharpsl_nand_parts[1].offset = buf_start(1);
> +	sharpsl_nand_parts[1].size = buf_end(1) - buf_start(1);
> +
> +	sharpsl_nand_parts[2].name = "home";
> +	sharpsl_nand_parts[2].offset = buf_start(2);
> +	sharpsl_nand_parts[2].size = buf_end(2) - buf_start(2);
> +
> +	*pparts = sharpsl_nand_parts;
> +	return SHARPSL_NAND_PARTS;
> +}
> +
> +static struct mtd_part_parser sharpsl_mtd_parser = {
> +	.parse_fn = sharpsl_parse_mtd_partitions,
> +	.name = "sharpslpart",
> +};
> +module_mtd_part_parser(sharpsl_mtd_parser);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Andrea Adami <andrea.adami@gmail.com>");
> +MODULE_DESCRIPTION("MTD partitioning for NAND flash on Sharp SL Series");
> -- 
> 2.7.4
> 
