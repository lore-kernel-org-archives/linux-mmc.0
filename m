Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E903A1D07
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882620; cv=none; b=kMOGmz0FDkdLebP4xGt8qJkt6PIeMSeuwpOgHy8NohkGY5JmLUXw6uGE3bVuWZJoN/ZtttheuSqipZeM75mzyNZAcItWLvVnbYIR8TWATymkmQEV7ktTxPTc9Bz9vvI8SMUDX2JAMA/w3K3SittJd6LUFNecILF1FQZmMye7To0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882620; c=relaxed/simple;
	bh=vAzSLybegI34mYow0nOF+AgqVR3sJdZCFtQPvXm+V/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YAllDdVcoAqQW4sjlrJYLDXe8n6wWRCSNjmSnpWUb2NgfvNrqevSrN5etmN55vqw8nk17QwJXMTDvYTeOcYDi7hM2Km8KBUcVMlfLe+6UjllqflnXEk0qlNSMvcv+PHPyhnN2EaBNo3kU5tLU+rPbVsgxfhlWB0OKFqomb3ae44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R0onX8Zr; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R0onX8Zr"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-640f2c9ccbdso1643928d50.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762882618; x=1763487418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WKx52tDU9fE/jrn3OSl+5XufPAN8oICm0eZEtZIfSXw=;
        b=R0onX8Zr6/fKZXOfy5nA4CC1ORYsPHUs9p/S9HNggV4Yk6aBrNWjL0R4jtI+DkAfGh
         zjXCuDVaH+dHpK5N5PDhkhvKihbSiBwqziN0vfSU9vwA56UgtEbftQMGgW51kGNRc48T
         Gw1Rg9aAVAfKyvaLBL5VR+oX+I+oqxVPbSXetW64tG4agjnq6roXR+XPcglRwID9PZ6w
         ZVzdAUJNkXBuNHOGnfTFeTdvfiTQPXQxnw0iPWs37la+/VC5GIIxNQyPB9eVdI2dENyK
         8zZGzlq7Y/75HLsig8EaW4aArkTDA7/8CdpxNZ5ucTEK4dWejDHej9j/jlJWZ7NtU9v+
         VsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882618; x=1763487418;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKx52tDU9fE/jrn3OSl+5XufPAN8oICm0eZEtZIfSXw=;
        b=FFKnrkiw/3y2HZWYDnr45Uk7udH6KSbqbrFMrL53chqYU7wce2+TCvPuaWWeMo5INw
         KpcAPV+egtpK8OE+q527tHHX+h9IcTrFfkS4qgcnGixqch9wz2xX9Uh0jn0u4/4mgYRR
         gldAUaPZNlWIllKlD1+voTBDtpFLfEGsl4lqK55sKb9i6TaDYBdsbbREqPrzHSqsm5TE
         AId7m/gsaeL12aYwIYhKCN9v2anZsVugCpc87719P/lXooEcvEZCy0RTiPlOZWp8HHp6
         UyivwXpWrP9xQyx/W/Vrgu4YEKz/Cve3SibfTBEbnMslFqNsSBpUfN7xKP7SrmFhrNOY
         Pqcw==
X-Gm-Message-State: AOJu0YzR9ETFTL6/B8RzirXe1kpdUEnY4kn6CEVBNhul/6Tk1r9uPROR
	u2PGJCsvk7nHRXDnm/C8kCT8ISb0RSMRm1br+0IoQ5TLZTzwN1lN88hqgjPiOB5qgzaeVpdqTo4
	xXK6Psg74mNDnkV48rnTftySUjKk3X0mm+GOllVdeZ2+93l+VFSLr
X-Gm-Gg: ASbGncuKLTNLhEVJxMocWv7j74wNdr17bt/W2Sxhi+blwCM/ggVgcy2ByymI/iEcBYa
	dHGIPx5NGTjSfqCENmzBMh0FPfj+hKKtSJiJxQVwyrCBHJgaGdKjYAqNLBgIByaXllAqChavZyc
	+5KSgVc3QcsO329jfJ7HEvhrL+bI4GndgMtFMqNaDKhS0uO3IcQzV7tsFu1m1W3ozOeL9eRlpMP
	NnEaWQlXRXtIRjim9V2DT5mbu0pjkK3pKqCqROy1teJJWsddeJfsH3XerHBNw==
X-Google-Smtp-Source: AGHT+IFG/mW3147rLIk/4ZSa6RQzg77G3xKZhXep2yre7N/p9jZyCCo9N5Fyry2pkzcMfmVVIX2eU862eo/xsY1nodE=
X-Received: by 2002:a05:690c:c36b:b0:784:88df:d8c with SMTP id
 00721157ae682-787d51f294dmr87916837b3.0.1762882617877; Tue, 11 Nov 2025
 09:36:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1762245713-68815-1-git-send-email-shawn.lin@rock-chips.com>
In-Reply-To: <1762245713-68815-1-git-send-email-shawn.lin@rock-chips.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 11 Nov 2025 18:36:22 +0100
X-Gm-Features: AWmQ_bm9Qmf4nXRcTSgPYgCD_FsUOaFbVR88iEZyDK5Bitah05wYL3RN6yXeLZY
Message-ID: <CAPDyKFqmq6Tz+wpeeqiEL7+m+ggkn_kcEx+U07wNQJA7Cw2EZA@mail.gmail.com>
Subject: Re: [PATCH] mmc: debugfs: Allow more host caps to be moodified
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Nov 2025 at 09:42, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> This makes various signal and function tests more convenient
> without the need to modify the DTB.
>
> /sys/kernel/debug/mmc0# echo $(($(cat caps) | (1 << 7))) > caps
> /sys/kernel/debug/mmc0# echo on > /sys/bus/mmc/devices/mmc0\:0001/power/control
> /sys/kernel/debug/mmc0# echo auto > /sys/bus/mmc/devices/mmc0\:0001/power/control
>
> // Disable 8-bit support
> echo $(($(cat caps) & ~(1 << 6))) > caps
> // Enable 8-bit support
> echo $(($(cat caps) | (1 << 6))) > caps
> // Disable 4-bit support
> echo $(($(cat caps) & ~(1 << 0))) > caps
> // Enable 4-bit support
> echo $(($(cat caps) | (1 << 0))) > caps
> // Disable CMD23 support
> echo $(($(cat caps) & ~(1 << 30))) > caps
> // Enable CMD23 support
> echo $(($(cat caps) | (1 << 30))) > caps
> // Disable CMD23 support
> echo $(($(cat caps) & ~(1 << 30))) > caps
> // Enable CMD23 support
> echo $(($(cat caps) | (1 << 30))) > caps
> // Disable CQE support
> echo $(($(cat caps2) & ~(1 << 23))) > caps2
> // Enable CQE support
> echo $(($(cat caps2) | (1 << 23))) > caps2
> // Disable CQE DCMD support
> echo $(($(cat caps2) & ~(1 << 24))) > caps2
> // Enable CQE DCMD support
> echo $(($(cat caps2) | (1 << 24))) > caps2
>
> /sys/kernel/debug/mmc0# echo on > /sys/bus/mmc/devices/mmc0\:0001/power/control
> /sys/kernel/debug/mmc0# cat ios
>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  drivers/mmc/core/debugfs.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
> index f10a4dc..91ea00a 100644
> --- a/drivers/mmc/core/debugfs.c
> +++ b/drivers/mmc/core/debugfs.c
> @@ -315,7 +315,10 @@ static int mmc_caps_set(void *data, u64 val)
>                       MMC_CAP_SD_HIGHSPEED |
>                       MMC_CAP_MMC_HIGHSPEED |
>                       MMC_CAP_UHS |
> -                     MMC_CAP_DDR;
> +                     MMC_CAP_DDR |
> +                     MMC_CAP_4_BIT_DATA |
> +                     MMC_CAP_8_BIT_DATA |
> +                     MMC_CAP_CMD23;
>
>         if (diff & ~allowed)
>                 return -EINVAL;
> @@ -327,7 +330,10 @@ static int mmc_caps_set(void *data, u64 val)
>
>  static int mmc_caps2_set(void *data, u64 val)
>  {
> -       u32 allowed = MMC_CAP2_HSX00_1_8V | MMC_CAP2_HSX00_1_2V;
> +       u32 allowed = MMC_CAP2_HSX00_1_8V |
> +                     MMC_CAP2_HSX00_1_2V |
> +                     MMC_CAP2_CQE |
> +                     MMC_CAP2_CQE_DCMD;
>         u32 *caps = data;
>         u32 diff = *caps ^ val;
>
> --
> 2.7.4
>
