Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9C0190693
	for <linux-mmc@vger.kernel.org>; Fri,  9 Aug 2024 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197248; cv=none; b=my86ikAWhQ4Qm5aSH09eMqL2K2vzmtjACWb1AX/YqcrTSoeedv/zpL/i3ew4XxCps1P0TKo+Wslay5CCGrx2yRKy+7SgpQoCdlO/DwGCyvwgJQQKnx2nvxh2/78TUOIPUVoG3kNkr/7sdeO8objSuGD0P9H18RNndcS6F/x1/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197248; c=relaxed/simple;
	bh=TTLyWM2pf3GLdzjQofESBPppuOs+zN0Xg4I3gtlGsb0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=p0+tWDVtH2jS3H5GsoHnusVbOU1LEiMXc8X9tZxcO7GeUt7AbUtdoxiTLApreJGM/IDfqYUesh5c02FQONRVqx1lhVGHzk4hYG3ppPJyDVc1tmqVf8/ypYD5cL4TJW41fIxlvJg14Dy6Az79uFYEuROoRsm/9hyp+F/xcsxquYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XW6AGMU+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XW6AGMU+"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4799s2apD647749, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723197242; bh=TTLyWM2pf3GLdzjQofESBPppuOs+zN0Xg4I3gtlGsb0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XW6AGMU+YnWFuj/cBMSVIxlUahmqXumfJ/hX7vuK6nxfl4/CamOWBTZFuWwWM6RyI
	 E7ohip70O0jnnsMlj0lkbsqcg707RBMmkNjj7T/Ly4NVyBOvIkoIVd2+Rs3jbhB0fT
	 Mwk/REZPWvC+xr//vAcdyBAw9r19lwJBOECuBEB1t9qtS1AbEGdwjE0psTxcgPIHYw
	 DDg2tN+lbXdCw2iceUzsRHgULlNqO8XuN8quAHSnihmJHwSG+d8JFMvM5hGoH62XuV
	 hQnNt8CJNTWNIW6qr9xWKux+q1FW9SlMaV08zltME5mgz5ONNmEBG2JroDhpVpxOmy
	 //RindCBGOtbg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4799s2apD647749
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 17:54:02 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 17:54:03 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Aug 2024 17:54:02 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::2c08:7dc1:82be:6c38]) by
 RTEXMBS01.realtek.com.tw ([fe80::2c08:7dc1:82be:6c38%5]) with mapi id
 15.01.2507.035; Fri, 9 Aug 2024 17:54:02 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2 03/10] mmc: sd: Add Extension memory addressing
Thread-Topic: [PATCH v2 03/10] mmc: sd: Add Extension memory addressing
Thread-Index: AQHa6I+3SZy1GmYJBkiUztDYYyeimbIerijA
Date: Fri, 9 Aug 2024 09:54:02 +0000
Message-ID: <94bfdd1ab7bb4e998097bb4575b2a821@realtek.com>
References: <20240807060309.2403023-1-avri.altman@wdc.com>
 <20240807060309.2403023-4-avri.altman@wdc.com>
In-Reply-To: <20240807060309.2403023-4-avri.altman@wdc.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> SDUC memory addressing spans beyond 2TB and up to 128TB.  Therefore, 38
> bits are required to access the entire memory space of all sectors.
> Those extra 6 bits are to be carried by CMD22 prior of sending
> read/write/erase commands: CMD17, CMD18, CMD24, CMD25, CMD32, and
> CMD33.
>=20
> CMD22 will carry the higher order 6 bits, and must precedes any of the ab=
ove
> commands even if it targets sector < 2TB.
>=20
> No error related to address or length is indicated in CMD22 but rather in=
 the
> read/write command itself.
>=20
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/sd_ops.c | 15 +++++++++++++++
> drivers/mmc/core/sd_ops.h |  1 +
>  include/linux/mmc/sd.h    |  3 +++
>  3 files changed, 19 insertions(+)
>=20
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c index
> 7f6963dac873..8b69129d7b61 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -199,6 +199,21 @@ int mmc_send_app_op_cond(struct mmc_host *host,
> u32 ocr, u32 *rocr)
>         return 0;
>  }
>=20
> +int mmc_send_ext_addr(struct mmc_host *host, sector_t addr) {
> +       struct mmc_command cmd =3D {
> +               .opcode =3D SD_ADDR_EXT,
> +               .arg =3D (u32)((addr >> 32) & 0x3F),
> +               .flags =3D MMC_RSP_R1 | MMC_CMD_AC,
> +       };
> +
> +       if (!mmc_card_is_sduc(host))
> +               return 0;
> +
I think here can be removed, all mmc_send_ext_addr caller are have if-state=
ment to check the card is SDUC

> +       return mmc_wait_for_cmd(host, &cmd, 0); }
> +EXPORT_SYMBOL_GPL(mmc_send_ext_addr);
> +
>  static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8 pcie_bi=
ts,
>                               u32 *resp)  { diff --git
> a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h index
> 7667fc223b74..462efd43acfa 100644
> --- a/drivers/mmc/core/sd_ops.h
> +++ b/drivers/mmc/core/sd_ops.h
> @@ -21,6 +21,7 @@ int mmc_send_relative_addr(struct mmc_host *host,
> unsigned int *rca);  int mmc_app_send_scr(struct mmc_card *card);  int
> mmc_app_sd_status(struct mmc_card *card, void *ssr);  int
> mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
> +int mmc_send_ext_addr(struct mmc_host *host, sector_t addr);
>=20
>  #endif
>=20
> diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h index
> 865cc0ca8543..af5fc70e09a2 100644
> --- a/include/linux/mmc/sd.h
> +++ b/include/linux/mmc/sd.h
> @@ -15,6 +15,9 @@
>  #define SD_SEND_IF_COND           8   /* bcr  [11:0] See below   R7
> */
>  #define SD_SWITCH_VOLTAGE         11  /* ac
> R1  */
>=20
> +/* Class 2 */
> +#define SD_ADDR_EXT             22   /* ac   [5:0]
> R1  */
> +
>    /* class 10 */
>  #define SD_SWITCH                 6   /* adtc [31:0] See below   R1
> */
>=20
> --
> 2.25.1

