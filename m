Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=88.99.92.76
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793369387;
	b=xrIzvy9cWKxwrnPYbqU17REau1lsZevLdv7ikmn/c/BkUSIIL0GXnO/MWqOMQ1dchOoX
	 w8LsV8RxvFAfck2HKAqcCOTcaFaLR5ThJQ4t/ZWalm99iYJQoS9BjFrH3j2NT6KqO84WU
	 S4kCfMh4CZjvxvpVAb0zzhQYJ75R91J/1OTTkWldxFA83JVeMlwI90udIecWgP7ciDCGY
	 EMRF8uIkSXDY27gqCfuciq0GDoiXe0R7ZXEkwagpoj6RKUtX0mk1xdW1uczDf2oFxR37H
	 PL/5lqQoQ8NN8fqiGvy1hs3k+h/94bMlnxQpOeWC9XFkbpXkpA0BtYY29PxOpyR6Flg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369387;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=WmS+CVCzuvxVoE760Ui7VRLzK1RM3gMsHjnco6tBH0o=;
	b=eDA85jMEuBizxqF1vAjOty2w1TeYi2ij/SFZ3JMSn+l8gbb9M4Q1eQojQcHA0sWGG+SD
	 mXgx64mK31F1vV4walgYREUdcQPEhGkhaeMACkiWaHHJWYG8SZhJ1VbDAFtI8YDpUhOFS
	 KHsp54fGPZ2780f2y9kk1ftthoX69+S2+/7Xl+UzFE5bGXvM+55vKrRJf8DR1aBB8Ba8G
	 K32/OilJqfshLLXnCvLba5m2N/rU7WLYNlR3txNnyn9V7LurkBbwvTdAaFqX58dfhzfuU
	 jrVGCoiw0uM2/g0CwtzwOe6ToKa7GDrCK7SvFp4lSkZxQra61V+9i/8D6qZbe4lzOsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rojer.me;
	spf=pass smtp.mailfrom=rojer.me;
	dkim=pass header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=V0Mkl8Gh;
	arc=none smtp.remote-ip=88.99.92.76
Received: from mail1.rojer.cloud (mail1.rojer.cloud [88.99.92.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1E2606A31E
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D1E2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rojer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rojer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=V0Mkl8Gh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rojer.me; s=main;
	t=1793369378; bh=NipbTtAjrLg4RMpGQO/RHv1pYjokrJm5L1BpWTaf3GM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V0Mkl8Ghdd2HNA6zHhz65BdcmVQ3oYhm5osD02nZiuvK4cB+MDBtixGN1vzm8JZo4
	 p57AMRO5w2r2WovVlOq55cZUeS0KRvk9mDSqse62BP2PZlKOPMRFtSM+WYqZb4zyNt
	 aCLYZgHMzfd43b9684pUG0F9U2klCT0SnhLMWX6DDk1GqZuoOyBzWodjgCvPhHtTqD
	 /SnpbDqRbbVvfGORD7VwTqE3gVeJTv0MHFdw3PEaD6bsv/DF0CZeNAF81yyt0Rb9Vn
	 tjY3fd1Ti8NB3qFkF7Nfe1V5QNIcJKUx3S5uB08bctpI/qj9MfppjXH5+ZvYGjHGjv
	 pLEjWx0vKgHMg==
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail1.rojer.cloud (Postfix) with ESMTPSA id 7603F21662
	for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 14:09:38 +0000 (UTC)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-53a448f86e0so479857b6e.1
        for <linux-mmc@vger.kernel.org>; Fri, 30 Oct 2026 07:09:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwumLERyvwLacYjKSYgNBT8AaovRrJ/0y8/PtcodE28x54id/MVsHhI0JP9X5qIRQKWe/KgnaGZgxQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKW2TpZMcim/lT133K92sQsP9ltcs9/2PwKfmc7pNgPCQdirAUh
	flYj1F8uwvbSBXFz8/eYZXUboI6NLwISq+as93wzq+wYU5YLXCx4OJhTvQaya81BH3g6k9+kKNQ
	J6aAdEd1o+riiBeubPRRVOOXtV/Pe9g==
X-Received: by 2002:a05:6808:6404:b0:4f2:4d2f:7ba with SMTP id
 5614622812f47-5640d953debmr1796710b6e.8.1793369376966; Fri, 30 Oct 2026
 07:09:36 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027122417.954133-1-rojer@rojer.me> <20261027122417.954133-2-rojer@rojer.me>
 <CAPx+jO-SrC-8DKEfOC9KTMY=zHyiNVqNwiZyf7ipvX1=ZzZ1iw@mail.gmail.com>
In-Reply-To: <CAPx+jO-SrC-8DKEfOC9KTMY=zHyiNVqNwiZyf7ipvX1=ZzZ1iw@mail.gmail.com>
From: "Deomid \"rojer\" Ryabkov" <rojer@rojer.me>
Date: Fri, 30 Oct 2026 16:09:25 +0200
X-Gmail-Original-Message-ID: <CABFmFwoXejC7p_i4i4nctsqJ5e+CUP8tN5LnJ=5LVtuQPiCPhQ@mail.gmail.com>
X-Gm-Features: AclHuK8qEgLA1GddyFvod5CZ6IsCRLe_wzw9sQ6U-TsEP2z-vAr9UYuIT3oUqm8
Message-ID: <CABFmFwoXejC7p_i4i4nctsqJ5e+CUP8tN5LnJ=5LVtuQPiCPhQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mmc: core: sdio: retry without UHS if UHS init fails
To: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Cc: ulfh@kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	shawn.lin@rock-chips.com, llj@rock-chips.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ulf,

it's not wrong: after the "Read the common CIS tuples" and the
subsequent vendor check the only two outcomes can be oldcard =3D=3D NULL
or card =3D=3D oldcard.
but your way is clearer, i will send v3 with it.
thanks for the review!

On Fri, 30 Oct 2026 at 16:10, Ulf Hansson <ulf.hansson@oss.qualcomm.com> wr=
ote:
>
> On Tue, Oct 27, 2026 at 1:24=E2=80=AFPM Deomid rojer Ryabkov <rojer@rojer=
.me> wrote:
> >
> > If mmc_sdio_init_uhs_card() fails, e.g. because tuning finds no
> > working sample phase, card initialisation fails and the card is not
> > usable at all, even though it would work fine in high-speed mode.
> >
> > This happens for example on the FriendlyElec NanoPi R2S Plus when the
> > SDIO pins of the RTL8822CS Wi-Fi module are left at their default 4 mA
> > drive strength:
> >
> >   dwmmc_rockchip ff5f0000.mmc: All phases bad!
> >   mmc2: tuning execution failed: -5
> >   mmc2: error -5 whilst initialising SDIO card
> >   [... repeated for every init frequency ...]
> >   mmc2: Failed to initialize a non-removable card
> >
> > There is already a fallback for a failure to read the CCCR in UHS mode:
> > reset the card and restart the init sequence without R4_18V_PRESENT.
> > Do the same when UHS init fails, so that the card comes up in
> > high-speed mode instead:
> >
> >   mmc2: UHS init failed (-5), retrying without UHS
> >   mmc2: Skipping voltage switch
> >   mmc2: new high speed SDIO card at address 0001
> >
> > The fallback is taken at most once, as the retry doesn't request UHS.
> >
> > Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>
> > Signed-off-by: Deomid rojer Ryabkov <rojer@rojer.me>
> > ---
> >  drivers/mmc/core/sdio.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> > index 83085e76486..6787fdf1c53 100644
> > --- a/drivers/mmc/core/sdio.c
> > +++ b/drivers/mmc/core/sdio.c
> > @@ -867,8 +867,14 @@ static int mmc_sdio_init_card(struct mmc_host *hos=
t, u32 ocr,
> >         /* Only if card supports 1.8v and UHS signaling */
> >         if ((ocr & R4_18V_PRESENT) && card->sw_caps.sd3_bus_mode) {
> >                 err =3D mmc_sdio_init_uhs_card(card);
> > -               if (err)
> > -                       goto remove;
> > +               if (err) {
> > +                       pr_warn("%s: UHS init failed (%d), retrying wit=
hout UHS\n",
> > +                               mmc_hostname(host), err);
> > +                       mmc_sdio_pre_init(host, ocr_card,
> > +                                         card !=3D oldcard ? card : NU=
LL);
>
> Is this really correct?
>
> If there is an oldcard we should *not* pass the card (since it would
> be equal to oldcard) to mmc_sdio_pre_init() as it would remove it.
>
> If there is no oldcard (oldcard =3D=3D NULL), we should pass the card to
> mmc_sdio_pre_init() to make it remove it.
>
> In other words, how about just:
> "oldcard ? NULL : card"
>
> > +                       retries =3D 0;
> > +                       goto try_again;
> > +               }
> >         } else {
> >                 /*
> >                  * Switch to high-speed (if supported).
> > --
> > 2.53.0
> >
>
> Kind regards
> Uffe



--=20
Deomid "rojer" Ryabkov
rojer@rojer.me
