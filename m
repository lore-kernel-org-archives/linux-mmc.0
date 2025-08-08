Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CA72AE74;
	Fri,  8 Aug 2025 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645757; cv=none; b=DZwwYsNtsMjZAfYTTIk0vpbWZ1aXTb50J2oVi9FPu5LufNWbuOn3Du7+zCpsrjsCG7iZbp+xrf9uJLYbfbuTxrFcex31RWjDEJMfaqSMa6N08zTGBXeypLm9gwxOqNxVqBKv8JgJ2Cv2lWO/jPAcr+K0+GmOsNqM4eSbiViFPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645757; c=relaxed/simple;
	bh=TLVTniuZttcH1XUQEqI/TrUIjj9gfTm9RsC9ZiqzNIc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=m8qa/qFV6KxDO0IqGYT2Vdl4ZQ/RqlVtt9EXRvkKH5LxMugZunStBIukwiUUUBcez03DsY5y2nW3xzjOwTgWFWuYsZnztLtvo+RVfd9c79BtE2BzOsAQ1aZQqavhiuPNymcAriIQL4IkGnOan/fHii9DBtTKgjgcmhSJkBDaVWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TOuzzp57; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HTxUchm7; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TOuzzp57";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HTxUchm7"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 440CF14000B9;
	Fri,  8 Aug 2025 05:35:52 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 08 Aug 2025 05:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1754645752;
	 x=1754732152; bh=+IkjgG41wJ1Z8VswgckhF77h56auMeNQN7JbI+lzz8U=; b=
	TOuzzp57RHZZYLsPtSdfWyLv5cDm+26SfYGkZMGlmn/s0QOhNXueT8Os55HwymB/
	8BFVSfj4U+BuFKG8XRVcCAWdpqkrxCH+VVVOR+FjPosYGUdbbpGiU1H/LDK/AxG5
	7UY9msE6fkCXp/Y4kNZEARHr1P7rRs5Q6jmsQSitjhfg1jneZ9MroqFCFcQKGLOo
	joMQjxnx+2kdJO5tf4SAi6lhjt1nCabWN7PEdaX8EkUIaG1zc3GsppIy3t62wupp
	Kr7ZmCjn6LSTBO0t/CpJfNB1yihTyMnCLllFzvhaHtjMnmp83msC+CqPcRitOIcc
	6B2mOW/Uh8i12uLzT93LKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754645752; x=
	1754732152; bh=+IkjgG41wJ1Z8VswgckhF77h56auMeNQN7JbI+lzz8U=; b=H
	TxUchm7Dlc1uhe0lQj+L9hBiroGWUhJLpMOXvOVf2nGWai4gjDNrtSLHUwCOHr5C
	CRHTJxO+TCnWrz49oldUN9mRAg4vM2WnYwxLoRls5a5IqDe2Wl1CB7gneoVuoKb7
	pgCtTyPz43G9rL/Fc4lP7nNswcizAO4+6xnvCcAqtxeGVkP8XAdMWrTVuG9yf4s4
	UK+0/vLFzKinqeGrABa/P8h7QAr4amWgOM6Qlswq9N9qWR50dE4ZSUArenruihsx
	3zMSfhqPBuKHD5X4vCMfsiqkpr2vVdvvWzqPCUha7ENnHnxrjnegH+hl+vbB0gvp
	SVe4aygYWFN3qcvRcz6NQ==
X-ME-Sender: <xms:98SVaFlFZOa1-h9v78DmKLpruZwL2M1zH-NzkTJo2DcbINe5WEineQ>
    <xme:98SVaA2ZAZOxmqHTRU2bq23wl_STSdJH6KPCUUKVScFIDRAdbVdMtavbOzC6mbbYG
    FV9IHzykPy5lg7Fbxs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvdefgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhorhguohhnrdhgvgessghsthdrrghipdhrtghpthhtoheprggurh
    hirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphhtthhopehulhhfrdhhrghn
    shhsohhnsehlihhnrghrohdrohhrghdprhgtphhtthhopeihrghnghiihhdtledtieesth
    hhuhhnuggvrhhsohhfthdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmhgtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:98SVaFuEeDIe2kZQMto9tLEajLj9N4del19h-D3JcZ4jD3ObvPg1OQ>
    <xmx:98SVaF2TJsDGbSssP0Hk9T1l0A2hXlzu12GOlkrjPaZEqWEZl2SkjQ>
    <xmx:98SVaOVQXPfe5cKuifA5sbbkKvtDQgxrKkcr4_R-4a4kAi0Rnk6i3A>
    <xmx:98SVaIILXFePJ6scoTA6yxgx9q2yDi5iwt_dRXJJWsmLe9HjpR5lTA>
    <xmx:-MSVaPgKPDuSDb6RSQXWjG9vifYjiFVjWe9xRxg28aF3LfnqC8JHwN-L>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 72DDA700068; Fri,  8 Aug 2025 05:35:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Tf7f6c885039edc57
Date: Fri, 08 Aug 2025 11:35:07 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "yangzh0906@thundersoft.com" <yangzh0906@thundersoft.com>
Cc: "Adrian Hunter" <adrian.hunter@intel.com>, "gordon.ge" <gordon.ge@bst.ai>,
 linux-kernel@vger.kernel.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 "Ulf Hansson" <ulf.hansson@linaro.org>
Message-Id: <8413fb10-3526-42f8-aae9-382931aed7b2@app.fastmail.com>
In-Reply-To: <20250808083916.959079-1-yangzh0906@thundersoft.com>
References: <05e13ba9-c1fe-450a-a159-9693edce0a23@app.fastmail.com>
 <20250808083916.959079-1-yangzh0906@thundersoft.com>
Subject: Re: [PATCH v2 5/8] mmc: sdhci: add Black Sesame Technologies BST C1200
 controller driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Aug 8, 2025, at 10:39, Albert Yang wrote:
> On Fri, Jul 11, 2025, at 08:55, Arnd Bergmann wrote:
>
> After investigating the approaches you suggested, I need to clarify the
> hardware constraints we face:
>
> The BST C1200 SoC has fundamental hardware limitations:
> - System RAM starts at 0x8.00000000 (above 32-bit addressable range)
> - The eMMC controller's DMA engine is limited to 32-bit addressing
> - The SMMU does not function for address translation in this path due to
>   hardware design flaws
> - These limitations were finalized during silicon design and cannot be
>   modified in software
>
> Regarding your suggestion about programming the bus controller mapping,
> we have thoroughly reviewed the BST C1200 datasheet and confirmed:
> - No accessible registers exist to reprogram the address mapping
> - The 32-bit DMA limitation is a hard constraint of the controller IP
>
> Given these silicon-level constraints, the current bounce buffer approach
> represents the only viable solution to provide eMMC functionality on this
> platform.

Thanks for checking and confirming. I think what you had in v2 is
probably close to what we want then. Please update the comments in
the code that explain the workaround and send it as v3 so we can
have another look.

     Arnd
