Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706061;
	b=G1MVSVkgO0ATky/r1kuCbvP83wgamsJsnfjW1dHvO1gJwRVNhqh0b1vGs9vo/8W8NCS9
	 TO9SkAqGY92RjYKDMOzucQRfmv9Ph6xWrbRQ2zGDTUwFKi0dvhKujfzdOzthi+y8uqnK+
	 jsWUPhImYVrcGbDOxTk1ILPXCH3s6zvBxkcEqPH+bMXCYy3svTrbXAnAOrlwgmaCHCQF8
	 F8QuPNpXzZgUsjvHsPP3c7kKsMTShlsTF6i+Oxke/fYbzTHPEYz7w1OWGB1BYhW7cRSWz
	 enPUkB+sXbzJOHdtc7j4U3pJNAttFHL22LG0Tms8Xy+EvjVaZ0F1fQDNIe6O3yXplvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706061;
	h=DMARC-Filter:Received:DKIM-Signature:Received:MIME-Version:Date:From:
	 To:Cc:Subject:In-Reply-To:References:Message-ID:Content-Type:
	 Content-Transfer-Encoding;
	bh=bONyyJpUFgPkylO2P2hlNIFwAOFn1eJYoMX8uFPSfJY=;
	b=UDykYgjzqVckd3Iul+r6nZkSzFUTjus2QzLDy5EUMvX1vgPK3ClunWVwoopdrpaLe2k8
	 r6K6tv+Pqlunai4J28PE+Ko0nhz+Xpy8gcwqClSEsPekPFPxt18AC+0LrYWlHG+f/I43b
	 hwbF03tkUiEibHoKu5JhGM4daguVGYJ9SN0rxvpA+BDEugIXuN2bC8aIV/JFnTugRz4ZX
	 c6Od6FIZGH82YuNgwNd6byMjKkgVOQT2J7yl/vs82dMqIj7sCgQ2FWlBacpFSt/93Ne2v
	 nDW3OVhjwpe3HG04E2Zin9tj2geYO8t0z2hHW+pwqm/5wjQUn2oFVk4DPvl6E/UmISA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.net;
	spf=pass smtp.mailfrom=posteo.net;
	dkim=pass header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=F8tPpaJS;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB54606A333
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 11:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7DB54606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.net header.i=@posteo.net header.a=rsa-sha256 header.s=1984.8680eb header.b=F8tPpaJS
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id DBFB2240101
	for <linux-mmc@vger.kernel.org>; Tue,  3 Nov 2026 12:40:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.8680eb; t=1793706058;
	bh=bONyyJpUFgPkylO2P2hlNIFwAOFn1eJYoMX8uFPSfJY=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=F8tPpaJS4TIjDIm/1jgb2/3l0fXCVTUv0pEjmumjtHsfgTktbO2bMYo7o8sLZDrJL
	 47dbZqnPLFKkWC8bw2EteT1SHnkVnPF/BIVtviwQ3YZVdZHrBKWK+KloqS7yOk9kX3
	 B6ttjBysSbKNwWznwbD9VvkRG8MpMnpe3Ti+G+9FCq7pD7Kg7yI+1l2968Zw7TmOtF
	 lkbOnmHUwpPN6ePvPJunhq+SlEdxIvlUgic+F5swtoDO6oykjXgx/P+U2RB/0Et1P1
	 1P9/1v6aAtIEoPAuLqOXLGdqaiHKrwOKcmBYbpyzOvVc3BdRegzWK+wumzpDrsxzmK
	 OHwqZtB9Grgiw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4jJmqF4Rj7z9rxB;
	Tue,  3 Nov 2026 12:40:57 +0100 (CET)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 03 Nov 2026 11:40:58 +0000
From: mateusz.nowicki@posteo.net
To: Christophe KERELLO <christophe.kerello@foss.st.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, Linus Walleij <linusw@kernel.org>, Yann Gautier
 <yann.gautier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH 3/3] mmc: mmci: stm32: lock the STM32MP25 delay block
 again before tuning
In-Reply-To: <6d138e10-343f-4fa4-8886-0480e95fe96b@foss.st.com>
References: <20261031120700.42576-1-mateusz.nowicki@posteo.net>
 <20261031120700.42576-4-mateusz.nowicki@posteo.net>
 <6d138e10-343f-4fa4-8886-0480e95fe96b@foss.st.com>
Message-ID: <21a6bcb074c46fbad82d9d913150bdf1@posteo.net>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

Hello Christophe,

> This patch is similar with the one that we have on ST downstream.
> mmc: mmci: stm32: release the delay block before enabling it (Commit 
> 01d3cac)
> 
> If it is the case and if you are going to upstream ST downstream source 
> code,
> do not forget to keep ST signed-off author, please.

You're right, it's the same fix, I just hadn't seen your commit. v2 will
use yours instead of mine, with your authorship and Signed-off-by kept.
I only added a Fixes tag and Cc stable.

Regards,
Mateusz
