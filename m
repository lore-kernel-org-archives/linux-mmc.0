Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F250026CE0F;
	Thu, 25 Sep 2025 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807549; cv=none; b=FSAdajRn6I+agPDufYjJcGReinwzlBY2Mg27gvoWmU4lQZQGhistB2uhvObRY3IPbZeR4iR36o8eLxX/V0p9Q8SQVSG9Zts0tO/My44006chcLnfSzMIFKEtOIuiFcKUDtQZ1SoFI8fH+dl7+6gjMOAoh5rSoD/LaNiIaxsF/qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807549; c=relaxed/simple;
	bh=l9noDZmS+h5Akb+RjBpEJrg20lrX30Rh2R6I7mjXR/8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rPwDDMTTMaiyFy404gj70m6RHvEUuuFqnA3mTo4ZBQ+6wQ6MW/oELZK9zakUnX9XNFsN8j/UtmjP6W01AZ3mFxie8+Lsv0mFz6FXJeylqiRuA3er/NmcmT3c91B5FeqyeQZMLvePMU/0yTYV2T9Sf66ujycjQZNIpKSicOXL6XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Yga0bisA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SLCZyK/W; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Yga0bisA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SLCZyK/W"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id F1365EC01C9;
	Thu, 25 Sep 2025 09:39:05 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Thu, 25 Sep 2025 09:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758807545;
	 x=1758893945; bh=ZP6i8t6VjyohhnaOw+R5p+q7sTs7Hkp2pGWlk4LB/z0=; b=
	Yga0bisAcqKTV0DnIf+ALNVaHGED9hccLWEpVcu1AS2ugQrXux+JA34d+GEbwyXx
	e1FF0+O80vgwnO1ne8rdph8It6i84gUkARzZip9XgVMLc71RtQMA4wXJtW7w4JSu
	xfQfTt7AmtsdAOVuYNusA/41h2FeDK2+dOSS0qUiliUaAJUOB13CWyvxCH/wWWMQ
	iAuYirlk7aD3gyuTEJeKhbPXgaSS08grLJPvb94j9DcstOCoRVhWSAXJl9VGVuP5
	C0z8eTH5I4m6zXWUkNFI9lMlVUVIMkuV2nktR269Zk3NtdV6VQ+c7F7E3C0SKXKg
	TuNZ6PgokfHTn3+f1bTJQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758807545; x=
	1758893945; bh=ZP6i8t6VjyohhnaOw+R5p+q7sTs7Hkp2pGWlk4LB/z0=; b=S
	LCZyK/WT4E/AJqkEn4I4YpM3gmtkrGKSMOjemO5DGw0dS4DogzqSSjqto2aMHMpR
	wxUYOoTA8WID/3kdzBpXjaQnfpnyY7XgqLMM0saOJUcdjGCQE3807d7McA9iLy9Z
	okhcLBhPp7+ibK8m6kYp3xbfXzN9EGSc5MFyM43ORS+YUaSaJpVdV0Oq9TFNTKcP
	cWwUTPMgxTMKp2GOJ+Xj71wxH4ud2RC1KPocZwQJogiZcAVPUmT7J+wO5wO3cYmn
	d7WBwyG9R74WaI80m86f1ZYTfllRUQ7iu7kkfzcs1L9zzRlvxIA173SmD3dGOdjC
	bEMa2uPMgyMDuPlgWi5ZQ==
X-ME-Sender: <xms:-EXVaFl1peFBt9BoXygc2Q9r-wWTKxr5LzzwlJgArNIGdcACKp-2mQ>
    <xme:-EXVaLrAe_LPjNZ12OohpAcXUeOrXAnHR-81spEbJf5SpKs011LLasvgsMa8VUxFx
    j2lnOBq0do6AlL5CL7iJp380yyg7zO99ls4xSuWLkWl2Oc9LYdKS24>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiieeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpefhtdfhvddtfeehudekteeggffghfejgeegteefgffgvedugeduveelvdekhfdvieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtph
    htthhopehgohhrughonhdrghgvsegsshhtrdgrihdprhgtphhtthhopegsshhtqdhuphhs
    thhrvggrmhessghsthgrihdrthhophdprhgtphhtthhopegrughrihgrnhdrhhhunhhtvg
    hrsehinhhtvghlrdgtohhmpdhrtghpthhtoheptghonhhorhdoughtsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehrohgshheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhlsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehlih
    hnrghrohdrohhrgh
X-ME-Proxy: <xmx:-EXVaKcqt-fv8lOleOx8L8kijJDVWj7-P23o48SsNRvckojD-eQdzw>
    <xmx:-EXVaLwC1bOigfMDX-tFoRmlBM74SFARXzeAqG86RqlIDGh71P_hHA>
    <xmx:-EXVaLIcIpoRWcV4NKcNP5fBP6qfFJmG9of8HUkN1I7UU9i2YVjKww>
    <xmx:-EXVaEuDGcpXdm5BN4EAXo4c4CRynPUdv6uXY39MKc2saKqSfkRcNg>
    <xmx:-UXVaJ-JhawVLmBEvgcMBDrywJHyP5BoJ5x4etVHw-smF0Ja35YcNudd>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8EB47700069; Thu, 25 Sep 2025 09:39:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AYQZGcjF-1nJ
Date: Thu, 25 Sep 2025 15:38:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ulf Hansson" <ulf.hansson@linaro.org>,
 "yangzh0906@thundersoft.com" <yangzh0906@thundersoft.com>
Cc: "Adrian Hunter" <adrian.hunter@intel.com>,
 bst-upstream <bst-upstream@bstai.top>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Conor Dooley" <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 "gordon.ge" <gordon.ge@bst.ai>, krzk+dt@kernel.org,
 "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 "Rob Herring" <robh@kernel.org>, "Will Deacon" <will@kernel.org>
Message-Id: <f64b0e00-1c30-47a1-b6b0-1bc28cc7f8ac@app.fastmail.com>
In-Reply-To: 
 <CAPDyKFp3onTDGgygvOrK-G40w4mSx4S5=PbdZ+26hsQ+nPVRSA@mail.gmail.com>
References: <20250925090412.2068216-1-yangzh0906@thundersoft.com>
 <20250925121155.2401934-1-yangzh0906@thundersoft.com>
 <CAPDyKFp3onTDGgygvOrK-G40w4mSx4S5=PbdZ+26hsQ+nPVRSA@mail.gmail.com>
Subject: Re: [PATCH 0/9] arm64: introduce Black Sesame Technologies C1200 SoC and
 CDCU1.0 board
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 25, 2025, at 15:34, Ulf Hansson wrote:
> On Thu, 25 Sept 2025 at 14:12, Albert Yang <yangzh0906@thundersoft.com> wrote:
>> On Thu, Sep 25, 2025 at 05:03:57PM +0800, Albert Yang wrote:
>> Subject: Re: [PATCH] splitting SoC and MMC parts
>>
>> Hi Arnd,
>>
>> I may have missed an important detail in my previous note. If I split
>> out the MMC-related patches and submit only the SoC parts first, I
>> cannot validate the SoC on real hardware: both the kernel and the root
>> filesystem live on the MMC device. Without the MMC stack (DT bindings
>> and the controller driver), the board does not boot to userspace, so I
>> cannot properly verify the SoC/DT changes in isolation.
>
> At least to me, I would not consider that a problem. As long as you
> can test the pieces together "manually" that's fine, I think.
>
> I mean, the platform was not supported in the first place, so it's not
> like we would be introducing a regression - or break something, right?

Agreed, it's rare for newly added platforms to immediately have
everything working, and we can still fix things if they don't.

It's also possible to test userspace by using a standalone
initramfs with a login shell or an automated test suite, but
I don't require that.

     Arnd
