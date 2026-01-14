Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AE2280014
	for <linux-mmc@vger.kernel.org>; Wed, 14 Jan 2026 13:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768399128; cv=none; b=TxxbIkT9XXZIZAM7hxOI1kBpG5O33OJvcu+LY/UCCiBi6dNTO2yhN8Cr4MMKrAIr9a3fSVe8n36e5JC1grk5Sw9EYaxRagaRWewOtMINj+zZbhsZtlSSheciMcMtFDr8PKhdI7qyRfxR6BpEzLrLIe55ngqcn47fbWdIcIrA5h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768399128; c=relaxed/simple;
	bh=QpeOW/sEaOfEuvoIhUjTAMw7y96h/aW+EFhSth1UXkg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=myCk+xyDwCVkeVpKKak0XhKVOXWbu9HHeGoHQJdQM9hW4GslUvRjfarsgf3/hCN7y95oo+uHdFvpmCsRqawBvKaR8ZZeOFA+RajmYTszIKUbNkp2+nSvG7lg7WYBX7APPZJgQanOU3PGfNO6++8FCRVCzDZExN3nRdlzTm1Kx2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RbaU2diT; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RbaU2diT"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9263D4E420D5;
	Wed, 14 Jan 2026 13:58:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 642E06074A;
	Wed, 14 Jan 2026 13:58:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03BC910B6824C;
	Wed, 14 Jan 2026 14:58:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768399122; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YNjffRp1/8+T59mlTHNitsw61Xuht8VMpF+gPH6kU5M=;
	b=RbaU2diT+2o3nYB+qso994IAQmLHQwmq2nb5Cm1S9sWjjd2N+g9lyE1PdQq6qr2dcnN0K+
	PjOdZ5IKST7oHXinJnIYyn3PT3yAmfDlxk/9qYNbc9iDtqTCVRS6fWWHoUIdMrTENH2zjl
	L6IGjRDuGzHQspn8gMkoYiQbyQwNaY+YI+uTmwQ/yrdrAdN6NH6phsf22oGnt1p5aoI4C7
	/Wo6Inw3e8tZA+sijnhWDwdmRU52crDrkE9NfW8byUv1DZFjaTRGmJruYxeij3y3CNxyTk
	RfRlF6UmoxshF9bek40/kEqIDjKA0QoSRep7ESTW522/Zx/K6pqUADvOErmXoQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Rob Herring <robh@kernel.org>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor
 Dooley <conor+dt@kernel.org>,  Brian Norris <computersforpeace@gmail.com>,
  Kamal Dasu <kdasu.kdev@gmail.com>,  William Zhang
 <william.zhang@broadcom.com>,  Nick Terrell <terrelln@fb.com>,  David
 Sterba <dsterba@suse.com>,  =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>,  Simon Glass
 <sjg@chromium.org>,  Linus Walleij <linusw@kernel.org>,  Ulf Hansson
 <ulf.hansson@linaro.org>,  Marcus Folkesson <marcus.folkesson@gmail.com>,
  Tony Lindgren <tony@atomide.com>,  Roger Quadros <rogerq@kernel.org>,
  Hauke Mehrtens <hauke@hauke-m.de>,  linux-mtd@lists.infradead.org,
  devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-mmc@vger.kernel.org
Subject: Re: [PATCH 07/10] dt-bindings: mtd: Ensure partition node
 properties are documented
In-Reply-To: <CAL_JsqKV+3ZnqpbQ4USmJh-dngik_jZdnpOw0bGcxD0RSSzfxA@mail.gmail.com>
	(Rob Herring's message of "Fri, 9 Jan 2026 18:34:17 -0600")
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
	<20260108-dt-mtd-partitions-v1-7-124a53ce6279@kernel.org>
	<87fr8fxipc.fsf@bootlin.com>
	<CAL_JsqKV+3ZnqpbQ4USmJh-dngik_jZdnpOw0bGcxD0RSSzfxA@mail.gmail.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Wed, 14 Jan 2026 14:58:35 +0100
Message-ID: <87ms2gwb1w.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi Rob,

>> > +$defs:
>> > +  partition-node:
>> > +    type: object
>> > +    if:
>> > +      not:
>> > +        required: [ compatible ]
>> > +    then:
>> > +      $ref: '#'
>> > +      unevaluatedProperties: false
>> > +    else:
>> > +      $ref: '#'
>>
>> This, however, is total blackmagic to me. Would you mind explaining what
>>
>>       $ref: '#'
>>
>> indicates? Is this a placeholder indicating "a reference must be given?
>
> It's what's known as JSON pointers. The '#' is a reference to the top
> level of this schema.
>
>> Also I do not understand the final else case, what is it covering?
>
> It's really just there so a $ref to
> partition.yaml#/$defs/partition-node applies the schema (all of
> partition.yaml) whether there's a compatible property or not.
>
> This all just works around that a schema like this doesn't work:
>
> $ref: foo.yaml
> if:
>   ...
> then:
>   unevaluatedProperties: false
>
> The evaluation of unevaluatedProperties doesn't "see" the $ref being
> in the parent. So we can't factor out the $ref.

Oooh, ok, fully understood. I think I already faced that problem
before. First time I hear about JSON pointers, thanks a lot for the
heads up.

Regarding this series, it feels like in the end, if I understood the
discussion with Krzysztof correctly, there is no modification to bring?
Let me know if you plan on sending a v2 of if I shall take v1 otherwise.

Thanks,
Miqu=C3=A8l
