Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560BEEAB
	for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 11:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770894522; cv=none; b=VQM87lexXM+YiSTh/arsMZWO7RKqQpTgoLt5s9cSSZZhzWBq0vZGJJkRGn3BbIDAeIn0SGyztiOEn5HQYYLpRMkelFWNwq9HfWzU6v/NNalXjw3RMWhLWQbIZLNy2xrO+P5hDPMm/ZUKxAjY5A1R3ui96mdSXfEKi1wnyqE56mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770894522; c=relaxed/simple;
	bh=ELesR79nEgzbYvbVtbkai+gF5L9OXkkQBqsB+SAv8Ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ood0RIuCJyqFy5S0laasNc+ym4gB9+QU9TWsBQbhQxOxDY++PiKOjficmTChRESpE+w5QRRlGwo1rwOSPG4eFa5Eyfnyr8wYLJm9IkBYno+UWbShq2FwxvWvPHhtkog38RqXROGkgfbkGQ5ZmsyYiOpOYRnV/JOPRuR9ptaLGek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDy6DNJh; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDy6DNJh"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59dd784efddso870142e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 12 Feb 2026 03:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770894520; x=1771499320; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Te28COGsJvbZjhoIswrSDU/sOtkJ6DypnGTOIiAuYoo=;
        b=QDy6DNJhzkVfmTpwHIsWj/4KJ5S65DCJPk0nh9d5V5ljKXOuWLFU075lwXPJBiR3CW
         V2+iQQqaBby7OYy+aJo2NWiaGnf9aQAyfaFpbeuCIjN8XT42LDMzawZd02DLV6oxtZrz
         /bZnYWlkDbOZy9S+Px+fvg41Rz8gSvFSG0OEeI/SBPtPrgHOJE3pDJqva1JQg2HR0h3q
         sUKhfLv4/WAfjciSO7IbqInSnd6KdJeoOMI6wTAnRRcbLQKqYN/iopGPObTuEySQ4LxA
         oU63lMNKfOGdMMR8ZRyqgoqDNumirw3v3gjfIaEvs/sr4WtfA7RbgHjRdi+dZJePl75P
         rCkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770894520; x=1771499320;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Te28COGsJvbZjhoIswrSDU/sOtkJ6DypnGTOIiAuYoo=;
        b=GCevEMDCLnnvLlQsB9/qCukTDt8C1wQISo6bBtpYMEzkIjcIEkvJpiiaguq7RWMggT
         QDV1fLdHZ4FZBgXwsONZkRkRbUsDv5pbrwfBEmAh0j06yHoe9LLkblN2iny/kRJexww3
         /q5KltmpBkce3CPyrXBgKreSqkHrlTZ5zh98WWs+vVEkdbEN8BBs34KSPl5bLQZa6VBI
         iDaNbXWtmkQ51/rlQwsf/891KPlwKiKO3gdIM28EXhmCswp/5g1TwsMtQvBX7xvQnMZW
         wTlIJzvKIm553Q1vidyevO8CRcnt9GKJt+noUdq/RwTbv8UVO9bb63+llAxopvl0D62U
         nndQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHgkDcpjmg4hCT6jKYab0P2viuzv8GgckiOvU2H7CnrVxjffWRWrIlgfFVsw6FE9KEh5M18WRBM54=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBoUVCUuIPTGnYTEOgNDWWtRhtPvIfWxpTJzTO070PMegSeMlg
	xyKGVuY7r4ykwQ4NzJECEqW4/uUvXUWvEFMp7WHM74TGLdc3xTA8Za+UbHB54Q==
X-Gm-Gg: AZuq6aKfJGmdjjwwiOimIzHHtLxPD4UgukLpj5KvlWbxwl1ogyXvmVURaFz9a7RWc99
	Cf9dyoiwFepqfAxZt7SKag82Yb24Rju3Gf9B3CagUXUN6iOc+cVNZOepbguEciv+Jrm+px20Uwy
	2VNZ6VvPRbMeIP14tWblCQDOo3jPKPcIoxdFSlRZF38rq7mLcFVnwQU/HMUz4xSfYzbznt1Smar
	hd5NCjgjWXbDnlKy8pw9MtTffn3K6Jb2zbwFf3fdE798xgkUnWCdlaSzmqueXb0lPWNPOZO0XBy
	K3kknLc4X7Bg8TI71CUhszlNEMLY/LLp+kxDPiG+/Kdjz+FVqP9fl5XgFYJM1npHF8KA9GF/cWM
	uvqG2doYQ9QkadEMeRGJAPa4cJvGAkOC01Iblyb6OseGve/scTq+3gsTqERDrxHQGMOUWYvL6FR
	SBO1L+uPhmhmGHicM=
X-Received: by 2002:a05:600c:524a:b0:477:7a78:3000 with SMTP id 5b1f17b1804b1-48365718323mr18483945e9.6.1770888685036;
        Thu, 12 Feb 2026 01:31:25 -0800 (PST)
Received: from skbuf ([2a02:2f04:d501:d900:2f75:bf70:f0b9:4586])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d482480sm215126875e9.0.2026.02.12.01.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 01:31:24 -0800 (PST)
Date: Thu, 12 Feb 2026 11:31:21 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Josua Mayer <josua@solid-run.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	linux-phy@lists.infradead.org, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-next@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] phy: renesas: rcar-gen3-usb2: Drop local
 devm_mux_state_get_optional()
Message-ID: <20260212093121.2c6o6pkk4riphbel@skbuf>
References: <67c8c4f9bf9f09fd0c13daedef27b82ff389ddfb.1770720452.git.geert+renesas@glider.be>
 <CAPDyKFpY2X8hephSfHq7rj_DaKX76ZSkWSCYXrGTEBUFHkvOzg@mail.gmail.com>
 <aYyrsPTH1923jV7y@vaman>
 <CAMuHMdUHNRuMmHU2ACX84nsZdXn_-fSamnF+LMFvZS3vkHnEWA@mail.gmail.com>
 <aY1eIG_U_GBOFQGt@vaman>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aY1eIG_U_GBOFQGt@vaman>

On Thu, Feb 12, 2026 at 10:29:12AM +0530, Vinod Koul wrote:
> Hi Geert,
> 
> On 11-02-26, 17:30, Geert Uytterhoeven wrote:
> > Hi Vinod,
> > 
> > On Wed, 11 Feb 2026 at 17:17, Vinod Koul <vkoul@kernel.org> wrote:
> > > On 10-02-26, 14:34, Ulf Hansson wrote:
> > > > On Tue, 10 Feb 2026 at 11:53, Geert Uytterhoeven
> > > > <geert+renesas@glider.be> wrote:
> > > > > Now the mux core provides devm_mux_state_get_optional():
> > > > >
> > > > >     drivers/phy/renesas/phy-rcar-gen3-usb2.c:944:1: error: static declaration of ‘devm_mux_state_get_optional’ follows non-static
> > > > >      declaration
> > > > >       944 | devm_mux_state_get_optional(struct device *dev, const char *mux_name)
> > > > >           | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >     In file included from drivers/phy/renesas/phy-rcar-gen3-usb2.c:20:
> > > > >     include/linux/mux/consumer.h:64:19: note: previous declaration of ‘devm_mux_state_get_optional’ with type ‘struct mux_state *(struct device *, const char *)’
> > > > >        64 | struct mux_state *devm_mux_state_get_optional(struct device *dev, const char *mux_name);
> > > > >           |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > >
> > > > > Fix this by dropping the temporary local wrapper.
> > > > >
> > > > > Fixes: ad314348ceb4fe1f ("mux: Add helper functions for getting optional and selected mux-state")
> > > > > Fixes: 8bb92fd7a0407792 ("phy: renesas: rcar-gen3-usb2: Use mux-state for phyrst management")
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > > Thanks Geert for helping out!
> > > >
> > > > > ---
> > > > >   - ad314348ceb4fe1f is in mmc/next, and a PR has already been sent
> > > > >     https://lore.kernel.org/20260209133441.556464-1-ulf.hansson@linaro.org
> > > > >   - 8bb92fd7a0407792 is in phy/next
> > > >
> > > > Vinod, do you want to pick up the $subject patch as a fix for 7.0-rc1
> > > > or do you prefer me to handle it?
> > >
> > > Should I drop the 8bb92fd7a0407792 and it makes things easier for
> > > everyone and then we can pick fixed commit for 7.1 cycle..
> > >
> > > Does that work for everyone. I was about to send PR, will hold off for a
> > > bit.
> > 
> > Alternatively, you can mention the semantic conflict in your PR to Linus,
> > and ask him to fold my patch into the merge commit.
> 
> Hmmm, that is also a good option but might leave Linus a bit grumpy so
> bit reluctant. Dropping and getting right implementation would be
> better. I think it was a mistake to pick or this all could have gone
> thru mux tree.
> 
> Thanks
> -- 
> ~Vinod

I think with Linus' refusal of the mmc/next PR, there is no longer any
need either for this patch or for the revert of 8bb92fd7a040 ("phy:
renesas: rcar-gen3-usb2: Use mux-state for phyrst management").
http://lore.kernel.org/lkml/CAHk-=wgnRQiKqWVrO_uF1btYM2K8r8xL95RGdKU3QLe8B58nrw@mail.gmail.com
