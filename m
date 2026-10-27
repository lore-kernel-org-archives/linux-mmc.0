Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.98.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098874;
	b=zSU9rosifwAGyj7r+8zVXsmKG2/5GMdEoOX24NtKqk3b5tErYYBFcWCN+UdJMGXr4QJf
	 2PCtqqSjECduVRYYYfey2GiqstCOyqUBXstQcpwRFXXligJ3ijuXqfPBSsC8ae9DMNb/z
	 0MpX/6/pYK8/EdWSdAcBROadd4LOHz2t40QR0BMvplW3pERiDIaGbYdTNl7CZFYTe9Dxp
	 9V9CKRtlEU7VTMcgHD+21mBP7qJDSMyJC3/2w69SUBXL58wlmMW5wiSJeN4gTXGvKe5UV
	 1Ye9+x6MMmzVDvqzescOtTv+rRa0dTBrZplWu5u688y/cqDaDDLRDYOThVRic0xBHig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098874;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=vgn/+XBoLaT9001BrzrBGzKDV91J5TSEJlR/hOLDCBc=;
	b=Gdy5YAQk0sf/khTbikUo2ZyfOuXiP0a8Oi7ZusOhbzluOcpGtAHVb1maVEwDyeiGOdfo
	 zsN+dbqWq5LFJy5lDBPfPoUDF83LGCgyOq8BRof1GBctsaSqJNyANGnnrSrIwEchSCzaO
	 ZFaNTUPhagdZGqjnUtlERaIFUq+tl7n1d67JYjO/kgo0m26qPtOegaW6jw2huLPoZ5Ek7
	 BrAbJWgf+bdg5iPaLUgqmP7Eq7iHYTeJvHv7Ih4qTJJXvlNMMwUIMkRY/XdYGkINTFmFm
	 N9zBXFxZ/HoO1c6KV/oOkHxURS90YM3zQWIKyWsojDMINnjG9NejYslq+EUDirsaBUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=rojer.me;
	spf=pass smtp.mailfrom=rojer.me;
	dkim=pass header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=F3jqO0tq;
	arc=none smtp.remote-ip=144.76.98.110
Received: from mail1.rojer.cloud (mail1.rojer.cloud [144.76.98.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8A606A31B
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 11:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1C8A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rojer.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rojer.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rojer.me header.i=@rojer.me header.a=rsa-sha256 header.s=main header.b=F3jqO0tq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rojer.me; s=main;
	t=1793098864; bh=4pXZShZiotLNas5yd3Kknxfosgbwr5B+M9bNvsGExxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F3jqO0tqnv8PmFHgSWzj0ySj7t1AbcDJMfZ9jpLJSxOsknAV2Grwh8P/gMZztA46t
	 FbEob/NJ7TzIcEHs+sg3zMoxa2Vep7jm/nHoVjIXpEXqKLuvpvWSKRZNu9q4rtT4yk
	 MHDvIhn5O65KAg7FxMCXRpUJBxelovh1G/Or9gTM882l45HKUx1BL9AsZ51yqjK8Nf
	 hRid+KYnMIRf8ADrc68rDdQ+jIWU9RWabY4V5CpYQVkkby9iznEjZlL2rRGQzza0OD
	 y8hKgkhBBkMpRfByGMcGyTStrBlchw0kxlx+e9FtnaOYzwqCI05ObdRqaUKhROwZZY
	 HFr2Dqp2kxiOA==
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail1.rojer.cloud (Postfix) with ESMTPSA id ADC431271C3
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 11:01:04 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-4a6bb779d13so2031772fac.1
        for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 04:01:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxDlRjhU7H0hoWZCuOmaqwPYpmYtZMuMcDwOWdbEEWzyFnn4sGdIejusS0xSEiXOVDdvQDVyFFpYRk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHSQkq4EKZuGR6HNtMH+HUKkkMmaQm+6NXdu8aPrVDxPkG8oDx
	EDk2XTc4EhPsVwix+mwBuZTKy92H7/oFdE1PqsVNYfFJROrK0oyMLFS52rOHqiBNHttgQ6EOvHa
	eY1yM2F1pC2AOEUnkmjZ+GgBFjpFlvg==
X-Received: by 2002:a05:6870:2106:b0:4a7:4452:bcb6 with SMTP id
 586e51a60fabf-4a83f579d76mr6347732fac.38.1793098863284; Tue, 27 Oct 2026
 04:01:03 -0700 (PDT)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023232813.2983368-1-rojer@rojer.me> <20261023232813.2983368-3-rojer@rojer.me>
 <4e8bbb32-e062-40fe-8ee4-363e83a68f2b@rock-chips.com> <46a26683-9d8e-451b-bc98-505b1c13b09f@rock-chips.com>
 <202610261435018282601@rock-chips.com>
In-Reply-To: <202610261435018282601@rock-chips.com>
From: "Deomid \"rojer\" Ryabkov" <rojer@rojer.me>
Date: Tue, 27 Oct 2026 13:00:52 +0200
X-Gmail-Original-Message-ID: <CABFmFwr0JozEeaDd4KErDzh+DWjkjkVRo6z61OxHG6BE=L_hKg@mail.gmail.com>
X-Gm-Features: AclHuK_qWW4rzaLnwQHFLDFsw_amnTa3SRrrRqVubNsZQXOOd4w_KfjlwheuRvE
Message-ID: <CABFmFwr0JozEeaDd4KErDzh+DWjkjkVRo6z61OxHG6BE=L_hKg@mail.gmail.com>
Subject: Re: Re: [PATCH 2/2] mmc: core: sdio: skip CMD11 if signalling is
 already 1.8V
To: "llj@rock-chips.com" <llj@rock-chips.com>
Cc: =?UTF-8?B?5p6X5rab77yI57O757uf77yJ?= <shawn.lin@rock-chips.com>, 
	Ulf Hansson <ulfh@kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, Jensen Huang <jensenhuang@friendlyarm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 at 08:35, llj@rock-chips.com <llj@rock-chips.com> wrote:
> With this patch, swt6621s can skip CMD11 and successfully
> enable UHS mode.
>
> Tested-by: Longjian Lin <llj@rock-chips.com>

thanks for testing, Longjian! so in your case it's even worse: without
the patch doesn't come up at all. good to know that now it does.
note that your reply didn't reach the list (vger drops HTML-only
mail). i'm quoting it here for but if you can, please re-send it in
plain text again, with full context.

Shawn, thanks for the reviews! you're right about the soft-reset vs
power cycle: card is soft-reset, not power-cycled.

Ulf, if there are no other comments, please s/power-cycle the
card/reset the card/ in 1/2 when applying. sounds like we're
converging on 2a, so the alt patch can be dropped. or, if you prefer a
single cleaned up patch set, please let me know.

-- 
Deomid "rojer" Ryabkov
rojer@rojer.me
