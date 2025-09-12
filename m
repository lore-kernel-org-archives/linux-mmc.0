Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117F11F4E59
	for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 08:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757666944; cv=none; b=C/qrGOAKStzjz7k6cox/AY1eXeWL2di6G/7uJGrr1INYX750u3Db5oKZJlg2dXo5/pZEaG/UBL/HYexnuGUUDZVPEVtl3dihplG4XKwc6wdC8Sr66UbU8r2Typ0HBqmBLOPFGSSA+OyCeoemyv+RQxIlOuQGYXDgBzC6fg3Abps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757666944; c=relaxed/simple;
	bh=pfequ67AxMRG2qp1IorZvEGJU/BS32aaLb+8hih0caA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lfODTFoJLn7MKYLc/0Lj8KWHy9ZX8ba+1iIOD6mOlWoxiQDIsOWeh7wg9cXvQ3A1IG0LNuVYuYbHf8BhpWCiIzEnx57JZuP4KkA8pRmo7TcN5hprhV/SjGK3WPx01370FxwIxLSV2e/Esm6xZ//JfB6ijdyvixXI9/uD+HtJsIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-54a17fbd375so270786e0c.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 01:49:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757666941; x=1758271741;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kvFl2wUmtFFxKY2KBAM++CC8ombdEefvWb0q1iJCezw=;
        b=RcenJ3Z5MXm7xxDJh1SJhicjUWlS38OLrIuy1HaAZJP7VLN0EaVqf205/MBFclm5pe
         ea/E0q3OgaptMrlXMmee5aDOUR5ks0Lt9cIghiUUP+kkWY3BJuxSTJ6z3PmEiHP21Hf7
         9dCG0jWVGfyKieM5DuHkeS4x6oc8f51o/I0PfOeJ2rVRqqFWDVKT98TqQlSsh5WdTFi2
         K7wFlysVexqDYfzh6XXnJ7cubmd4qzsumVA54ZEPnCK38ruErgtT49tNju9QZP2OMqJB
         9LodRTRRrx56vwBozsedpSj/Ak/Lva2AepLKe5FL3J0jd9VFdLJ97xsKl//ligsVQhw5
         aFRQ==
X-Gm-Message-State: AOJu0YwapFwCc3+b+NAEcrqlq5Xc4LkHL5D7cX3dMxu5bD6OeJUl/Pst
	P2ha/ADZPvsNX32oJdJr766UxGv3vWBL6CaMOuVQnMOUY0zNCNJMIrMmsvjmnpV2
X-Gm-Gg: ASbGncu1fioRVxmdwwefqONH8PmvkDSOVMaEuUCQ5nTcrx0m6PtEB2nFX+QuePhNIbE
	MXU1lYlciMu6bjLXid9ldQ6UUK1o2jX6EoF0NUXtpUD/IOGLGjMmyzEH76h4WypkBjIrzxWLAm/
	D6IEiW+AN4PqyXqQH6oHdp8SHlUvn6otdKFmPGavUEV8SFDfTJlgR1uoBJz3e3ceNG4qAjgAcBz
	GLqDNh3Cxm0XqIn4PnhiOc/V68PobCVDqBDhffcfgn4XwpExcW/g8NxzY3iduEhj8f77vaYA3jf
	VgBwX9xBi9825O1yykUDa+qlnfj1qha6zh3el+JUZPuygL+YeRAT+6ARHOrohvaYtqtb7Fzt+Pk
	mavlWWp2fuF1lZjpAokUe8OOSqKy92zINLlUS5gNMy0y2hTsHRu1XVUkmkeWc+2ssmQax6X4=
X-Google-Smtp-Source: AGHT+IGuDznWdx1s4xcTckY4OF4FJ1NJ8rfIcsy2ry3yLGJXRfoPNjd+rD2gHJsHyu0niD7gkOCNJg==
X-Received: by 2002:a05:6122:1682:b0:545:eca2:1c7e with SMTP id 71dfb90a1353d-54a16980f8amr713253e0c.0.1757666940790;
        Fri, 12 Sep 2025 01:49:00 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54a0d1bd09fsm734668e0c.3.2025.09.12.01.48.59
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 01:48:59 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-529f4770585so1113239137.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Sep 2025 01:48:59 -0700 (PDT)
X-Received: by 2002:a05:6102:38ca:b0:52d:56e7:379 with SMTP id
 ada2fe7eead31-5560d94aaa2mr992401137.25.1757666938783; Fri, 12 Sep 2025
 01:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912084112.2795848-1-mikko.rapeli@linaro.org> <20250912084112.2795848-2-mikko.rapeli@linaro.org>
In-Reply-To: <20250912084112.2795848-2-mikko.rapeli@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 12 Sep 2025 10:48:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUUQ_raSGTjLSU0QaBxy3CMMnJJTV9BKmWQLQ7U8VE3oA@mail.gmail.com>
X-Gm-Features: AS18NWBiuYTvyIQj6odp2YphRi_cdJn-bbWmQ3arIwrCLTZ05PO_-WVlIOuk6lU
Message-ID: <CAMuHMdUUQ_raSGTjLSU0QaBxy3CMMnJJTV9BKmWQLQ7U8VE3oA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: rockchip: select ROCKCHIP_PM_DOMAINS
To: Mikko Rapeli <mikko.rapeli@linaro.org>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, 
	=?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	linux-kernel@vger.kernel.org, adrian.hunter@intel.com, 
	victor.shih@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw, 
	geert+renesas@glider.be, angelogioacchino.delregno@collabora.com, 
	dlan@gentoo.org, arnd@arndb.de, zhoubinbin@loongson.cn
Content-Type: text/plain; charset="UTF-8"

Hi Mikko,

On Fri, 12 Sept 2025 at 10:41, Mikko Rapeli <mikko.rapeli@linaro.org> wrote:
> According to Heiko Stuebner <heiko@sntech.de> all SoCs
> since 2012 have power domain support in HW and
> ROCKCHIP_PM_DOMAINS should always be enabled.
>
> Suggested-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>

Thanks for your patch!

> --- a/arch/arm/mach-rockchip/Kconfig
> +++ b/arch/arm/mach-rockchip/Kconfig
> @@ -14,6 +14,7 @@ config ARCH_ROCKCHIP
>         select HAVE_ARM_TWD if SMP
>         select DW_APB_TIMER_OF
>         select REGULATOR if PM
> +       select ROCKCHIP_PM_DOMAINS

This requires "select PM". Oh, that is done below (out-of-context).
So the "if PM" above can be dropped.

>         select ROCKCHIP_TIMER
>         select ARM_GLOBAL_TIMER
>         select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
