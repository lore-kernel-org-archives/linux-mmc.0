Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E07213DDB4
	for <linux-mmc@vger.kernel.org>; Thu, 30 May 2024 09:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061031; cv=none; b=o6n9JdhhKUSlXizrHmuwZDTaWUv79G4gGPWwUxfLsN8oQeiV7rdvn3fXDmV2Urjwmw7EDnxVInNyW+hO+VIJOVFafCa+wGsVsypcxbaMMFvtK1lduT0kbPKzJJFvgZo7ALZT7osiQj4fD08cg5D+PytRX0pOoqUDBfef9cEqRkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061031; c=relaxed/simple;
	bh=5xQNtr4KKjhLwOAxnbxqbasCaZrA8nthp+Ey9uAEedk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gYNVPO3roaiFCAjvFkfP54NlX18JOeEdFZGbTvf+c1TWIM15NjoriQN7kcmKdkQ40dOooiHTHuE1Q6NvEVuqFuBy58XRNK2AH6jcS5d50gpqDf//kGdhlNAHXz12ZqEz0fZek/4ob01P98NTCh0uwy6DypKtn9SvgBeslBncP2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fKRRqK5g; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fKRRqK5g"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b79447c58so903942e87.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 May 2024 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1717061027; x=1717665827; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKTau+YU0RyTU4x5XVrkjnpY1yWlzcekDVk7dqnzHyc=;
        b=fKRRqK5gEP2K3Cy1fy93TH1ey4tWhpCW6rlpL6vC7EvtsY9XxwfqKEVNisfWKv1wkI
         8YPUtsEXEoauHZBmzh4rNPCuLsaA79LiQo2gtqiLsIkXlUfqiYmG+Hn8Ep/8GXS+badM
         gSOQmRZvC6GfaQXLwbyA5zfsE2gGrX+tYb7cLk2K4hlUU+LJnD+o/VDTpe7ht2PNM/DI
         GspPCVW0ZAGaiAtaIsc1hjLiHdXcRvARWUjXdrew91rBcEeKaF7z/kozmvR2AhcU3bhp
         7t533AiQJWKN0t5N6+VhC7DPj/DpiEBWkgHTwo0JdYX/tXBvJcZGIzfirp43pN663zvN
         Vk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717061027; x=1717665827;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OKTau+YU0RyTU4x5XVrkjnpY1yWlzcekDVk7dqnzHyc=;
        b=M+wbUnShwQJkTow4w+M5RwtOUBJxDbH9F0utOc/eVFj8qDGijh6SbK7+ISfwPE1WnC
         BNUTRA5OdwOEd+czZP6/Mj3WY4oah9oZYBXjbg4K4Vx4vOEaRhUVmoWx3DsQVqTwEqmT
         Jm/jQ4Je1+ECIjFPjguInKIiH/NQUag1T/LbrHsG9NBr5Uuq8VZT768ANpgwvmNmcF3/
         xMb61pJ8XShSmxuTbo8yQKXuRbWPyN0krRuDTLdNUcq2v9Vo8NncOBULJ2KvHqG+c/oZ
         RdvbRU7KwfxtKqj6t17VIe7L7V0HShAWAgR9fugOWcHA+i76xFjED3uLQI39wXwnxB6n
         8+SA==
X-Forwarded-Encrypted: i=1; AJvYcCXtC88BgYhN3OQ014+NgL8S8YHYMlrSn16UkVxmyIwgFdlxP/51NTFybT8XU04TYXlF6jMRVQQ8V+BmHMHW+SLLCloUDQavXXP0
X-Gm-Message-State: AOJu0Yzfut84GssE6ciVVpesjGV/J0E3j8ImmVxejnNPlri8EwThb4DV
	dNSgRnHTjWOWjAx/b7mItapexRRfqc1iS+7hHhX+57XkHi+qVzfdru4UOWNxMaA=
X-Google-Smtp-Source: AGHT+IF85vUzPlq0AyAMTY+th/DjCHy1wMkF5f7oy4kB3UpvpxIDGn/E0S9HB07IbBUb/8RWP+1DDg==
X-Received: by 2002:a05:6512:3694:b0:522:373c:fb74 with SMTP id 2adb3069b0e04-52b7d4996d1mr1068441e87.52.1717061027465;
        Thu, 30 May 2024 02:23:47 -0700 (PDT)
Received: from localhost (host-87-16-233-11.retail.telecomitalia.it. [87.16.233.11])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a630f25943dsm368913966b.41.2024.05.30.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 02:23:47 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
X-Google-Original-From: Andrea della Porta <aporta@suse.de>
Date: Thu, 30 May 2024 11:24:00 +0200
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
Subject: Re: [PATCH v4 4/4] arm64: dts: broadcom: Add support for BCM2712
Message-ID: <ZlhFsGw7PaseT_08@apocalypse>
Mail-Followup-To: Stefan Wahren <wahrenst@gmx.net>,
	Andrea della Porta <andrea.porta@suse.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>, devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org
References: <cover.1716899600.git.andrea.porta@suse.com>
 <8dd6997394a01317747ca11b4779f586752b4947.1716899600.git.andrea.porta@suse.com>
 <f94cf0fb-a9a2-4447-9b32-7f09c2a37cf6@gmx.net>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f94cf0fb-a9a2-4447-9b32-7f09c2a37cf6@gmx.net>

Hi Stefan,

On 08:11 Thu 30 May     , Stefan Wahren wrote:
[cut...] 
> > +	clocks {
> > +		/* The oscillator is the root of the clock tree. */
> > +		clk_osc: clk-osc {
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-output-names = "osc";
> > +			clock-frequency = <54000000>;
> > +		};
> > +
> > +		clk_vpu: clk-vpu {
> > +			#clock-cells = <0>;
> > +			compatible = "fixed-clock";
> > +			clock-frequency = <750000000>;
> > +			clock-output-names = "vpu-clock";
> > +		};
> Is the VPU clock really fixed or is it just a workaround for minimal
> boot support?

Unfortunately I don't have enough insight on this due to lack of documentation.
I had to take it by faith from downstream dts.

Many thanks,
Andrea
