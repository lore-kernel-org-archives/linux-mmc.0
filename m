Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25DF45C1C;
	Fri, 10 May 2024 19:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715367715; cv=none; b=eAGnCry9XMRC5YV97wu0glWuqwce/zz7NK/VKQD+m9VPav0KdK3r9F2pq0e04k/RQEGDjMYcw5ieWqYaFBymbjM4df+sz0+qZ/P+aO5P7xl0vePD5V5XoS+ucg75kGb2ycgQjNBMT+mYcXNoyFZV+Yo/UPvMJJChg7fHHU31qyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715367715; c=relaxed/simple;
	bh=OQ3cjp1YaVKAGDCN+Mm0n4QgaEEqNCP+eQ2CEyY2KCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EbeGDQ6/GO1WNWJi6JUpmJiS11OWXXBxPNO44XV0YrhxYdobMTG2+XLAU0BE6Xa37wbFeDXeWkBs5UM7GozWkEUYBrXS3TRDHXvk9ARj1jetLHrRX7yDq3nVN4MJ+LRyiHVwZL8dn/VWZGfMl6Hb1QpCa6iEyQs/2GMk0kPrCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=TF7n/g/x; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="TF7n/g/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1715367694; x=1715972494; i=wahrenst@gmx.net;
	bh=r0K6LUzeSfFM3cfAryelCHAy7vdffcHD56EhNe6U6Fc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TF7n/g/xGCdXYQrjRdgg1eTRWR39nlDmazQkPk1hdgRMWid7k2VfJClTmTKFSpFI
	 yXQk8do7L3xXOB9jfHZgSh3rNfmiBb2QUIXz07D4EgIDOwu9tOh18lPd/A2MuxWsJ
	 YMaQOJIEIcmHCT40Se32E5DvR0NiHUGx+iDLoOm30OkFBMKSzn2D6U5skg6jzNwm8
	 M3OOi/XxysQQn1/rKv7P8OrBxeaj7ia54nJk4lmxqWGkekShLgWojmX4jniVWToNG
	 fSThpJfP6Q0k74GmU1/ojU1LqQHVS4cAdFJMqdKI07lEO0FqdOnCNFw3yNmMGxMbO
	 3vNcghzvrCLniwezwQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.126] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N9MpS-1si3Ks12CC-016NY0; Fri, 10
 May 2024 21:01:34 +0200
Message-ID: <01a7a263-9de3-468c-b438-c16f2c73872c@gmx.net>
Date: Fri, 10 May 2024 21:01:33 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] dt-bindings: mmc: Add support for BCM2712 SD host
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
 Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
References: <cover.1715332922.git.andrea.porta@suse.com>
 <1f0c4fa62d6849753e2138cce5498693cfc3a230.1715332922.git.andrea.porta@suse.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <1f0c4fa62d6849753e2138cce5498693cfc3a230.1715332922.git.andrea.porta@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VVVD62vh/QTwMPK7v84RK80zkzw/ZcaJNUYdmqwHzZHVl9s9ji7
 A6OlGA+19sAZuEiEd4SpvmYckNwKP03ZuCStO5U2fmMXGMNG0QhIHa8ODlRHVqKW42CKh52
 hgShO3qEqgNRUDdwrGsp19eQkjDX/dKou0BSoh/OYICHvGSTZHtwFRSFWy9uDwHoXctzhZS
 Tf4QXtNR0A0J1q9eBZuHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JsqNtMBpAPQ=;WrE82vYxBS55rqDrrooFi6unvXR
 EVZjm4eXXeBxDQYx9R/kFrTZkdcVoWDx3LwaJ8+dgJh1PA/nMCAYyTrNwGzu2SayDpTebyC/o
 E4dZJwpzxA39NQ30/Kbty8XfqRPx/MbHe9NA9oS7GE/nMoGwkgaywx+I0Wk3LlU5/q/A10Nw6
 Vc9MF9JIH7Ex4HKSUu+5yO5jh/aQHG8qfHZk/W4jd5YGmQZEfCbrx7ThibyboCJxQQqUVB+if
 4pN2vL2Z6ikCm5LfzIiAxWHz96zJny9wt9D13Q6jML2XjcnnUd6MTqZxTij00A1XGsYmS08LZ
 A0wkiHUXb5Q1GMHKktqP44jiaHRwdsTRb65/IUlcCdNLVwK53r/OidANRNmPAZBEDEvbR2wP3
 r2kHKPDsESbBlLZrOG+DmYRgZCPsBS9u5iBc25v2d7uAIAPn/P0CiBZQrG1OYHYkwuI4cK08E
 sOt+4ZKREHJQeK+rU8up2x27RinAkzGGPOvpH/ZqEnCIRAZYHwYp/fvt6X1aWr2//wjRcfoBg
 66VsDiiuNj4/u2SlxGagz63VnWdowCJ/0qKIlEtCfdDhbSwGd3nHVAaE0/jIr9r4TzArXgjhi
 d5MdH0T1epNqZmXBpmgsHBMPt0EgOgisuACFwDY1xUHwwT81HTrb8uuj6qWcEVNwxdACFPGr2
 2AH+Ll09Rq1fx4GcuVMAotUw3q5XoFivxljYUZmTzpF+FbJUPZteiu1FSXg0Zx/BRd5UjdUIS
 ve5VJ5h4tmJ0Gg8QTctizR0n/gDczdj/inbtheAsIORhtjY9sTVIPgOQHDJT+yzjLMbUm/jnV
 GKkOFK4DbZLk9a0y8qOHrkBN8IZM6I7OzutXowqQDOKfA=

Hi Andrea,

please drop E. Anholt from the recipients. AFAIK she is not interested
in kernel development anymore.

Am 10.05.24 um 16:35 schrieb Andrea della Porta:
> The BCM2712 has an SDHCI capable host interface similar to the one found
> in other STB chipsets. Add the relevant compatible string and relative
> example.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>   .../bindings/mmc/brcm,sdhci-brcmstb.yaml      | 23 +++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.ya=
ml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> index cbd3d6c6c77f..404b75fa7adb 100644
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
>         - items:
>             - enum:
>                 - brcm,bcm7216-sdhci
> @@ -114,3 +118,22 @@ examples:
>         clocks =3D <&scmi_clk 245>;
>         clock-names =3D "sw_sdio";
>       };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    soc {
> +      #address-cells =3D <2>;
> +      #size-cells =3D <2>;
Would be nice to have a short explanation in the commit message why this
is necessary.
> +
> +      mmc@1000fff000 {
> +        compatible =3D "brcm,bcm2712-sdhci",
> +                     "brcm,sdhci-brcmstb";
> +        reg =3D <0x10 0x00fff000  0x0 0x260>,
> +              <0x10 0x00fff400  0x0 0x200>;
> +        reg-names =3D "host", "cfg";
> +        mmc-ddr-3_3v;
> +        interrupts =3D <GIC_SPI 0x111 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks =3D <&clk_emmc2>;
> +        clock-names =3D "sw_sdio";
> +      };
> +    };

