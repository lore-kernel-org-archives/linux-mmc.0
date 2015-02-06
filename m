From: "Luca Porzio (lporzio)" <lporzio@micron.com>
Subject: RE: [PATCH v3] mmc: Add Production State Awareness Support
Date: Fri, 6 Feb 2015 13:57:44 +0000
Message-ID: <26E7A31274623843B0E8CF86148BFE3201167C60EA@NTXBOIMBX08.micron.com>
References: <1417020269-3993-1-git-send-email-alex.lemberg@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout.micron.com ([137.201.242.129]:34385 "EHLO
	mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999AbbBFN56 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Feb 2015 08:57:58 -0500
In-Reply-To: <1417020269-3993-1-git-send-email-alex.lemberg@sandisk.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <alex.lemberg@sandisk.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>, "avi.shchislowski@sandisk.com" <avi.shchislowski@sandisk.com>, "Bruce Ford (bford)" <bford@micron.com>, "Brett Hunter (bhunter)" <bhunter@micron.com>

Alex, Ulf,

I am not sure about the status of this patch.
Still I would like to give some feedback.

The Jedec specification requires to check the=20
PRODUCTION_STATE_AWARENESS_ENABLEMENT (ext_csd[17])=20
register before issuing a PSA command.
Actually in some devices the PSA register might be a=20
"don't care" random value if the=20
PRODUCTION_STATE_AWARENESS_ENABLEMENT shows that device=20
is not supporting MANUAL mode.

Thus we propose some changes to Alex patch=20
in order to check the ext_csd[17] before actually=20
taking any action.
Even if the modified lines are few, I was not able to=20
efficiently merge my proposals with Alex code.
Please forgive me if I post a new patch which=20
includes both my changes and Alex original=20
patch.

With these small changes, patch is fine for us.

Cheers,
  Luca

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 7466ce0..52c8cc9 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -571,6 +571,29 @@ static int mmc_decode_ext_csd(struct mmc_card *car=
d, u8 *ext_csd)
 		card->ext_csd.ffu_capable =3D
 			(ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) &&
 			!(ext_csd[EXT_CSD_FW_CONFIG] & 0x1);
+ 	=09
+        /*=20
+         * PSA ext_csd parsing
+         * Note: Only Manual mode needs to be supported=20
+         */
+        card->ext_csd.psa_enablement =3D
+            (ext_csd[EXT_CSD_PSA_ENABLEMENT] & 1);=20
+        if (card->ext_csd.psa_enablement) {
+            card->ext_csd.psa =3D
+                ext_csd[EXT_CSD_PSA];
+            if (ext_csd[EXT_CSD_PSA_TIMEOUT] > 0) {
+                card->ext_csd.psa_timeout =3D
+                    100 *
+                    (1 << ext_csd[EXT_CSD_PSA_TIMEOUT]);
+            } else {
+                pr_warn("%s: EXT_CSD PSA Timeout is zero\n",=20
+                mmc_hostname(card->host));
+            }
+        } else {
+            card->ext_csd.psa =3D EXT_CSD_PSA_NORMAL;
+            card->ext_csd.psa_timeout =3D 0;
+        }
+       =20
 	}
 out:
 	return err;
@@ -1358,6 +1381,24 @@ static int mmc_init_card(struct mmc_host *host, =
u32 ocr,
 	}
=20
 	/*
+ 	 * eMMC v5.0 or later
+ 	 * and Production State Awareness state is
+ 	 * EXT_CSD_PSA_POST_SOLDERING_WRITES (0x02)
+ 	 * The host should set the device to NORMAL mode
+ 	 */
+ 	if ((card->ext_csd.rev >=3D 7) && (card->ext_csd.psa_enablement) &&
+ 		(card->ext_csd.psa =3D=3D EXT_CSD_PSA_POST_SOLDERING_WRITES)) {
+ 		unsigned int timeout;
+=20
+ 		timeout =3D DIV_ROUND_UP(card->ext_csd.psa_timeout, 1000);
+ 		card->ext_csd.psa =3D EXT_CSD_PSA_NORMAL;
+ 		err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
+ 			EXT_CSD_PSA, card->ext_csd.psa, timeout);
+ 		if (err && err !=3D -EBADMSG)
+ 			goto free_card;
+ 	}
+=20
+ 	/*
 	 * If enhanced_area_en is TRUE, host needs to enable ERASE_GRP_DEF
 	 * bit.  This bit will be lost every time after a reset or power off.
 	 */
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 4d69c00..8dc1148 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -60,9 +60,12 @@ struct mmc_ext_csd {
 	u8			packed_event_en;
 	unsigned int		part_time;		/* Units: ms */
 	unsigned int		sa_timeout;		/* Units: 100ns */
-	unsigned int		generic_cmd6_time;	/* Units: 10ms */
+    unsigned int		psa_timeout;		/* Units: 100us */
+    unsigned int		generic_cmd6_time;	/* Units: 10ms */
 	unsigned int            power_off_longtime;     /* Units: ms */
 	u8			power_off_notification;	/* state */
+    u8			psa_enablement; /* production state awareness enablement*/
+    u8			psa; /* production state awareness */
 	unsigned int		hs_max_dtr;
 	unsigned int		hs200_max_dtr;
 #define MMC_HIGH_26_MAX_DTR	26000000
diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index 49ad7a9..435e9ef 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -277,6 +277,7 @@ struct _mmc_csd {
  * EXT_CSD fields
  */
=20
+#define EXT_CSD_PSA_ENABLEMENT			17	/* RO */
 #define EXT_CSD_FLUSH_CACHE		32      /* W */
 #define EXT_CSD_CACHE_CTRL		33      /* R/W */
 #define EXT_CSD_POWER_OFF_NOTIFICATION	34	/* R/W */
@@ -285,6 +286,7 @@ struct _mmc_csd {
 #define EXT_CSD_EXP_EVENTS_STATUS	54	/* RO, 2 bytes */
 #define EXT_CSD_EXP_EVENTS_CTRL		56	/* R/W, 2 bytes */
 #define EXT_CSD_DATA_SECTOR_SIZE	61	/* R */
+#define EXT_CSD_PSA			133	/* R/W/E */
 #define EXT_CSD_GP_SIZE_MULT		143	/* R/W */
 #define EXT_CSD_PARTITION_SETTING_COMPLETED 155	/* R/W */
 #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
@@ -315,6 +317,7 @@ struct _mmc_csd {
 #define EXT_CSD_PWR_CL_26_360		203	/* RO */
 #define EXT_CSD_SEC_CNT			212	/* RO, 4 bytes */
 #define EXT_CSD_S_A_TIMEOUT		217	/* RO */
+#define EXT_CSD_PSA_TIMEOUT		218	/* RO */
 #define EXT_CSD_REL_WR_SEC_C		222	/* RO */
 #define EXT_CSD_HC_WP_GRP_SIZE		221	/* RO */
 #define EXT_CSD_ERASE_TIMEOUT_MULT	223	/* RO */
@@ -428,6 +431,12 @@ struct _mmc_csd {
 #define EXT_CSD_PACKED_INDEXED_ERROR	BIT(1)
=20
 /*
+ * PRODUCTION STATE AWARENESS fields
+ */
+#define EXT_CSD_PSA_NORMAL		0x00
+#define EXT_CSD_PSA_POST_SOLDERING_WRITES	0x02
+=20
+/*
  * BKOPS status level
  */
 #define EXT_CSD_BKOPS_LEVEL_2		0x2

> -----Original Message-----
> From: linux-mmc-owner@vger.kernel.org [mailto:linux-mmc-
> owner@vger.kernel.org] On Behalf Of Alex Lemberg
> Sent: mercoled=EC 26 novembre 2014 17:44
> To: ulf.hansson@linaro.org
> Cc: linux-mmc@vger.kernel.org; chris@printf.net;
> avi.shchislowski@sandisk.com; Alex Lemberg
> Subject: [PATCH v3] mmc: Add Production State Awareness Support
>=20
> In this patch driver should recognize if eMMC device (Rev >=3D5.0) wa=
s left
> in PRE_SOLDERING_POST_WRITES (0x02) state, and switch it to NORMAL (0=
x00).
> PRE_SOLDERING_POST_WRITES (0x02) state - represents a state where the
> device is in production process and the host (usually programmer)
> completed loading the content to the device.
> The host (usually programmer) sets the device to this state after loa=
ding
> the content and just before soldering.
> After soldering the device to the real host (not programmer), the dev=
ice
> should be switched to NORMAL (0x00) mode.
> The NORMAL (0x00) mode of PSA register represents a state in which th=
e
> device is running in the field and uses regular operations.
> Leaving device in PRE_SOLDERING_POST_WRITES (0x02) might cause unexpe=
cted
> behaviour of eMMC device.
>=20
> More details about PSA feature can be found in eMMC5.0 JEDEC spec (JE=
SD84-
> B50.pdf):
> http://www.jedec.org/standards-documents/technology-focus-areas/flash=
-
> memory-ssds-ufs-emmc/e-mmc
>=20
> Signed-off-by: Alex Lemberg <alex.lemberg@sandisk.com>
> ---
> Changes in v2:
>  - Remove typo in patch code
> Changes in v3:
>  - Move ext_csd revision check
> ---
>  drivers/mmc/core/mmc.c   | 28 ++++++++++++++++++++++++++++
>  include/linux/mmc/card.h |  2 ++
>  include/linux/mmc/mmc.h  |  8 ++++++++
>  3 files changed, 38 insertions(+)
>=20
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c index
> 02ad792..2c523ca 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -571,6 +571,16 @@ static int mmc_decode_ext_csd(struct mmc_card *c=
ard,
> u8 *ext_csd)
>  		card->ext_csd.ffu_capable =3D
>  			(ext_csd[EXT_CSD_SUPPORTED_MODE] & 0x1) &&
>  			!(ext_csd[EXT_CSD_FW_CONFIG] & 0x1);
> +		card->ext_csd.psa =3D
> +			ext_csd[EXT_CSD_PSA];
> +		if (ext_csd[EXT_CSD_PSA_TIMEOUT] > 0) {
> +			card->ext_csd.psa_timeout =3D
> +				100 *
> +				(1 << ext_csd[EXT_CSD_PSA_TIMEOUT]);
> +		} else {
> +			pr_warn("%s: EXT_CSD PSA Timeout is zero\n",
> +					mmc_hostname(card->host));
> +		}
>  	}
>  out:
>  	return err;
> @@ -1358,6 +1368,24 @@ static int mmc_init_card(struct mmc_host *host=
, u32
> ocr,
>  	}
>=20
>  	/*
> +	 * eMMC v5.0 or later
> +	 * and Production State Awareness state is
> +	 * EXT_CSD_PSA_POST_SOLDERING_WRITES (0x02)
> +	 * The host should set the device to NORMAL mode
> +	 */
> +	if ((card->ext_csd.rev >=3D 7) &&
> +		(card->ext_csd.psa =3D=3D EXT_CSD_PSA_POST_SOLDERING_WRITES)) {
> +		unsigned int timeout;
> +
> +		timeout =3D DIV_ROUND_UP(card->ext_csd.psa_timeout, 1000);
> +		card->ext_csd.psa =3D EXT_CSD_PSA_NORMAL;
> +		err =3D mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> +			EXT_CSD_PSA, card->ext_csd.psa, timeout);
> +		if (err && err !=3D -EBADMSG)
> +			goto free_card;
> +	}
> +
> +	/*
>  	 * If enhanced_area_en is TRUE, host needs to enable ERASE_GRP_DEF
>  	 * bit.  This bit will be lost every time after a reset or power
> off.
>  	 */
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h inde=
x
> 4d69c00..09ac3b0 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -60,9 +60,11 @@ struct mmc_ext_csd {
>  	u8			packed_event_en;
>  	unsigned int		part_time;		/* Units: ms */
>  	unsigned int		sa_timeout;		/* Units: 100ns */
> +	unsigned int		psa_timeout;		/* Units: 100us */
>  	unsigned int		generic_cmd6_time;	/* Units: 10ms */
>  	unsigned int            power_off_longtime;     /* Units: ms */
>  	u8			power_off_notification;	/* state */
> +	u8			psa; /* production state awareness */
>  	unsigned int		hs_max_dtr;
>  	unsigned int		hs200_max_dtr;
>  #define MMC_HIGH_26_MAX_DTR	26000000
> diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h index
> 49ad7a9..458814d 100644
> --- a/include/linux/mmc/mmc.h
> +++ b/include/linux/mmc/mmc.h
> @@ -285,6 +285,7 @@ struct _mmc_csd {
>  #define EXT_CSD_EXP_EVENTS_STATUS	54	/* RO, 2 bytes */
>  #define EXT_CSD_EXP_EVENTS_CTRL		56	/* R/W, 2 bytes */
>  #define EXT_CSD_DATA_SECTOR_SIZE	61	/* R */
> +#define EXT_CSD_PSA			133	/* R/W/E */
>  #define EXT_CSD_GP_SIZE_MULT		143	/* R/W */
>  #define EXT_CSD_PARTITION_SETTING_COMPLETED 155	/* R/W */
>  #define EXT_CSD_PARTITION_ATTRIBUTE	156	/* R/W */
> @@ -315,6 +316,7 @@ struct _mmc_csd {
>  #define EXT_CSD_PWR_CL_26_360		203	/* RO */
>  #define EXT_CSD_SEC_CNT			212	/* RO, 4 bytes */
>  #define EXT_CSD_S_A_TIMEOUT		217	/* RO */
> +#define EXT_CSD_PSA_TIMEOUT		218	/* RO */
>  #define EXT_CSD_REL_WR_SEC_C		222	/* RO */
>  #define EXT_CSD_HC_WP_GRP_SIZE		221	/* RO */
>  #define EXT_CSD_ERASE_TIMEOUT_MULT	223	/* RO */
> @@ -433,6 +435,12 @@ struct _mmc_csd {
>  #define EXT_CSD_BKOPS_LEVEL_2		0x2
>=20
>  /*
> + * PRODUCTION STATE AWARENESS fields
> + */
> +#define EXT_CSD_PSA_NORMAL		0x00
> +#define EXT_CSD_PSA_POST_SOLDERING_WRITES	0x02
> +
> +/*
>   * MMC_SWITCH access modes
>   */
>=20
> --
> 2.1.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org More majordomo inf=
o at
> http://vger.kernel.org/majordomo-info.html
