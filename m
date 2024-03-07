Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976BA1272D0
	for <linux-mmc@vger.kernel.org>; Thu,  7 Mar 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709809390; cv=none; b=HC+V4Zlc0UQX7hFlNdDhVuPj4lGStbNEqjdMgcjHIEol32Xi422U8lZln03GO8xIx81RaoHWjfNAh9WQqeJwl/PPIXN/WubptZ2h85aDKl55PKw0b6nY/6oXa4sRb4+nD6v4fRr1muRJHNhTicTWZ7ICwZ9oN7PWBlkurBFWpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709809390; c=relaxed/simple;
	bh=iSor8fZxDh42P0svZ0pXu7l8hnMqZ6b1ZOL44HJXOQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FQgJjUhMVyGJt4oCATM4jeaNPz+7zBNdunX3T0HOu38kJhLxs6e3rHif0lm8lRPU7iI+wIPrvfYTp1YroLDnYASVvxa4icgvVPCY7Jwi3db/Z8n5pAO0xQDVWHN8NjrKHghI6vZzrFAZcKydsvvyCqEhBGX/lurzjpANDTHB1Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ek0urVA7; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ek0urVA7"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso757280276.2
        for <linux-mmc@vger.kernel.org>; Thu, 07 Mar 2024 03:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709809387; x=1710414187; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DP9VurdbY6YRjSA0IQcXwswngGCEJsz7oI4j7t5y+yA=;
        b=Ek0urVA7AY3yz/nsvBhL2tq3kysVhI4ZarNwvOtp6i/nExUqFNbPaxFio8a60QcrxS
         8nG44eGw5xdxNZZMzYVCl+cYSb9E0naO25jH6s0w9GkgR3EnwaTAGa4eRfdUc0TsLIrg
         /kXfAbMzwwEh3vG76aaD8q7LccDkE1Bw9kSTkkyegoIDJ471WnK4aMk52oq7Ve0Y+eYP
         JjrTEhuvSxsjb/99n4cb9hCSnxxvCQ23s0Cx0/b9uvbqbnYpSwrc+ydzZUO8O+LKiHzH
         Bjh4NL8Gjifa5VXVW8x/WovoiE5kjlLqcv1gFPpSlJl2vUuOES3eIKKDVygkDZ1YmDK2
         2tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709809387; x=1710414187;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DP9VurdbY6YRjSA0IQcXwswngGCEJsz7oI4j7t5y+yA=;
        b=I/2xAe5TSdDRvIf0x74uG0XRPIgGKgaQFgUD2KgYYoSMcBkkTRoH6VhpCiemGPITlH
         oZq8Zegon8F+RzSrC3euzaU4SAOycQEueCSBwMlNlvBi5HM9IhwK+Yux+ELCGxpIlVeP
         WVGI2bJdgRtFyKlxmqFLEh14is06O7le6Bb4NoVqv9aAdu/4EtqYta2lT/KVPLnta/Sn
         Qivnp7nHqBEd7zxWUPRuxHUnCJTAw68x12r/QX3tc4unZz1pJPoZLd26aP+HYvH32JD8
         +Qq0scAvTzQ4GZQUzhjWQuf5ukRGfA+X81z3bZzJ0FHP0uLiHK+YN4xaKvyVKd1AJhG7
         hvkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZfed871MLru9PWWWQ+1kS60SV9ySdFNHzyno8zDEE6Xz8i3fWq4bmO9wAFQC0+TWTgUcuS5WYuK7T9RSFZ7guYDNnFCW4v+JF
X-Gm-Message-State: AOJu0YzSEtlcmc7O7VIIQD1yhO6pIzcdxinllofihuNYag1g4jmL05b/
	wd1xxSku+f532eI8eAe/2H/cEV8kfDU1ofsFHcg9fOGL43XIVpyMR1BHbAy3w0ntxoau7/AeXs+
	oX/B5e690PcanUA2LIBKxHoV0LC01IbcjBAkX8A==
X-Google-Smtp-Source: AGHT+IFlC4/zHtgUhdB0INXcF7LfWLDlEfy5VPYE6VTiMjxfZAcn4WVKLiRt+eJm6ctpKwofe7lQNttdYRyrBHiOK7I=
X-Received: by 2002:a25:3009:0:b0:dc6:ff32:aae2 with SMTP id
 w9-20020a253009000000b00dc6ff32aae2mr12377866ybw.63.1709809387540; Thu, 07
 Mar 2024 03:03:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DM6PR04MB657504D3DD4B66F9873E3094FC222@DM6PR04MB6575.namprd04.prod.outlook.com>
 <20240305184513.400364-1-giulio.benetti@benettiengineering.com>
In-Reply-To: <20240305184513.400364-1-giulio.benetti@benettiengineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 7 Mar 2024 12:02:31 +0100
Message-ID: <CAPDyKFrBEK8nKM0ELYQDiE-A1BLG01qZxpuq3PvKMUD+h9NuEA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc-utils: mmc_cmds: fix type-punned warning on
 &ext_csd[] casting
To: Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc: Avri Altman <Avri.Altman@wdc.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 19:52, Giulio Benetti
<giulio.benetti@benettiengineering.com> wrote:
>
> When building with -Werror=strict-aliasing error is thrown:
>
> mmc_cmds.c: In function 'do_ffu':
> mmc_cmds.c:2972:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
>   sect_done = htole32(*((__u32 *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
>   ^
> cc1: all warnings being treated as errors
>
> Let's fix type-punned breaking strict-aliasing by implementing local
> per_byte_htole32(__u8 *) and use it for the 2 present occurences of
> htole32(). Let's also change sect_done type to __u32 for consistency.
>
> Suggested-by: Avri Altman <Avri.Altman@wdc.com>
> Fixes: a1b594ca735e ("mmc-utils: ffu: Simplify ext_csd bytes parsing")
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>

Applied to git.kernel.org/pub/scm/utils/mmc/mmc-utils.git master, thanks!

Kind regards
Uffe

> ---
> V1->V2:
> * implement local per_byte_htole32() as suggested by Avril Altman
> ---
>  mmc_cmds.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index ae7b876..936e0c5 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -58,6 +58,11 @@
>  #define WPTYPE_PWRON 2
>  #define WPTYPE_PERM 3
>
> +static inline __u32 per_byte_htole32(__u8 *arr)
> +{
> +       return arr[0] | arr[1] << 8 | arr[2] << 16 | arr[3] << 24;
> +}
> +
>  int read_extcsd(int fd, __u8 *ext_csd)
>  {
>         int ret = 0;
> @@ -2807,7 +2812,7 @@ static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
>                                __u8 *ext_csd, unsigned int bytes, __u8 *buf,
>                                off_t offset)
>  {
> -       __u32 arg = htole32(*((__u32 *)&ext_csd[EXT_CSD_FFU_ARG_0]));
> +       __u32 arg = per_byte_htole32(&ext_csd[EXT_CSD_FFU_ARG_0]);
>
>         /* send block count */
>         set_single_cmd(&multi_cmd->cmds[1], MMC_SET_BLOCK_COUNT, 0, 0,
> @@ -2827,7 +2832,7 @@ static void set_ffu_single_cmd(struct mmc_ioc_multi_cmd *multi_cmd,
>  int do_ffu(int nargs, char **argv)
>  {
>         int dev_fd, img_fd;
> -       int sect_done = 0, retry = 3, ret = -EINVAL;
> +       int retry = 3, ret = -EINVAL;
>         unsigned int sect_size;
>         __u8 ext_csd[512];
>         __u8 *buf = NULL;
> @@ -2835,6 +2840,7 @@ int do_ffu(int nargs, char **argv)
>         char *device;
>         struct mmc_ioc_multi_cmd *multi_cmd = NULL;
>         unsigned int default_chunk = MMC_IOC_MAX_BYTES;
> +       __u32 sect_done = 0;
>
>         assert (nargs == 3 || nargs == 4);
>
> @@ -2968,7 +2974,7 @@ do_retry:
>         }
>
>         /* Test if we need to restart the download */
> -       sect_done = htole32(*((__u32 *)&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]));
> +       sect_done = per_byte_htole32(&ext_csd[EXT_CSD_NUM_OF_FW_SEC_PROG_0]);
>         /* By spec, host should re-start download from the first sector if sect_done is 0 */
>         if (sect_done == 0) {
>                 if (retry--) {
> --
> 2.34.1
>
>
