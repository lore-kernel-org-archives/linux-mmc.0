Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7FA2882D3
	for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108865; cv=none; b=gyOo5B20UI0MIS7TlxqVKxKe+Wlsj0DxVdpQEIAPe//lF3DovZm0d8R0zCK54G/4sXCMv3tvfzNbj2I++NwqjZmSfnP48lKi8r4Rv4q9cMKViSL8uiOCwyKpkBafv0lVArteBltr5C2hwIthaLxtDBW/V49twS/91MekgpsLlXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108865; c=relaxed/simple;
	bh=dZSodkbE5/6Z4K+bFidaBOlhacrE2QQfWb9OjIApyZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PAB4Xh1LAVycx8L6H19jxjfuO2yc3w6IdRUUqd7o1q2wEPc3IsB3sBH6fOKn+CofHzl2QH7U6BEi+dmkwrm4FdooHg82tF9HOdj9djtJf0049qhZx4ZrhA4AITQEnFiu3y2eSgw4RgG4zf9P1xrA7yhaa+cS8YdB/f7r26ARft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QoGp8zVo; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoGp8zVo"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37b8aa5adf9so64856991fa.1
        for <linux-mmc@vger.kernel.org>; Tue, 30 Dec 2025 07:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767108859; x=1767713659; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AnmwhxY415JhuBFjf99xT9gSeFG1Nkzo5OtJjVGKyn0=;
        b=QoGp8zVojiySF5FfVqc8D/7SuWJshFPUYVYS7FPDUtvdQcfF+NyxZTkaPaPwE+FjNV
         QGgNALy+J5vIzkt9mKm3orI4n0NQ3AjXzl4NsqurKtoRvATqc1S4uVMKhfGf2JAhgP/e
         LAlQn7RMxO2EUSHpqwlAmqlss69lSNXVY0RIR2eIcJ5mQN/Cc1mg1Qcz66q6oFlsxeKX
         5Uda+BPHfxAVbbLlJRL5uHPYvNbntTgCcFXQOf397oFh/jUPWi3/kzpYGeOI9oSBOQV2
         bWGjpKhEwNYysYJkFsv8YrbYUsmKxtwFIkfmUMkktWdvJ5HJbp1vDhVskeCtUoCcdnXw
         39lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767108859; x=1767713659;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AnmwhxY415JhuBFjf99xT9gSeFG1Nkzo5OtJjVGKyn0=;
        b=VluyCwtCRWDED1a3pi4mtu1wBVvngNnzgyBLwFMiB1EK2XzyXZk0bqk4uHaqh7r9Vh
         8JhEnn/NxDY9l26YUcwXPid9GqcqoNxzK9KrnJyOJKHXL6rVFXA+R+Z+KcYHOPca4cPt
         SMAHyYHe5CV757diydSdqCNPh++d3Wz6+41y1Vk2kjzL4ghjX94sKFPX/2mFfFHTM1Ld
         aVlSoLmVoDlEbeQF8ZEnjR3p/xxE1tQo6KOPiJT/msW4774deAAKs3ZUT+7EjTfx25/8
         lUWEhJIA7rDYTtxp5Tl2cpaLymMV/WqrUKaVtm8bvK1Dk0+q4MLncfT5nqXgVVosC11l
         4dHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgb1VwJyuuJvqj5ORE755qnXPcIQouO/7DkJOQRglJATrx5K8IUuMW0USqbE/CT9hhI2mOng9NgjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvLU+c1ddvCaDPo3VNCnCXbZLanMzmSWhuwMtI+64GldPpIV08
	xHPm8mW5q3dYnK5JluH6zomimhgV/zslunRK8q5IXO6DoTnzMn0KKE/KtDbSvWfn1wo+Ce+6X5w
	6us0RzgU6BLQCuz7CTuT30u+/EoENiwnPqGMMy67JZg==
X-Gm-Gg: AY/fxX5M2Z1jL+f8IFwtiP/oF2AFY6iHPqgZIW6gNwJkZ8Osps2993ykQ+4rZm+tfcl
	h0P/aWzRCTf2YJANapMMxnSvt/l+ZCAZdwoMsdvzEVGjAu2p4/pFKz05CxdyoNTHnmQkpmMmOdO
	tvptxvxyHhkWkF6VdF/0z/IAU7dVje9JdEAUwCDeXe6A73EWFbJ9MTISdmnZ8lmePHG/q7m+eA1
	QtHcU7xWSBSNgn+0gCRUJ5b6rjVyResBPHRHsu4UDDuGh03r+lxEe7qEDUKdfqrDLZ+rInL
X-Google-Smtp-Source: AGHT+IEW5MCCMztJEcOlaEFCIvi3KU9NMQMaqTxBXuzKZPmVo1f1oxiQEdMGa9fcYX4NA2q8jUD2x8uH2/ni91ZM6F4=
X-Received: by 2002:a2e:bc0f:0:b0:37c:c84a:99b9 with SMTP id
 38308e7fff4ca-38121605971mr101636721fa.24.1767108859386; Tue, 30 Dec 2025
 07:34:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251225181615.1402052-1-vz@mleia.com>
In-Reply-To: <20251225181615.1402052-1-vz@mleia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Dec 2025 16:33:43 +0100
X-Gm-Features: AQt7F2oBY1dHJwylW5gRmwSRBH1bYF8wF2Tb2mX6ur1EQF0YPxufnczOkLVAsew
Message-ID: <CAPDyKFq7O1mUxpygFzy2g=MqBUxb2mXyfDS0CCUoR2CObs_2sA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: arm,pl18x: Do not use plural form of a
 proper noun PrimeCell
To: Vladimir Zapolskiy <vz@mleia.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Dec 2025 at 19:16, Vladimir Zapolskiy <vz@mleia.com> wrote:
>
> As a proper noun PrimeCell is a single entity and it can not have a plural
> form, fix the typo.
>
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/arm,pl18x.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> index 8f62e2c7fa64..066f21deb3e8 100644
> --- a/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> +++ b/Documentation/devicetree/bindings/mmc/arm,pl18x.yaml
> @@ -11,7 +11,7 @@ maintainers:
>    - Ulf Hansson <ulf.hansson@linaro.org>
>
>  description:
> -  The ARM PrimeCells MMCI PL180 and PL181 provides an interface for
> +  The ARM PrimeCell MMCI PL180 and PL181 provides an interface for
>    reading and writing to MultiMedia and SD cards alike. Over the years
>    vendors have use the VHDL code from ARM to create derivative MMC/SD/SDIO
>    host controllers with very similar characteristics.
> --
> 2.43.0
>
