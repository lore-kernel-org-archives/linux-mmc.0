Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560C32EA159;
	Thu, 25 Sep 2025 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784039; cv=none; b=DzxB2v7JjXl7JOB9dsiKNtT/r/bDrF18dZzRmwMXx8PmLOM6p/bd49MUmj+vg7Rwg+ckMRBtpFdeJ0sn+vzijWMtYPldHqeFzExcnlNRcnehGk6FLiwskCzBgI7q6genk1GFTc0OrEguPH05yY6Kk9CvAhpd3Y3kOGm9A3TYunY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784039; c=relaxed/simple;
	bh=g+r5Q5E94/jojgji+RWseyLVvvGLzc3G6w5H7nl4WJQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=itWzzVNglZLN8NASfSUlI3Jp9SUNmqBZBDRGl4pxikpNsQPk/glbWhehiKWlbjMTCOUK+e+X7wFIQv7xapLzCatk3cxExzQq4Byw7OHL8yuTAofEvRydvAByzLWyqeyQ8mEYlgjuWxKd3MMaX6YNXBHFREXjfqIZddYCnaOit9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=w3Ex7jnU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lrcUrojy; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="w3Ex7jnU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lrcUrojy"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4EEC61D00153;
	Thu, 25 Sep 2025 03:07:16 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 03:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758784036;
	 x=1758870436; bh=TeIrumQy28sPmYSnm7vU8gqJZj2W4K8gO38cU/gKK3Y=; b=
	w3Ex7jnUBXWkmKCwAFWnH32PbPYgT6hQ9+nm0NwA26DiUhtQiYT5Lc+PyKOR6tLw
	Qsv2g6CV8PhnEf+oJJHuJQ+IxmqwVISpjGxBas9FD+lGnU1TByxjLqmOXWK6fSBm
	TS7sZCk/3H6eltuYwQadCCY4yjZhLdZzbj+Cdg0qzvaMLrl7iM06kvBraAWaxfsS
	67TBf/MejRUkeRvxz54/aMSvDDQbiRkTUxSvyOIAcbksthMw8FKlpXDvXNoNPJcU
	tN43Pb0hEAV+nH2k5VlD4/pFBNiYCZ5KL30lAshIlmTf+nBA1vpZMpUqogo6Rc/g
	Sn7Iq+JX3Z14K2JJycmbng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758784036; x=
	1758870436; bh=TeIrumQy28sPmYSnm7vU8gqJZj2W4K8gO38cU/gKK3Y=; b=l
	rcUrojyuUb71wHD2vPR4b/F6wEcxPZlHmWD5RRVHKgLTePmmQnMqMHYR4nimbIf5
	XC9jb5uX9x210q18nT3jtZf/YOoo4PocqOUP/Ali9IFvjNlfLdZCaoGqUZw6O0Jq
	AhzgFiUby+d6qNXL+3gM3eAzkXxZl13rUz9R3jfXkqSJW181z4wIMXxGpBTknZRS
	xkhrVDXwqxefrRgtoBZ3bF1XnaTAEG8S6O2gnxx2PBQRNBIpJI4OjlJAnViHy+eP
	5Gcl6QSSq5oj4lDKCXeCgdrJdhWDBouOSOdxSx4CxNRuY4LVAlYcbZ+8ugkhu9fo
	QOYYvsv4ZHsbR14A+Y5uA==
X-ME-Sender: <xms:IurUaJcOrUmrm2kwDrRAaTlGz4eVGDJMM7R61_2i1b4o7-HUNFkAjw>
    <xme:IurUaCC0jRrsWJ-UUdNT-WWbC93ST5nAB2Ttx9rWv9e26_uKhCmWP2QQjKTyDiqh0
    DKYHxJGo5-AZboasELTiyLbO8-n0sk7u-fFRMIx33LL9kt8KWQO-Jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeekleejudehvdehueegheehvdfggfefhfefueevieeigeduueevjeehgfevudffheen
    ucffohhmrghinhepsghsthdrrghinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    udeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtrghlihhnrdhmrghrih
    hnrghssegrrhhmrdgtohhmpdhrtghpthhtohepghhorhguohhnrdhgvgessghsthdrrghi
    pdhrtghpthhtohepsghsthdquhhpshhtrhgvrghmsegsshhtrghirdhtohhppdhrtghpth
    htoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopegt
    ohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriiihshiith
    hofhdrkhhoiihlohifshhkiheslhhinhgrrhhordhorhhg
X-ME-Proxy: <xmx:IurUaMkt3FNzrr5HiolNmk8y7IHLKox9NIhqNC07gffGXE_2Vg0GKw>
    <xmx:IurUaMySZkUXc-wcDplhthTrFFPDP2QMcJB7fLHzHKmQNIGMw9njLA>
    <xmx:IurUaK_OTM_tPVPPHdOcM0rozgw6yfGUDbpTIyf61urUNuRffoeyKQ>
    <xmx:IurUaHAEOz6W5dfpOnvX12hYr6DZ4TB2D2UlvO9Dj_3fSKqcxd3nyQ>
    <xmx:JOrUaF3bnAJYdSobaar05uW3kQz6dJ9tv-aka8j6dxOv_nzEky7767xX>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 792C2700069; Thu, 25 Sep 2025 03:07:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYQZGcjF-1nJ
Date: Thu, 25 Sep 2025 09:06:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "yangzh0906@thundersoft.com" <yangzh0906@thundersoft.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "gordon.ge" <gordon.ge@bst.ai>,
 bst-upstream <bst-upstream@bstai.top>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Adrian Hunter" <adrian.hunter@intel.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 soc@lists.linux.dev, "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
Message-Id: <09b1318e-21dc-4354-8733-866b70696295@app.fastmail.com>
In-Reply-To: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
References: <20250923-v4-patch-final-v1-0-2283ad7cbf88@thundersoft.com>
Subject: Re: [PATCH 0/9] arm64: introduce Black Sesame Technologies C1200 SoC and
 CDCU1.0 board
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Sep 23, 2025, at 08:10, Albert Yang wrote:
> This patch series introduces comprehensive support for Black Sesame 
> Technologies
> (BST) C1200 SoC and CDCU1.0 ADAS 4C2G board. BST is a leading 
> automotive-grade
> computing SoC provider focusing on intelligent driving, computer 
> vision, and AI
> capabilities for ADAS and autonomous driving applications. You can find 
> more information
> about the SoC and related boards at: https://bst.ai

Hi Albert,

I see you submitted the series to soc@lists.linux.dev, which would
normally indicate that it has been fully reviewed and is ready
to be merged.

I'd be happy to merge the actual SoC portions in arch/arm64 as they
do seem to be ready, and for a new SoC support I sometimes merge
in required driver changes with a subsystem (uart, irqchip, clk, ...)
maintainer's Ack as well. However the MMC driver portions in patches
4-6 don't really fall into that category, as there has not been
any Ack for this version yet, and MMC is not one of the subsystems
we normally make this exception for.

Given the current timing, I would suggest that you respin the
series for 6.19 once 6.18-rc1 is out and leave out those three
patches in the submission to soc@lists.linux.dev.

If the MMC driver gets merged for 6.19, it's ok to keep the
sdhci device nodes in the dtsi file here, but to make things
easier, you can also leave out those nodes in the initial
submission and send this as a follow-up patch to
soc@lists.linux.dev once the driver is actually merged.

     Arnd
