Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E7D304BBD
	for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 11:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766142017; cv=none; b=Y6RhSrOh2cfu6Oby09reLcO5Aj4xbD9ywvCI/ox6hqhSOx2yrPyqA/C8iQEeFrSj5FPb0qYRLtshR95gDhrqycLMtzwRefAc+U0Q/NgpE0jvdRL7T6bLbJbLJw/yPEEOTOD4OUCK/sesbJA/vhIMGUhkYTmUG+0TZZlrUZrA17g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766142017; c=relaxed/simple;
	bh=s6x/oEPLhMgTTeO4Ahkv1T1HFAlTv9cJwpa6J77w+kw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LtBaHFCnLve79VbhEe+c6hu1UPwpx88OLKnATgPhfbzQWUvYcLgHB5lobcJG53FSgpIfq8plu3y7CZ08n0Bu2n7B//O6+vl7chyuMcAYtWlmsnRE44h5oUiECzVovvtk686IEqbSWLx7GDddTNFRpO1PXZag8B2bHAtG1p3HCzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E3RCQUie; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3RCQUie"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-37ce27af365so13805991fa.0
        for <linux-mmc@vger.kernel.org>; Fri, 19 Dec 2025 03:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1766142014; x=1766746814; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s6x/oEPLhMgTTeO4Ahkv1T1HFAlTv9cJwpa6J77w+kw=;
        b=E3RCQUietxOXP7mwrpVkirkAmZyYB5jGkDn+okDIuobdu/3I/+kv/BHrC84UdaD6fX
         jnWLVxeK6bHPUL9HH2Zzjhao5cFZDe3sxqJ3ss+Qiaa1SM/me0Xk86lcIpc/sJtnS6lO
         h5iB5tLJ5d4XfJbb4+YDd5dEewhapAmT2GKHQFY0mJnA1XHe1hT3rQa8j+C6A+bSy2i5
         go5zcmBHO+f221QHYG6tuAVhU/uWDkYLZOf0dsWn9Ob2K5txcMXMkvYwJoWQPCjahJcD
         GgohEK6aAoVXC9FMJ5648+A31Ail3IITdrrEiN1HM0NBgrl/BRaVEmtEF4qf7MRWnqcu
         o9Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766142014; x=1766746814;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6x/oEPLhMgTTeO4Ahkv1T1HFAlTv9cJwpa6J77w+kw=;
        b=b7QctgnOMy/+pZmwaGU5bAxNUlau1BVHmVMeV1F5jiT5Ba1XoqA9kpyzgLer/zOr38
         vjpxrOTNbY2ukMS7dYkVljIO6QuVmgjyCtYJs0qIbqDqwxp6p/IHWq2mnOv4Xv4BMdz5
         LkYGYCSfJXpJlOjVws/wnVv87Lu46LnES87pKkq2AABXdIb3sBQTPwIZ5Za+vt0uXWi4
         ez3LpLTopMFrE0222lnLKsa9rx/Eo5krz3eMcWAmyXW6/SdBGj2rzZmYsIuR/R50eHN8
         Sa2/VZ1u8aeXuepyIy1PRsvizVm8zZXz6yYt7oXmbe9F/igVR/Txl8iKuRntu8w4r/+0
         ouOQ==
X-Gm-Message-State: AOJu0YyIwrk9Hsw7qL6p9qh1u03Sn8p6wsEMXJXtiqiJU7WE4Poxb1Yr
	zUUbkd/fScbrc4uLz8EDBOhDFbzCw7VRcoNqTd2LlySzCQawzpAxeJV0viWCw2zznaM2Uuue6sY
	O8Y5GzOlLuRezczUTqN0zTlNxDyq/f5x71L46mLT3Qw==
X-Gm-Gg: AY/fxX61ba06pukRcxXyBbzZvkxcNpJDLVJMyB8/QVBWC6T6GYuyUjDc83WxrSp/UTZ
	g4DRj8FSb0lEiTfkWGnplXnpEamQye56PQCjVyFVv7aPxr/1WtiDwSAxK7pdKI9P4A5YV442nyq
	o4AqoyyeMiVSdiIcuSRTlW9HlCgy34mbytdNDOmWY5zk6PeClccmH1dxYITNkXzpcQm2ZueOYGP
	qP0mLd3nzRfxYbxjHHmHiyD3DPq94V7f3PQRsMr3iuPdJq866nhfiUYmkoE0pf8zwpidooi
X-Google-Smtp-Source: AGHT+IEttooMjctn9PTkIuV8f3vwHQovTQjSbQYqje1s67e6BNM0jsY/HxweNA+t464KEMm/FbSoYdRYmcWx72TwOXs=
X-Received: by 2002:a05:651c:211f:b0:380:c72:d495 with SMTP id
 38308e7fff4ca-381216e11c8mr8642701fa.32.1766142013519; Fri, 19 Dec 2025
 03:00:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1765885807-186577-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20251218182343eucas1p2d8e8c97da2f3abdecd0a2f54b06c10cf@eucas1p2.samsung.com>
 <1765885807-186577-13-git-send-email-shawn.lin@rock-chips.com> <75e28c6b-c62c-4c84-9b88-6bc8902b8c5b@samsung.com>
In-Reply-To: <75e28c6b-c62c-4c84-9b88-6bc8902b8c5b@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 19 Dec 2025 11:59:37 +0100
X-Gm-Features: AQt7F2oURQ4eEyNd-d-X-XErN-cMe4gNff2U9XSWa8nAnD2DQAQhIueK-BGrKpk
Message-ID: <CAPDyKFpfU5Qxutx9WTz=4H0mbsvfsScWvTDi1KqP1Ab5_iaAjA@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] mmc: dw_mmc: Remove struct dw_mci_slot
To: Shawn Lin <shawn.lin@rock-chips.com>, Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 18 Dec 2025 at 19:23, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
>
> On 16.12.2025 12:50, Shawn Lin wrote:
> > This patch sets struct dw_mci as mmc_host's private data by
> > copying struct dw_mci passing to dw_mci_probe() in order to
> > achieve with mminimal changes. Then we remove slot everywhere.
> >
> > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> This patch landed in today's linux-next as commit 926311cf3361 ("mmc:
> dw_mmc: Remove struct dw_mci_slot"). In my tests I found that it breaks
> DW-MMC driver operation on Hardkernel's Odroid-HC1 board. This is a bit
> strange, as it works fine on other, similar, Exynos5422 based Odroid
> boards. On Odroid-HC1 no MMC card is detected at all after this patch. I
> briefly checked the code and I don't see anything suspicious besides
> this host vs. local_host structure copying... Reverting $subject patch
> on top of linux-next fixes this issue.

Indeed that copying looks suspicious. In principle we end up with two
different data structures for the struct dw_mci host, as the callers
of dw_mci_probe() have already allocated one that they may operate
upon too.

Instead of doing it like $subject patch implements, the allocation
should be done only once, upfront by the callers of dw_mci_probe().

That said, I am dropping the $subject patch for now from my next branch.

Shawn, please re-work the code according to the above. Even if that
doesn't fix the problem, it's still the right thing to do.

[...]

Kind regards
Uffe
