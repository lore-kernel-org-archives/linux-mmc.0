Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06862EC0A1
	for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770809089; cv=pass; b=OMmEI9BfTy+iCN3sLIvR3vuxyUeA9H96WZugVqpGNtPP4NaV4X/bWjdKwYqDnWbf/CsaBooQZmhwslXTiY624Xpya/3rOBYZ8uS9OWMWuJ73rd3vteTBt9vcN10fvLt7WBkB5xlqG2gXlsDKWKJPY7l4gMQKcfrV2D3auzLYTu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770809089; c=relaxed/simple;
	bh=3qOOB1W1sEpKjR5p0weK1j/zb67lo3H+2YiIp5SW5Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8E692lwL05gYYBqTOa6Wuu1Uvh7I4pEaBrQsFZYVC7VJ32I2/vCrLgQCHzyoWZx6NnV0XbXmqLQ149/RnECfXBsHZaZbS2LHWxyaWPqA5RvFPwkO+OTsUkbg8CbVDQh9ZcNvjrFkJdWz5eVqwRIrkhinIb51z9pHVBz9F5bdJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TML8kUnE; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TML8kUnE"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59e57973dbfso670718e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 11 Feb 2026 03:24:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770809086; cv=none;
        d=google.com; s=arc-20240605;
        b=INR0QG7potPPscuvAvHZ/bSvRjD2TP0g6NYE8atUM3ptMiZo3+aBjhScBugaLE9ttV
         B1cYARohMZ1PDHEOhSo2eOph7zb1JefPYk7VgSNkc7C/Neq6soi00UAqLDnYZk693o4M
         TbHCw/5aQrxn+6I6CsXfNoFO7XpYcuaJ+oUhQ1IDkvhONQWqm+JAzP/bmJ4uPoDXAWdD
         Hut+z9VgXX4P26BciOViUnPsmD2OeLNisSs/tzUBgAuetHWSsOIkFgKfomL88uOvwdz0
         MdOUUHzZotA2+9MVudC8C99vIqmzuBihi85aYjWjD2ZCzM+8/DaYD4CkATqjksVbCrDw
         R0Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GOxBNof9HuL1UcSa7VfWUSTZ4ubIgjq23oyYfzzR8QA=;
        fh=2iKz3AqYxwGck4acAtQJ6/208mwqzO+86tu6uoAL4Eg=;
        b=QHRYd2MFBq2fjoedAWd4rS+hHQ7MJwEml6NPvCbNfb0JfidkZjSE6c9KEVEO8Jkkzu
         Epy5ZOXNiT6LKBbabyXInSGCZp+ClOY5VPjPgzPh4WepnVcmNrqdC5zSrRrgTWdH6kVK
         VdUy3nV5498lrWhf1ifB1gE1UIAkeR5E5t5EVrzRf2Zp0cQeRUwhcucp+X6QD1E2B6Sn
         1wpYTxQtrvBsa6nZiHUNABp7pBAMhi1Js3t4BYlgz2ei+jyvM5Q3LukeZZ3RYP/4vFJ7
         n8JBO62EJ/6HKisB7PuctDOz+k4f8gT577Ek3mXzHBArSK72RFF2Lgnt0nFFOVMCNPR3
         rJVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770809086; x=1771413886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOxBNof9HuL1UcSa7VfWUSTZ4ubIgjq23oyYfzzR8QA=;
        b=TML8kUnEegXCk1dinjhYZY+ZK9/78tAIfKCeXaau8Vb3fbSR+hhebvtgyVkUyhkyPJ
         T/fwUwyc31y12W43OvjeR113SwFG5qnlE2k/rTAZ4tBqjL8km2ksQCEzop37MUxSgtrL
         dgNr1MsHZK/V5kyix/EhR+opjY7pwpirSokHSw/Dfo38nmSZyfDcm5URyf8QUifsz3Xu
         ZBV+RdIGjUJvkGhCJPXYpHdh+BugMLgVk7l94IDSXiyTIZ8TK+3efi0oaqxy/DaQzUWy
         T+sWQx9Vyqg2unKNbm/kk6brtLXL+oyt1tLF8/v0zUzEAKliN9BVfUn6tjwQ7ExedNwd
         WUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770809086; x=1771413886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GOxBNof9HuL1UcSa7VfWUSTZ4ubIgjq23oyYfzzR8QA=;
        b=Bw73ragNiwrnLB2hDMiseOdcLlhS0xrZP4FfkU4R2oNL8fK+T/t52jAcnb3Wpujjj7
         E5FBG6RwVxQ4BYLuKZMDyB9zi7ghAHiJLbe5i6pAwbqy9g0yKrR8vUqwcrONj5pOWiyq
         1lmCSfuvt51qbuis7frx2c5+C5ZG7CjPJft+RVt9L9LDSPDv0wHFUHcdNdB7FdcY+SMJ
         ID78gfNd9Iyhx70GPq60eR8AoMm1X+Nb66WETA9Hqey36I5tDeKJaDLDFOSBSJ/CFkCI
         2nSc2M7MG6gH/Bog1veaO5ncNrGu5vdtG+9yN80NQK4fY+EF4ut0Ikjqg4v1m75CpqbX
         /LBQ==
X-Gm-Message-State: AOJu0YwQpPb7yuSoqylKaAXojRSghAZ9gx+4Dzj3dRJNVLXdbTld/600
	XyXyqYivMcjNOx1m2S2rKx8k5xgoxk2m5rmOqqk4gXKIdEfEl/UQV6i04kvtBRAS4B0i9qifhiz
	WRHe8TdLvkoQGW14hSZvEm8+lbFfPWYliNkDafrjMWw==
X-Gm-Gg: AZuq6aIw8XZe4LeXrMJquEP+ZHvoR7aTUSNki1OhqbAqpCbVXN+3NUy5qIQA8KbdaIL
	KRcgq3iKUSSwUIm7VTIhRlIl3B5GOoTt4to3uTEVTSuHMwzFq++NaQQPUsli8cudCmANgdeNhFr
	yToWRxqc3+67dhxzDClKxZE8ISrT7yL6k0ILd3IYSJrfDNuoxEcQNPylRRXfFHSjMc5Kc+fAeCc
	2pp4NErdJhK3b1IFrOUxzTSytfDYvMfu/ZFiXWUvI6e0f48c9DB1PHaGwM4PEvAw+OVafJU8XBa
	J9WQkVS45KbDQ63dgLM=
X-Received: by 2002:a05:6512:39cb:b0:59e:44cd:9674 with SMTP id
 2adb3069b0e04-59e556c1e98mr2373898e87.4.1770809086012; Wed, 11 Feb 2026
 03:24:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131020039.45966-1-enelsonmoore@gmail.com>
 <CAPDyKFps1oX=aKuUYFbXNQXM3rGtZOwTfgCaiHgDvGOb3qGc5w@mail.gmail.com>
 <CADkSEUhk1TfJXvLYOrx0OvVCgCA=L+CEZXGzQAhdTgkKz3a=bw@mail.gmail.com>
 <CAPDyKFrfXgCZJtFHttA1E0Tn1tSugHWsSfZvP1RAOOx5=ViWQw@mail.gmail.com>
 <CADkSEUj1TsZLXNO-GPU-5c19RPV-9d8os9HnxVOxrygvyTtqJg@mail.gmail.com>
 <CAPDyKFrxNM81N=_jvkLtkzjgnbWKJ9CE8a-3DUrRoZkJoNNQ8A@mail.gmail.com> <CADkSEUiTTOKUp1AAxk9Y7cAwPA=7B5SkBCjS_Xrixd-dFax4Hw@mail.gmail.com>
In-Reply-To: <CADkSEUiTTOKUp1AAxk9Y7cAwPA=7B5SkBCjS_Xrixd-dFax4Hw@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 11 Feb 2026 12:24:10 +0100
X-Gm-Features: AZwV_Qg1HQkoDrPNrAOKw3aUQde8ShMBgVlrqEbr5wipwefIWpaUkmn24B_oXwc
Message-ID: <CAPDyKFp1_wWRAtHKij=rr36gXdd2tQiuneKdcKDjXrOb=EV6kQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: remove unnecessary module_init/exit functions
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Feb 2026 at 21:38, Ethan Nelson-Moore <enelsonmoore@gmail.com> w=
rote:
>
> Hi, Uffe,
>
> On Tue, Feb 10, 2026 at 5:05=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.o=
rg> wrote:
> > If there is no exit function, the module will stick around in memory.
>
> No, it won't:
> =E2=9E=9C  ~ sudo grep mii /proc/modules
> (nothing)
> =E2=9E=9C  ~ sudo modprobe mii
> =E2=9E=9C  ~ sudo grep mii /proc/modules
> mii 20480 0 - Live 0xffffffffc2549000
> =E2=9E=9C  ~ sudo rmmod mii
> =E2=9E=9C  ~ sudo grep 0xffffffffc2549000 /proc/modules
> (nothing)
> =E2=9E=9C  ~
>
> Ethan

Thanks for re-confirming! Yes, it seems like I was wrong, sorry for
all the noise!

I had a look at the code for the delete_module sycall in
kernel/module/main.c states, which confirms this too! If there is no
init function, we don't need an exit function to allow a module to be
unloaded.

That said, I will apply your patch as is, as soon as we have v7.0-rc1.

Kind regards
Uffe
