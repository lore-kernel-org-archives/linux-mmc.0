Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517F327703E
	for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767002163; cv=none; b=CO16dXlWUFdboj1CwEVeNzobrHn74KDwIkRGcrfZ3F9cogfZDCNR5iAOPr+h5MrMNdUwsLIumI5iyoEVrEM14ML1oOG5Clp3PjUaJvVV94u3S9gHLZ/qbQqrTfrtDr4KMX0YwxzgMPoU6Imp0zcQj5jwtjppVfpvn2qrX5opXPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767002163; c=relaxed/simple;
	bh=z0YEap3u/EBh2b6OmtcTMDQvHPeE+nUA6zhZ4RivPS8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q9aT5IBduDR9IFm100Cf6TMDZ+Qacuyn8ORyvrGGnwXaEgOt/TjZgXNaGn9kYpLfjPF4kQ29JO6WiA2syqatYtm48XHYGAscQPPGJF/q7WBFAiic9VyLU5q70+UxVphpwrWDmthA82FU9XITOqV5+qRrmJskuci6ycXfy7p/Zs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFDhKK12; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UlnYydPO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFDhKK12";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UlnYydPO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767002160;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obH9iYXUH7PcM8LuIvRWvOaIIfnfBietKIkzq92XPAw=;
	b=CFDhKK12FnXzdrkGiJykuUe9iFxlzEoEUbC66IBNgNhHnDmTod/lbVxQdiW8npJmZ4UJf/
	0flouEy1TNnbBdb3XDx9HH9zbt0pv2OcDo/62Du13Y6QzkJsgy3eKJi5CCArGJq/jcpTmS
	c08sNLyRV7YLULYeYZJnYSsM9bgFoek=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-unKHasJ9MBO4PCN0R3_1Tw-1; Mon, 29 Dec 2025 04:55:58 -0500
X-MC-Unique: unKHasJ9MBO4PCN0R3_1Tw-1
X-Mimecast-MFC-AGG-ID: unKHasJ9MBO4PCN0R3_1Tw_1767002157
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477771366cbso66305695e9.0
        for <linux-mmc@vger.kernel.org>; Mon, 29 Dec 2025 01:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767002157; x=1767606957; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=obH9iYXUH7PcM8LuIvRWvOaIIfnfBietKIkzq92XPAw=;
        b=UlnYydPOxm1O+0R1LQ1jOAWV9Q97E4P8boxHvem7yA1WD/lkx+OPJRfH4SllEOD4OS
         LDF4mJK4pHwYh8z6n5BsXX3BzlK+4wUswWMiLD46kog1R4EctbRNDGN92rK6RI7bRftd
         hydSdLuON+Z+gijid9HLwF8B9mIxJxrRvx/heerSGqNj6H16/Oq5TPIJx/un0Ot3pIQq
         +Vriih03SVu7uPSVJ/KwrVEd3L+1pj1Sm25EYd+XE1uFAa/paj4EZlbagJRReysxjijg
         4TyNpzMYbxdspw5dV5Eiimlrj1eww6wrJZOfvU7+mNK6jACOXTAYpBbUcymCx5eK7+S6
         EKkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767002157; x=1767606957;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=obH9iYXUH7PcM8LuIvRWvOaIIfnfBietKIkzq92XPAw=;
        b=em5z0hLJjr6tf6qSB6iMW0/dlEyQwp6NN2BHHxrn8bPPUL4woE0FHEZEhCk4/PG1++
         54uH5qgGTpuWAcniqfLEox55FZA11LsF9EKHINCMvWeKdoAvYpN9oaeaAIJUWkHA6EWs
         ++4N4+lSSZ4NjNkllTzBWfaMZWPkP/BRID83CgAKWyajCCSy/eVOzJaWaTrFQSW86Hu3
         KnDuYgOeVud5a8KQuIX8RqhmtBsJbYa/Ach9Nro37541ouCSWOi1rN6VH6M3IKPOvKtG
         qCfYfXCzL1m+EHQfyEvpZRFTs/yPe7woTrcr8XNEDT3tBU2q9SpnUVUgq08gsJZm252u
         cSLA==
X-Forwarded-Encrypted: i=1; AJvYcCUzqirxSw1U8lq4E+N3SxSXPfbEtNL/2GWtp4OfJ1AX8s3ow7ALalAjnbjepvoOzZBsEu/HAkQnGCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQ6jorD5oAp5B09QF02DkEF45V5Q44Yia92PSnqWoqyG23X8a
	B21HVkvf+LheOIi32BLdjtTFc5Vz+AYaYWqYiHNApLyEXRpC1fBfgM+0oDwWwQahbetXBL8/Etv
	zJmN+TzS+upW4a6yyYTQgLqz6d75n7S0sInXY49TcbYB7NbPvDA4nr/4lNMU9yQ==
X-Gm-Gg: AY/fxX7VPDtO/dq0UVun/Z1MJA+SUNS38w2k7QE8aRMRjWOWSexNeIQCIuXQLJqey6Q
	wckfQ5BLc1UgQpRtTuk3A7SY1/3xm9cFpUfh5O+A5/cONHnuaOXf1wOyPcSZF+XpXIo1h0JQk/6
	TXYdZRfBuUW3sS777GFWQhch27iniw5Kg/w97B9G3AEA3psZKHiaZtz5lla7iQw4IaRT/tw/9jX
	FPHZYaX8WMl6I6TeVHPw8XxRl6uyuVFw2l4D3YoRvtVZvb5sX5Hk5HP8zFROWr9bHqhmS4oyeDt
	jPbG1dhM9H8Wbr+AHZxevo4r+KQVHz1wDvfKRybTyIv430mdpjazzM0x1sHkTqHtMvox6vDnzhA
	pPc/VIcFpdLMxN9JF4FhIvIhgb3ACvI066AcPf70/2flhc5xcZ023GSn8K4tRukXnovCA
X-Received: by 2002:a05:600c:1c21:b0:47b:e2a9:2bd9 with SMTP id 5b1f17b1804b1-47d19583142mr410001445e9.31.1767002157341;
        Mon, 29 Dec 2025 01:55:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvt0pHSYFpii6xSHzwFuul+6dVBdHfQqlf/eiF9MlDFn+5XDqtCOM3lJyrho9dCfbqBslcow==
X-Received: by 2002:a05:600c:1c21:b0:47b:e2a9:2bd9 with SMTP id 5b1f17b1804b1-47d19583142mr410001085e9.31.1767002156889;
        Mon, 29 Dec 2025 01:55:56 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be3a33c1csm252799015e9.1.2025.12.29.01.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 01:55:55 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Yixun Lan <dlan@gentoo.org>, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Iker Pedrosa <ikerpedrosam@gmail.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, Yixun Lan
 <dlan@gentoo.org>
Subject: Re: [PATCH v2 3/3] riscv: dts: spacemit: sdhci: add reset support
In-Reply-To: <20251223-07-k1-sdhci-reset-v2-3-5b8248cfc522@gentoo.org>
References: <20251223-07-k1-sdhci-reset-v2-0-5b8248cfc522@gentoo.org>
 <20251223-07-k1-sdhci-reset-v2-3-5b8248cfc522@gentoo.org>
Date: Mon, 29 Dec 2025 10:55:54 +0100
Message-ID: <87344thas5.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yixun Lan <dlan@gentoo.org> writes:

> Request two reset line explicitly for SDHCI controller.
>
> Signed-off-by: Yixun Lan <dlan@gentoo.org>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

