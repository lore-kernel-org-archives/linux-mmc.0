From: Philip Rakity <prakity@marvell.com>
Subject: Re: [RFC]: mmc bus width testing -  MMC_RSP_SPI_R1 question
Date: Thu, 25 Nov 2010 13:31:50 -0800
Message-ID: <349CD46B-A008-48D6-BD58-8EBFD6E57CD0@marvell.com>
References: <798674B4-E7B8-4437-A689-18536D1B6180@marvell.com>
 <35DC0B74-9C5E-4F0E-BA86-1B677060FCAB@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:35962 "HELO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752226Ab0KYVdf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 25 Nov 2010 16:33:35 -0500
In-Reply-To: <35DC0B74-9C5E-4F0E-BA86-1B677060FCAB@marvell.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc <linux-mmc@vger.kernel.org>
Cc: Mark Brown <markb@marvell.com>, Adrian Hunter <adrian.hunter@nokia.com>


see below -- thanks to Takashi Iwai for pointing this out.

On Nov 23, 2010, at 5:17 PM, Philip Rakity wrote:

>=20
>=20
> On Nov 23, 2010, at 7:56 AM, Philip Rakity wrote:
>=20
>>=20
>> A long time (2.6.2x days) I tried to submit a patch to do bus width =
testing on mmc and would appreciate some feedback before I do a formal =
submission.
>>=20
>> Bus width testing is defined in JEDEC Standard No. 84-A441: section =
A.8.3 Changing the data bus width
>>=20
>> The problem is that it does NOT work in all cases.  Some controllers=
 do not handle the CMD19/CMD14 exchange.
>> (BUSTEST_W/BUSTEST_R)
>>=20
>> When this failure happens it is not at all clear what to do....
>>=20
>> We could default to 1 bit mode and just do what we do today and take=
 4 bit bus width -- assuming CAPS are appropriately enabled.
>>=20
>> I was thinking of adding a new MMC_CAP saying controller supports bu=
s width testing.      Any thoughts ?
>>=20
>> <snippet of code from today implementation =3D=3D based on 2.6.32 bu=
t with DDR support back ported>
>>=20
>> look for mmc_test_bus_width()
>>=20
>=20

<snip>=20
>=20
>=20
> Diff made against linux-next (see below) and tested against marvell m=
mp2 controller using mmp2
> marvell linux
>=20
> eMMC cards do not have a card specific field indicating the bus width=
 that they support.
> The bus width needs to be figured out by probing the bus.
>=20
> JEDEC STANDARD
> Embedded MultiMediaCard(e=95MMC) e=95MMC/Card Product Standard, High =
Capacity,
> including Reliable Write, Boot, Sleep Modes, Dual Data Rate, Multiple=
 Partitions Supports,
> Security Enhancement, Background Operation and High Priority Interrup=
t (MMCA, 4.41)
> JESD84-A441
>=20
> defines what needs to be done in Annex A.8.3.
>=20
> In earlier testing (2.6.2x) this code did not work on some PCIe SD co=
ntrollers.
> We define a new MMC_CAP: MMC_CAP_BUS_WIDTH_WORKS that the host adapta=
tion
> layer can set if the controller can support bus width testing.  If th=
e CAP is not defined the
> behavior defaults to what is done today; the largest bit width is sel=
ected.
>=20
> Transcend 1GB and 2GB  MMC cards work when this code is enabled and f=
ail otherwise.
>=20
> Signed-off-by: Philip Rakity <prakity@marvell.com>
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 77f93c3..d20237b 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -531,12 +531,57 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
>=20
>        /*
>         * Activate wide bus and DDR (if supported).
> +        * Determine mmc bus width supported by probing card (if supp=
orted)
>         */
>        if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
>            (host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA))) =
{
>                unsigned ext_csd_bit, bus_width;
> +               int temp_caps =3D host->caps & (MMC_CAP_8_BIT_DATA | =
MMC_CAP_4_BIT_DATA);
>=20
> -               if (host->caps & MMC_CAP_8_BIT_DATA) {
> +               do {
> +                       if (temp_caps & MMC_CAP_8_BIT_DATA) {
> +                               ext_csd_bit =3D EXT_CSD_BUS_WIDTH_8;
> +                               bus_width =3D MMC_BUS_WIDTH_8;
> +                       } else {
> +                               ext_csd_bit =3D EXT_CSD_BUS_WIDTH_4;
> +                               bus_width =3D MMC_BUS_WIDTH_4;
> +                       }
> +
> +                       err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORM=
AL,
> +                                        EXT_CSD_BUS_WIDTH, ext_csd_b=
it);
> +                       if (err) {
> +                               printk(KERN_WARNING "%s: switch to bu=
s width %d ddr %d "
> +                                          "failed\n", mmc_hostname(c=
ard->host),
> +                                          1 << bus_width, ddr);
> +                               err =3D 0;
> +                       } else {
> +                               mmc_set_bus_width_ddr(card->host, bus=
_width, MMC_SDR_MODE);
> +                               /*
> +                                * if controller can't handle bus wid=
th test
> +                                * try to use the highest bus width t=
o
> +                                * maintain compatibility with previo=
us linux
> +                                */
> +                               if ((host->caps & MMC_CAP_BUS_WIDTH_W=
ORKS) =3D=3D 0)
> +                                       break;
> +                               if (mmc_test_bus_width (card, 1<<bus_=
width))
> +                                       break;
> +                       }
> +
> +                       if (bus_width =3D=3D MMC_BUS_WIDTH_8)
> +                               temp_caps &=3D ~MMC_CAP_8_BIT_DATA;
> +                       else
> +                               temp_caps &=3D ~MMC_CAP_4_BIT_DATA;
> +
> +                       if (temp_caps =3D=3D 0) {
> +                               ext_csd_bit =3D EXT_CSD_BUS_WIDTH_1;
> +                               bus_width =3D MMC_BUS_WIDTH_1;
> +                       }
> +               } while (temp_caps);
> +
> +               if (temp_caps =3D=3D 0) {
> +                       ext_csd_bit =3D EXT_CSD_BUS_WIDTH_1;
> +                       bus_width =3D MMC_BUS_WIDTH_1;
> +               } else if (temp_caps & MMC_CAP_8_BIT_DATA) {
>                        if (ddr)
>                                ext_csd_bit =3D EXT_CSD_DDR_BUS_WIDTH_=
8;
>                        else
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 326447c..5795e1b 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -20,6 +20,126 @@
> #include "core.h"
> #include "mmc_ops.h"
>=20
> +int mmc_test_bus_width(struct mmc_card *card, int bits)
> +{
> +       struct mmc_request mrq;
> +       struct mmc_command cmd;
> +       struct mmc_data data;
> +       struct scatterlist sg;
> +       int len;
> +       u8 test_data_write[8];
> +       u8 test_data_read[64];
> +
> +       switch (bits) {
> +       case 8:
> +               test_data_write[0] =3D 0x55;
> +               test_data_write[1] =3D 0xaa;
> +               test_data_write[2] =3D 0x00;
> +               test_data_write[3] =3D 0x00;
> +               test_data_write[4] =3D 0x00;
> +               test_data_write[5] =3D 0x00;
> +               test_data_write[6] =3D 0x00;
> +               test_data_write[7] =3D 0x00;
> +               len =3D 8;
> +               break;
> +       case 4:
> +               test_data_write[0] =3D 0x5a;
> +               test_data_write[1] =3D 0x00;
> +               test_data_write[2] =3D 0x00;
> +               test_data_write[3] =3D 0x00;
> +               len =3D 4;
> +               break;
> +       default:
> +               /* 1 bit bus cards ALWAYS work */
> +               return 1;
> +       }
> +
> +       memset(&mrq, 0, sizeof(struct mmc_request));
> +       memset(&cmd, 0, sizeof(struct mmc_command));
> +       memset(&data, 0, sizeof(struct mmc_data));
> +
> +       cmd.opcode =3D MMC_BUSTEST_W;
> +       cmd.arg =3D 0;

> +       cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;

should this be changed to add MMC_RSP_SPI_R1 ?

+	/* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but we
+	 * rely on callers to never use this with "native" calls for reading
+	 * CSD or CID.  Native versions of those commands use the R2 type,
+	 * not R1 plus a data block.
+	 */
+	cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+


> +
> +       data.flags =3D MMC_DATA_WRITE;
> +       data.blksz =3D len;
> +       data.blocks =3D 1;
> +       data.sg =3D &sg;
> +       data.sg_len =3D 1;
> +
> +       mrq.cmd =3D &cmd;
> +       mrq.data =3D &data;
> +
> +       sg_init_one(&sg, &test_data_write, len);
> +
> +       /*
> +        * The spec states that MMC_BUSTEST_W and BUSTEST_R accesses
> +        * have a maximum timeout of 64 clock cycles.
> +        */
> +       data.timeout_ns =3D 0;
> +       data.timeout_clks =3D 64;
> +
> +       mmc_wait_for_req(card->host, &mrq);
> +
> +       if (cmd.error || data.error ) {
> +               printk(KERN_INFO "%s: Failed to send (BUSTEST_W) CMD1=
9: %d %d\n",
> +                       mmc_hostname(card->host), cmd.error, data.err=
or);
> +       }
> +
> +       /* Now read back */
> +       memset(&mrq, 0, sizeof(struct mmc_request));
> +       memset(&cmd, 0, sizeof(struct mmc_command));
> +       memset(&data, 0, sizeof(struct mmc_data));
> +       memset (&test_data_read, 0, sizeof(test_data_read));
> +
> +       cmd.opcode =3D MMC_BUSTEST_R;
> +       cmd.arg =3D 0;

=20
> +       cmd.flags =3D MMC_RSP_R1 | MMC_CMD_ADTC;

should this be changed to add MMC_RSP_SPI_R1 ?

+	/* NOTE HACK:  the MMC_RSP_SPI_R1 is always correct here, but we
+	 * rely on callers to never use this with "native" calls for reading
+	 * CSD or CID.  Native versions of those commands use the R2 type,
+	 * not R1 plus a data block.
+	 */
+	cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADTC;
+



> +
> +       data.flags =3D MMC_DATA_READ;
> +       data.blksz =3D len;
> +       data.blocks =3D 1;
> +       data.sg =3D &sg;
> +       data.sg_len =3D 1;
> +
> +       mrq.cmd =3D &cmd;
> +       mrq.data =3D &data;
> +
> +       sg_init_one(&sg, &test_data_read, len);
> +
> +       data.timeout_ns =3D 0;
> +       data.timeout_clks =3D 64;
> +
> +       mmc_wait_for_req(card->host, &mrq);
> +
> +       if (cmd.error) {
> +               printk(KERN_INFO "%s: Failed to send CMD14: %d %d\n",
> +                       mmc_hostname(card->host), cmd.error, data.err=
or);
> +               return 0;
> +       }
> +
> +#if 0
> +#warning PRINT RESULTS FROM CMD14
> +       printk (KERN_INFO "%s: Bits =3D %d, Got %02X %02X %02X %02X\n=
", __FUNCTION__,
> +               bits,
> +               test_data_read[0],
> +               test_data_read[1],
> +               test_data_read[2],
> +               test_data_read[3]);
> +#endif
> +
> +       switch (bits) {
> +       case 8:
> +               return (test_data_read[0] =3D=3D 0xaa && test_data_re=
ad[1] =3D=3D 0x55);
> +       case 4:
> +               return (test_data_read[0] =3D=3D 0xa5);
> +       case 1:
> +               return (test_data_read[0] =3D=3D 0x80);
> +       }
> +       return 0;
> +}
> +
> static int _mmc_select_card(struct mmc_host *host, struct mmc_card *c=
ard)
> {
>        int err;
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 653eb8e..c08b9ad 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -26,6 +26,7 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid);
> int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
> int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
> int mmc_card_sleepawake(struct mmc_host *host, int sleep);
> +int mmc_test_bus_width(struct mmc_card *card, int bits);
>=20
> #endif
>=20
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 53496bb..1e3d9d2 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -169,6 +169,7 @@ struct mmc_host {
> #define MMC_CAP_1_2V_DDR       (1 << 12)       /* can support */
>                                                /* DDR mode at 1.2V */
>=20
> +#define MMC_CAP_BUS_WIDTH_WORKS        (1 << 13)       /* CMD14/CMD1=
9 bus width ok */
>        mmc_pm_flag_t           pm_caps;        /* supported pm featur=
es */
>=20
> #ifdef CONFIG_MMC_CLKGATE
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
> index 956fbd8..8e0d047 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -40,7 +40,9 @@
> #define MMC_READ_DAT_UNTIL_STOP  11   /* adtc [31:0] dadr        R1  =
*/
> #define MMC_STOP_TRANSMISSION    12   /* ac                      R1b =
*/
> #define MMC_SEND_STATUS          13   /* ac   [31:16] RCA        R1  =
*/
> +#define MMC_BUSTEST_R            14   /* adtc                    R1 =
 */
> #define MMC_GO_INACTIVE_STATE    15   /* ac   [31:16] RCA            =
*/
> +#define MMC_BUSTEST_W            19   /* adtc                    R1 =
 */
> #define MMC_SPI_READ_OCR         58   /* spi                  spi_R3 =
*/
> #define MMC_SPI_CRC_ON_OFF       59   /* spi  [0:0] flag      spi_R1 =
*/
>=20
>=20
>>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

