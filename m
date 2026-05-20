Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBD8376483
	for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263820; cv=none; b=WyEq4TT0BDbMOOX+u0EiktbhPoUZJ2j4jipY2f80CXmdmfLEqn9bJLKp4hMjJY0bt80jhX7HxKaUZKhygZb3C9LpXiPKAoSbQOAAy31ENq5oOCC+XNoa8oWFBA84DbI4umSNLGuYUClzqu2jgHHgr7649V5F018bkyV5s6APS7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263820; c=relaxed/simple;
	bh=jyR6CItUiBYwh36JUt384ZPKK5Q8HWzq/VYAHdg6RMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E57Di+IdrCaq3gw6/H6I/sXlyi9ZFpCypU9KWyRFI2YndIMlgdwOBL00kEyWi1OFdbfDkTHqheA048UoxixuX4mpCv0MG9WisxwlM9IrVwpXCC4mxEv/56232tPOuHuXjyHuRXuHC45sZZSsQsEDA741cuA6cxJXfLjR2/dOqa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-95699e8e26aso1328516241.0
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 00:56:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263815; x=1779868615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lx7PXaJ7S8HoogAUAhRbNuNVf+vLw1gLYatnc2YBrZ4=;
        b=qVsyGMkBaaKdEoz9gHaLNjADzRZRCYF5Z0tQoQKe4U/76o73CDIRFHnsMU8u9q5OmV
         w7InHj1/YgQDZGY2AkWeQjs5QznG7aIDoj0dgq2ScQ0915B9RFKocD7ZXFB+aQTDgJVC
         119Jfa0cwH+QLnnm+022fiNo+SVL/66uWaZcA717etBltLUvGvbHiSOwknof9LPnB0nv
         IILZbMzZWFUw925i6pxirwrEFyVPu0iZ47EH1llDzEhLZBaUd4PIDkTu4WuX2vijTbtm
         RP8uOwKsQBnD+YzUNQoSolUGSRs6108XJznRX3rusIYKGNiL86nkhGTHfW7xYUJ7JEEw
         SU2w==
X-Forwarded-Encrypted: i=1; AFNElJ9S4Su7ApGjZa499ti1OmZJf6ktBuGNlfhWMttBXMP3Y3HQ4FAAixIEuCFmoPPM61GAAEYx8jA5kxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvSrYorCPtMHdo38Y3wqBPmCYtKY2P1NbDdJQSEt8ubTYDQAzt
	zc81qkm0Muc5WQMSBx51zxAdbE8IO4SHkzJVZgLDIpuSxIug1k9dT7+n9XzoDTyezSc=
X-Gm-Gg: Acq92OFgfJtGZfcNDgG9aucBddjEvJMB67JTrBvYKtLHB/1ghX27JKq178O+N2KFlUw
	M8w/zxxZBOGEgv3Wof22C3m9oBCaQg8lW2l8vpTDaY48hXcoWN0oV+tXLoV6ov1YwjXY/qy5FA7
	nzb8KR/vmEojjEh9QlQyM/lo2S59IawdOBiJN4aC7CmWWuTe6id5XMePVZNU4XozzW8pRAKm6ZV
	NxzL72K/ppMBCAeGFU/pNhVBNhaHy1gMNGmURXOG9M5DKRlAKDZpPtvRuRRlK0ElCYczq3EqVC6
	w4Vdhx8ZE1QfQWaAxOZs7yEzRHHG4SomTR95QcSV2mIh4SPwCfuvKNUw2eYWTnP+NPVxrTOe+dp
	mZVZv5As3V500DhfDUqFZ0uitPgQHz+3f74mrHwtBb9G/cp6wSlbAXhVoPLj1y2IvqSdtyNLCfV
	b/v87V7A3PF2ru7r21YFW2ya7x1S7Of1bLL7gY2tGvGkARBqgwShW0oFhV3GnB
X-Received: by 2002:a05:6102:598d:b0:5ff:cee8:660c with SMTP id ada2fe7eead31-63a3fc94452mr11706700137.31.1779263815086;
        Wed, 20 May 2026 00:56:55 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com. [209.85.217.42])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-63cd19e0bf4sm7808458137.6.2026.05.20.00.56.53
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 00:56:54 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-63124ac76f5so1258087137.1
        for <linux-mmc@vger.kernel.org>; Wed, 20 May 2026 00:56:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9o9GdGK1Znhm87HnOrH8IzuVZarP/+lXuv5IxIT87OtrBxAjfnCy/QaSTTUif3k2wOrtP/YtXSb2I=@vger.kernel.org
X-Received: by 2002:a05:6102:6051:b0:611:17bb:934a with SMTP id
 ada2fe7eead31-63a3f98ec5fmr10259611137.28.1779263813547; Wed, 20 May 2026
 00:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519135342.623943-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260519135342.623943-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260519135342.623943-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 May 2026 09:56:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVQp8BAyKdeEaLrtmCQpa_4Pqq4nbhyt-n8ef7duifTcg@mail.gmail.com>
X-Gm-Features: AVHnY4IbP8AIZJYKzVxOParrOshLbOYMr3ry1CVDytm7aZOPAeFN8Az-3bq0N1E
Message-ID: <CAMuHMdVQp8BAyKdeEaLrtmCQpa_4Pqq4nbhyt-n8ef7duifTcg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mmc: renesas_sdhi: Add OF entry for RZ/G2N SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 19 May 2026 at 15:53, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/G2N (R8A774B1) SoC was previously handled via the generic
> "renesas,rcar-gen3-sdhi" fallback compatible string. However, because
> the SDHI IP on RZ/G2N is identical with the R-Car M3-N (R8A77965), it
> requires the specific quirks and configuration defined in
> `of_r8a77965_compatible` rather than the generic Gen3 data.
>
> Add the explicit "renesas,sdhi-r8a774b1" match entry to map it correctly.
> Note that the DT binding file renesas,sdhi.yaml does not need an update
> as the entry for this SoC is already present.
>
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
