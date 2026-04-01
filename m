Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3949B39A051
	for <linux-mmc@vger.kernel.org>; Wed,  1 Apr 2026 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775033609; cv=pass; b=bTKvaHf2RRrQLAZ4/xNMntpPQQFXJANG6EnAqn7TicDLD660TZQkpqhrfjX28Tj0B25PXqoj8xqEMksYu8JgvDERIk5OI5eVVN648s9G7LaVmrGqA/aGaYPGLUC0dtUhYlKO6jV+FxUWAi9k4U6gkRmb+ukpA/1cyzBO0wbvWRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775033609; c=relaxed/simple;
	bh=uXo5sGUS+X2GeacJ66r0n5qoFH9G6+mkiyEHkwOrSd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwFKcULWJE9mRlgdb7FlzKQQKrAVcCNMhATKuPdwqs+Y/cN83lFoPQBJh+P8cNsDS2sdiBUuSKs1q9YQHjrYL5yoBDt+E5gZ/vjBQnpsB+Ubo6mQvgj3TFi6Kc7jRjGOkc50Cuiw/ncOhkslTjq7zBAGC3t5fJk5XiV2bQRVJNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeTYK7x0; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeTYK7x0"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6501d32b04bso5783916d50.2
        for <linux-mmc@vger.kernel.org>; Wed, 01 Apr 2026 01:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775033607; cv=none;
        d=google.com; s=arc-20240605;
        b=NU2z8zhBx+CZCbElRYTVbYz0lWvp1ZBO+GkgembCABZMH1C+2oRVtmygLY3J8Xcmx3
         TpTCIcaiuxJY9YV2QhgWJeYYQXVbxXyzwn28qWRnucK9A40hb1mWGMCksq7d/tyfMaoC
         41/xnWsEzwvhySOIvOsHySXXUljnA6b0jC0PJINCM3R35G8YbcTTh7jwJpKo+Wsr1q1k
         x6QDo8RAWAgIJTgvD/uQmO+xIm62LfTzNT1dp/YwCyaNNmW1ucYTXJfD099XyZVwCsUi
         D8hpDSi3bKxbq3RAgu1ictUQdFvcLCG7o2RccH/pOeH5/V30/zjORlm/Lt1klQ8uDjRN
         7zsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ENRki6GE3XavXQugQXE3GjN1Vl6hypf25Ont7yDJwJM=;
        fh=avdOf++njCZenmzClJBqdgEp0/hYVKjq9IenYQs1gM4=;
        b=L200IsnuhHuwz1nS2wGijU1ZAX4w36Nt3cG1v5qwHmTGhDbhP8mK0xI2SQuppFyQBj
         deUj0XXNEZdUqSM3200RAf00a1JYnKXIlrdDpqYtVS1Vj713kdfEZbO2990c4SCkcytf
         mkBZD9bah0zp3+EqJ416pL9QSgOHro5Mmf9ccb0neBQAV4BO88FFeRlNHR3jtxc4t0dQ
         BpGGfd59vHk3D6urRAMmk8S1R5E3c7GNhS+mke3xDtlN3cfxtf0egqKrhVuKo0ShLfC9
         yw9LbHdXRpMqFZcU66lig9j8jpmBAKCIV8F38jFBxJnTqnazmiYbVArqBaaSjZsVqlhr
         +pQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775033607; x=1775638407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ENRki6GE3XavXQugQXE3GjN1Vl6hypf25Ont7yDJwJM=;
        b=NeTYK7x0FC2LVI1nWe/ovu/i+NvbrvkwdfeTtsO9yge7gJDrygPH/TXeR3NuH2tkbp
         NMSbDMKItfGOtXezqmeSqRgdR4LAiW5JGbwUEFONySeOxi7HXjmgX0Whz9VI1LQLOPbq
         K5y3qYToOywVT/lVLe1fhPX5hxWpdKeXaVAgdbfAxel9Nid+w/6up6wm2TC8RRJELQo6
         j61eE18rniPmKsfZ1d3hJJuqZu+gSvfs7HhO6rv0KdQWGNElU/QLLBX97zavAH9IPuC+
         j5j9YDQxaEPWxfs7qP9UpIn2mXCPp2Tvtymr7mkpfjhy1Dyruq1prq8ZlDS76yTr4e97
         UVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775033607; x=1775638407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ENRki6GE3XavXQugQXE3GjN1Vl6hypf25Ont7yDJwJM=;
        b=VLiPS+lOnwepOJTXR0jf5Wa38kMyxoGDzcjdBNN/1Ajb+I+lW7hCmgIhmdpoJi7AWr
         6wVvMplzJrWgTxx+XV6RFCnK3BVBnTnsJTbqDVG1bKTZeMfXfRpjmazqtNHn2ew3tJe7
         um2+5CKtJWmZVOsFlSlfscfCUyC9XfVKzdJw3b+XaNGxFnAb4upJy/cX8smSLUiM6Kt5
         iMZ+VBcJtccHHINGNGA/heYYfi+dOt8JH1C30jCL61U3diwieAXrX/nQjtNkqCs2rxwU
         QDoDxfI4CYhrIH8CxUpA/vEVzGO0Ea70vXB8bCb4qMWZeeE5MfUhd3hG4SVFT6oXlDFA
         6f+g==
X-Forwarded-Encrypted: i=1; AJvYcCX5cmMZA6TzbutGZppHOTCijIUT6sW1TDLCXEoiXI9kKeUOk1Wnf5pb5lC9nkeGd/SINb4zY0lmd44=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvEGrmKG633/qJ5NfZXT1B1YjmphEN9HhqG5iFysx/Um/ySVy2
	07CgmD82xuyE0aoRlC7ospugW3VdBbg2AxIggQUrBO4cgMQ8ZAgSODO6m8oEqL+ZQu3PeMR6V3s
	p1s8tZ52JWnw4BP3rq/yBLkEfHJGgh5Q=
X-Gm-Gg: ATEYQzwRaVlVaIATKxt7ShKJf6Xnt8HsIcCI5iGC0vbfIDoFb8smjtQf2B/p4CrHgbf
	68rF6ydp1Jy2fUq0Y66ucFj8KRD4FYbItcy+mSqx3MxzCVdDZ+Yx3GdWZ6MNfZL29i6Uy1CNJ/U
	XQZGQhZDoUKreK5gstBRUpCiN8iGHr/PUY0Krm3wmCAIMOaKzoiPPBfgS/04Ajt3SCVO2yhSDgT
	mbLCDddRlIwJMGReMPg9RaWVnPlTosWGowoZ9goMY35YkeMuL5DO4dEuDyF9TpnvB+zAubwcZQc
	bkbjCw==
X-Received: by 2002:a05:690c:389:b0:79b:ced2:fa39 with SMTP id
 00721157ae682-7a2133f6f60mr28605447b3.57.1775033607174; Wed, 01 Apr 2026
 01:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-orangepi-sd-card-uhs-v5-0-bd853604322d@gmail.com>
 <20260330-orangepi-sd-card-uhs-v5-5-bd853604322d@gmail.com> <aco9oLumPh4OZtIo@kernel.org>
In-Reply-To: <aco9oLumPh4OZtIo@kernel.org>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Wed, 1 Apr 2026 10:53:16 +0200
X-Gm-Features: AQROBzCe0V-3QMHTJmNMWmbyBErt61jt6_tzSI47AYboyyBlMnKTU6WQsgJn7cM
Message-ID: <CABdCQ=MFcDPnzcYUEkbQyu_0qZt=aDD04p1kyxCMuVt7Av_P1Q@mail.gmail.com>
Subject: Re: [PATCH v5 5/9] riscv: dts: spacemit: k1: add SD card controller
 and pinctrl support
To: Troy Mitchell <troy.mitchell@linux.dev>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, 
	Michael Opdenacker <michael.opdenacker@rootcommit.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 30 mar 2026 a las 11:08, Troy Mitchell
(<troy.mitchell@linux.dev>) escribi=C3=B3:
>
> On Mon, Mar 30, 2026 at 16:38:06 CST, Iker Pedrosa wrote:
> > Add SD card controller infrastructure for SpacemiT K1 SoC with complete
> > pinctrl support for both standard and UHS modes.
> >
> > - Add sdhci0 controller definition with clocks, resets and interrupts
> > - Add mmc1_cfg pinctrl for 3.3V standard SD operation
> > - Add mmc1_uhs_cfg pinctrl for 1.8V UHS high-speed operation
> > - Configure appropriate drive strength and power-source properties
> >
> > This provides complete SD card infrastructure that K1-based boards can
> > enable.
> >
> > Tested-by: Anand Moon <linux.amoon@gmail.com>
> > Tested-by: Trevor Gamblin <tgamblin@baylibre.com>
> > Signed-off-by: Iker Pedrosa <ikerpedrosam@gmail.com>
> > ---
> >  arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi | 40 ++++++++++++++++++++=
++++++++
> >  arch/riscv/boot/dts/spacemit/k1.dtsi         | 13 +++++++++
> >  2 files changed, 53 insertions(+)
> >
> > diff --git a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi b/arch/riscv/=
boot/dts/spacemit/k1-pinctrl.dtsi
> > index b13dcb10f4d66022d27307de73a6ea3287e97441..8d82011f1af666fb78c282a=
2abcc0cb88f962053 100644
> > --- a/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > +++ b/arch/riscv/boot/dts/spacemit/k1-pinctrl.dtsi
> > @@ -570,4 +570,44 @@ pwm14-1-pins {
> >                       drive-strength =3D <32>;
> >               };
> >       };
> > +
> > +     mmc1_cfg: mmc1-cfg {
> > +             mmc1-data-cmd-pins {
> > +                     pinmux =3D <K1_PADCONF(104, 0)>,   /* mmc1_d3 */
> > +                              <K1_PADCONF(105, 0)>,   /* mmc1_d2 */
> > +                              <K1_PADCONF(106, 0)>,   /* mmc1_d1 */
> > +                              <K1_PADCONF(107, 0)>,   /* mmc1_d0 */
> > +                              <K1_PADCONF(108, 0)>;   /* mmc1_cmd */
> > +                     bias-pull-up =3D <1>;
> > +                     drive-strength =3D <7>;
> I'm a bit concerned about this value. Looking at the downstream 6.6 code,=
 3.3V uses DS4,
> which equals 13mA. Since 7mA maps to DS0, what's the reasoning for using =
it here?
> Do we have any documentation or measurement to back this up?

Thank you for catching this! You're absolutely right to question these
drive strength values.

Looking back at my development process, I remember hitting signal
integrity issues in the early stages of this driver development. As a
quick solution, I lowered the drive strength values, which seemed to
resolve the immediate problems, and I moved on without revisiting the
electrical characteristics.

After your feedback, I investigated this properly by comparing with
the vendor kernel. It uses:
- 3.3V mode: PAD_3V_DS4 (19mA)
- 1.8V UHS mode: PAD_1V8_DS3 (42mA)

My original values were indeed backwards from both electrical theory
and proven vendor implementation. Testing with the corrected values
(19mA/42mA) confirms SD card is working.

I'll send v6 with the corrected drive strength values: drive-strength
=3D <19> for 3.3V and drive-strength =3D <42> for 1.8V UHS modes.

> > +                     power-source =3D <3300>;
> > +             };
> > +
> > +             mmc1-clk-pins {
> > +                     pinmux =3D <K1_PADCONF(109, 0)>;   /* mmc1_clk */
> > +                     bias-pull-down =3D <1>;
> > +                     drive-strength =3D <7>;
> > +                     power-source =3D <3300>;
> > +             };
> > +     };
> > +
> > +     mmc1_uhs_cfg: mmc1-uhs-cfg {
> > +             mmc1-data-cmd-pins {
> > +                     pinmux =3D <K1_PADCONF(104, 0)>,   /* mmc1_d3 */
> > +                              <K1_PADCONF(105, 0)>,   /* mmc1_d2 */
> > +                              <K1_PADCONF(106, 0)>,   /* mmc1_d1 */
> > +                              <K1_PADCONF(107, 0)>,   /* mmc1_d0 */
> > +                              <K1_PADCONF(108, 0)>;   /* mmc1_cmd */
> > +                     bias-pull-up =3D <1>;
> > +                     drive-strength =3D <13>;
> See above.
>
>                                       - Troy
