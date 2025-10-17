Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BA821B9D2
	for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760707857; cv=none; b=J1MsSJ/WDtAcEhoNzoDaZK0Ne6lXz+te+0U1qyk3bqMFBdd1XQzM1XMRl1vuZ12Se/wMdZe2sMdqygu7Xp5+aGKLI+iC0LOltuag43kh7mNIkKlaVAIX9KwA6+M4CT2wKOQkzBW5J3VZxM4E1lyTi8gWewiXIj7Ybz0XwkQJJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760707857; c=relaxed/simple;
	bh=8h4MyfofRRgMJU0FH6oAiG30tlFhnJzpo3CvUEr0yL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INy/4VVLXVta5flQBg4cm0Mj54K9enwrdrbmHhFZgFMQBu7uuHp4WJnyWmb4mSL05sfIUw9NpW6MyWFuEG/7sfk/Iyr3G+eBHBXBJMUzflMpZBH2sU6ZcniF7D55K4NpRjt4MwAx2h+GQC+vLXIRdBt7Bx0fWp82wHvhtJxqxVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sCcbaEbt; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sCcbaEbt"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-633be3be1e6so3078381d50.1
        for <linux-mmc@vger.kernel.org>; Fri, 17 Oct 2025 06:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760707854; x=1761312654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5X7BQeA3rXzmBQbgRKoHIxB7KAjrjMKVEn539LLi6sA=;
        b=sCcbaEbt1EaYifDeeqmx8bRhf4wd2X+XbTj9yzsoLq90Hd23tHHw0ja/Rb23OTTD8w
         epkAXbw48CQU+V7LVOZ0ii3v0uQ9dLoC6IQXX0gJcC8nNqy2DpUEDIESo1291S0KlcGd
         OsBVpK0J5xX4J77q6MUH5FE6zHA/nFHcFwwQZBsoINgy5ifeNW78FJFlEsD6xEmejVkH
         G3hCzpF+zlAHtzjgdiNB8dCumx50NB7b1LLbCuvHFM0TbKl2jwCuv1ZulTcKnuVoP7gH
         C9mSSZPZPs9zsYrTkhL4eYiyhBykY6gilBOWJhKlbMsgYlzoxU877JjlUSQszcCNf92R
         2MXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760707854; x=1761312654;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5X7BQeA3rXzmBQbgRKoHIxB7KAjrjMKVEn539LLi6sA=;
        b=HCis/5gOL8hoBn+R/zy5dZ+Mlu/EIU2LIQONAq3BCmOQULdFu6Tn8ZMxhcLTe6XQfI
         1Fnv+GJTNt+Y1KpRIZ1OvNgv7UWyW+Vv3uDfAwsoBrfNpifQJWAw+rkf1AiBATGKDwn7
         8glgNgsH4LtIFgMRlx10FRDmiHBW+Im5MA5q5UpNE+5hy1huBX1/BBdndrUpp9R+tQYW
         Jmz0oZrcM1iM3aKSMd1h4symseGw/Qc32weWgmYKHjEObXrhyDhorn4lGFMoG4CKhUqU
         O133IZ5P1euTZD/QlbPZvmXFE53EOYy0xAe6uUpL6eLYEh5myqmnpE6rNu6v2yMEJpj3
         nL8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBGeOlaue0Bu8MwqdHyCvcWiSSfCUC6rd22vT+sRIwSRpOuuxC22l9r04y1LaehdMPcNhJrSAcf8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYhWqwll8pQYvgs0weeGcgPNCHEXC/5e+PVCbqr7PoXNhM4vms
	M0dYZQ0bJinLxvIFh7Q+uogsfKuzGxguIIk2TVaylqru7YEVYAkTM2Mh819kKCtRUmul5KBLQOO
	kkHXObu14zFw4ZQ6BVT+W6YXAvo2BcDzMc4VqgOArdA==
X-Gm-Gg: ASbGnctg8bAPQ/9EY7sd6NXklJ0juw6r81Jv2HK7gBSE8z9soq9m1ZlqQFlr/GMR5KS
	wuTdTaYIs5sNA6nUn8FzXYIcKpiCG9pZzTF+Ado0/3zZRhkxIwvEwxQlqEgrPRvluESbZjyVd4b
	AbAlJr2qkE0boHeQ1dFr1sLg1TmYJTaYF/iHZp10ZLVnDNzkPqGpGQziJWtVODIksTdKTFfUYpb
	M2Gfk4Es7HVZXCbeeyvBABrnSAHZRCpg1t/wjikvg/i471Cp0iz6I7rwWNkZNTef+JA6n6N
X-Google-Smtp-Source: AGHT+IFuJjjPUeond6ve2TsWvJpxprVjAj4k4yWkaW70iusJk/wVdKJ5/E78uqC6hlFI+4D6JFSKhgGZ3fDtx8Pb1ws=
X-Received: by 2002:a05:690e:4182:b0:633:a6fa:386b with SMTP id
 956f58d0204a3-63e1617888amr2411139d50.9.1760707853775; Fri, 17 Oct 2025
 06:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-knp-sdcard-v1-1-fc54940066f1@oss.qualcomm.com>
In-Reply-To: <20250924-knp-sdcard-v1-1-fc54940066f1@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 17 Oct 2025 15:30:16 +0200
X-Gm-Features: AS18NWDaJ0stRMP0tjdx1D-OEVihvanFSmIUNXsykH9atcloWEZNEl8Qe24908I
Message-ID: <CAPDyKFqMYyo5i2ZVU8SBrD=gbGZMZiwYuOC+MWD0r34UMeNizw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: Add Kaanapali compatible
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com, 
	trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com, 
	Manish Pandey <manish.pandey@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 01:34, Jingyi Wang <jingyi.wang@oss.qualcomm.com> wrote:
>
> From: Manish Pandey <manish.pandey@oss.qualcomm.com>
>
> Document the compatible string for the SDHCI controller on the
> Kaanapali platform.
>
> Signed-off-by: Manish Pandey <manish.pandey@oss.qualcomm.com>
> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> index 594bd174ff21..474afc98c8f6 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
> @@ -42,6 +42,7 @@ properties:
>                - qcom,ipq5424-sdhci
>                - qcom,ipq6018-sdhci
>                - qcom,ipq9574-sdhci
> +              - qcom,kaanapali-sdhci
>                - qcom,milos-sdhci
>                - qcom,qcm2290-sdhci
>                - qcom,qcs404-sdhci
>
> ---
> base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
> change-id: 20250917-knp-sdcard-772e77cae9d2
>
> Best regards,
> --
> Jingyi Wang <jingyi.wang@oss.qualcomm.com>
>
