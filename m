Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9312F2915
	for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762852284; cv=none; b=sd0BeE/LkHwOC3A1CQaFfP9MpB8myaAe7+nn2i+YoTLjxyYtRTVBt2dthD3NoSSLdxvogwChBJ+62U2lLggX4V7zCa75RPiMO11Y0BA4gk5ZQO3e2xZIZYiVOKcg3pNMTEUmA74hF5tEcbdqNrw84tNy7n0KzgucCZODGnDExkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762852284; c=relaxed/simple;
	bh=IC12fHhlBvy29gj1iCw1D67sVqepEB0wT8AN2IikFBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nZktPLWEpmzHStG169BEwgI9T9kpt5+DxFbFvvwbeS04wDTMLtZJLdpmGhV9bpfo6pqeem8PlIOo9M52PB/p6TCFZeYrndejJHia2nGs+R+KSbDYnebUOg5idbjfgXz4X069sbejwTXWspQ7/3crScH+vIjc8gc4t2UfhI1Hn3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FZwovYwh; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FZwovYwh"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640aa1445c3so6065842a12.1
        for <linux-mmc@vger.kernel.org>; Tue, 11 Nov 2025 01:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762852281; x=1763457081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RR2DSG60UlpWwlqOzMpmJE0q0mIMg7DAaHRuyBpwltU=;
        b=FZwovYwhwaDyFoFMXaivhMY6THHA3TVg/P5BMGwvs2UR45U8beqydwCG1KPNRgOBp7
         YeRYbUujWM8PV4O37Van7ztqLy1zye8UKIsdDgif+icldZMJbgpeIgzVgHxIP+9ul1GG
         mXmE19hIDr2/jogLMyIDkhhlYL38f9uSx5/FVkGEHefJfRsxUpvbkwrhEL/p/XI4o0+b
         lqp9hg7FmF/6wqyS35NEuyi87l4eCk8DXc0N5CmONBb68xKQedesgKAVDUR0siU6ZCdg
         Jn5s4P8dENonQoXy35JHgxLk5e/6YcOYajlFBsPQx78uWabpXOHyWA6EztrjGTupfw3u
         ibgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762852281; x=1763457081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RR2DSG60UlpWwlqOzMpmJE0q0mIMg7DAaHRuyBpwltU=;
        b=Vt9jTA/VIDpSzweo0kFS7ddwlHtRsn4OUQpqzYnEyCmx/NnS9GS/MDBrlPFrOWj4m6
         YlIJZvU87PnSTVEJThINcMb2o5P3stoOjNSzrMSeR0WDZr6TBp+gbEL3os7WWcxIOO5k
         WRM2n3a1C77CGQ9+CIesJaOCRSuqAwFCWFE0Tt6+8vNdAdwNsSDImWaiz5Y+LGB+ZTFI
         01xIYKJq+vlX27R4lgiPdfRpIqWmbkfknnxGSHO063Jl9QRTVQlktHIY4DQB615t7tMw
         mUtgTO2RsrqO1JPONOO8uGYdM+Js9EGct91xWNuH3stzGI4+V34GyyqfMqVXQKpHSUzK
         cNyQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4uBZtPQOFhauFlEWGt7sEoJw2duMuHdJ+hp87pJJD+B5ey/SdnJgw0wy43Zjw20uQRv+2/bQJ6sg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzntGSHfLHMVCEhY6fxVXenA06jBOaM6miAPwzBJef2GXvBUSI8
	fmatjbhmQSqwf2IVXB8Hk7tHiQRRk2Ge3SBJFM85+xLnLRaFn1HWs5dcqgfMx4PaOMkO0uYy+/l
	soG+j8zBgK8QARq+r1y3SPQr0/HMt+bs=
X-Gm-Gg: ASbGnctpp/9ReiGuGOwCj+VVzhxOfw1141c64JpcxmrG0uCxBqis7EYGUWHTCn6OYU3
	t5IlItsrlLAdh22cmOJJ9FC0KPvZWqdLVgd4WA5IFip6cPbJDORkFwaQwHk8Nz6yWqKErRijXNH
	O/nFxoanZwmbPc6UxeyoM2i3kwUN15WvdzLxHMqJ4HajZVWYmW10WdP+T+Hd6wsLlI/QDnPgcBm
	VLBSxtGdMhq5hpplpEfbT6Q1FNzkbfBqhcciYgED1c66sLoWOwvQvSc2BwyilOJWj/THA==
X-Google-Smtp-Source: AGHT+IFwb4OPXLAjDG0LEbBU8wuK/9nGtJVCt3FeTPGn34yEbvZTdObeJN9hDSak7qBSnp6o8GcDb80G8zLSC9zKTc0=
X-Received: by 2002:a17:907:842:b0:b4e:f7cc:72f1 with SMTP id
 a640c23a62f3a-b72e035f245mr1156807766b.22.1762852281314; Tue, 11 Nov 2025
 01:11:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111072158.6686-1-linux.amoon@gmail.com> <b749faf3-b197-4b78-a918-501a639a8f4d@rock-chips.com>
In-Reply-To: <b749faf3-b197-4b78-a918-501a639a8f4d@rock-chips.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 11 Nov 2025 14:41:04 +0530
X-Gm-Features: AWmQ_bnFiCpFHUomwGMZiBBphjUVHI9tPfzMaMLV8q4Dcc6I4jB5SQOjxVQ5kdU
Message-ID: <CANAwSgTs1dqyF8UfizOP-8Yt4kxeRD+7ebZGkXuVbMe5HqT-XQ@mail.gmail.com>
Subject: Re: [PATCH v1] mmc: sdhci-of-dwcmshc: Enable enhanced strobe for eMMC
 in HS400 for Rockchip
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Thanks for your review comments.
On Tue, 11 Nov 2025 at 13:09, Shawn Lin <shawn.lin@rock-chips.com> wrote:
>
> =E5=9C=A8 2025/11/11 =E6=98=9F=E6=9C=9F=E4=BA=8C 15:21, Anand Moon =E5=86=
=99=E9=81=93:
> > As per RK3588 TRM Part 2 section EMMC_EMMC_CTRL, Add code to enable
> > enhanced strobe mode, set the card type to eMMC in HS400 during clock
> > configuration. This bit instructs Host to sample the CMD line using dat=
a
> > strobe for HS400 mode.
> >
>
> Did you really test the latest kernel?
Yes, with the fio command, testing before and after this patch on a
Radxa Rock 5b eMMC.

$ dmesg | grep mmc
[   16.321495] [     T60] mmc0: SDHCI controller on fe2e0000.mmc
[fe2e0000.mmc] using ADMA
[   16.425317] [     T72] mmc0: new HS400 Enhanced strobe MMC card at
address 0001
[   16.449670] [     T72] mmcblk0: mmc0:0001 SLD64G 57.6 GiB
[   16.550133] [     T72]  mmcblk0: p1 p2
[   16.577289] [     T72] mmcblk0boot0: mmc0:0001 SLD64G 4.00 MiB
[   16.641182] [     T72] mmcblk0boot1: mmc0:0001 SLD64G 4.00 MiB
[   16.699865] [     T72] mmcblk0rpmb: mmc0:0001 SLD64G 4.00 MiB,
chardev (234:0)

> HS400ES for Rockchip platform has been supported for 3 years..
>
The only modification made was to enable the strobe bit in the eMMC control=
.
> please see commit c6f361cba51c536e7a6af31973c6a4e5d7e4e2e4
>
Based on my analysis and the RK3568 TRM, neither the RK3566 nor the
RK2568 supports
HS200 or HS400 modes.

Thanks
-Anand
