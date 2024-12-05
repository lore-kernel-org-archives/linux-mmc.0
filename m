Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1196726AFF
	for <linux-mmc@vger.kernel.org>; Thu,  5 Dec 2024 03:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733370078; cv=none; b=RK8h/pFqQwU0+05O/HnSZCzjymCxF75mjgZApbW4LuvCQk2AjvgZBYplqXYMeW+gotpzOpIcPxCvEMmQvUjyXwiJyHbCMZi+CMSbgXd1aIr0PyCQ0oyfBwYX0bowjmcbEkRDOQJcAZ+S0lxTR9JfCvsmpTsK9kGZa9HJRF6OHoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733370078; c=relaxed/simple;
	bh=8ILclPDNeqSnZ4d4adFACLlkV1PYPYXs8E36ta2tDWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JN0qZNAIBc1BR3949OGcf9AqJfBC0/RkX1Hb0liCS7Vvqj7zgt5VR4mx+D4lcpXDeFOlCuZHQ5w+wdM68UiV9H1yR+QGrJ8DtVDInsqUExtF1f0oNXcdEeWaj7PVdKj+DSr78XUdgSe2ZfgZOpCzMpEESEhg/AD0QDHI9W+I4SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FEFNrATf; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FEFNrATf"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53df67d6659so462672e87.3
        for <linux-mmc@vger.kernel.org>; Wed, 04 Dec 2024 19:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733370073; x=1733974873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JwfLitJcijVjn3mYmWjqS2pZ/U3vybZ9MoCggOPZX9Y=;
        b=FEFNrATfOjEwDJIJwKs7wzBSAJxytdGtTNh8t0ehBYRV5mQsDmQCkunBeaH3uVocTx
         PzJWfAr8GeqrpFT7e08l0OwQtfycDP2EWh51hjg4yvIcROg+GFDKH6h7kbLzcw5m0gxy
         wJ9pgvF0/wG1MhHXpyoOvtv5zK7ULh3OGV/H0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733370073; x=1733974873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JwfLitJcijVjn3mYmWjqS2pZ/U3vybZ9MoCggOPZX9Y=;
        b=qvjkLJP8rdxEyVou1WYpgRlW9BFfGpdBzwxLGDfBuZ1/l0yDUOEgDokROqMOlAo7a8
         7/ePRTUqItLyMWSKZB9LgbBKa41P1Wm3ebdyspRsXS8atXzqXD/TCwvnMW/WyxkeV42x
         LS2ucoH2kbm4oym80zADk+Y84vcniqcq5mcuQDp8arqKivQAYfPiF8mP2XJ2kdBASMa4
         R6ZDBy5JigLoOACAdtFAgrxDvayHVB8XY7ew7r4j+tXlYPPS4Z1yRveEY+Hml1ytDxrE
         Sl9hMQ6Z5qdgyoyxrpT7zyAjXNcyncM+iXwbLABjys4puXFU5uC1s+eeDiXX2TyaoGQ6
         t2UA==
X-Forwarded-Encrypted: i=1; AJvYcCVsZUh84xvaUJMN5g+DdlVQIwdZTI4pSRpI+yKnyVgm2zkvOVgCUoImpIRIElwfy6qGWd62FIB2MIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJ5lDxlUzovprAJ9VHzWgyMeMpc14N1PnGd3eMJrXFJ9hoCMK
	eGk8glYqeHjIfj3ZZ7e5dAE+eK5m7SYG2JDa+xEqSDBGgaTv37WPaDQ6ti6eV1gqiwWazx16ewE
	ZJZFMhcrnjBUVW7OO06gAMmtobnjeCjTqt+jx/ZWssOkF8xA=
X-Gm-Gg: ASbGnct/0Zmu4pmszLJSFNbyDfA3yRVtFFP0+cp3hUgBLP3n8iF7WgFUIsCCyP2vtfe
	V94zLSpUIaKsWkD3AxpLO1wMmZRGwq8Wq/DMjK8bnVklHlcVuafT4hFha/Uk=
X-Google-Smtp-Source: AGHT+IHqgDnUkKGPY8hz6ukhVqJstOuAN0fggL2+fodGywtVNADNTkDdluEMvlUwqS+eqw7nTOCdm7Cyv8kDB7dlMcU=
X-Received: by 2002:a05:6512:2822:b0:53e:228a:85b with SMTP id
 2adb3069b0e04-53e228a0a02mr191564e87.11.1733370073161; Wed, 04 Dec 2024
 19:41:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204092855.1365638-1-wenst@chromium.org> <20241204092855.1365638-2-wenst@chromium.org>
 <4762E5F1-59F2-40D1-9D22-724107623AAB@public-files.de>
In-Reply-To: <4762E5F1-59F2-40D1-9D22-724107623AAB@public-files.de>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 5 Dec 2024 11:41:01 +0800
Message-ID: <CAGXv+5EYf9-r88nv7zDo8JFGhMFyzVPU1gBNwkETvGTp+27q0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mtk-sd: Document compatibles that
 need two register ranges
To: frank-w@public-files.de
Cc: Chaotian Jing <chaotian.jing@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, 
	Andy-ld Lu <andy-ld.lu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 6:38=E2=80=AFPM Frank Wunderlich <frank-w@public-fil=
es.de> wrote:
>
> Am 4. Dezember 2024 10:28:52 MEZ schrieb Chen-Yu Tsai <wenst@chromium.org=
>:
> >Besides the MT8183's MMC controller and all its compatible derivatives,
> >the recently added MT7986 and MT8196 also require two register ranges.
> >This is based on the actual device trees.
>
> Hi
>
> Mt7988 is similar to mt7986 (only using different clock settings) and usi=
ng 2 reg too.
>
> Currently there is no mmc node in mt7988 dts (i currently upstreaming it)=
 so i guess this is why you have not yet noticed it.
>
> See this for more:
>
> https://patchwork.kernel.org/project/linux-mediatek/patch/20241202122602.=
30734-3-linux@fw-web.de/

I think I noticed it at the beginning, but it then slipped my mind. I
might have gotten it mixed up with mt7986.

> Maybe you can add mt7988 compatible here too in v2.

Will do.

Thanks
ChenYu

> Regards Frank
>
> >Properly enforce this in the binding.
> >
> >Fixes: 4a8bd2b07d88 ("dt-bindings: mmc: mtk-sd: Add mt7988 SoC")
> >Fixes: 58927c9dc4ab ("dt-bindings: mmc: mtk-sd: Add support for MT8196")
> >Cc: Frank Wunderlich <frank-w@public-files.de>
> >Cc: Andy-ld Lu <andy-ld.lu@mediatek.com>
> >Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> >---
> > Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 9 ++++++++-
> > 1 file changed, 8 insertions(+), 1 deletion(-)
> >
> >diff --git a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml b/Documen=
tation/devicetree/bindings/mmc/mtk-sd.yaml
> >index f86ebd81f5a5..9ea035928563 100644
> >--- a/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> >+++ b/Documentation/devicetree/bindings/mmc/mtk-sd.yaml
> >@@ -235,11 +235,18 @@ allOf:
> >       properties:
> >         compatible:
> >           contains:
> >-            const: mediatek,mt8183-mmc
> >+            enum:
> >+              - mediatek,mt7986-mmc
> >+              - mediatek,mt8183-mmc
> >+              - mediatek,mt8196-mmc
> >     then:
> >       properties:
> >         reg:
> >           minItems: 2
> >+    else:
> >+      properties:
> >+        reg:
> >+          maxItems: 1
> >
> >   - if:
> >       properties:
>
>
> regards Frank
