From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH V2] mmc: eMMC bus width may not work on all platforms
Date: Tue, 24 May 2011 18:14:58 -0700
Message-ID: <2FB34057-4156-4BCA-A896-733203F90DA3@marvell.com>
References: <2FBABAF6-BFF6-46C9-BE6C-D4CA1EE9BD03@marvell.com>
 <1482D9D127C1754E8684047CF53F7660622B177DBE@pgsmsx505.gar.corp.intel.com>
 <m3fwo7r0nc.fsf@pullcord.laptop.org>
 <15864FE4-25CB-46BC-ACC2-FC24C2E6E241@marvell.com>
 <m3wrhgaeur.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:43528 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753979Ab1EYBP1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 May 2011 21:15:27 -0400
In-Reply-To: <m3wrhgaeur.fsf@pullcord.laptop.org>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: "Mok, Tze Siong" <tze.siong.mok@intel.com>, Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <mark.brown314@gmail.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>


resend=20

Note:  I cannot test test for a few days.  Following Chris
suggestion posting to list.

version 2
---
return -EINVAL when compare of ext_csd_fails
combine two compare routines into one per suggestion
from Chris.

---
version 1

CMD19 -- The offical way to validate bus widths from the
JEDEC spec does not work on all platforms.  Some platforms
that use PCI/PCIe to connect their SD controllers are known
to fail.

If the quirk MMC_BUS_WIDTH_TEST is not defined we try
to figure out the bus width by reading the ext_csd at different
bus widths and compare this against the ext_csd read in 1 bit
mode.  If no ext_csd is available we default to 1 bit operations.

Code has been tested on mmp2 against 8 bit eMMC and Transcend 2GB
card that is known to not work in 4 bit mode.  The physical
pins on the card are not present to support 4 bit operation.

Signed-off-by: Philip Rakity <prakity@marvell.com>
---
 drivers/mmc/core/mmc.c |  113 ++++++++++++++++++++++++++++++++++++++++=
+++----
 1 files changed, 103 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index baab027..6db91d6 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -174,14 +174,17 @@ static int mmc_decode_csd(struct mmc_card *card)
 }
=20
 /*
- * Read and decode extended CSD.
+ * Read extended CSD.
  */
-static int mmc_read_ext_csd(struct mmc_card *card)
+static int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd)
 {
 	int err;
 	u8 *ext_csd;
=20
 	BUG_ON(!card);
+	BUG_ON(!new_ext_csd);
+
+	*new_ext_csd =3D NULL;
=20
 	if (card->csd.mmca_vsn < CSD_SPEC_VER_4)
 		return 0;
@@ -199,12 +202,15 @@ static int mmc_read_ext_csd(struct mmc_card *card=
)
=20
 	err =3D mmc_send_ext_csd(card, ext_csd);
 	if (err) {
+		kfree(ext_csd);
+		*new_ext_csd =3D NULL;
+
 		/* If the host or the card can't do the switch,
 		 * fail more gracefully. */
 		if ((err !=3D -EINVAL)
 		 && (err !=3D -ENOSYS)
 		 && (err !=3D -EFAULT))
-			goto out;
+			return err;
=20
 		/*
 		 * High capacity cards should have this "magic" size
@@ -222,9 +228,23 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 				mmc_hostname(card->host));
 			err =3D 0;
 		}
+	} else
+		*new_ext_csd =3D ext_csd;
=20
-		goto out;
-	}
+	return err;
+}
+
+/*
+ * Decode extended CSD.
+ */
+static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
+{
+	int err =3D 0;
+
+	BUG_ON(!card);
+
+	if (!ext_csd)
+		return 0;
=20
 	/* Version is coded in the CSD_STRUCTURE byte in the EXT_CSD register=
 */
 	if (card->csd.structure =3D=3D 3) {
@@ -372,8 +392,70 @@ static int mmc_read_ext_csd(struct mmc_card *card)
 		card->erased_byte =3D 0x0;
=20
 out:
+	return err;
+}
+
+static inline void mmc_free_ext_csd(u8 *ext_csd)
+{
 	kfree(ext_csd);
+}
+
=20
+static int mmc_compare_ext_csds(struct mmc_card *card, u8 *ext_csd,
+			unsigned bus_width)
+{
+	u8 *bw_ext_csd;
+	int err;
+
+	err =3D mmc_get_ext_csd(card, &bw_ext_csd);
+	if (err)
+		return err;
+
+	if ((ext_csd =3D=3D NULL || bw_ext_csd =3D=3D NULL)) {
+		if (bus_width !=3D MMC_BUS_WIDTH_1)
+			err =3D -EINVAL;
+		goto out;
+	}
+
+	if (bus_width =3D=3D MMC_BUS_WIDTH_1)
+		goto out;
+
+	/* only compare read only fields */
+
+	err =3D	(!(ext_csd[EXT_CSD_PARTITION_SUPPORT] =3D=3D
+			bw_ext_csd[EXT_CSD_PARTITION_SUPPORT]) &&
+		(ext_csd[EXT_CSD_ERASED_MEM_CONT] =3D=3D
+			bw_ext_csd[EXT_CSD_ERASED_MEM_CONT]) &&
+		(ext_csd[EXT_CSD_REV] =3D=3D
+			bw_ext_csd[EXT_CSD_REV]) &&
+		(ext_csd[EXT_CSD_STRUCTURE] =3D=3D
+			bw_ext_csd[EXT_CSD_STRUCTURE]) &&
+		(ext_csd[EXT_CSD_CARD_TYPE] =3D=3D
+			bw_ext_csd[EXT_CSD_CARD_TYPE]) &&
+		(ext_csd[EXT_CSD_S_A_TIMEOUT] =3D=3D
+			bw_ext_csd[EXT_CSD_S_A_TIMEOUT]) &&
+		(ext_csd[EXT_CSD_HC_WP_GRP_SIZE] =3D=3D
+			bw_ext_csd[EXT_CSD_HC_WP_GRP_SIZE]) &&
+		(ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] =3D=3D
+			bw_ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT]) &&
+		(ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] =3D=3D
+			bw_ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE]) &&
+		(ext_csd[EXT_CSD_SEC_TRIM_MULT] =3D=3D
+			bw_ext_csd[EXT_CSD_SEC_TRIM_MULT]) &&
+		(ext_csd[EXT_CSD_SEC_ERASE_MULT] =3D=3D
+			bw_ext_csd[EXT_CSD_SEC_ERASE_MULT]) &&
+		(ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT] =3D=3D
+			bw_ext_csd[EXT_CSD_SEC_FEATURE_SUPPORT]) &&
+		(ext_csd[EXT_CSD_TRIM_MULT] =3D=3D
+			bw_ext_csd[EXT_CSD_TRIM_MULT]) &&
+		memcmp(&ext_csd[EXT_CSD_SEC_CNT],
+			&bw_ext_csd[EXT_CSD_SEC_CNT],
+			4) !=3D 0);
+	if (err)
+		err =3D -EINVAL;
+
+out:
+	mmc_free_ext_csd(bw_ext_csd);
 	return err;
 }
=20
@@ -438,6 +520,7 @@ static int mmc_init_card(struct mmc_host *host, u32=
 ocr,
 	u32 cid[4];
 	unsigned int max_dtr;
 	u32 rocr;
+	u8 *ext_csd =3D NULL;
=20
 	BUG_ON(!host);
 	WARN_ON(!host->claimed);
@@ -536,7 +619,11 @@ static int mmc_init_card(struct mmc_host *host, u3=
2 ocr,
 		/*
 		 * Fetch and process extended CSD.
 		 */
-		err =3D mmc_read_ext_csd(card);
+
+		err =3D mmc_get_ext_csd(card, &ext_csd);
+		if (err)
+			goto free_card;
+		err =3D mmc_read_ext_csd(card, ext_csd);
 		if (err)
 			goto free_card;
=20
@@ -676,14 +763,18 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
 					 0);
 			if (!err) {
 				mmc_set_bus_width(card->host, bus_width);
+
 				/*
 				 * If controller can't handle bus width test,
-				 * use the highest bus width to maintain
-				 * compatibility with previous MMC behavior.
+				 * compare ext_csd previously read in 1 bit mode
+				 * against ext_csd at new bus width
 				 */
 				if (!(host->caps & MMC_CAP_BUS_WIDTH_TEST))
-					break;
-				err =3D mmc_bus_test(card, bus_width);
+					err =3D mmc_compare_ext_csds(card,
+						ext_csd,
+						bus_width);
+				else
+					err =3D mmc_bus_test(card, bus_width);
 				if (!err)
 					break;
 			}
@@ -730,12 +821,14 @@ static int mmc_init_card(struct mmc_host *host, u=
32 ocr,
 	if (!oldcard)
 		host->card =3D card;
=20
+	mmc_free_ext_csd(ext_csd);
 	return 0;
=20
 free_card:
 	if (!oldcard)
 		mmc_remove_card(card);
 err:
+	mmc_free_ext_csd(ext_csd);
=20
 	return err;
 }
--=20
1.7.0.4



On May 23, 2011, at 9:42 PM, Chris Ball wrote:

> Hi Philip,
>=20
> On Sun, May 22 2011, Philip Rakity wrote:
>> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>> index baab027..6db91d6 100644
>> --- a/drivers/mmc/core/mmc.c
>> +++ b/drivers/mmc/core/mmc.c
>> @@ -174,14 +174,17 @@ static int mmc_decode_csd(struct mmc_card *car=
d)
>> }
>>=20
>> /*
>> - * Read and decode extended CSD.
>> + * Read extended CSD.
>>  */
>> -static int mmc_read_ext_csd(struct mmc_card *card)
>> +static int mmc_read_ext_csd(struct mmc_card *card, u8 *ext_csd)
>=20
> This one doesn't work -- you're missing the half of the patch that ho=
oks
> up the rest of mmc.c to the new code, which was in v1.  As-is, we get=
:
>=20
> drivers/mmc/core/mmc.c: In function =91mmc_init_card=92:
> drivers/mmc/core/mmc.c:621:3: error: too few arguments to function =91=
mmc_read_ext_csd=92
> drivers/mmc/core/mmc.c:240:12: note: declared here
> drivers/mmc/core/mmc.c: At top level:
> drivers/mmc/core/mmc.c:404:12: warning: =91mmc_compare_ext_csds=92 de=
fined but not used [-Wunused-function]
>=20
> - Chris.
> --=20
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

