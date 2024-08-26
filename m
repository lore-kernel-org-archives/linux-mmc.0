Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58830155315
	for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672355; cv=none; b=F92hfnLsLfWt70gpYdRcnF15J1/7ipkUYJ8oqTF8B09+M1dIOVBlcZ3f3aM/c9NBASGLlB62X/CqEtlv0lmJqxn1z571duZG5UMjgNM0ADA1f8VNR0uAJvqBB9NdI0Q9IGbdVc9374wr9zUak6PFCP6C+217/QmhVHsKxN5NR0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672355; c=relaxed/simple;
	bh=RH7aHaC5FeI2cK0JDUbDNbd1o8qmQF4nH9GWmopKfYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u8GMh9r6nNHkBnkbPv5QeEbNobctwQ0y2Tp5BTCgk4iouLHv7kwIz/u40Gdg6F0lfjgqAhnUOFNCdh3t0iYBQx8AqgxlwyGnohIXN7elJky4RQhkKHzpVEfUTXwSaz1INWQCUU1VrwHp4lXYUU9F7PyrYQyxnnXipe3WWoRSlkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p9XCSypw; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9XCSypw"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e13cda45037so4408934276.3
        for <linux-mmc@vger.kernel.org>; Mon, 26 Aug 2024 04:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724672353; x=1725277153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bk7xueDtstYJ9dmp/2G1Dduwg3O+kNnnJuyCn7RuweI=;
        b=p9XCSypwJC/y8+bOFnFU1Jc7/RmGAoElPlFVmDCHgT5D6c3zUu/b7n7zCmKY6AUObH
         KmDPju3OJ4vEiqKSJGgYv5N7jORAnw156VusYYWy27xjDtBCGpPM2rdQgrJh6nTqRJta
         FEcPmqRKzBc6lJxmrVGE0WA+kvv8D7vh/8pY+mB5Sfco0+kfFfxG6WbvwCqfZS1l4Wau
         BGAfa87bDv2s40wyydWJaX2sAJjd8lkvxoaPvCjU6mjNas7RhpTKdpoVKXQCgOx31YWz
         y7XZLyvXtDWyXykBmHURBvhhG9egIMlXOS67khK37R+diZ4p1//IrWnVbg907H6nD4Dp
         AB5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724672353; x=1725277153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bk7xueDtstYJ9dmp/2G1Dduwg3O+kNnnJuyCn7RuweI=;
        b=eUdzznK/eiDhpUmv4zvRzKCDlJJh+VA0As+WixARDBU4xEYuSwtbbtOvMP5CiknANt
         6n+knuSoCWoqEPtOnRYTVL9gnXnbEXOOIudqEtGv7nvlJk89WtuFTJpsUD5YDWmLW2xP
         MlB/1Xclh7G/yoXPQ7l12MpATMPIS70yAVUjsbnBNFmyvylYPyuXB0LYOTbptVKT4R3o
         pgGvHflZydTYMzAt8lXqtaPII4FiNfkI33EzFy8h2LVm1tw+nbV+9lRiB/JxeCD/AyAb
         nnbyArdBHGUbgGqIJgzDtgkNYGVEkNUTHMorcm3tI8w+L9ewDhRk25lGrsh8W1OeNV/Z
         tZwA==
X-Forwarded-Encrypted: i=1; AJvYcCWxEJ4IuhNW7J0kvaPSV0zI30MLYXbSjcg+797BMbGdG4pC6lWNV/aFLfuHupZWPRs0fXugK5fhWEY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXYTrgFee+OevW2YKBhcwZ2zhoqilRFns7EK59M7TX4PEK1ASs
	pc6n6kqx4o2Qj8qHsKZwJ1glPPHisoKIePp3tl44SYwb1IZyMOwJxDJ3iwa/Iw6Y9EG6YyQA3iQ
	Ya6AqPm/fIj+NNqTq61AWxvBCaAiyxDgDHu9p/mrsUBtDOrSa
X-Google-Smtp-Source: AGHT+IEcnBMUIcCF5CUp8jBtc8tjDBrcMQ4VDom+21v1nRzD+R8Ys+j1l4ytsneSEda6sCA46AVz1ky/6kSNrhOrTfg=
X-Received: by 2002:a05:6902:248f:b0:e12:97d9:4204 with SMTP id
 3f1490d57ef6-e17a866d9b5mr12096548276.41.1724672353176; Mon, 26 Aug 2024
 04:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814153558.708365-1-jens.wiklander@linaro.org>
 <CAPDyKFqBuQ8uUdeThRaJtd2CYNWMmpLCEDxfO+znhwjPamH+Gg@mail.gmail.com>
 <2024082414-doily-camisole-b5c7@gregkh> <CAHUa44E0bLYHzoGs3onu6sK5dwXB=1t-GsFWt096z+u4aN6R1g@mail.gmail.com>
In-Reply-To: <CAHUa44E0bLYHzoGs3onu6sK5dwXB=1t-GsFWt096z+u4aN6R1g@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 26 Aug 2024 13:38:37 +0200
Message-ID: <CAPDyKFoZBXGKf_TMGFUCL8pHw-=5GrK12KQvnPs9vhhwVkAGuA@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Replay Protected Memory Block (RPMB) subsystem
To: Jens Wiklander <jens.wiklander@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Manuel Traut <manut@mecka.net>, 
	Mikko Rapeli <mikko.rapeli@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Aug 2024 at 09:38, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Sat, Aug 24, 2024 at 7:18=E2=80=AFAM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Wed, Aug 21, 2024 at 11:23:03PM +0200, Ulf Hansson wrote:
> > > On Wed, 14 Aug 2024 at 17:36, Jens Wiklander <jens.wiklander@linaro.o=
rg> wrote:
> > > >
> > > > Hi,
> > > >
> > > > This patch set is getting ready to be queued for the next merge win=
dow. The
> > > > issues reported by Mikka in the v7 patch set has been resolved, the=
 issues
> > > > turned out to be outside of the v7 patch set relating to configurat=
ion in
> > > > the secure world. I'm planning a pull request to arm-soc, but befor=
e that
> > > > I'd rather have acks or at least an OK for:
> > > > - "rpmb: add Replay Protected Memory Block (RPMB) subsystem" by Gre=
g
> > > > - "mmc: block: register RPMB partition with the RPMB subsystem" by =
Ulf
> > > >
> > > > Arnd, please let me know if anything else is missing.
> > >
> > > Greg, Jens,
> > >
> > > To help out with the merging strategy, I don't mind queuing this whol=
e
> > > series via my mmc tree. It would also be nice to let it cook in
> > > linux-next for while, via my next branch.
> > >
> > >  From my point of view this looks good to me now, but please let me
> > > know if you prefer a different route or if you have any further
> > > comments.
> >
> > No objection from me, please take it through your tree, makes it simple=
r
> > for me :)
>
> Same here, Ulf please take it through your tree.
>
> Thanks for helping and reviewing this.
>
> Cheers,
> Jens

The series applied for next, thanks!

Kind regards
Uffe
