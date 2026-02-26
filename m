Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9342749E6
	for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2026 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100549; cv=pass; b=ot7N5QWHiTaqDAiEH37PrYrjJA0rzC73KwZ2zFw8IjBt3rdAJO+ZFaNwkvdGjPesMYkPgu+WQeYml3d/26ov6dWXvtuZ+EaKFJBOua8/XSRQNEIKwgErfTF0njNPyz06GojQISfRAOMEynvuoZICIb43R+4uJJ2JA75toTCubyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100549; c=relaxed/simple;
	bh=EQ9Zv3knqnt6ZZnEFeatyYweXaGIe5Cyr76dZiofxB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxJR4Npylss6HQV2tWhcMKu+1EpgLQjMoNtEgNQkgocmC0fU1wNUuUAhkDgPWW4aFVzBJK0X42XJm1BkbaiOb+WBNVSghuI6RBA8Asb47jCcpJHL3/09IGOau6AAXt7m5EQjOUWVzvgsFubUNSXGqhihq4pby+vBuQyIZWqLK+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaLwqaMa; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaLwqaMa"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1277d379936so768525c88.1
        for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2026 02:09:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772100547; cv=none;
        d=google.com; s=arc-20240605;
        b=H4SMHJnLWtiUpbikzn46vYdaVuJ5DlgtWF6wwLMh2Adi9McyMu4tk8C3MQOXU6/KCI
         o5yKkDBew8aICL0tGd4odgFWjv85H22i+sWAEMu8lUgOO1CdRGkKiI9D90tmvhIY4LoV
         oQ+y9HC0bI87iXqJKKAKHk10xaXfJ0zedm4YpsHaA7KacT0DpOu1JjrVCnaHMFlYSDFM
         D0uzUQfQZWrKeZ6TJSVSOj3hFWJ7YuFZTnedo09zkCVNk+FVLybCbTDUXM4z3B+TwpJi
         W+zzBF9FnDUvY9ujy7/O8ptSAr/ua9ge8dyELYvvCjK/zx5IiS+NRLNZeREItxM0lNJh
         QzGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+pi8udncsL2BoITAHNdx69OrjXUQmhVzhrxoQ/FaM6Q=;
        fh=Id5kIwi3j355aBykCFg2NfLqVWKv3BYnAXaopmOIhU0=;
        b=OBJ+uz0Ds0VpXP+A6fJS5/Qgfk/eUHYVwlomrFAQky4EM0A4Wu+uCxDQM/83Ba8SpI
         32fRovYmou/OR0Lb9ffOd2/yiGmXXyTkXmxofn30XBII9FWbrfQCYZfCvQAUABG14dJQ
         duiM84fZbMp7AxOvO0dSbpRfdOBxy7VzFikXNoXBKh57B59uv5J1sSEnP+aVHyd2+WHn
         rKTNmduVgeaNy5lceLdiWGi7mm8jMIquSpYQyfFikII2mQT4VcrBmwFUHbaFzPn9a7s9
         dbeDh+iTlgWr1K6rb/lSaiTRv187zjjlRf1w6yDm1Uu+PB4EFelzXrkVa94Kju+4Ud/9
         nLxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772100547; x=1772705347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pi8udncsL2BoITAHNdx69OrjXUQmhVzhrxoQ/FaM6Q=;
        b=kaLwqaMayTLPp0Mo5ePANPDObEL0+mIapFBnlQrkU+W+BAvuTLLwAgf4btQAcoktHV
         qo1xuikWqbzTbCHWl8duqxOVgiWa3Dh2fBnmj4+rITsEnv+B4yI1h99P0YuImT0k/bX1
         5KeaLSYbXh8GCT4UpoL0m8PXK4YqPaVZS2ofICrEYprV/3qlms4/+T95AOQScPLka6b4
         1XSfEk6Mm1igJov3bjxjG3D4O0hBt3SChlmmWEn/MES9ky8igL38GZbxOoO/Pbf8+jWu
         w55UDlh5ze9JMD+jNQrltFaQSwnAl0/0aOaXZ2hAhjikDdSr/yFU/1wRUAVRw1Fmo4Nt
         XQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772100547; x=1772705347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+pi8udncsL2BoITAHNdx69OrjXUQmhVzhrxoQ/FaM6Q=;
        b=dy8zVGGvPIxqaiN3AmYrSrgzxaQaB5lNvpJ5MN9UBtYDkSZppSdi0+p70n2mBeGO+Z
         WsGhjxaPnuKpNkeo1voDa98tQs2z/YKWOLVvueFf0tIgg7ni64MHgtk5n+iQM9/f8A3I
         G4xqMs/dUz5VVKEIv4J2BeIwaXpnW4LXNK4RBzs+2egiSrxKbF9YuEEx2wzvzRWIkmLb
         Ea4lm4KQMKgZqXj/pR2evm+TMeb/pRot9/tDjexre8OjlnnfqDCLMQVXfrkzr+Z6Ms7n
         A18MAaB1DdmHFIIcE0J6b9I5CgaDnFp29fmwp/7oemUB+MdkTHnPsM9hFgtKLlnSkpPw
         JN3A==
X-Forwarded-Encrypted: i=1; AJvYcCVWWKVjwdH/gWjznCX94q9RMaxPvwTrdUfX6ucX2k8WHjiVlmJpLvx+K+zNXvHBv27NC9Y0+o+G8hg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyax4RZCq2ehUvwJYV7Wy7VQpFbqetX1AQgfbdNIwMdJRIZcOqv
	5D/wHW1+I4XpYq1tqLTmffokfG+3wgT49zFe6RrQ2qw5gDzacJWWpZ1qn7UIBq6aQheYg0NmUBx
	Pymxir/WAUChQuRAakSNINyx1Dk6nI0E=
X-Gm-Gg: ATEYQzxnSVz936dFAv8TNKGA3w8hrg4Hf/SgVp1NtruJVjNr6DUOnfCv3yhxp2YK79I
	SxlHWyxLUWcul0a/BeomBC55nA4R01chtlaah5IuqK+48/RN5MDiqGlaKHTgOYi0URztyioWMP3
	uEnf2W+TBGc2BMM9QG1Vhs8LI0V3UXiClJ/oZtAQo+A/r23PfKly39kA3gYkLiqhXS+RibCXoSz
	eOX8c+COpV4TsJ8hqv8b2unEnozoC+xivEAWMZn0gfNaS7t1g7OPHlkPSdQjITLrhMamM8oWfx1
	/Wa23vh9uBetbwtcfNBfnDJJMwiF38gwXydFsBidEg==
X-Received: by 2002:a05:7300:e810:b0:2ba:72c3:53c0 with SMTP id
 5a478bee46e88-2bdcbdfe38fmr1530092eec.0.1772100546418; Thu, 26 Feb 2026
 02:09:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260117234800.931664-1-matthew.schwartz@linux.dev>
 <8efb0406-b9ce-46ec-bd8d-4763c12298e1@intel.com> <TYZPR01MB426077A7AB8CE602ECA2CAF4D766A@TYZPR01MB4260.apcprd01.prod.exchangelabs.com>
 <655ee663-b331-4dcb-bf85-0e40c1b5191b@linux.dev>
In-Reply-To: <655ee663-b331-4dcb-bf85-0e40c1b5191b@linux.dev>
From: Ben Chuang <benchuanggli@gmail.com>
Date: Thu, 26 Feb 2026 18:09:05 +0800
X-Gm-Features: AaiRm53662tABZ22Cv5jQ-VS3K13-AFpF667BitAEIwLtu4QW4Wjyl_0BwB_ozw
Message-ID: <CACT4zj8dJAD5CM3HtEhWP1hEnAp=MygFg8Uhx7UJxFFPbd-dxg@mail.gmail.com>
Subject: Re: [RFC PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corruption
To: Matthew Schwartz <matthew.schwartz@linux.dev>
Cc: =?UTF-8?B?QmVuQ2h1YW5nW+iOiuaZuumHj10=?= <Ben.Chuang@genesyslogic.com.tw>, 
	Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Victor Shih <victor.shih@genesyslogic.com.tw>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 6:00=E2=80=AFAM Matthew Schwartz
<matthew.schwartz@linux.dev> wrote:
>
> On 2/6/26 12:05 AM, BenChuang[=E8=8E=8A=E6=99=BA=E9=87=8F] wrote:
> >> -----Original Message-----
> >> From: Adrian Hunter <adrian.hunter@intel.com>
> >> Sent: Friday, January 30, 2026 6:53 PM
> >> To: Matthew Schwartz <matthew.schwartz@linux.dev>; Ulf Hansson <ulf.ha=
nsson@linaro.org>; BenChuang[=E8=8E=8A=E6=99=BA=E9=87=8F]
> >> <Ben.Chuang@genesyslogic.com.tw>; Victor Shih <victor.shih@genesyslogi=
c.com.tw>
> >> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org
> >> Subject: Re: [RFC PATCH] mmc: sdhci-pci-gli: fix GL9750 DMA write corr=
uption
> >>
> >> Genesys folks : Any comment on this?
> >
> > Hi Matthew,
> >
> > Could you share the 510h register value on your computer under Windows,
> > and the 510h register value under Linux when the f3 test is normal and =
abnormal?
>

Hi Matthew,

> Hi Ben,
>
> Apologies for the late reply, I was taking some time off. For reference, =
the device in question is a Lenovo Legion Go S which is a handheld gaming P=
C, and it has an AMD Z2 Go APU.

This is a performance-oriented gaming device.
Thank you for sharing this information.

>
> Under Windows - I used RWEverything, unsure if there's a better tool as i=
otools only seems available on Linux:
>
> Type:Memory   Address 00000000B0AFF510
> Width:01
> 00=3D0F 01=3D00 02=3D00 03=3D00 04=3D00 05=3D00 06=3D00 07=3D00

R_OSRC_Lmt (bit 16-17) is zero.

> 08=3D00 09=3D00 0A=3D00 0B=3D00 0C=3D00 0D=3D00 0E=3D00 0F=3D00
> 10=3D00 11=3D00 12=3D80 13=3D0F 14=3D00 15=3D2A 16=3D00 17=3D00
> 18=3D00 19=3D00 1A=3D00 1B=3D00 1C=3D0C 1D=3D00 1E=3D00 1F=3D00
> 20=3D00 21=3D00 22=3D00 23=3D00 24=3D00 25=3D00 26=3D00 27=3D00
> 28=3D00 29=3D00 2A=3D00 2B=3D00 2C=3D00 2D=3D00 2E=3D00 2F=3D00
> 30=3D00 31=3D00 32=3D11 33=3D01 34=3D07 35=3D00 36=3D00 37=3D00
> 38=3D00 39=3D00 3A=3D00 3B=3D00 3C=3D00 3D=3D00 3E=3D00 3F=3D00
> 40=3D00 41=3D00 42=3D00 43=3D00 44=3D00 45=3D00 46=3D00 47=3D00
> 48=3D00 49=3D00 4A=3D00 4B=3D00 4C=3D00 4D=3D00 4E=3D00 4F=3D00
> 50=3D00 51=3D00 52=3D00 53=3D00 54=3D00 55=3D00 56=3D00 57=3D00
> 58=3D00 59=3D00 5A=3D00 5B=3D00 5C=3D00 5D=3D00 5E=3D00 5F=3D00
> 60=3D00 61=3D00 62=3D00 63=3D00 64=3D00 65=3D00 66=3D00 67=3D00
> 68=3D00 69=3D00 6A=3D00 6B=3D00 6C=3D00 6D=3D00 6E=3D00 6F=3D00
> 70=3D00 71=3D00 72=3D00 73=3D00 74=3D00 75=3D00 76=3D00 77=3D00
> 78=3D00 79=3D00 7A=3D00 7B=3D00 7C=3D00 7D=3D00 7E=3D00 7F=3D00
> 80=3D00 81=3D00 82=3D00 83=3D00 84=3D00 85=3D00 86=3D00 87=3D00
> 88=3D00 89=3D00 8A=3D00 8B=3D00 8C=3D00 8D=3D00 8E=3D00 8F=3D00
> 90=3D00 91=3D00 92=3D00 93=3D00 94=3D00 95=3D00 96=3D00 97=3D00
> 98=3D00 99=3D00 9A=3D00 9B=3D00 9C=3D00 9D=3D00 9E=3D00 9F=3D00
> A0=3D00 A1=3D00 A2=3D00 A3=3D00 A4=3D00 A5=3D00 A6=3D00 A7=3D00
> A8=3D00 A9=3D00 AA=3D00 AB=3D00 AC=3D00 AD=3D00 AE=3D00 AF=3D00
> B0=3D00 B1=3D00 B2=3D00 B3=3D00 B4=3D00 B5=3D00 B6=3D00 B7=3D00
> B8=3D00 B9=3D00 BA=3D00 BB=3D00 BC=3D00 BD=3D00 BE=3D00 BF=3D00
> C0=3D00 C1=3D00 C2=3D00 C3=3D00 C4=3D00 C5=3D00 C6=3D00 C7=3D00
> C8=3D00 C9=3D00 CA=3D00 CB=3D00 CC=3D00 CD=3D00 CE=3D00 CF=3D00
> D0=3D00 D1=3D00 D2=3D00 D3=3D00 D4=3D00 D5=3D00 D6=3D00 D7=3D00
> D8=3D00 D9=3D00 DA=3D00 DB=3D00 DC=3D00 DD=3D00 DE=3D00 DF=3D00
> E0=3D00 E1=3D00 E2=3D00 E3=3D00 E4=3D00 E5=3D00 E6=3D00 E7=3D00
> E8=3D00 E9=3D00 EA=3D00 EB=3D00 EC=3D00 ED=3D00 EE=3D00 EF=3D00
> F0=3D00 F1=3D00 F2=3D00 F3=3D00 F4=3D00 F5=3D00 F6=3D00 F7=3D00
> F8=3D00 F9=3D00 FA=3D00 FB=3D00 FC=3D00 FD=3D00 FE=3D00 FF=3D00
>
> Under Linux with abnormal test:
>
> deck@steamdeck ~> sudo iotools mmio_read32 0xb0a00510
> 0x0303000f
>
> Under Linux with normal test (i.e. with kernel patch):
> deck@steamdeck ~> sudo iotools mmio_read32 0xb0a00510
> 0x0300000f
>
> >
> > These two bits 510h[17:16] (R_OSRC_Lmt) on GL9750, are likely used to l=
imit requests.
> > Additionally, 510h[25:24] are similar but marked as W_OSRC_Lmt.
> >
> > I tested the demo board I had on hand with an Intel PC, and I didn't re=
produce the issue.
> > The test information is as follows.
> >
> > --
> > $ sudo f3write -e 3 /run/media/gli/sdsamsung/ && sudo f3read /run/media=
/gli/sdsamsung/
> > F3 write 9.0
> > Copyright (C) 2010 Digirati Internet LTDA.
> > This is free software; see the source for copying conditions.
> >
> > Free space: 29.00 GB
> > Creating file 1.h2w ... OK!
> > Creating file 2.h2w ... OK!
> > Creating file 3.h2w ... OK!
> > Free space: 26.00 GB
> > Average writing speed: 21.17 MB/s
> > F3 read 9.0
> > Copyright (C) 2010 Digirati Internet LTDA.
> > This is free software; see the source for copying conditions.
> >
> >                   SECTORS      ok/corrupted/changed/overwritten
> > Validating file 1.h2w ... 2097152/        0/      0/      0
> > Validating file 2.h2w ... 2097152/        0/      0/      0
> > Validating file 3.h2w ... 2097152/        0/      0/      0
> >
> >   Data OK: 3.00 GB (6291456 sectors)
> > Data LOST: 0.00 Byte (0 sectors)
> >                Corrupted: 0.00 Byte (0 sectors)
> >         Slightly changed: 0.00 Byte (0 sectors)
> >              Overwritten: 0.00 Byte (0 sectors)
> > Average reading speed: 70.75 MB/s
> > $ sudo f3write -e 3 /run/media/gli/sdsamsung/ && sudo f3read /run/media=
/gli/sdsamsung/
> > F3 write 9.0
> > Copyright (C) 2010 Digirati Internet LTDA.
> > This is free software; see the source for copying conditions.
> >
> > Removing old file 1.h2w ...
> > Removing old file 2.h2w ...
> > Removing old file 3.h2w ...
> > Free space: 29.00 GB
> > Creating file 1.h2w ... OK!
> > Creating file 2.h2w ... OK!
> > Creating file 3.h2w ... OK!
> > Free space: 26.00 GB
> > Average writing speed: 20.90 MB/s
> > F3 read 9.0
> > Copyright (C) 2010 Digirati Internet LTDA.
> > This is free software; see the source for copying conditions.
> >
> >                   SECTORS      ok/corrupted/changed/overwritten
> > Validating file 1.h2w ... 2097152/        0/      0/      0
> > Validating file 2.h2w ... 2097152/        0/      0/      0
> > Validating file 3.h2w ... 2097152/        0/      0/      0
> >
> >   Data OK: 3.00 GB (6291456 sectors)
> > Data LOST: 0.00 Byte (0 sectors)
> >                Corrupted: 0.00 Byte (0 sectors)
> >         Slightly changed: 0.00 Byte (0 sectors)
> >              Overwritten: 0.00 Byte (0 sectors)
> > Average reading speed: 71.18 MB/s
> > $ sudo f3write -e 3 /run/media/gli/sdsamsung/ && sudo f3read /run/media=
/gli/sdsamsung/
> > F3 write 9.0
> > Copyright (C) 2010 Digirati Internet LTDA.
> > This is free software; see the source for copying conditions.
> >
> > Removing old file 1.h2w ...
> > Removing old file 2.h2w ...
> > Removing old file 3.h2w ...
> > Free space: 29.00 GB
> > Creating file 1.h2w ... OK!
> > Creating file 2.h2w ... OK!
> > Creating file 3.h2w ... OK!
> > Free space: 26.00 GB
> > Average writing speed: 20.48 MB/s
> > F3 read 9.0
> > Copyright (C) 2010 Digirati Internet LTDA.
> > This is free software; see the source for copying conditions.
> >
> >                   SECTORS      ok/corrupted/changed/overwritten
> > Validating file 1.h2w ... 2097152/        0/      0/      0
> > Validating file 2.h2w ... 2097152/        0/      0/      0
> > Validating file 3.h2w ... 2097152/        0/      0/      0
> >
> >   Data OK: 3.00 GB (6291456 sectors)
> > Data LOST: 0.00 Byte (0 sectors)
> >                Corrupted: 0.00 Byte (0 sectors)
> >         Slightly changed: 0.00 Byte (0 sectors)
> >              Overwritten: 0.00 Byte (0 sectors)
> > Average reading speed: 71.22 MB/s
>
> deck@steamdeck ~> sudo f3write -e 5 /run/media/deck/SR02T/ && sudo f3read=
 /run/media/deck/SR02T/
> [sudo] password for deck:
> F3 write 8.0
> Copyright (C) 2010 Digirati Internet LTDA.
> This is free software; see the source for copying conditions.
>
> Removing old file 1.h2w ...
> Removing old file 2.h2w ...
> Removing old file 3.h2w ...
> Removing old file 4.h2w ...
> Removing old file 5.h2w ...
> Free space: 378.34 GB
> Creating file 1.h2w ... OK!
> Creating file 2.h2w ... OK!
> Creating file 3.h2w ... OK!
> Creating file 4.h2w ... OK!
> Creating file 5.h2w ... OK!
> Free space: 372.60 GB
> Average writing speed: 62.56 MB/s

Based on the test results (write speed: 62.56 MB/s), the issue seems
to occur during fast writing to the SD card.
R_OSRC_Lmt is zero means that read requests (DMA receive data from
system memory) are limited to the smallest unit.
So I think your patch setting R_OSRC_Lmt to zero is reasonable.

Best regards,
Ben Chuang


> F3 read 8.0
> Copyright (C) 2010 Digirati Internet LTDA.
> This is free software; see the source for copying conditions.
>
>                   SECTORS      ok/corrupted/changed/overwritten
> Validating file 1.h2w ... 2097150/        2/      0/      0
> Validating file 2.h2w ... 2097152/        0/      0/      0
> Validating file 3.h2w ... 2097150/        2/      0/      0
> Validating file 4.h2w ... 2097147/        5/      0/      0
> Validating file 5.h2w ... 2097150/        2/      0/      0
>
>   Data OK: 5.00 GB (10485749 sectors)
> Data LOST: 5.50 KB (11 sectors)
>                Corrupted: 5.50 KB (11 sectors)
>         Slightly changed: 0.00 Byte (0 sectors)
>              Overwritten: 0.00 Byte (0 sectors)
> Average reading speed: 85.93 MB/s
>
>
> > $
> > $ uname -a
> > Linux arch-pc 6.18.7-arch1-1 #1 SMP PREEMPT_DYNAMIC Sat, 24 Jan 2026 00=
:47:39 +0000 x86_64 GNU/Linux
>
> Linux steamdeck 7.0.0-rc1-1-git #1 SMP PREEMPT_DYNAMIC Wed, 25 Feb 2026 1=
8:53:27 +0000 x86_64 GNU/Linux
>
> > $ lsblk /dev/mmcblk1
> > NAME        MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> > mmcblk1     179:0    0 29.8G  0 disk
> > =E2=94=94=E2=94=80mmcblk1p1 179:1    0 29.8G  0 part /run/media/gli/sds=
amsung
>
> deck@steamdeck ~ [32]> lsblk /dev/mmcblk0p1
> NAME      MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS
> mmcblk0p1 179:1    0  1.9T  0 part /run/media/deck/SR02T
>
> > $ sudo dmesg | grep mmc1
> > [    1.557901] mmc1: SDHCI controller on PCI [0000:06:00.0] using ADMA
> > [  272.440507] mmc1: new UHS-I speed SDR104 SDHC card at address 0001
> > [  272.468419] mmcblk1: mmc1:0001 EB1QT 29.8 GiB
>
> deck@steamdeck ~ [0|1]> sudo dmesg | grep mmc
> [    1.034894] mmc0: SDHCI controller on PCI [0000:02:00.0] using ADMA
> [    1.557246] mmc0: new UHS-I speed SDR104 SDXC card at address d555
> [    1.567765] mmcblk0: mmc0:d555 SR02T 1.86 TiB
> [    1.580830]  mmcblk0: p1
> [    6.507652] EXT4-fs (mmcblk0p1): Using encoding defined by superblock:=
 utf8-12.1.0 with flags 0x0
> [    6.765191] EXT4-fs (mmcblk0p1): mounted filesystem 4d6b24bb-833f-4859=
-a85a-13e1d1dbd3d8 r/w with ordered data mode. Quota mode: none.
>
> > $ sudo lspci -d 17a0:9750 -vvv
> > 06:00.0 SD Host controller: Genesys Logic, Inc GL9750 SD Host Controlle=
r (rev 01) (prog-if 01)
> >         Subsystem: Genesys Logic, Inc GL9750 SD Host Controller
> >         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- Par=
Err- Stepping- SERR- FastB2B- DisINTx+
> >         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort=
- <TAbort- <MAbort- >SERR- <PERR- INTx-
> >         Latency: 0, Cache Line Size: 64 bytes
> >         Interrupt: pin A routed to IRQ 205
> >         Region 0: Memory at 84000000 (32-bit, non-prefetchable) [size=
=3D4K]
> >         Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
> >                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s =
<4us, L1 unlimited
> >                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-=
 SlotPowerLimit 10W TEE-IO-
> >                 DevCtl: CorrErr+ NonFatalErr+ FatalErr+ UnsupReq+
> >                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
> >                         MaxPayload 128 bytes, MaxReadReq 512 bytes
> >                 DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq- AuxPw=
r+ TransPend-
> >                 LnkCap: Port #80, Speed 2.5GT/s, Width x1, ASPM L0s L1,=
 Exit Latency L0s <4us, L1 unlimited
> >                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp=
+
> >                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- Comm=
Clk+
> >                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt- =
FltModeDis-
> >                 LnkSta: Speed 2.5GT/s, Width x1
> >                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgm=
t-
> >                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NR=
OPrPrP- LTR+
> >                          10BitTagComp- 10BitTagReq- OBFF Via message/WA=
KE#, ExtFmt- EETLPPrefix-
> >                          EmergencyPowerReduction Not Supported, Emergen=
cyPowerReductionInit-
> >                          FRS- TPHComp- ExtTPHComp-
> >                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> >                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
> >                          AtomicOpsCtl: ReqEn-
> >                          IDOReq- IDOCompl- LTR+ EmergencyPowerReduction=
Req-
> >                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
> >                 LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Ret=
imer- 2Retimers- DRS-
> >                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- S=
peedDis-
> >                          Transmit Margin: Normal Operating Range, Enter=
ModifiedCompliance- ComplianceSOS-
> >                          Compliance Preset/De-emphasis: -6dB de-emphasi=
s, 0dB preshoot
> >                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationC=
omplete- EqualizationPhase1-
> >                          EqualizationPhase2- EqualizationPhase3- LinkEq=
ualizationRequest-
> >                          Retimer- 2Retimers- CrosslinkRes: unsupported,=
 FltMode-
> >         Capabilities: [e0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
> >                 Address: 00000000fee00d58  Data: 0000
> >         Capabilities: [f8] Power Management version 3
> >                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,=
D1+,D2+,D3hot+,D3cold+)
> >                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 P=
ME+
> >         Capabilities: [100 v1] Vendor Specific Information: ID=3D17a0 R=
ev=3D1 Len=3D008 <?>
> >         Capabilities: [108 v1] Latency Tolerance Reporting
> >                 Max snoop latency: 3145728ns
> >                 Max no snoop latency: 3145728ns
> >         Capabilities: [110 v1] L1 PM Substates
> >                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.=
1+ L1_PM_Substates+
> >                           PortCommonModeRestoreTime=3D255us PortTPowerO=
nTime=3D3100us
> >                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1=
.1+
> >                            T_CommonMode=3D0us LTR1.2_Threshold=3D337510=
4ns
> >                 L1SubCtl2: T_PwrOn=3D3100us
> >         Capabilities: [200 v1] Advanced Error Reporting
> >                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP-
> >                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedT=
LP- AtomicOpBlocked- TLPBlockedErr-
> >                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- Mis=
IDETLP- PCRC_CHECK- TLPXlatBlocked-
> >                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF- MalfTLP-
> >                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedT=
LP- AtomicOpBlocked- TLPBlockedErr-
> >                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- Mis=
IDETLP- PCRC_CHECK- TLPXlatBlocked-
> >                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmp=
lt- RxOF+ MalfTLP+
> >                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedT=
LP- AtomicOpBlocked- TLPBlockedErr-
> >                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- Mis=
IDETLP- PCRC_CHECK- TLPXlatBlocked-
> >                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout+ AdvN=
onFatalErr- CorrIntErr- HeaderOF-
> >                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout+ AdvN=
onFatalErr+ CorrIntErr- HeaderOF-
> >                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn-=
 ECRCChkCap- ECRCChkEn-
> >                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLog=
Cap-
> >                 HeaderLog: 00000000 00000000 00000000 00000000
> >         Kernel driver in use: sdhci-pci
> >         Kernel modules: sdhci_pci
>
> deck@legion-go-s ~> sudo lspci -d 17a0:9750 -vvv
> 02:00.0 SD Host controller: Genesys Logic, Inc GL9750 SD Host Controller =
(rev 01) (prog-if 01)
>         Subsystem: Genesys Logic, Inc GL9750 SD Host Controller
>         Physical Slot: 0
>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParEr=
r- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TAbort- =
<TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 63
>         Region 0: Memory at b0a00000 (32-bit, non-prefetchable) [size=3D4=
K]
>         Capabilities: [80] Express (v2) Endpoint, IntMsgNum 0
>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <4=
us, L1 <64us
>                         ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- S=
lotPowerLimit 75W TEE-IO-
>                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
>                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr+=
 TransPend-
>                 LnkCap: Port #80, Speed 2.5GT/s, Width x1, ASPM L1, Exit =
Latency L1 <64us
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>                 LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommCl=
k+
>                         ExtSynch- ClockPM+ AutWidDis- BWInt- AutBWInt- Fl=
tModeDis-
>                 LnkSta: Speed 2.5GT/s, Width x1
>                         TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROP=
rPrP- LTR+
>                          10BitTagComp- 10BitTagReq- OBFF Via message/WAKE=
#, ExtFmt- EETLPPrefix-
>                          EmergencyPowerReduction Not Supported, Emergency=
PowerReductionInit-
>                          FRS- TPHComp- ExtTPHComp-
>                          AtomicOpsCap: 32bit- 64bit- 128bitCAS-
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-
>                          AtomicOpsCtl: ReqEn-
>                          IDOReq- IDOCompl- LTR+ EmergencyPowerReductionRe=
q-
>                          10BitTagReq- OBFF Disabled, EETLPPrefixBlk-
>                 LnkCap2: Supported Link Speeds: 2.5GT/s, Crosslink- Retim=
er- 2Retimers- DRS-
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- Spe=
edDis-
>                          Transmit Margin: Normal Operating Range, EnterMo=
difiedCompliance- ComplianceSOS-
>                          Compliance Preset/De-emphasis: -6dB de-emphasis,=
 0dB preshoot
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationCom=
plete- EqualizationPhase1-
>                          EqualizationPhase2- EqualizationPhase3- LinkEqua=
lizationRequest-
>                          Retimer- 2Retimers- CrosslinkRes: unsupported, F=
ltMode-
>         Capabilities: [e0] MSI: Enable+ Count=3D1/1 Maskable- 64bit+
>                 Address: 00000000fee04000  Data: 0023
>         Capabilities: [f8] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=3D375mA PME(D0-,D1=
+,D2+,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=3D0 DScale=3D0 PME=
-
>         Capabilities: [100 v1] Vendor Specific Information: ID=3D17a0 Rev=
=3D1 Len=3D008 <?>
>         Capabilities: [108 v1] Latency Tolerance Reporting
>                 Max snoop latency: 1048576ns
>                 Max no snoop latency: 1048576ns
>         Capabilities: [110 v1] L1 PM Substates
>                 L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+=
 L1_PM_Substates+
>                           PortCommonModeRestoreTime=3D20us PortTPowerOnTi=
me=3D4us
>                 L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1=
+
>                            T_CommonMode=3D0us LTR1.2_Threshold=3D176128ns
>                 L1SubCtl2: T_PwrOn=3D150us
>         Capabilities: [200 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt=
- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP=
- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisID=
ETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt=
- RxOF- MalfTLP-
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP=
- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisID=
ETLP- PCRC_CHECK- TLPXlatBlocked-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt=
- RxOF+ MalfTLP+
>                         ECRC- UnsupReq- ACSViol- UncorrIntErr- BlockedTLP=
- AtomicOpBlocked- TLPBlockedErr-
>                         PoisonTLPBlocked- DMWrReqBlocked- IDECheck- MisID=
ETLP- PCRC_CHECK- TLPXlatBlocked-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNon=
FatalErr- CorrIntErr- HeaderOF-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout+ AdvNon=
FatalErr+ CorrIntErr- HeaderOF-
>                 AERCap: First Error Pointer: 00, ECRCGenCap- ECRCGenEn- E=
CRCChkCap- ECRCChkEn-
>                         MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCa=
p-
>                 HeaderLog: 00000000 00000000 00000000 00000000
>         Kernel driver in use: sdhci-pci
>         Kernel modules: sdhci_pci
>
>
> > $ sudo iotools mmio_read32 0x84000510
> > 0x0303000f
> > $
> > --
> > Best regards,
> > Ben Chuang
> >
> >>
> >> On 18/01/2026 01:48, Matthew Schwartz wrote:
> >>> The GL9750 SD host controller has intermittent data corruption during
> >>> DMA write operations, which has been traced to an incorrect burst
> >>> configuration. This was discovered by comparing initialization sequen=
ces
> >>> between the working GL9767 controller and GL9750 and seeing that the
> >>> GM_BURST register was handled differently.
> >>>
> >>> Clearing bits 16-17 eliminates the corruption with f3write/f3read tes=
ts
> >>> while maintaining full DMA write/read performance.
> >>>
> >>> Fixes: e51df6ce668a ("mmc: host: sdhci-pci: Add Genesys Logic GL975x =
support")
> >>> Closes:
> >> https://lore.kernel.org/linux-mmc/33d12807-5c72-41c
> >> e-8679-57aa11831fad%40linux.dev%2F&data=3D05%7C02%7Cben.chuang%40genes=
yslogic.com.tw%7C2361bfc18a574c93ddc
> >> 308de5fedb708%7C4e753840bf6b40a19645185818deeb52%7C0%7C0%7C63905367179=
0416204%7CUnknown%7CTWFpbG
> >> Zsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFO=
IjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7
> >> C%7C%7C&sdata=3DAzJ5iXlS1yxTdGDFK64jJxRkOAty%2FzNAGMHM%2FItQDfA%3D&res=
erved=3D0
> >>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> >>> ---
> >>>
> >>> Hi all,
> >>>
> >>> I arrived at this after a whole bunch of guesswork based on the other
> >>> Genesys card readers in the kernel that do work, like GL9767. I lande=
d on
> >>> register 0x510 which appears to be "GM_BURST_SIZE" and ended up going
> >>> through each bit and either setting it or masking it. Eventually, I
> >>> arrived at masking bits 16-17 which seemed to stabilize writes comple=
tely.
> >>>
> >>> Could someone at Genesys confirm what this register is for on GL9750,=
 and
> >>> what those bits are? At least locally, I have been able to run 50GB o=
f
> >>> f3write/f3read without any corruption while before even 1GB would cor=
rupt.
> >>> This also maintains the same read/write speed as before this change. =
I
> >>> tried searching online but was unable to find any relevant docs, and =
I'd
> >>> like to confirm the purpose of those bits before sending this out as =
v1.
> >>>
> >>> Thanks,
> >>> Matt
> >>>
> >>> ---
> >>>  drivers/mmc/host/sdhci-pci-gli.c | 8 ++++++++
> >>>  1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhc=
i-pci-gli.c
> >>> index b0f91cc9e40e4..a06b0cf11f12d 100644
> >>> --- a/drivers/mmc/host/sdhci-pci-gli.c
> >>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
> >>> @@ -26,6 +26,9 @@
> >>>  #define   GLI_9750_WT_EN_ON            0x1
> >>>  #define   GLI_9750_WT_EN_OFF           0x0
> >>>
> >>> +#define SDHCI_GLI_9750_GM_BURST_SIZE                 0x510
> >>> +#define   SDHCI_GLI_9750_GM_BURST_SIZE_MASK            GENMASK(17, 1=
6)
> >>> +
> >>>  #define SDHCI_GLI_9750_CFG2          0x848
> >>>  #define   SDHCI_GLI_9750_CFG2_L1DLY    GENMASK(28, 24)
> >>>  #define   GLI_9750_CFG2_L1DLY_VALUE    0x1F
> >>> @@ -629,6 +632,11 @@ static void gl9750_hw_setting(struct sdhci_host =
*host)
> >>>
> >>>     gl9750_wt_on(host);
> >>>
> >>> +   /* clear GM_BURST bits to avoid corruption with DMA writes */
> >>> +   value =3D sdhci_readl(host, SDHCI_GLI_9750_GM_BURST_SIZE);
> >>> +   value &=3D ~SDHCI_GLI_9750_GM_BURST_SIZE_MASK;
> >>> +   sdhci_writel(host, value, SDHCI_GLI_9750_GM_BURST_SIZE);
> >>> +
> >>>     value =3D sdhci_readl(host, SDHCI_GLI_9750_CFG2);
> >>>     value &=3D ~SDHCI_GLI_9750_CFG2_L1DLY;
> >>>     /* set ASPM L1 entry delay to 7.9us */
> >
> > ________________________________
> >
> > Genesys Logic Email Confidentiality Notice:
> > This mail and any attachments may contain information that is confident=
ial, proprietary, privileged or otherwise protected by law. The mail is int=
ended solely for the named addressee (or a person responsible for deliverin=
g it to the addressee). If you are not the intended recipient of this mail,=
 you are not authorized to read, print, copy or disseminate this mail.
> >
> > If you have received this email in error, please notify us immediately =
by reply email and immediately delete this message and any attachments from=
 your system. Please be noted that any unauthorized use, dissemination, dis=
tribution or copying of this email is strictly prohibited.
> > ________________________________
>
