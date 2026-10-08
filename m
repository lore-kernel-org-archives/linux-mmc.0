Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3572AD3F
	for <linux-mmc@vger.kernel.org>; Thu,  8 Oct 2026 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791418063; cv=none; b=VMuTW8ds/sCeOiytNBy0U61M2Kja/mwglm7dGEnRaJ9SlkDaNcqV0wCLh6CrOeCgyzVs8c3ezab1X9bRfwJb2JpTFILVecMpxUEt6FXmDP2AzjQVPdyBPDGzI5kakZyTVTfIfZER7Szhj4ILTEDaiwUcVU5NUle8OMMXuMwFkYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791418063; c=relaxed/simple;
	bh=izMm3ub5pHWSzU9B5+I9vrWo+LdhgWZ+NZKCaQYUlMA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=acMZJQBFA7jS6CFMtuFGCUQDltCQmDLnn4a0TakCXBCx6L7gZTuCY29+8SFUXRVhMPsXQOqsE+NpsT7EoitI8NucqGueq0+La9BUoq6AFMP3YTZd/XiE2eTt9vy0UHmxZ21+AFz1Sb6iV4RYHApDhej/ehYWUcZ1WAqSIzrE2cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG57klW+; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG57klW+"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-486e70f2457so2084495f8f.2
        for <linux-mmc@vger.kernel.org>; Wed, 07 Oct 2026 17:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791418059; x=1792022859; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=izMm3ub5pHWSzU9B5+I9vrWo+LdhgWZ+NZKCaQYUlMA=;
        b=iG57klW+wzwbJiwL9z7I3Vw0Gb4EvVA84WWSsEKl51G/4OL5Ia4iOj2mF18kKc7baJ
         O9O8d3fTKBxnm4duBRTdAIsxowZnA6lMNGRiFG5RpKITA5k7iPb+YaGkV6QRwZw74Ael
         yL/3hWfWMjnMVVRyPRTz7jOEN34pEvl7OFRBBcRzOM+lr+GYKaz2Qx9Ul8rjaD5aSOZR
         9Q4qFrnTBW4mcU6KOvM1gEvLuEvhpaO/beq+PIHhYvuC1ptPJTcHPY5TTbB0CRQkNQeL
         zzs0qGWHVlYC7jq2o7qxrA0dx2flDaKHfFy51Qbs0HxrWWjFGHr04LBN3DoFtYzzt7gg
         JVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791418059; x=1792022859;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=izMm3ub5pHWSzU9B5+I9vrWo+LdhgWZ+NZKCaQYUlMA=;
        b=ZGVz8HHxCrVI83TcZOAba6D8eQoG5lSYRmyNFqD53eLbmQ/QkMRcMV1uWO/on5aSko
         ZD1qU8skIbWi4TPWW2bZLGrPnRagWn4DykpHphZilzDPpqYsMC9ylNPxQso3kBr79ma3
         rne0/nBBY6J+MTFZsugmW8UCqCBTWY1AlxrSiahQu70uqq5ON2AatXXVvPKEGWyfNNj4
         CcuFTND/MTAwbc/g4gteqVIl/0hT0v4ehOauC0rGJPJHJmsGOfnSFOTe+O5haAqRTKlA
         bMqZ0H7vL8RwdRCHCWXEdIF08hopZbIeh0GmTCtmR+JSAr84bPifB6MG0MhrJASuAmKe
         pusA==
X-Forwarded-Encrypted: i=1; AKwUvBxVQnfCFdCC2xeQrtcP5FiZygRJklXDiwvlXT5tQdui2ikv7DPcny7XsQx1lTBEvKOTEJ3wQsxFA68=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKufPxl1gQWnRT0ai+rrexqCj4sZaoVYSldYR+2UVJ/LW4vtSZ
	5UL4Yf8+N6xVLJ0ZxD2+z2ksxWhn1/hJZ9ahOY8g+vAEgJHHQk21lqAE
X-Gm-Gg: AYBFou3q8Q1FjjvBM9cPJrUSO/NmvQtyunB1ckoBxA0gMNlqWzQ2mYnWsAd0nGbXI11
	9L0/+91pnBH2kGWXU8J3NjE/SS+NySuaq6h0uSvK1poDFi2R1zr/vlYONy6NMDruPx9GpjW8Xfe
	StcBeN4EZvyD5pquWWrLn2/tF4TqT6A/Hic7RsfXD1UJYN1uVZ567i4/4bdiLer2Df8rHDkiYdL
	nXpyYRacBf1tSxCmqyIzKO3KzWo7OBPAj8eqCJFvkDlhxAKS1AM0SaPhGrL+t0gEGBcDPA5v2n5
	LauFnW3gRLhwWLx00DbrKrBewZmUACFsyn3O5uydWTpQi8brgo16VyIWdT5H8S8AUI6ufTpm3fJ
	DyFsam423ZhOWC1tAjTNl6Mk2YseyfvNRIPXcIlmaOHawJ4Jl5iDSV7MsmhbUqhYBf850UqjmHb
	NdGFdDYFqdj2lnn2H0/eE4r5EbXd1rLAkJ2F8X3P5YOoWX2vtduXPafFsFDz15QtBfY2A1z6M6l
	IguQFu+/6fCR2mtrrMt4+bK8R07
X-Received: by 2002:a05:6000:4818:b0:488:8751:e78e with SMTP id ffacd0b85a97d-48c72788373mr6736354f8f.16.1791418058790;
        Wed, 07 Oct 2026 17:07:38 -0700 (PDT)
Received: from smtpclient.apple ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c7fb9eda1sm1040996f8f.7.2026.10.07.17.07.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Oct 2026 17:07:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.3\))
Subject: Re: [PATCH] arm64: dts: amlogic: meson-sm1-odroid: let the SD card be
 powered down
From: Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <179140715034.293470.4459182430175564610@iav.lv>
Date: Thu, 8 Oct 2026 04:07:23 +0400
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Dongjin Kim <tobetter@gmail.com>,
 Eric Neulight <Eric.Neulight@linuxdev.slmail.me>,
 linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AD1E9AE8-8FA9-4CC2-AED8-AB2F455FA8E2@gmail.com>
References: <20261003-hc4-sd-power-off-v1-1-f7ffba01b348@iav.lv>
 <179100548183.3372253.2014593916926884551@iav.lv>
 <179140715034.293470.4459182430175564610@iav.lv>
To: Igor Velkov <iav@iav.lv>
X-Mailer: Apple Mail (2.3864.700.51.1.3)

> On 8 Oct 2026, at 1:05=E2=80=AFam, Igor Velkov <iav@iav.lv> wrote:
>=20
> Follow-up to the dropped patch.
>=20
> An out-of-tree restart handler [1] power-cycles the card: it drives
> TFLASH_VDD and both tf_io lines low for 100 ms, then releases them and
> the card is powered again. With the SPI flash erased, ODROID-HC4 boots
> from SD after a warm reboot 5/5 on 6.18, 7.2 and 7.3-rc5. Without the
> handler the boot stalls in the ROM or in U-Boot.
>=20
> Where should this live upstream: the mmc core on restart, =
meson-gx-mmc,
> or a board driver like this one?
>=20
> [1] =
https://github.com/armbian/build/blob/main/patch/kernel/archive/meson64-7.=
3/meson64-reboot-02-port-to-gpiod.patch

I=E2=80=99ve been doing some bring-up work on S4 support with a VIM1S =
board
and Claude initially suggested a u-boot variant of the same patch [1]
which improved but did not fully resolve the situation. I was also not
able to explain why applying the same change via the Linux device-tree
that u-boot consumes didn=E2=80=99t have the same effect as essentially =
the
same change in the u-boot dtsi file.

Claude subsequently added a second patch [2] which resulted in 100%
reliable boot. However that allowed me to move forwards with kernel
work and I haven=E2=80=99t yet circled back to u-boot to run an =
experiment
without the first patch.

[1] =
https://github.com/chewitt/u-boot/commit/0a3f5693a4ff192eb044fc4c5a434770d=
e053835
[2] =
https://github.com/chewitt/u-boot/commit/8e663632bc500ee6a83a846bcd3242231=
c33aa43

As usual both of Claude=E2=80=99s authoritatively worded descriptions =
sound
convincingly or conveniently good :)

Christian

