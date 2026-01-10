Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C819E98D
	for <linux-mmc@vger.kernel.org>; Sat, 10 Jan 2026 00:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768005270; cv=none; b=cnRJRKAX3t+I/ZvAQgY708tm1ajjxzI2LoQV4/k6Bn7nrzRadOhZFSAZ8G3FP8GyqMKkPlE5BaRAv9umGrv/4iFBdFjH5kjPYQyq3RzHIlc/ZUiWEnKsny4C1GkDhBFAIguoG9ZYMKLz6Pxv2743TFxlbq3v3Gi1zd6LcA+/S84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768005270; c=relaxed/simple;
	bh=n9j4w5nJYKbxcwM73KIWngQepQ+L/d3sKcNUKAyIKtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=st2Mg6MHNDgn2Y333YdkOwiyTCoVhMFCuNOU7SuX4/im0r1swh6azn8OdhKVgMDVKEmYN5W+zPFYMVorS5ZnnBI2NswgLX91nEey0//v6oa71KHlj2xnuCDKmTP9vbf7P3Mzj91MZbhNL6xQ1TxSAAjBzFGd/3zCQpWHZ3AWt6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3j1l10C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3j1l10C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51485C2BCB2
	for <linux-mmc@vger.kernel.org>; Sat, 10 Jan 2026 00:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768005270;
	bh=n9j4w5nJYKbxcwM73KIWngQepQ+L/d3sKcNUKAyIKtA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Y3j1l10C+hAb4+TwRKe4Yib5x0tP27Svztx8ryAtaW5SCgjFum36gzCyn9TvCKILf
	 3RpShiT0yTvU2h7okf9Fq/EOlpZmTwXg6F5nYoc7x91qI6O/JNEj2PHvq6atrtyZhV
	 amcBUYADbpTh+C2lJkCjRJxvjo/S1OObtidjLIWnPvLevAlUzygmhQ7eX9b64ZPH9O
	 lIhxGQZW7izhpKMbgILxwbUqtpCz9wGSzR1ti1fLrEwiyh9lmxVI4O2yZNDA1ogkw/
	 i+qSWFPBwubHAHuv9OEZmgQZhI47KjI7OSjAJXr0+IcOF/tJbglNF2WbZxq16ZHY6t
	 BUhA/Pj6Z5uWw==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7a02592efaso783263366b.1
        for <linux-mmc@vger.kernel.org>; Fri, 09 Jan 2026 16:34:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURSVV9yNZ+e0vdFUidrNoikTbZCoCSdiWsXCv8F9awysE4g71KOgQLs6uM+ot6GGfcnGdHbmUOegc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jbEN3Tr2hxHUtTyCudcRbv3HhDEB3JfgPSxt9geZgAMRG8Pp
	Q/lKpWQ77QCHreL9tEztyhttd8WCXaoSPR4Pnqzt3RT600k3W2tfh9eJSGL0OuMjetJlFsOqt/z
	o89q1LghaiAOO39XoKP8o+WccJJ2BIQ==
X-Google-Smtp-Source: AGHT+IHN7k0nlGN3BF9fptQCLroS2OEfJY1/5qH3rkE+fPUZiyIh4ww1H45mbZW8XjV64hyoMyOZFamozMjqQOGqBVw=
X-Received: by 2002:a17:907:c08:b0:b83:3773:e72a with SMTP id
 a640c23a62f3a-b8444c3fc0bmr1024959766b.1.1768005268828; Fri, 09 Jan 2026
 16:34:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
 <20260108-dt-mtd-partitions-v1-7-124a53ce6279@kernel.org> <87fr8fxipc.fsf@bootlin.com>
In-Reply-To: <87fr8fxipc.fsf@bootlin.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 9 Jan 2026 18:34:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKV+3ZnqpbQ4USmJh-dngik_jZdnpOw0bGcxD0RSSzfxA@mail.gmail.com>
X-Gm-Features: AZwV_QjC5h7SzUM3Etvm3QTQEL2XLjJtwO-GnUAtRHPbI0yx2ANvpooNSCKrkpM
Message-ID: <CAL_JsqKV+3ZnqpbQ4USmJh-dngik_jZdnpOw0bGcxD0RSSzfxA@mail.gmail.com>
Subject: Re: [PATCH 07/10] dt-bindings: mtd: Ensure partition node properties
 are documented
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Brian Norris <computersforpeace@gmail.com>, Kamal Dasu <kdasu.kdev@gmail.com>, 
	William Zhang <william.zhang@broadcom.com>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Simon Glass <sjg@chromium.org>, Linus Walleij <linusw@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Roger Quadros <rogerq@kernel.org>, Hauke Mehrtens <hauke@hauke-m.de>, 
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 3:02=E2=80=AFAM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> Hello Rob,
>
> On 08/01/2026 at 11:53:16 -06, "Rob Herring (Arm)" <robh@kernel.org> wrot=
e:
>
> > Partition nodes without a compatible have no restrictions on additional
> > properties. Fix this by ensuring 'unevaluatedProperties' is set when
> > there's no compatible property. If there is a compatible property, then
> > there should be a specific schema for it which will enforce
> > 'unevaluatedProperties'.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
>
> Overall thank you very much for this series, I've been sruggling while
> defining these and your approach seems very relevant. I am fine with all
> the patches in this series, but will wait a bit for others to make a bit
> of feedback.
>
> [...]
>
> > +$defs:
> > +  partition-node:
> > +    type: object
> > +    if:
> > +      not:
> > +        required: [ compatible ]
> > +    then:
> > +      $ref: '#'
> > +      unevaluatedProperties: false
> > +    else:
> > +      $ref: '#'
>
> This, however, is total blackmagic to me. Would you mind explaining what
>
>       $ref: '#'
>
> indicates? Is this a placeholder indicating "a reference must be given?

It's what's known as JSON pointers. The '#' is a reference to the top
level of this schema.

> Also I do not understand the final else case, what is it covering?

It's really just there so a $ref to
partition.yaml#/$defs/partition-node applies the schema (all of
partition.yaml) whether there's a compatible property or not.

This all just works around that a schema like this doesn't work:

$ref: foo.yaml
if:
  ...
then:
  unevaluatedProperties: false

The evaluation of unevaluatedProperties doesn't "see" the $ref being
in the parent. So we can't factor out the $ref.

Hope that makes sense.

Rob
