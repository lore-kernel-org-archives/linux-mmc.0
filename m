From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc:core: fix hs400 timing selection
Date: Wed, 29 Oct 2014 11:33:57 +0200
Message-ID: <5450B485.5050705@intel.com>
References: <1413946555-1266-1-git-send-email-chanho.min@lge.com> <544F98DD.6040605@intel.com> <00b501cff307$1de03fb0$59a0bf10$@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00b501cff307$1de03fb0$59a0bf10$@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?EUC-KR?B?wK/H0bDm?= <hankyung.yu@lge.com>, 'Chanho Min' <chanho.min@lge.com>
Cc: 'Chris Ball' <chris@printf.net>, 'Ulf Hansson' <ulf.hansson@linaro.org>, 'Seungwon Jeon' <tgih.jun@samsung.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 'HyoJun Im' <hyojun.im@lge.com>, gunho.lee@lge.com
List-Id: linux-mmc@vger.kernel.org

On 29/10/14 01:30, =C0=AF=C7=D1=B0=E6 wrote:
> Hi I'm Hankyung Yu
>=20
> I will answer instead Chanho Min
>=20
> HS200 mode right thing to support less than 52Mhz
>=20
> However CLK <-> DATA delay timing is dependent on the clock.
>=20
> So only lower clock without adjusting the timing and mode of a contro=
l h/w
> ever the problem may occur.
>=20
> So change the operating mode and to lower the clock.

I meant something different.

With your patch I find that __mmc_switch() -> send_status() fails.

So I suggest something like this:

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 92247c2..195d48a 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -1045,21 +1045,28 @@ static int mmc_select_hs400(struct mmc_card *ca=
rd)
 	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
 			   card->ext_csd.generic_cmd6_time,
-			   true, true, true);
+			   true, false, false);
+	if (!err) {
+		u32 status;
+
+		/*
+		 * According to JEDEC v5.01 spec (6.6.5), Clock frequency should
+		 * be set to a value not greater than 52MHz after the HS_TIMING
+		 * field is set to 0x1.
+		*/
+		mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
+		mmc_set_bus_speed(card);
+
+		err =3D __mmc_send_status(card, &status, false, 1);
+		if (!err)
+			err =3D mmc_check_switch_status(card->host, status);
+	}
 	if (err) {
 		pr_err("%s: switch to high-speed from hs200 failed, err:%d\n",
 			mmc_hostname(host), err);
 		return err;
 	}
=20
-	/*
-	 * According to JEDEC v5.01 spec (6.6.5), Clock frequency should
-	 * be set to a value not greater than 52MHz after the HS_TIMING
-	 * field is set to 0x1.
-	 */
-	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
-	mmc_set_bus_speed(card);
-
 	err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
 			 EXT_CSD_BUS_WIDTH,
 			 EXT_CSD_DDR_BUS_WIDTH_8,
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index 23aa3a3..f917527 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -23,15 +23,12 @@
=20
 #define MMC_OPS_TIMEOUT_MS	(10 * 60 * 1000) /* 10 minute timeout */
=20
-static inline int __mmc_send_status(struct mmc_card *card, u32 *status=
,
-				    bool ignore_crc)
+int __mmc_send_status(struct mmc_card *card, u32 *status, bool ignore_=
crc,
+		      int retries)
 {
 	int err;
 	struct mmc_command cmd =3D {0};
=20
-	BUG_ON(!card);
-	BUG_ON(!card->host);
-
 	cmd.opcode =3D MMC_SEND_STATUS;
 	if (!mmc_host_is_spi(card->host))
 		cmd.arg =3D card->rca << 16;
@@ -39,7 +36,7 @@ static inline int __mmc_send_status(struct mmc_card *=
card, u32 *status,
 	if (ignore_crc)
 		cmd.flags &=3D ~MMC_RSP_CRC;
=20
-	err =3D mmc_wait_for_cmd(card->host, &cmd, MMC_CMD_RETRIES);
+	err =3D mmc_wait_for_cmd(card->host, &cmd, retries);
 	if (err)
 		return err;
=20
@@ -54,7 +51,7 @@ static inline int __mmc_send_status(struct mmc_card *=
card, u32 *status,
=20
 int mmc_send_status(struct mmc_card *card, u32 *status)
 {
-	return __mmc_send_status(card, status, false);
+	return __mmc_send_status(card, status, false, MMC_CMD_RETRIES);
 }
=20
 static int _mmc_select_card(struct mmc_host *host, struct mmc_card *ca=
rd)
@@ -419,6 +416,21 @@ int mmc_spi_set_crc(struct mmc_host *host, int use=
_crc)
 	return err;
 }
=20
+int mmc_check_switch_status(struct mmc_host *host, u32 status)
+{
+	if (mmc_host_is_spi(host)) {
+		if (status & R1_SPI_ILLEGAL_COMMAND)
+			return -EBADMSG;
+	} else {
+		if (status & 0xFDFFA000)
+			pr_warn("%s: unexpected status %#x after switch\n",
+				mmc_hostname(host), status);
+		if (status & R1_SWITCH_ERROR)
+			return -EBADMSG;
+	}
+	return 0;
+}
+
 /**
  *	__mmc_switch - modify EXT_CSD register
  *	@card: the MMC card associated with the data transfer
@@ -497,7 +509,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 =
index, u8 value,
 	timeout =3D jiffies + msecs_to_jiffies(timeout_ms);
 	do {
 		if (send_status) {
-			err =3D __mmc_send_status(card, &status, ignore_crc);
+			err =3D __mmc_send_status(card, &status, ignore_crc, 1);
 			if (err)
 				return err;
 		}
@@ -524,18 +536,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8=
 index, u8 value,
 		}
 	} while (R1_CURRENT_STATE(status) =3D=3D R1_STATE_PRG);
=20
-	if (mmc_host_is_spi(host)) {
-		if (status & R1_SPI_ILLEGAL_COMMAND)
-			return -EBADMSG;
-	} else {
-		if (status & 0xFDFFA000)
-			pr_warn("%s: unexpected status %#x after switch\n",
-				mmc_hostname(host), status);
-		if (status & R1_SWITCH_ERROR)
-			return -EBADMSG;
-	}
-
-	return 0;
+	return mmc_check_switch_status(host, status);
 }
 EXPORT_SYMBOL_GPL(__mmc_switch);
=20
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index 6f4b00e..a59319c 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -20,7 +20,10 @@ int mmc_send_op_cond(struct mmc_host *host, u32 ocr,=
 u32 *rocr);
 int mmc_all_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_set_relative_addr(struct mmc_card *card);
 int mmc_send_csd(struct mmc_card *card, u32 *csd);
+int __mmc_send_status(struct mmc_card *card, u32 *status, bool ignore_=
crc,
+		      int retries);
 int mmc_send_status(struct mmc_card *card, u32 *status);
+int mmc_check_switch_status(struct mmc_host *host, u32 status);
 int mmc_send_cid(struct mmc_host *host, u32 *cid);
 int mmc_spi_read_ocr(struct mmc_host *host, int highcap, u32 *ocrp);
 int mmc_spi_set_crc(struct mmc_host *host, int use_crc);



>=20
>=20
> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com]=20
> Sent: Tuesday, October 28, 2014 10:24 PM
> To: Chanho Min
> Cc: Chris Ball; Ulf Hansson; Seungwon Jeon; Jaehoon Chung; linux-
> mmc@vger.kernel.org; linux-kernel@vger.kernel.org; HyoJun Im; gunho.l=
ee@lge.
> com; Hankyung Yu
> Subject: Re: [PATCH] mmc:core: fix hs400 timing selection
>=20
> On 22/10/14 05:55, Chanho Min wrote:
>> According to JEDEC v5.01 spec (6.6.5), In order to switch to HS400=20
>> mode, host should perform the following steps.
>>
>>  1. HS200 mode selection completed
>>  2. Set HS_TIMING to 0x01(High Speed)
>>  3. Host changes frequency to =3D< 52MHz  4. Set the bus width to DD=
R=20
>> 8bit (CMD6)  5. Host may read Driver Strength (CMD8)  6. Set HS_TIMI=
NG=20
>> to 0x03 (HS400)
>>
>> In current implementation, the order of 2 and 3 is reversed.
>=20
> But HS200 mode supports running at speeds less than 52 MHz whereas Hi=
gh
> Speed mode does not support running at speeds greater than
> 52 MHz.
>=20
> So the switch command might succeed, but the subsequent send_status c=
ommand
> (see __mmc_switch) could be expected to fail unless the frequency is
> changed first.
>=20
>> The HS_TIMING field should be set to 0x1 before the clock frequency =
is=20
>> set to a value not greater than 52 MHz. Otherwise, Initialization of=
=20
>> timing can be failed. Also, the host contoller's UHS timing mode=20
>> should be set to DDR50 after the bus width is set to DDR 8bit.
>>
>> Signed-off-by: Hankyung Yu <hankyung.yu@lge.com>
>> Signed-off-by: Chanho Min <chanho.min@lge.com>
>> ---
>>  drivers/mmc/core/mmc.c |   13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index=20
>> a301a78..52f78e0 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -1061,9 +1061,6 @@ static int mmc_select_hs400(struct mmc_card *c=
ard)
>>  	 * Before switching to dual data rate operation for HS400,
>>  	 * it is required to convert from HS200 mode to HS mode.
>>  	 */
>> -	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
>> -	mmc_set_bus_speed(card);
>> -
>>  	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>  			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS,
>>  			   card->ext_csd.generic_cmd6_time, @@ -1074,6
> +1071,14 @@ static=20
>> int mmc_select_hs400(struct mmc_card *card)
>>  		return err;
>>  	}
>> =20
>> +	/*
>> +	 * According to JEDEC v5.01 spec (6.6.5), Clock frequency should
>> +	 * be set to a value not greater than 52MHz after the HS_TIMING
>> +	 * field is set to 0x1.
>> +	 */
>> +	mmc_set_timing(card->host, MMC_TIMING_MMC_HS);
>> +	mmc_set_bus_speed(card);
>> +
>>  	err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>  			 EXT_CSD_BUS_WIDTH,
>>  			 EXT_CSD_DDR_BUS_WIDTH_8,
>> @@ -1084,6 +1089,8 @@ static int mmc_select_hs400(struct mmc_card *c=
ard)
>>  		return err;
>>  	}
>> =20
>> +	mmc_set_timing(card->host, MMC_TIMING_MMC_DDR52);
>> +
>>  	err =3D __mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
>>  			   EXT_CSD_HS_TIMING, EXT_CSD_TIMING_HS400,
>>  			   card->ext_csd.generic_cmd6_time,
>>
>=20
>=20
>=20
