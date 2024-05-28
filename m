Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA0C1DFDE;
	Tue, 28 May 2024 14:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905751; cv=none; b=K1NX1Z4cshI6SYtgwCC+0Pu/xSRMnLxROSV7PuOctRCgCWYU5u8ILi2W7b8B3KicjSr4vbcedL3c/3efkINCJOsCVkzLhvrLzCO079fIOsrPKCAnWJfD0HWNS5cifG/UTRKOpRsCAsrmbkZMfDGFZ+iSf5YXHiIpUg3wzRr2Tw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905751; c=relaxed/simple;
	bh=ZpiZtSugjss1IH3bHnUrUBBvCJmQBU7qym1W53Fl558=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q2vxcP0Cko7IS8GUz/t6gPHM/wi87sQ02DNrvWHDVBm4fIguKL6TWxRSgugOnUrPbyESO0OOj/7dgdnnCqlJJZKcUqGCYDfOod/H6IlexF9dRdwOQa8VM1krPeqp1itVZAQ/VxpNh8pyIQZCwfZE3fKEZZg0MDantyt91v2/F+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=tFa4qhqM; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="tFa4qhqM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1716905728; x=1717510528; i=wahrenst@gmx.net;
	bh=ZpiZtSugjss1IH3bHnUrUBBvCJmQBU7qym1W53Fl558=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=tFa4qhqMy2dC8+csEejmBW6eRUibSI1973H/nMfE9r1vp28c5gwjMbOeBN55rv8n
	 gjSpKMdY2Sq27+7ziQzTr9FnW4Pz6Dh8bjk/WTkz3IzzOU+e924tLtIU/NOqc+xHX
	 ydpo7baZVEJ6G+sgM/vDDhzpVOrO64dx5IBTeNMPLMuiqD51NDOxSuFEHo3lTPktD
	 mXAi0LOdphM6XpTSVB31tT/Vu7scvF9nHBrgdjQ9bw1Lz7wIUsKg/VAv8C3Cl/dpT
	 zYN9JFGDENUscoKXR1n8d/BlADD99Y7y5/2DwsijDrI7u79YQEktFGZZSUc8EGUyI
	 2/KHuqPN7EqN33rJIQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GQs-1sXjjU2jgW-014E1j; Tue, 28
 May 2024 16:15:28 +0200
Message-ID: <17b76f79-2e83-4957-b240-b7bd5997d508@gmx.net>
Date: Tue, 28 May 2024 16:15:24 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: mmc: Add support for BCM2712 SD host
 controller
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <cover.1716899600.git.andrea.porta@suse.com>
 <0f263886c0622f43d3a2f4cccaebae0c39ba1bc5.1716899600.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <0f263886c0622f43d3a2f4cccaebae0c39ba1bc5.1716899600.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:oLe0wtPQqWitqt+Z78DgjMVIuWzRxkC8b/uPq2RlmctB2GmVo+m
 fokurLJQK9muVnCajS8yd56oa/exYtzDrQDLLHONd/DMdjh7KHZQfX4ihRBw4We6ds9A5ov
 SIXFeTTqi8mtlbvE+C1hf1GUffX5+8gC7vJfKM57UbYjRzaB49OuQJ7ErV2R9S132MMSRCB
 wNHnlrzu6LKG2myLr9aqA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:u8vm6Rexr5o=;HMwPB9aKOPZ9rWvv8T3eN5y/yfb
 lFF9q4+FhcH0wzpZuDVCTulLM65QXh6xik1UJYEnlO1rM51Nf6LpF/saN6faiHC1UIS1aA9wI
 yHa8J7m4L6R9LldlqtHSiD+aDjRGGppPIPdpxhrHl7yl5oTbVd0MVACV9sL36bxPzUIviHkrc
 fFPykiwMFnWmxCdlIZjs3XO0J2HRiSIRFQ1UD3kOE0UDSLceryeqacQ3pRF1b9hcq322iwOoI
 XkulbRrsan1rKmoxpYoLgVFrqKUEQmdwfRXCvyIzj1QhcRQhwC0uUmMLFwfqZ+J7LChhAyYCL
 ugJVGHGwWgWTVPmsFTzunOfAFtCIEVwnUwyxFfMz/beYj2TO3PuUJMiAxe2azJqj7qZroW6RB
 Yn865s8lCxiesMUZd3aAeecpXR/xqPppODvn3KvFrgmBIn60JZoof543UUJdDDCgMSWv/n9Af
 wPcLP8i+zMQtK0ivI0g5W5jTNWkioFxwuvezyWkDAGJgmkjS7QDsk8yFG798S8R47PAXP9mut
 +iDonoK9wzRCDsydJ9UPQCfaeKtqiHk/AVYKUGPSTjKm/5plrz5lxCpppBEGvnTvmqJkfbX4W
 txwNs+uroED/CEzFqTTtlv4lQ6RTVZD4WU5u+gpEjGr/N1r5wK84RB4xLylxANOsb4UgkEiFE
 80NkXzSbJJAsaR08EielTxaVY76FOwR/1gel7LYtDOE21w4elgiDi1/5PLM4LM3a+3YCAGBAy
 t56x5Wr8C1v9v3oG1tnxgSz2M+DlXZyTpwRVhZL+WJkEXwsWBN5/2pOVimnRsKHoyROHQ1bJx
 DrhTCt/+inuJvEZVZRSXudFcfrrW2MPl6x3xK3ByCzbZE=

Am 28.05.24 um 15:32 schrieb Andrea della Porta:
> The BCM2712 has an SDHCI capable host interface similar to the one found
> in other STB chipsets. Add the relevant compatible string.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
