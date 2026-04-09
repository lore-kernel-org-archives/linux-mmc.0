Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B473090C2
	for <linux-mmc@vger.kernel.org>; Thu,  9 Apr 2026 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775749540; cv=pass; b=vFuPRmzPGbdjlj0NhLIPI1/E7Wn+qrl78PNFsTxVhL9aPpht9u8rSMLD+e3SdqHdhSPGXYg+lgkcmY6hb9nXt60hpzH+fJrqSBrXkGgFqTaA1bBrSclu1MbDgHGj2FDxm53sEuRdu3Izav82/5bnjj61MJjzI1HyyGdMc4R4od8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775749540; c=relaxed/simple;
	bh=i38o6zgx9E3RxYR1jkq6U5/qrH4jGtb/gYzPRm4ARGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yxug9ul3xl7KQa8/Ztq1Bz5kOI0mfaakSkGYx7AEke6At/KDXYJa9wjiPCVwixj/3tzVSiWoE26FNXC729WMe+9UBKl2CtxPVDXvGUoB3FV9zwN3uHpmWgfMGjtZU+eWF6FUae60o9AOl3LI093e2OYOMYogXjZvl0BZme9kGS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cKpv3GHL; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKpv3GHL"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5a3af1b7549so1332413e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 09 Apr 2026 08:45:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775749537; cv=none;
        d=google.com; s=arc-20240605;
        b=W67xjuTSdE/UXH0toW+97nANF0Zhe5hKMX3qzvCwm9j68SEr8jCQy5ZjLqquFcCo4L
         Yz48gk804ldsM5FtlNemiLvtTm+/TE0wJGmZ0mGNBdsejTRyQeK/iYMlgoVdXd6OFh2k
         A8sMRo5vx5YdcIRlHtIo2xyGSWsDKMyfC5HBxrqeOY+C9PCUja0Nv9uXt1aoXn2cxqSK
         S1IwbsLvZA1BrNRqOT6abR6DlPian4UAM8A5D9vNfFwU7XQMgnBZWhKcEcWR1EDfbbSK
         Sb1pyfp561S/RjvL3MZla3603zqRzcY/K1dTC6869zKFgr2ltT8hecre6F1brVMMMy19
         U8dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FLsVtStZbO9hH5l5AzJYqw9w3HjfakD/LNEZ+6mKscM=;
        fh=aJ+D/JUt8a7oyWJIkSqMuKdyrRTXQJbIjOXpzBAQJVY=;
        b=c6QgNSUTDL5fdd2sUiMzmA3+IyRYaebSYZssjsHZoRnVGnIhyKIYCblLN5rNQX8rtv
         Sr5TNKgYCcVamyDc1HAMsQjfIqdxX1ucwYQASSyqov/sKj9Dsvyl2IBTJgErvmxFAGed
         sVd1nYs65ssyWjaXCWsfQnK/iOO9yPDCPFv5Z9o4MWagdicqva5tkTXRRjgCfIF6mhWA
         otY2Du5wpmq6N5H8XtsQslA0SrtR2Z3M8tT35bYkmANW4vS3P1+ug/APyM6d9ISQaJ6K
         ifdM+TNqsVrtVBlezLwxazepEWWacEs3KAYqUoO+1it7Kxc4QwM4q9SSWijJMkB/wUOl
         fIIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775749537; x=1776354337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLsVtStZbO9hH5l5AzJYqw9w3HjfakD/LNEZ+6mKscM=;
        b=cKpv3GHLKJHs6E6En2zVzFH8dig0iLEFTpSlVsJm+jcLIJyt1pMyh3Bsxr6VW9TJ7m
         5UHYDPas0Dvjo7B3u2aQG4I2mgaJXWB5qYAT3klzZdTIG9qabQpmgvn9zEKu4tJEeIZ7
         8c5i02FtodqNY1hNlK5pd3zED53KHHwFYgFnqagNXFwyA7lQ1ETtkCz+l/8ZBKtr6Isv
         OYoUG1itg2qxBswyeiTj/C5vdUUxaJG+MZZgREEmtZRs08YbAC1fxblFgq+Dn1TGR5/k
         NAJ8pxRCEs0TywCFk/C4Rn2/x/KEJjm/Vev9uInBfu4tdb3bin9HjR5Q97aJ5op5VhAd
         2cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775749537; x=1776354337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FLsVtStZbO9hH5l5AzJYqw9w3HjfakD/LNEZ+6mKscM=;
        b=q3jfhgL8PRk8brh48S+2S5cbKORi8hxBIXnqlwEd1bc3mQ5o0vUiu294mZBViHkDYk
         3yHikVmWVl8qkkIXFcFP3ByV5ikhFKFi8x/1EUHaGwpEad2+8Cf1hHYaUJ4tXKFRYpx7
         qIgeLuq6sSbDjsYvhkcrRdHfMHldm/j7NF34j/213/zHt9/146demwK9NSg8Ha1SC3GZ
         iIv+PG+6Wj3DZhKbyswvRN65IcjfeO7d5bsfM4R3KMeGE1bERJZEn8d+NQUAA4kEgqV8
         ouQJCu7K4aZh2/+yMBd8d94z7szxkMYmdUyKPUZYq5DrzPHrqLWFD8J6lT9TKYHde3PA
         +x2g==
X-Gm-Message-State: AOJu0YwMzIAJaRrPyi6TJFO+ify9rl7Xg3RlZNx88sodxVI5Sp1Bht7S
	zm2HmbpIQuroDnUwrAUduQWgR+peGzh2RaHjlDsU+gYrisg9XbCPXCKHKARvlGrIbBxT5TOawZ/
	foRAphIOQX2mRQtm4RC5pwYjIkAOjNmOhQRskk1L2Qg==
X-Gm-Gg: AeBDiev5dEedt65u8/FVYe1s3VNOABmy0oDB5cLSDNPxcldGN+0+X6cLgoAAZKmYwCt
	arknrmZjhATUtTt+JVZ44r67WxEmsURu3Ek0n8eQlnwDaZIFRTmag6jLyh60ygSNzAQpi5p6ZCZ
	xWuKG8yoWAR5AZMM+MKb2jVD9dY8MDHD7HO0YxDk0V6LOqfHFRjkyspBc1t0e6ADoKzUuQJhbvy
	rApQjaowj+BO5JAqIQ9eBG4bXr4OI6BgKY5MvnK7A6WHes6DYPEssQizm3Lc35cWoGxsjLvEn0D
	Brlciozz2dTwfX/DNQU=
X-Received: by 2002:a05:6512:1047:b0:5a2:ae26:63a8 with SMTP id
 2adb3069b0e04-5a337590bb2mr10160314e87.45.1775749537212; Thu, 09 Apr 2026
 08:45:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <964d54a3-90ce-475e-952f-342bb383f878@gmail.com>
In-Reply-To: <964d54a3-90ce-475e-952f-342bb383f878@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 9 Apr 2026 17:45:01 +0200
X-Gm-Features: AQROBzAUjTq6Y5lwvnv7uSh9MpP4MuhwyJQwlzeLuCQ4oIxIldML_82AoRtG3UY
Message-ID: <CAPDyKFoPjwBeaQKMDf7zrW8hQDZjD89=ChJ_TPf51BG4yonz6w@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx_usb: reset chip on resume to restore card detection
To: Greg S <grigoryya@gmail.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rogerable@realtek.com, Ricky Wu <ricky_wu@realtek.com>, 
	Sean Rhodes <sean@starlabs.systems>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+ Ricky, Sean

On Tue, 7 Apr 2026 at 13:56, Greg S <grigoryya@gmail.com> wrote:
>
> After S3 suspend the Realtek RTS5129 USB card reader loses its internal
> state, but rtsx_usb_resume() does not reinitialize it =E2=80=94 it only w=
akes up
> child devices.  As a result, the first command sent to the chip after
> resume times out with -ETIMEDOUT and the mmc subsystem never re-detects
> the card.  The SD card (mmcblk0) disappears and does not come back until
> the next full reboot.
>
> rtsx_usb_reset_resume() already handles this correctly by calling
> rtsx_usb_reset_chip() before waking children.  Apply the same logic to
> the regular resume path.
>
> Tested on a laptop with an RTS5129 (0x0bda:0x0129) built-in card reader
> and a 128 GB SDXC card.  Before the patch, mmcblk0 was lost after every
> S3 cycle; after the patch, the card is reliably re-detected on resume.
>
> Signed-off-by: Greg S <grigoryya@gmail.com>

The patch looks reasonable to me, but perhaps we also need a fixes tag?

I have also looped in some of the relevant driver authors to get
confirmation that the change makes sense.

Kind regards
Uffe

> ---
>   drivers/misc/cardreader/rtsx_usb.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/misc/cardreader/rtsx_usb.c
> b/drivers/misc/cardreader/rtsx_usb.c
> index 2b3ae2914ec8..f1a3b5c7e912 100644
> --- a/drivers/misc/cardreader/rtsx_usb.c
> +++ b/drivers/misc/cardreader/rtsx_usb.c
> @@ -732,6 +732,18 @@ static int rtsx_usb_resume_child(struct device
> *dev, void *data)
>
>   static int rtsx_usb_resume(struct usb_interface *intf)
>   {
> +    struct rtsx_ucr *ucr =3D
> +        (struct rtsx_ucr *)usb_get_intfdata(intf);
> +
> +    /* After S3 suspend the chip loses its internal state and needs a fu=
ll
> +     * reset, identical to what reset_resume already does.  Without this
> +     * the first command sent to the chip after resume times out
> +     * (-ETIMEDOUT) and the mmc subsystem never re-detects the card
> +     * (mmcblk0 disappears until the next reboot).
> +     *
> +     * Affected: at least RTS5129 on several laptop models.
> +     */
> +    rtsx_usb_reset_chip(ucr);
>       device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
>       return 0;
>   }
> --
> 2.43.0
