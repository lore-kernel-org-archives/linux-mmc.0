Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED8229D0C
	for <linux-mmc@vger.kernel.org>; Fri,  9 Aug 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723197245; cv=none; b=hVXMdMz912sJaiaOlUp2GiCiGpMkzI3aybB4CdKCIzdiBL4VaGbKOok1T23Y3RrsyFNoKHGzeicDx1PfaRmERQCPCM0V1Xvx2CVckJUI3Rg0v4tYHqRCl2RC05f8NuPSAwUEn1jp4eoGcg4wrywCMBZJ0xstnzmU1pNufmgDrNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723197245; c=relaxed/simple;
	bh=JBF5qBJsfmPt/VcVX6b3wNYYqqgl6iT2jGkDa8CcLDw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nw95gaOFVM4D5lLgSdOLG7RIhUKxVul5CroUERfDbhtiG6MMTv0h19cV05sR1VFDXT1n36z369EZZ8NlAdAhvkIfCNgExPS0awBEN14WZVM45m3W16DnJQ2nA6rgenEvhQk+b5aHqfiTSPzpp82UdHMiRPGDqNAlC53Ym780u3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=hq2Z4KJ6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="hq2Z4KJ6"
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4799rvmJ7647734, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723197237; bh=JBF5qBJsfmPt/VcVX6b3wNYYqqgl6iT2jGkDa8CcLDw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hq2Z4KJ6yaYGgc5COsP6Xev7MWra+WffLIkJ/H1CkuWbMhIxCpx2YWv3tyjtiarWx
	 wS3o7/FeNwQ+EHOmlGk8Rji94elOMW+JITTl7bVtuBKaP9i33IW+9MKbPVB6ZViLsa
	 cmLCan7Gd490BuHoSq1gFakjbSlJnGW53YtY5jo0DxNkeae1Szi4us6UROLcsUmF/G
	 aLnDp0uLETZH/Pb5++/gbZoDBrDAZTqb/Q6Plw5GhmiDaauTaomN64BliKI6js/YQu
	 6KdWyPdtjTKuJXTJDgNyEszyww03xukrWzZO1U9qkdh47khuY0zGin8tMljj9h+hdH
	 Y2Yb1fun5ZlvQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4799rvmJ7647734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 17:53:57 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 17:53:58 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Aug 2024 17:53:57 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::2c08:7dc1:82be:6c38]) by
 RTEXMBS01.realtek.com.tw ([fe80::2c08:7dc1:82be:6c38%5]) with mapi id
 15.01.2507.035; Fri, 9 Aug 2024 17:53:57 +0800
From: Ricky WU <ricky_wu@realtek.com>
To: Avri Altman <avri.altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2 01/10] mmc: sd: SDUC Support Recognition
Thread-Topic: [PATCH v2 01/10] mmc: sd: SDUC Support Recognition
Thread-Index: AQHa6I+0Eks83+1Lf0iafVu12MZRZrIeqUMA
Date: Fri, 9 Aug 2024 09:53:57 +0000
Message-ID: <9353f3aec3e846dd9075ada858d44fd4@realtek.com>
References: <20240807060309.2403023-1-avri.altman@wdc.com>
 <20240807060309.2403023-2-avri.altman@wdc.com>
In-Reply-To: <20240807060309.2403023-2-avri.altman@wdc.com>
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

>=20
> ACMD21 was extended to support the host-card handshake during initializat=
ion.

Is ACMD41?

> The card expects that the HCS & HO2T bits to be set in the command
> argument, and sets the applicable bits in the R3 returned response.  On t=
he
> contrary, if a SDUC card is inserted to a non-supporting host, it will ne=
ver
> respond to this ACMD21 until eventually, the host will timed out and give=
 up.
>=20
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/sd_ops.c | 19 +++++++++++++++----
> include/linux/mmc/host.h  |  6 ++++++
>  include/linux/mmc/sd.h    |  1 +
>  3 files changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c index
> 8b9b34286ef3..7f6963dac873 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -168,12 +168,16 @@ int mmc_send_app_op_cond(struct mmc_host *host,
> u32 ocr, u32 *rocr)
>                 .cmd =3D &cmd
>         };
>         int err;
> +       u32 sduc_arg =3D SD_OCR_CCS | SD_OCR_2T;
>=20
>         cmd.opcode =3D SD_APP_OP_COND;
> +       cmd.arg =3D ocr;
> +
>         if (mmc_host_is_spi(host))
> -               cmd.arg =3D ocr & (1 << 30); /* SPI only defines one bit =
*/
> +               cmd.arg &=3D (1 << 30); /* SPI only defines one bit */
>         else
> -               cmd.arg =3D ocr;
> +               cmd.arg |=3D sduc_arg;
> +
>         cmd.flags =3D MMC_RSP_SPI_R1 | MMC_RSP_R3 | MMC_CMD_BCR;
>=20
>         err =3D __mmc_poll_for_busy(host, SD_APP_OP_COND_PERIOD_US,
> @@ -182,8 +186,15 @@ int mmc_send_app_op_cond(struct mmc_host *host,
> u32 ocr, u32 *rocr)
>         if (err)
>                 return err;
>=20
> -       if (rocr && !mmc_host_is_spi(host))
> -               *rocr =3D cmd.resp[0];
> +       if (!mmc_host_is_spi(host)) {
> +               if (rocr)
> +                       *rocr =3D cmd.resp[0];
> +
> +               if ((cmd.resp[0] & sduc_arg) =3D=3D sduc_arg)
> +                       host->caps2 |=3D MMC_CAP2_SD_SDUC;
> +               else
> +                       host->caps2 &=3D ~MMC_CAP2_SD_SDUC;

I think host->caps2 is for host to claim caps, here can just call mmc_card_=
set_ult_capacity?=20
Don't need to wait csd, because SDXC and SDHC need to identify by capacity,=
 but SDUC can be identified here
And all your mmc_card_is_sduc() I think change to mmc_card_ult_capacity() t=
o know the card type

> +       }
>=20
>         return 0;
>  }
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h index
> 88c6a76042ee..a9c36a3e1a10 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -427,6 +427,7 @@ struct mmc_host {
>  #define MMC_CAP2_CRYPTO                0
>  #endif
>  #define MMC_CAP2_ALT_GPT_TEGRA (1 << 28)       /* Host with eMMC
> that has GPT entry at a non-standard location */
> +#define MMC_CAP2_SD_SDUC       (1 << 29)       /* SD over 2TB */
>=20
>         int                     fixed_drv_type; /* fixed driver type for
> non-removable media */
>=20
> @@ -638,6 +639,11 @@ static inline int mmc_card_uhs(struct mmc_card
> *card)
>                 card->host->ios.timing <=3D MMC_TIMING_UHS_DDR50;  }
>=20
> +static inline int mmc_card_is_sduc(struct mmc_host *host) {
> +       return host->caps2 & MMC_CAP2_SD_SDUC; }
> +
>  void mmc_retune_timer_stop(struct mmc_host *host);
>=20
>  static inline void mmc_retune_needed(struct mmc_host *host) diff --git
> a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h index
> 6727576a8755..865cc0ca8543 100644
> --- a/include/linux/mmc/sd.h
> +++ b/include/linux/mmc/sd.h
> @@ -36,6 +36,7 @@
>  /* OCR bit definitions */
>  #define SD_OCR_S18R            (1 << 24)    /* 1.8V switching request
> */
>  #define SD_ROCR_S18A           SD_OCR_S18R  /* 1.8V switching
> accepted by card */
> +#define SD_OCR_2T              (1 << 27)    /* HO2T/CO2T - SDUC
> support */
>  #define SD_OCR_XPC             (1 << 28)    /* SDXC power control */
>  #define SD_OCR_CCS             (1 << 30)    /* Card Capacity Status */
>=20
> --
> 2.25.1

