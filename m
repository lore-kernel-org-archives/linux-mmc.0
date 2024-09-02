Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1666D187349;
	Mon,  2 Sep 2024 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725290115; cv=none; b=Ni+IBs4NQHGsL804tjgjtdGIMSKsA3MOs3v/H9VqGtOhyGhXEuDkEgjouOcpsiqjKTTS/gxZd/HFQq7muyi1qcYrwvXBG0kmDkxoq3HFg/qSBLAAF6PAdwvEmuPOOj0/vhh0MNi9z9ArkBN6LrWoRgvnUGBJJsSMsCqcS7qB67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725290115; c=relaxed/simple;
	bh=ko8YArlYJbtgYttL+4VV/JINclmFZ48AwksEMzPXfdc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=dASx/X0gjgPIs01SMJj1IoL2esGIxpsL2TRD2IFj0Slymrx+6yKNyGiyRmQEOEnDcS+SxFB8P/W2mv+sVxXwZAVL+GTTzTOIP9mX3Sl0peusyl2PHdeTMJotm580L6F7DojAkGtSzLSa/rVGz0YmDo8eUUnhZKaTNiclMh7iBSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=RBVGzegn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s3M83ssS; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="RBVGzegn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s3M83ssS"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3C3D913802AA;
	Mon,  2 Sep 2024 11:15:12 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Mon, 02 Sep 2024 11:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1725290112;
	 x=1725376512; bh=CFAfsh+V4MUCXkYtVwNLqeCLzWM8HdsL2CF0HjftE9g=; b=
	RBVGzegnaATczaX4+Nrc6TFXptUJDyhHtcWxyZ3c+wFAHoI+AMxNF7D8RsZkoq23
	0m0AB2PZ1rgXW59/fXqHiGsas3pUuDGjVu6yCHdDCu5cQdJ+0Uh/Lrh/ewakXbOf
	xRa6jw6jvF194FjX0ZidGpQMWQbWaUk05QAQ+PJBzvKydcTql656N0Kw7JdAtTGn
	n/G3NE3PfK6h4J3CSWXpvg19fjideMBTnQco8KVMLO0sa7YBKSiTdwtMjxKGsG0T
	xOpZsbsk86XZZUs+kU32tmHhckaLRPqqMrW/OpdI8rGA35Zvu5FktV6/9WmHLXuY
	0KJB3lsJiicwUN1Q587GyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725290112; x=
	1725376512; bh=CFAfsh+V4MUCXkYtVwNLqeCLzWM8HdsL2CF0HjftE9g=; b=s
	3M83ssSoJm55aHii+VJj6EqGVfQbVKEAmsjEmeW68mZ4YPflyJHnMXj3LPAwUYj4
	b4n9JQn95zZHRuKiICY7HKgmKrj4RCcSmmW9twlV28smWY1JT95AZM5cXOInKSDl
	n8mlOa6pTef4InWxo71HeeBsjMmqTJrLA2QWBkwUkhznLh4m0ssjOCAGbT4Gdv3Q
	/QuK3/lSP+Bp1YBnvq6Vp3yXqTLDYid4NehQ9k8NjeiSDK9JNWXVoUlMCK8+Bj+7
	/a5kFr+/M+xTzYCQLF64syiH1KKubkA3jXFpSiB//KlgtW7kqLtM0nz7xj4x9irJ
	8n6NBI3efzHl/NJfYh45g==
X-ME-Sender: <xms:f9bVZkgkESYYsBtzOjDOhovOv2QK2AfYKFrv_P4t7nDMEd-RPHkKZw>
    <xme:f9bVZtA-O8aLMPY4_dpPEIioGxhIPCmCcwPQtWuXqe8qQ7ZlV2cbrM1dHbnINfy8p
    OXVC0f0QIRnY8Tg7dU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehfedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeek
    keelffejteevvdeghffhiefhnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghr
    nhgusgdruggvpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohepjhgvnhhsrdifihhklhgr
    nhguvghrsehlihhnrghrohdrohhrghdprhgtphhtthhopehlihhnuhhsrdifrghllhgvih
    hjsehlihhnrghrohdrohhrghdprhgtphhtthhopehsuhhmihhtrdhgrghrgheslhhinhgr
    rhhordhorhhgpdhrtghpthhtohepuhhlfhdrhhgrnhhsshhonheslhhinhgrrhhordhorh
    hgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhg
    pdhrtghpthhtohepohhpqdhtvggvsehlihhsthhsrdhtrhhushhtvggufhhirhhmfigrrh
    gvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhmtgesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:f9bVZsH2yOCfrTX8ThVnRUi7aZefxvs_wsta-te2EzLQGYBlVO2JJQ>
    <xmx:f9bVZlTiEWDJkzN1h6uLnXFBJFS3pNZnTagfakDOZSaiBptyp600TA>
    <xmx:f9bVZhyaqLLXCzGBzO48sZgvvCQVrJyKwwPjb-gM5vjDwHhxJIMECg>
    <xmx:f9bVZj5i9WYih9_wOZbbzK6X9uaRV9zsqzYivsDdP9xbla1kjrUJLg>
    <xmx:gNbVZokRFwxOQDSm6kn48qV2U-6pqLT6Hf5B-RZiMI7eR9Bd7uRPaVWN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id AFF402220083; Mon,  2 Sep 2024 11:15:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 02 Sep 2024 15:14:50 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jens Wiklander" <jens.wiklander@linaro.org>,
 linux-kernel@vger.kernel.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 op-tee@lists.trustedfirmware.org
Cc: "Ulf Hansson" <ulf.hansson@linaro.org>,
 "Sumit Garg" <sumit.garg@linaro.org>,
 "Linus Walleij" <linus.walleij@linaro.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "kernel test robot" <lkp@intel.com>
Message-Id: <75d9c06f-5af3-4088-8813-b4a3ccb59434@app.fastmail.com>
In-Reply-To: <20240902151231.3705204-1-jens.wiklander@linaro.org>
References: <20240902151231.3705204-1-jens.wiklander@linaro.org>
Subject: Re: [PATCH 1/2] mmc: block: add RPMB dependency
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Sep 2, 2024, at 15:12, Jens Wiklander wrote:
> Prevent build error when CONFIG_RPMB=m and CONFIG_MMC_BLOCK=y by adding
> a dependency to CONFIG_RPMB for CONFIG_MMC_BLOCK block so the RPMB
> subsystem always is reachable if configured. This means that
> CONFIG_MMC_BLOCK automatically becomes compiled as a module if
> CONFIG_RPMB is compiled as a module. If CONFIG_RPMB isn't configured or
> is configured as built-in, CONFIG_MMC_BLOCK will remain unchanged.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202409021448.RSvcBPzt-lkp@intel.com/
> Fixes: 7852028a35f0 ("mmc: block: register RPMB partition with the RPMB 
> subsystem")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
