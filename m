Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925244C7A
	for <linux-mmc@vger.kernel.org>; Sat, 27 Apr 2024 11:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714215762; cv=none; b=lBWWqVnyayNqjAPw6vnRMdlv9RVoNKfno+ghBHzcrKtOsDq6X9kqhasEzP3YnpFcVilnwpvyUzzU8M9EcOmYhs52aCc2mUbV3CfG64SQu+KTHiBX00Dxxov6g4ZOkSxb3Tpx1hqA5qeW5RxHJPs1QUR146sOiyVWSAsANbyjsv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714215762; c=relaxed/simple;
	bh=SdVWyGuDCcQrIJ7fzWwR31HxNpM16sH3dH4YrTuBW6s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJDLTkYfCnCT7OcU1fFeqXtq0bX/JePXaFrmgfPmXjNzhhIKL1ktIu0ZouhpezUpsf3jXW18NF7Fj5583fgzRdEzD78JzlcgcX4W0sppvVXx3FET6CtyGkaro9bV4gOIEtz84XTyBAVGLX1zmcafNuReRGionn7TRSyptBZQY4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=L8Jv+9da; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="L8Jv+9da"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso409785966b.2
        for <linux-mmc@vger.kernel.org>; Sat, 27 Apr 2024 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714215759; x=1714820559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vw7YIWRgewiIjaQbILnrrX2snAdB7TalnWcaho2WU3o=;
        b=L8Jv+9daB332PLjvd4UFkr+9PNEDKLJtxZf85f4qL6T0VNvTHsQylSdlFHM/Wc0vva
         D/21lb9dpPSTM+DfwM2sdIY95boCtHze3kggayx0ysSeyg3Ylq6PNW1q4uQVVdc7LSxz
         R0tToW1r65zDtuswtPAXYhT2im59oTsVU2tvM55KGQAec6GNkZGD2rQczSjvPNcBW/ra
         YNQPLGpL3RO7fAPPWw8SvyXVcmgLIZF8ASmJy4/lvyK9S41pTif5VnAL6PHTTaK0m5/H
         vkGdOTIb6VMo8/+HBYYcZkILELGSh/BOQEEHeccfyX/Isvq01+MLMYCsefpdZuGCSFT0
         zrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714215759; x=1714820559;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vw7YIWRgewiIjaQbILnrrX2snAdB7TalnWcaho2WU3o=;
        b=B8IMV5f2Zdl/L4284wfn7RAol9g5khXYp8Q3TqEfZoF7k1NaWfgW+MaFf2CAkdegA+
         1m5ElwbHcvuhmkA280HqyBaRtWuP1siKc1ZoiJLv8GxKrpWOuJIeOJ2zaeLTOdqDFaZm
         x+nx1Ey0zfTwFlICR4wWlIAvkAZLog/z0m4IrbuO2mOsTAKttPEXC1+SAwRA/TmYZjIb
         M0ZpWTRCtu0q7DCggJ12/AIcpTAZTuFF9CAyCiRkV2Ott93L2mYWSHYm0gCuC14IcBP7
         Kq4mDd6Gm8xO6C/MWsokOkyddA/IsUOi4rVVoD/ekV6tVECJ3v53yIEXEXx9NFGlWSVv
         fBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3b5H2D4ygTCKu2cWi809k9DXzo6U0//Qy9dImFg9Eyze4GneeK4X/xL3wsHcPoF33i6jkAuTN99pDmWqy5eX7yXfwFSGXUAZo
X-Gm-Message-State: AOJu0YzzeCZna1cAXNU+Duzr7z6jaNawG3dH7lZzW90GB3P4t1rbfmyY
	Ui5nKh5gBNs8V/0Y0l1k2WKirpqpTYMwOAhPbowxaZ31cYPzMOTabySdg9IPb+c=
X-Google-Smtp-Source: AGHT+IGD03B2i7PKMy6HkJBPlBDJAzn/QclUOnQKtoK3JDSXtq9G1ETAVHvABI1pCX1NQAJQ0I3ePA==
X-Received: by 2002:a17:906:1759:b0:a58:7f48:18c4 with SMTP id d25-20020a170906175900b00a587f4818c4mr3406243eje.68.1714215758684;
        Sat, 27 Apr 2024 04:02:38 -0700 (PDT)
Received: from localhost (host-87-1-234-99.retail.telecomitalia.it. [87.1.234.99])
        by smtp.gmail.com with ESMTPSA id le23-20020a170906ae1700b00a4e4c944e77sm11516281ejb.40.2024.04.27.04.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 04:02:38 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Sat, 27 Apr 2024 13:02:39 +0200
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 3/6] arm64: dts: broadcom: Add support for BCM2712
Message-ID: <ZizbT4Qo0XFB2m4A@apocalypse>
Mail-Followup-To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <0ab5a768d686cb634f7144da266c9246e9e90cb4.1713036964.git.andrea.porta@suse.com>
 <198793bf-5ec8-4f33-aae7-75c635f900ec@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <198793bf-5ec8-4f33-aae7-75c635f900ec@broadcom.com>

On 09:01 Sun 14 Apr     , Florian Fainelli wrote:
> 
> 
> On 4/13/2024 3:14 PM, Andrea della Porta wrote:
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> 
> No commit message given the amount of lines changed?

Ack. Patchset V2 will have a commit message.

> 
> Please split this patch into multiple series that add basic 2712 support to
> the mainline kernel.

Please, can you elaborate a bit further on this?

Many thanks,
Andrea

> -- 
> Florian


