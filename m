Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F5C14E2C9;
	Wed, 19 Jun 2024 15:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718811688; cv=none; b=bfyl7xZmrCOcUhnbe1BLEkC56ZIcWdjtjaBRnXt7dXm62v7/RKqdKp/vrNuAyIt9hMRqnFiP1hC/vFDlN//wtUzhfS4kyX7cj46BA4y28KH9qqLl081S6uptDcfO2/6S+68lWSq0qHgrAKJb88PBkPDEl8stAgYwCJOznvGMk1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718811688; c=relaxed/simple;
	bh=RT4j2J3K2cJPug7RNVsL6yX/1+8te7yz8mA1djK7REE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=l5AGffNdriOvAc7p3pqCFNAShi4sdeCjuDnZfGB6z4W7C++wXnwup75ukOch2Kx+/R16H+HV8CJtuJAmjnOLTtvpRuRwxWm2g5JsELm2vYLKzzeDZhIg7Ltp9aBgUp/yZTewGMYH05w7XhwJdLKC0XKBUKMybCBep+ATC+8SteA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=xAkvfHA8; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="xAkvfHA8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1718811649; x=1719416449; i=markus.elfring@web.de;
	bh=t5BuAxzFoF/+RdRA6VaLzFTyRU7lFDYKeo0DV2WDzlk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=xAkvfHA8biEeRnEi+oQhGy2Owlu6W+IcYtUieQIeml00P8MOii/yo+ZzYzY6SZzi
	 JhSVEmlzPZyF/kQuhPOsSCHei6Hz7ijdqPzw6GaOtSTOUs0LyxTWM2E0iLxSfiyUg
	 CxXFWOY9MtjngovgsEAX35VP/mI4FCU8aCfiNg0pCb4kLQo/1jOHMPYUNcB8I9KNY
	 87IRiE0Ekl4kVhT7ZdYi9plPyJ6lrv6QC+OiG8ChHnN6VEPNRzjup0BhmJUtbguw9
	 +klHjnBXkxNZYTnp4W/SZUVNsXm9oDyOz5kstthYET1wfRbKN1ugG2/pudCDK6C7g
	 H8bUQxwdSeEKw6VBKQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N943B-1sOvN01Av9-00z95r; Wed, 19
 Jun 2024 17:40:49 +0200
Message-ID: <4f3ad4ae-1071-4411-9791-ee9d27cfcbf4@web.de>
Date: Wed, 19 Jun 2024 17:40:36 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Shan-Chun Hung <schung@nuvoton.com>, devicetree@vger.kernel.org,
 linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Shan-Chun Hung <shanchun1218@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Adrian Hunter
 <adrian.hunter@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>, Jacky Huang <ychuang3@nuvoton.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Peter Robinson <pbrobinson@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Sergey Khimich <serghox@gmail.com>, Tomer Maimon <tmaimon77@gmail.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Yang Xiwen <forbidden405@outlook.com>
References: <20240619054641.277062-1-shanchun1218@gmail.com>
Subject: Re: [PATCH 0/2] Add support for Nuvovon MA35D1 SDHCI
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240619054641.277062-1-shanchun1218@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:JHeYW0cTxhh2VTBOBK2iw7JrIrc8CacTjD4FKBl1hGqnrc+nRIi
 uhdbk1aSRjCtkoUbXezCLmBVvhaNJeWmVdY6WMTNffK7v6HlLdQoGYDmHr3La3XPk8RCaOf
 DuQ9gW7PJSCm/x4C/GrVxlBPnVNmrTZzgp+b0vdfOuFdBQglC4N7YwGkZg9MuLBRPCtFYcv
 kLpNHagO+4wOXwYkb1dvw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CjjkTc2rrZk=;SajpZgiLXLGdeK8Y/d6bvqJUNcz
 hiHG/lWXa5DWRL0BJO7b6glIr8ZolceZc4YGZZMeRS8ZIcfQY8zaTJPJKjy5LgJ3dkbTMllCZ
 uZ1/7pH1/ZFwi/fIyq1AQcCdIdVKcSmMQb7fDI9QCPXBXypuxMuv1beUFPGLlk3XUrJ8eW5T6
 Y2iPE3FF9H4HDdhY+n1Twz878IDWfr5YvFkKQzTt1fGgQrk+CEvn3Q0C/GjJREyr+Ym21lpEf
 LEj9X6BBXqKk3GVrPefoNHeg30U+7PcZzJk+6ynEL8xYcsxK3f6FL0X/CFRJ9dTvdlqnF4DGF
 x6cjJRdYpWwZ431/hCF0epGxEfqJBec48MrweVh8qVTx2R5TuNslUOfq70i98jk7aPacDK4zM
 iN3X/Kx66ORTXmGG+N71TlH4qSUixV8D3YdwHJTj7/Bt/qzb9XNycSB4YHXW2IDYB8ph56yb7
 R2VIC3J3BQyz+op2U2rbTv3D+ox8RF+d3ac8/6FHwruFn/x3yEi3Fn2zEoEFnghat1BljvYJq
 nl+LvkuYsDDFXeg61LTWO0GEcLIw6f0h5TUWPvBV+ZthfAkaXlXSxu/6ReHaEA9pLYadMZYG2
 iZKPQ71tWwjkUwcntr7I+5576ifOX3eG8fZK+Dqs95Ad6nbzy3U9bi0gzjv9tYsjrweNxkEGs
 pEKQip83d0gg3T0BbNAFLVSyIfo173vNkr7SSYEwmN9JONhUPfbJ9Zb9dIO32vx9WyWsQ1anO
 NMPe6FFtmTzYzz68k4jddlQjXWbpqglT//ZQQouZWnJUAyuFldWRXHc6bgkSkTQbVC7ry1WuQ
 INKVh1diCcseDcq/XkU1ImFI3HS1z+D1fFyaUhp4w+AGOpF00GAzRE+fbmi/zSqMdY

> This patch series adds the SDHCI driver for the Nuvoton MA35D1 series
> platform. It includes DT binding documentation, the MA35D1 SDHCI driver.
=E2=80=A6
>   mmc: sdhci-of-ma35d1: Add Novoton MA35D1 SDHCI driver
=E2=80=A6

Would you like to refer to a slightly different company name
at a few message places?

Regards,
Markus
