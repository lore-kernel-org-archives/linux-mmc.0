Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225E4085C
	for <linux-mmc@vger.kernel.org>; Sat, 27 Apr 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714215360; cv=none; b=HFUWdo2CLbt1qcJhYlmSQzpemNBSq1Qkxax30pb8UqGZVvxq7B34X4/zG+lZ/TOL1XOjA2qe+aSBWH1xDoyIGCtq+gga1pmlaAQhZVlNhzm53bLNBlVxKtlmeDX9kAZWwB6+oWKs1MkYEnXhJ9008lnr/KLuhpxF0nZIiVpYXbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714215360; c=relaxed/simple;
	bh=30Y0vDFTIC+GZ4kILAnfrxpQKyxIfE0SN088Unsl+Ao=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6i5VRD5WPyXksyFcHK9CMKs41V+2xPQUoprPkhKGKpOAYuLhvT72u3J7j4qEP0N32I/0UD9LdFW6m+Amt7U0Jt9yZh5QUqX5GHYJd4n/1am8LSpJcxzV5HmFWyJm9iDBsw2oAZj5Jbu5N1T25JKZU8SN8mf4OPI8Ta500bTs7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=M4KUxJ7U; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="M4KUxJ7U"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso4681955e87.2
        for <linux-mmc@vger.kernel.org>; Sat, 27 Apr 2024 03:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1714215357; x=1714820157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AVy+Y3fQ+ZL5eTtoRlGJR4TNBIR1UBCGRhefmZftvMw=;
        b=M4KUxJ7UOZz4VX2NoiS+se6iptl8tDexJH5RdwaGrt9ANLLx+HwZ7ECBLS8UdKGbL3
         mdFVDsXRI6Unub6iyvenM5bt0lnOKrzQCl21RPGMmrUgC7xJeljhZhCYsHkAVntbRkTd
         01o3ncEnSLrlZLxROFkYSpSo8JdCMKBepg3O+Zd3aoFuLrhW2M6MWMROh28/HuSTTj5f
         OlAPQNV4XrzxKM9uhyd4VsmF1ItZHbiH+AyraT9twOAyFa31Xlmm+wdQuP+i65IwAxKz
         CU5AtVkDxBgMVX4DcNlxmNo1EkxBJrwiM4hidscO2IXdeQF6avCBuA1ivjeJlJSEf3Qw
         0X1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714215357; x=1714820157;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVy+Y3fQ+ZL5eTtoRlGJR4TNBIR1UBCGRhefmZftvMw=;
        b=Lk+dOotmPR3ozbmKtoyuNEzloU1g8FcEqCJ3z8aNmseKI3setjd5OCTDRO2sZwCfTM
         xnu04RHe83yz6sV48OkE2GWPCsJfasTaebVYSo7qhsJ9sB6FJnDOjulhXZL/4FcVM0WP
         y2GoMxWJbxOQUGC5i/cLisc7NSXh7VVghzMmL4hhM+gznERCPGJAkGez7EQ8lSY/Ju42
         nxQ10jDf6M+fykVHQQWprDfYQxZ3SYxCgQMynZ3YT2FVSz8DQUxcMb0veQXkc8spCcAP
         nMwzCyfLxj+xL42Dw8MoEoMIALh48u+7CTkn3Yi9XoFNRlc6fCoziAKA7Dfsu7js8KCq
         vSdg==
X-Forwarded-Encrypted: i=1; AJvYcCVqCPbfjot6r0Z6v1ygrLwufx+DnRJwr9o5sWzv/hTFUikOyNPNqGoWjhNIYbQ2S4FzPGMJkPaXR72a3uGSkVA3tt8LjU0Eh4HE
X-Gm-Message-State: AOJu0Yx3d9gakr4aneCB+HCTk00nPY7xOKG20v6eTobj72vZDa/63Akg
	r36plMJuZZlzP0p7r0UaQ+6PLGcT7p09Ejwq1p/yAs8qBzCaIDigJL7FPRI8PIY=
X-Google-Smtp-Source: AGHT+IFbYDgaYUGXxbXGJ4orAbrnlEp+fN+SYD4kxVugbNaLRY0H7Dzfacf9J7Mf14vZwL/Y6Mmgew==
X-Received: by 2002:a05:6512:329c:b0:51c:778f:b569 with SMTP id p28-20020a056512329c00b0051c778fb569mr4049642lfe.29.1714215356833;
        Sat, 27 Apr 2024 03:55:56 -0700 (PDT)
Received: from localhost (host-87-1-234-99.retail.telecomitalia.it. [87.1.234.99])
        by smtp.gmail.com with ESMTPSA id i13-20020a170906090d00b00a588dab605dsm4285140ejd.88.2024.04.27.03.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 03:55:56 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Sat, 27 Apr 2024 12:55:58 +0200
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
Subject: Re: [PATCH 1/6] dt-bindings: pinctrl: Add support for BCM2712 pin
 controller
Message-ID: <ZizZvpv3yomm0L3i@apocalypse>
Mail-Followup-To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Phil Elwell <phil@raspberrypi.com>
References: <cover.1713036964.git.andrea.porta@suse.com>
 <2d1272cad92ad618297a6683e9264e31b8f2df73.1713036964.git.andrea.porta@suse.com>
 <f6601f73-cb22-4ba3-88c5-241be8421fc3@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6601f73-cb22-4ba3-88c5-241be8421fc3@broadcom.com>

On 08:45 Sun 14 Apr     , Florian Fainelli wrote:
> 
> 
> On 4/13/2024 3:14 PM, Andrea della Porta wrote:
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >   .../pinctrl/brcm,bcm2712-pinctrl.yaml         | 99 +++++++++++++++++++
> >   1 file changed, 99 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml
> > new file mode 100644
> > index 000000000000..2908dfe99f3e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2712-pinctrl.yaml
> > @@ -0,0 +1,99 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/brcm,bcm2712-pinctrl.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Broadcom BCM2712 pin controller
> 
> This is not strictly speaking BCM2712 specific, the pin controller you
> describe is a Broadcom STB product line pin controller.
> 
> Please describe it as such as and make BCM2712 a specific instance of the
> chip using that pin controller, see more comments on patch #4.

Ack. It turned out that the pin controller is not strictly need for a bare minimum
support of sd card booting, so it will be drop in patchset V2. A future patchset 
will re-introduce it when needed.

Many thanks,
Andrea
 
> -- 
> Florian


