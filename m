Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D662FD682
	for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 08:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937381; cv=none; b=sUZgMkjPxn0rH6n2C97Ld6UY/aRb0BY270nEI+Xf8DHNehiqTFGj4+3SsRkNBye135N06en06MBtJoOM9/4BY3fJzlWl9AQwz015VkmLMGsMSgNavHLv00IqMop6pUlbUY6isaLpL+c0xHTYH6aDLzRcpbAJt71CegUwMpdc5BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937381; c=relaxed/simple;
	bh=Z99mIqeia+YwnxsvpuycDzk6TGzbqIDr6NWTdL8N780=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUNgu4GSYhu8+QN4p/yhzTW/TG2B0wICul7hd0x9f2vESvEpLV893yTHeNotwAwS/a34nYHMIjnP+0jmN12ftPU0ax9JM4i/f1jLiOqAGCAlpzTiF9GnGtsKBuYwiFr9lTA8zSg/p1lkYjJkG0xzDeJ0HBeDLcXB0rWaHxhsGUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z8e2/kwm; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z8e2/kwm"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-592ff1d80feso627143e87.2
        for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 00:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762937378; x=1763542178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z99mIqeia+YwnxsvpuycDzk6TGzbqIDr6NWTdL8N780=;
        b=Z8e2/kwmWfSp8Q3897seqT1L8mx1wB9X4L6CwASrrsN4A9b+q0mAuJxAlb6midu3MV
         gCVZ3lfOcDDG9rX8C17tFd02GAXW/7DolY8TotOg9y3LOAIY9/PxB61fmQZmPQIZcI4Z
         14ppuCQlAkX4WQ74eyoVHXGL7hzphywLZxdpUiy594mwUabfzuDIhDMrRyHL2XwbFMdn
         JquYBbfJuMRFCjTUQ/NL4sl1mjPowPQ9GPOj7QGJximm5HgmGlaZ4N/d+Mr7esYsKG9m
         kn9mD7UQ7BuI3RKbtNXhI/NN8sG9sEc8tPBbnEGrMJDC4tH6wLkGr5gngfIguiklBbPJ
         0R+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937378; x=1763542178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z99mIqeia+YwnxsvpuycDzk6TGzbqIDr6NWTdL8N780=;
        b=XSU0zSXPxXni3r6iwtmxUspAk8YqKpwCtuyzd/R/rU4twntgk6ZSXEUsTquCLVyhEn
         8XD0x1jcojSDyixz6XWlmDBSWjS8gd6wWPc7AoW/KRMr2mD8H7AraFCzGiTMVxcDzFGN
         /dIaBeS7LFHGIqJrhTxsGSvyHhIpyw84xbzmBkNdMwuoj/Gpwf+ZqS2GqYzgqGo6TXqC
         x4RJtOaFoDuKHRgI+ZWPsuEZZxNIIFY0TL+s3CXDVbgdlkrUKoZeXpx9rYdIPLu9aMH6
         A5g3P+/68TNuaDpDiaguiLPxEviMmiTS0D/j4OLcviYKG+pM8Mxtu59Z1mMF8wP+S5He
         w3TA==
X-Forwarded-Encrypted: i=1; AJvYcCUGIS0bVNGzMddrYxBxAheCaEL7zDndF8UOcwlQCwohvORoOdHgVnP/A/m8B8ie7SSFYgbymhJ66MM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrfViFytb/OUaQLWiF/pK51E98MSoD+PVdjD34iXA59XFpqqaI
	6NtEHDsLRfBf7XL3V+5eXPv/Q6/q+XtdlXjF8T+8CYkh69PHXC4MzCJfwVDvnOJt3BK00Th5kwX
	bPAYAFVtKo4ep6cUjSq5eFU2wb1FxJ+R/XwM/Kvd4Ag==
X-Gm-Gg: ASbGncsDnazU5u+KVNmHX+jFyT8x8A/PBIIyzk8LU4rqBi1HeHdVjBPD+23YQFCA6+Y
	a/tSWjiDhNRrUz+/SDef01QxatYwYpHBoulAsvfkmiy5BfUNiDH/M+iMXrJaHBbolx41LmVvVXz
	bbm9T3IuP6QJ0/KvFBEDLXo0gRkcM1+C4Qsd6Sf5R/xyu1hKTs3oZPLauCX75LthOTgSsMEpfNA
	1xkh5Hlh5pHw9s2PX7o++z5a/ljYv7wh6/0e2SRfVnpW9WN88BywOM1duUDSeFV9L1IE/1wQi+z
	SKNcRgY8Yq8Fy7W1lui/Ux/Jzy78
X-Google-Smtp-Source: AGHT+IHwkyX27togvHCQMW2BZonFzlk/AX1LRSnafb7ksgAGV7MSuE3/MUECC9rK4STtLAD8hduluRS8ToF2sYh+/Uk=
X-Received: by 2002:a05:6512:a92:b0:594:2b70:6d09 with SMTP id
 2adb3069b0e04-59576e3a932mr714105e87.44.1762937378011; Wed, 12 Nov 2025
 00:49:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105145824.239054-1-marco.crivellari@suse.com> <CAPDyKFpVS9Z86D_QLhjvOYFAbXaa4_Z=ZQnV+x1ZTuXG4x8oXw@mail.gmail.com>
In-Reply-To: <CAPDyKFpVS9Z86D_QLhjvOYFAbXaa4_Z=ZQnV+x1ZTuXG4x8oXw@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 12 Nov 2025 09:49:27 +0100
X-Gm-Features: AWmQ_bnT0AamP8qb05zC_dt0cIUnpnjMsIHeflBvyb85nhOL9I5Vg8kBfSa8zH8
Message-ID: <CAAofZF74Ojim5fJmeu2Y3OTqi1VTTTSqLiCf9VGd6XqbXJSq+w@mail.gmail.com>
Subject: Re: [PATCH] mmc: mtk-sd: replace use of system_wq with system_percpu_wq
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Chaotian Jing <chaotian.jing@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 6:37=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> [...]
> Applied for next, thanks!
>

Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product
