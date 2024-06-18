Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9736933FD
	for <linux-mmc@vger.kernel.org>; Tue, 18 Jun 2024 05:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718689092; cv=none; b=Ulpx/Jz+RJYsOckyQ5O7BCRCp0oiKq2U5OZNDtVE3QQFg+JKWVhotob7K0lak67Rrw890KEf4V14bZnTXQAWUl0cNQySDroLcqUF485rXJXAQ06X6Ez26kThw9kNZR7X485Zc3N5r2gE2sk8+jReZytRG8YyJyoLP/f1hf4kFKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718689092; c=relaxed/simple;
	bh=RJ8Vb4QiKHul8qKmlwqbnSJUFspoEYMgKUjvEIcQHbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TbP3HVUTifJifV9kLQOY2aH6kPsjZGUr/upAAqOGGxLC1A3Dlgx9DgEU7hR6jVsMuMdZDBy5RhWRFJolYvN5SObiTlLmz6Io2/oST9UKwV8Jy8KateHP+Hs0rbUYaO1VU8C6HZLFKSZ0XAFoWPh3ZZE2adTJ0z/3HxhAxyas85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDsooNTT; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDsooNTT"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-6e3741519d7so3513965a12.2
        for <linux-mmc@vger.kernel.org>; Mon, 17 Jun 2024 22:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718689089; x=1719293889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZTo0beYYNrX/6yfhSA+PDXaKUFWMwnLJRIj6pIvC2KA=;
        b=lDsooNTTTNVXh8XF0wUxTyEY9ilLV/gNCvrUswWie9xL19TrqrGu3J5cpu/xF+1hOU
         yfJHx+k80UtZ/O8yHAbHMWiav8mKZU0kpt80ZQtZD/vkA0cM1rdArN0nXv6+WJvjLBej
         sHTL1GNfEDurKaKFi+fcuCrzw0RP3qbiOlMVBj5eU66mBbbrp6xbYWQJjhUG98lMkfmS
         +zMJl5bLIwqCdzREH7jVqV5Nj8sCHjyBJDNCvVZPOyUVcn3NQs3RJIW3uNAmxUi/nUiG
         UDEcXbQq7pzNnZY+CEPuz4zzpMxE83oid7JqtlpGP21k99ed6EEBq0/WzZ+iLG84QOvS
         wJfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718689089; x=1719293889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZTo0beYYNrX/6yfhSA+PDXaKUFWMwnLJRIj6pIvC2KA=;
        b=QGmqkUmu5eXrV49jynlRlx/aDomTLw+VBxWFNA2AocLnZR3DHnJ9iChUj8B5YN1U7N
         qQ+CfC0pY+dQk29uCP10Irz0rRhHP95vuy88/OcpJu5zydNVTFnGd/CjoAJaOg+7o/St
         NZbKxpFEHQtxEhB6p8S3Hna0dkHDCHRyg/qlvDEIOJwXObKYCbw2mNPMVlSOKWHi7yTA
         9fJrifCpuxGH4cwIyuesdkzLWcdcYYYYJp+0KA5fpos2KbEFOZqZCC9TmOyGsipRNxut
         VumRpLLYqKSxK47woyp3Y65u1A5E28DijQYrIR68agUswM4phMxTw3Jl6QXdg/Cpuf+N
         ZJsw==
X-Gm-Message-State: AOJu0YwX+D13kUU7i9NkK0VzPc2SR/CCOZtLB8hTJ2l/gt4XTYlHaWXT
	YL3MUQa8uSD5876f3es4DJqOAv1AS5VYSbv5tyxpDyvFVkPK4iyyl8F42fadK9JiXwQne9m/jTj
	m/tD1/lIBhUywhAsZCovUWpL3K1qdgw==
X-Google-Smtp-Source: AGHT+IG/J2jZT9+dhfxOfkzpZRR3KAQUslAcztLT1pcnaKRqYBl6dTf7+YrH2eEV/Ri+kuqFXgwFm/BfAFZMIF8RZbY=
X-Received: by 2002:a05:6a20:cf8b:b0:1b8:6bd9:b8ad with SMTP id
 adf61e73a8af0-1bae823dcb1mr10839091637.42.1718689089472; Mon, 17 Jun 2024
 22:38:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABqN7BxTNMFz5hxPePYV0sM02XwRsv+g7Siw-ZKZ7_X++H0JtQ@mail.gmail.com>
In-Reply-To: <CABqN7BxTNMFz5hxPePYV0sM02XwRsv+g7Siw-ZKZ7_X++H0JtQ@mail.gmail.com>
From: Zhan Liu <liuzhanjobs@gmail.com>
Date: Mon, 17 Jun 2024 22:37:32 -0700
Message-ID: <CABqN7ByLAm7rB=wq07AoL2A1o2-Tz=rqmP-Ctf1SS8uQYeor7Q@mail.gmail.com>
Subject: Re: [PATCH v1] mmc-utils: FFU Status check for device without FW
 install support
To: linux-mmc@vger.kernel.org
Cc: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have submitted this patch on Apr 19, 2024. However, I have never got
any reply etc. and now I did not see this in the patch list (even if I
search any patch under my name). therefore, it not rejected, approved
etc. It just disappeared. Can you please let me what is going on?

Regards,

Zhan

On Fri, Apr 19, 2024 at 8:14=E2=80=AFPM Zhan Liu <liuzhanjobs@gmail.com> wr=
ote:
>
>  [PATCH v1] mmc-utils: FFU Status check for device without FW install sup=
port
>
> From: Zhan Liu <liuzhanjobs@gmail.com>
>
> Problem and my changes
>
>                ffu:also check ffu status for FW install not support
> device to catch the possible error of FW download error
> (FFU_STATUS[0x26] =3D 0x12), which is not captured by current mmc-utils.
> current mmc-utils simple ask user to reboot, which give the user false
> impression that the FW update is successful. they will only found it
> is not after they check the FW version with extcsd read command and
> have not idea what is wrong since at this time the FFU_STATUS has been
> reset to 0x00. With this patch, user will know that FW download is
> failed.
>
> when check the devce don't support FW install, read extcsd and check
> the FFU_STATUS value. If it is 0x00, ask user to reboot. If not, print
> the error message and exit.
>
>
>
> ---
>
> Signed-off-by:  Zhan Liu <liuzhanjobs@gmail.com>
>
> ---
>
> diff --git a/mmc.h b/mmc.h
>
> index 6f1bf3e..5b06410 100644
>
> --- a/mmc.h
>
> +++ b/mmc.h
>
> @@ -229,6 +229,14 @@
>
> #define EXT_CSD_SEC_GB_CL_EN                         (1<<4)
>
> #define EXT_CSD_SEC_ER_EN                  (1<<0)
>
>
>
> +/*
>
> + * FFU status definition
>
> + */
>
> +#define EXT_CSD_FFU_SUCCESS
>              (0x00)
>
> +#define EXT_CSD_FFU_GENERAL_ERROR                                       =
 (0x10)
>
> +#define EXT_CSD_FFU_FIWMWARE_INSTALL_ERROR                   (0x11)
>
> +#define EXT_CSD_FFU_FIWMWARE_DOWNLOAD_ERROR                         (0x1=
2)
>
> +
>
>
>
>  /* From kernel linux/mmc/core.h */
>
> #define MMC_RSP_NONE          0
>  /* no response */
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
>
> index 936e0c5..10bdb94 100644
>
> --- a/mmc_cmds.c
>
> +++ b/mmc_cmds.c
>
> @@ -2962,9 +2962,38 @@ do_retry:
>
>               * if not then skip checking number of sectors programmed
> after install
>
>               */
>
>              if (!ext_csd[EXT_CSD_FFU_FEATURES]) {
>
> -                           fprintf(stderr, "Please reboot to complete
> firmware installation on %s\n", device);
>
> -                           ret =3D 0;
>
> -                           goto out;
>
> +                           ret =3D read_extcsd(dev_fd, ext_csd); //get
> the current extcsd after FW download
>
> +                           if (ret) {
>
> +                                         fprintf(stderr, "Could not
> read EXT_CSD from %s\n", device);
>
> +                                         goto out;
>
> +                           }
>
> +
>
> +                           switch (ext_csd[EXT_CSD_FFU_STATUS]) {
>
> +                           case EXT_CSD_FFU_SUCCESS:
>
> +                                         fprintf(stderr, "Please
> reboot to complete firmware installation on %s\n", device);
>
> +                                         ret =3D 0;
>
> +                                         goto out;
>
> +
>
> +                           case EXT_CSD_FFU_GENERAL_ERROR:
>
> +                                         fprintf(stderr, "FFU General
> Error on %s\n", device);
>
> +                                         ret =3D 0;
>
> +                                         goto out;
>
> +
>
> +                           case EXT_CSD_FFU_FIWMWARE_INSTALL_ERROR:
> //may never happen since we have not install firmware
>
> +                                         fprintf(stderr, "FFU Install
> Error on %s\n", device);
>
> +                                         ret =3D 0;
>
> +                                         goto out;
>
> +
>
> +                           case EXT_CSD_FFU_FIWMWARE_DOWNLOAD_ERROR:
> //main purpose is to check this since it will be cleared after power
> cycle
>
> +                                         fprintf(stderr, "FFU FW
> Download Error on %s\n", device);
>
> +                                         ret =3D 0;
>
> +                                         goto out;
>
> +
>
> +                           default:
>
> +                                         fprintf(stderr, "Unknown FFU
> Status on %s\n", device);
>
> +                                         ret =3D 0;
>
> +                                         goto out;
>
> +                           }
>
>              }
>
>
>
>               ret =3D read_extcsd(dev_fd, ext_csd);
