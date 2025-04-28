Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99527C862
	for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857327; cv=none; b=T00efJHFxPf8HGdBuH+JXHT0rC8eGq+/Hh3vXI3scarP3G2Wz4eMbHJVWganrUI8vOtzlZeVRpnGbyhS87G1UeqCe4UG6tk1YBdFpmtF2W2ksYGezDm21fYWdTHjdiAZISh00j7hA2PSOGl7Z7rmcT2dnyUYmiKNKa+A5QIOHQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857327; c=relaxed/simple;
	bh=bpFyqVnuV1089Ku+5ux8rJ2ecmqFhHkgxj5EiEeZRv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQzhZsX80a2kPw3IxgNiziUm5Ejo2m5q2VXcZOLf6bPMbXW+Dy9r7Iwb+9FsWBw2WK9frkzPZq+etNX5j0w9zg1t/FbJXz+Sk9VgJ0lBGoq8LntVNCRQUlVTigcR+uefF7BA0jqtHOpzxGbs7CnVylW1QlNQ2IqpQaXks1Rv29Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NibRXpgW; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NibRXpgW"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ff1e375a47so51996427b3.1
        for <linux-mmc@vger.kernel.org>; Mon, 28 Apr 2025 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745857324; x=1746462124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jYJtlwUK9gE9rMaYOlbOBvLsJs+lLIqjK+LtZtlE7Pg=;
        b=NibRXpgWAWIKe5UMYOjZwFdat/f/I+EKWRm4WbRkQssJjXtQsl6YiIiMbHZ1qH74Of
         MlKo8+yt0mxBlg0KLHVgJDxuohwL0SCz24AlRuaMxgpgF9/YC/oLK40moVsqqMqevn8Y
         rQVFoyCF7CAMkeLlmUToFc2Z2F3IH2Nh+hQtZPHWLoZmPfIRCrJOBp7bWc1xpN1iA3qq
         fLGxERY1f2GGPm+mguKAWuf5P0dDgNZmynZp6RYhAGnjO2XiUqucFcy7rTetzOGUwpQA
         I1MWLY2isG86wcMrZAPYHiII0LIhW2NSBoBnFEcJKlUBRfFxspqxJO6jsklIJvKRld+j
         H2aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857324; x=1746462124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYJtlwUK9gE9rMaYOlbOBvLsJs+lLIqjK+LtZtlE7Pg=;
        b=dB5UpNkVGBTxp5C3qtKGnGMErFeZrEiK/fbtjCJ398FG9UOh5vHlGMU9bKJLo2KHWW
         rMLZ+QAeGLCKAL7CTnhYQwxCRNKTP9IHSD77drLJYaQlZvHX0QvQKyX9XunnP5kqmsaP
         R8pm2l317X4x+hPHsEBG7hQAfgQtQX3g0Vh0MzVKlaes/a5pAiMu9T89QHR9t5v6t78O
         r3KqdN6ReqcU+TSzdSMlRIGZFBqO2/9Z+0aaTQqD7Y65bUthlkdSsqT276eaP5G3j1jz
         9EQRbpS9SPSmJCZRIKWnlYv77FulJd9IWtosHued0ReEEhF6HOCxoSfS+jJNr5MHsdmh
         0doA==
X-Forwarded-Encrypted: i=1; AJvYcCUjcjbvYg25Lg3z1AIa9+CwDegiiHw73wbOAh8qCzzKVP2nc6SgdQ42+4ZF/GXM3BeYp4ZMIiJXBC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypL72aq60dv/RGQrfUGhnaBarOAFaQhkQLxnTGNEqfmJS4u8U1
	SrtTZQBIRVwKR/9ndErlmOE+q2eMCJbsvWxbnBlTNZ/ktFF3nKm6gkPGM6ULy4Mf5Sw9UPs8LAu
	zD+vYNaoJj9Dvs1OzNlKjlI2TPyjj8ffBJsvGxQ==
X-Gm-Gg: ASbGncsfO7hKEM1fP9WmD4ZClBaBvTkxcG+7BqKegarc2rKg4mtjHimhdCZc0DQO2Al
	nx+B/ttvp2cqIZ6V32z5qXDG/nuZpGI4LKomxDjsUb+/uxc0Gv/Da7DLCEKia2nXqeLjXQoihjA
	ixXp3wpbEaKOyursGBgo+rmZc=
X-Google-Smtp-Source: AGHT+IEnuPZVaSvesgsXBNiFjLoJWiZy53DGC9o8Sp1zW11942XKrl2X+yuR17blEKZkX8LjsFHcDXXyS5d8LGqn8s4=
X-Received: by 2002:a05:690c:4905:b0:6ee:8363:96d3 with SMTP id
 00721157ae682-7085f23733bmr133253447b3.27.1745857323624; Mon, 28 Apr 2025
 09:22:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417151300.3570021-1-Frank.Li@nxp.com>
In-Reply-To: <20250417151300.3570021-1-Frank.Li@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 28 Apr 2025 18:21:27 +0200
X-Gm-Features: ATxdqUFvglZC6L-IAvGpqWBDcRfYWiynLM-kZ_f4pW7hBaIPW-FcbcKpWQ_mW_g
Message-ID: <CAPDyKFpEGn=xcaG=QF4KkvLxwN3Ak41dJ=1mgY5oDn2pRYJktQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: fsl,esdhc: add compatible string fsl,ls1021a-esdhc
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 17 Apr 2025 at 17:13, Frank Li <Frank.Li@nxp.com> wrote:
>
> Add compatible string fsl,ls1021a-esdhc for LS1021a SoC.
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
> index b86ffb53b18b5..62087cf920df8 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl,esdhc.yaml
> @@ -24,6 +24,7 @@ properties:
>            - fsl,t1040-esdhc
>            - fsl,t4240-esdhc
>            - fsl,ls1012a-esdhc
> +          - fsl,ls1021a-esdhc
>            - fsl,ls1028a-esdhc
>            - fsl,ls1088a-esdhc
>            - fsl,ls1043a-esdhc
> --
> 2.34.1
>
