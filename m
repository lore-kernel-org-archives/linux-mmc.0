From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH]  mmc: Resubmit: Bus Width testing for eMMC and MMC
	 Cards
Date: Sat, 27 Nov 2010 15:37:31 -0800
Message-ID: <7A0E973B-2B53-4AD4-BCEB-B2A455239110@marvell.com>
References: <A8541278-E69B-43AC-A820-B8D11F718FC1@marvell.com>
 <20101127193229.GA3019@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:39704 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751093Ab0K0Xhk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 27 Nov 2010 18:37:40 -0500
In-Reply-To: <20101127193229.GA3019@void.printf.net>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>


Chris,

Thanks for the review.  Revised complete patch below incorporating  you=
r comments.

Philip

On Nov 27, 2010, at 11:32 AM, Chris Ball wrote:

> Hi Philip,
>
> Some early stylistic review comments:
>
> On Sat, Nov 27, 2010 at 11:00:19AM -0800, Philip Rakity wrote:
>> Patch made against linux-next (see below) and tested against marvell=
 mmp2
>> controller using Marvell linux
>
> The patch doesn't apply against current linux-next or Linus HEAD, due=
 to
> Ohad's recent runtime PM change to host.h.
>
>> We define a new MMC_CAP: MMC_CAP_BUS_WIDTH_WORKS that the host adapt=
ation
>> layer can set if the controller can support bus width testing.
>
> "BUS_WIDTH_WORKS" is a bit vague.  Maybe MMC_CAP_BUS_WIDTH_TEST?
>
>>      if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
>>          (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
>>              unsigned ext_csd_bit, bus_width;
>> +            int temp_caps =3D host->caps & (MMC_CAP_8_BIT_DATA | MM=
C_CAP_4_BIT_DATA);
>>
>> -            if (host->caps & MMC_CAP_8_BIT_DATA) {
>> +            do {
>> +                    if (temp_caps & MMC_CAP_8_BIT_DATA) {
>> +                            ext_csd_bit =3D EXT_CSD_BUS_WIDTH_8;
>> +                            bus_width =3D MMC_BUS_WIDTH_8;
>> +                    } else {
>> +                            ext_csd_bit =3D EXT_CSD_BUS_WIDTH_4;
>> +                            bus_width =3D MMC_BUS_WIDTH_4;
>> +                    }
>> +
>> +                    err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL=
,
>> +                                     EXT_CSD_BUS_WIDTH, ext_csd_bit=
);
>> +                    if (err) {
>> +                            printk(KERN_WARNING "%s: switch to bus =
width %d ddr %d "
>
> Please stick to 80 cols where possible.
>
>> +                                       "failed\n", mmc_hostname(car=
d->host),
>> +                                       1 << bus_width, ddr);
>> +                            err =3D 0;
>> +                    } else {
>> +                            mmc_set_bus_width_ddr(card->host, bus_w=
idth, MMC_SDR_MODE);
>> +                            /*
>> +                             * if controller can't handle bus width=
 test
>> +                             * try to use the highest bus width to
>> +                             * maintain compatibility with previous=
 linux
>> +                             */
>> +                            if ((host->caps & MMC_CAP_BUS_WIDTH_WOR=
KS) =3D=3D 0)
>> +                                    break;
>> +                            if (mmc_test_bus_width (card, 1<<bus_wi=
dth))
>
> Extra space here.
>
>> +                                    break;
>> +                    }
>> +
>> +                    if (bus_width =3D=3D MMC_BUS_WIDTH_8)
>> +                            temp_caps &=3D ~MMC_CAP_8_BIT_DATA;
>> +                    else
>> +                            temp_caps &=3D ~MMC_CAP_4_BIT_DATA;
>> +
>> +                    if (temp_caps =3D=3D 0) {
>> +                            ext_csd_bit =3D EXT_CSD_BUS_WIDTH_1;
>> +                            bus_width =3D MMC_BUS_WIDTH_1;
>> +                    }
>> +            } while (temp_caps);
>> +
>> +            if (temp_caps =3D=3D 0) {
>> +                    ext_csd_bit =3D EXT_CSD_BUS_WIDTH_1;
>> +                    bus_width =3D MMC_BUS_WIDTH_1;
>> +            } else if (temp_caps & MMC_CAP_8_BIT_DATA) {
>>                      if (ddr)
>>                              ext_csd_bit =3D EXT_CSD_DDR_BUS_WIDTH_8=
;
>>                      else
>
> Why is the "temp_caps =3D=3D 0" test inside the while loop necessary,=
 rather
> than just relying on the same test outside of the loop?
>
>> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
>> index 326447c..2b115a3 100644
>> --- a/drivers/mmc/core/mmc_ops.c
>> +++ b/drivers/mmc/core/mmc_ops.c
>> @@ -20,6 +20,138 @@
>> #include "core.h"
>> #include "mmc_ops.h"
>>
>> +int mmc_test_bus_width(struct mmc_card *card, int bits)
>> +{
>> +    struct mmc_request mrq;
>> +    struct mmc_command cmd;
>> +    struct mmc_data data;
>> +    struct scatterlist sg;
>> +    int len;
>> +    u8 test_data_write[8];
>> +    u8 test_data_read[64];
>> +
>> +    switch (bits) {
>> +    case 8:
>> +            test_data_write[0] =3D 0x55;
>> +            test_data_write[1] =3D 0xaa;
>> +            test_data_write[2] =3D 0x00;
>> +            test_data_write[3] =3D 0x00;
>> +            test_data_write[4] =3D 0x00;
>> +            test_data_write[5] =3D 0x00;
>> +            test_data_write[6] =3D 0x00;
>> +            test_data_write[7] =3D 0x00;
>> +            len =3D 8;
>> +            break;
>> +    case 4:
>> +            test_data_write[0] =3D 0x5a;
>> +            test_data_write[1] =3D 0x00;
>> +            test_data_write[2] =3D 0x00;
>> +            test_data_write[3] =3D 0x00;
>> +            len =3D 4;
>> +            break;
>> +    default:
>> +            /* 1 bit bus cards ALWAYS work */
>> +            return 1;
>> +    }
>> +
>> +    memset(&mrq, 0, sizeof(struct mmc_request));
>> +    memset(&cmd, 0, sizeof(struct mmc_command));
>> +    memset(&data, 0, sizeof(struct mmc_data));
>> +
>> +    cmd.opcode =3D MMC_BUSTEST_W;
>> +    cmd.arg =3D 0;
>> +
>> +    /* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but w=
e
>> +     * rely on callers to never use this with "native" calls for re=
ading
>> +     * CSD or CID.  Native versions of those commands use the R2 ty=
pe,
>> +     * not R1 plus a data block.
>> +     */
>> +    cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>> +
>> +    data.flags =3D MMC_DATA_WRITE;
>> +    data.blksz =3D len;
>> +    data.blocks =3D 1;
>> +    data.sg =3D &sg;
>> +    data.sg_len =3D 1;
>> +
>> +    mrq.cmd =3D &cmd;
>> +    mrq.data =3D &data;
>> +
>> +    sg_init_one(&sg, &test_data_write, len);
>> +
>> +    /*
>> +     * The spec states that MMC_BUSTEST_W and BUSTEST_R accesses
>> +     * have a maximum timeout of 64 clock cycles.
>> +     */
>> +    data.timeout_ns =3D 0;
>> +    data.timeout_clks =3D 64;
>> +
>> +    mmc_wait_for_req(card->host, &mrq);
>> +
>> +    if (cmd.error || data.error ) {
>
> Extra space here.
>
>> +            printk(KERN_INFO "%s: Failed to send (BUSTEST_W) CMD19:=
 %d %d\n",
>> +                    mmc_hostname(card->host), cmd.error, data.error=
);
>> +    }
>> +
>> +    /* Now read back */
>> +    memset(&mrq, 0, sizeof(struct mmc_request));
>> +    memset(&cmd, 0, sizeof(struct mmc_command));
>> +    memset(&data, 0, sizeof(struct mmc_data));
>> +    memset (&test_data_read, 0, sizeof(test_data_read));
>> +
>> +    cmd.opcode =3D MMC_BUSTEST_R;
>> +    cmd.arg =3D 0;
>> +
>> +    /* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but w=
e
>> +     * rely on callers to never use this with "native" calls for re=
ading
>> +     * CSD or CID.  Native versions of those commands use the R2 ty=
pe,
>> +     * not R1 plus a data block.
>> +     */
>> +    cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
>> +
>> +    data.flags =3D MMC_DATA_READ;
>> +    data.blksz =3D len;
>> +    data.blocks =3D 1;
>> +    data.sg =3D &sg;
>> +    data.sg_len =3D 1;
>> +
>> +    mrq.cmd =3D &cmd;
>> +    mrq.data =3D &data;
>> +
>> +    sg_init_one(&sg, &test_data_read, len);
>> +
>> +    data.timeout_ns =3D 0;
>> +    data.timeout_clks =3D 64;
>> +
>> +    mmc_wait_for_req(card->host, &mrq);
>> +
>> +    if (cmd.error) {
>> +            printk(KERN_INFO "%s: Failed to send CMD14: %d %d\n",
>> +                    mmc_hostname(card->host), cmd.error, data.error=
);
>> +            return 0;
>> +    }
>> +
>> +#if 0
>> +#warning PRINT RESULTS FROM CMD14
>> +    printk (KERN_INFO "%s: Bits =3D %d, Got %02X %02X %02X %02X\n",=
 __FUNCTION__,
>
> Extra space, and please don't submit #if 0'd code.  You can use a deb=
ug
> level printk if you want to condition it on CONFIG_MMC_DEBUG.  Also,
> __func__ instead of __FUNCTION__.
>
> Thanks!
>
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

=3D=3D=3D=3D=3D=3D REVISED PATCH BELOW =3D=3D=3D=3D=3D=3D=3D

=46rom feabf089d8b1eff6e809ffe1a174ed1365cd6464 Mon Sep 17 00:00:00 200=
1
=46rom: Philip Rakity <prakity@marvell.com>
Date: Sat, 27 Nov 2010 15:26:40 -0800
Subject: [PATCH] mmc: Add Bus Width testing for mmc/eMMC Cards
MIME-Version: 1.0
Content-Type: text/plain; charset=3Dutf-8
Content-Transfer-Encoding: 8bit

Change from previous patch:

MMC_CAP_BUS_WIDTH_WORKS renamed MMC_CAP_BUS_WIDTH_TEST
        value changed from 1<<13 to 1<<14 to not conflict with earlier =
patch
if 0 / endif removed in mmc_ops.c -- pr_debug used instead
        __FUNCTION__ no longer used in print changed  to __func__
extra spaces removed
column size adjusted to fit 80 columns

Change from previous patch;
Added MMC_RSP_SPI_R1 to mmc_ops command for DATA_READ and DATA_Write
(Thanks to Takashi Lwai for pointing this out)

eMMC cards do not have a card specific field indicating the bus width t=
hat
they support.
The bus width needs to be figured out by probing the bus.

JEDEC STANDARD
Embedded MultiMediaCard(e=95MMC) e=95MMC/Card Product Standard, High Ca=
pacity,
including Reliable Write, Boot, Sleep Modes, Dual Data Rate,
Multiple Partitions Supports, Security Enhancement, Background Operatio=
n and
High Priority Interrupt (MMCA, 4.41)
JESD84-A441

defines what needs to be done in Annex A.8.3.

In earlier testing (2.6.2x) this code did not work on some PCIe SD cont=
rollers.
We define a new MMC_CAP: MMC_CAP_BUS_WIDTH_WORKS that the host adaptati=
on
layer can set if the controller can support bus width testing.
If the CAP is not defined the behavior defaults to what is done today;
the largest bit width is selected.

Transcend 1GB and 2GB  MMC cards work when this code is enabled and fai=
l otherwise.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/mmc.c     |   50 ++++++++++++++++-
 drivers/mmc/core/mmc_ops.c |  130 ++++++++++++++++++++++++++++++++++++=
++++++++
 drivers/mmc/core/mmc_ops.h |    1 +
 include/linux/mmc/host.h   |    1 +
 include/linux/mmc/mmc.h    |    2 +
 5 files changed, 181 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 77f93c3..0eccd96 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -531,12 +531,56 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,

        /*
         * Activate wide bus and DDR (if supported).
+        * Determine mmc bus width supported by probing card (if suppor=
ted)
         */
        if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
            (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
                unsigned ext_csd_bit, bus_width;
+               int temp_caps =3D host->caps &
+                       (MMC_CAP_8_BIT_DATA | MMC_CAP_4_BIT_DATA);

-               if (host->caps & MMC_CAP_8_BIT_DATA) {
+               do {
+                       if (temp_caps & MMC_CAP_8_BIT_DATA) {
+                               ext_csd_bit =3D EXT_CSD_BUS_WIDTH_8;
+                               bus_width =3D MMC_BUS_WIDTH_8;
+                       } else {
+                               ext_csd_bit =3D EXT_CSD_BUS_WIDTH_4;
+                               bus_width =3D MMC_BUS_WIDTH_4;
+                       }
+
+                       err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL=
,
+                                        EXT_CSD_BUS_WIDTH, ext_csd_bit=
);
+                       if (err) {
+                               printk(KERN_WARNING "%s: switch to bus =
width %d"
+                                       " ddr %d failed\n",
+                                       mmc_hostname(card->host),
+                                       1 << bus_width, ddr);
+                               err =3D 0;
+                       } else {
+                               mmc_set_bus_width_ddr(card->host, bus_w=
idth,
+                                       MMC_SDR_MODE);
+                               /*
+                                * if controller can't handle bus width=
 test
+                                * try to use the highest bus width to
+                                * maintain compatibility with previous=
 linux
+                                */
+                               if ((host->caps & MMC_CAP_BUS_WIDTH_TES=
T) =3D=3D 0)
+                                       break;
+                               if (mmc_test_bus_width (card, 1<<bus_wi=
dth))
+                                       break;
+                       }
+
+                       if (bus_width =3D=3D MMC_BUS_WIDTH_8)
+                               temp_caps &=3D ~MMC_CAP_8_BIT_DATA;
+                       else
+                               temp_caps &=3D ~MMC_CAP_4_BIT_DATA;
+
+               } while (temp_caps);
+
+               if (temp_caps =3D=3D 0) {
+                       ext_csd_bit =3D EXT_CSD_BUS_WIDTH_1;
+                       bus_width =3D MMC_BUS_WIDTH_1;
+               } else if (temp_caps & MMC_CAP_8_BIT_DATA) {
                        if (ddr)
                                ext_csd_bit =3D EXT_CSD_DDR_BUS_WIDTH_8=
;
                        else
@@ -557,8 +601,8 @@ static int mmc_init_card(struct mmc_host *host, u32=
 ocr,
                        goto free_card;

                if (err) {
-                       printk(KERN_WARNING "%s: switch to bus width %d=
 ddr %d "
-                              "failed\n", mmc_hostname(card->host),
+                       printk(KERN_WARNING "%s: switch to bus width %d=
 "
+                              "ddr %d failed\n", mmc_hostname(card->ho=
st),
                               1 << bus_width, ddr);
                        err =3D 0;
                } else {
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 326447c..4ea4a82 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -20,6 +20,136 @@
 #include "core.h"
 #include "mmc_ops.h"

+int mmc_test_bus_width(struct mmc_card *card, int bits)
+{
+       struct mmc_request mrq;
+       struct mmc_command cmd;
+       struct mmc_data data;
+       struct scatterlist sg;
+       int len;
+       u8 test_data_write[8];
+       u8 test_data_read[64];
+
+       switch (bits) {
+       case 8:
+               test_data_write[0] =3D 0x55;
+               test_data_write[1] =3D 0xaa;
+               test_data_write[2] =3D 0x00;
+               test_data_write[3] =3D 0x00;
+               test_data_write[4] =3D 0x00;
+               test_data_write[5] =3D 0x00;
+               test_data_write[6] =3D 0x00;
+               test_data_write[7] =3D 0x00;
+               len =3D 8;
+               break;
+       case 4:
+               test_data_write[0] =3D 0x5a;
+               test_data_write[1] =3D 0x00;
+               test_data_write[2] =3D 0x00;
+               test_data_write[3] =3D 0x00;
+               len =3D 4;
+               break;
+       default:
+               /* 1 bit bus cards ALWAYS work */
+               return 1;
+       }
+
+       memset(&mrq, 0, sizeof(struct mmc_request));
+       memset(&cmd, 0, sizeof(struct mmc_command));
+       memset(&data, 0, sizeof(struct mmc_data));
+
+       cmd.opcode =3D MMC_BUSTEST_W;
+       cmd.arg =3D 0;
+
+       /* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but w=
e
+        * rely on callers to never use this with "native" calls for re=
ading
+        * CSD or CID.  Native versions of those commands use the R2 ty=
pe,
+        * not R1 plus a data block.
+        */
+       cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+
+       data.flags =3D MMC_DATA_WRITE;
+       data.blksz =3D len;
+       data.blocks =3D 1;
+       data.sg =3D &sg;
+       data.sg_len =3D 1;
+
+       mrq.cmd =3D &cmd;
+       mrq.data =3D &data;
+
+       sg_init_one(&sg, &test_data_write, len);
+
+       /*
+        * The spec states that MMC_BUSTEST_W and BUSTEST_R accesses
+        * have a maximum timeout of 64 clock cycles.
+        */
+       data.timeout_ns =3D 0;
+       data.timeout_clks =3D 64;
+
+       mmc_wait_for_req(card->host, &mrq);
+
+       if (cmd.error || data.error ) {
+               printk(KERN_INFO "%s: Failed to send (BUSTEST_W) CMD19:=
 %d %d\n",
+                       mmc_hostname(card->host), cmd.error, data.error=
);
+       }
+
+       /* Now read back */
+       memset(&mrq, 0, sizeof(struct mmc_request));
+       memset(&cmd, 0, sizeof(struct mmc_command));
+       memset(&data, 0, sizeof(struct mmc_data));
+       memset (&test_data_read, 0, sizeof(test_data_read));
+
+       cmd.opcode =3D MMC_BUSTEST_R;
+       cmd.arg =3D 0;
+
+       /* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but w=
e
+        * rely on callers to never use this with "native" calls for re=
ading
+        * CSD or CID.  Native versions of those commands use the R2 ty=
pe,
+        * not R1 plus a data block.
+        */
+       cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+
+       data.flags =3D MMC_DATA_READ;
+       data.blksz =3D len;
+       data.blocks =3D 1;
+       data.sg =3D &sg;
+       data.sg_len =3D 1;
+
+       mrq.cmd =3D &cmd;
+       mrq.data =3D &data;
+
+       sg_init_one(&sg, &test_data_read, len);
+
+       data.timeout_ns =3D 0;
+       data.timeout_clks =3D 64;
+
+       mmc_wait_for_req(card->host, &mrq);
+
+       if (cmd.error) {
+               printk(KERN_INFO "%s: Failed to send CMD14: %d %d\n",
+                       mmc_hostname(card->host), cmd.error, data.error=
);
+               return 0;
+       }
+
+       pr_debug ("%s: Bits =3D %d, Got %02X %02X %02X %02X\n",
+                __func__,
+               bits,
+               test_data_read[0],
+               test_data_read[1],
+               test_data_read[2],
+               test_data_read[3]);
+
+       switch (bits) {
+       case 8:
+               return (test_data_read[0] =3D=3D 0xaa && test_data_read=
[1] =3D=3D 0x55);
+       case 4:
+               return (test_data_read[0] =3D=3D 0xa5);
+       case 1:
+               return (test_data_read[0] =3D=3D 0x80);
+       }
+       return 0;
+}
+
 static int _mmc_select_card(struct mmc_host *host, struct mmc_card *ca=
rd)
 {
        int err;
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 653eb8e..c08b9ad 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -26,6 +26,7 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
 int mmc_card_sleepawake(struct mmc_host *host, int sleep);
+int mmc_test_bus_width(struct mmc_card *card, int bits);

 #endif

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 381c77f..078cff7 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -170,6 +170,7 @@ struct mmc_host {
                                                /* DDR mode at 1.2V */
 #define MMC_CAP_POWER_OFF_CARD (1 << 13)       /* Can power off after =
boot */

+#define MMC_CAP_BUS_WIDTH_TEST (1 << 14)       /* CMD14/CMD19 bus widt=
h ok */
        mmc_pm_flag_t           pm_caps;        /* supported pm feature=
s */

 #ifdef CONFIG_MMC_CLKGATE
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 956fbd8..8e0d047 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -40,7 +40,9 @@
 #define MMC_READ_DAT_UNTIL_STOP  11   /* adtc [31:0] dadr        R1  *=
/
 #define MMC_STOP_TRANSMISSION    12   /* ac                      R1b *=
/
 #define MMC_SEND_STATUS          13   /* ac   [31:16] RCA        R1  *=
/
+#define MMC_BUSTEST_R            14   /* adtc                    R1  *=
/
 #define MMC_GO_INACTIVE_STATE    15   /* ac   [31:16] RCA            *=
/
+#define MMC_BUSTEST_W            19   /* adtc                    R1  *=
/
 #define MMC_SPI_READ_OCR         58   /* spi                  spi_R3 *=
/
 #define MMC_SPI_CRC_ON_OFF       59   /* spi  [0:0] flag      spi_R1 *=
/

--
1.6.0.4


