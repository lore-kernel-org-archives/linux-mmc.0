From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH 2/2] mmc: Test bus-width for old MMC devices
Date: Tue, 14 Dec 2010 23:03:42 -0500
Message-ID: <AANLkTinTNp_tyFJV2ef3iU4i6X=ebNsNzrAqvXJepaFi@mail.gmail.com>
References: <1290579674-4616-1-git-send-email-tiwai@suse.de>
	<1290579674-4616-3-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-fx0-f43.google.com ([209.85.161.43]:56644 "EHLO
	mail-fx0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759204Ab0LOEDp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Dec 2010 23:03:45 -0500
In-Reply-To: <1290579674-4616-3-git-send-email-tiwai@suse.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Aries Lee <arieslee@jmicron.com>, wuqm@marvell.com

On Wed, Nov 24, 2010 at 1:21 AM, Takashi Iwai <tiwai@suse.de> wrote:
> From: Aries Lee <arieslee@jmicron.com>
>
> Some old MMC devices fail with the 4/8 bits the driver tries to use
> exclusively. =A0This patch adds a test for the given bus setup and fa=
lls
> back to the lower bit mode (until 1-bit mode) when the test fails.
>
> [Major rework and refactoring by tiwai]
>
> Signed-off-by: Aries Lee <arieslee@jmicron.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> =A0drivers/mmc/core/mmc.c =A0 =A0 | =A0 49 ++++++++++++---------
> =A0drivers/mmc/core/mmc_ops.c | =A0102 ++++++++++++++++++++++++++++++=
++++++++++++++
> =A0drivers/mmc/core/mmc_ops.h | =A0 =A01 +
> =A03 files changed, 131 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e81e6fe..5d8b4b2 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -507,29 +507,36 @@ static int mmc_init_card(struct mmc_host *host,=
 u32 ocr,
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if ((card->csd.mmca_vsn >=3D CSD_SPEC_VER_4) &&
> =A0 =A0 =A0 =A0 =A0 =A0(host->caps & (MMC_CAP_4_BIT_DATA | MMC_CAP_8_=
BIT_DATA))) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned ext_csd_bit, bus_width;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->caps & MMC_CAP_8_BIT_DATA) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd_bit =3D EXT_CSD=
_BUS_WIDTH_8;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_width =3D MMC_BUS_W=
IDTH_8;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd_bit =3D EXT_CSD=
_BUS_WIDTH_4;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus_width =3D MMC_BUS_W=
IDTH_4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static unsigned ext_csd_bits[] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BUS_WIDTH_8,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BUS_WIDTH_4,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD_BUS_WIDTH_1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static unsigned bus_widths[] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_BUS_WIDTH_8,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_BUS_WIDTH_4,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MMC_BUS_WIDTH_1
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 };
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned idx;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->caps & MMC_CAP_8_BIT_DATA)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (; idx < ARRAY_SIZE(bus_widths); id=
x++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card=
, EXT_CSD_CMD_SET_NORMAL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0EXT_CSD_BUS_WIDTH, ext_csd_bits[idx]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set=
_bus_width(card->host, bus_widths[idx]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D=
 mmc_bus_test(card, bus_widths[idx]);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!er=
r)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D mmc_switch(card, EXT_CSD_CMD_SE=
T_NORMAL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EXT_=
CSD_BUS_WIDTH, ext_csd_bit);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err && err !=3D -EBADMSG)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s=
: switch to bus width %d "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"failed\=
n", mmc_hostname(card->host),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01 << bus=
_width);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_set_bus_width(card-=
>host, bus_width);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s=
: switch to bus width failed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_host=
name(card->host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_card;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
> index 326447c..f8f47f9 100644
> --- a/drivers/mmc/core/mmc_ops.c
> +++ b/drivers/mmc/core/mmc_ops.c
> @@ -462,3 +462,105 @@ int mmc_send_status(struct mmc_card *card, u32 =
*status)
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> +#define MMC_CMD_BUS_TEST_W =A0 =A0 =A0 =A0 =A0 =A0 19
> +#define MMC_CMD_BUS_TEST_R =A0 =A0 =A0 =A0 =A0 =A0 14
> +
> +static int
> +mmc_send_bus_test(struct mmc_card *card, struct mmc_host *host, u8 o=
pcode,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 u8 len)
> +{
> + =A0 =A0 =A0 struct mmc_request mrq;
> + =A0 =A0 =A0 struct mmc_command cmd;
> + =A0 =A0 =A0 struct mmc_data data;
> + =A0 =A0 =A0 struct scatterlist sg;
> + =A0 =A0 =A0 u8 *data_buf;
> + =A0 =A0 =A0 u8 *test_buf;
> + =A0 =A0 =A0 int i, err;
> + =A0 =A0 =A0 static u8 testdata_8bit[8] =3D { 0x55, 0xaa, 0, 0, 0, 0=
, 0, 0 };
> + =A0 =A0 =A0 static u8 testdata_4bit[4] =3D { 0x5a, 0, 0, 0 };
> +
> + =A0 =A0 =A0 /* dma onto stack is unsafe/nonportable, but callers to=
 this
> + =A0 =A0 =A0 =A0* routine normally provide temporary on-stack buffer=
s ...
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 data_buf =3D kmalloc(len, GFP_KERNEL);
> + =A0 =A0 =A0 if (!data_buf)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> +
> + =A0 =A0 =A0 if (len =3D=3D 8)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_buf =3D testdata_8bit;
> + =A0 =A0 =A0 else if (len =3D=3D 4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 test_buf =3D testdata_4bit;
> + =A0 =A0 =A0 else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: Invaild bus_width =
%d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(host), len)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (opcode =3D=3D MMC_CMD_BUS_TEST_W)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(data_buf, test_buf, len);
> +
> + =A0 =A0 =A0 memset(&mrq, 0, sizeof(struct mmc_request));
> + =A0 =A0 =A0 memset(&cmd, 0, sizeof(struct mmc_command));
> + =A0 =A0 =A0 memset(&data, 0, sizeof(struct mmc_data));
> +
> + =A0 =A0 =A0 mrq.cmd =3D &cmd;
> + =A0 =A0 =A0 mrq.data =3D &data;
> + =A0 =A0 =A0 cmd.opcode =3D opcode;
> + =A0 =A0 =A0 cmd.arg =3D 0;
> +
> + =A0 =A0 =A0 /* NOTE HACK: =A0the MMC_RSP_SPI_R1 is always correct h=
ere, but we
> + =A0 =A0 =A0 =A0* rely on callers to never use this with "native" ca=
lls for reading
> + =A0 =A0 =A0 =A0* CSD or CID. =A0Native versions of those commands u=
se the R2 type,
> + =A0 =A0 =A0 =A0* not R1 plus a data block.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R1 | MMC_CMD_ADT=
C;
> +
> + =A0 =A0 =A0 data.blksz =3D len;
> + =A0 =A0 =A0 data.blocks =3D 1;
> + =A0 =A0 =A0 if (opcode =3D=3D MMC_CMD_BUS_TEST_R)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data.flags =3D MMC_DATA_READ;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data.flags =3D MMC_DATA_WRITE;
> +
> + =A0 =A0 =A0 data.sg =3D &sg;
> + =A0 =A0 =A0 data.sg_len =3D 1;
> + =A0 =A0 =A0 sg_init_one(&sg, data_buf, len);
> + =A0 =A0 =A0 mmc_wait_for_req(host, &mrq);
> + =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 if (opcode =3D=3D MMC_CMD_BUS_TEST_R) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < len / 4; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((test_buf[i] ^ data=
_buf[i]) !=3D 0xff) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D=
 -EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 kfree(data_buf);
> +
> + =A0 =A0 =A0 if (cmd.error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return cmd.error;
> + =A0 =A0 =A0 if (data.error)

	if (data.error && (data.error !=3D -EILSEQ))
Could you add code here to ignore CRC error of CMD14.
According to spec, CRC bits from card are optional in CMD14, and it is
ignored by host.
However some host still check and may get crc error here if card does n=
ot send.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return data.error;
> +
> + =A0 =A0 =A0 return err;
> +}
> +
> +int mmc_bus_test(struct mmc_card *card, u8 bus_width)
> +{
> + =A0 =A0 =A0 int err, width;
> +
> + =A0 =A0 =A0 if (bus_width =3D=3D MMC_BUS_WIDTH_8)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 width =3D 8;
> + =A0 =A0 =A0 else if (bus_width =3D=3D MMC_BUS_WIDTH_4)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 width =3D 4;
> + =A0 =A0 =A0 else if (bus_width =3D=3D MMC_BUS_WIDTH_1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0; /* no need for test */
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 err =3D mmc_send_bus_test(card, card->host, MMC_CMD_BUS=
_TEST_W, width);
> + =A0 =A0 =A0 if (err < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 err =3D mmc_send_bus_test(card, card->host, MMC_CMD_BUS=
_TEST_R, width);
> + =A0 =A0 =A0 return err;
> +
> +
> +}
> diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
> index 653eb8e..e6d44b8 100644
> --- a/drivers/mmc/core/mmc_ops.h
> +++ b/drivers/mmc/core/mmc_ops.h
> @@ -26,6 +26,7 @@ int mmc_send_cid(struct mmc_host *host, u32 *cid);
> =A0int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp=
);
> =A0int mmc_spi_set_crc(struct mmc_host *host, int use_crc);
> =A0int mmc_card_sleepawake(struct mmc_host *host, int sleep);
> +int mmc_bus_test(struct mmc_card *card, u8 bus_width);
>
> =A0#endif
>
> --
> 1.7.3.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
