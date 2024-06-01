Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB11117736;
	Sat,  1 Jun 2024 08:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717230460; cv=none; b=kPcb5gX1/jsguUugOpnRwqUejiS76Is33+rdUajD7RUDJanFPB0BPN6nn1MP6nTUp2hdbMsge5Tg4gCLiSfOdpgAqGTUnim4yMSjWI3NWaktvX8ZhwnyGQCoU/4O0Ee5dD+h7MAu+lQu+4wYpDDEay00Lseweq6SkJDsg2hK2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717230460; c=relaxed/simple;
	bh=CCGdaeCR/uSlXg0QGvO7hXoUNkCEtxBToDVRpLZJZDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ejlWXI72AYHLK0qQN58gLCPQiA02YppPVFnsKoalx76QlfkSOjNnaHmWPI6WWSbJ0O6PtuGMcijJ2h0Xh7fOgtGEvb/4qt+NRpawMs8KYTMd+GsEnL1cF4gKARdJ8xK+Dp8JDTR9ciZkh5Ne5BPDCFj6inXHqFh6CF2HtM9OJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=gqVIp9oq; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="gqVIp9oq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1717230441; x=1717835241; i=wahrenst@gmx.net;
	bh=CCGdaeCR/uSlXg0QGvO7hXoUNkCEtxBToDVRpLZJZDw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gqVIp9oqJ24/c2lzQKDkZ2QtAkJHYXEqWiawrrXMWXvw1gtOqUzsThlO3aW+gsLa
	 tAnUH6unRCIrHm1RuZOsTxbRi1bJbiAWXvpiQRoYBIcsKe6nfnVRYIQQWwiJL6M7g
	 lwZUWcp+kA16BjU9onxsMP2vXdlg55N++7va74VBfwBjks/gw8tL4XivnLJahCilp
	 c72+h7RJGOu7Ku1zgNWvVTyIE3CnbC/KGyHsANbHd7xFC7mvJcNm98EAtGtHZ2F0B
	 ZC1S980PKiWWjAk5XqRJnuaeaE0rJlCak0lYXBEKOJ+ATxvJ9lCDGtkc+NH9JnSez
	 Ar59cDDvZb1cY0kBuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.127] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIx3C-1rstW702cE-00KSlK; Sat, 01
 Jun 2024 10:27:21 +0200
Message-ID: <dbcd0f28-3f45-4506-aefb-b8dc6be47a43@gmx.net>
Date: Sat, 1 Jun 2024 10:27:18 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/4] arm64: dts: broadcom: Add minimal support for
 Raspberry Pi 5
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
References: <cover.1717061147.git.andrea.porta@suse.com>
 <874589f6c621036620cca944986e5be7238b4784.1717061147.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <874589f6c621036620cca944986e5be7238b4784.1717061147.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:eAMNr6tyKKk5lXgBC/lHAUcrQiVwXALGXb+bV2UoQxMspC3HHqW
 /7/yOEI2IyRxgRUdmgTvVDulpss+/ExBcchPXhxue8QT0GlCXP3XU9nLMV03V/lRj4M04n5
 bw+ihcEEye0eAJkV/hwQhfScsS0+POT8kneoRJ0RgdOwuiXKHyajHIrknV00lnRchj5IjMu
 dqIExM+aSdlQJ+L0QUOcg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U+Adulxrhug=;DQtuSnTMoCZFQSZXDz5eLyzymsi
 oD/abWDWRHWpdJVXD50f3xTYhJTvvj122R8WH9ivX4OrtyLJe19eEdzvlJjd/CbrZauN2JB5K
 S0EqQN1fGjqCgPN5KlRHqukyYLSDwgqlkxnfWNJSxN1Q7d22u2ChcDSBA4qKflRZTz36xZAct
 TWyLVodQsx7hbM/krHfjjMKM7sf9nLNpKLvgDLwEaKb+aYFxM7iwH4gfOWA8PwqithXsaunmR
 NVi+fFUVmze614RFKNHnId1zNKmDf/96NHk82Lu29F9y+0IDOEmwZnxZWZxKyJMCXBXsLmMRL
 ybfi15ZkSPZPM87t7pC36qV8jFYCpcHuhxXn16qOZVuqmx9gJJUORigEdJB9EFDZStL1RgkcB
 13cMwHVKoELLko7aFMFunhevjK687a9qn/UlS9KZOrqG903SXAzFbMm9ORUGf7ktympYMpeCw
 doNoMtxo2adNqHAlpXfGYqPfABlI4AZewE1p6o4K5gSkETzzGfwIDtVAOCrC6ZRlfn67NJ75K
 UdmyP/hzKhOosdxIUr38Ds/nAYxUABV3LP9bREuByKU/RvU6QrAKV8T8BOsqYbqWb2Qs9m4tR
 f5lslYEl2QjXRhsCxHE2E/xaCFxelWf8u3e7FzV+n3Wo6Wi6stqf71XPxN8N6xMq97YUbEHNm
 H6IvtM51SmPymWSExS+QHJJK7JVAI3ISTe/DERQB+0KwcXCIlftWiKmxb7iWbZDKBxHjU9QBt
 200w6Hfne8iRnnCdmGoDc4XTbgkHfuKxfUZQyx4zrpUPwvZBp4Oz4C9nAqGwdiJMDaLVmPTSe
 2PAGPxLimnRq/cEN3gWPkYFKIjFtzUP+l4NJ0vxvK+N8E=

Am 30.05.24 um 12:12 schrieb Andrea della Porta:
> The BCM2712 SoC family can be found on Raspberry Pi 5.
> Add minimal SoC and board (Rpi5 specific) dts file to be able to
> boot from SD card and use console on debug UART.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
