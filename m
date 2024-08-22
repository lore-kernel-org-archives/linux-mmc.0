Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145ED1C93B2
	for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724327587; cv=none; b=QHKuhI/z+W39uRGJoHVw/3NP3Cnh1LcUJ4fEX0hVjg3FlDYQkUBMqhufKdD2yzgZvh9FtngKZYKOgXQdrWh1XoD1lvILg6raltCd7blpXTNGaIfIPXHbl6y+Dhz9yM8HZzXHQ1WG8/j9XSFrSPODfRN7y9SbKrDzgNkocopST8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724327587; c=relaxed/simple;
	bh=C+kNv2237qOL+rsOONunOS+e582/xAnI7+4M+Owlmrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H4si1u4d6vIcOywEzByTfIm479Zf+avDsxJZyA0HFI/SZsCFYHxmRlucJLP/ojsMQV+u/fzMFxRVUHbv/gzr7BLPJCVQMp5mqG1oo9lTiqBV12TVdTLzTl6PznjWh0EQNxa5rS7vsFqDllJFtWEtUhkJpZ5MKoXuCJtHwLMdWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iy1opJRv; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iy1opJRv"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e1161ee54f7so821353276.2
        for <linux-mmc@vger.kernel.org>; Thu, 22 Aug 2024 04:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724327585; x=1724932385; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+4xiglxxiaxUidUD2tLbGcF5hIfbs7sd/+hFSmPwUKw=;
        b=Iy1opJRvl5+LO1tfeImZMknDrV2JzKCvIHVVqOg8eqFlywI4vrQRuTjsxkXa6c/3IY
         pziui+duQLrIdtPPv7yQwnhMxz7Jp6blXwJ77FLcBYwy94ixTFrfKKik4zIYhK2gBU1A
         w8DFWYPPBpwXic00043XD4amqcyIEsTA2Cl8XAT+MHeRxvQXC2KEHT5Qd/wWB4y1qK5P
         Xv6JMZyWz2MhNox3uIh0NH/IvKfoxzFPsBo0JxrKvGxB9KSBWBLN3b8Z32Rpb4pvEj9R
         bUF9/jNSWmw4Z1ZZJscYsNaUsxwiNHRxf3em5wzTojM5QpAKIgfxzMtxawInsGFTdFkB
         OwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724327585; x=1724932385;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+4xiglxxiaxUidUD2tLbGcF5hIfbs7sd/+hFSmPwUKw=;
        b=QzNFdMWaw34NLyTkdBlamFnEVM59iffuovitMyPOnY47dJiZvvBLAF25Afoky0R2nf
         van+A96lP7qgGPptUFoXLr/FqYW8u7SWLKXLL1m1NyfjXcmUVrUJtJO87/xWBUziXHWZ
         3hngzH+QMErCFJrvxbb8WKfyQSnAJxOnEcmnSdsXFy1tujNnCJw3kOdrzSYsERhO7DJg
         +2UsYZXOS6hSnaFNMOvMp1kQ6bBjD34p3UAig0/5oCc4UR/cZqlHDYcwspKCxpQKW/ax
         vupfoD8sToX4yfusmHHTKoNYltshv/MdrRemS4oNtZlzbPY2RDZJ23v9xwAPmPyUTN0v
         opvw==
X-Gm-Message-State: AOJu0YyfV60ZEELMVoNjpu5yv6FHLwAp6YIAE+S9AaRyiimiAY4oEjsx
	mheGMuyieGTjT/7jsYEslWc+KI5362b/PiUDur1nqzaK99Wr7PZDL/TRKBNTKeqcDunRu7Ipdql
	F/nX7EXyG+ZglWY1zE9jte7+JFUsIMkt6K3UTtg==
X-Google-Smtp-Source: AGHT+IGHPCw3W7RgjLYkUhbPPw8zTQVZvm/uRMY9JyAcTrvwPDMCfiNxXeIQ5aVjOfPKFB2PZMozqXhruHrz0m+Rxxg=
X-Received: by 2002:a05:6902:2002:b0:e0b:1191:3cb3 with SMTP id
 3f1490d57ef6-e16666b2978mr5768182276.38.1724327584987; Thu, 22 Aug 2024
 04:53:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814072934.2559911-1-avri.altman@wdc.com> <20240814072934.2559911-4-avri.altman@wdc.com>
In-Reply-To: <20240814072934.2559911-4-avri.altman@wdc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Aug 2024 13:52:28 +0200
Message-ID: <CAPDyKFqboXgBtK8uEV+17r5N+4GWgvL6e_wgLBztCaBDs2Ws9w@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] mmc: sd: Add Extension memory addressing
To: Avri Altman <avri.altman@wdc.com>
Cc: linux-mmc@vger.kernel.org, Ricky WU <ricky_wu@realtek.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Aug 2024 at 09:31, Avri Altman <avri.altman@wdc.com> wrote:
>
> SDUC memory addressing spans beyond 2TB and up to 128TB.  Therefore, 38
> bits are required to access the entire memory space of all sectors.
> Those extra 6 bits are to be carried by CMD22 prior of sending
> read/write/erase commands: CMD17, CMD18, CMD24, CMD25, CMD32, and CMD33.
>
> CMD22 will carry the higher order 6 bits, and must precedes any of the
> above commands even if it targets sector < 2TB.
>
> No error related to address or length is indicated in CMD22 but rather
> in the read/write command itself.
>
> Tested-by: Ricky WU <ricky_wu@realtek.com>
> Signed-off-by: Avri Altman <avri.altman@wdc.com>
> ---
>  drivers/mmc/core/sd_ops.c | 15 +++++++++++++++
>  drivers/mmc/core/sd_ops.h |  1 +
>  include/linux/mmc/sd.h    |  3 +++
>  3 files changed, 19 insertions(+)
>
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 7f6963dac873..8b69129d7b61 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -199,6 +199,21 @@ int mmc_send_app_op_cond(struct mmc_host *host, u32 ocr, u32 *rocr)
>         return 0;
>  }
>
> +int mmc_send_ext_addr(struct mmc_host *host, sector_t addr)
> +{
> +       struct mmc_command cmd = {
> +               .opcode = SD_ADDR_EXT,
> +               .arg = (u32)((addr >> 32) & 0x3F),
> +               .flags = MMC_RSP_R1 | MMC_CMD_AC,
> +       };
> +
> +       if (!mmc_card_is_sduc(host))
> +               return 0;
> +
> +       return mmc_wait_for_cmd(host, &cmd, 0);
> +}
> +EXPORT_SYMBOL_GPL(mmc_send_ext_addr);

Why is this exported?

I was thinking that it should only be the mmc core (not the mmc block
device driver) that needs to keep track of how the card should be
addressed. In that case, why is the EXPORT_SYMBOL_GPL needed?

Oh well, I guess I need to look at the following patches in the series
to understand better.

> +
>  static int __mmc_send_if_cond(struct mmc_host *host, u32 ocr, u8 pcie_bits,
>                               u32 *resp)
>  {
> diff --git a/drivers/mmc/core/sd_ops.h b/drivers/mmc/core/sd_ops.h
> index 7667fc223b74..462efd43acfa 100644
> --- a/drivers/mmc/core/sd_ops.h
> +++ b/drivers/mmc/core/sd_ops.h
> @@ -21,6 +21,7 @@ int mmc_send_relative_addr(struct mmc_host *host, unsigned int *rca);
>  int mmc_app_send_scr(struct mmc_card *card);
>  int mmc_app_sd_status(struct mmc_card *card, void *ssr);
>  int mmc_app_cmd(struct mmc_host *host, struct mmc_card *card);
> +int mmc_send_ext_addr(struct mmc_host *host, sector_t addr);
>
>  #endif
>
> diff --git a/include/linux/mmc/sd.h b/include/linux/mmc/sd.h
> index 865cc0ca8543..af5fc70e09a2 100644
> --- a/include/linux/mmc/sd.h
> +++ b/include/linux/mmc/sd.h
> @@ -15,6 +15,9 @@
>  #define SD_SEND_IF_COND           8   /* bcr  [11:0] See below   R7  */
>  #define SD_SWITCH_VOLTAGE         11  /* ac                      R1  */
>
> +/* Class 2 */
> +#define SD_ADDR_EXT             22   /* ac   [5:0]              R1  */
> +
>    /* class 10 */
>  #define SD_SWITCH                 6   /* adtc [31:0] See below   R1  */
>
> --
> 2.25.1
>

Kind regards
Uffe
