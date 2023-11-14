Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F871173D
	for <linux-mmc@vger.kernel.org>; Tue, 14 Nov 2023 11:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WbEcUmC8"
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B832CD9;
	Tue, 14 Nov 2023 03:06:40 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2809b4d648bso4586283a91.2;
        Tue, 14 Nov 2023 03:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699960000; x=1700564800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlsGw7et8eLr+Jq6nhWfBbhkvxoUPbPT8GRbIrxe+No=;
        b=WbEcUmC8cz7ar2Ez/J4j2bmAPmzbchlR6zvLZPiVdhQ5Ho2KCwlhYyngsO7JRmdrrN
         pgYnPWpiRkLk0PfEzPwifjIeeZkh+6ho4EplEg4qT54bHKduFcnab6Vu/NokCJ67Z1FD
         X9WsPMlkDflj+Bqz4Vvzu4n7amu1YuIeXCHzD1zOrIcEcw0T6YIX80LrlNHQU+2p8zlt
         h/Be3DKU5MIDv/cD4WL99gMwH0gDn5O818paF7/cMqknWbqNgr5F1ObXwUCH6Mpet9h9
         UfCVQI1bcuS5i2YMMNz02lLKLgK+rT8MkCqqgctIqCwf1nZCyCV8aRl9tdbQbB9MXzGl
         CbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699960000; x=1700564800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TlsGw7et8eLr+Jq6nhWfBbhkvxoUPbPT8GRbIrxe+No=;
        b=cf82Ys92myPAE8lggBf6RqXLeMsvMiIC5kmatGPhKj2z78tpllmDwkswO+JvyBypCq
         1Lh9FiPFWQ8ssA9neFTwNqbPWXBvvGSa7He8D2xiIthAZ12Hz4o1i69XS3A/I3x1juV9
         wEe9A0mookLNXOiynQlz/M8ZCnN6w0muxgiYdcE5gtNYpiZTyOFYYNUp67KlKYvctvhp
         aFzVc6v1FeSxb2AdIkLsMOKwTIh+dxVGq9GJi8KbXepi+jUwnvwkj6ehZvjpZXqITgCo
         lsupAW9iQ7EYaCVP/MvgN61hTo/e2d1BKlc/s91+sAXoDhCMD8i+eYosO4ZCqO7zuTC7
         dM7w==
X-Gm-Message-State: AOJu0YzljDpCWfWuDnnnjGTR7k7VolQYDfasRzYdNdXUsN0+y20TdRlN
	dfPdtOKljTzrIBTVkiJCVDzqYIe4dqXXjojihck=
X-Google-Smtp-Source: AGHT+IHVuEuZixW3PXUWTNy3iOqK6PwYb6Th4QR+NyQw8dXBFabRUAdwdFNl5cB9iyDXR1d+/KBpRPhw2pbfUD2cKe4=
X-Received: by 2002:a17:90b:38d2:b0:27c:efe3:89dc with SMTP id
 nn18-20020a17090b38d200b0027cefe389dcmr6832222pjb.14.1699960000056; Tue, 14
 Nov 2023 03:06:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230830092314.624212-1-mathieu.moneyron@gmail.com>
 <096e9122-23b8-5a36-7779-28994187c620@intel.com> <9a311ce3-0d29-af39-5533-c1cad6de1300@microchip.com>
 <CAKmtTBYquiYQ-=MVWCqH8=iiFONvt6B_==EZhWsQkSA8WNuYUQ@mail.gmail.com> <c8178e61-31c1-4eb3-9d04-7aa70ed18634@microchip.com>
In-Reply-To: <c8178e61-31c1-4eb3-9d04-7aa70ed18634@microchip.com>
From: Mathieu Moneyron <mathieu.moneyron@gmail.com>
Date: Tue, 14 Nov 2023 12:06:28 +0100
Message-ID: <CAKmtTBbsXgWuT__kkPneRKpveUO24pJqFn+aAa9-3n11Pu0PwQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: Fix force card detect in sdhci
To: Aubin Constans <aubin.constans@microchip.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Eugen Hristev <eugen.hristev@collabora.com>, 
	Ludovic Desroches <ludovic.desroches@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, linux-mmc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 8:57=E2=80=AFPM Aubin Constans
<aubin.constans@microchip.com> wrote:
>
> On 23/09/2023 16:23, Mathieu Moneyron wrote:
>
> In the device tree, has PIN_PA13__SDMMC0_CD been removed from the
> pinctrl for sdmmc0?
Yes the pin is not present in the pinctrl. Only PA0 to PA10 configured as
SDMMC0 function.
>
> In case the above behaviour was due to hardware, it would likely point
> out a flaw in the Parallel Input/Output Controller (PIO) rather than in
> the SDMMC Controller.
>
> Would you read back the relevant PIO_CFGRx register, with only "PA13"
> set in PIO_MSKRx, and provide me with the value read?
> Assuming PA13 is Non-Secure; if PA13 is configured as Secure,
> S_PIO_CFGRx and S_PIO_MSKRx should be accessed instead.
I'm not sure if that's the best way to achieve this but I enabled debug
messages in pinctrl-at91-pio4 driver.
The messages I got regarding the PA13 pin is the following:
'enable pin 13 as GPIO'
With PIO_CFGR0 register for PA13 only is 0x0400.

Also from PA0 to PA10 the pins used for the in the mmc pinctrl:
'enable function A group PA0'
For all these pins funcion A is SDMMC0.

Also as a side note, I will no longer have access to the hardware from the
beginning of december as I have resigned from my current job.

Best regards,
Mathieu
