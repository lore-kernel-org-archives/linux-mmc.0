Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4ED12BF2B
	for <linux-mmc@vger.kernel.org>; Tue, 16 Apr 2024 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713272843; cv=none; b=CbF+BXSDxva++nwno01j9scY+2Ute3EwRBqvEWt2ZS6yBJFltKSMVISCmpOV75HDWsBXKOchziFFU9QN+nmVEhVd+Ek8slZf+TEZKhY7obctMeXmjFdRwlmwmGAFFyDjC0wK1rxdAULdR7tJRNQLeBw9BGYf9bxlInmef3T38FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713272843; c=relaxed/simple;
	bh=HmvXI03R5pI/zAKZJlsrVo2+wK/0GPdxyq1DQa8OqhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEV9kvXQuorwD6bA/bi4GXxqoRa52DI5e8nVExX37b6/VF3mn1UAzq+dkAVwGF2G9CJ/56aEf9m0fhfpSNLNIDVRMrUKaQI66tsio9U/Ho8tJB8tKa2xe/290LFReL7L5hu2Pz5BKCbfyKnq3Mnos/ofQ7WwC2WtKARmBl12qQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DWmgPb0N; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWmgPb0N"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61804067da0so44114107b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 16 Apr 2024 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713272841; x=1713877641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t1wZ4RlxPXvTNTt155bxNVqHJ65kss0cZ6zzPcL8MBU=;
        b=DWmgPb0NmQOrd4jA1gi3TbyCJ67dSQiZf07YA1YuXkzXtF9tln+KzWyrsngwt+NHB1
         tjIFhiZIOrAqFDnjtDKyM2hyIuRhCVd9P55wFy16augpprdz47xpdgMaDuC/KXZ/1CpK
         PKM2JakGzGJe+OjDGiu+hbQqNVv9W1ygBtYdKlo9Vbhau/f8XPS2rjzSGgynHVd1yteo
         iq5oBzROFj8r3kC3JNBpk7c/7FQ+QopXkckH3hLN7XoTwci7E3SMgRPSxS/vEQFxMYJM
         MoyZqSKQGJdGhJgQJN4ymEZ0TLRZO0UYh6+Nbz6nzx2obqw2XnpvClZlRMXMpUNtpZEW
         8qnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713272841; x=1713877641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1wZ4RlxPXvTNTt155bxNVqHJ65kss0cZ6zzPcL8MBU=;
        b=daLrHeJJC1qwdZkrVUxvCOJN7NeMe6iByrS2fM1U35OtwMRmSlj88SrX8lkK5GicSF
         wPpiLWJAp44cfd+oHv4huU3Cmx9YJ4l3VboaADHLVL6E3JEqPHxTrHUyGIZf3ikYsz1B
         zvKYGt+4Oct2Iuy4OEI1Il0O9RlQGnisLbqN8gxPhJbt7ZyLHBPdhaHP5ZH9uGkMbiyM
         VY7NXux/eoLD1bEFa/Mf4JQXItg+LW8FQGvqjtDMsto8EcNyko965+duwo8a4DP77D+Z
         E46HfjPHw02KKRqBkZH0U2xA+zLRZjrMDZ48IrK4rthZCAMp051aGvwX2/3orpaWig90
         Sg3g==
X-Forwarded-Encrypted: i=1; AJvYcCWyuF2U47G77fNjpDk/45YUk092O+CGTddXw+3yi++WwNpriVLtOEIk+Azx6iv6+lMH+ar8u4ZLyaCNalePq9qRX6eA6uSVpFEk
X-Gm-Message-State: AOJu0Yz9WdOsN7VpnYGn425gNaWCd6/weyd20nbzf7bZQuQaVMLR+QLQ
	otI9NrNlc8L+DXRhh5Vl3kGss95Y1FQxnz8icklnNfacV5j89gisCgWegNj+PwiBtxZ5WlcYUan
	hXN93qPZtyC6gsRWGubTcOH7MN6egWfUnRXtpFA==
X-Google-Smtp-Source: AGHT+IHb8YezJrIKOfLoMoc7uIpD4dtBShh3owNc8+qLs30nvSoLDk2eI9a8QHBtTaFEE0X5MmFpb8tz5c6JqPQMdjY=
X-Received: by 2002:a81:7e06:0:b0:618:517b:9dcf with SMTP id
 o6-20020a817e06000000b00618517b9dcfmr11136789ywn.22.1713272840743; Tue, 16
 Apr 2024 06:07:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713036964.git.andrea.porta@suse.com> <8fb5dde9404875777587c867e7bdb4f691ab83f2.1713036964.git.andrea.porta@suse.com>
In-Reply-To: <8fb5dde9404875777587c867e7bdb4f691ab83f2.1713036964.git.andrea.porta@suse.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 16 Apr 2024 15:07:09 +0200
Message-ID: <CACRpkdYmfEz-eM_R3ifGnbu6saL4Fd60D2ksyCr0SW0X6M_1VQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] pinctrl: bcm: Add pinconf/pinmux controller driver
 for BCM2712
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kamal Dasu <kamal.dasu@broadcom.com>, 
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Jonathan Bell <jonathan@raspberrypi.com>, 
	Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrea,

thanks for your patch!

Some comments apart from was said already.

On Sun, Apr 14, 2024 at 12:14=E2=80=AFAM Andrea della Porta
<andrea.porta@suse.com> wrote:

> +#include <linux/pinctrl/consumer.h>
> +#include <linux/pinctrl/machine.h>

Really? Why?

> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/pinctrl/pinconf-generic.h>

I would just expect these.

> +static int bcm2712_pinctrl_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       //struct device_node *np =3D dev->of_node;
> +       const struct bcm_plat_data *pdata;
> +       //const struct of_device_id *match;

I don't know if others commented on it but drop all commented-out code
or make use of it.

Yours,
Linus Walleij
