Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F93984A
	for <linux-mmc@vger.kernel.org>; Mon, 12 Feb 2024 11:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736662; cv=none; b=f12F9jNCGU880O+NHxT7NUIghpGAVZhUYruJ9JNfrcIS2hGC1HiEbRYUr5gf6HE8ylQYBcv2AY7TYvI6m0Bh93nEVhl++E8cbbpI4ibuVluPKerDueMMgk9S7xj3jKKxSlS/eaTiLrp6F5dS/jCRtC6B0g6+COVGH9DxUIGzNwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736662; c=relaxed/simple;
	bh=6OuJxan0RO9Rm8CnHzNnBl9DKAywxvgH9Eco662MVcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqFbNFrD0zneB+MiAwNtAQHRYKKbKKeqnmyl6tXqkObYcLbKZBqx7rS+3nJe+xb1MGp5LlpzA+NDqhThAdDR099+QAJTgk81uHPDi2bmqsqAXFPO4j7DomzMFF13oQmJv4qFvKyXdq1kIdqTCFAwhne4SCCh9/Vk+B5K1cCHKNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Flmbgik0; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Flmbgik0"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-604b2c3c643so24614247b3.0
        for <linux-mmc@vger.kernel.org>; Mon, 12 Feb 2024 03:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707736660; x=1708341460; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eXlnIB6w3EJyUe2smpgvDwHTN4H9326dG042toXH0B0=;
        b=Flmbgik0+EerQvJble09ihH1iXL/+PRQirW6gTCoe3MWE69aDs8ZWdwvN/J4/Wphie
         5ayPzw5JhOjYYm3y0uFR7cehKSgee0dRQ61Ci5myK0GM34c5Sq6ospJIPHwoC/X+nQ/w
         M8GgbySOjpin6Z9JdM7ZTLHTyg9lh8wlnT3RpPrqo32LUKDjOnLbw1mAv7OKrAc61pvl
         X0WoptTWRxnz6dIuM5p2bUFePFe2mG86DFHb/c8aUvBCBLmxf4W94tqZrsVKXlhUCkvp
         21lh7llZcRkY/rz5JSOqK+/p3cMZgxhFucPqroAx5EM2G609URoPOoMwEblolkeyk5BX
         FCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707736660; x=1708341460;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eXlnIB6w3EJyUe2smpgvDwHTN4H9326dG042toXH0B0=;
        b=aRw495Rh6ow11hKTVttTRkBQMo1//PoAt3axR1g8798qxVGE11bmUKKKVdzHqZsj4G
         UiPfEi7Uq+wvjEYwEDpd16yEkFevsxofY6zosjvaqnhATyumN+Z0IKkprrjiWrco3gec
         iq+lRnvRX7S9Vp8rlw0/7MkH95MH9EvjJ9Ld8U1tMjtH7d2TY7I1aJPzJ464wguo/tbE
         +RY95yn58vLCdeilIsjPRGpne1BfCKHa9R3edmcPdwiJ5aL+knl3f+nmNRT47Tn1GZWy
         jWeHbI5bebmyYoGDXiNVzFDhNN5DCm8ss1uNRQsUOhmH3NjuZ7DlBmgrSl5m0Ni+Q6+m
         kcnQ==
X-Gm-Message-State: AOJu0Yx1Owl/+Te45eSAFHSrdAM5naADOMgOdo0avlCna++6ea2+4/Gz
	KzQIiA897UZHJg2X5L8GlCkCvp0BEfxcKI7YoL7ycyc0nz4T6JxAHlw293ouZyi6P4ASnARnlOj
	2OQ0Rq52TDGiuByqXPgwmXUdJU7vgbVvh4lwPXQ==
X-Google-Smtp-Source: AGHT+IF9GDNEuttfYlVQrYI4s7jFX4gNI1ltABl5lKf9BO7IINBP0fJdXEuiOWk54w0rp1fb1PQs/TlZyxESPHS3Pa8=
X-Received: by 2002:a81:920c:0:b0:604:9729:6b49 with SMTP id
 j12-20020a81920c000000b0060497296b49mr2924236ywg.5.1707736660068; Mon, 12 Feb
 2024 03:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209015817.14627-8-wsa+renesas@sang-engineering.com>
 <CAPDyKFpmfgwJ5dJFmORhg1tBewzhB_jrWikpX=b23r-joN91SA@mail.gmail.com> <20240209132837.GJ689448@google.com>
In-Reply-To: <20240209132837.GJ689448@google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 12 Feb 2024 12:17:03 +0100
Message-ID: <CAPDyKFpho16DU7OorMgXDqiyfFfgM_tWu+DZZOHd0gbjtBw_Cg@mail.gmail.com>
Subject: Re: [PATCH 0/6] mfd: tmio: simplify header and move to platform_data
To: Lee Jones <lee@kernel.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-renesas-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Feb 2024 at 14:28, Lee Jones <lee@kernel.org> wrote:
>
> On Fri, 09 Feb 2024, Ulf Hansson wrote:
>
> > On Fri, 9 Feb 2024 at 02:59, Wolfram Sang
> > <wsa+renesas@sang-engineering.com> wrote:
> > >
> > > The MFD parts of the TMIO have been removed by Arnd, so that only the
> > > SD/MMC related functionality is left. Remove the outdated remains in the
> > > public header file and then move it to platform_data as the data is now
> > > specific for the SD/MMC part.
> > >
> > > Based on 6.8-rc3, build bot is happy. Branch is here:
> > >
> > > git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/sdhi/tmio-simplification
> > >
> > > I'd suggest this goes via the MFD tree, so the series would need acks
> > > from the MMC and SH maintainers. Is that okay with everyone?
> >
> > Wouldn't it be better to funnel this via the mmc tree? In that way, we
> > can easily avoid conflicts with additional renesas-mmc driver changes
> > that we have in pipe.
>
> You could say the same about changes SH, MFD and Platform Data have in
> the pipe.
>
> > Or perhaps there are other changes that make the mfd tree preferred?
>
> MFD is usually preferred since the parent device usually lives there and
> we are well accustomed to merging multi-subsystem related sets.
>
> It doesn't really matter how this is merged.  The only stipulation is
> that whoever applies the set does so on a succinct, immutable, tagged
> branch and sends out a pull-request for everyone else to pull from.

You are right.

Although, in this particular case I thought it could make better sense
to use the mmc tree, because 1) we are only removing a header file
from mfd and 2) I know we have other renesas-mmc changes in the pipe
for the next release. The point is, I wanted us to avoid the need for
using an immutable branch. But nevermind.

>
> If you want to do that, there are no complains from me.

Well, it sounds like we may need the flexibility with the immutable
branch, so I suggest we do the usual thing with the mfd tree.

Please add my ack for the mmc related changes.

[...]

Kind regards
Uffe
