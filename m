Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706023;
	b=3T5gidZwoBo+TsLfwI9eAtpZmIKrR25uZlJRKvJ5FEhVESKryGmLEqGZ766tYsBkSMK6
	 Zu6pezu2gllSEP6hipym3lyolZwufTw9a1tpA3UuWFC0C4QgqXhUsFuO+QtEFHoF8Ghxm
	 LIkDcBrSY89ipQJ4J1N5noSaq2wkw7fqE7h29OtZw/1wP4vcLpNqu5ydJYf5nlEGkeg0y
	 rcwQZmpjhV6VD3JNnyU8q+9ynRlo2grto4XcmWVksW8tfWZSTZAUYY0w+FTvJXOBvgQje
	 1yyqtwYoKsp9w7NvGzGSzG1K6JuT0Wd4Ce8cVhx03/Q4mYHLLEuNX+ZcLwH/HIhSl0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706023;
	h=DMARC-Filter:Received:DKIM-Signature:Received:MIME-Version:Date:From:
	 To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q66KFJC7/i7Yn4OCqcftASZFnDxA3e4YKO5lDWUMXlY=;
	b=pr7GmI9wrhx0mSxg3fKc8YuOtn48tYAljYJdb6DcUTOa5j148XSFJSd/A9jQGIrGIshy
	 vVca12uNzwZ5iPAK9Bn33vwJ0/TSbd0iovZp5Otf53H3/CGzbHwpwz9u1gEz233zBgxzw
	 WJ2j/hsnNi6EgJmxq9L00yBcVk3fQ76WltuJH20EZ3A4cvsv6EahkCNOK64pKkorSn7T9
	 2cMV28ND4N5xglu2xayF1f9DvFBhqMfnkb863PiBWCUajbBcfir0Nel7i07iWpYj8V583
	 U01tGgfSTXlAg8FBSj1LDocd5FLOUXGwbhthV8LwtmZlMJgaYQjV647Yb/602LDmlQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b="bjt9+W/b";
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620286082BC8
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 11:40:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 620286082BC8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=bjt9+W/b
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 2990D240109
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 12:40:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793706020;
	bh=Q66KFJC7/i7Yn4OCqcftASZFnDxA3e4YKO5lDWUMXlY=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=bjt9+W/bdEj9OIkjT+tMhRa3EyLEGBVp77gpDIxWr3H+xaDFoUqsIss7lm8ho8qBt
	 cmcV/OmuHVTf0YhBTy5pun2eWpGqTYbajHq2CCttvn0aTcnP3chEIe9NIQkrTUUp5b
	 wlxY7rRD0Xfz0lVjyVt1625P+T47clxB9YSoSQ4efuvQQ2c1mjWCZxFPbQKRXmm6oE
	 dovLyI970W9kDmLktYarmd3Bn5AkU9T2t5sukvf0NkL+d4m+LPld2dEigfEUZa0LUu
	 wECiN6rPDUnpL40SVt29s2KRQL4O3ls79OKgiJSWkg40KuEGcVzKXMgbLaUtnGoJ+1
	 rVnzxPkSC7wzg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jJmpV1Zysz9rxL;
	Tue,  3 Nov 2026 12:40:18 +0100 (CET)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 11:40:19 +0000
From: mateusz.nowicki@posteo.net
To: Christophe KERELLO <christophe.kerello@foss.st.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, Linus Walleij <linusw@kernel.org>, Yann Gautier
 <yann.gautier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 2/3] mmc: mmci: stm32: do not use NEGEDGE in HS200 mode
In-Reply-To: <a5fff7cd-686a-4fef-b9f7-87e19b870fa9@foss.st.com>
References: <20261031120700.42576-1-mateusz.nowicki@posteo.net>
 <20261031120700.42576-3-mateusz.nowicki@posteo.net>
 <a5fff7cd-686a-4fef-b9f7-87e19b870fa9@foss.st.com>
Message-ID: <f9358cbe526c22c6a8fcbdde814820e3@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello Christophe,

> No, it is not what it is written in the RM. If clkdiv is equal to 0, 
> NEGEDGE has no effect.
> NEGEDGE has an effect only when clkdiv > 0, so it can be used with 
> HS200.

You're right, thanks for the correction. I read the NA in table 268 as
"not allowed in HS200", but it is only there because CLKDIV is 0 in that
configuration. I'll drop this patch.

> On ST downstream Linux Kernel, you can find following patch not already 
> upstream:
> mmc: mmci: stm32: use the delay block above 100 MHz on stm32mp25 SoC 
> (Commit ca3b1cf)
> By applying previous downstream patch + patch 3 of this patchset + 
> using  original slew rate that was upstream on
> this board (slew rate set to 2 for the clock IO, 1 for the others IOs), 
> HS200 should run on a ST MP25 DK board at 100 MHz.

Thanks for the pointer, that was the missing piece. I went back to the
DK and tested it with the SDMMC2 kernel clock at 200 MHz, so HS200 runs
at 100 MHz like in mainline. Without ca3b1cf every write test failed,
no matter whether NEGEDGE was set or which pin group I used. With
ca3b1cf all runs were clean, with pins_a as well as with pins_b. I also
checked 150 MHz (no divider, delay block in use), and it works with
both pin groups too.

So NEGEDGE was never the problem, it was the delay block running at
100 MHz. I'll include ca3b1cf and 01d3cac in v2, with you as the author.

One more thing about the pins. I added the pins_b groups (faster slew
rate) to the DK device tree in 7.4 because pins_a seemed to corrupt data
in HS200 at 100 MHz. Looking at it now, that was the same delay block
issue. Would you like me to send a patch that switches the DK back to
pins_a and drops pins_b?

> This patch breaks also MP13 SoC that is supporting HS200.

Understood, sorry about that.

Regards,
Mateusz

