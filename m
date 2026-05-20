Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E902375F63
	for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263794; cv=none; b=CXf+6EC19C8vK5gmCWSTUCvdHGmfkSGn+hLtzZqtJqP8v+Xn3queEBpujirONKigPBQMs6d9Zk78rZeCZ6BSlTXoDLKLv+iAjgff/uAwCkiJuz1SN/N2N0kFNToFxePoorcKvm9f/d72MlV6/saJkoLo7eKd8M/MByNbVDfahtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263794; c=relaxed/simple;
	bh=QqPxeM13+Xx0aqfPwJhCfwrd69Mly4RhTLXMjEcRwuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/ujwZi35X5gJC+jJcXZSII3dTOR3H5gr2TW7j1EomuqaMLeDJ3HW3QbAlhwcLUstoj0wIPFJop3/9Zm9aRmVKXcIz0SKm0Txl2ItCJmr8wkv5T9q5dJhRLzMlTU9Td8s07PAMKcromHZzbzmMsgyD4sxO+mMy2ft93OvX9wuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-575212eb419so3201316e0c.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 00:56:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263792; x=1779868592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7bxrGxQ1iTs6SaX4Z9onRYwjShKtP0zGwIDYAHZcO8=;
        b=p6DWfU/H0PqavH6H151exsqhYVx9qKAEq/MBS6PnDAyBk1ldg6D0Mu44F7jM9aacMR
         TdHSCtaVimhheA+rPgi5AqgbhIK+HbTsy/de1eWOFyUChFnhOzHnZmk8KRaS8w9p6VLx
         rPJXrclRz+ozN61FCH4F6e2T33c/V+og8o2a0EpNwDRqQ0uZaszgZUo35Gx36onNWpz3
         L98h+wqh/K7yzKT6bM/hKrXPNkgZ9fUuBOwHW2n1QxK9pFKfBENWL2gCM0rAoJMhzKuV
         GhATnzCukbw/t0cZB+37IqXX7CUNMjDzJP58hVqAQ6CqRiFCjfOIy75EngPA6egCcILr
         DzKw==
X-Forwarded-Encrypted: i=1; AFNElJ9vl/LeW8WEYxTm4ecunheWbCovMJjc/kVW/grCfeJViPf/XKflP0/g3brEczEt+LLVeFuImDJJPXM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6lnAJ+zTmNN7uI2PvD8z7ItkRVq7y2AY7rggPnAfuT0F6RGe3
	kTcG5qo+8+Ks+NRHzZvM5KHQrp2A2j/PL+8oJVjVNmHRLypubw2opxlS2CEKyU8rEMQ=
X-Gm-Gg: Acq92OFaP7qO/6Jmgy2LNUvN8JFCLb7A7/qOepnL3M1/nAakCKzb2pjekEJijXjGVEO
	795ZujCs5KGW+A1K93ZBzQGgbshYXFaAeeY7l25cAoIrMlJeZ6S5c8jbvchNgpdJkakpzDXxCj9
	p6+DVL8P7XG/lgtvExpa/198OhzmWUgKxHrTB8NBTH9ehhzFdzG4jNPbpytQBhm4NCDVkPDZ7cB
	BHfrruexLPlGojcHCFvrSXv7+HE384rtqKvZono6P4MSYvnf3w9Tr+NbLbaKn3DmhAYmHoqsNW7
	SREBOurd5QWDIf5FXvPQTMxMWLEPCUDtevhP7GAMb2ap3AIfwc4QIo7FXDp1YWPZlB897ON9tUL
	6M6aYB4g9CWP8NdFqa9I0tfEpKuwZsZHKiYKdiWi0rv1GDsZeGqeZ2WA+NA/s9uad8Tsbnr8/+1
	701WQSER9a3dsgRc7XeG2gJr7g7EMHV2aRky4bdmVlqYgcFlXAy5zkFsWP7fI6raTv
X-Received: by 2002:a05:6122:f8b:b0:56f:7e8a:a395 with SMTP id 71dfb90a1353d-5760b71060dmr9560186e0c.1.1779263792245;
        Wed, 20 May 2026 00:56:32 -0700 (PDT)
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com. [209.85.221.174])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760f58feacsm10584611e0c.1.2026.05.20.00.56.30
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 00:56:30 -0700 (PDT)
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5751136c561so4269541e0c.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 00:56:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ovERWB62IPTkXFPbgsWGjutDFjeKgi2gSRtSfKf70B08u5TVhO8W/R1N23dFkXrS5J2p5uLBpVe4=@vger.kernel.org
X-Received: by 2002:a05:6102:c4b:b0:634:10bd:95c6 with SMTP id
 ada2fe7eead31-638b8411d03mr10827623137.22.1779263790023; Wed, 20 May 2026
 00:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519135342.623943-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260519135342.623943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260519135342.623943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 May 2026 09:56:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVsSdar1OdGtU4wK+d0+UDxGJwtXBRa+LgRVwK5BE425g@mail.gmail.com>
X-Gm-Features: AVHnY4KNCbwcbPYoOaAbA20ajOpz0ciN8hyEvIG4fBBRoaXuGIeSrdlARt57b4Y
Message-ID: <CAMuHMdVsSdar1OdGtU4wK+d0+UDxGJwtXBRa+LgRVwK5BE425g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 at 15:53, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/G2H (R8A774E1) SoC was previously handled via the generic
> "renesas,rcar-gen3-sdhi" fallback compatible string. However, because
> the SDHI IP on RZ/G2H is identical with the R-Car H3-N (R8A77951), it
> requires the specific quirks and configuration defined in
> `of_r8a7795_compatible` rather than the generic Gen3 data.
>
> Add the explicit "renesas,sdhi-r8a774e1" match entry to map it correctly.
> Note that the DT binding file renesas,sdhi.yaml does not need an update
> as the entry for this SoC is already present.
>
> Fixes: 31941342888d ("arm64: dts: renesas: r8a774e1: Add SDHI nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Dropped adding entry in the quirk list instead added entry
>   in the OF match table to map the SoCs to the existing quirks.
> - Updated commit messages to reflect the above change.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
