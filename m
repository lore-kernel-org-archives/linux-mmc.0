Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01584EF122
	for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2026 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791894701; cv=pass; b=Q0zlFnanAakq0mVzHPRVrO9BVk+ZbQ3Ju34Ywfvn+4ANCl4TzyjoapM38jrUOxg0pKAws61DjlI7AG6cmInhnOaRfy8b7IztYKGD9lbywVwhK0YOzEMWxn70QHxC8aZLY/STdLU5awpbVFi6Da4RltcHA+tV68FfbkdfqyiCD64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791894701; c=relaxed/simple;
	bh=bQuvyd+lLMLpP+/naLydRfyvKQ0tICbP+2oXkYg2JWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D31vZ7aL1wi5jZ5oIW0A1IHthgvjhToZjNlz7Y1oMyYIclSUddxURJ6GnwAocCFdsEcvMEDlRiR+RTHEbtI3jIsU5xiW48pK4GG80CmxpYPAz6Q5ke1aGtBnmyOlw3vqR7/UvChL3TQGlKXEoX+st4e322ApZfGNiFkE+qdUi4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems; spf=pass smtp.mailfrom=starlabs.systems; dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b=rMGIzNtm; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starlabs.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="rMGIzNtm"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8acda240937so20650197b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 13 Oct 2026 05:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791894698; cv=none;
        d=google.com; s=arc-20260327;
        b=VAUYeJy6j/tHm+doiPjTA+ZHP3ByM+SFjsNAWX/3nmqBGLoKHym6bP7CxdklvlT6J3
         GguRdgsXv6FuVBfLhxsbtcFJ1UWINiua8xncRk3A8x853V5Dl94vt6ZAoE7dLTdiJDsX
         7eZcaYENwfNYDvL8lzRFLoWljXAa5ricwcU0cZFj5r+ESV/nPeKQ4+POPLxBWq4Wsvo4
         qMJMDCWlEvESU1swAOasc9RVlUPTrcxO6CjXsTTjYCQ4FKDmhm4qKYAH/EY43ikTpjZM
         cyI0jZW81pYn152L1zw7WFC81vw4PE8d0gpADAdzARwm/767BNXrmWCACFEihymVx1F3
         B89w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bQuvyd+lLMLpP+/naLydRfyvKQ0tICbP+2oXkYg2JWE=;
        fh=/XAxZ0cSkKaP93no3ENmFoN5dWDQcwuP7My8cUi5WcA=;
        b=RaKh5U9ubQoXtHEI85OkDG9JqakatU2x7ysqmAPsWsuxrmImFvqfcS9VrmZhlSxIf0
         7WZo/CqZ3tReCOfm3HA94rxarCqL5OQxljp5DYcTjT4nQjNXSm8+dN5oTPlMUubMgFdk
         pzAmaeosItKU5XpmvmGaObDm6vSCpQge7T+bLdkq6bWhLcT7KinOia+kqfRNdPhnWChL
         YqAlS8FEpG5ou8loWJWN1y1bUOCxtOXRVWLWpJytaoi1SxUu76kJkAf07GdpyfP/AjiI
         QLp9Wc/aL2xJTLQaOYGBehlYTfc0Qb9XBpIAYDJrAVid1M2+WP/ovl08Q3usoQWKXiTN
         CXlg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1791894698; x=1792499498; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bQuvyd+lLMLpP+/naLydRfyvKQ0tICbP+2oXkYg2JWE=;
        b=rMGIzNtmZ2LTP4fb+HRn7UnXWzwpEnMhQ83qiWXYn4CN/oEBf8B5Np3sMm98DEy2qb
         ftdZAMfGP4YjCTeVCvJIfOgolt4iXYJtaH/x0+cSIHZLt+yhdVS56BecrrP+Z6YQ7Cts
         KHF0AJOavpzubN5VRn+z3pjQpZB6k4o8grKu0n6LrlPOHC6TFCIjH8Jc+WwGVQz3OdZ3
         d4abxQdpX7+Og2N1FRS0MHgcYbmO7G9OPyQxd7+nZSTVIJOzT06kKGu1kmKLDtZbp8Lr
         hXcwF1HJaPcb+WuiUAVuZ50Iz6xr7FQyGyiTCRw0/JCbeJYKtfR7O9gNMHsVB+TMi5w9
         BWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791894698; x=1792499498;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bQuvyd+lLMLpP+/naLydRfyvKQ0tICbP+2oXkYg2JWE=;
        b=IqoRtrEW0Yg1xqGHjnijtU+l89r/5YLuA49g5qoV8tB2fGIKWgk+AutjSR9YzRWlJX
         RYnSIiGss7q6p6YvTtwGiMCmE8emyHIcu4C+oSarYqJsbit1cQLdQJxQHENMe1CUebTb
         boFmLm3Sz2nmh6W6F6yXivatTT3KBpkWpxwyJOdOu4EHyt7qmtyNYlnSyLdzTBxxZpj6
         ADAWJFrHyVmnaHS/+fXPgXfaoHiMu6oXVNO3XM+Qrgq0ZHcmtNbPDZl6R9K/QxuluIJY
         8/lNgHI3UbzulqZyS95MD7KKLo9qZdKZje1IF10ACJGfc1cjBPlYaM5jXFqABNPsUGPp
         2sHQ==
X-Forwarded-Encrypted: i=1; AKwUvBzJHcq+1BXTQw1tkTCOGOvj1ekJASNAWq4oqtA11zryYAi8uGmmK6FhBCBgccaaGFUs9lhmzqBbd3E=@vger.kernel.org
X-Gm-Message-State: AFq9FYI6XEZJLwuVAgwop2wWC1twe1CERc4zgtB3zmylPffN7/FAAwMz
	RlHHyEBkNRVOkcI1ho/ZUA9aq8XspPEQ6w5LQJbTb41YW4Fltmba9gMlJfdN/QP1fJDeYD6HUAL
	2Rz92Wk0qdS+LEzKfRc5knvtXjRMVJ+BbChKfs/er
X-Gm-Gg: AYBFou0tb36EfRomKxomQJTTQQu9TuLoxsNsdGHfkr0YvtTI8WILkrVL4WetPEMvfDO
	L7tw6mv4E7udXBW1PiuJf9W5+0qPvKn8Dj11g0lCcei+qn4K4uK2CQ5uyv28ASphVi8A3A7lCRn
	u0gjhhStsgs+9xIYC4uCBPKWcgAL8Emc+L+UHUfXCL8RvH/fWcd97rXIWcx0UKVIs2ncAThJTwt
	Mroh8vyMfSrAS2B/827DG8hByEjNQKEWXy0Qb/R9WmwS+40N6OezEzEhxkCI7tMtYwUE18K343o
	ERNDxRujIUTU4Wsp0URMmUE3gGs5/RleY6zDCAHnyXR+RWuk2ae1812ku1kEC5IoQRPofnNENxB
	i5ftEz26UZZk=
X-Received: by 2002:a05:690e:1c1c:b0:676:85ca:71a0 with SMTP id
 956f58d0204a3-67936297c42mr4229864d50.112.1791894698388; Tue, 13 Oct 2026
 05:31:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1783352430.git.sean@starlabs.systems> <7acac70a471452a6ccf23b7ccc557f3c3861e0ad.1783352430.git.sean@starlabs.systems>
 <20261005103011.03175826.michal.pecio@gmail.com> <CABtds-3t+ECCPeFShq__iNa9niRAge=WOED4cHtNZAFVw6kPzw@mail.gmail.com>
 <20261013142737.7b10a5b0.michal.pecio@gmail.com>
In-Reply-To: <20261013142737.7b10a5b0.michal.pecio@gmail.com>
From: Sean Rhodes <sean@starlabs.systems>
Date: Tue, 13 Oct 2026 13:31:26 +0100
X-Gm-Features: AclHuK-gfZVil9yXDIcZhUFuimzZc6z2C6fJBrCjyXvykiGCNcXOlXVVejAHGvM
Message-ID: <CABtds-0s8Co-qWk0xm=R1pdz3JyV_GyaiwYzgxS9g2tFwtHRzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] misc: rtsx_usb: avoid USB I/O in runtime autosuspend
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ricky Wu <ricky_wu@realtek.com>, 
	Lee Jones <lee@kernel.org>, Roger Tseng <rogerable@realtek.com>, 
	Dan Carpenter <error27@gmail.com>, Jisheng Zhang <jszhang@kernel.org>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I have a card reader with RTS5178 and a simple SD slot, no tray.

Thanks, but what is that attached to? i.e. Arrow Lake

On Tue, 13 Oct 2026 at 13:27, Michal Pecio <michal.pecio@gmail.com> wrote:
>
> On Mon, 12 Oct 2026 22:34:14 +0100, Sean Rhodes wrote:
> > > How is the driver supposed to detect card insertion after the last
> > > poll but before the reader goes to suspend and can issue remote
> > > wakeup?
> >
> > The reader uses remote wake; what hardware are you testing on?
>
> I have a card reader with RTS5178 and a simple SD slot, no tray.
>
> Remote wake doesn't work when the reader is not suspended, so before
> suspending we used to check one last time that no new card has been
> inserted. This made sense.
>
> Any delay between the last time the reader is polled (by anyone, for
> any reason) and actually placed in suspend is a time when a new card
> can be inserted and completely undetected, forever.
>
> Regards,
> Michal
