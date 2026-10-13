Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2057F3E51D2
	for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2026 13:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791899349; cv=pass; b=k4F1uc6aCEic/TWw+wQ/1hnn9OwsdiBL5cQZIjzhlEQu4rDpNMhrnNUm8MiMfnX+iSzlPDt2Ke6tZMXQIpHujC4ZCSTdyU2hP/bbef3pjxDyjH/9sVHwHrsR//3dPzDPSRnIVjxHlvkK8oW2FGQWPPVD4pL1ocvzxhxJFKiGG1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791899349; c=relaxed/simple;
	bh=5KKxHFt1utd2J5hTIaEt51KhNsCi8K6LQ6SAZ6t4QIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRIWQQ6m7//P93c2XYb3h+CWFPIEzB4UHWb0R0TRk7FwkqAoN3nBPWMlb6aXKDNNZmhYRwI5I9/b157IPQQjMN3QWXQaYMbL45jbWXC/eZmET+gO9AvjOWM9s4ixBf02LxfZstAB1OadyEBQsrIqzAEEC0AG4eyiuOS479JtlhQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=g5pJ2PvB; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="g5pJ2PvB"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-677bc4704cbso2576348d50.0
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2026 06:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791899346; cv=none;
        d=google.com; s=arc-20260327;
        b=Af12MfHHLApgCpdGKTJb56FF2IGkm1zioiL4t1OELxgnAKkMtuKuawsRDHbUzsQtY2
         QvZxz58PHtfGSacIjMZlZzIf8kAImhxK6fDgd3lp54hNcpErXIE6055pajcHeN1XWUTB
         u0d/gAslO85M77k6zf8O76z+yF1lWujFmrPbb8ndE8DRiGRannoH2rRl9CrSA8DAXXVC
         8kjgNDqfS7foTSinObj2ZFeBUg4LJ5csM6oHHs7IClwDj27ZsapePDsFDSZhGQqeQyLi
         h79Rj+hbdJYC1ewfEHyCdLUcGA/9hPCMgDC+cDOElxoF3+toUeGfLAwsvIT6b6q3JR7w
         Rd/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8JC4TnkkkQJEykNKjL1ks28PzRDsA6E7qVy20XFBtGg=;
        fh=dSztbln/5Ur0TKcjoyqJX3jiD6VLMHGNVfDutPrCS84=;
        b=sx6lPM5Ciqj3uUUh3ja4I8EXhUXZlSMWpi4fMRx/CcU4ANvHzIwZhvgO9TrOvQjTB4
         8eM3Ip3AV2zkvZqSQV8DgbT7bKLcat0K4X8AdQ1poFPFvF0DkNN7KVYJDsK5/dJD3djV
         ZHdRFTDCEPdJKmz1X9Z/TlHvFEYZA2tcA1b52xmFkmv2iYhv3mqSws9N0w4KINJrxSQL
         eeETtdZlzWbUFvsAbpZzptD3gCXB7SW4hdHtijXH9IvOwFwIaEbc8mv0xKD7mQujPK0T
         Bund1YY12AqLgCcht74Yuz3ywJPw4GwpGo6dLRBpU6vxg+BqKaaSK8sG3SfwMy8ZgArO
         kT6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1791899346; x=1792504146; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8JC4TnkkkQJEykNKjL1ks28PzRDsA6E7qVy20XFBtGg=;
        b=g5pJ2PvBpBgk3Mkwkil1KMhFvR35bYn03IajPqZCS5nLMlc+lNdus6kWwOGkSlkIkL
         /bh8i2+qlWjRd0B+ped23UN4i2Qov/ya+maIoMDqgIECUMsxoVeTgJusrhgiKCgwqRwX
         9Yn/cpSDLp3eKVL1Cmtg9+bVU8v+Xr+4sZGGzn5Po7aZ5yMhR4E69N45QJ+IJc9FLRtD
         CRQlTZCpIxheD/DuV/hEX4v9zU6M8bb0fsrBc+XfTjrNtKFPX1pMfSdJM1XBoGuxxDKX
         gPDL6mlb8Wp7E//L4niWydX3Do1v3EtA1sa/4nqr15EmkfXE8dO6EL+5h7b00FVnhO0p
         gxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791899346; x=1792504146;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8JC4TnkkkQJEykNKjL1ks28PzRDsA6E7qVy20XFBtGg=;
        b=P6zIbVpz1lUZkOJLiMXfHjI+08NkGCVpGHTN9R+JHdfQukcRxa5RFwpasURVldMA9b
         grWOIYH1gbfAWKEWc3QRakrRfPa+zBTjcqMjoTYMS5o1ZYNJTrgoR6AGR1xbqTpsuNwS
         JD5q0E3EAhAl7JpWQ+IBcNOu3v3Z5TISGvuM94equV48SAIxOIG2jPqTKbqzJ5XS3qKc
         RwQWPNSJ5bWhz6kcWZqgjI1CKoxUR1/N/C9pV3L1wfgbDZjGcWArSQeoFdCYHeRCdFF4
         rG6HsiEeP6+mXMp0diu0cbEEp9GgCuYy2Mg8M1rwsvgOJY5W5Tt4xi2m/ymYdFSnAmDq
         g4vQ==
X-Forwarded-Encrypted: i=1; AKwUvBzR/SUIQcJJoTTE7ldVw81dVDqqWn7trdOB3hnCE9EeoynNproPgvOKPqOJW+TBFlTTfEGL4sPnKSk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLZOWilFxVwuTrnKWUQsDCqE273lX9wmCI1nqEpwyPsWvM4zMv6
	UbM4w8BBayfLK4Sa3Kr9/bqssOecYobxxHawFMrZWMVqy5uEF9Vd5Zo9DvJTLR0N3+x3ev8Wt1O
	lI7q5TSuMgFu+9iGtz3gOj7m1pwGnu2w/VhERAF0Z
X-Gm-Gg: AYBFou3PGquRTkeWsgFJlD7XGVKgScRE+tBuuwQegXMAva1vR4HOFmNPKQE8NPtQkvl
	N9r675js7EjZiZlqnghT3S/9/YQeR1G4iWw4rj2U7thpgtHt/nFe6dGjTXsE1QGtnuFha2uyPoA
	l1vxX9VTgJQibBVN3kBabCxZgbA3ejIa8lM/bBGKbar2RKOT1kDq7QRRty96Zm9v+eg5/T0G1k7
	DBZ6U+8MIhT92AgWH7jjjMdlmUhILKT/B0cXujQHtp+pvvAE0s/7SmYzDvD5qfM5n02R3lYgmiS
	LunWJ5TFGmz6Ic2mLqUlDAgV3aG+wdFMztBHRBHTbjexAHfbJ2fhUkkSRcR1MnXPzpEXJCyWs/g
	RXwmPRcQEXzQ=
X-Received: by 2002:a05:690e:11c6:b0:677:d3fb:6b6f with SMTP id
 956f58d0204a3-679362fc5afmr3581571d50.116.1791899345622; Tue, 13 Oct 2026
 06:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783352430.git.sean@starlabs.systems> <7acac70a471452a6ccf23b7ccc557f3c3861e0ad.1783352430.git.sean@starlabs.systems>
 <20261005103011.03175826.michal.pecio@gmail.com> <CABtds-3t+ECCPeFShq__iNa9niRAge=WOED4cHtNZAFVw6kPzw@mail.gmail.com>
 <20261013142737.7b10a5b0.michal.pecio@gmail.com> <CABtds-0s8Co-qWk0xm=R1pdz3JyV_GyaiwYzgxS9g2tFwtHRzg@mail.gmail.com>
 <20261013143836.76ad7bf4.michal.pecio@gmail.com>
In-Reply-To: <20261013143836.76ad7bf4.michal.pecio@gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 13 Oct 2026 14:48:54 +0100
X-Gm-Features: AclHuK-MIJsRpvubJRFscXHmX4V8Uu_X8keb1uPXgNmjX7WNlocg-EqGPJtslF0
Message-ID: <CABtds-1kHYrA_RtTtUh0jmx7jC6=08vDce5pREWhtv_cxGAgAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] misc: rtsx_usb: avoid USB I/O in runtime autosuspend
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ricky Wu <ricky_wu@realtek.com>, 
	Lee Jones <lee@kernel.org>, Roger Tseng <rogerable@realtek.com>, 
	Dan Carpenter <error27@gmail.com>, Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> For the record, I have no issues with wakeup on insertion when the reader is suspend.

I do, but only on Meteor Lake

>  The problem is when it goes to suspend with a card already inserted and doesn't wake.

I can't replicate this at all; my "bunch" are all fine (glk through
arl, and cezanne through phoenix)

> Sounds like the proper condition is to ignore the card if and only if it failed to initialize and has not been swapped for a new one.

I agree; but that approach wasn't accepted.


On Tue, 13 Oct 2026 at 13:38, Michal Pecio <michal.pecio@gmail.com> wrote:
>
> On Tue, 13 Oct 2026 13:31:26 +0100, Sean Rhodes wrote:
> > > I have a card reader with RTS5178 and a simple SD slot, no tray.
> >
> > Thanks, but what is that attached to? i.e. Arrow Lake
>
> A whole bunch of USB ports on various xHCI and one EHCI controller,
> none of it makes a difference. For the record, I have no issues with
> wakeup on insertion when the reader is suspend. The problem is when
> it goes to suspend with a card already inserted and doesn't wake.
