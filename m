Received: from mail-qk2-f7.google.com (mail-qk2-f7.google.com [74.125.230.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 298CB26159E
	for <linux-mmc@vger.kernel.org>; Sat, 15 Aug 2026 03:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.199
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786763645; cv=pass; b=ZmfwygsOw0Jb0d9j7bc4u+noVHcw291mCJGe4hnuZdmOw+op1itJb/SAnhH9HD2rjv30JP69DjOuX+3Qu4jsXE9VtwRxOnCBMxg9iGibSkNQgoa4XLx9INL/3JKhHVJJS+D+jULn7hgP3V5myrFBiLW9LhKKua1sZ9bLXV1OoVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786763645; c=relaxed/simple;
	bh=iSfM/5zR3FO1hxc641lTfSTUQipWVINU8smV1++P6Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dto7EBUJckbFWPvT0Fn2Lw7qdJyXdkS+//AY5oqfgFm/UUNlY4t7aS5CMK0CzhnJBAnaxXk8Nm15WOecYalrMK7VXW+YmwVf9txTwOiqhtElSY7epz2IEi9fvj7+O93rAx3SETLW4HyPJ3Fpy5XmMhWdugjZ7e/T4bTJGRFiJAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7kk774K; arc=pass smtp.client-ip=74.125.230.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7kk774K"
Received: by mail-qk2-f7.google.com with SMTP id af79cd13be357-936b6f4b44dso41159385a.1
        for <linux-mmc@vger.kernel.org>; Fri, 14 Aug 2026 20:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786763643; cv=none;
        d=google.com; s=arc-20260327;
        b=FDn8A2fSMlRrEvU5TRVPKnlwlBm3DS0zycxcHo81Ifr2jX4Di7XyRgdP21dkPt5w85
         2R2CD64fJjGh94e80gLsARc5V1SY4p4RNb7HwKUqmU/UXwBng5OUu/EjqZHxZoGMCgaq
         uGCF/DPNa+89Wn8hbLOEi5aw59s1LlbXDWULuudRA3XxFXeTpMI9dNzH3ME2HjDOFMTo
         7vr7K26okw2OmGq+TBA6mvSeaQk8ONjLN9PVJOA41pup/rE1uFqYlXGfNTa9+REOPycZ
         QCmHCXaPlbIWfSJucDTgTMCDOW/9VYxhnCMDAUb4wbkG46zJ9p6BacNUQ3WFiwK2gRMB
         je4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N1niuDJcwGLVmXZCzrR8HgoUrAWQplWf6u5KB9p/0LI=;
        fh=4L0ps9OejE00C8Mbh4EiH7W7F2dJ+yivQ+FAcrn3fkY=;
        b=lUBVb1R59HDIZR0UAAmoGWjzXE4xSsYhkEmatKlpcxP5aZrZuU5GUu20JQ/e7scJ72
         QgGjhfW4FhUXVDiRXTYRdmTIbe33sY42CgqW/SE12sGmZgLrjvdJ36BAChKNBuVplEXe
         p2pzozJEoat9oaGamrxcNLm1RZgxiud3jIrtTlSCKHr8pQcKMOwMufmjjbDBSVJzTSlq
         6bqO7zHo8mHDxq03gwhO3dFVWI1NxBKo3eCue5MDSS3U2bi9391jfFeQIndBDAbNSHPo
         QFcUu6PttyiU12mdMllXbboQs4SzaTg7uX+ek8ER7NlvnvywyXnWfg2I30pPuXXV+FNA
         D5Lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786763643; x=1787368443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N1niuDJcwGLVmXZCzrR8HgoUrAWQplWf6u5KB9p/0LI=;
        b=X7kk774KgXkc62bmcMautk8W+SXbPk80iSM2/u/cde+78u52CqQ67lgvM0gQcDq0UF
         ReETU1Ii1Zid7B72sdeGyjC1zjVA5Ros7TLzAH4zhGFYKP/hOCbMF9bkHStifWhxJrW6
         KTvIP3h9/1pw9RgfbfpeWHTINi91NqpBYgTlhQ8j9xTt4sGvoiTBhzpDhSq349gJ/RVZ
         jJTltFavtxMjpHVvzm4FLbvu/rvbJ6IU2VKlXltebe5g/xgRpMDf5zpkAhCBbap52jma
         IOp++2oR5GtI3F5NsYGJEkW8iD29JGrEANOhmrUq33a04miAJOev9tYWxNVCRV7rq6eU
         ZHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786763643; x=1787368443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N1niuDJcwGLVmXZCzrR8HgoUrAWQplWf6u5KB9p/0LI=;
        b=YwtZ8BCxSOrnnd1Dy2quRUgEIiV6yhhHA4q3bYjJ1KsVZ62SvwmD9tJPPgT7NOM2Cj
         FokU/MqyYJ9jNxbmjjusX2eVgFB4+AgYJwszb93YN4PidRg/xw5OectWO3vYutOHjjNE
         xPSDDlj6L5CCKASZCTkZphLTRSXqMmZUFPyEpg0gfgdvMJvIMXcfrlv5TCh2ugM6a4to
         28ai42fV4eyw/Y4lxgNkaG303pvk1c45tPbFjSSGzMBwxVRjFSB2qQcMEzh5Sa0y/hso
         vlFh0EIxCf5C10ujRNI1Wx8OHIriVi353hPstk9RHgHSpI0sJqrqUX+4sNntjsnzzXTt
         Gk3w==
X-Gm-Message-State: AOJu0YxinmBtVn1QUJ+ZQye/hDJWxrkgCz3n04mIyblcgsBX/v7a+luT
	acQ0Qrpf1watzxgLxZXLyEADGFRYyOWO7z/hQVwVasAGM5s3Lm2Iz3YFzx7Bq6zPg5FFx3fjs6c
	YiHNCAZKPoTZH6WWP4nv/ZD2HaGXnbRRa4PNZ
X-Gm-Gg: AR+sD10f2hfxqQDOOLDDfs1zjLKCecZozGOpjISady6gd32XSq6y4Y7gy0fqpzj5hdp
	J/OQcXVM+aPD/FE3kf6wOUQAk6V6d143dq+XvZtnwGSP49ECr6uAwakLKPuMEZt5D9d0rsDA0BZ
	Atu+881DwaO3HihrWyq+wtOBan5wlkMmiXDV6YSLp6tovAilMXilt6an7C3Rq5wdNhxIxPR4w11
	RyaH+UFS+09m6who4h5Yn5aXlhgNDNv/Adsg0ZHxs4vr4bYkM4s/kovyWhCPY8aJYfQUcum4jQq
	2WQiOAimyYGyR+BypguOF8HvRLbgWHTI768wMmEAcM4lwgONfdmXIeKbW0OPlzsClaYJSllZUA5
	lncjFDjzJdtvEDDa9pprYO7D7hDL5bBkiYI7g1C8il0V3cZTT9p5RnxCkzWiar0HB5j2KEh8IXw
	==
X-Received: by 2002:a05:6214:27ea:b0:908:25a2:6bbf with SMTP id
 6a1803df08f44-90a91dc8d86mr104476016d6.30.1786763642968; Fri, 14 Aug 2026
 20:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806115112.45821-1-ulf.hansson@oss.qualcomm.com>
In-Reply-To: <20260806115112.45821-1-ulf.hansson@oss.qualcomm.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Fri, 14 Aug 2026 20:13:51 -0700
X-Gm-Features: AcwNN1Wqt6uiM684YoSQBluLfBebn8_UF46faNXL9yaidrUvjAI7TAJyQLtqwFI
Message-ID: <CADkSEUiBRBb-UGKraUkiXaMbSe6Ng0YbqY-FjXnjPoXsf5=r5Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: PXA: Fix build error for PXA93x
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: linux-mmc@vger.kernel.org, Ulf Hansson <ulfh@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:51=E2=80=AFAM Ulf Hansson <ulf.hansson@oss.qualcom=
m.com> wrote:
>
> From: Ulf Hansson <ulfh@kernel.org>
>
> Add a missing semicolon to fix the build error for PXA93x.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607301822.cl0lEkQt-lkp@i=
ntel.com/
> Fixes: ab9c44bbf6d7 ("ARM: PXA: remove remnants of PXA93x support")
> Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Signed-off-by: Ulf Hansson <ulfh@kernel.org>
> ---
>  include/linux/soc/pxa/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/soc/pxa/cpu.h b/include/linux/soc/pxa/cpu.h
> index 38bacdae684f..c5b275a80854 100644
> --- a/include/linux/soc/pxa/cpu.h
> +++ b/include/linux/soc/pxa/cpu.h
> @@ -177,7 +177,7 @@
>         ({                                              \
>                 __cpu_is_pxa300(id)                     \
>                         || __cpu_is_pxa310(id)          \
> -                       || __cpu_is_pxa320(id)          \
> +                       || __cpu_is_pxa320(id);         \
>          })
>  #else
>  #define __cpu_is_pxa3xx(id)    (0)
> --
> 2.43.0
>

Hi, Ulf,

That's embarrassing. Thanks for catching it.

Ethan
