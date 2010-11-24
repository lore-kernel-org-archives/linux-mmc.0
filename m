From: Philip Rakity <prakity@marvell.com>
Subject: Re: [RFC]: mmc bus width testing
Date: Tue, 23 Nov 2010 17:17:40 -0800
Message-ID: <35DC0B74-9C5E-4F0E-BA86-1B677060FCAB@marvell.com>
References: <798674B4-E7B8-4437-A689-18536D1B6180@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:47080 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753543Ab0KXBVv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 23 Nov 2010 20:21:51 -0500
In-Reply-To: <798674B4-E7B8-4437-A689-18536D1B6180@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>



On Nov 23, 2010, at 7:56 AM, Philip Rakity wrote:

>
> A long time (2.6.2x days) I tried to submit a patch to do bus width t=
esting on mmc and would appreciate some feedback before I do a formal s=
ubmission.
>
> Bus width testing is defined in JEDEC Standard No. 84-A441: section A=
=2E8.3 Changing the data bus width
>
> The problem is that it does NOT work in all cases.  Some controllers =
do not handle the CMD19/CMD14 exchange.
> (BUSTEST_W/BUSTEST_R)
>
> When this failure happens it is not at all clear what to do....
>
> We could default to 1 bit mode and just do what we do today and take =
4 bit bus width -- assuming CAPS are appropriately enabled.
>
> I was thinking of adding a new MMC_CAP saying controller supports bus=
 width testing.      Any thoughts ?
>
> <snippet of code from today implementation =3D=3D based on 2.6.32 but=
 with DDR support back ported>
>
> look for mmc_test_bus_width()
>
> My thought was to replace
>
>                       if (err) {
>                               printk(KERN_WARNING "%s: switch to bus =
width %d ddr %d "
>                                          "failed\n", mmc_hostname(car=
d->host),
>                                          1 << bus_width, ddr);
>                               err =3D 0;
>                       } else {
>                               mmc_set_bus_width_ddr(card->host, bus_w=
idth, MMC_SDR_MODE);
>                               if (mmc_test_bus_width (card, 1<<bus_wi=
dth))
>                                       break;
>                       }
>
> with
>
>                       if (err) {
>                               printk(KERN_WARNING "%s: switch to bus =
width %d ddr %d "
>                                          "failed\n", mmc_hostname(car=
d->host),
>                                          1 << bus_width, ddr);
>                               err =3D 0;
>                       } else {
>                               mmc_set_bus_width_ddr(card->host, bus_w=
idth, MMC_SDR_MODE);
>                               if ((mmc->caps & MMC_CAPS_CONTROLLER_SU=
PPORTS_BUSTEST) =3D=3D 0)
>                                       break;
>                               if (mmc_test_bus_width (card, 1<<bus_wi=
dth))
>                                       break;
>                       }
>
> and let the platform code set MMC_CAPS_CONTROLLER_SUPPORTS_BUSTEST
>
>
>
> from mmc.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> static int mmc_init_card(struct mmc_host *host, u32 ocr,
>       struct mmc_card *oldcard)
> {
>       struct mmc_card *card;
>       int err, ddr =3D 0;
>       u32 cid[4];
>       unsigned int max_dtr;
>       u32 rocr;
>
>       BUG_ON(!host);
>       WARN_ON(!host->claimed);
>
>       /*
>        * Since we're changing the OCR value, we seem to
>        * need to tell some cards to go back to the idle
>        * state.  We wait 1ms to give cards time to
>        * respond.
>        */
>       mmc_go_idle(host);
>
>       /* The extra bit indicates that we support high capacity */
>       err =3D mmc_send_op_cond(host, ocr | MMC_CARD_SECTOR_ADDR, &roc=
r);
>       if (err)
>               goto err;
>
>       /*
>        * For SPI, enable CRC as appropriate.
>        */
>       if (mmc_host_is_spi(host)) {
>               err =3D mmc_spi_set_crc(host, use_spi_crc);
>               if (err)
>                       goto err;
>       }
>
>       /*
>        * Fetch CID from card.
>        */
>       if (mmc_host_is_spi(host))
>               err =3D mmc_send_cid(host, cid);
>       else
>               err =3D mmc_all_send_cid(host, cid);
>       if (err)
>               goto err;
>
>       if (oldcard) {
>               if (memcmp(cid, oldcard->raw_cid, sizeof(cid)) !=3D 0) =
{
>                       err =3D -ENOENT;
>                       goto err;
>               }
>
>               card =3D oldcard;
>       } else {
>               /*
>                * Allocate card structure.
>                */
>               card =3D mmc_alloc_card(host, &mmc_type);
>               if (IS_ERR(card)) {
>                       err =3D PTR_ERR(card);
>                       goto err;
>               }
>
>               card->type =3D MMC_TYPE_MMC;
>               card->rca =3D 1;
>               memcpy(card->raw_cid, cid, sizeof(card->raw_cid));
>       }
>
>       /*
>        * For native busses:  set card RCA and quit open drain mode.
>        */
>       if (!mmc_host_is_spi(host)) {
>               err =3D mmc_set_relative_addr(card);
>               if (err)
>                       goto free_card;
>
>               mmc_set_bus_mode(host, MMC_BUSMODE_PUSHPULL);
>       }
>
>       if (!oldcard) {
>               /*
>                * Fetch CSD from card.
>                */
>               err =3D mmc_send_csd(card, card->raw_csd);
>               if (err)
>                       goto free_card;
>
>               err =3D mmc_decode_csd(card);
>               if (err)
>                       goto free_card;
>               err =3D mmc_decode_cid(card);
>               if (err)
>                       goto free_card;
>       }
>
>       /*
>        * Select card, as all following commands rely on that.
>        */
>       if (!mmc_host_is_spi(host)) {
>               err =3D mmc_select_card(card);
>               if (err)
>                       goto free_card;
>       }
>
> #if 0
>       if (mmc_card_mmc(card)) {
>               /* work around of Micorn 16G emmc */
>               /* set bus_width to 1 bit as init state */
>               mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                               EXT_CSD_BUS_WIDTH, EXT_CSD_BUS_WIDTH_1)=
;
>
>       }
> #endif
>
>       if (!oldcard) {
>               /*
>                * Fetch and process extended CSD.
>                */
>               err =3D mmc_read_ext_csd(card);
>               if (err)
>                       goto free_card;
>
>               if (rocr & MMC_CARD_SECTOR_ADDR)
>                       mmc_card_set_blockaddr(card);
>       }
>
>
>       /* switch to user partition, emmc may stay in boot partition af=
ter boot */
>       mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                       EXT_CSD_PART_CONF, 0);
>
>       /*
>        * Activate high speed (if supported)
>        */
>       if ((card->ext_csd.hs_max_dtr !=3D 0) &&
>               (host->caps & MMC_CAP_MMC_HIGHSPEED)) {
>               err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                       EXT_CSD_HS_TIMING, 1);
>               if (err && err !=3D -EBADMSG)
>                       goto free_card;
>
>               if (err) {
>                       printk(KERN_WARNING "%s: switch to highspeed fa=
iled\n",
>                              mmc_hostname(card->host));
>                       err =3D 0;
>               } else {
>                       mmc_card_set_highspeed(card);
>                       mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
>               }
>       }
>
>       /*
>        * Compute bus speed.
>        */
>       max_dtr =3D (unsigned int)-1;
>
>       if (mmc_card_highspeed(card)) {
>               if (max_dtr > card->ext_csd.hs_max_dtr)
>                       max_dtr =3D card->ext_csd.hs_max_dtr;
>       } else if (max_dtr > card->csd.max_dtr) {
>               max_dtr =3D card->csd.max_dtr;
>       }
>
>       mmc_set_clock(host, max_dtr);
>
>       /*
>        * Indicate DDR mode (if supported).
>        */
>       if (mmc_card_highspeed(card)) {
>               if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_DDR_1_=
8V)
>                       && (host->caps & (MMC_CAP_1_8V_DDR)))
>                               ddr =3D MMC_1_8V_DDR_MODE;
>               else if ((card->ext_csd.card_type & EXT_CSD_CARD_TYPE_D=
DR_1_2V)
>                       && (host->caps & (MMC_CAP_1_2V_DDR)))
>                               ddr =3D MMC_1_2V_DDR_MODE;
>       }
>
>       /*
>        * Activate wide bus and DDR (if supported).
>        */
>       if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
>           (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
>               unsigned ext_csd_bit, bus_width;
>               int temp_caps =3D host->caps & (MMC_CAP_8_BIT_DATA | MM=
C_CAP_4_BIT_DATA);
>
>               do {
>                       if (temp_caps & MMC_CAP_8_BIT_DATA) {
>                               ext_csd_bit =3D EXT_CSD_BUS_WIDTH_8;
>                               bus_width =3D MMC_BUS_WIDTH_8;
>                       } else {
>                               ext_csd_bit =3D EXT_CSD_BUS_WIDTH_4;
>                               bus_width =3D MMC_BUS_WIDTH_4;
>                       }
>
>                       err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL=
,
>                                        EXT_CSD_BUS_WIDTH, ext_csd_bit=
);
>                       if (err) {
>                               printk(KERN_WARNING "%s: switch to bus =
width %d ddr %d "
>                                          "failed\n", mmc_hostname(car=
d->host),
>                                          1 << bus_width, ddr);
>                               err =3D 0;
>                       } else {
>                               mmc_set_bus_width_ddr(card->host, bus_w=
idth, MMC_SDR_MODE);
>                               if (mmc_test_bus_width (card, 1<<bus_wi=
dth))
>                                       break;
>                       }
>
>                       if (bus_width =3D=3D MMC_BUS_WIDTH_8)
>                               temp_caps &=3D ~MMC_CAP_8_BIT_DATA;
>                       else
>                               temp_caps &=3D ~MMC_CAP_4_BIT_DATA;
>
>                       if (temp_caps =3D=3D 0) {
>                               ext_csd_bit =3D EXT_CSD_BUS_WIDTH_1;
>                               bus_width =3D MMC_BUS_WIDTH_1;
>                       }
>               } while (temp_caps);
>
>               if (temp_caps =3D=3D 0) {
>                       ext_csd_bit =3D EXT_CSD_BUS_WIDTH_1;
>                       bus_width =3D MMC_BUS_WIDTH_1;
>               }
>               else if (temp_caps & MMC_CAP_8_BIT_DATA) {
>                       if (ddr)
>                               ext_csd_bit =3D EXT_CSD_DDR_BUS_WIDTH_8=
;
>                       else
>                               ext_csd_bit =3D EXT_CSD_BUS_WIDTH_8;
>                       bus_width =3D MMC_BUS_WIDTH_8;
>               } else {
>                       if (ddr)
>                               ext_csd_bit =3D EXT_CSD_DDR_BUS_WIDTH_4=
;
>                       else
>                               ext_csd_bit =3D EXT_CSD_BUS_WIDTH_4;
>                       bus_width =3D MMC_BUS_WIDTH_4;
>               }
>
>               err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>                                EXT_CSD_BUS_WIDTH, ext_csd_bit);
>
>               if (ddr) {
>                       mmc_card_set_ddr_mode(card);
>                       mmc_set_bus_width_ddr(card->host, bus_width, dd=
r);
>               } else
>                       mmc_set_bus_width_ddr(card->host, bus_width, MM=
C_SDR_MODE);
>
>               if (err && err !=3D -EBADMSG)
>                       goto free_card;
>       }
>
>       if (!oldcard)
>               host->card =3D card;
>
>       return 0;
>
> free_card:
>       if (!oldcard)
>               mmc_remove_card(card);
> err:
>
>       return err;
> }
>
>
> from mmc_ops.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> int mmc_test_bus_width(struct mmc_card *card, int bits)
> {
>       struct mmc_request mrq;
>       struct mmc_command cmd;
>       struct mmc_data data;
>       struct scatterlist sg;
>       int len;
>       u8 test_data_write[8];
>       u8 test_data_read[64];
>
>       switch (bits) {
>       case 8:
>               test_data_write[0] =3D 0x55;
>               test_data_write[1] =3D 0xaa;
>               test_data_write[2] =3D 0x00;
>               test_data_write[3] =3D 0x00;
>               test_data_write[4] =3D 0x00;
>               test_data_write[5] =3D 0x00;
>               test_data_write[6] =3D 0x00;
>               test_data_write[7] =3D 0x00;
>               len =3D 8;
>               break;
>       case 4:
>               test_data_write[0] =3D 0x5a;
>               test_data_write[1] =3D 0x00;
>               test_data_write[2] =3D 0x00;
>               test_data_write[3] =3D 0x00;
>               len =3D 4;
>               break;
>       default:
>               return 0;
>       }
>
>       memset(&mrq, 0, sizeof(struct mmc_request));
>       memset(&cmd, 0, sizeof(struct mmc_command));
>       memset(&data, 0, sizeof(struct mmc_data));
>
>       cmd.opcode =3D MMC_BUSTEST_W;
>       cmd.arg =3D 0;
>       cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
>
>       data.flags =3D MMC_DATA_WRITE;
>       data.blksz =3D 64;
>       data.blocks =3D 1;
>       data.sg =3D &sg;
>       data.sg_len =3D 1;
>
>       mrq.cmd =3D &cmd;
>       mrq.data =3D &data;
>
>       sg_init_one(&sg, &test_data_write, 64);
>
>       /*
>        * The spec states that MMC_BUSTEST_W and BUSTEST_R accesses ha=
ve a timeout
>        * of 64 clock cycles.
>        */
>       data.timeout_ns =3D 0;
>       data.timeout_clks =3D 64;
>
>       mmc_wait_for_req(card->host, &mrq);
>
>       if (cmd.error || data.error ) {
>               printk(KERN_INFO "Failed to send CMD19: %d %d\n", cmd.e=
rror, data.error);
>               return 0;
>       }
>
>       /* Now read back */
>       memset(&mrq, 0, sizeof(struct mmc_request));
>       memset(&cmd, 0, sizeof(struct mmc_command));
>       memset(&data, 0, sizeof(struct mmc_data));
>       memset (&test_data_read, 0, sizeof(test_data_read));
>
>       cmd.opcode =3D MMC_BUSTEST_R;
>       cmd.arg =3D 0;
>       cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
>
>       data.flags =3D MMC_DATA_READ;
>       data.blksz =3D sizeof(test_data_read);
>       data.blocks =3D 1;
>       data.sg =3D &sg;
>       data.sg_len =3D 1;
>
>       mrq.cmd =3D &cmd;
>       mrq.data =3D &data;
>
>       sg_init_one(&sg, &test_data_read, sizeof(test_data_read));
>
>       /*
>        * The spec states that MMC_BUSTEST_W and BUSTEST_R accesses ha=
ve a timeout
>        * of 64 clock cycles.
>        */
>       data.timeout_ns =3D 0;
>       data.timeout_clks =3D 64;
>
>       mmc_wait_for_req(card->host, &mrq);
>
>       if (cmd.error) {
>               printk(KERN_INFO "Failed to send CMD14: %d %d\n", cmd.e=
rror, data.error);
>               return 0;
>       }
>
> #if 0
> #warning PRINT RESULTS FROM CMD14
>       printk (KERN_INFO "%s: Got %02X %02X %02X %02X\n", __FUNCTION__=
,
>               test_data_read[0],
>               test_data_read[1],
>               test_data_read[2],
>               test_data_read[3]);
> #endif
>
>       switch (bits) {
>       case 8:
>               return (test_data_read[0] =3D=3D 0xaa && test_data_read=
[1] =3D=3D 0x55);
>       case 4:
>               return (test_data_read[0] =3D=3D 0xa5);
>       }
>       return 0;
> }



Diff made against linux-next (see below) and tested against marvell mmp=
2 controller using mmp2
marvell linux

eMMC cards do not have a card specific field indicating the bus width t=
hat they support.
The bus width needs to be figured out by probing the bus.

JEDEC STANDARD
Embedded MultiMediaCard(e=95MMC) e=95MMC/Card Product Standard, High Ca=
pacity,
including Reliable Write, Boot, Sleep Modes, Dual Data Rate, Multiple P=
artitions Supports,
Security Enhancement, Background Operation and High Priority Interrupt =
(MMCA, 4.41)
JESD84-A441

defines what needs to be done in Annex A.8.3.

In earlier testing (2.6.2x) this code did not work on some PCIe SD cont=
rollers.
We define a new MMC_CAP: MMC_CAP_BUS_WIDTH_WORKS that the host adaptati=
on
layer can set if the controller can support bus width testing.  If the =
CAP is not defined the
behavior defaults to what is done today; the largest bit width is selec=
ted.

Transcend 1GB and 2GB  MMC cards work when this code is enabled and fai=
l otherwise.

Signed-off-by: Philip Rakity <prakity@marvell.com>

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 77f93c3..d20237b 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -531,12 +531,57 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,

        /*
         * Activate wide bus and DDR (if supported).
+        * Determine mmc bus width supported by probing card (if suppor=
ted)
         */
        if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
            (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) {
                unsigned ext_csd_bit, bus_width;
+               int temp_caps =3D host->caps & (MMC_CAP_8_BIT_DATA | MM=
C_CAP_4_BIT_DATA);

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
width %d ddr %d "
+                                          "failed\n", mmc_hostname(car=
d->host),
+                                          1 << bus_width, ddr);
+                               err =3D 0;
+                       } else {
+                               mmc_set_bus_width_ddr(card->host, bus_w=
idth, MMC_SDR_MODE);
+                               /*
+                                * if controller can't handle bus width=
 test
+                                * try to use the highest bus width to
+                                * maintain compatibility with previous=
 linux
+                                */
+                               if ((host->caps & MMC_CAP_BUS_WIDTH_WOR=
KS) =3D=3D 0)
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
+                       if (temp_caps =3D=3D 0) {
+                               ext_csd_bit =3D EXT_CSD_BUS_WIDTH_1;
+                               bus_width =3D MMC_BUS_WIDTH_1;
+                       }
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
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 326447c..5795e1b 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -20,6 +20,126 @@
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
+       cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
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
+       cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;
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
+#if 0
+#warning PRINT RESULTS FROM CMD14
+       printk (KERN_INFO "%s: Bits =3D %d, Got %02X %02X %02X %02X\n",=
 __FUNCTION__,
+               bits,
+               test_data_read[0],
+               test_data_read[1],
+               test_data_read[2],
+               test_data_read[3]);
+#endif
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
index 53496bb..1e3d9d2 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -169,6 +169,7 @@ struct mmc_host {
 #define MMC_CAP_1_2V_DDR       (1 << 12)       /* can support */
                                                /* DDR mode at 1.2V */

+#define MMC_CAP_BUS_WIDTH_WORKS        (1 << 13)       /* CMD14/CMD19 =
bus width ok */
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


>

