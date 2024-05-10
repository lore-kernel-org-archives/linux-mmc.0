Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2C1C6B8;
	Fri, 10 May 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366484; cv=none; b=CbKYH1afncm7IzVPLYJrYALqOmRqemyEQ0Jdj8LRLEJFkliKIiwPHEbEEAxE8Ym7UlC4BtiWL7lMfSa3JH5EIgSO0kprahqABFCHK9G/Y6EOzaVPgAKWwkNQ8yaTxzPhvyV6HKTbJKxmFlPMUq5DgKQBVYvrFxmJnhDA9qFh8h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366484; c=relaxed/simple;
	bh=2w97oK1jExDzB2dmQW+G7YcnogGchVumDfRy3uylpLU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oZ1/0lzr8wQIklbImkuDOHU1hW0q7/wKx9yEGZTORcCYyw0FDqSxR5PPF4XLhMRu2LfaEtxmAIDsHD3mFJzP+k55yNJ8FDwew5eKzqRDxetX+nTxFRsIImCuczdLmqYPQmxGgaPjjin0xUTTGu2VM26/deFs1jamlqzJV94fZTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=SeZwY1/C; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="SeZwY1/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1715366462; x=1715971262; i=wahrenst@gmx.net;
	bh=2w97oK1jExDzB2dmQW+G7YcnogGchVumDfRy3uylpLU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SeZwY1/CvYrCJxjjDSCyEOYXZZzyT3QGqPd3RJWnFxhNDxgmaQCVRzx3F9QQgjyW
	 1kllfMaQKM02ZFcf3gca1J/49FGT1K4qSWVoH8BGbwCQqQ+/tdNxRB/xYVClIdqkU
	 u6CvVoXpqUiWbiCizFsXy3IUwBvRV+A0iy/x6X/S7OcJz0MQkPW2FmPwnC6/YmvCb
	 nFNhdnfY3gUa5/cRozpryGZVNoc8CH52PwLXug/rEzPzow32XL+124e/G8LB4q7RP
	 OfOLJ/ym8L7ON/9D538fN0h0i36ZbNAK64KqpQA7H0f+JESpkdcSxL7pDJVIPinYK
	 nEOuS6SPyWZDDHCajw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.126] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MEUzA-1rpWat3gmA-00Ex5b; Fri, 10
 May 2024 20:41:01 +0200
Message-ID: <289e3ec4-a2ba-4bbe-b758-dfcfc4a79498@gmx.net>
Date: Fri, 10 May 2024 20:40:59 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: bcm: Add BCM2712 SoC support
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <cover.1715332922.git.andrea.porta@suse.com>
 <e60ee068f06cb2325e3d09c27b27002ba6db8572.1715332922.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <e60ee068f06cb2325e3d09c27b27002ba6db8572.1715332922.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:WOJWRoqjKtDUsTiFi/ZNqDsbvFNk0ekwLzkRplB2jlwJ8bh7MQM
 JgIOSxoK5Hkh4gEcSaAnEaXju/rBT5mUbtcHhA0edylYZ8wPNHPNFwIIv8FzKkXIkkyFXPj
 S9KijIhuLWPAYe8IIowCvni+PxMyiRYVaJB/R1pzwgMge5Lw3IrgkHfaLm9WG5UfjpC2Hd/
 wRkgcumg0KjDD5OBWWVkw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:j7thrQ8qSFA=;wZl4qNoDouCljPfOOOAv4y++2kU
 UjeMwOh4IcmrsYE5k/3bDMbP9EV+LfEN1Yoi1CuF8YBy9Odtotod9972TOdASGT83fGEoGkvz
 Ksfb7zJfmjTmo8+5mTgnV04uCpn0ZgU8H/MLHSLZpSP6VxdvC9OGmzc8leW2YM/QGgfBho8P7
 yGNFRtqE0RNdEjxJoHAGZjMGJeHQBK+M2ncgMSF291X60cs2dl3fesGU8lsr2EPAo+iQURePp
 E6CkrgH0jlBSKcn/LJO5r9wN1EeVJyd0ZOCftQ0DB7w69bL/3r0GH5LNc6QTDMJ3WmqJxxNoy
 N26rLmpNkQZHIKdNw07eDJct7KM5/rQsENHi6sfKYz+O93gVHaCdHEqngD/lguK5QK047tUBQ
 N/0mN/GvtIK9D8rbDsTiIqppF2XG0NRTj5Xr/XWa0hElO78VgtEgaEzl/jmrMes+dgL1RvYiS
 DcCZ3yvEOnRZW3NvShItWXEId34xNPeDs2LDR9g6goK+pCTQIE/79B2X6SrglysNxr3Eo1S3+
 u5CiasVXS09an0W46SO6T7i9E+NW4xamKqGnoF637vCtAjW32zAJ8pA7u3FtbUYEzbqtVekXV
 P74Afht1agNRc1cApNyxu/0QDBNjTtjB2ZSkuAhkKp4nkWr5v2sWTglNzk3MXEx1GM9UoKqRv
 57Nx+Ce9XjvPFEsXBi5q0yh9YMBCFPC8dS76qV83a51UjlV66ZbT3D1dP2F/jV8P0KrtyWX/2
 Al3c6t5493wppcNdIenQi0BxKg4SbJpVj6kRM6vFwKnlOlK9nujsKWhxQCG2fi3/S9Ryo9t0V
 j50C82jF9brh5ncXfg2hhkPDFXGhf1xqnNwUfSbvaEB6o=

Am 10.05.24 um 16:35 schrieb Andrea della Porta:
> The BCM2712 SoC is found on Raspberry Pi 5. Add compatible string to
> acknowledge its new chipset.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>

Thanks
