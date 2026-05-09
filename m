Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47141DE8BF;
	Sat,  9 May 2026 13:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778332276; cv=none; b=sPjU7+pocLsG76GWH89A/wJf+a2cs6CcsxfgI67fEgwEU2npL7owf8QwWINGp8YIyDfusSdj0zsVMcWH2koMXKokOPygNe2kjhwPvUiYy5xfZxQAswrssUy0UPrssFk7g4RD/e9ILCE0C5W24Tl7M0KDk3oQtXCu3NV2RCHhHTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778332276; c=relaxed/simple;
	bh=2aSWZc8Dwk+9kmPDchePM9KLcf+qoHLMBnMSgU4iMzs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iB6RkyseM779fQyF1IchvhcMWFaRdFWkEFaLTWutvyoAMECTeYumjeQMmo1P9MsmkSC1nqxO4z5WllFFrUXkbiYCQ+AwF+Z5WgiCB0UC+SB9vPfsEGKvV8Fx5FTFVrogdjMHUaaDDy6eEuJ3z3kmO5EIR/OFm35MB1Y2k5SDwI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=eSCATAeh; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="eSCATAeh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1778332268; x=1778937068; i=wahrenst@gmx.net;
	bh=2aSWZc8Dwk+9kmPDchePM9KLcf+qoHLMBnMSgU4iMzs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:From:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=eSCATAeh/rYH2RtMo7rm93DJeMU8R1p4GPuXStRs+mnvo7ObWZQ6LzmG2m8YN0az
	 p1d/FjF4UPssLlH/thJWOls6Up4+xmj75UhwDDbjLarIOt+f+kwbVJEbSlhROXqUi
	 QHyCOvkOX3kuu/AbpWv0YK35Ji1RSE4ZmD9UziAgyEgFGeLvl+ALXvI+KCT/IirZf
	 uf7WFO8kCDuMrOIXeXFP2VeHnXltWMUXgLcbcQ7KcqZDB0Gl4fLj+wTk5KtY323dD
	 2ymp9k7ksaXQoLj5QZYzvz+Q/IozPORDKuy8YqcFBpZ22AkaBkevkIrn0BjShIpJ5
	 1fc32QqujT8+/aClmQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv31c-1vV6s74Bua-017vLv; Sat, 09
 May 2026 15:11:08 +0200
Message-ID: <6e863b3f-9fa6-4a5a-8ef1-08af4b1d3c33@gmx.net>
Date: Sat, 9 May 2026 15:11:07 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Haibo Chen <haibo.chen@nxp.com>
Cc: "imx@lists.linux.dev" <imx@lists.linux.dev>,
 linux-mmc <linux-mmc@vger.kernel.org>,
 "open list:GENERIC PM DOMAINS" <linux-pm@vger.kernel.org>
From: Stefan Wahren <wahrenst@gmx.net>
Subject: sdhci-esdhc-imx: How to disable runtime PM via sysfs
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rQSQz9W9AzDHnpOJdX55z38qDFbwuvFZk5HhWtzumGeL6vvIy1j
 ABK08AsrHT84eVdKs+ZWmL2sRRMLffXWmwiQj/dl0n26yEHvGtCEHWR+MgUlz6VFZqtBFho
 ZL54lvtjRxcGTzzreVHlEq7uLxtjCV/tR5K8uBEtUr/o/0qiwSTBbSMWaMnnVCNYRFVjjJX
 UtL5qv6TkFFoXoArAXXPQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:tKVqbKwA5xk=;G6di/+grf248MCQFOEhp5KDT9Jv
 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
 3boBamcXk/BRbt9qOJ+nZfqA==

Hi,
I'm investigating a performance / latency issue on my i.MX93 board with=20
an eMMC and sd card use Linux 7.0.3. With latencytop I found out that=20
sdhci_start_signal_voltage_switch() is called from time to time (~ 5=20
secs). The reason behind this is the runtime PM of the boot device is=20
handled by sdhci-esdhc-imx.

So I tried to disable runtime PM via sysfs:

Strangely /sys/class/mmc_host/mmc*/power reports that changing=20
autosuspend_delay_ms is not supported. But according to the driver code=20
it should be set to 50 ms.

Changing /sys/class/mmc_host/mmc*/power/control and=20
/sys/class/mmc_host/mmc*/mmc*/power/control to "on" and=20
sys/class/mmc_host/mmc*/mmc*/power/autosuspend_delay_ms to "-1" doesn't=20
disable runtime PM of sdhci-esdhc-imx. The function=20
sdhci_esdhc_runtime_resume is still called, I doublechecked it by adding=
=20
a dev_info into it.

Is this expected or do I miss something?

Best regards
