Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com [74.125.224.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9302F43E48B
	for <linux-mmc@vger.kernel.org>; Sun,  4 Oct 2026 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791116017; cv=none; b=FFcQMcu7uqPaxn4YTY/2XXJpSLckDq6J30Ab8C8Fop0iT0mFH2Yt4VrBwf825HssV0XUCPrF8eKJM5gM6I5CoN6HUjG9+UaKDI+Xq/uUWSr2TAMmOCyOEbrrZVMs1oLnJfurzR/fiuk+KVocTiBHttMekhYUuzLct1SjYVcaEww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791116017; c=relaxed/simple;
	bh=5Pr4pI6UHbC0U2MKjSQsGnO4riVPy06dn9dWWcRzV98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMxyu29Lp3KJIy2N8N2qav4ieue/XCCGA16F/aMET+pgKO5Ln9UChDGGWyjJ7hvW7TBJCmMuOI8ycQspdnx5HpXdTZYe1g1qNU9kljz1GNIWnSyX7MGEw1zss0fw0O3AStYzIjYp0zp1nZQAFhStlYwfcAwL39G8LvDc8eO9PhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.224.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ac502960dcso6524697b3.1
        for <linux-mmc@vger.kernel.org>; Sun, 04 Oct 2026 05:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791116014; x=1791720814;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nfYr76LOTu8jVRzggIwBN8xVUqu42mEkcSJCjGTgQ0g=;
        b=FRFjiKf6ttOFXwTxE8kOSFPzK+h+A8qMAKt/mmGOljBeYoZraQEql2ik4s3Rww1peX
         cBdE4oqq5+fQUHQhwEbdRPcjhVTKjQXdyB+i+FWzfHc539vvppg7OGVQzg/BEqbMcIPY
         aTtuWLLzyAJhhhxP+0WRsBEVEgnnY5htda55O/u3Ebz915GWbPB2uq93pqO0n3rLTnb3
         tqN9wwgbqPxZOWIJq80rupsMZskYMhcT5b1VvL+aZWD5aNpPD/zBXGHYeK2LCL7srDkI
         TJ1cDPYYYWTSbZITzzg3XpFPXAhmIBcNdB9oUkYWOwvYF5dbPPHVWns8iOTJDep4G4Dh
         PfEg==
X-Forwarded-Encrypted: i=1; AKwUvByngue48UlgaP27/96k4VMPLRvUy4vUPJqpeOuqIhXr44tNr7/I0lw2T/zqD3tuITMc1GeNND3tEGU=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/+eS2xAYFlcGbHNuKOh8ybjBPPlwtnz71JOWPnUkO21BaJRM3
	Z44PpUjU98CzG6TycpGAgkQpnmhfjXn/0Bz6yPfyT7Y10WdRf0WsEMWHEUTrlA==
X-Gm-Gg: AYBFou0+D8nfn6nR7ZqlzP+8tygFjwAFE4YZAE+adq7TDA1PXhrsAZAhnj4ovYtAaqQ
	gdH65O43JpmlHZcFAn+Kjib49B8b/KJn/Rtpn8aeeDcif/bpkw/vLg2U00gq2YnW6qA73t1JK9a
	TE5y8wleo6GfPwT55Zg+a1n4byG7KI7DYp5aLdxfxNrbuv7MF9xHsS2OayBYrUh7dqyJYnNn0gI
	WR9a6+bC0EK8q++ZxjXV3f7GSttBjeBwI9aoRMj0M/XY7j1hzG4C4hGFOb+c6oEjNSZukQK9ruS
	tMnEfu9Kf33z7hrQwmzdS6xDx5AtPDi3c86mY1e0GBEs5tjE18WXpCtAPmD61XaH2+TLdNhD9s7
	alsFbrcbGbOFP1Ax4iSdHG4SSl9eZArPxt2Pit2rRNqkz180SHBcMf2QKNZq3MmmRMun2W7DpYB
	dytjYIA4arGX6AXHy6ui9THK+18FVacvIHrvUTg2cnWWhLJBzjdCKediOGH+19NHa67djOuDmsz
	f8zXIeUfWMl6AowNlMhRn0KADsLeybFzv8FOWS2V+U=
X-Received: by 2002:a05:690e:124d:b0:677:c18f:7254 with SMTP id 956f58d0204a3-677c18f8127mr942794d50.21.1791116014480;
        Sun, 04 Oct 2026 05:13:34 -0700 (PDT)
Received: from mail-yx2-f38.google.com (mail-yx2-f38.google.com. [74.125.224.166])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8ae321f9e62sm28445917b3.9.2026.10.04.05.13.34
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Oct 2026 05:13:34 -0700 (PDT)
Received: by mail-yx2-f38.google.com with SMTP id 00721157ae682-8ab3e848918so3953027b3.3
        for <linux-mmc@vger.kernel.org>; Sun, 04 Oct 2026 05:13:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByUfEroXnMeyKXXwalSOIN0i1qprGpEIe4Lq1eUlrn5CmqrLNaNnRFNvrMUcQz7XNvbNEDSca5GtUU=@vger.kernel.org
X-Received: by 2002:a05:690e:d01:b0:66f:7e05:c3f8 with SMTP id
 956f58d0204a3-677ac00785emr2680725d50.42.1791116014048; Sun, 04 Oct 2026
 05:13:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905153234.133217-1-tanure@linux.com> <20260905153234.133217-5-tanure@linux.com>
 <aqSX-kUvYaixESxe@redhat.com> <CAJX_Q+2vpcFw-5evCkykwWo6jbHvKvQ4XjYt_EKFyJuQm_ES5g@mail.gmail.com>
 <1jcxui79k0.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jcxui79k0.fsf@starbuckisacylon.baylibre.com>
Reply-To: tanure@linux.com
From: Lucas Tanure <tanure@linux.com>
Date: Sun, 4 Oct 2026 13:13:22 +0100
X-Gmail-Original-Message-ID: <CAJX_Q+0T=k44tHbJ5BSAsD-RvpytA6mLu1FKu_2GZgYucorXNw@mail.gmail.com>
X-Gm-Features: AclHuK8rosb4K--WkyZLuEcRV46M1KSWdwcM-4rWMY7HfYobH2sNfTEc1o2MX3w
Message-ID: <CAJX_Q+0T=k44tHbJ5BSAsD-RvpytA6mLu1FKu_2GZgYucorXNw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] clk: meson: t7: don't mark sys_ampipe_nand as critical
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Brian Masney <bmasney@redhat.com>, Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman <khilman@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney+clk@redhat.com>, Chuan Liu <chuan.liu@amlogic.com>, 
	Jian Hu <jian.hu@amlogic.com>, Ronald Claveau <linux-kernel-dev@aliel.fr>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 4:51=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com=
> wrote:
>
> On sam. 12 sept. 2026 at 08:50, Lucas Tanure <tanure@linux.com> wrote:
>
> > On Sat, Sep 12, 2026 at 1:08=E2=80=AFAM Brian Masney <bmasney@redhat.co=
m> wrote:
> >>
> >> Hi Lucas,
> >>
> >> On Sat, Sep 05, 2026 at 04:32:34PM +0100, Lucas Tanure wrote:
> >> > sys_ampipe_nand clocks the pipeline stage inserted in the bus path
> >> > between the SD/eMMC controllers and the NIC_MATRIX fabric. It does h=
ave
> >> > identifiable consumers - the three MMC controllers - so marking it
> >> > critical was the wrong tool: the clock should be referenced from the
> >> > consumer nodes and claimed by the mmc driver instead.
> >> >
> >> > Drop the CLK_IS_CRITICAL flag and update the comment accordingly.
> >> > sys_am2axi0..2 remain critical as they clock the AXI DMA bus itself =
and
> >> > have no single identifiable consumer.
> >> >
> >> > Assisted-by: Claude:claude-fable-5
> >> > Signed-off-by: Lucas Tanure <tanure@linux.com>
> >> > ---
> >> > This patch depends on the MMC controllers actually referencing the c=
lock:
> >> > the dt-bindings, mmc driver and t7 DTS changes adding the "pipeline"
> >> > clock must land before this patch, otherwise the boot hangs and memo=
ry
> >> > corruption this clock caused are reintroduced.
> >>
> >> This series should be merged together in one tree? Which tree? I can
> >> provide an Acked-by if it should go through the mmc tree.
> >>
> >> Brian
> >>
> > It's definitely best to keep the series together in one tree to avoid
> > boot regressions,
> > but I think the clk tree is the better fit since the core changes
> > revolve around clock logic.
> > Could you accept it ?
>
> No. This applies on top of another change already queued in the amlogic
> clock tree. It can't go through the MMC tree at the moment.
>
> This clock is not critical in mainline right now, so
> 1) I could merge this and it and in practice there would be no
>    regression. The problem you had would still be there until the MMC
>    change lands
>
> 2) Or you can wait for the MMC stuff to land and re-submit this in
>    the next cycle.
>
> Your choice. IMO, (1) is fine.
>
> >
> > thanks
> > lucas
>
> --
> Jerome
Hi Jerome,

Sorry for the late reply. The MMC side is in next now, so the clock has
a real consumer.

Can you take this patch dropping the sys_ampipe_nand part or
should I re-submit a new version dropping sys_ampipe_nand change and
only marking sys_am2axi0/1/2 as critical?

Thanks
Lucas
