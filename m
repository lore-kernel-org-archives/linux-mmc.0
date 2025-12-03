Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253A32BE7B4
	for <linux-mmc@vger.kernel.org>; Wed,  3 Dec 2025 21:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798657; cv=none; b=vDj8oXBw89r7hEan2E7b2kjwejYdAFM8UzNmM6bAS9//n6nIOG8IYvX4PqkGGXUbKbi7xTuf5uEjAfO4KuG1PHURVaSTrnh27iSl7xEFxcHmdlLGaUie2M00UkKoa+lsKFOzSvEZGNE/HGmFzexkKHQnjotUQ/+N5draDhXtgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798657; c=relaxed/simple;
	bh=PZj3jANR6/nSU6UkeOQuWgGLC3q5F/VtSyt7tbEpauE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+n2Xn9UByKl+kq3jx/xQkIe7zac8Is4sF8xWn7uAiRbC3HRKxMaJd2MjGILorRmuhSaS7U1K/bYnbnx7vUAxMtYlMmLErqxZfgR57TXQpEodN1jOWFIaVi68yjPZygbVXUgwRzIwXPRuMlrpjmlGUqVOSXIzl3lf62tBcpJGRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TpsGPBE5; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TpsGPBE5"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-11beb0a7bd6so1698562c88.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Dec 2025 13:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1764798655; x=1765403455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o6chODghEB4z80xHdOkemzEluE/IBI6XrITBvqfM7dE=;
        b=TpsGPBE58rbo5KCTYqgujRkIIMkBKqs4f7u/+pa25FqLzR0iQEdN6Ey5UXF7eF/LAf
         P0mYb4NZguqkp5XJDbG3yufvHhEewGXSKauLxZXmScxmytiaKSAKQTfce2RRpSrfvYYH
         7yrLIw7FDmVwlDdo0eXJRDB+0RkQVbDVYKS5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798655; x=1765403455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o6chODghEB4z80xHdOkemzEluE/IBI6XrITBvqfM7dE=;
        b=Q5GZ7ZLCTIbEes3qN6Gcn2Gkc2/gp7YzT6Of/e0q4i1ulYXZMFJml40XLBebByoqnk
         bwIOkBAUKKS3q59nTV13J6fD/NuMqKF5NKNPCdwlgRfwf3iYDjp5mx7cdyGlP4gxtmu+
         oWzVBTb/7KAQ1uV/tlLxvuSQcrTG+6TEmi0s8vYR9cE1c0PjKscyFNweXy+GfRE8cYe7
         r6ALB3eh2/LgHnUmu1jya/iTvCkrl1QV2paDEaGMsXx7EcQcfHjxcLHxxyg3NkAVAWaD
         6yJ51YNRWC52bXqCSFJJD/Jj6u2aNWqXq7JV0WFARt+TC5RnoUdxKgi3UAZKGpIUnM7p
         RZfg==
X-Forwarded-Encrypted: i=1; AJvYcCVF/7oy0+DTEhRC04RS2td6UHqKFcWXh9lh838p2YomYL7aEP7fsH7zf86VgobRniTphtn+h49RD24=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmckaOb4/1KXZBp9nll8vyoQfxFtWMzrVnsJbIb5Q2JJm5QImy
	U2TBWW3COiGy47qZ/UtAUENOpRdqbRugFUazn1P1YXKJvjl4pwhDFiXsGYhJkMThFg==
X-Gm-Gg: ASbGncuSr08dBX9lOvEUn4D4ydYkxjcbDesD77glJCW55xA1/0GHlP/8jzqjyFFUm8G
	6tjlXStjZds94HZkGEuRTYkJK8LUdqwNq7P779RigYBmapqjpzVV7HhCE2niNmtmhF7Kr5r3g02
	t1Q8wG+YdY5MUX6zYBGZtP4J2J0rWG4TJQK8PzqFlCMPSqa9gxmyofIV9N8+4XYiWFyjnzB6aC8
	lJLZo+lUuMdG1d7HFwMfx3vQEkqKDsibqiusAChKIrVrbq0V10IjfEZZZvu9gLkgpUZMCkhgMvI
	6uw0nyLugnJi9+8MTl9jG4PDj7Ba5koEPO70pSO/1l7eDFH1ZEldZUuavfS3i4jMDsEWUioR611
	WT7XcZDpk8pu2SPzxi/VLTV2cc4SGqmuNELtrRzv0CfCgYAxSe/YQnMxRUV2KiE4pmfsrQ3MreD
	oCdhBPHt+GORNXyAZZNiMtCehl9LslwloeAynha9fwgjl/4UMcyQ==
X-Google-Smtp-Source: AGHT+IEIEIBW08OkV8WK/jMyO0yClG6Glkh0kZ5O3uJlxkndo5BOSqM+ZQ1/IXiO+9a7SW6sezHK1A==
X-Received: by 2002:a05:7301:60e:b0:2a4:3593:cca7 with SMTP id 5a478bee46e88-2aba3394a44mr820588eec.4.1764798655218;
        Wed, 03 Dec 2025 13:50:55 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:e953:f750:77d0:7f01])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2a965ae9d06sm69699431eec.4.2025.12.03.13.50.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 13:50:54 -0800 (PST)
Date: Wed, 3 Dec 2025 13:50:52 -0800
From: Brian Norris <briannorris@chromium.org>
To: Karel Balej <balejk@matfyz.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Duje =?utf-8?Q?Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
	linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org, Jeff Chen <jeff.chen_1@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [DONOTAPPLY RFC PATCH v2 1/4] dt-bindings: mwifiex: document use
 with the SD8777 chipset
Message-ID: <aTCwvFBE6IF6WT1d@google.com>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <20251026182602.26464-2-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026182602.26464-2-balejk@matfyz.cz>

On Sun, Oct 26, 2025 at 07:20:38PM +0100, Karel Balej wrote:
> Document the corresponding compatible string for the use of this driver
> with the Marvell SD8777 wireless chipset.

Device tree bindings aren't supposed to be about "drivers". This can
just be:

  Document the compatible string for the Marvell SD8777 wireless chipset.

On the bright side, it's totally legit to describe HW bindings even if
there isn't driver support yet. So:

Acked-by: Brian Norris <briannorris@chromium.org>

> Signed-off-by: Karel Balej <balejk@matfyz.cz>
> ---
>  .../devicetree/bindings/net/wireless/marvell,sd8787.yaml         | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
> index 930b700b73d0..d31ff38f57d1 100644
> --- a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
> +++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
> @@ -18,6 +18,7 @@ description:
>  properties:
>    compatible:
>      enum:
> +      - marvell,sd8777
>        - marvell,sd8787
>        - marvell,sd8897
>        - marvell,sd8978
> -- 
> 2.51.1
> 
