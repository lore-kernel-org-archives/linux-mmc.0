Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B64502F
	for <linux-mmc@vger.kernel.org>; Sun, 17 May 2026 06:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778997676; cv=pass; b=jbMNZi7qCGSF4dq6qUjZGaP8sz/m3JdIEol2XQRguHdtAlPsUZbKhOx/yqsfIfjobz1LsQwCNsJ1DCaRAJR6hQe9rkpvf3C4VGl9+3hez4/uajwH51V3gQ+jKdaSuEHMg9HQZTvPif5fUkLxTm8DGzm7ClGYHGjpzv10JB2lcSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778997676; c=relaxed/simple;
	bh=IqQFfv6/r0JK36WkjRDXAwlyLd9uPo5HcQLjEUhczc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VSW47yoW0uA/ytkpBShVndrU3erEcmpb6eocKImFroh9R7e+YeiD0imjnT343CtkOLNgkuIuEYxdVkrvOWFI8GLK3kkH8DxlIR2UqCPWUZRCIvkup4c4KKemljQ8P8MUEgzOiyWs8iRgGBmxvJHMWjBtwM6lUU+aAkk+VnTciA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQUfevh0; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQUfevh0"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-368f25ff4c4so481380a91.2
        for <linux-mmc@vger.kernel.org>; Sat, 16 May 2026 23:01:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778997675; cv=none;
        d=google.com; s=arc-20240605;
        b=a1wzjfzVjOUdE77doto/dahNQmoWpBEpxxQiF7u86hgUd3w543L5bsSQ2Z2mM/T6IR
         TVk2eclzcDwYTrTCQIc5MIEjScqmWEqSXAWGPA83a9HSMIZn5fnpxFeNwuT2gqNkrjJh
         CeOPeWVoniD0fAvO+roRDHlx0vB+HSk7du7A0ElCYHOHEpp/H0al7Rm8CA3qaajZCoLn
         es61xlWyIZC06IMB08Ja5IftsA1SvJXCFHnPjjqr/VxIlw/8+vF4qb//RXILBoiKVlAb
         H9FqU6KvC1kuW9SCbunLFLvuYoUSO9OyJ9fFQPnuj3Lnckv72Hi7NEYnUvFjZXq+50XC
         mWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IqQFfv6/r0JK36WkjRDXAwlyLd9uPo5HcQLjEUhczc0=;
        fh=Xn5gGOD0wfvxR3QQnaA7YlzIeHMppEapma8laY3ceNU=;
        b=Qx1ntRQn5GGn6uijKyq92NEKi/+8jmCkyHCJkolpEg4QYrTZRWOWJLhTFB8xoSNgWW
         XZ1Ftl0qEiLXFTUlaTJVjJxY3U1HkoAacsPNnj4im4EmVBfE3P5gmcTUupi3pxPMIRCk
         TjfqkJp5VUVw86m+pkYkedwOd8n9bEoK0E9v6ZJOX7OdMKx645aL+K0wKRtMn/eUpIU5
         XJaRNhixpLFkxz3Vr21WVIRiVJJE4Op3ESK6V8YAAN2IzUhYEjr0t+jy6MXTth1ujO+d
         0nnRGC4Gt3dXWNiOWMkBTyWxp9d1+K9VDUHd/Mt5MEI9pUD+IMLTFHAW5bWVHraD3dRR
         HKCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778997675; x=1779602475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqQFfv6/r0JK36WkjRDXAwlyLd9uPo5HcQLjEUhczc0=;
        b=ZQUfevh0y2JadbdJDH8S7ErTw6NEjtfmhIcvB5ahuYM4sIfWkQWKfbWhvw0HHz9G7A
         dgnP3j46MLUP8kJIBBKEilQDVVhlVzmdItUYkyMceogLCYZMtyqK5cmgK4xfXGnlGJ5Y
         7o103eegqpsVRR9rxT/EwSdIQze5u+rH8OuTrPwOO4Z1UIACDc77VncbAK0fCZD1M4Pc
         vuw0NWHaoAqyQDRiorjXFB7m/XUzmRORjpZNqOTshYnPd8QiTsKjbonEvC1hV4u97zqj
         ndF7qymTBEeGrWdgAJfNOGk49OQNCAr0s6/WL9bfohlsgY3c6G9eVJw5l/vo8nZgn/FH
         HfWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778997675; x=1779602475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IqQFfv6/r0JK36WkjRDXAwlyLd9uPo5HcQLjEUhczc0=;
        b=Ylmf8yEw3dx14TNapzMpUzHDu4yUemRTFshr/J7Mtem2Dv3FYYf6AkGEQFHQeTYz+k
         nZhr7E84tmw3094R544Ia0cCvaBF5jZdwmpehrqWjv4dWmHZB/vzIT76mZVPdqcXJFy4
         3A8G3tOfwIbgeLkbFfJsgRCiEmM1omNZYCAfnKOhhL+sNc1lR1zXm85wy5YMGPGnpSen
         IG7QgrJZQqCzTt/9n2gOtDYvYnntLiueXmRhCGWObpZc9aIul/KVkK3NSZjwPjg2TUNP
         AHSc3evutTOMqcM65yP9EM6kPeEriSttvt7+SO7TgBBoJpbzLhoGWDBoju7rhqvjsK3V
         aknw==
X-Gm-Message-State: AOJu0YwxUex+1eK5tWOsCcKmzZh11tr1BHMy1HUVOYOWtM5xdU2vlJ3A
	89pZ5UzRijlQS6KGKXf4mfCghqOEVaI7+ivQO6k/+BwF/gm81dWnS5nrKtWfullnG/oH4feJjw/
	gjE0Q2iU4/WzeLQ8QbqW7mJm3Oxuwa5sSzC7Xu7s=
X-Gm-Gg: Acq92OERmxLDz1b4p/lnpjsHwGucvNHizOs9LPabBuDUKyTcieIZw+OUOgETBF3W/dn
	fQCZNPDll0XPrCNMstYfzm4zs6TD8g+zqBu4bphJRILBKUx1nXARzetLrEBDFqv+B9fzzXOMwDe
	cUINwz02RZ1y8hcprUPPDmPpOCh22bcTKS/RrAIbWGKH1Kl93FeGsz69fm5FUJkS1rF3lCude9R
	RyRCzmDD8rC30jFPeSDK5cpptOmrYjusXLo5z0KWcvtCyclzCfzattDcmXQZXdMZWdsmPvgQTCm
	IN+NhfOo0JtIcbsJTSAZoRi0PMrSzrOpKloK8wQ=
X-Received: by 2002:a17:90a:d44b:b0:35d:a3b4:2f0d with SMTP id
 98e67ed59e1d1-369518b00d8mr10524376a91.6.1778997674804; Sat, 16 May 2026
 23:01:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515213747.1452692-1-torsteine+linux@gmail.com>
 <20260515213747.1452692-2-torsteine+linux@gmail.com> <DS1PR16MB6753D67AE4A413704D6E3264E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
In-Reply-To: <DS1PR16MB6753D67AE4A413704D6E3264E5022@DS1PR16MB6753.namprd16.prod.outlook.com>
From: Torstein Eide <torsteine@gmail.com>
Date: Sun, 17 May 2026 08:01:01 +0200
X-Gm-Features: AVHnY4L_sRI1Q9kgyDe6ljW8hQRtFu7WiUSL9ZYA0GUkOP69IoiJ2PoF2d2Eec4
Message-ID: <CAL5DHTHw2cOqsm=c2zKNAu7ejQ0w=wg1PtMsVQdeKQzWD6_7GA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] mmc-utils: lsmmc: Refactor CID parsing into shared structs
To: Avri Altman <Avri.Altman@sandisk.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Torstein Eide <torsteine+linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

s=C3=B8n. 17. mai 2026 kl. 07:19 skrev Avri Altman <Avri.Altman@sandisk.com=
>:
>
> > Add struct sd_cid and struct mmc_cid with parse_sd_cid() and
> > parse_mmc_cid() helpers. Use them in print_sd_cid(), print_mmc_cid() an=
d
> > print_list_entry() to eliminate duplicated parse_bin() format strings a=
nd local
> > variable lists.
> >
> > Also fix print_list_entry() using const char * for the strdup'd manufac=
turer string
> > without a matching free().
> >
> > Signed-off-by: Torstein Eide <torsteine+linux@gmail.com>
>
> Looks like you are missing:
> 8f41ccb (origin/master, origin/HEAD, master) mmc-utils: recognize ext_csd=
_rev 9
> 388e059 mmc-utils: lsmmc: cache ext_csd revision for MMC devices
> 2364dc6 mmc-utils: lsmmc: fix CID manufacturing date decoding
> 4dbd897 mmc-utils: lsmmc.c: print_{mmc,sd}_cid(): correct month names
> 6f6b6e1 mmc-utils: lsmmc.c: print_mmc_cid(): correct year/month parsing
>
> Please rebase.
>
> Thanks,
> Avri


I see why, i was cloning this mirror https://github.com/mhei/mmc-utils/

it is no longer update, it is 28 commits behind. my fault.

I will update to the https://git.kernel.org/pub/scm/utils/mmc/mmc-utils.git

Once you have review the last i do a V3.
