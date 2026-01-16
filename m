Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE813590C4;
	Fri, 16 Jan 2026 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768556647; cv=none; b=N2YwxV5ukvMA8Pv57vD9/NjNDo2RvzC+K+3TGnloswEzjeieOV/NUGtV5vJdiGd9c9tulCaIsIS0bY8fU7c1vw0lhvcv3B4l0iUs9A9Lu3KDjGWpkSpIj45Q7i4D3tB6STYDIP9xnTTIInFww7WaaEMUwtHV3EE9O2RIs5WurUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768556647; c=relaxed/simple;
	bh=1c4EcBFwNDwcjlcibwyZ+c6q6z+rAR6cb1ZILyUaqEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/dWZglKNmFcTZYKVjC10HOuf+2D3XDSu8jFx14Y+tqn8rLd8yXC8kloNZ8eyW5DYvg0Z3pAIvGcE9b5rQcIqwIoiOP8+amN8VbEm83HXAGYgDsJpjYxK7VyqRSTOqxF/g4A0sK/6xae3z+smF48XS/PSuv+esQKwCI2llj5Yh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=X/EKOz3y; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="X/EKOz3y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=QGCCaGWgIfg2vfdsl9W+Yld60nDB/Iv9Cfq95SmZGJI=; b=X/EKOz3ywJYWTNlqdF9VO9mql5
	4xqoQqvalFKibN2AMQncOi+i9nZUxkoIuPYhvI/FtRsNo66DBdHnsn2ZmwMZWbrE8IoJDy2XZmuNG
	tfYsgLEUU+slhtyaVTt+tpeVhn5ZM8pmMHPoymFb/5qk5v/tUXpchepygjStqoQWSvfpaSeU9sOST
	EcbAMgR6GRYyjFX3guDim1kIMORAtWLZpKTcAazE2T82Jn8BbsikfwlRm8I1fsC1wM0tvyhnGVdVx
	x8zrOWwE7JUtitXUbMgt1xZvks2AYJ5P+sF5DcMYS8Hm+M+V2aF8W42uSzgafMAiEqGLbKpeXowEO
	rlWUq23Q==;
Received: from i53875a97.versanet.de ([83.135.90.151] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vggN5-002bUI-F4; Fri, 16 Jan 2026 10:44:00 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Marco Schirrmeister <mschirrmeister@gmail.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-rockchip@lists.infradead.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject:
 Re: [PATCH v1 1/3] dt-bindings: mmc: rockchip-dw-mshc: add
 rockchip,disable-runtime-pm
Date: Fri, 16 Jan 2026 10:43:57 +0100
Message-ID: <1791168.izSxrag8PF@diego>
In-Reply-To:
 <CAGJh8eAWNe0JzC7BdA2Rw5etCYgGq3O5Zdgk9zSzsLNv18k=ag@mail.gmail.com>
References:
 <20260110010715.1610159-1-mschirrmeister@gmail.com>
 <20260111-melodic-chestnut-coua-73e6ec@quoll>
 <CAGJh8eAWNe0JzC7BdA2Rw5etCYgGq3O5Zdgk9zSzsLNv18k=ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi Marco,

Am Montag, 12. Januar 2026, 00:51:24 Mitteleurop=C3=A4ische Normalzeit schr=
ieb Marco Schirrmeister:
> On Sun, Jan 11, 2026 at 10:41=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel=
=2Eorg> wrote:
> > > +  rockchip,disable-runtime-pm:
> > > +    type: boolean
> > > +    description:
> > > +      Inhibit runtime power management. This is required for boards
> >
> > What is runtime power management? Like Linux PM? If anything phrased
> > like that is it is a clear no go. Bindings describe hardware.
>=20
> You are right. This refers to the Linux PM subsystem and describes
> software behavior.
>=20
> > > +      where the bus timing becomes unstable if the controller is
> > > +      runtime-suspended.
> >
> > You described the desired Linux feature or behavior, not the actual
> > hardware. The bindings are about the latter, so instead you need to
> > rephrase the property and its description to match actual hardware
> > capabilities/features/configuration etc.
>=20
> On this board, the bus timing becomes unstable when waking up from
> a low-power state. This causes a constant retraining loop.

As you describe it here, it does sound like a real hardware quirk (which
would be a dt-thing) ... it's just that the previous wording describes it
in a non-hardware way - as Krzysztof pointed out in his reply.


> I will move this logic into the driver and handle it as a board specific
> quirk using of_machine_is_compatible("friendlyarm,nanopi-r76s")
> instead. I will send a v2.

This won't fly I think. We can't really have a (possibly long) list of

If (boardA) foo();
if (boardB) bar();
if (boardC) bas();

That really is not sustainable and most likely won't get accepted.

Heiko


