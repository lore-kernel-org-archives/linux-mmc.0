Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9A925D538
	for <linux-mmc@vger.kernel.org>; Mon,  9 Jun 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479146; cv=none; b=mbXjB5D/5dhj1K3wovXmt6NZ6B9Lu43btCxVTOjOofV/Odg5Jb3XvefFr+p6AYh8lragYtkpnotpPr0gM1JvZSEkLSaH3sBfBSZFkaI4pNy42rsC3aOpySIVQBaJqDmg6+nmAaKlPJBkMPI+DEF7X2kDCLAHaNl7IccMM37fuC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479146; c=relaxed/simple;
	bh=JembqEDnPfh2VIA0GR9xZmb2kn3DMblLdpcQQYVBcIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YuNlk0XnhmTWZIosgfJ1Vj7GYCuvTeLNtAqlLef5aEma4kyRiBoCmUTSzd4ElCqBKMzWhI60Ptcx7/n2sbDh3PDfY8CfebfSCYm+IdJ2pjlsCC+HGZjV2XM6G0702/qaYLCXlG7bGcbQhwwkt/QLA2FtrvmHAqukG935MRCFZ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EnSvZPhF; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnSvZPhF"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e7dc89108bfso3563026276.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jun 2025 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749479143; x=1750083943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kzdfsvEKoVL0JlUZYzUNHs+G1k04M6kNna6qKIJw/N4=;
        b=EnSvZPhFWf3yLKSOojCeqZrs2eU49KNiKtKahw7FbA4HP51vqJrojYKVAIexxPa+fF
         BXCmcrlHq+QWlLCmc4YZ0NgDEKJFd+aYdhSziKjd9ZP5JBbNG6pWVIgl6nW2j/HnlYkN
         q5odvyeGLxZ4r+CS0t8JQ2xX0mTH4Vk0SLBLLT3vN+bgvXeejQ3W6ER+TnBbKGqnv95o
         fUnmyHPbyIklAwljECYvN3H6faTKT3w2hGvhoROqRR4uzGgscSszcdAUYEjoenLbrtTJ
         4pMvSJlARbwQ272aPfJS95A9MMYz44ba4Sbap9v8UTuKlckJxRdGEG1IPmlsjQuIOVJM
         2oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749479143; x=1750083943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzdfsvEKoVL0JlUZYzUNHs+G1k04M6kNna6qKIJw/N4=;
        b=YdgYPR8GKhq5KJW8LjtABeekKo+56X42ntHv02jUH2LZgRwk2QRhNSgMGpWo1o40hP
         IHORFBcbsSwHohEri3fWPOwy9X4w59/dMXIlhP27EEddjOsIXUD+ARJcRORN41mB2SDs
         h/uxVkLEB7MhqFolkQn6K2X2n0oHqh+yIcnaugtIEPFHE906Hc+E7j8lE8/Fj9yNxNzO
         eXVckQFTTv11+Wxg+Wy9cYd+YmFbpVEayGc6EbNIKkrVvWFPv38rB7T7QsCWmcovN6ka
         vkbWj0XELcBAF8NJkdD++AFTKeF5tcB90W+s07LU0v4vlse6h59Pm6XBxPWlhGQdvlMY
         OSNw==
X-Gm-Message-State: AOJu0YyVQvrx5s7U1DB+zQpiCR52ZNX8yyNHo1GybsQ0DYtRCivxkGKq
	akMqqc4j35xQhqdzxf4ZkOXdSP7n83RCO3C6MoIrPQFt3SEOOUC1OwensmHkIXZIZt9svejDyfZ
	u0GJkSbz9syKuj17zY8/hEC6nA48FmMcpph9iyDowBw==
X-Gm-Gg: ASbGncvHL6H5hboIWhPTbJ/2aHCorZwjcVrhRzxVFEhYehJxtluaN0tbOLOtOlG1rzY
	xRPLNJqk/v/ep7Zwf3XvjkgWzaJ+pwqZMeK8CQHpbFJXmYd6DlDrV5xouOguWxe6rYjagetwuz3
	FdduQQkzxm7QEdqjSpL+E6iRit382d2agajg==
X-Google-Smtp-Source: AGHT+IG2HLdvbnxpZe5SlTc13La28qz/TTvT3V0gP1+rVEn7gv/MG3ut8oNriSko0ei9/cjAWdSH5AWw1B+pvvtkfTs=
X-Received: by 2002:a05:6902:1884:b0:e81:891e:9628 with SMTP id
 3f1490d57ef6-e81a227ca7amr17811028276.10.1749479142932; Mon, 09 Jun 2025
 07:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526114445.675548-1-avri.altman@sandisk.com>
In-Reply-To: <20250526114445.675548-1-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Jun 2025 16:25:07 +0200
X-Gm-Features: AX0GCFvgU7bcLOda429ePjzI3MwknDGYJdfbakJENxHfVdHS1d_GKrzXTjkaoks
Message-ID: <CAPDyKFrDNqkFAOx8yF+jW3NOA+J5M7e77MT91aRxsG8Mozq7bg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 May 2025 at 13:50, Avri Altman <avri.altman@sandisk.com> wrote:
>
> Move the BROKEN_SD_DISCARD quirk for certain SanDisk SD cards from the
> `mmc_blk_fixups[]` to `mmc_sd_fixups[]`. This ensures the quirk is
> applied earlier in the device initialization process, aligning with the
> reasoning in [1]. Applying the quirk sooner prevents the kernel from
> incorrectly enabling discard support on affected cards during initial
> setup.
>
> [1] https://lore.kernel.org/all/20240820230631.GA436523@sony.com
>
> Fixes: 07d2872bf4c8 ("mmc: core: Add SD card quirk for broken discard")
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>
> Cc: stable@vger.kernel.org

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
>  - rebase on latest next
> ---
>  drivers/mmc/core/quirks.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 7f893bafaa60..c417ed34c057 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -44,6 +44,12 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
>                    0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
>                    MMC_QUIRK_NO_UHS_DDR50_TUNING, EXT_CSD_REV_ANY),
>
> +       /*
> +        * Some SD cards reports discard support while they don't
> +        */
> +       MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
> +                 MMC_QUIRK_BROKEN_SD_DISCARD),
> +
>         END_FIXUP
>  };
>
> @@ -147,12 +153,6 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> -       /*
> -        * Some SD cards reports discard support while they don't
> -        */
> -       MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
> -                 MMC_QUIRK_BROKEN_SD_DISCARD),
> -
>         END_FIXUP
>  };
>
> --
> 2.25.1
>
