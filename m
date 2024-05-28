Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DB6140E37;
	Tue, 28 May 2024 14:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716905820; cv=none; b=RdPDWJkrnKLsHietHQsGeyWWl+4VOUGxhfHxeApCUUvmhDgJrGsmzR4/ec+gDSJeE1Jk2bxCSveYd92L6Ps1OgiNGiKtqEZUxaPHxg4u6G7sTqbq6ee4C+msguzhyqgvox0TGmXNOzuWljyWbj88S+gexBAXsW7fShiqQbVjzH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716905820; c=relaxed/simple;
	bh=nnq1HNup0g0KUjYWTDaNiDizX9ovR2foxA+ZttZXqp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Q65FJ02hqskJhXZHqRqZs8GFeMNfba9NkY3Tkqrzvv2dix+1ihrBjffPKI80teg1rjgUSUiwGWfR31AuzJQMtn0NF2rxF0C2Qzoxv0D5UihA1xwH9bztk6q5E2QwdlyeUmvWHeSvgmPiJRJ3e9AF9HSf70+WKcbh0DgCedX+hoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=riv68m70; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="riv68m70"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1716905801; x=1717510601; i=wahrenst@gmx.net;
	bh=nnq1HNup0g0KUjYWTDaNiDizX9ovR2foxA+ZttZXqp8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=riv68m70zSzcz5IxJgvPP3NgFTYWoEnZI5gJsU/lo57OMQ/TPoa4hF6SOrq6elWY
	 aNOayLfsq44OSuWmquct3/iotf45XQ+lEXue9Y8WepUwuSag1MN2qm0mwH4KWHN2f
	 sUKNubTmvdFJ3uiWlpEqm9R9Ur5MDx0+XbDaSMDE02J7oLVirajPaZOjhlMz+m0Mb
	 Ys2K1S17PsQIpVDDgCsL4p6/fP6k2oHck8HVA7W4r6uF7TrOZJ7Sq6UvGlWY1A185
	 dZj+aoWQA8ZGaxu6OcYpVN/LlJ/m6rKEDFMGj4+5jBQTZYdtqPGsSRF/q4E+HEGWT
	 Uu7m6SSbw7PI75iJ+w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1My32L-1sQLaQ2pLD-00zaby; Tue, 28
 May 2024 16:16:41 +0200
Message-ID: <cad7b5c5-3a18-44ba-a377-f7aed1eba0e9@gmx.net>
Date: Tue, 28 May 2024 16:16:40 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] mmc: sdhci-brcmstb: Add BCM2712 support
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
 <4e8fc54e87447bae7db58636a1c87e5d8baeb012.1716899600.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <4e8fc54e87447bae7db58636a1c87e5d8baeb012.1716899600.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:etJIBGHhBTcuA5xOTz9exBNpjUjaiNcilgxin9SPEWrTzJKVZib
 aP6VLSOxVwQYtO7ErY3bEmP6KphaXtFmG15AFYTywpPChW8hSbQDKUMZ2Bx6n16nKCs28C+
 5be5ftC3L40tZe6YT2WJzYswi2HYYjITFfJIrR/3eYiFPXh/I3kYetzE4GMXFMCos3Hm5sn
 Ymc0rB7gfSyA5f497lc9g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:npDpGTgrOeA=;weWOGvnzbKBV6LhR00Ym/FnVcbl
 TRGWIKc3h0f+AiCtdJ9VWUSR1xTT6pigWSX3m6FB4Olq5j+CVxBqC0g5fVJdt8b7wLMcJj66Q
 c389FR5qyn7tFgP/DEBTd0Tz2MN8TPMHGgxQs1Fs1hIFFs8yrhBx9zKnkTPa3VXQQ6qdv7xkY
 kyt5SapW7Sv0DSeLHHx/iWhiGfWwuvn5QLYO/ooT7rofhV4G1QbnerpjottriWl3GvbYfmJck
 6GmwRhff/M4PwccIwFQsHu8ASsGicswNBjFri7aCDaJPcEhKYjp2332wLyu5ajDJY/qrgGt0u
 Fff+SSi3UEUhvrTAvG7QBkFs3klg2K1Hrj9xyBuqDvruwhnsLVLd7QRWdzBuFpKMTsFnKVuM7
 UwvDW3axP+SYYYGicoFgSekUa6qlZB5gsxIQGulS1tixt54wABIn2KvThqHmPc3CtbU/gS1rQ
 vPfJAW4g0HnrU8Pi/WuNB3uZGpULgabyZsIY+d4+4LUhtyri0pGi1ZG48OnF8DzPx1MzS5zXe
 AQuVBeB1pT3AGOmYTr0HpjlyjsV5mm/5MLjPdMGgnI0MbVebmYSWLdG5zJto6pHRfV27nvFnI
 dtQd10vUgIcXu2xRc5KpNLHhlB2pKnVvp7CVybeaIwIzgGhC0wLohP2BXOBpev3+Vcwj0HKuS
 D4XNYc5eknETnozZeKKsrDTbNNsAXdiVzfAY8n1ck8uSOkCUkbMVaZUVXPPFusyR1oCqFkJGW
 UMJ3Hb9YaMJWUt9vlovDsBEPss8IC58hXskalpkZPfdU3JcHfB1AjmRV/jkovIO6r8DIs3z9f
 ARf3oDhycAKKU+IsyvcPRSeK4ecHU26oNsrF+qZ5etP2A=

Am 28.05.24 um 15:32 schrieb Andrea della Porta:
> Broadcom BCM2712 SoC has an SDHCI card controller using the SDIO CFG
> register block present on other STB chips. Add support for BCM2712
> SD capabilities of this chipset.
> The silicon is SD Express capable but this driver port does not currently
> include that feature yet.
> Based on downstream driver by raspberry foundation maintained kernel.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
