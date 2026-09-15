Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A10627AC31
	for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 09:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465728; cv=pass; b=qzjsP+/jDa4E4tVZ4IKMgMorM3i8U20KtJFV4HiJoREfQcKlv8f3JzE3SCqnYDKZiqTGPtvUjxOFX7GmJUwJCuvjhKD+2TasTyyevO9kR5n8iFQCHusgIm6HOFuxiy0IKf6NRdUvZZeQkJIQZ/z1wBqAZlQf+cXW6idcVqxdeqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465728; c=relaxed/simple;
	bh=kqN7v6OkOyHJgxbwrpC5Eacfx8YjrcZBxxUXMIP2YC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EID8/mK2pXaWpauN1n5FMeO+y9RT2U4iRKSgKqWYTas8bqHE/A2jNB+aDuyL8KVN4ElJbTLLZ6VJuEiSGLmIWQfF+QAiBY04DB3xhwwMvVw5VMxHDvodwIJgc9Vi+9lfNt6Ua9M85YARh4lsQag0bWg1EGd0s6kkPM+p2tFjdzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FP1ayT+w; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FP1ayT+w"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d43ac8d1eso21538557b3.2
        for <linux-mmc@vger.kernel.org>; Tue, 15 Sep 2026 02:48:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789465725; cv=none;
        d=google.com; s=arc-20260327;
        b=aZBU2WCzASOzpDuOPaAVQ/PrHpXjSjpt7H/MbtOaB0Z5uMlSHX2vC7P65+jONSY4UL
         vDU8TYbxhsHKiNOYXmPIPSMyZJEiZRBsTUW4glV4agFEBg0Qc/jgRrZM5hCvh16CJCFM
         wPbC3i9ijkgHoOUNfelyrgdByLWaZOebTQPOspDJFfknygPr9cf+DDFqNJYbmA5gZEe3
         DTdIQ53/r40TQ6nm5POHU1P9jW7FxmUY3m/6/TMMbJMQk6mT8AIpF0Ble8Doz2y0CTvB
         xOrmCBFxF3hDt1bzD0qsV4EBZ7msPoZ6n75k4UwlfO69+sKHXr8VcLm146YfgjG7hk2m
         HPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xt/N1c2QTUTpESd5vWZaOt8vFR/C1nSv7TXwJ+U64JY=;
        fh=JQ2jmZ+2nWnk4FccUdlbX3STIH8cR1Te79tp6KldQtU=;
        b=o+RkPiehPHt4P+0E1LWdpPmEdxFrU5c2vE9adstehsV9X/M1gvL4IUqm7ILXaWf0Fx
         urAM+VSDZFk5FCiMgPbq440CCraMSocukznXA6a0ul09TalQRYw3wryixh5XdLnaa/As
         tZ2VqdwchRxqC6GcDVpSC6oHiOnwA5HF91geL8NdnC63MZa1d54zG3EQeE8C0xe9Wl5y
         HtJ2zbHiV4uYHzEmXrQMTeRj47LwL5cMtbCwVBVHhwzJdc9xiNxobtx7W6rlk13PKAFD
         xk2sP1uRRZbWsk0B5JwfLNMKZ4VGyzSy6jB/v2XXHfHwuyr8B76LAgj3A4Bl6uZwvuTu
         y50g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789465725; x=1790070525; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Xt/N1c2QTUTpESd5vWZaOt8vFR/C1nSv7TXwJ+U64JY=;
        b=FP1ayT+wSNVGfq0qzEdIfLUDQ4EfryMIXuD3nRX4TOJUzphwV99dqE3p7XBYA0fQ3s
         RuBpaTMyg2wbPjxKnlNkOrSkTwYbcm0/u/UmDotjQoOJhqA8wuOr/wCeWExDVJrEr/T2
         msBszEVwdS/VsnoLFQI3ABwbyGsv5161f4qQ8fInG1BiFy7aSiUnUiAReT0fQ1stKlZT
         Vr1+oIbnjLV7la0Jv0qd+pch8VU/UIJPDISn9OM5E3KJSocmXHinYq6/0To6LiZvE4eS
         GTu7FsI/aALM50+W25FPo6Dq5yNGdQV+ZRdz9MMG2LgBmEMLZZnGd48dDAdwf+rlGns7
         MvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789465725; x=1790070525;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xt/N1c2QTUTpESd5vWZaOt8vFR/C1nSv7TXwJ+U64JY=;
        b=UfRcNKhpQHWvs6JpvtFVAQUkHOodwaIkdGAbkIP4ccsOOSERam+CEwkhX1qdMrY9AZ
         kDfIjy6lrOAnMGWAJGT0VcnLa9tiColHoZXV4boeJblrN6UzDXo2dYPBgY11lgFWAIio
         dPzZYKr1hYSie0BwFft2BdXsySJ3YiTWjClHsvGsJAggYIh/7d1Sm6PgNoBuZew/Gdgh
         564d6dGe/yI/k80GPzLafNI/WxK7dmxhdudidRqY5u9LqT9iUoch0tzUmNJjzzfLTqNY
         m4yBiC1rYVnZU5HaEIB9ok/z8vXzXyPpa7MjJp8gsdBAi/9qOmmej6qwdG24Nz/5Xd59
         w5dQ==
X-Forwarded-Encrypted: i=1; AKwUvByi9AliupwlpXMr9zGFQsRJGw45W4mzx9XbTRm7xx2TSGcMMkTEOp41vsK9sp07S3M+31f4w+RwPaE=@vger.kernel.org
X-Gm-Message-State: AFuF++lDXNYqmYG6ZC46mmrVXrEZHC8zR9jB2jo5x4+j9+6OEEE3HEpx
	IA1TTo2XjpTL9LrTWEoz5F5+BycIrQmtrXNojIACa7V4OYi2Hiq211Ed81qzKARUgDJThXUSrt1
	TY4lXn/JcmpAjogwfOIM8AKXez1Mr/Wo=
X-Gm-Gg: AYBFou1IuYyia5DaGB2yNtKfzFnVy1E4nTivSR2EFjUaDDLKgCQ91lJ8RVC4Zu/cjrT
	r0bzlwqSotvZ6Sryoz9i6k+Mu2CzjO9O3icjLM1NoK7wXfbf3pLxXam59S8oruJVvr3YzOAb3ng
	Z2YXYByijo5vNK3JVHsWn7sdKhRRRmsVvmqz8Stsq5oP23Dkzbxt8vmcypNl957DtrtO+ZEbCGO
	nGtvRYvGiSxkhclSHITeRaSNdsPuyD1J40l/n/+X+Wr4WXNIlrxw9L+MYQccVj38nFsQmjKcCS3
	0CJiTm9ZzeQIe8F4S0YQe4A4DNAgrvb65o4ex30I8lM7Fpn0yrfugmvZ+g==
X-Received: by 2002:a05:690c:9990:b0:884:b55c:1bf with SMTP id
 00721157ae682-88d19927a33mr17511267b3.0.1789465725204; Tue, 15 Sep 2026
 02:48:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-07-k3-sdhci-fix-v1-6-b15c5d0f64fd@kernel.org> <20260907155300.1411173-1-alan.tseng.cs@gmail.com>
In-Reply-To: <20260907155300.1411173-1-alan.tseng.cs@gmail.com>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Tue, 15 Sep 2026 11:48:34 +0200
X-Gm-Features: AcwNN1UPWo8A8KL1cUnWKRSOKo7pDITqyT1rjkjcajM5WYeVYYuEMRIWcJfeozY
Message-ID: <CABdCQ=Mi3M8vGCYjURicNWy-Bh22qN199jOdHA5rEfTzui2b_A@mail.gmail.com>
Subject: Re: [PATCH 6/7] mmc: sdhci-of-k1: Improve RX tuning window
To: Hung-Chun Tseng <alan.tseng.cs@gmail.com>
Cc: dlan@kernel.org, adrian.hunter@intel.com, ulfh@kernel.org, 
	long.wan@linux.spacemit.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 7 sept 2026 a las 18:00, Hung-Chun Tseng
(<alan.tseng.cs@gmail.com>) escribi=C3=B3:
> So a threshold of 50 is comfortable here. It also supports your
> rationale directly: boot -2 produced a 5-code window and boot -1
> produced a 1-code window on mmc1, so the narrow-window case this
> patch guards against does occur in practice.

A jump from a minimum window size of 3 to 50 delay codes is quite dramatic.
Could you clarify how 50 was chosen? Is there a specific hardware specifica=
tion,
phy datasheet recommendation, or test dataset across multiple boards that
justifies this exact number?

> My question is about the form rather than the value. The vendor
> driver takes this same limit from DT, per host:
>
>   sdh@d4280000: spacemit,rx_tuning_limit =3D <0x32>;  /* 50 */
>   sdh@d4280800: spacemit,rx_tuning_limit =3D <0x32>;  /* 50 */
>
> So 50 matches what SpacemiT already ships -- but there it is a
> per-controller DT property, and this patch turns it into a global
> compile-time constant. Was that deliberate? The vendor design implies
> the value is expected to need per-board adjustment, and with a Fixes:
> tag this will land in stable, where a board with a narrower window
> would go from "adjust the DT" to "patch and rebuild the kernel".
>
> Two options, if you think the concern is real: keep it as a DT
> property (matching the existing binding), or keep the constant as a
> default that DT can override.

I agree with Hung-Chun's point regarding configuration. Hardcoding 50 as a
global driver constant assumes all boards and trace layouts will behave
identically under thermal/power variations. Defining this limit in the Devi=
ce
Tree (or allowing DT to override a sensible fallback default) would prevent
boards with slightly tighter tolerances from breaking or requiring kernel
rebuilds to boot.
