Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E872BFC66
	for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561389; cv=none; b=nB6kuU8wDXkjZETcxQaA4O4D3ue6DD1l3T2t2ytfsnT1eKgDRsggjGjEWnNJo+eDaRiKOrWaWarwrD87TPsMsht8XjY/xRG1ObFhXjFAzkyPIwYW+fjljlQQAdQ0kc3G9M8rc2WJCU7VQZP0KBl59eF+2wRtaMvRM0MHjMQT25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561389; c=relaxed/simple;
	bh=35s+gkpc8FB40Kh0km79x/nXdEnw7kIVxVZiRBlNFMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEgg1FLmKrWZPi0g/3/UVehFXXnEk3FZAsFpDxKRYtghLsSD/N2xC6Ea4ck7eS0q8BalnSAWEVUvJnkneTm27RbBE6p1qejzrm6L/qw270HKi15nwHmifHWNWwtiaX+ZbcZ7/6gIvDckSHTX40p8KTlCAJygrkmB74OxcjkGd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n3dF8LzC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n3dF8LzC"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-607fbc13725so2808578a12.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749561386; x=1750166186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJeK9rG6Ths2SZ1ZdDQMz2djUId3vdrXzdXhMg+ZqiM=;
        b=n3dF8LzCrtajAsY2ba9QpEuK5fB4izays9ezxCKpf/UmkpqiRrm4BaljYB+VYHmrFs
         Wl3sUj8VrkY5sUL6PZwmQ1FzdMAWUz7XYtyYjrxPwczmqH623QafC+cnXWJhbDmEGQHu
         oXwxg1lZiOQATTCi3+IqkN7cNQcPmOWtG/Md2rr6e+H1ctZBEFnZ1Zg1N2GQ7JkR9TmE
         1eXl+LEz6tU4DDIj5uAwPlbYthKYnXAkwVbU4MxyNVMYy6lnIxdUt+OCcWUvFQWYMJ4k
         DYSgAw8Qu+W0g+eEvRabVWVhLAPL+WcCG1Oj68SiJAD0IUrDqjitVRXuOC1aEOk+8tH8
         EoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749561386; x=1750166186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CJeK9rG6Ths2SZ1ZdDQMz2djUId3vdrXzdXhMg+ZqiM=;
        b=Yd0JrcZIlN3T8ZoRhWo9QQb6+TtxCJlEhuPNrtBOkl7O5U8Kacj9aDfedV45cfXtqz
         VlUQZOrtXz56UZBaY4Rs4/EiaYsR/EPnGIeRXc4CD2DnHG9qtNuQMGFT6k0N1ttjLx6l
         bjmohe1OYVNeahm8yCpBOdhBkQE9SzQhVacD5hkD4HZar3fvGJoirmMWrKCbeAmrWFly
         TH0et2ebth+UNTggi5NQah7372rz55wLxUmJcdm44A3DmypIBemxDh6qyPLITodUH1Wm
         hiZabtGY5zFx+kke8tpzkh2kOU2IDG0l0ohH7zg6LV9Tt+2MBB1H2/Yvql7ljEWcR7pG
         a95Q==
X-Gm-Message-State: AOJu0Yy9bZGXVPCELoQFeiG8OlU000+x2IPxWUE36pR7agJMIsMjzMwB
	w/mtp8DF7X3Ukbs9VWhDhV6wnlQl/eDX/G28hP2bupMohgAOIocbXGut0r0wLRqqgBevMuhRri3
	qStM62IADCssQTkYJqAHoM1fTk1WTnYomZ99Fovl8xA==
X-Gm-Gg: ASbGncvzt7PFQL1OUyyOGpIWcHvUB7HLZX41rHtdE/3SXZEUDiYtCGEZU2Wr2UUrauK
	DKpU4ZlykMiH2WRAD9kC7F5bjaa+tg+0fIczd3RtJHz/JENf73SaW6s869qJqbJZRVrMoybJOZo
	GrnLvQn8gFjI4QG5VovTS30W6AtvzhDaZKlWVWaKy4bKQK/9wKiAXADUU=
X-Google-Smtp-Source: AGHT+IEGBNLTiJIUfeqDCS5+HTzBZeIeM8Rbt6us4EQSJhgvb9TmHAe0x/FqIU1mMLL3og+s/aF8vkCUO36KSvPuzUk=
X-Received: by 2002:a17:906:f58c:b0:ad5:5302:4023 with SMTP id
 a640c23a62f3a-ade1ab2217amr1630823566b.44.1749561385920; Tue, 10 Jun 2025
 06:16:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <fa67d9b9358a4eeab2cb43471b08c2ec@wut.de>
In-Reply-To: <fa67d9b9358a4eeab2cb43471b08c2ec@wut.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Jun 2025 15:15:48 +0200
X-Gm-Features: AX0GCFvih7gAL1WRI-oezVShgRxL486qbtX2riwRdRQIfOZUB5WYBAIhShGO2Go
Message-ID: <CAPDyKFpcdabed0jZ-QrAz58JDiVQVxG8y4wjNcxe880KimrLFA@mail.gmail.com>
Subject: Re: [PATCH] command "rpmb write-key" not working
To: Simon Lindhorst <S.Lindhorst@wut.de>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "avri.altman@wdc.com" <avri.altman@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Jun 2025 at 15:43, Simon Lindhorst <S.Lindhorst@wut.de> wrote:
>
> Hello,
>
> I am wondering how the call "rpmb write-key" works. Isn't it the case tha=
t the content of the keyfile is read in, but not stored in the structure "s=
truct rpmb_frame" before "ret =3D do_rpmb_op(dev_fd, &frame_in, &frame_out,=
 1);" (mmc_cmds.c:2296)?

That's a weird commit message. Please try to better describe what the
patch does and why we need it.

>
> If I am right, I suggest the following patch:

No need to state that here. We certainly consider your patch just by
sending it to us.

>
> Fixes: rpmb write-key did not work

Please add a commit hash to the fixes tag, similar as below.

>
> Fixes: 05051e40351c ("mmc-utils: Refactor RPMB key handling into a separa=
te function ")
> Signed-off-by: Simon Lindhorst <s.lindhorst@wut.de>

Thanks for the patch, but I am not able to apply this as it's not
correctly formatted/sent - according to
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Please give it another try by sending a new version, but first, I
strongly encourage you to first do some homework by reading
submitting-patches.html.

Kind regards
Uffe

> ---
>  mmc_cmds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index b2cc3d6..7994223 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -2289,7 +2289,7 @@ int do_rpmb_write_key(int nargs, char **argv)
>                 exit(1);
>         }
>
> -       ret =3D rpmb_get_key(argv[2], &frame_in, NULL, false);
> +       ret =3D rpmb_get_key(argv[2], &frame_in, frame_in.key_mac, false)=
;
>         if (ret)
>                 return ret;
>         /* Execute RPMB op */
> --
> 2.43.0
>
> -- Unsere Aussagen k=C3=B6nnen Irrt=C3=BCmer und Missverst=C3=A4ndnisse e=
nthalten.
> -- Bitte pr=C3=BCfen Sie die Aussagen f=C3=BCr Ihren Fall, bevor Sie Ents=
cheidungen auf Grundlage dieser Aussagen treffen.
> -------------------------------------------------------------------------=
-----------------------------
> Wiesemann & Theis GmbH | Porschestr. 12 | D-42279 Wuppertal
> Gesch=C3=A4ftsf=C3=BChrer: Tobias Theis (M. Eng.)
> Amtsgericht Wuppertal | HRB 6377 | Infos zum Datenschutz: https://www.wut=
.de/datenschutz
> Tel. +49 202/2680-0 | Fax +49 202/2680-265 | https://www.wut.de
