From: Andrea Adami <andrea.adami@gmail.com>
Subject: [PATCH v5 1/9] mtd: sharpslpart: Add sharpslpart partition parser
Date: Mon, 14 Aug 2017 22:48:32 +0200
Message-ID: <1502743720-28672-2-git-send-email-andrea.adami@gmail.com>
References: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1502743720-28672-1-git-send-email-andrea.adami@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: linux-mtd@lists.infradead.org
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Richard Weinberger <richard@nod.at>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-mmc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Lee Jones <lee.jones@linaro.org>, Brian Norris <computersforpeace@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Linus Walleij <linus.walleij@linaro.org>, Daniel Mack <daniel@zonque.org>
List-Id: linux-mmc@vger.kernel.org

The Sharp SL Series (Zaurus) PXA handhelds have 16/64/128M of NAND flash
and share the same layout of the first 7M partition, managed by Sharp FTL.

The purpose of this self-contained patch is to add a common parser and
remove the hardcoded sizes in the board files (these devices are not yet
converted to devicetree).
Users will have benefits because the mtdparts= tag will not be necessary
anymore and they will be free to repartition the little sized flash.

The obsolete bootloader can not pass the partitioning info to modern
kernels anymore so it has to be read from flash at known logical addresses.
(see http://www.h5.dion.ne.jp/~rimemoon/zaurus/memo_006.htm )

In kernel, under arch/arm/mach-pxa we have already 8 machines:
MACH_POODLE, MACH_CORGI, MACH_SHEPERD, MACH_HUSKY, MACH_AKITA, MACH_SPITZ,
MACH_BORZOI, MACH_TOSA.
Lost after the 2.4 vendor kernel are MACH_BOXER and MACH_TERRIER.

Almost every model has different factory partitioning: add to this the
units can be repartitioned by users with userspace tools (nandlogical)
and installers for popular (back then) linux distributions.

The Parameter Area in the first (boot) partition extends from 0x00040000 to
0x0007bfff (176k) and contains two copies of the partition table:
...
0x00060000: Partition Info1     16k
0x00064000: Partition Info2     16k
0x00668000: Model               16k
...

The first 7M partition is managed by the Sharp FTL reserving 5% + 1 blocks
for wear-leveling: some blocks are remapped and one layer of translation
(logical to physical) is necessary.

There isn't much documentation about this FTL in the 2.4 sources, just the
MTD methods for reading and writing using logical addresses and the block
management (wear-leveling, use counter).
For the purpose of the MTD parser only the read part of the code was taken.

The NAND drivers that can use this parser are sharpsl.c and tmio_nand.c.

Signed-off-by: Andrea Adami <andrea.adami@gmail.com>
---
 drivers/mtd/parsers/Kconfig       |   8 +
 drivers/mtd/parsers/Makefile      |   1 +
 drivers/mtd/parsers/sharpslpart.c | 376 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 385 insertions(+)
 create mode 100644 drivers/mtd/parsers/sharpslpart.c

diff --git a/drivers/mtd/parsers/Kconfig b/drivers/mtd/parsers/Kconfig
index d206b3c..ee5ab99 100644
--- a/drivers/mtd/parsers/Kconfig
+++ b/drivers/mtd/parsers/Kconfig
@@ -6,3 +6,11 @@ config MTD_PARSER_TRX
 	  may contain up to 3/4 partitions (depending on the version).
 	  This driver will parse TRX header and report at least two partitions:
 	  kernel and rootfs.
+
+config MTD_SHARPSL_PARTS
+	tristate "Sharp SL Series NAND flash partition parser"
+	depends on MTD_NAND_SHARPSL || MTD_NAND_TMIO || COMPILE_TEST
+	help
+	  This provides the read-only FTL logic necessary to read the partition
+	  table from the NAND flash of Sharp SL Series (Zaurus) and the MTD
+	  partition parser using this code.
diff --git a/drivers/mtd/parsers/Makefile b/drivers/mtd/parsers/Makefile
index 4d9024e..5b1bcc3 100644
--- a/drivers/mtd/parsers/Makefile
+++ b/drivers/mtd/parsers/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_MTD_PARSER_TRX)		+= parser_trx.o
+obj-$(CONFIG_MTD_SHARPSL_PARTS)		+= sharpslpart.o
diff --git a/drivers/mtd/parsers/sharpslpart.c b/drivers/mtd/parsers/sharpslpart.c
new file mode 100644
index 0000000..2511059
--- /dev/null
+++ b/drivers/mtd/parsers/sharpslpart.c
@@ -0,0 +1,376 @@
+/*
+ * sharpslpart.c - MTD partition parser for NAND flash using the SHARP FTL
+ * for logical addressing, as used on the PXA models of the SHARP SL Series.
+ *
+ * Copyright (C) 2017 Andrea Adami <andrea.adami@gmail.com>
+ *
+ * Based on 2.4 sources:
+ *  drivers/mtd/nand/sharp_sl_logical.c
+ *  linux/include/asm-arm/sharp_nand_logical.h
+ *
+ * Copyright (C) 2002 SHARP
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+/* oob structure */
+#define NAND_NOOB_LOGADDR_00		8
+#define NAND_NOOB_LOGADDR_01		9
+#define NAND_NOOB_LOGADDR_10		10
+#define NAND_NOOB_LOGADDR_11		11
+#define NAND_NOOB_LOGADDR_20		12
+#define NAND_NOOB_LOGADDR_21		13
+
+#define BLOCK_IS_RESERVED		0xffff
+#define BLOCK_UNMASK			0x07fe
+#define BLOCK_UNMASK_COMPLEMENT		1
+
+/* factory defaults */
+#define SHARPSL_NAND_PARTS		3
+#define SHARPSL_FTL_PARTITION_SIZE	(7 * 1024 * 1024)
+#define PARAM_BLOCK_PARTITIONINFO1	0x00060000
+#define PARAM_BLOCK_PARTITIONINFO2	0x00064000
+
+#define BOOT_MAGIC			0x424f4f54   /* BOOT */
+#define FSRO_MAGIC			0x4653524f   /* FSRO */
+#define FSRW_MAGIC			0x46535257   /* FSRW */
+
+/* Logical Table */
+struct mtd_logical {
+	u32 size;		/* size of the handled partition */
+	int index;		/* mtd->index */
+	u_int phymax;		/* physical blocks */
+	u_int logmax;		/* logical blocks */
+	u_int *log2phy;		/* the logical-to-physical table */
+};
+
+/*
+ * SHARP SL FTL ancillary functions
+ *
+ */
+
+static int sharpsl_nand_read_oob(struct mtd_info *mtd, loff_t offs, size_t len,
+				 uint8_t *buf)
+{
+	loff_t mask = mtd->writesize - 1;
+	struct mtd_oob_ops ops;
+	int ret;
+
+	ops.mode = MTD_OPS_PLACE_OOB;
+	ops.ooboffs = offs & mask;
+	ops.ooblen = len;
+	ops.oobbuf = buf;
+	ops.datbuf = NULL;
+
+	ret = mtd_read_oob(mtd, offs & ~mask, &ops);
+	if (ret != 0 || len != ops.oobretlen)
+		return -1;
+
+	return 0;
+}
+
+/*
+ * The logical block number assigned to a physical block is stored in the OOB
+ * of the first page, in 3 16-bit copies with the following layout:
+ *
+ * 01234567 89abcdef
+ * -------- --------
+ * ECC BB   xyxyxy
+ *
+ * When reading we check that the first two copies agree.
+ * In case of error, matching is tried using the following pairs.
+ * Reserved values 0xffff mean the block is kept for wear leveling.
+ *
+ * 01234567 89abcdef
+ * -------- --------
+ * ECC BB   xyxy    oob[8]==oob[10] && oob[9]==oob[11]   -> byte0=8   byte1=9
+ * ECC BB     xyxy  oob[10]==oob[12] && oob[11]==oob[13] -> byte0=10  byte1=11
+ * ECC BB   xy  xy  oob[12]==oob[8] && oob[13]==oob[9]   -> byte0=12  byte1=13
+ *
+ */
+
+static u_int sharpsl_nand_get_logical_num(u_char *oob)
+{
+	u16 us;
+	int good0, good1;
+
+	if (oob[NAND_NOOB_LOGADDR_00] == oob[NAND_NOOB_LOGADDR_10] &&
+	    oob[NAND_NOOB_LOGADDR_01] == oob[NAND_NOOB_LOGADDR_11]) {
+		good0 = NAND_NOOB_LOGADDR_00;
+		good1 = NAND_NOOB_LOGADDR_01;
+	} else if (oob[NAND_NOOB_LOGADDR_10] == oob[NAND_NOOB_LOGADDR_20] &&
+		   oob[NAND_NOOB_LOGADDR_11] == oob[NAND_NOOB_LOGADDR_21]) {
+		good0 = NAND_NOOB_LOGADDR_10;
+		good1 = NAND_NOOB_LOGADDR_11;
+	} else if (oob[NAND_NOOB_LOGADDR_20] == oob[NAND_NOOB_LOGADDR_00] &&
+		   oob[NAND_NOOB_LOGADDR_21] == oob[NAND_NOOB_LOGADDR_01]) {
+		good0 = NAND_NOOB_LOGADDR_20;
+		good1 = NAND_NOOB_LOGADDR_21;
+	} else {
+		/* wrong oob fingerprint, maybe here by mistake? */
+		return UINT_MAX;
+	}
+
+	us = oob[good0] | oob[good1] << 8;
+
+	/* parity check */
+	if (hweight16(us) & BLOCK_UNMASK_COMPLEMENT)
+		return (UINT_MAX - 1);
+
+	/* reserved */
+	if (us == BLOCK_IS_RESERVED)
+		return BLOCK_IS_RESERVED;
+	else
+		return (us & BLOCK_UNMASK) >> 1;
+}
+
+static int sharpsl_nand_init_logical(struct mtd_info *mtd, u32 partition_size,
+				     struct mtd_logical **sharpsl_mtd_logical)
+{
+	struct mtd_logical *logical;
+	u_int block_num, log_num;
+	loff_t block_adr;
+	u_char *oob;
+	int i, ret;
+
+	logical = kzalloc(sizeof(*logical), GFP_KERNEL);
+	if (!logical)
+		return -ENOMEM;
+
+	oob = kzalloc(mtd->oobsize, GFP_KERNEL);
+	if (!oob) {
+		kfree(logical);
+		return -ENOMEM;
+	}
+
+	/* initialize management structure */
+	logical->size = partition_size;
+	logical->index = mtd->index;
+	logical->phymax = (partition_size / mtd->erasesize);
+
+	/* FTL reserves 5% of the blocks + 1 spare  */
+	logical->logmax = ((logical->phymax * 95) / 100) - 1;
+
+	logical->log2phy = kmalloc_array(logical->logmax, sizeof(u_int),
+					 GFP_KERNEL);
+	if (!logical->log2phy) {
+		kfree(logical);
+		kfree(oob);
+		return -ENOMEM;
+	}
+
+	/* initialize logical->log2phy */
+	for (i = 0; i < logical->logmax; i++)
+		logical->log2phy[i] = UINT_MAX;
+
+	/* create physical-logical table */
+	for (block_num = 0; block_num < logical->phymax; block_num++) {
+		block_adr = block_num * mtd->erasesize;
+
+		if (mtd_block_isbad(mtd, block_adr))
+			continue;
+
+		if (sharpsl_nand_read_oob(mtd, block_adr, mtd->oobsize, oob))
+			continue;
+
+		/* get logical block */
+		log_num = sharpsl_nand_get_logical_num(oob);
+
+		/* FTL is not used? Exit here if the oob fingerprint is wrong */
+		if (log_num == UINT_MAX) {
+			pr_info("sharpslpart: Sharp SL FTL not found. Quit parser.\n");
+			ret = -EINVAL;
+			goto exit;
+		}
+
+		/* skip out of range and not unique values */
+		if (log_num < logical->logmax) {
+			if (logical->log2phy[log_num] == UINT_MAX)
+				logical->log2phy[log_num] = block_num;
+		}
+	}
+	pr_info("Sharp SL FTL: %d blocks used (%d logical, %d reserved)\n",
+		logical->phymax, logical->logmax,
+		logical->phymax - logical->logmax);
+
+	*sharpsl_mtd_logical = logical;
+	ret = 0;
+exit:
+	kfree(logical->log2phy);
+	kfree(logical);
+	kfree(oob);
+	return ret;
+}
+
+static int sharpsl_nand_read_laddr(struct mtd_info *mtd,
+				   loff_t from,
+				   size_t len,
+				   u_char *buf,
+				   struct mtd_logical *sharpsl_mtd_logical)
+{
+	u_int log_num, log_new;
+	u_int block_num;
+	loff_t block_adr;
+	loff_t block_ofs;
+	size_t retlen;
+	int err;
+
+	log_num = (u32)from / mtd->erasesize;
+	log_new = ((u32)from + len - 1) / mtd->erasesize;
+
+	if (len <= 0 || log_num >= sharpsl_mtd_logical->logmax ||
+	    log_new > log_num)
+		return -EINVAL;
+
+	block_num = sharpsl_mtd_logical->log2phy[log_num];
+	block_adr = block_num * mtd->erasesize;
+	block_ofs = (u32)from % mtd->erasesize;
+
+	err = mtd_read(mtd, block_adr + block_ofs, len, &retlen, buf);
+	/* Ignore corrected ECC errors */
+	if (mtd_is_bitflip(err))
+		err = 0;
+	if (!err && retlen != len)
+		err = -EIO;
+	if (err)
+		pr_err("sharpslpart: error, read failed at %#llx\n",
+		       block_adr + block_ofs);
+
+	return err;
+}
+
+/*
+ * MTD Partition Parser
+ *
+ */
+
+struct sharpsl_nand_partitioninfo {
+	__le32 start;
+	__le32 end;
+	__be32 magic;
+	u32 reserved;
+};
+
+/*
+ * Sample values read from SL-C860
+ *
+ * # cat /proc/mtd
+ * dev:    size   erasesize  name
+ * mtd0: 006d0000 00020000 "Filesystem"
+ * mtd1: 00700000 00004000 "smf"
+ * mtd2: 03500000 00004000 "root"
+ * mtd3: 04400000 00004000 "home"
+ *
+ * PARTITIONINFO1
+ * 0x00060000: 00 00 00 00 00 00 70 00 42 4f 4f 54 00 00 00 00  ......p.BOOT....
+ * 0x00060010: 00 00 70 00 00 00 c0 03 46 53 52 4f 00 00 00 00  ..p.....FSRO....
+ * 0x00060020: 00 00 c0 03 00 00 00 04 46 53 52 57 00 00 00 00  ........FSRW....
+ * 0x00060030: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................
+ *
+ */
+
+static int sharpsl_parse_mtd_partitions(struct mtd_info *master,
+					const struct mtd_partition **pparts,
+					struct mtd_part_parser_data *data)
+{
+	struct mtd_logical *sharpsl_mtd_logical;
+	struct sharpsl_nand_partitioninfo buf1[SHARPSL_NAND_PARTS];
+	struct sharpsl_nand_partitioninfo buf2[SHARPSL_NAND_PARTS];
+	struct mtd_partition *sharpsl_nand_parts;
+	int err;
+
+	/* init logical mgmt (FTL) */
+	err = sharpsl_nand_init_logical(master, SHARPSL_FTL_PARTITION_SIZE,
+					&sharpsl_mtd_logical);
+	if (err)
+		return err;
+
+	/* read the two partition tables */
+	err = sharpsl_nand_read_laddr(master,
+				      PARAM_BLOCK_PARTITIONINFO1,
+				      sizeof(buf1), (u_char *)&buf1,
+				      sharpsl_mtd_logical) ||
+	sharpsl_nand_read_laddr(master,
+				PARAM_BLOCK_PARTITIONINFO2,
+				sizeof(buf2), (u_char *)&buf2,
+				sharpsl_mtd_logical);
+	if (err)
+		return err;
+
+	/* compare the two buffers */
+	if (memcmp(&buf1, &buf2, sizeof(buf1))) {
+		pr_err("sharpslpart: PARTITIONINFO 1,2 differ. Quit parser.\n");
+		return -EINVAL;
+	}
+
+	/* check for magics (just in the first) */
+	if (be32_to_cpu(buf1[0].magic) != BOOT_MAGIC ||
+	    be32_to_cpu(buf1[1].magic) != FSRO_MAGIC ||
+	    be32_to_cpu(buf1[2].magic) != FSRW_MAGIC) {
+		pr_err("sharpslpart: magic values mismatch. Quit parser.\n");
+		return -EINVAL;
+	}
+
+	/* fixup for hardcoded value 64 MiB (for older models) */
+	buf1[2].end = cpu_to_le32(master->size);
+
+	/* extra sanity check */
+	if (le32_to_cpu(buf1[0].end) <= le32_to_cpu(buf1[0].start) ||
+	    le32_to_cpu(buf1[1].start) < le32_to_cpu(buf1[0].end) ||
+	    le32_to_cpu(buf1[1].end) <= le32_to_cpu(buf1[1].start) ||
+	    le32_to_cpu(buf1[2].start) < le32_to_cpu(buf1[1].end) ||
+	    le32_to_cpu(buf1[2].end) <= le32_to_cpu(buf1[2].start)) {
+		pr_err("sharpslpart: partition sizes mismatch. Quit parser.\n");
+		return -EINVAL;
+	}
+
+	sharpsl_nand_parts = kzalloc(sizeof(*sharpsl_nand_parts) *
+				     SHARPSL_NAND_PARTS, GFP_KERNEL);
+	if (!sharpsl_nand_parts)
+		return -ENOMEM;
+
+	/* original names */
+	sharpsl_nand_parts[0].name = "smf";
+	sharpsl_nand_parts[0].offset = le32_to_cpu(buf1[0].start);
+	sharpsl_nand_parts[0].size = le32_to_cpu(buf1[0].end) -
+				     le32_to_cpu(buf1[0].start);
+
+	sharpsl_nand_parts[1].name = "root";
+	sharpsl_nand_parts[1].offset = le32_to_cpu(buf1[1].start);
+	sharpsl_nand_parts[1].size = le32_to_cpu(buf1[1].end) -
+				     le32_to_cpu(buf1[1].start);
+
+	sharpsl_nand_parts[2].name = "home";
+	sharpsl_nand_parts[2].offset = le32_to_cpu(buf1[2].start);
+	sharpsl_nand_parts[2].size = le32_to_cpu(buf1[2].end) -
+				     le32_to_cpu(buf1[2].start);
+
+	*pparts = sharpsl_nand_parts;
+	return SHARPSL_NAND_PARTS;
+}
+
+static struct mtd_part_parser sharpsl_mtd_parser = {
+	.parse_fn = sharpsl_parse_mtd_partitions,
+	.name = "sharpslpart",
+};
+module_mtd_part_parser(sharpsl_mtd_parser);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Andrea Adami <andrea.adami@gmail.com>");
+MODULE_DESCRIPTION("MTD partitioning for NAND flash on Sharp SL Series");
-- 
2.7.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
