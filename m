Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com [209.85.222.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A93233033A
	for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770755884; cv=pass; b=nIsB9HAgbSbRGuNP5QtlYLuIAnnYAWKRJBG5nDi+F/yKqwRCUIKVDO9cdafom7qogStvCdRNYAwqaLl9Oi+LDuVXqh0u7Mm11rTv/hU1V38AnAI98UKlRityg+uMKPdIq7Tb14h9AOHH4etpVzkzgILgwAMsD6m4v/XSFvZpOhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770755884; c=relaxed/simple;
	bh=xLN3JWxfSlAZvPPPiU79sYkM6qrE3etMEqMO8i8DW7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DySaZPbEYJ1RpESIQ6eaPnzGldLeIc9LFJYxMUv/pOpcLcQjmYOYYdBrUoGRJvGEAAN4bN+l5rAzMBq3hbIQCkvdrGdeHmHV9POe7pCbQb/chQ5Kg6MJHL8NFrSVfgBo21BVjwgokUUjhlyFH+ueG8IvtUqUvfWpffn87cOHtnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hi52O/fM; arc=pass smtp.client-ip=209.85.222.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hi52O/fM"
Received: by mail-qk1-f193.google.com with SMTP id af79cd13be357-8c6f21c2d81so134570585a.2
        for <linux-mmc@vger.kernel.org>; Tue, 10 Feb 2026 12:38:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770755882; cv=none;
        d=google.com; s=arc-20240605;
        b=cTrQiwzusQwlJMltqCn3raDmwpWc7Md0lJbl5oeEUqpbVO1GCXQ3qPmW+2mFttIZCS
         1HwEkXJdxrEpJI6DFmBJxzPjKFAVmNb/qFwbVndAhBlhvJP8nS33/h1LA200m3J5yLCX
         LwP+0OikQrU23kDPPtr+LbgEsDfbSE9yUtvB6hfWH4xqOSPPrQ++k5XIswsOLZoPV34m
         gl8j56yMTOuliY8pE2ERpEFiwY7Lxwv16oye0psKg2DpryTjKuZreYWmhcb/uOiU/F4m
         C6KW8PHZ4KHv1XfEjQWYg5IY6nORlgulGiw0C2uP3yMGy8hCR8fTyNna+TqUWhaHGUa3
         Z4vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DH4l3p7UJmX5cZ890Lhq/4fNEtk8d2otB6w7im0OUlU=;
        fh=M7UOd/t5//Qe9QvEc+sgAdznt0bpWIM/Iw0CVNsYa9U=;
        b=JONciWwBcs0snGwVAXNY4UPezb91X6IlPLvGhXg/AZtDE5OagdhkIRn7ROwteMEuK/
         LmFhxnFW8Rg80iUACcJGEh5zkCfrr9KQ0lK49/bCZxJRLXGiU76afjGHZm00YyypLq2X
         O3/lBvRSs298+BOx//Vjq+CPU1FjKeP/a64WcFsyL28xczbPdsNrPNVlSP9MyahDBRrd
         VZu8CuY0mRz/V/Y+VzyHoDt5hiQrKVJItFxz+GEpe8kX5LtrBZ5EgF5f0GIWtllYdqch
         1J27vqXRozh94aq+x5jLVaKSo39y0jTovE8A+iBA8OtR1DVuvvZMcfq0vVwEgiPbGGsA
         OXoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770755882; x=1771360682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH4l3p7UJmX5cZ890Lhq/4fNEtk8d2otB6w7im0OUlU=;
        b=Hi52O/fMqE7vVRTg7dQ/7fTIMdCfVWOzRT9JOGRCOcyjLxXWb425VwiK6f7fu/UGUY
         +JmGHy4lzy8iRNoXjsJV0kDVA/yoLPCpfSjcrHrJ023mWEHa3S1rYDAyokt6pAdnTCZw
         1mGDh/vwEG3OjJGdRGteYxBlU+LC3FlImyuYkzUomWjJzI6IRHXtn1LjV3df8VvboUiU
         SyLhtDbF8W4SzjtE68gp50r44PAEP9M5Yanpwy0PClnt2nhQ7bG5+3VDLoDNK0so6o79
         GTxFCYpMOmJXT4v0AzoHYe5y94jSaXdBhiRFOQKt/+JOp6ydZyg0Yh+CyKq47LynH4Aa
         kvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770755882; x=1771360682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DH4l3p7UJmX5cZ890Lhq/4fNEtk8d2otB6w7im0OUlU=;
        b=ZQYR8txPbkEWLQYRj8bZWFHeL2WSUit9fjja8ws+sxHM1zY3M+jXzft3ABLlvba/Hz
         NYC3nZemfxl6SHuuLwmzRtiaALtrcK9XT+G9Qc/e6k4/0rmTm/TUjoSwkgleWz5FQY4w
         GritAQBNcEsag3HkIoxPxXDqh38mK3Fo+X/3hOs4uSNqKVD8zDDv/3O9zJ3Ky/YCFjFl
         P7DFVtktb1kbvAK59hfLLDHjgYgPAj6Z3Xg1yOPPKxkIIWYED3oZL8al6DeABj1yqfRv
         lVgyq6ny1IUTfcOVyvIMGnEH3g35RfqBG3PMFvwAlcahbS5hZLcNGhexoYMKiwyi5Pbx
         r8MQ==
X-Gm-Message-State: AOJu0Yyv1GDJwHaHl/eThsOj/lrcC6OUPU5VhrJ5JEONgrydqdETyeSW
	j9kdOrvPqQolgJ5qKbCFyX/BIVQWDQ3mRkhhxsDQRwK7YYDR/1EhrOQ4GH8pKA40IxGzpF7FX8y
	XjpnZSHgFSVWf+bAo0DApFUbvGlzjPcQ=
X-Gm-Gg: AZuq6aLWh/hSZX6kqDHyZppFIpjP254xTmOCPIdcipeb7I9Bj5BnHJubQz0ZWm1Oh3e
	swKz/DJp55jVqCLmiBMYYhg1D2kE1AZ6qTZP0gFStRR58Xx4iawJiAc3P/rf1t9NwW77OOZj78Q
	WGzzMvdrQNWVQSLQ1QgI02IL6QOq8l15e0Z2A17PTnS71eyaYSGm8sBrZoq8bx2qq3rbQsUZu0m
	KB1o0QpDZGv47OW2lrnI9TSqzLQpioX7Oiz8ZpTLDJBhbP8rPoFE3qfvtd7lBcnuWfyJok17Vpu
	yrEgdCE9WScFsz0r06cpi+DVL9D0aIo2IywopvCyR2O6GhsFc2r8upwzKa7jZCYwyJH3
X-Received: by 2002:a05:620a:460a:b0:8c7:1952:7894 with SMTP id
 af79cd13be357-8caf0581494mr2054015085a.23.1770755882348; Tue, 10 Feb 2026
 12:38:02 -0800 (PST)
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
 <CADkSEUj1TsZLXNO-GPU-5c19RPV-9d8os9HnxVOxrygvyTtqJg@mail.gmail.com> <CAPDyKFrxNM81N=_jvkLtkzjgnbWKJ9CE8a-3DUrRoZkJoNNQ8A@mail.gmail.com>
In-Reply-To: <CAPDyKFrxNM81N=_jvkLtkzjgnbWKJ9CE8a-3DUrRoZkJoNNQ8A@mail.gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 10 Feb 2026 12:37:51 -0800
X-Gm-Features: AZwV_QiEIr7WO1u-MJCQNgsiKc3refyeVqFuA5tKjR0EDCCTpw3T6Dynt-HGaRg
Message-ID: <CADkSEUiTTOKUp1AAxk9Y7cAwPA=7B5SkBCjS_Xrixd-dFax4Hw@mail.gmail.com>
Subject: Re: [PATCH] mmc: remove unnecessary module_init/exit functions
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Uffe,

On Tue, Feb 10, 2026 at 5:05=E2=80=AFAM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> If there is no exit function, the module will stick around in memory.

No, it won't:
=E2=9E=9C  ~ sudo grep mii /proc/modules
(nothing)
=E2=9E=9C  ~ sudo modprobe mii
=E2=9E=9C  ~ sudo grep mii /proc/modules
mii 20480 0 - Live 0xffffffffc2549000
=E2=9E=9C  ~ sudo rmmod mii
=E2=9E=9C  ~ sudo grep 0xffffffffc2549000 /proc/modules
(nothing)
=E2=9E=9C  ~

Ethan
