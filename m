Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76B5189;
	Mon, 18 Aug 2025 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755518925; cv=none; b=SXePj0vC8MB4aMgvKDUUca1GzhgRVTcGvybx4dOa5+Yo/fHETBaHIc1SvmxJHuczkzY0wY08YoXQRmGQWx4RypwhivU6qh5uQzpqjN6tjaEbcdO36Asgx7vJWe5YnwawDreLcYzQdcZnyBx3fvWCokGVgX05Ytx92VhQR1wgCuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755518925; c=relaxed/simple;
	bh=bh6OIfO4EELLg333GBIihIzx8g8wZEEARzEm1lA1wgA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GcnTPGJC44wviaev5x/0RPefkTUD9U5cizGOKm6OnJesHPuEjS7lHAEkOkYt7M9b1pCyUYTX3r2qnSOjfhD/pb7UKRuSDGcj5jKZTyExeUCyKKr8u+9IURZsg1hdvngwpsnr2zS2oUCXpLdHrGlmQ4pudW8V/5D/WBWjbDNPoXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PZFmpJE1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QlsHi7Pm; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PZFmpJE1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QlsHi7Pm"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0BFA61400177;
	Mon, 18 Aug 2025 08:08:43 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 18 Aug 2025 08:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755518923;
	 x=1755605323; bh=xQdgyGA5COaCrzWAChLbDJ+k+lzLu0z9z0SAOXUT6IU=; b=
	PZFmpJE1SIC0ikjX2oHaqNM6DnBCadXASQTuhYXCsK+w7Y5zL8DAAQR6ob3dDUqe
	jwLZnpxKI6/IibAOqlxOoGneXquxM0rCvsL+CaaJhGSeb465FVt7EC4Jz6N8bTjh
	atf3fbws0BCfEqZJ4nQGhOZSmDGKZ98PThJ7u65IraJQIsA0RsnuJXhGxQBXsee5
	AShi0wFgrQYfo2OkZpMXJ+Tnz1693FY8rIkQxWh41pEaPzcy8/5aTAXRUqIrz8nI
	gnps6evmvxVP8d12IchRmVa2m5XGkGn5Ilm171BSI1QaTlfC7BaiWnOmmQIz89DG
	uvzNw7vsaevQAabV7cgyLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755518923; x=
	1755605323; bh=xQdgyGA5COaCrzWAChLbDJ+k+lzLu0z9z0SAOXUT6IU=; b=Q
	lsHi7Pm1rZLZHQJtksrghMt0VUT9jNPcm3xovM5rJ/CCW7qxyh9loEB/g8EO6Ajp
	8TRXN6BIWUjvtzN0isKS+bO4l0fdXqQWA2csTPSuwbRIIwKPYiYUNvHg2IEcQbEo
	XdwwRqUZ66MCPb5WIvvSPUP1/GOaoqHWVwtg2JfkioPnqNSKxeu2/uOh368n9+GQ
	YGycwqlzmA8c+c74gCW7DPHY1Stb6FHkmi5D5IVbxDiEtTxPbY9KuN0NEQgHx4oS
	GgdlZr9hcpksMzjDaB/BJWvGV1e/c83HkAR915BdEEYnobWKsTRSToeyPB+eyPzK
	url7v9zbKtder0cz6B0lg==
X-ME-Sender: <xms:yRejaCqIZ3AGCURGRIlytMnCHfErMm7O_syE0cyNe-2YuKo50f-OCA>
    <xme:yRejaArSGBva9y0cZZZ4lTFsL4VtQI3dW-1yB_FTQHtmWAA7rOJJBSjlSK7rCmUob
    MtBeHreYZw0lPd1dpE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduhedvheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudekpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopegtrghtrghlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtg
    hpthhtoheprhhosghinhdrmhhurhhphhihsegrrhhmrdgtohhmpdhrtghpthhtohepughi
    nhhgrdifrghnghessghsthdrrghipdhrtghpthhtohepghhorhguohhnrdhgvgessghsth
    drrghipdhrtghpthhtohepsghsthdquhhpshhtrhgvrghmsegsshhtrghirdhtohhppdhr
    tghpthhtoheprggurhhirghnrdhhuhhnthgvrhesihhnthgvlhdrtghomhdprhgtphhtth
    hopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihkodgu
    theskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhriihksehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yRejaF6BKJ9KbL9B2ut29tSL58MeD3qPX_I_sQ3FXIg2oS7mws-kbw>
    <xmx:yRejaJeSxwQ2DaDjOy7Yp2mOZ20MbZ9bT8d1Lu-05voCl9vG9NIl_A>
    <xmx:yRejaOJxxIDgpIHsMGO_c8hSSz_LiLB1-QwXCuyLAcPu5gbq73CdNg>
    <xmx:yRejaHnbPPwLJ82TxrvKEU3-LqT0cm8Cpn8rPVdHvfWRuTILLcW2sw>
    <xmx:yxejaDqi-zXF_mMXhoi3J-UJkoYExW_yqvxdzr2z3myvYYWDiKMWXgo9>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1E17D700068; Mon, 18 Aug 2025 08:08:41 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AXmPW4ZJGxVF
Date: Mon, 18 Aug 2025 14:08:20 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ulf Hansson" <ulf.hansson@linaro.org>,
 "yangzh0906@thundersoft.com" <yangzh0906@thundersoft.com>
Cc: "Krzysztof Kozlowski" <krzk@kernel.org>, "Rob Herring" <robh@kernel.org>,
 krzk+dt@kernel.org, "Conor Dooley" <conor+dt@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "Robin Murphy" <robin.murphy@arm.com>, ding.wang@bst.ai,
 "gordon.ge" <gordon.ge@bst.ai>, bst-upstream <bst-upstream@bstai.top>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 soc@lists.linux.dev, linux-kernel@vger.kernel.org
Message-Id: <689f58fe-6339-4a3e-9aad-175bff7681f8@app.fastmail.com>
In-Reply-To: 
 <CAPDyKFon7Q2UHOJbbVtPTHvqxYeOJr8HK5BOk6TAJaph8FcwvQ@mail.gmail.com>
References: <20250812123110.2090460-1-yangzh0906@thundersoft.com>
 <20250812123110.2090460-6-yangzh0906@thundersoft.com>
 <CAPDyKFon7Q2UHOJbbVtPTHvqxYeOJr8HK5BOk6TAJaph8FcwvQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/8] mmc: sdhci: add Black Sesame Technologies BST C1200
 controller driver
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Aug 18, 2025, at 12:48, Ulf Hansson wrote:
> On Tue, 12 Aug 2025 at 14:31, Albert Yang <yangzh0906@thundersoft.com> wrote:

>> +       /*
>> +        * Silicon constraints for BST C1200:
>> +        * - System RAM base is 0x800000000 (above 32-bit addressable range)
>> +        * - The eMMC controller DMA engine is limited to 32-bit addressing
>> +        * - SMMU cannot be used on this path due to hardware design flaws
>> +        * - These are fixed in silicon and cannot be changed in software
>> +        *
>> +        * Bus/controller mapping:
>> +        * - No registers are available to reprogram the address mapping
>> +        * - The 32-bit DMA limit is a hard constraint of the controller IP
>> +        *
>> +        * Given these constraints, an SRAM-based bounce buffer in the 32-bit
>> +        * address space is required to enable eMMC DMA on this platform.
>> +        */
>> +       err = bst_sdhci_reallocate_bounce_buffer(host);
>> +       if (err) {
>> +               dev_err(&pdev->dev, "Failed to allocate bounce buffer: %d\n", err);
>> +               goto err_remove_host;
>> +       }
>
> FYI, I will be awaiting a confirmation from Arnd to be with the above
> hack, before I queue this up.

The explanations here are clear enough to me,

Acked-by: Arnd Bergmann <arnd@arndb.de>
