Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3473329E066
	for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2025 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745918234; cv=none; b=QSZXck1E+Q/yzkSzKqVt0o6UOX/Nl4QG02MVNRseHjIZy2l6JFZzJf9frNCgF4Vjt+D2WBaiJsJXl0fsZmu7oHi6i2DARTm2qxyA9dkwd5JIlPzcHu7YZ1TOTgqDpLzzpLohl9bXx9oNf5pVwzO/6k+o/QjSj9DHUVMdly83MaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745918234; c=relaxed/simple;
	bh=B0ki5WVqBAKBRusFcBBrcMjDpyZxRQJNqVD9RLqvS2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eXUCA49pVEJMn9cp/ydiaSzGA05JymVqjqPpkivAXTWk0IpddW0SdU7oxeLojEKIasFrmPkA5BQ8lrX3D9fLNCdyaE9PanapTelSWXARyxTEMEjxkOQRQcI0xSJVlErP0GK0PRWJcL7JSg43cIKwTld5lXStnGgJptp9XKW3cGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tqqv2JPb; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tqqv2JPb"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e7329792c6eso2250609276.1
        for <linux-mmc@vger.kernel.org>; Tue, 29 Apr 2025 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745918229; x=1746523029; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9AFZuP5QCiVw2bvfwORhzfZHSaEjFI09KNVHM5hnVfQ=;
        b=tqqv2JPboip4waBsxCUxEc1fWSpcBjV68m1ENkXsLyc07SA5iztnY9ba+hkmsicL6k
         5THEQU7YmL4dgxrOlvKDq3aIaxR+ukqXP1cks2h3ZbOuraPbjQf3CpEiYBDyA9A/aNg4
         xF6ruBnofXe+Z09lOeunI0qVM1ws13x+pw0lvszRPPWEmb4CNHZRpjTF7GWC+AdSaIkb
         MpTS9wqehY/N31g8epy+eFvbT+SHNFGTE/oixVAJ2e0zvMTxpx+AcQdVDnEjVsTLbS2w
         z6dxEBTg3krg8gaVntBROF9xh9LdVzVE/L/MFe3AL4Fdk6/Qs5O5bw21UZa/C7g5Pm5R
         4S6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745918229; x=1746523029;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9AFZuP5QCiVw2bvfwORhzfZHSaEjFI09KNVHM5hnVfQ=;
        b=ohkd7il8Sy2j1cUlQpFFFutxhq3RYW3EQKEOj9qkCzXpMCH9dkqMUDoEl8YwStW6Z1
         4Ftw2GjarVEoHKYclnCTLO8kwMTESZqqMkAwNolFXWv6UpS8PH4gyBN5jGTqfzqiNnSk
         2jgcLQQUFfKGKfgNqsZjoSjfPZ0Zdex6L8kBfMquzCWApEfoI5JC3kQuBzNW4z9c3Elg
         BZs/ZgfzRMXyW3Q9uDlAQXhnH5eGzpYddLam7NhVCUsH+6HUjEMSSIu5OBSsqF1bxExG
         5ewp84K8VLY3kC0bwcuCZ8i64mO4CENN6rsdSQsgQTv71cRw5i9O+hEB9VBGo8+DrpDg
         w+mw==
X-Forwarded-Encrypted: i=1; AJvYcCUMU/W6xROzWngMJC5pofjzesQgzR/8kIfcTMCXRDjSlVQJDTET+bSqVrWk9t766rT1GsUw0HWGLRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl3o76qs7l+ru4cmyR2QvV/vgpxAPrus5iNz/YOoPmY4/dnhNm
	PBK85mmcA0ejl/sptHRb7Eb57KZ0k59XwbwQKSqewrjiD951jure0Nv3CHUjWMtrA0GhQHwhweM
	Iok0ggjS2ri4JonwNH5hlx+sMh1adCqjtgEKTGA==
X-Gm-Gg: ASbGncuxdhXQQxsiremCB6YzYkZICNej4DnIsUTV25UwCmI91ovvu5mMa3Haodjrg0w
	EsrOp1pDYiE9fRbOwHBUNwiRfQcrCFdV2oku9F0yE4Ubjn0ZONYDRazelqE1a1jrD8jR/a4Jz38
	jm5x/LLnCHoms787HZ1HPeqoU=
X-Google-Smtp-Source: AGHT+IHzF99Jc5zjHiTwpYwDuGNz5KeVf6zfylnYOW5l1S9c2m17qhd0GLM02sExOq6djyUCeukxpH9Gv2n/QOZUitk=
X-Received: by 2002:a05:6902:2085:b0:e72:ecd8:6d51 with SMTP id
 3f1490d57ef6-e7323471842mr15952277276.46.1745918229201; Tue, 29 Apr 2025
 02:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250425111414.2522-1-wsa+renesas@sang-engineering.com>
 <CAPDyKFqxHd85DsUH6eZVyoocTDrvwNu+wTLRBq-jUwDY+2iFTg@mail.gmail.com> <aA-yRD3FX5Nr9ypK@shikoro>
In-Reply-To: <aA-yRD3FX5Nr9ypK@shikoro>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 29 Apr 2025 11:16:33 +0200
X-Gm-Features: ATxdqUERauDj9X-EyfbLPJoHlMhqfczBHusMUQhGDJMr2QFYf9GT2Yl7ZA3WSRs
Message-ID: <CAPDyKFrWrw4ZthJ_GGZQ-qtgrPjQ2j0BoJTVbHH_qA1oTMt0kg@mail.gmail.com>
Subject: Re: [PATCH 00/11] mmc: rename mmc_retune_* to mmc_host_retune_*
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Aubin Constans <aubin.constans@microchip.com>, Ben Dooks <ben-linux@fluff.org>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Eugen Hristev <eugen.hristev@linaro.org>, 
	Fabio Estevam <festevam@gmail.com>, Haibo Chen <haibo.chen@nxp.com>, Hu Ziji <huziji@marvell.com>, 
	imx@lists.linux.dev, Jaehoon Chung <jh80.chung@samsung.com>, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Michal Simek <michal.simek@amd.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Patrice Chotard <patrice.chotard@foss.st.com>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, s32@nxp.com, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, Viresh Kumar <vireshk@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 28 Apr 2025 at 18:52, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Hi Ulf,
>
> uuuh, I overlooked this mail, sorry!
>
> > Sorry if my suggestion was unclear. I only had the MMC_CAP|CAP2_*
> > related functions in mind. I think we should leave the mmc_retune*
> > functions as is as they are not "can" functions.
>
> I agree. I suggested that in my initial series, too.
>
> > mmc_host_cmd23, mmc_host_done_complete, mmc_boot_partition_access,
> > mmc_host_uhs. All in drivers/mmc/core/host.h
> >
> > According to your earlier renaming series, we should rename these function too:
> > mmc_host_can_cmd23, mmc_host_can_done_complete,
> > mmc_host_can_boot_partition, mmc_host_can_uhs
> >
> > Does this make sense to you?
>
> I don't know these functions well, so you are probably right. I'll look
> into it. One question: do you really suggest:
>
> mmc_boot_partition_access -> mmc_host_can_boot_partition
>
> or should it be:
>
> mmc_boot_partition_access -> mmc_host_can_boot_partition_access

The name tends to be rather long, perhaps while at it move to
mmc_host_can_boot_partition and rename the MMC_CAP* too?

>
> ? I tend to think the first is better, just making sure.
>
> Happy hacking,
>
>    Wolfram

Thanks and kind regards
Uffe
