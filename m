Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0B71AE861;
	Wed,  4 Dec 2024 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308423; cv=none; b=jBH8xxCi+FL+k4wrFh1onWJQNg1LGu4uvnnMtPge60xSOiodeAjtfw0pu+bKFrhffBhNBVRwKdGgbJ4+abL6+tlgw8KLbcQTFInCrOfKZvo/O58ODtUk9W0hVj9zpa2uZhVI6mmN923glX2FRKJ1LqwkwGu2VTKfPYNapoVxIWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308423; c=relaxed/simple;
	bh=kJx9FLnINvE3YM4iJf1/srbrsQsAkpP4c0HtMzm13ls=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=oz9F7oS6WI7amig1PdkTKt/Qn0IIiO2WmQGNtUK2/mLPyGFluh6mWi+zP0imIs5Q3dNPfX+ldk5l6iuqXcyMUgej0qGxeic7MRBH/TV3l6SKqADs+0IHzEwy7YMa6vIZ+rO8qZw6tccAqZy+/OFtJa7fY3LQEvNkYWM736XHhXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de; spf=pass smtp.mailfrom=public-files.de; dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b=p1NsGWXO; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=public-files.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=public-files.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=public-files.de header.i=frank-w@public-files.de header.b="p1NsGWXO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=public-files.de;
	s=s31663417; t=1733308401; x=1733913201; i=frank-w@public-files.de;
	bh=dyk00jx2rD13abnBIF0gny6mCB3L0WTy7Wj+eriGTe4=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:Reply-to:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=p1NsGWXOBMpk9Xrxst9wZ0QHjMpwO7wZJ8PDKhJSd5bz+aLjtIPUof5t5z92JKzh
	 WT02h1/9Ek2xR76AismXJy1hwo56p+h5riKtLoF+z+6W0IDaGJzvNBC1p0XHudAL3
	 jtOOec7pDImiWz7HbelNd3t1Wpmj9F65TG7D/yPkSLXvy/a3dlWQ9MygbJHBa++zz
	 mXLkVzs0UUVuBkS8la5c1KcoKak8F/2CyDCW9yVL+hQelEYyzrEldwIvbUOE6JEp6
	 TnRY2WuT6d2WACzdxo5G5WAjudf2k/UcG120YBStBRKx6TEuzHzh046azmBcb2MMU
	 zD7LgwK4EffKaV9O+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([194.15.87.121]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N7zBR-1tfnDG2q0p-00rC64; Wed, 04
 Dec 2024 11:33:21 +0100
Date: Wed, 04 Dec 2024 11:33:19 +0100
From: Frank Wunderlich <frank-w@public-files.de>
To: Chen-Yu Tsai <wenst@chromium.org>, Chaotian Jing <chaotian.jing@mediatek.com>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Wenbin Mei <wenbin.mei@mediatek.com>
CC: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, Andy-ld Lu <andy-ld.lu@mediatek.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_dt-bindings=3A_mmc=3A_mtk-sd=3A_Docu?=
 =?US-ASCII?Q?ment_compatibles_that_need_two_register_ranges?=
User-Agent: K-9 Mail for Android
Reply-to: frank-w@public-files.de
In-Reply-To: <20241204092855.1365638-2-wenst@chromium.org>
References: <20241204092855.1365638-1-wenst@chromium.org> <20241204092855.1365638-2-wenst@chromium.org>
Message-ID: <4762E5F1-59F2-40D1-9D22-724107623AAB@public-files.de>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:db3sHldF0T6VuQva7YZ8BJkBo83cuzvjx9Z9UO2GrwoDa+O4ixH
 63rmTFteH+CanEW1qjyJ069egAPYXQngNUs46t0yjSkh3WMF/xZrQP6vY9qrGuV5e7KbCfF
 g6HTJA6sh62ZCv5Ae+BJ8V7TBxzSZUshJcf9QvB0tKaivwWdNdU+QxtIxPo6scMnpvq6CFR
 HVb0vJa7N7Bvc35qVqjnA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:cyQuMalTPvY=;G6cIYpP8l4HrqzVPFLzj+VTuA7s
 6uJk7KoSZC1ZovJPT25TGM8GJhSI8xoE6q/HVcQqBdR69izgSmBk0HHjKrQFCMhBlGOb/YaE1
 zFN4MB2ZIc6cuu4mTxyNsNIPoUrAv53QGq/Cxm6L8eJIqc31ePlcmdDlmYdk3wCBa/bADdyjx
 mCfBONVrdbTanzp6gGEd/sQrLnQJoiw1bf7/dVY3tiTp1f5Kl+pI9Q89yktvTjb8NgoZhitro
 6UYJ8EU5i5S0NQPv7nd2p7N2dpscbpotcfPfUFzW1teVXMYS5TfSKS/jLpxWt2HVjsuSJ7DOp
 VPKbfuj30K1EbEFpDYPqjxTzdwBJEZw85eAqAu+DukkBex6lHtnQb7UZVJ4XDeZvfMXyXtOKB
 66ZW1RLWCHvlAA1cBw3uIFJw4Gf65wmMO2UqTc+F4s9bJ5+TyUEkwGdY8oCr9ZBIvO2Bz8tzz
 GFWCjJ2X9GpvCXVRsHOjuAtzQY+zDeamSdAaSmxCx+SM05MFMUt53JTmBecp8xBA6w/mryszI
 PU9ndFD1J3U3Pl9sh+3RNNgBwRB9HZF9rWs5Bkbz94U8pIRKCxav7ojdmSx6d6SGOhBmbhOl5
 p/tPEYB0PXqLCglsVzE+650DxSgPifuJmr+9592Vh6OjY384voQrQFvSe65q+dzoSmoYMYzB4
 sE8VJwUSkTk1161t1+9qzBU+gVrrGHd/PfJtzGs7Rm0Ou5kYUR4CnjtefZIuJKxlxbbU29WWJ
 kGiK9aICfxDhWANsyKZ9QwlaWxZ7e+bG+MqcmE/I3DxIs4F3D53d8Vm/1gn7zgrmL1KiyuSZ2
 3SacLt7TdVo4kM3MLSt5CdP+AxNBAXcwTE8Cy4mHVoDNOHgztGLGzKVB4UdO29dGXGLmDUHHk
 Z4wSQbE66gN7+4pDbDUc5U03YTZ3jsvphxj8U6LOv0+dX3NgWE7hkmbxAA6m4lGVbJ4QWFDW8
 fuA+JppOaV3Fm2tuCQ5lzQTLY6lgpQT96ME/EUYMtYWT+AzHPjIwZoPCwnTt7eRp4F04AXgIF
 WzqtPeQ0ZQ/r9Pfk27OTM7w1CCceSbdZLtCA06MSWkN89GmH8b/ZDCZqFhlb4yfzNtaNVCg8+
 yZaXe4JsM0f1iCA05qDKUovnAigL3g

Am 4=2E Dezember 2024 10:28:52 MEZ schrieb Chen-Yu Tsai <wenst@chromium=2Eo=
rg>:
>Besides the MT8183's MMC controller and all its compatible derivatives,
>the recently added MT7986 and MT8196 also require two register ranges=2E
>This is based on the actual device trees=2E

Hi

Mt7988 is similar to mt7986 (only using different clock settings) and usin=
g 2 reg too=2E

Currently there is no mmc node in mt7988 dts (i currently upstreaming it) =
so i guess this is why you have not yet noticed it=2E

See this for more:

https://patchwork=2Ekernel=2Eorg/project/linux-mediatek/patch/202412021226=
02=2E30734-3-linux@fw-web=2Ede/

Maybe you can add mt7988 compatible here too in v2=2E

Regards Frank

>Properly enforce this in the binding=2E
>
>Fixes: 4a8bd2b07d88 ("dt-bindings: mmc: mtk-sd: Add mt7988 SoC")
>Fixes: 58927c9dc4ab ("dt-bindings: mmc: mtk-sd: Add support for MT8196")
>Cc: Frank Wunderlich <frank-w@public-files=2Ede>
>Cc: Andy-ld Lu <andy-ld=2Elu@mediatek=2Ecom>
>Signed-off-by: Chen-Yu Tsai <wenst@chromium=2Eorg>
>---
> Documentation/devicetree/bindings/mmc/mtk-sd=2Eyaml | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)
>
>diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd=2Eyaml b/Docume=
ntation/devicetree/bindings/mmc/mtk-sd=2Eyaml
>index f86ebd81f5a5=2E=2E9ea035928563 100644
>--- a/Documentation/devicetree/bindings/mmc/mtk-sd=2Eyaml
>+++ b/Documentation/devicetree/bindings/mmc/mtk-sd=2Eyaml
>@@ -235,11 +235,18 @@ allOf:
>       properties:
>         compatible:
>           contains:
>-            const: mediatek,mt8183-mmc
>+            enum:
>+              - mediatek,mt7986-mmc
>+              - mediatek,mt8183-mmc
>+              - mediatek,mt8196-mmc
>     then:
>       properties:
>         reg:
>           minItems: 2
>+    else:
>+      properties:
>+        reg:
>+          maxItems: 1
>=20
>   - if:
>       properties:


regards Frank
