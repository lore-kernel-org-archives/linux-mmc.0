Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6902A2877E9
	for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 09:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856745; cv=none; b=T2qTQ5vDa0Rw7u/KThpV2YpyxhA7uvforeatXOWxmuj+ig1XW1H9fDEDC27rUF2VrUgMWbENSBB/vCt18EMxocfzDaF3XKEc2iT/RmmkY2opCf+Yd20rVuITi2Du5jyud4GaRMpn1lNGenHQkaRVMhwsSaQNMShp2cct0hce+KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856745; c=relaxed/simple;
	bh=O3/7A6Wz95KhbbQsG2Mm37l0Wb0s91jJ7cABoe2MIkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAddG3d8O3xGNrkZEKCH4GFsaPyhkxkZ8cIj57lAsUxAAmB8SlESSSeSVGt4DyzR+vYU4LTvTOsqHSDb4dQhtn8HBQps+19poE6vVI3HUrnEhhCM4zuG61wUbRJsHmECVVzCWrtLahD5oV6I5fIR+q9Lp9rRkFrU8uemL1IXjj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdO6xxJ5; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdO6xxJ5"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71d71bcab6fso15209567b3.0
        for <linux-mmc@vger.kernel.org>; Fri, 22 Aug 2025 02:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755856742; x=1756461542; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MupVyM5V8S7xfEuqt+V4G4FxecFOk8NDMM0guvbljvg=;
        b=hdO6xxJ5ooaju0JRSsZ6fWy8jJjtB82L38LcvJaWk2Crbg0484+KDnbNQFaPIkk/tW
         5i+9rV27M527Qkzoqs4NiIV2rsuCcENTUjBQnALQ8jDEXo6jIZajTQNZR3zG4389GsRU
         QSrNTVi8nBlDJDaqnPwalG+UOXAdMgF/K0bEqet8E6pSWfZiatP9cT5SMfp1h//6Ku0Q
         pN33mIBeQ08laY7f22nuz4TnCHwuxWcgd1BdG6yCzKSKl97cFYk0iPq+Nl3jaGZ/R3ut
         fJewn/hzaB2qXCXZkBQN0nsT9VlucliQE7S9vzt7d4Hzup8AzzlOOf2jqxaJVXHbmnDy
         IU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755856742; x=1756461542;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MupVyM5V8S7xfEuqt+V4G4FxecFOk8NDMM0guvbljvg=;
        b=LKfLnmDrS9VlSiAMGlN3INx9Z9vnr8Lgiul6P2aQlmUsW8GHpGmcixFWI2kCwplhqD
         Ov/tRWjZuYhvdqvFGMV5NDoa5vXybFvrByJVVbshTfPhl18M9ThOz7zRicAQtIYnLSQI
         za7WbKrxfzL/zQsD0BNhZgQ7n36LC83sKrCKj7rjVLHM8BWC/9OXZpsSGuEGfw3tC9EZ
         eGTvH14gUzIp47ubUeNfcZJi1V5dSgRCLrfRB5l1sAyrwJMlGm+w4baUcBNozfZp0oDF
         HPS2Ix36BW6RKEQeEJ8eXPXeeLGCVQ2KPUwCnyFsY29IuaX4t117j+yXE1hiyM3eWXMX
         v6tw==
X-Forwarded-Encrypted: i=1; AJvYcCWiMuq3BjH2bGN/JVsufmMlFxH1HDbbbrSpX87EwnD8gYoMg96WmAPi6RKKgYyqCvReVrTAlnjh5UE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGKwN+tySTjV99W5ZmGTmxb8rV571ItBJiAttTqdr7YghoytEz
	EIpGy/AklAayk7hNIGiTbwmJ1/E9W3hA8kTXWwLqUgj6ezR5nPE1PDdGdxTnKD8HvSerjE8o25y
	rZiBHC8Xbxk6UrzZVFjcvJXMhR4JcPZupPUGlNyhk2E8dYZ/MDO5F
X-Gm-Gg: ASbGnct+9XScwM9xj9mR9ZOwC95AUT3mzIaqvIK4qxlfBkkD8PtXe+S096CuHCvVgLy
	g6cG1UtEjuU8tT1DvmB9f11QFHqw7HYPQmtZiF2caSOoeOC1aZ6BrbsG8G6Z5UYoWmtHLVNrtsQ
	Qd8fr8iBqEmjZroaojQsd+/2yK+PqSNzGFSeK6uk8Vp7J9op53pjTDUIgRKHFG52iAbAoGVjbVI
	wqHwI6x
X-Google-Smtp-Source: AGHT+IGW1UTX6fQaw19toVL97OISC/Ry0Xp6bS03YAWQ8SWHpLi2Fv4YjzcA1kwnxqqHARhMhn919UITNadOtX73TGY=
X-Received: by 2002:a05:690c:7006:b0:71a:1bbf:bc04 with SMTP id
 00721157ae682-71fdc30ae9fmr27985117b3.19.1755856742203; Fri, 22 Aug 2025
 02:59:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821200701.1329277-1-david@redhat.com> <20250821200701.1329277-28-david@redhat.com>
In-Reply-To: <20250821200701.1329277-28-david@redhat.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 22 Aug 2025 11:58:26 +0200
X-Gm-Features: Ac12FXy5YAgos3FlxeTAUjV_qUtOvnPUJMl5UU6P6i8dKRZPvTVLextRAtA1LQY
Message-ID: <CAPDyKFrMR2bfnra1hWiLwqTqt7AFgALHzYCn+35PqU_wq+GhBA@mail.gmail.com>
Subject: Re: [PATCH RFC 27/35] memstick: drop nth_page() usage within SG entry
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

- trimmed cc-list

On Thu, 21 Aug 2025 at 22:08, David Hildenbrand <david@redhat.com> wrote:
>
> It's no longer required to use nth_page() when iterating pages within a
> single SG entry, so let's drop the nth_page() usage.
>
> Cc: Maxim Levitsky <maximlevitsky@gmail.com>
> Cc: Alex Dubov <oakad@yahoo.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe



> ---
>  drivers/memstick/host/jmb38x_ms.c | 3 +--
>  drivers/memstick/host/tifm_ms.c   | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/memstick/host/jmb38x_ms.c b/drivers/memstick/host/jmb38x_ms.c
> index cddddb3a5a27f..c5e71d39ffd51 100644
> --- a/drivers/memstick/host/jmb38x_ms.c
> +++ b/drivers/memstick/host/jmb38x_ms.c
> @@ -317,8 +317,7 @@ static int jmb38x_ms_transfer_data(struct jmb38x_ms_host *host)
>                 unsigned int p_off;
>
>                 if (host->req->long_data) {
> -                       pg = nth_page(sg_page(&host->req->sg),
> -                                     off >> PAGE_SHIFT);
> +                       pg = sg_page(&host->req->sg) + off / PAGE_SIZE;
>                         p_off = offset_in_page(off);
>                         p_cnt = PAGE_SIZE - p_off;
>                         p_cnt = min(p_cnt, length);
> diff --git a/drivers/memstick/host/tifm_ms.c b/drivers/memstick/host/tifm_ms.c
> index db7f3a088fb09..0d64184ca10a9 100644
> --- a/drivers/memstick/host/tifm_ms.c
> +++ b/drivers/memstick/host/tifm_ms.c
> @@ -201,8 +201,7 @@ static unsigned int tifm_ms_transfer_data(struct tifm_ms *host)
>                 unsigned int p_off;
>
>                 if (host->req->long_data) {
> -                       pg = nth_page(sg_page(&host->req->sg),
> -                                     off >> PAGE_SHIFT);
> +                       pg = sg_page(&host->req->sg) + off / PAGE_SIZE;
>                         p_off = offset_in_page(off);
>                         p_cnt = PAGE_SIZE - p_off;
>                         p_cnt = min(p_cnt, length);
> --
> 2.50.1
>
