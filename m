Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEAF3A6408
	for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412943; cv=pass; b=ekswZk9SPPG98K95Ldns+CGsS/tTo7poY/ImAn2URHrVxtMFlO/3z9ZuOYI70QvApI/XKZBk4De5sbRoqeVJ+4FKm6guppwv/3V9BCYXK7Kas5AKQ+KgHW6bw106hGdNPszIF9mFDaTFtjmhEW6AvuuU3H91xky1LRUQ4T8KVlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412943; c=relaxed/simple;
	bh=MV/eXRShZGoChKIqTWx3xRDJY4D5p1GfCWHVtdLntcU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TkbcP5EhKs8oxr+99KgfvzBVczYirGEwKtkJLnaQyf1pBHcLaAwxgRnETTPCMx0960rZxGrBGxWAOeF7zwhzNYnGR1rT0ynPDjfxzNZA98JSjKb5shRgIV/NAfGG5Awhf84P1rr7H3QgKKFtjja25W2hWFJ/Ex/EJDHpT7FPCJw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGFSMfaB; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGFSMfaB"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-89a1c6dd788so22870166d6.0
        for <linux-mmc@vger.kernel.org>; Fri, 13 Mar 2026 07:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773412941; cv=none;
        d=google.com; s=arc-20240605;
        b=CS5Gx7fXma4sRC1Oj67sDQZQ2EtJpTBXO5VqRafKfjqv6qOw7bC1OmKWrODkeXLGC/
         LSGRHBvRFLLF5OhDTQSf3CD3/AImMnniiMJiELoG4MshWTvwMXmUQNV7oV9AyCDqXQiN
         Jcbs7Wn0Glh9BuhaFlYUTwoGU/9z+kAme9XlYH3AaI3ZygK9SB5Z9cO+10szJz/Shhds
         GPvb+wkip0ZeP76R4bKEZJpVq3vJJ/7nbeuB2PoSdOpwrcG5Tc937M3rZfmBP0LW6fP5
         LJrUb/+e1KIQIlZ0oFGdqwR8KDvTwaFU+9tkrHdN2hAM6AvP6LDGOIYwICyxBP/KFs2R
         vMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qc+mZxTV+FdzmhrCNMAZNBcHZoz8P43EP82OiNbVxfA=;
        fh=tSU/+wyHnKVHa+sMq7nbdyNU0+/K1sAsn1v6FDqd6sk=;
        b=d9T+yaj562jU0QxA0can7kEnADQMNlk4jIqn76Cb2+pA4MjPpRlaaQ9rMr5qOFrs8Q
         jmLDtHDq4aqUbTATpUy6GjXpMqLMEhQsbr4xRwmlRJLL5EAYdEiRhG3KizGMkK+UxODp
         4yRa+zft9IK61Ng4N1S+YME35o85djSG3HVERmg5qapH6JuieHsPhI9+4LexqSKWKXxt
         ufIikdsC9JtJ7L21AIkpUE5mO0VXq1ktSUoGR74o84JsgwxJakENj1i7mRlvz5pWXY1w
         pZQN4F8dT55MWOJByZNBvABgC8bh2V0gIM8SfAeQfM3pn+VkzuGOPjYk2S7Mei4Xcnf5
         Ydrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773412941; x=1774017741; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qc+mZxTV+FdzmhrCNMAZNBcHZoz8P43EP82OiNbVxfA=;
        b=GGFSMfaBlV/JxTe/0jFPTsEVWBYVyhH1nm+RUwZcTHAVGEbe4fWdeKRBQ7kTeOdTHa
         xgP1Z0XaudAMPir7uZgUFxxeKtIf0AL+Jlf0uzdpdg157snS0oDxN+VNYUfFYrsTDahn
         iYBZ7Y9l5lBEC9n2Ds18tvp0x9qgoH/fUBUM9lvlPyO1xSqsNv1dpO2NuQXzX2zhJKjI
         DBGUO9N4bNPfLL6IEq4FwGNMCpLCvyKM+vWJ/tr+YXtCZ3Zb6HxXV1zhzKI7ux30QGAA
         Vjlsh4vlYCyJ+9zAPxt/lP/e5SrZrxsxYv6rpQp6WADiNCpuOVDFuVpk6gsOOAVIYCuF
         nH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773412941; x=1774017741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qc+mZxTV+FdzmhrCNMAZNBcHZoz8P43EP82OiNbVxfA=;
        b=PCgWa0JGNvw9Cj63LyKySlXiT9xLeImvXE3xGIH+jXWKBmowq3bv/ztWlh1uArrLVQ
         O7hUfacXUHpcn52EsutmGoUpiMb+LzWhK/JZ6ZM2C6i+2MiO0uw+fzbfAKJsZ4DrEUhA
         lpNF9VB0HLqimwS9wTYVzFFhEtcYWzpi7OUv4RBZe9XaXBf28VDGyvz23+HlLJj9Btia
         JmI/cFeQWqs/BefCOtenE9R1h1vr/RoKr07A9NLuJG+qo3ebMfsHhCHjNqFR082z6FsX
         22KyRL/vaYBSUNouFckW8Ik6ytmUZANfcvLfaTNSqiPcWsuN1WWay5x5ScyKwjSonJub
         zjgg==
X-Forwarded-Encrypted: i=1; AJvYcCXQafYaDbQa4tYyvga0+qKYwSWxjy3anLA2kT16im46Rorpuzn4zBTgCybrwBXcps35jFB+AcsfQNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRCYtCSa9AN65sxkjRkau6EDmmMKopVxZmcu74U5nElWWFvr+X
	qgCAU6u6mpv89GSnyL73HIsYCMBCLdF46zEHQ/jFUeCKgFnHGUTtfsR/2rZGUZ99+qDrQL7Seok
	E4DZdJd3ws6lkw0ctKVMcw/R4ilhL0q0=
X-Gm-Gg: ATEYQzzmnBZyigcDEjdrbiSuVnehMelCzTlg/4qoEttvHQdF+FNSEQ4lOXGTBHy1lHe
	njHg/nxII7TifY8/1w1B8Z1EI4XOzboCJJKbwDmAhlajDjLmiCz8kgc82MnJ14xUH4rXC3dEJjX
	nhqPvWEumtvEzyRrsaOawc0iidKUHgAK9S2hyQP0rgRTwVTvxMm9ggUtAf3aMEA+teYFRNzI3Uo
	pcmPC/nVt6molADiiCQzwjMpgGthYJ5a53TVJaAJdpwn+N/sT1110JQSVITmjklizx3/8MquZ5i
	qyKh3w==
X-Received: by 2002:a05:622a:1a8c:b0:503:4251:6597 with SMTP id
 d75a77b69052e-50957cc6720mr50149121cf.29.1773412941102; Fri, 13 Mar 2026
 07:42:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-orangepi-sd-card-uhs-v2-0-5bb2b574df5d@gmail.com>
 <20260309-orangepi-sd-card-uhs-v2-7-5bb2b574df5d@gmail.com> <f2eeddcb-712f-4a67-9687-e217f46f9ea8@baylibre.com>
In-Reply-To: <f2eeddcb-712f-4a67-9687-e217f46f9ea8@baylibre.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 13 Mar 2026 20:12:02 +0530
X-Gm-Features: AaiRm51P57qcJuyAf0DEi9SoGi5rXwcJCFXanh2EQoeiyawGvbU2ynSwbZwPkSA
Message-ID: <CANAwSgSjsn46p13LokjYZBLdOrUBTFsmDNf80TG=nvkqHWNkfQ@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] riscv: dts: spacemit: k1-orangepi-rv2: add SD card
 support with UHS modes
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Trevor,

On Fri, 13 Mar 2026 at 19:26, Trevor Gamblin <tgamblin@baylibre.com> wrote:
>
>
> On 2026-03-09 07:40, Iker Pedrosa wrote:
> > Add complete SD card controller support with UHS high-speed modes.
> >
> > - Enable sdhci0 controller with 4-bit bus width
> > - Configure card detect GPIO with inversion
> > - Connect vmmc-supply to buck4 for 3.3V card power
> > - Connect vqmmc-supply to aldo1 for 1.8V/3.3V I/O switching
> > - Add dual pinctrl states for voltage-dependent pin configuration
> > - Support UHS-I SDR25, SDR50, and SDR104 modes
> >
> > This enables full SD card functionality including high-speed UHS modes
> > for improved performance.
> >
> > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > ---
> >   arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts | 19 +++++++++++++++=
++++
> >   1 file changed, 19 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts b/arch/ri=
scv/boot/dts/spacemit/k1-orangepi-rv2.dts
> > index 414b03f5e6480f05f5d7eeaaa0afb4e86425ae36..361135269801f436703b6f1=
d768c91325a52f07f 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> > +++ b/arch/riscv/boot/dts/spacemit/k1-orangepi-rv2.dts
> > @@ -140,3 +140,22 @@ sd_vqmmc: aldo1 {
> >               };
> >       };
> >   };
> > +
> > +&sdhci0 {
> > +     pinctrl-names =3D "default", "state_uhs";
> > +     pinctrl-0 =3D <&mmc1_cfg>;
> > +     pinctrl-1 =3D <&mmc1_uhs_cfg>;
> > +     bus-width =3D <4>;
> > +     cd-gpios =3D <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
> > +     cd-inverted;
> > +     no-mmc;
> > +     no-sdio;
> > +     disable-wp;
> > +     cap-sd-highspeed;
> > +     vmmc-supply =3D <&sd_vmmc>;
> > +     vqmmc-supply =3D <&sd_vqmmc>;
> > +     sd-uhs-sdr25;
> > +     sd-uhs-sdr50;
> > +     sd-uhs-sdr104;
> > +     status =3D "okay";
> > +};
> >
> Hello again,
>
> Thanks for doing this work. My colleagues and I have been testing this
> on an OrangePi RV2, and also a Muse Pi Pro board (making a similar tweak
> to this patch in k1-musepi-pro.dts). To do the testing on my end, I'm
> applying the patch series on top of 6.19 in a Yocto BSP.
>
> I've been finding that I see issues with the UHS support on my side
> (this log comes from an image built and flashed to an SD card):
>
>
> [ 1.072417] sdhci-spacemit d4280000.mmc: Got CD GPIO
> [ 1.109741] mmc0: SDHCI controller on d4280000.mmc [d4280000.mmc] using
> ADMA
> [ 1.114589] clk: Disabling unused clocks
> [ 1.118421] PM: genpd: Disabling unused power domains
> [ 1.123249] ALSA device list:
> [ 1.126[ 1.129949] check access for rdinit=3D/init failed: -2, ignoring
> [ 1.133284] Waiting for root device
> PARTUUID=3De94bfdd7-a36f-4315-a480-476e2a12403d...
> [ 1.176569] mmc0: new UHS-I speed DDR50 SDHC card at address aaaa
> [ 1.180732] mmcblk0: mmc0:aaaa SS16G 14.8 GiB
> [ 1.276268] mmcblk0: recovery failed!
> [ 1.277351] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags
> 0x800000 phys_seg 1 prio class 2
> [ 1.286346] Buffer I/O error on dev mmcblk0, logical block 0, async page
> read
> [ 1.293891] mmcblk0: recovery failed!
> [ 1.297289] I/O error, dev mmcblk0, sector 0 op 0x0:(READ) flags
> 0x800000 phys_seg 1 prio class 2
> [ 1.306269] Buffer I/O error on dev mmcblk0, logical block 0, async page
> read
> [ 1.313522] mmcblk0: unable to read partition table
>
>
> At first I wondered if maybe there was an issue with the card itself,
> but by changing the sdhci0 section to this, I'm able to read the SD just
> fine:
>
I used the same example on the K1-OrangePi-RV2 DTS,
But it=E2=80=99s slightly different from the one you=E2=80=99re working wit=
h.
I tested on the latest  7.0-rc3.

> &sdhci0 {
>           pinctrl-names =3D "default";
>           pinctrl-0 =3D <&mmc1_cfg>;
>           bus-width =3D <4>;
>           cd-gpios =3D <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
>           cd-inverted;
>           no-mmc;
>           no-sdio;
>           disable-wp;
>           vmmc-supply =3D <&sd_vmmc>;
>           vqmmc-supply =3D <&sd_vqmmc>;
>           no-1-8-v;
>           status =3D "okay";
> };
>
+
+&sdhci0 {
+       pinctrl-names =3D "default", "state_uhs";
+       pinctrl-0 =3D <&mmc1_cfg>;
+       pinctrl-1 =3D <&mmc1_uhs_cfg>;
+       bus-width =3D <4>;
+       cd-gpios =3D <&gpio K1_GPIO(80) GPIO_ACTIVE_HIGH>;
+       cd-inverted;
+       no-mmc;
+       no-sdio;
+       disable-wp;
+       cap-sd-highspeed;
+       vmmc-supply =3D <&sd_vmmc>;
+       vqmmc-supply =3D <&sd_vqmmc>;
+       sd-uhs-sdr25;
+       sd-uhs-sdr50;
+       sd-uhs-sdr104;
+       status =3D "okay";
+};

Thanks
-Anand
