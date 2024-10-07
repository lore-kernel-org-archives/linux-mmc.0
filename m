Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B88114C5B5;
	Mon,  7 Oct 2024 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287839; cv=none; b=qLpLsKKshXCnmBLZJ/HzA761zrY6sCrDYPCAyQqAxLWPS4ZWLY012EAXEOgbZQ1cs1IWO3BdMbo48686rBT5EYZW96UFjXXP0lTX3yPVrLciL0uBpfuA5RIdWytj8aY/Y41hRTQyxVtRSadGqO+1VCNcUwsu1JBXSyfC0j67w0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287839; c=relaxed/simple;
	bh=Lf9Lj82NnhZjINNCF4N7l5gB/HthW6d439XtJDOaA80=;
	h=MIME-Version:Message-ID:From:To:Cc:Subject:Content-Type:Date:
	 In-Reply-To:References; b=X5IQC7QNT487k/pAUMnSmRHj543m9w/mhd30YYRGZgQLaLyjy4Z/Ctbiwhc8ib5T2mw5hboq4TZSaf27gzMzOtwMxWWXqp7Vctmdp5YODPhfSgNdYkwCjZPde5LHO3BQiK3oVWVyVRsa2/xFYJRckZXcL/d9y/7JGCHA/kyw8XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=cJ2vT8TM; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="cJ2vT8TM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1728287815; x=1728892615; i=frank-w@public-files.de;
	bh=aWRckGpPlClWXWLlLN+tiFUkn8w9XI5KUDE1QFwaEQk=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Cc:Subject:
	 Content-Type:Date:In-Reply-To:References:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=cJ2vT8TMTcoIe4ueB8NAz1JOX6UVll0T81S7D+vyvypx+R6VJee98Du7kwwrXNe1
	 BV47plGQVUGfNdl0HCTFaFBagsT5nCTJNDBvVfRb17xMW5qyB8FAmR2B0D09nbGjq
	 M5PeLb996gaxQy6iuYDEbmB0VNk5heXKEHw830ds316MXchi1Q68P0r1ca0GcjRN0
	 TfHzwpxUzbIMhn+7AsLXGQC2im2OXJZyPkGyNmq6Q1OQJm3hlOyxE72fPJ2Q+fjXo
	 QhWz8JrbbkdpwGTDsvo2aOZoznwfdc02uC4FwhelaPu1iPDQO2U1ff30o5DjXw/Tf
	 MPeMLR55s0vAcek7nA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.153.101] ([217.61.153.101]) by web-mail.gmx.net
 (3c-app-gmx-bap03.server.lan [172.19.172.73]) (via HTTP); Mon, 7 Oct 2024
 09:56:55 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-c35964a7-f0d4-435a-ac76-586e90c666ed-1728287815279@3c-app-gmx-bap03>
From: Frank Wunderlich <frank-w@public-files.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Frank Wunderlich <linux@fw-web.de>, Chaotian Jing
 <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 daniel@makrotopia.org, john@phrozen.org, eladwf@gmail.com,
 ansuelsmth@gmail.com
Subject: Aw: Re:  Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add mt7988
 SoC
Content-Type: text/plain; charset=UTF-8
Date: Mon, 7 Oct 2024 09:56:55 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <486a85cb-8e09-493b-93f8-6610855b5f7e@kernel.org>
References: <20241006153447.41377-1-linux@fw-web.de>
 <20241006153447.41377-2-linux@fw-web.de>
 <p7lqqhet6ahmvieh5xaws6ugsnasmuw6k4oajkmfcctuhrs4dn@quvrkmyof5ss>
 <trinity-57600902-afb6-42f3-8cf5-54a07710f979-1728284364104@3c-app-gmx-bap03>
 <486a85cb-8e09-493b-93f8-6610855b5f7e@kernel.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:n6jvowWeY9OPnSLi7BVINuNe/LC0IYJRWMIhKNkJshpxKZMv4cJiUbGEOrFJmMTBiwg21
 PyYiAz8aH+rVqwlLL65Anr6la9n0pFwTBn+qcVXMe0Vrx3ayKWuW728U07tyBbHVMvZXcLw7l4mx
 hGX01rUlL6vujA90vYjD20gUllv1n0IrYVagmHhWbgrB3P4d2bGdjRl7THwtXP0gaCGLGbnBdwmd
 OJ+zbmPX/VnlZbY5Wp38ZCw6kJf65gg8bVu2oMtuqZ+5Zy5KJJFsWsSYMbazCvrICwUSZKaoYCCm
 dU=
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UoCxcf+vtco=;NOMDgFbtuMli4t8K+pGge72+Bzc
 pVbp3Gi1YbvPknFZOQv1tv+9kkSDOtyL3KXvvl6AUGD7hpZF3BtVKdctB3Zb5LYqU/J1aGpBj
 iUFY76Z80zhu3Etfgc581TngWEsgociT9T3HiZNSEcKSonQpn8+IX/ZbOGYfxrfAnMU2F1950
 cz7kZz7GCzF6DuQnfLzmxY+9kE5EA72k1wMo0TgzDTIVClxr7tB/kTaq4qnTxJstxphBkURIi
 ZirUZGDdfIWoDSVY6VSOw0cwTUfEpCJom785oMr9hqso4JvPvlaD50yuwc4njSYBhVcad6GmU
 mp9+AV9JQvSf/bXsLHvs9k23Yfx8q5ImMa0oULDwqxbeqdKvwiiVrgnpC6IoeOxpuvDhdvOTF
 EgMPVZBTebvcbf4QSs0OkiinbNZTzWIA/+YcBQEsFrpVZ33ZC6rTGRtf7FNpuGSWbvVRcAXoO
 YfmEBF76QlWgdHsDieTSJsQZIr84uCH18FyANadm1vTKwCTGwf+BvZU0zk04XmyPEXM7//8eV
 8Zxgum6gmM9xyTEUnjel9QxjZf6yyGmYp/Ia2N7iM4WlEl6OxpxaQbanQJSZT/kCBO8wj3D9k
 o5C7AVVoEyItVVynqGg7klMhPI+eV1VLDPMB/ckVVVQVwABP63kxo6GmphlqwTPgNGwtq42bU
 ABgxyXqhgfbWm8EY7rK5b+U3XgR0s6TYjyghygoNYg==
Content-Transfer-Encoding: quoted-printable

Hi
> Gesendet: Montag, 07. Oktober 2024 um 09:04 Uhr
> Von: "Krzysztof Kozlowski" <krzk@kernel.org>
> Betreff: Re: Aw: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add mt7988=
 SoC
>
> On 07/10/2024 08:59, Frank Wunderlich wrote:
> >> Gesendet: Montag, 07. Oktober 2024 um 07:55 Uhr
> >> Von: "Krzysztof Kozlowski" <krzk@kernel.org>
> >> An: "Frank Wunderlich" <linux@fw-web.de>
> >> Betreff: Re: [PATCH v2 1/2] dt-bindings: mmc: mtk-sd: Add mt7988 SoC
> >>
> >> On Sun, Oct 06, 2024 at 05:34:45PM +0200, Frank Wunderlich wrote:
> >>> From: Frank Wunderlich <frank-w@public-files.de>
> >>>
> >>> Add binding definitions for mmc on MT7988 SoC.
> >>>
> >>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> >>> ---
> >>> v2:
> >>> - fixed minItems to 4
> >>> ---
> >>>  .../devicetree/bindings/mmc/mtk-sd.yaml       | 24 ++++++++++++++++=
+++
> >>>  1 file changed, 24 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Doc=
umentation/devicetree/bindings/mmc/mtk-sd.yaml
> >>> index c532ec92d2d9..7380f72ea189 100644
> >>> --- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> >>> +++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> >>> @@ -21,6 +21,7 @@ properties:
> >>>            - mediatek,mt7620-mmc
> >>>            - mediatek,mt7622-mmc
> >>>            - mediatek,mt7986-mmc
> >>> +          - mediatek,mt7988-mmc
> >>>            - mediatek,mt8135-mmc
> >>>            - mediatek,mt8173-mmc
> >>>            - mediatek,mt8183-mmc
> >>> @@ -263,6 +264,29 @@ allOf:
> >>>              - const: bus_clk
> >>>              - const: sys_cg
> >>>
> >>> +  - if:
> >>> +      properties:
> >>> +        compatible:
> >>> +          contains:
> >>> +            enum:
> >>> +              - mediatek,mt7988-mmc
> >>> +    then:
> >>> +      properties:
> >>> +        clocks:
> >>> +          minItems: 4
> >>
> >> Drop
>
> Drop this line.
>
> >>
> >>> +          items:
> >>> +            - description: source clock
> >>> +            - description: HCLK which used for host
> >>> +            - description: Advanced eXtensible Interface
> >>> +            - description: Advanced High-performance Bus clock
> >>> +        clock-names:
> >>> +          minItems: 3
> >>
> >> This is still wrong... anyway, drop.
> >
> > arg, sorry again...i should triple-check all before resending.
>
> Drop this line.
>
> >
> > but dropping means the global 2 is used (making axi+ahb optional), or =
am i wrong? afaik "minItems: 4" is right here
>
> How minItems:4 is right here?

mt7988 needs all 4 clocks, tested with only first 2 (based on global minit=
ems) and got this (similar with first 3 clocks):

[   10.826271] mtk-msdc 11230000.mmc: msdc_request_timeout: aborting cmd/d=
ata/mrq
[   10.833485] mtk-msdc 11230000.mmc: msdc_request_timeout: aborting mrq=
=3D(____ptrval____) cmd=3D18
[   10.842006] mtk-msdc 11230000.mmc: msdc_request_timeout: aborting cmd=
=3D23
[   10.848704] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=3D18 arg=3D=
00036402; host->error=3D0x00000002
[   15.866269] mtk-msdc 11230000.mmc: msdc_request_timeout: aborting cmd/d=
ata/mrq
[   15.873480] mtk-msdc 11230000.mmc: msdc_request_timeout: aborting mrq=
=3D(____ptrval____) cmd=3D13
[   15.881998] mtk-msdc 11230000.mmc: msdc_request_timeout: aborting cmd=
=3D13
[   15.888694] mtk-msdc 11230000.mmc: msdc_track_cmd_data: cmd=3D13 arg=3D=
00010000; host->error=3D0x00000002

so minItems:4 is imho right here

> Best regards,
> Krzysztof
>
>
