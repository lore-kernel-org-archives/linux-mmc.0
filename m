Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66AB23F397
	for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 11:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741778700; cv=none; b=GsSMBm67AKsC5iMqh+ZDMlHDMXHv/ATE4c7kJj7D1BQPDiQasAW2bw89i1tKooLp489a7Vhu3IophB4TyFBNA/f5Lps5PV+hsxbIIr0EF6PGe+YOpOToyqkOFsElhTPwTTqcSvTWzeSyS4vbxiAYUqz+ObYjTaoksTn2QEe5LQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741778700; c=relaxed/simple;
	bh=EyLOE0jVe6Ot5eLlgUxopazARR5tkTAv5HgZzzFVFuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AguM1AwklFkYKTQ8ms6CIe7Sd6qWwaxWlCao+zVfH9ImXQGDuovQikLfi4yQO50IVNJkh7jCrL3lKhWgW/Hy6bRdtUhzWH5yoCIeqRBNDJ1hPnsKXfXtKwzm/nTg80IqulFUscdUevEINGdLjXmRCamrjqr9apTImq+mM9iX+ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TW04dLOY; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TW04dLOY"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6ff07872097so21849277b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 12 Mar 2025 04:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741778698; x=1742383498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ESIBsTzEIcUZ/ECc1taqnCKMBy5hYudFtIt6EODPkzM=;
        b=TW04dLOYqmJcdFVfoD1FwNrpW6qBAaxIMLsDcy86bev1MD0l/2dia6uIyiG90guYeL
         Z1NWmiPuAfk+cg1pjWJGKQR0j4CyDec5iy3i8eqhqg+hRoz5pcQv7+4V9iAzS6ZsKy56
         kA33yT9zhgGkrcw8wGF1jLioE9MOLf8m813ZM0YHpqpBd3CC3Vqk7SLOKsbe+0iq1G7P
         oxxr1o9bpUIi+HOgOFWRAKT919GPnpwwXUjSmsotCwreJnfCDTv4otYoh7OMkdx0pf8p
         +72Ix1x0aNydFTV9UXKVaJob4sTsk2Ivq4L4/WE2G55mi6uNL/BYLYag2oF7hKemDybx
         fvhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741778698; x=1742383498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESIBsTzEIcUZ/ECc1taqnCKMBy5hYudFtIt6EODPkzM=;
        b=OuR1P2Hz1my1MEwAPCxilNcJg5GykkbWEZ66z8Kv1e8g6l/VPnp86m4U6uF5auVTuy
         UEoe2ZXU8+QCi64/nPgPc7dXGR2vAwLGqnP+YX6Is6ou1JUWjUHxK6NKbIx2GtxV/9An
         yA0KUNODW+5ovl7fnEjJgi1zqQHQrSrUTVq9ogGbqvxwWG4U9BcmoOzabTvQ7/7B9GD6
         HIOrahJsoBN4pI/SqlM2e90lb7tzpbfmrWowpR2bswcqqt39YNQMFF7jR9tHpoY66Veb
         HcQ/qmI09J0YXauiMTiqJ/Cu0GuG6frtBWvZqqEOboWSN84gO2o4GG9/TJAKoBs3cO9d
         8XdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvZ1C+ZkEPzIoLRPKM22sgUd+6gP9TcoocyRXVOFag6nKOXvdlEWvgLn8+5cZT4uLymCIMXlPyTxM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/q9JfGlfG6nKZlTtBROLJgRtLJi/nrXoAUEZmlMr2sMPnykFH
	QW57UAw0up8itmaamhHJgoEkOsxJ4LEr1rIhLS37rtUbzKlhItqXPF8ZmD1fvEnD2FW73fALpUf
	StABuj39pk06zUy8TUaaDNgiqY1sLJdHmWSTmEg==
X-Gm-Gg: ASbGncsCzXIz1O/+2zfIHwErO5DOAaGEV7Bb+87f6ME0lCeFaNRAq5msWeqAT9hvJ7p
	mPcnvqN39B0a16TYqR9vKoxwDpr86P1Gy/qSN4pIvVt5WfYsvHdHJERb8SqQzkzprBQpq6Ugzsj
	vksYiq6Q7sCxDV2246K03JHiMHjb4=
X-Google-Smtp-Source: AGHT+IHtmnbXh+/xWHNRtVc/+e25TtwDya77gAG3BQFWZJv3xY+g85qmMUghOraOvNz9vB+GjgG9TqOZpEeA4ZqkZEA=
X-Received: by 2002:a05:690c:30e:b0:6f9:8436:3d2a with SMTP id
 00721157ae682-6febf3f7f61mr306802797b3.32.1741778697916; Wed, 12 Mar 2025
 04:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220164655.2081224-1-Frank.Li@nxp.com>
In-Reply-To: <20250220164655.2081224-1-Frank.Li@nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 12 Mar 2025 12:24:22 +0100
X-Gm-Features: AQ5f1Jo7KEKuskQ_5cOeKngtf3fN-L7jwpx8y4RoWNvAYB-ewPO61CKAdCrGxr0
Message-ID: <CAPDyKFrxGzyNsr5vQjcxPRzyQMTpoR5sZjreYbO_8ZA6i_-XkA@mail.gmail.com>
Subject: Re: [PATCH 1/1] dt-bindings: mmc: Change to additionalProperties to
 fix fail detect Unevaluated property
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, 
	"open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." <linux-mmc@vger.kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	imx@lists.linux.dev, shawnguo@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Feb 2025 at 17:47, Frank Li <Frank.Li@nxp.com> wrote:
>
> mmc-controller.yaml is common schema file. According to writing-schema.rst,
>
> * additionalProperties: true
>    Rare case, used for schemas implementing common set of properties. Such
>    schemas are supposed to be referenced by other schemas, which then use
>    'unevaluatedProperties: false'.  Typically bus or common-part schemas.
>
> Reproduce steps:
> 1. Add unevaluated property 'abc' at example of fsl-imx-esdhc.yaml
> 2. Run make dt_binding_check DT_SCHEMA_FILES=fsl-imx-esdhc.yaml
>
> No any warning report. But suppose report below warning:
> mmc@70004000: Unevaluated properties are not allowed ('abc' was unexpected)
>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> index 9d7a1298c4554..26e4f0f8dc1ce 100644
> --- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> +++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
> @@ -24,7 +24,7 @@ properties:
>    $nodename:
>      pattern: "^mmc(@.*)?$"
>
> -unevaluatedProperties: true
> +additionalProperties: true
>
>  examples:
>    - |
> --
> 2.34.1
>
