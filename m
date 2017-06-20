From: Andrea Adami <andrea.adami@gmail.com>
Subject: Re: [PATCH v3 1/9] mtd: sharpslpart: add sharpslpart MTD partition parser
Date: Tue, 20 Jun 2017 10:56:32 +0200
Message-ID: <CAAQYJAuiMd5mViL76x6qwUw_VxSvMmUXbwMTvwmnO+rnifgSzw@mail.gmail.com>
References: <1496270458-6479-1-git-send-email-andrea.adami@gmail.com>
 <1496270458-6479-2-git-send-email-andrea.adami@gmail.com> <20170609014240.GM102137@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170609014240.GM102137@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <computersforpeace@gmail.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Wolfram Sang <wsa+renesas@sang-engineering.com>, Lee Jones <lee.jones@linaro.org>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, Jun 9, 2017 at 3:42 AM, Brian Norris
<computersforpeace@gmail.com> wrote:
> Oh, one more thing:
>
> On Thu, Jun 01, 2017 at 12:40:50AM +0200, Andrea Adami wrote:
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
>
> [...]
>
>> +struct sharpsl_nand_partitioninfo {
>> +     u32 start;
>> +     u32 end;
>
> I was going to ignore this earlier, but I just noticed that you handle
> endianness for the magic values above, so...
>
> shouldn't you handle endianness for the start and end fields too?
>
>> +     u32 magic;
>> +     u32 reserved;
>> +};
> [...]
>
> Brian

Brian,
I have added a macro so to avoid to repeat le32_to_cpu() for each value.
This seems even to work as intended...

Note that the magics are 'texts' so they appear as BE.
Some more tests and I'll send v4 of the patch to your attention.

Thanks in advance.


Andrea
