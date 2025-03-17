Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518D7157A48
	for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2025 10:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208051; cv=none; b=d8mbcGGhYOyU3Cg6ZLu05S35HFe7CKmjQdoBSah3vKQ1yFIXo/s3+03eMqFsPKTt80aYyZ5JavcO3biEnNBIAUzYufHeSCwspjvcffFEcVhwf8c2AocAYI9J0ukuO68yw3VQrck5hW2pTOVd1qt/UzevzDX18QPdIdVEu1tUVos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208051; c=relaxed/simple;
	bh=BD7IdPNT7Q7GUfTZNOIRSvijwf9O2oc4/VXxFtlXpAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZXgh08ToLZmstzYeSll1SZ6ld1B3O5VSnEXpDV7eE7O2F+beuNGYRbTLiL+cIPpA8YLPOlvGPvJ8XkC2ek+0L3SSX8VSf3QxqZyvVpNzCdfYxQIIweI5N3SpLIEbpz5S5+iha17UQ6XgdcJ6m0o6ds7dzkUaHh5kumzvUF7SHAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lxhGNBdE; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lxhGNBdE"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ff4faf858cso17947527b3.2
        for <linux-mmc@vger.kernel.org>; Mon, 17 Mar 2025 03:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742208048; x=1742812848; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kic7Egg81QcNSM11Ao367YtwTA8BH4eCYMLkgWYIVwg=;
        b=lxhGNBdEvqDPVfQXX9Mnm+bP06MzGLxhxcwahH6dJPELrqBe0E2Ngi22VSfXljTFQI
         EqTxRk3WEAB1XcThqiBaELhm9blyyQst3LimE+YVzjwuJpZaGQs1H1nsaF0YGNE7wOGK
         begtN9vVgDB2q+lBcFZNgcswwf7S0vgqGCfySbF2rsoUjZ4NkZPAKVGtPiL2PpxfSnQZ
         fFKq5Thur9yIrxTB1C3CQE02fDwu6iJQ1jf07X8Ap686hVn17986Cwjhaji64TxpHAoe
         Oe0edjSNkHhMWDykfzjM7N8ys/8lSq7Lxs+eJwUvXIcYVbdSPH1MtR/sgrr38B2EOtnv
         R3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742208048; x=1742812848;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kic7Egg81QcNSM11Ao367YtwTA8BH4eCYMLkgWYIVwg=;
        b=ogE0Xa/Y5lMh8j5db5GMN/77UwsbHEVAavEMBo9G+/NvKcGp7LPySqNCUpc6mSm0yv
         W2gysXZF8q5CtNH17zJgz6FVa1E7TA5sca996Vz50svP6kHI/awvve6BlfGrHAPNPD2+
         N2VboswZysRHaj02VjJYX6ZGxdCLUMwhvfDiPhgMG9k3p9V7ccXKMg/3+GspvGB5arYC
         4Kau/YI/hkE+weLnv2dCcwSAzi9yHcvMQjH/5esrAuMmPh2BK2upMf+7tQNd8ExpjKI0
         SDfikNNkQACk8MrGq8YDAps5/5KnneVPU7/vhYUo1dLasr7pzBlzEoS+qdwiSVd01ztp
         Z8+g==
X-Gm-Message-State: AOJu0Yw1W8F9k0SR7lNNr61oAJG1D2LXpfXOYNQANtGexGfn/fHVY6Rd
	jd4LjbfsFoNmJddsafl1UEkLB6O9Yj+YCZWxjAgLTNquImDA0JJGxvy/iJvFLKN4dxxNnTW5pON
	yhzcPhKNQSGNd3FXF6taL1et3TuGw11aEyQF4gA==
X-Gm-Gg: ASbGncsNYfCJYPwYK/otyET8kRJabXlNkBSZgvzd4dyoT8+NKpj8znP2nTgowpLy1bv
	EWytVYl5Lfujm6/JT3Gix+UAd6o4s5IKvwssCB/FJstTl1wr+W67QKsKbTbLZ55SZrLGZ12q7h2
	1jJTIzKeOgfPhRNFYy5RL/JAQH1L4=
X-Google-Smtp-Source: AGHT+IFzfknDW8LHE2gLcaztAQ20vfekEX1NPpiqD0qTBigDfdvzIZBVOFY26paifbo2z+lowFDLq76GRaCZglinGSg=
X-Received: by 2002:a05:690c:4b8a:b0:6fb:46dc:d9c4 with SMTP id
 00721157ae682-6ff45e9d7d3mr150954127b3.12.1742208048209; Mon, 17 Mar 2025
 03:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314195832.1588159-1-erick.shepherd@ni.com>
In-Reply-To: <20250314195832.1588159-1-erick.shepherd@ni.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 17 Mar 2025 11:40:12 +0100
X-Gm-Features: AQ5f1Joll4KUe38as4TiGrQsdvs-hbbk9e_M0slGJZ3FZIkxtyIrBZsdxhf58GM
Message-ID: <CAPDyKFqrT0zXVRya=sgEOdjmn7D6xb-e+nD9Q4JpVnh1ddu_Fw@mail.gmail.com>
Subject: Re: [PATCH] mmc: Add quirk to disable DDR50 tuning
To: Erick Shepherd <erick.shepherd@ni.com>
Cc: linux-mmc@vger.kernel.org, adrian.hunter@intel.com, keita.aihara@sony.com, 
	linux-kernel@vger.kernel.org, avri.altman@wdc.com, 
	wsa+renesas@sang-engineering.com, jason.lai@genesyslogic.com.tw, 
	jeff.johnson@oss.qualcomm.com, victor.shih@genesyslogic.com.tw, 
	andy-ld.lu@mediatek.com, dsimic@manjaro.org, jonathan@raspberrypi.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 14 Mar 2025 at 20:58, Erick Shepherd <erick.shepherd@ni.com> wrote:
>
> Adds the MMC_QUIRK_NO_UHS_DDR50_TUNING quirk and updates
> mmc_execute_tuning() to return 0 if that quirk is set. This fixes an
> issue on certain Swissbit SD cards that do not support DDR50 tuning
> where tuning requests caused I/O errors to be thrown.
>
> Signed-off-by: Erick Shepherd <erick.shepherd@ni.com>
> ---
>  drivers/mmc/core/card.h   |  1 +
>  drivers/mmc/core/core.c   |  4 ++++
>  drivers/mmc/core/quirks.h | 10 ++++++++++
>  include/linux/mmc/card.h  |  1 +
>  4 files changed, 16 insertions(+)
>
> diff --git a/drivers/mmc/core/card.h b/drivers/mmc/core/card.h
> index 3205feb1e8ff..756f80024635 100644
> --- a/drivers/mmc/core/card.h
> +++ b/drivers/mmc/core/card.h
> @@ -89,6 +89,7 @@ struct mmc_fixup {
>  #define CID_MANFID_MICRON       0x13
>  #define CID_MANFID_SAMSUNG      0x15
>  #define CID_MANFID_APACER       0x27
> +#define CID_MANFID_SWISSBIT     0x5D
>  #define CID_MANFID_KINGSTON     0x70
>  #define CID_MANFID_HYNIX       0x90
>  #define CID_MANFID_KINGSTON_SD 0x9F
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5241528f8b90..8962992f05aa 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -937,6 +937,10 @@ int mmc_execute_tuning(struct mmc_card *card)
>         if (!host->ops->execute_tuning)
>                 return 0;
>
> +       if ((card->quirks & MMC_QUIRK_NO_UHS_DDR50_TUNING) &&
> +           host->ios.timing == MMC_TIMING_UHS_DDR50)
> +               return 0;
> +

Please move this to mmc_sd_init_uhs_card() instead. Moreover, please
add a helper in drivers/mmc/core/card.h for
MMC_QUIRK_NO_UHS_DDR50_TUNING, similar to other quirks.

>         if (host->cqe_on)
>                 host->cqe_ops->cqe_off(host);
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 89b512905be1..7f893bafaa60 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -34,6 +34,16 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
>                    MMC_QUIRK_BROKEN_SD_CACHE | MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY,
>                    EXT_CSD_REV_ANY),
>
> +       /*
> +        * Swissbit series S46-u cards throw I/O errors during tuning requests
> +        * after the initial tuning request expectedly times out. This has
> +        * only been observed on cards manufactured on 01/2019 that are using
> +        * Bay Trail host controllers.
> +        */
> +       _FIXUP_EXT("0016G", CID_MANFID_SWISSBIT, 0x5342, 2019, 1,
> +                  0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
> +                  MMC_QUIRK_NO_UHS_DDR50_TUNING, EXT_CSD_REV_ANY),
> +
>         END_FIXUP
>  };
>
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index 526fce581657..ddcdf23d731c 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -329,6 +329,7 @@ struct mmc_card {
>  #define MMC_QUIRK_BROKEN_SD_CACHE      (1<<15) /* Disable broken SD cache support */
>  #define MMC_QUIRK_BROKEN_CACHE_FLUSH   (1<<16) /* Don't flush cache until the write has occurred */
>  #define MMC_QUIRK_BROKEN_SD_POWEROFF_NOTIFY    (1<<17) /* Disable broken SD poweroff notify support */
> +#define MMC_QUIRK_NO_UHS_DDR50_TUNING  (1<<18) /* Disable DDR50 tuning */
>
>         bool                    written_flag;   /* Indicates eMMC has been written since power on */
>         bool                    reenable_cmdq;  /* Re-enable Command Queue */
> --
> 2.43.0
>

Other than the minor things above, this seems reasonable to me!

Kind regards
Uffe
