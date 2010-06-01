From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] Recognize CSD structure version 3
Date: Tue, 01 Jun 2010 12:51:30 +0300
Message-ID: <4C04D822.5040208@nokia.com>
References: <20100531064035.GA25269@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:24996 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab0FAJwd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Jun 2010 05:52:33 -0400
In-Reply-To: <20100531064035.GA25269@july>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

Kyungmin Park wrote:
> The eMMC spec 4.4 and 4.3 + additional feature chips has CSD structur=
e version 3

That is not exactly correct.  There is no CSD structure version 1.3.  I=
nstead
there are two fields for CSD structure version.  One in CSD and one in =
Extended CSD.

In CSD there is:

CSD_STRUCTURE [127:126]
Describes the version of the CSD structure.
Table 44 =97 CSD register structure
CSD_STRUCTURE    CSD Structure Version    Valid for System Specificatio=
n Version
0                CSD version No.          1.0 Allocated by MMCA
1                CSD version No.          1.1 Allocated by MMCA
2                CSD version No.          1.2 Version 4.1=964.2=964.3
3                Version is coded in the CSD_STRUCTURE byte in the EXT_=
CSD register

So the 3 does not mean version 1.3 it just means look at Extended CSD i=
nstead.
But the Extended CSD field does not define CSD structure version 3 at a=
ll.

CSD_STRUCTURE [194]
This field is a continuation of the CSD_STRUCTURE field in the CSD regi=
ster
Table 78 =97 CSD register structure
CSD_STRUCTURE    CSD structure version    Valid for System Specificatio=
n Version
0                CSD version No. 1.0      Allocated by MMCA
1                CSD version No. 1.1      Allocated by MMCA
2                CSD version No. 1.2      Version 4.1=964.2=964.3-4.4
3=96255            Reserved for future use

> To probe these chip properly and make it simple.
> it doesn't check CSD structure.
>=20
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 89f7a25..9e42bc6 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -118,15 +118,12 @@ static int mmc_decode_csd(struct mmc_card *card=
)
>  	u32 *resp =3D card->raw_csd;
> =20
>  	/*
> -	 * We only understand CSD structure v1.1 and v1.2.
> +	 * We understand all CSD structure v1.1, v1.2 and v1.3.

This comment is not correct. v1.3 does not exist.

>  	 * v1.2 has extra information in bits 15, 11 and 10.
>  	 */
>  	csd_struct =3D UNSTUFF_BITS(resp, 126, 2);
> -	if (csd_struct !=3D 1 && csd_struct !=3D 2) {
> -		printk(KERN_ERR "%s: unrecognised CSD structure version %d\n",

I don't agree with removing this validation without a reason.  Instead
extend it to 3.

To support the '3' value properly, the Extended CSD CSD_STRUCTURE
field needs to be validated also i.e. in mmc_read_ext_csd() do
something like:


	u32 *resp =3D card->raw_csd;

	if (UNSTUFF_BITS(resp, 126, 2) =3D=3D 3) {
		check ext_csd[194]
	}




> +	printk(KERN_DEBUG "%s: recognised CSD structure version %d\n",
>  			mmc_hostname(card->host), csd_struct);
> -		return -EINVAL;
> -	}
> =20
>  	csd->mmca_vsn	 =3D UNSTUFF_BITS(resp, 122, 4);
>  	m =3D UNSTUFF_BITS(resp, 115, 4);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

