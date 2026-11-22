Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.205.8.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368060;
	b=LHsesIgJ5AKDo3G9J1xyBEIIH8jow1FHb/4kccyJ9Ecy/cecXmYatVNWeTKuCphhoOp5
	 f8Kyit1GLxgBrwxzTnB57MRfOFSY7ZdIMYvesDFBqPwuKzQY5X67iK4vIGj9EtpOA7gc8
	 3tJq8b3b7vbJMT3XnaKeloAt1cQvZyKSTw8lKLCf1MKe/pay4eWRUj8njRGZ2gSDPbeqe
	 h+wRxD7eCDuA/wmpDODyajPcDVNwNu9oa0RLCwzUjLQhhTO4qRp4fidm5lFpura68JsvU
	 5GiG9VBcVQhcA8CZdi3C+2PCLpGDfzng4t0cSvRjgLiHKDWU6joKT+JP872pimnqO4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368060;
	h=DMARC-Filter:DKIM-Signature:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Cc:Subject:To:
	 From:References:In-Reply-To;
	bh=xMAMvMSuemtr/dlGWGZZg9TqU0c+ENYkoUNgtIidgTI=;
	b=WpX73jhyNZ2rtQivwRTcs1dP0kccZGd/Mom2MjrmMgW4HqEY4qPZfRr4rsAOSVYkQgmu
	 0M8OH/GRiokqrXW94U6OvDYCMcw+O/I787aQs9d5Ig3RF6JtP/XpS/d3/4CmBlPe7lTTv
	 ua8WuP2gU5sigz77kP1aKskCwlfVSZfeyUSMPvnd4kI1ebcLcHDi+Y7FhtYOaR2ku/dLJ
	 YlH4yBWCV8Fs8n6BboQ+DjYyaSMuwAFmsUCzNObFPBBqaLymn/RJgmMYoVfvLYkiWKXL9
	 meUXQhiDkaSwILNj32XS3NlWCJ0Ml9J2a1k3gi3WhfOUFoUq6xbz80NcXgGiRSkEakA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=matfyz.cz;
	spf=pass smtp.mailfrom=vinatta.cz;
	dkim=pass header.d=vinatta.cz header.i=@vinatta.cz header.a=rsa-sha256 header.s=default header.b=oT1CQ8nR;
	arc=none smtp.remote-ip=37.205.8.231
Received: from vinatta.cz (vinatta.cz [37.205.8.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF90606A681;
	Sun, 22 Nov 2026 17:20:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BF90606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vinatta.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vinatta.cz header.i=@vinatta.cz header.a=rsa-sha256 header.s=default header.b=oT1CQ8nR
DKIM-Signature: a=rsa-sha256; bh=xMAMvMSuemtr/dlGWGZZg9TqU0c+ENYkoUNgtIidgTI=;
 c=relaxed/relaxed; d=vinatta.cz;
 h=Subject:Subject:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@vinatta.cz; s=default; t=1795368011; v=1; x=1795800011;
 b=oT1CQ8nR7khqT7IAnsfEfPfFZmLRzxBzw3BRr3KDj8njwtc36UDqCvlwkgiVV7DK7xi+VUnI
 f11f733vgEG08UJmp4PhxoEBn4cDoPwYiyUToX1f9TZnUYXCQBKWEpDFnQaSJOyqwjXFUiqza4K
 GfeQ3BZGY1zjP1R+sq+NafYPLr8dhZSWpC+OB9AvQF0qL7iagoHFBDKcd+c7UQ4aFu4zRPRlzA4
 Ax/IjgAhfQ2ycv8NgOnSt6OOxT/mLQlXFj3q4C/xwWzpaWUEC9yaxWGZ+xZAiwyrT62SBELTDcL
 gOyv9MG7QQW9wftp73prIAygBuFFx5HVU6eaOrERfWqeg==
Received: by vinatta.cz (envelope-sender <karel@vinatta.cz>) with ESMTPS id
 3a5e5229; Sun, 22 Nov 2026 18:20:11 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Nov 2026 18:20:10 +0100
Message-Id: <DN1WUDUNU9U2.351W1X92P0BJF@matfyz.cz>
Cc: "Brian Norris" <briannorris@chromium.org>, "Johannes Berg"
 <johannes@sipsolutions.net>, "Johannes Berg" <johannes.berg@intel.com>,
 "Francesco Dolcini" <francesco@dolcini.it>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, =?utf-8?q?Duje_Mihanovi=C4=87?=
 <duje@dujemihanovic.xyz>, "Gregory Clement" <gregory.clement@bootlin.com>,
 "Sebastian Hesselbarth" <sebastian.hesselbarth@gmail.com>, "Ulf Hansson"
 <ulf.hansson@linaro.org>, "Frank Li" <Frank.Li@nxp.com>,
 <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-mmc@vger.kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, "Jeff Chen" <jeff.chen_1@nxp.com>, "Peng
 Fan" <peng.fan@nxp.com>, "David Heidelberg" <david@ixit.cz>
Subject: Re: [DONOTAPPLY RFC PATCH v2 0/4] WiFi support for
 samsung,coreprimevelte
To: "Andrew Lunn" <andrew@lunn.ch>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <DEJL1ATTQMVE.120JV9YW59I27@matfyz.cz>
 <aSnWYS2g5slVFaSk@gaggiata.pivistrello.it>
 <DI5L100Q1RKO.1A68EJIPWYSRC@matfyz.cz> <afI8y70U7wFT_07h@google.com>
 <DLQ9LXDE2P29.248MPYCJMT0DL@matfyz.cz>
 <787950f1-ff2f-4b49-b164-61da3c9971c6@ixit.cz>
 <20374af8-2f50-4637-b92a-4fa5c5192c20@lunn.ch>
In-Reply-To: <20374af8-2f50-4637-b92a-4fa5c5192c20@lunn.ch>

Andrew Lunn, 2026-11-20T20:55:49+01:00:
> Why even bother, if it has no users?

I and a few others working on the phone/SoC use it and I'm sure that
others who have the hardware lying around would appreciate being able to
use it with a mainline kernel too.

> We have to look at it from the perspective of Maintenance. If it gets
> merged, you have to expect a hoard of LLM script kids descending on it
> and submitting patch after patch fixing theoretical problems. Is
> reviewing and merging such patches a good use of time for a driver
> with no mainstream users?

I don't see why this change should trigger any such patch avalanche =E2=80=
=93
the driver is already in-tree, all I want to do right now is to enable
it for an additional chip ID.

> Does openwrt support it?

Not that I was able to find.

Thank you for having a look,
Karel
