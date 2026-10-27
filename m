Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102035;
	b=XRXz8h6V/nzjgZwWWzBYLR5GCaKBdfHRZ+m3b3zaYgjno4ECK/TZiGnD9eXtbz/AjGPg
	 Sid0Omu9L5OM31ioUmz2VLO9nwB2+/RHMUiIukna055g5LjNYmDqySYQROavYyQ67Hs4U
	 arChRvW5v3cE6/Xx6I0XURj7Rscl5OT7wkJeLAqpCZJSZ+zdmRBUuA6G5q2dFvJcX7TNI
	 9o6+5uecyQtPN1I+hIpfJVh72x2JtmFafx5C39Fs1EiklHo0+DGVqI2lMjeDrS4l/MAen
	 t1vQuCH3MSLDOCSuuY31O8zxtcoUSfsq6bwDZBjsu7Gmlbi3pwbh1p59jwADwJEkl6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102035;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Hg2rJTq4dugLpsyQtR4635UwYsbDjZzt3P2CYzIqr7c=;
	b=STVvG1melz4llu481/QuqJludXlZSwLARrHjIWL82hIhJMQBClSA73EbqvCxjtdYo2+z
	 c+SS215XOa/h7JA0wdPyyZGCxAVDSxXipf4yks5jy0gPU2KaEQzW453Tyiebskac+vEy1
	 gVTzLf8upfgOfSEbBVqNO8DjZ0Kso/HTY8JbDc17AzVoH6O9vPx5Uppdap4IDQpKtNq7L
	 fZZSBK9y//e68Y3SAXxhA2q8PB73rVSdHo2eZbKzeymMnn5RoAzmjyvSh7MYWiJpdS2Kb
	 Z6AzRoa0FtQiiLHbdBNS2HxzPPVQMQYutbDjtIw1ycmMOZJMW/qdxk7pnfIVwnNgN7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nKkrKhR4;
	arc=none smtp.remote-ip=95.215.58.207
Received: from mta1.migadu.com (out-207.mta1.migadu.com [95.215.58.207])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E12606A31B
	for <linux-mmc@vger.kernel.org>; Tue, 27 Oct 2026 11:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5E12606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nKkrKhR4
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=rbVRWtd1a19ORZE1+XzRUlmNZZKKanCQY2cJK+FiJ+Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793102031; v=1; x=1793706831;
 b=nKkrKhR44tamPEk3vYXQqK4zfjfTUWxU/VsSuW+khk1vlO3qKbqBpParsXDp1erbG2QRT8Mr
 VOW+l7x/YpGZVSh/wyPiYidgcnBQqB9OEWvwCIe4vGtMFDFIEEv0O9A1/1QgL8Zlx9HLvQVBwfl
 q2w3XbzDiPLmEUyv9qHreHmE=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 6b00a2675eea1804;
	Tue, 27 Oct 2026 11:53:51 +0000
X-Mizu-Trace-ID: 6b00a2675eea1804
X-Migadu-Flow: FLOW_OUT
Message-ID: <6e59ac7e-0186-477d-8166-083dd2987aa4@linux.dev>
Date: Tue, 27 Oct 2026 19:53:41 +0800
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@linux.dev, =?UTF-8?B?5p6X5rab77yI57O757uf77yJ?=
 <shawn.lin@rock-chips.com>, Ulf Hansson <ulfh@kernel.org>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Jensen Huang <jensenhuang@friendlyarm.com>
Subject: Re: [PATCH 2/2] mmc: core: sdio: skip CMD11 if signalling is already
 1.8V
To: "Deomid \"rojer\" Ryabkov" <rojer@rojer.me>,
 "llj@rock-chips.com" <llj@rock-chips.com>
References: <20261023232813.2983368-1-rojer@rojer.me>
 <20261023232813.2983368-3-rojer@rojer.me>
 <4e8bbb32-e062-40fe-8ee4-363e83a68f2b@rock-chips.com>
 <46a26683-9d8e-451b-bc98-505b1c13b09f@rock-chips.com>
 <202610261435018282601@rock-chips.com>
 <CABFmFwr0JozEeaDd4KErDzh+DWjkjkVRo6z61OxHG6BE=L_hKg@mail.gmail.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <CABFmFwr0JozEeaDd4KErDzh+DWjkjkVRo6z61OxHG6BE=L_hKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Deomid

在 2026/10/27 星期二 19:00, Deomid "rojer" Ryabkov 写道:
> On Mon, 26 Oct 2026 at 08:35, llj@rock-chips.com <llj@rock-chips.com> wrote:
>> With this patch, swt6621s can skip CMD11 and successfully
>> enable UHS mode.
>>
>> Tested-by: Longjian Lin <llj@rock-chips.com>
> 
> thanks for testing, Longjian! so in your case it's even worse: without
> the patch doesn't come up at all. good to know that now it does.
> note that your reply didn't reach the list (vger drops HTML-only
> mail). i'm quoting it here for but if you can, please re-send it in
> plain text again, with full context.
> 
> Shawn, thanks for the reviews! you're right about the soft-reset vs
> power cycle: card is soft-reset, not power-cycled.

Just to mention that vqmmc is optional, so if not vqmmc-supply in DT,
the voltage is hardwired to 1.8V, then this patch doesn't help.

I'm inclined to add vqmmc dependency to the commit msg of this patch as
well. What's your opinion?


> 
> Ulf, if there are no other comments, please s/power-cycle the
> card/reset the card/ in 1/2 when applying. sounds like we're
> converging on 2a, so the alt patch can be dropped. or, if you prefer a
> single cleaned up patch set, please let me know.
> 

