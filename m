Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A30076035;
	Tue, 21 May 2024 11:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716292641; cv=none; b=sWJLgjIlFOopM1MGz6u33/W8Z9+qBMvWsJnR1k+JvO7Yw96lltquQLjv55hXGCoTwIWMfhYn8fBADHz3F2NT2uT3oEZeTI2INcOGWcEL+l3586t+Rb2sp2rgw/UPhNZpktZHtlU3wpu9EAfI3FYfmn4WM4johgJiSWAnKPZne/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716292641; c=relaxed/simple;
	bh=myNuxgtOJqDXVT+HSRgtuecaI5gwxkJHVxARIgcJq/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mBljf0STnfFvKKv/zCx7XKaO8QOHpQ1JUQYlg5vKWnfNei/drnMeQT/iQzbaHdCrIUfVpp3+oB8g8j7SXdr5BQ76DkYjhWf02KyBkToHh3UJbdtWb2M79WWMpPt9k7ZxGrrVhFv4CcpEWWk+XAxM6+VKoDMJqZzzpdS3LKnVa7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=Sd76a240; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="Sd76a240"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1716292614; x=1716897414; i=wahrenst@gmx.net;
	bh=MKxjmztR/jHkdYlpsG3v22N+vXjLHvDaMqP5hmX66zU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Sd76a240RQLy/1ECWGoEKxh2IQ4HK02TpUyj+SKcx3EU3iOvkrk5TyBp/AIg2evQ
	 anjIp0LmZYguOujWpFjRZJwlvEjHpWTojzzmo5zEt5YGCJzMDEC0XIKK22JhLmKfk
	 FZAAPtOUGMTSfNt7VHuUWx1VDoffDDD+R888PdMbwFrazVhtLEKe3gsmD11d5NRUi
	 3auJe4M3OwtABwsKnrBwib2yY6+3Mq8f5lvfY2kAy9CnxwbtdG7jICCt6zjwEIOQh
	 qQ9zUN1KPCt0o9GQSS3aL/tuAoKrxuez+I3SuBnuVErLLzg1RLi0ZFwQGJqrziBgr
	 m1gMlPJ4um/m2PTafA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.126] ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmDIu-1srHaI0niq-00i8j9; Tue, 21
 May 2024 13:56:54 +0200
Message-ID: <bc1eb98c-9d49-4424-ab89-16be6c67c3f5@gmx.net>
Date: Tue, 21 May 2024 13:56:52 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] dt-bindings: mmc: Add support for BCM2712 SD host
 controller
To: Andrea della Porta <andrea.porta@suse.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Marc Zyngier <maz@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Ulf Hansson
 <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kamal Dasu <kamal.dasu@broadcom.com>, Al Cooper <alcooperx@gmail.com>,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <cover.1716277695.git.andrea.porta@suse.com>
 <d7c8bc0143c6b8c8b313413860840ae5bf2dc22a.1716277695.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <d7c8bc0143c6b8c8b313413860840ae5bf2dc22a.1716277695.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RemX3IIs/au4ReeRx6ZGARXTRzVD7neD4wJdYjz7HTzsO8Ft2Ef
 XCUSPctDOQfm9J9h5aNR9coXl+VHWpZIUG0WIBSG2kfrJorlqdQ/Klkm3/M3iU10vDSwNm9
 eXgM6/Kt5gRB/+RMnUMQL1FpFI6qeSCHybbk0KdXjgFl1zCDxEt2CQRnUVYsJDgJSrJJLtW
 2b1TUHSmwIOX134TEiYcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Q+I2IaHxwcs=;qn8CZNtHsTD/R40C4OBokdVT9hY
 N1fuyvGihk6k4pKUYgCUA2NT1ROWEHgqnRxQVJeWujQqUcGDfzbsozaFH5y4WD61Iu6ijpygI
 dKJdgvFkfJcCBd+F3SaFbEFYG5ITK/IlS0IS2/gEWAbLb5Brbji78QeBDERokpFAYg5mW7INa
 oKqOOOPYlT6sZiab4SXddeF/C4CpQur/9se1G5yXZYU8mwDNApaQPRuYDJLFlPWXsutgG2fvb
 PjjPY23b/LRM84yJG+7bc/WAlIbjidOn8lsRqgSzJY7YJiqnNamIVixzGkrc3HWgmPa2ay8f4
 e2YUOFgU7mbz8RDvTd393f2WMGi71DIfZzvG1MYa6mptauM8dlGp9fsC9/YNlEEF3OzDN06ap
 lhdrby2XltiAaeWMJK2Pr1Ob5FJf7+RD7EBrIsQY4rQ+0IxlC0NZn6dhUcN2hWYYhmHjSPcpI
 Cq5ri61rZwQxzl4p4/vRg1lS45hrKcF35xPKKptFHlyPofJbdiVlHEb80sKObh6oLULP/Mutp
 SwIWKpIs+ZV/ybZB/r4Wr7VsNzibjwQKOUQrvQNkTez6h6R0JA/pOI7QPSYyGmYxnoF0qmOFC
 aQoC04GYMwWgjXvs20kda/TgOm74QpH30JEAoJnR7+a96Keqt69c+j2LAPq8xET0e+/5QZ86k
 WXmeyzytWIf2jZdV4qtCtF1crIAwDrpbB9xjcxUQ9ltivyVm09X2l0aXFMi5D9weyFQs871/2
 64OJn50lPAIIjtsMl0zYorsnzWeFkxzdQb7/tJPk5JpsaISt3bR4Oa1mOoF2JwFfJjNMsnvUc
 eA5VDIBNKWWQdVN2lvlMB44Wtt0m0OWlDrreNf7AioRV4=

Hi Andrea,

Am 21.05.24 um 10:35 schrieb Andrea della Porta:
> The BCM2712 has an SDHCI capable host interface similar to the one found
> in other STB chipsets. Add the relevant compatible string.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.ya=
ml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> index cbd3d6c6c77f..d584a7ea707a 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> @@ -13,6 +13,10 @@ maintainers:
>   properties:
>     compatible:
>       oneOf:
> +      - items:
> +          - enum:
> +              - brcm,bcm2712-sdhci
> +          - const: brcm,sdhci-brcmstb
sorry i didn't noticed in V2, but why can't we just extend the second
items list?
>         - items:
>             - enum:
>                 - brcm,bcm7216-sdhci

