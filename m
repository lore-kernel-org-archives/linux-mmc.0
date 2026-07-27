Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EA1368291
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 14:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161792; cv=none; b=rE7RsHLwCidlbKTB0AfgBoHjRdk0mOWKrQmJTPSHlAgvr+5QiJZizfWXSnh8X0VQVWIhJ7yUQPxSPbb3wQxewCHLbHyuJATcO/Gi5YUPpP/W7LvbiRArnyayuIXGh5WS0fIuROLYPIc4W7/uPQO0KCqIY9DbFbPBEjbsCmukg6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161792; c=relaxed/simple;
	bh=ZTt4L1rMqWUs0ZHpauJ7AWFGS7OSGMA9OLRAFFoDi7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pn4pt43kRZMIoyHe/MZCqqlCWZk8MAomeqTpT/bqDLcTK9OD5KNc3c7wrgtXnZ0DEvJTKOSLcyGVjzxcA+F1h21lvNQlh0VyL7l+bvqcfma9c+NPrjGw3lly4N9Cgujxak4LU6WP/sX6P3fZAVFBIqBGEnte89dEVhhzr8GHF9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNtDBqbG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNtDBqbG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8551F00A3D
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 14:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785161788;
	bh=ZTt4L1rMqWUs0ZHpauJ7AWFGS7OSGMA9OLRAFFoDi7k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JNtDBqbGJ29KkdkDKfqsYdxE3+ywZgPV33iZTweQ0NDewqPycw3xa6avVxofm5JFA
	 NWcQLVgyXX2jH+wqPJ24qEueyoZuMDMHzECszeNPw4fZwTmSYAybIESNIvZqGPkIc9
	 08M+fCWY5RLHTGAeBXEEy+gwxUxXUiJtLboKpPOy6kYKQrxyapI0wX5adAnFt3XJra
	 K9sKItugLOwZtUYUFVxNpyskAasXKlvFWCboNwc1QUBBn5RrHn/eH+zKRurzI3PJYS
	 MLY/iBC3ZpMjq9Kwm8B2ZG6TEsCulHS/eFF9PRKQPqgr2e4g/pSNHzDj4U1LzQK4hb
	 BXwqtEz86fALQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b2a22c52c1so3130217e87.3
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jul 2026 07:16:28 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrf4sGhYIVd+IpJ75B/hF/0iEAJxIf9Hugp0KWk/o3sxFrjDgCE8vaYGz4G6SPD3W/2Wzm9h3Dc+74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+v4LBc3dV+dWH6kJY/I4PXCCVvid79V3U0trnKO2wFbwRYb1p
	nJyLFIG7gkc5e7zrc0M4IiyeltB1Cq1RMA4rx/q/0FAl8/ZFVmloJQmf45Fpl2kho7uFmWzTKyi
	Nf2RP/e56WxJsglF3p45u60EMZl0slU4=
X-Received: by 2002:a05:6512:12cc:b0:5b1:54a8:6568 with SMTP id
 2adb3069b0e04-5b2c1b54a08mr1798111e87.33.1785161787692; Mon, 27 Jul 2026
 07:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727140322.41306-1-mhun512@gmail.com>
In-Reply-To: <20260727140322.41306-1-mhun512@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 27 Jul 2026 16:16:14 +0200
X-Gmail-Original-Message-ID: <CAD++jLn7z2uSvn11KTi2WxdUD4SXno9rj7p4N3tfGgL2kjJ8qg@mail.gmail.com>
X-Gm-Features: AUfX_my-ZM7DZCwcoBOePJb0b--NOWy9eg3G5S9SiaVu3O8ed7UMyomPSntzgfg
Message-ID: <CAD++jLn7z2uSvn11KTi2WxdUD4SXno9rj7p4N3tfGgL2kjJ8qg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: unmap the bounce buffer before device release
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulfh@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Ijae Kim <ae878000@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 4:11=E2=80=AFPM Myeonghun Pak <mhun512@gmail.com> w=
rote:

> sdhci_allocate_bounce_buffer() allocates its buffer with devm_kmalloc()
> but maps it with dma_map_single(). The buffer is therefore released by
> devres without the streaming DMA mapping being unmapped.
>
> Register a managed action after dma_map_single() succeeds so the mapping
> is removed before devres releases the buffer. The action is registered
> only for buffers allocated and mapped by the SDHCI core, leaving buffers
> provided by host drivers under their existing ownership.
>
> Fixes: bd9b902798ab ("mmc: sdhci: Implement an SDHCI-specific bounce buff=
er")
> Cc: stable@vger.kernel.org
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>

LGTM:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
