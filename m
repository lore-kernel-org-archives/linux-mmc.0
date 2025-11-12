Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D87F2FD661
	for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762937423; cv=none; b=NL0bFkkrKfz+0T8/cOK1hRK2BPuP+BS/qC6fALkQgqN21t28+7Dpe+AP9at6WC8QWB4J6qs3enTjlibhHrvHRL8VJaF1qNrG2UE6kpIhfmE0/YZsE40qpW1eft7jkk1ZR4VcoxVWccoj/zLrcOYUYlXC91KkGLKbwTK0PjF1L7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762937423; c=relaxed/simple;
	bh=cv14ieFpUbwndSxAy7avkwQ2XyYjwC36K/PyUY+um5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwkx1oosu2tKAEsVuA9buxB4EQzpvW0ADRqr+HWxM7lgFwlmn0WpYlBHCdz0JsRk3z7la+IVacj+oBNcic1Prj7BsNzKFyj1Phm/eOm0uGf0BvyjwES03vYKDlv4g7tuksWQbgUc3SSmiyp+G2D5JAPFZL1AJjh8KJd7e6i7mYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AYISAMQH; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AYISAMQH"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5957753e0efso555765e87.1
        for <linux-mmc@vger.kernel.org>; Wed, 12 Nov 2025 00:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762937419; x=1763542219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cv14ieFpUbwndSxAy7avkwQ2XyYjwC36K/PyUY+um5w=;
        b=AYISAMQHJptwYpNDmLTvQ0d12KHT9puLlFVUSD27jqSrfbp9Jk18LZCnIlbC5y2iID
         u1fq2X7O3iIp+xkexEvNAsJrfnW0RI59PnJHiLbvbvgdaEClUTkbL7dgWCMJtJDlJeta
         1JR12Ff5eBMHpStf2uoO068j8EorFjm8uMIVeTbrx/FiAl1m3KJ5HykO/UrmS3y4wsmv
         vAftNW19IfLeURBrs+4SkNEVfIUPR1JdDRNYWmrBvyGK/zK10ySdybz34CxRGNaZsD3k
         2JTHkjDiuWW6n3uoYK5sZLNFfRyxeUa1tVCfHVmnc52FdaMt1TL3nE7PEUN80+UrBLs4
         xuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762937419; x=1763542219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cv14ieFpUbwndSxAy7avkwQ2XyYjwC36K/PyUY+um5w=;
        b=CTtBj3IbAkPQK9RPm9U4jnVUF+zSbCesYW2RnL8HrT+5vQP8mJQoHtzbXG+FV+nS5x
         lEglnKeG8l9TfDIzynQvNnjMTZOxtLVLPf326d7kd1EAa8mR7U05cu0BnYVmiETCBCLB
         MRcqu10GBDcttoowv+av8bWdFKrvqiUyWqxdvhGssUTuSw3STBY7W0U4ScsE8KaaFLsS
         f2wcY5+yd2kL9Bz0dACK72ucYtdqlELiNQ1ZwAvaRmxdWM3DVtR2kaLsshdnN6LROYQ+
         zZTKnFDXcGvwAZbMKAHZJEDxxoYgHAi3gtE+oo58jozcC1n45Rr6L/dW36DsK1PZxYBA
         0O9A==
X-Forwarded-Encrypted: i=1; AJvYcCXrtofUfCeiy+oyjkdSURlONiop9mAcJBWjHzBfM28K8I3YYHdhQ8asCg7uO3ZwbLfJaXVdnAObIo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkheCio6wMDiqUCOh281kA3MK6Gc40xCmMBmFMIXTIT6SlY8oZ
	cR3dZloogf9SFMi3evbEjshdUuHo1kvoNY8kgNcugLnrLVURMTXho7n9dyPE0DOu/e1+opAZ2NC
	buyQy/5o5VXXg9JFLMLZgPhxx7Rwm0l6YBI1o36TeMA==
X-Gm-Gg: ASbGnct/puoCFS3NprZTLPXvZ30SBYdkDj76TxqMrOI39EsKnrDKzlXJEB6+sO8UOoR
	QtFye1s5483JnxhacuLdFH2T7WIlJqqrI8EhJjjkV0T6/QRDJ0elzOPmxy3HOpLJ0lFKKjdwIve
	DqHcQMOKZkBUKzrBnEHStyQiV8hGxfX20+EhgMBMtWOM1J+9UcJmZmnkciAK1wFRuEh2eIBrpVy
	u+KlpKwOIyMjgnQg9fo3M9UcP6rLKmlIw0G7SKeVwOY9tHr66bwONLGLm6W7kkSFIxFgMOypbC5
	cWC+qYmMbXDgS1lAUA==
X-Google-Smtp-Source: AGHT+IEHNK5povoEOlSKstlSmdaONyaokIQjzvKfkQZcWTAT6dqm/dGcMdLDdwfQXgcunxTTDe/Pm+/naHGGXjffp3E=
X-Received: by 2002:a05:6512:10c2:b0:594:35d5:f837 with SMTP id
 2adb3069b0e04-59576df6c92mr609466e87.19.1762937419287; Wed, 12 Nov 2025
 00:50:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251107141907.229119-1-marco.crivellari@suse.com> <CAPDyKFqpiWuJs3fZkATnfPejmqL=Ei4x1U9QbuaykuZxca9f4Q@mail.gmail.com>
In-Reply-To: <CAPDyKFqpiWuJs3fZkATnfPejmqL=Ei4x1U9QbuaykuZxca9f4Q@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Wed, 12 Nov 2025 09:50:08 +0100
X-Gm-Features: AWmQ_bnLU4W1RGKwfC6lAOJz6bOKPsLL4ZN-hxDK-KkR_0_v7NSwMnNMX7Q48II
Message-ID: <CAAofZF5WTAZJw5FmtTkB_FGNfee8myVksZGhcMQHj906RGOzYw@mail.gmail.com>
Subject: Re: [PATCH] mmc: omap: add WQ_PERCPU to alloc_workqueue users
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-omap@vger.kernel.org, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 6:37=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
> [...]
> Applied for next, thanks!

Many thanks!


--=20

Marco Crivellari

L3 Support Engineer, Technology & Product
