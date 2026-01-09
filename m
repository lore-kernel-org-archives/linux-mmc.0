Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7665B347DD
	for <linux-mmc@vger.kernel.org>; Fri,  9 Jan 2026 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949345; cv=none; b=A1C0vWzk2i2x8LXej7Gwjysdcc3tYMBhZ5VRBNKGLt+JpRgG0kDFyjaimOY+dLBcCcWIQDirhrxtF8YwjQTl0UOOIW/rLy6HsjBSKGL86lRTzhhHh69ceDMvH2n+rT6PlUXCIaAropFZRCYSyfdY5sfSH2PfWm0uKiEoQrDCjVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949345; c=relaxed/simple;
	bh=kmVu0tRy9fKfOH0WAJGuWXx3Zh4ofnNsMmmGksvk+Nc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=R6zLVMKrPPMW8DHcdndY8DmN6VNuAO6Tf8Ws4c8LkLDMIaE8PvTu293rc7deD6KOxl73mUhgY2wOQmUfta2u9fxcnM8U1G/MCq6Dz5MOogMoGSJ6rhmdbRf1C3dNz4KIMymXL7340Et8LTd7ZYswai0U75qPL+F+lyjFTWbd1CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O9taR1y3; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O9taR1y3"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4081A1A273B;
	Fri,  9 Jan 2026 09:02:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1261B60734;
	Fri,  9 Jan 2026 09:02:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 21670103C885B;
	Fri,  9 Jan 2026 10:02:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767949335; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=CTgNQ8aQKCK1awytoBCTagqusNg0f5KtpE7Bd+9hU70=;
	b=O9taR1y3aXblZciBqRSMOSupr+ReveLz5o2s2I5yTRJOgfMafUOyTmpRscqBj/f+fZ5cLn
	MLzyU11frfLWtCNsnWvhVdSnOPGKuOlmRtiNtkApr0XYmslk/ngrb76fkq7lo9/xRyRXox
	YsZ6MpM2CATVxd+Z4fqxtzDhLGVOsKAmSLAELhMrDKAUFK3leQRotyrBVvfl9XeV8kbN0S
	SJxJJ4/VqjEGLba0YB2aQRK5P46bYw9ckUzwligbrlXSX7aQdIANw1urahcxZ0dOPZ8xs5
	mKselM63JX98wnzDCvO9OoIz0/P9AxleQNgv9QWBXcPhYZTmi7OgOxHgJeRWbw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
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
In-Reply-To: <20260108-dt-mtd-partitions-v1-7-124a53ce6279@kernel.org> (Rob
	Herring's message of "Thu, 08 Jan 2026 11:53:16 -0600")
References: <20260108-dt-mtd-partitions-v1-0-124a53ce6279@kernel.org>
	<20260108-dt-mtd-partitions-v1-7-124a53ce6279@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 09 Jan 2026 10:02:07 +0100
Message-ID: <87fr8fxipc.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Rob,

On 08/01/2026 at 11:53:16 -06, "Rob Herring (Arm)" <robh@kernel.org> wrote:

> Partition nodes without a compatible have no restrictions on additional
> properties. Fix this by ensuring 'unevaluatedProperties' is set when
> there's no compatible property. If there is a compatible property, then
> there should be a specific schema for it which will enforce
> 'unevaluatedProperties'.
>
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Overall thank you very much for this series, I've been sruggling while
defining these and your approach seems very relevant. I am fine with all
the patches in this series, but will wait a bit for others to make a bit
of feedback.

[...]

> +$defs:
> +  partition-node:
> +    type: object
> +    if:
> +      not:
> +        required: [ compatible ]
> +    then:
> +      $ref: '#'
> +      unevaluatedProperties: false
> +    else:
> +      $ref: '#'

This, however, is total blackmagic to me. Would you mind explaining what

      $ref: '#'

indicates? Is this a placeholder indicating "a reference must be given?

Also I do not understand the final else case, what is it covering?

Thanks for the little explanation (or you can give me a pointer to some
relevant doc I could read).

Thanks,
Miqu=C3=A8l
