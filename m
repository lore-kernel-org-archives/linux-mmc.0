Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC5D24C06A
	for <linux-mmc@vger.kernel.org>; Mon, 18 Aug 2025 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499144; cv=none; b=DlRmoqsWLW3aEV2oNRm56Chzu8d3bgQjJYmfAPWSuKG6JXvHzxglCXLZ0Qw7qVH4ASPvP1yvwi+WCv9Gs5BG4xoYgZ3bMt206pO4neB7x0aXIu+jzC42xo+EyxizPAvf902jtza3ejByea6hFjNnTxVziWkf6qUKcpExrNdEWkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499144; c=relaxed/simple;
	bh=fdsSMUVN1tYyzzsYzCtSu+U/f8dLCqieMT5Xde4c0lU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I70arlJC5iiNgvIHZ/5sNYxROafMXwaNmiDDcnfLfdVQia9X1peYMigp9RDcGbgcOfLCwlI3GReRn9KGYjnSxghXE/cSVqU7/nOjWPzuo1+4gpRTWH2PkEzViruRtMha4oGG//IW4zoHcv+qTEiD824tcBXsQ1ZreqGhrXArd34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v0XlbMI7; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v0XlbMI7"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-24456ce0b96so36462575ad.0
        for <linux-mmc@vger.kernel.org>; Sun, 17 Aug 2025 23:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755499141; x=1756103941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dWdZCD7J/kohgzpk9nhXOytmOUzsGpBOAbeomBtF8rg=;
        b=v0XlbMI730Z1GoPkyjE9LMZLTtwd/ItJQ1M9oEfYgvHSlBul79b8OA3qtIXMl+LVYa
         ci7ZrpSYRsGYrak/TnCk0IC5U41JBi0Fnq6PpSkYuEZhiU78IeUrH5ZaRQVVgEt/bWKL
         Pk96Bwai5rgytS7Ft6a2ZGERboCgOIeAoC5Cqeg9D6OuMJg6zkAUiNXM3evip24RALKo
         hqEqfbPkEDhJbqqvrPrYo2a2dhfy2PqXXQ28I7FpKrmQoGiXTxUYZ/a4zBKT8vF8He2P
         Ic/+6C6JlhXd4M2j/tjbWfaB3hNrrmfTkKaro2wVaqMUudUFSGFHdH1tafBXoZ3XLwEQ
         XLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755499141; x=1756103941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dWdZCD7J/kohgzpk9nhXOytmOUzsGpBOAbeomBtF8rg=;
        b=MnobcW0Pm08YWQDEr/EAgHWzJWm2YU7Vgmi5QPbg/VqUkXV+oMUREoeP6apAbggING
         /TvzYPJ/bQ3omL5lo6/k3EZ3f73L39NN5LkqqFlL2EEeNUwSQLsli3KD7D9rO1b2/01I
         NCTvaQC9JSXioVnVIIwRBkUGBYBywz+mrOxEXZGFK5R0Nds7et7MrYcAFM23gYPBBx0k
         7flpgQUqC/+HpQChX306Wkr/ObjZRfN5p0wYubKZYKuCgOpUEV84pBnrvCdb8p88IRgJ
         +XnmzO3wJGjQUWcCmmHTyK4v2MUzH6FvpfAaHGumu0VeNz+FBWRT6/toxV8MNbi0jA1q
         ecLw==
X-Forwarded-Encrypted: i=1; AJvYcCWKd78aSPmZklGNA6h1Hh2aKB0Lb8NaiU3bPRPpc6LrtplWi7Wt+BtFR/3QYQjzdxw5Q6GfIrKX3E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9YVdcFM23U8PtZt+g5+ari14SxXzne/M+8QVZm3ph/H0qDXa
	eca0byi08jboO3W7WzENDWyvsT8jCJdNw/2K1TqAicggLZkvYTWkzG8K9JJan1ksKSY=
X-Gm-Gg: ASbGnctM/FilSOJA6oFWBwTZa2Lns8+2bqmG1uFYY8Skp4aQXpErga+JCA6b29VY+CJ
	vsl5PcJsho/FSRXnHI83ZOUEyep8eZj7fElvkYn+mqIuI3M5FBKHW6Xzm761UxCDuZO/t4UdOAn
	sswG1iLwFP85cggHovuC+j1QSbGCSA4u4edWSWH2ioBpgGxIJb4QwaANVftaV6RRN68prbmbxew
	s34RpU8ATR7gHSmkpbyxa2MOgp4CYk2mL4K1i7DpfTVNnz5wsD9cDwzbfPlFarkwZ3WZ6+IIl9l
	xvqEcIwXegOelhdcZoB8TpKsROWmHGRwpZdXVGlNpGEJD4orFxyDgTsyg7BkcjSsy6d0jxmT4HG
	wTHtFdS/5p1468o1zRjOJr3COGzHwgOeFT+Y=
X-Google-Smtp-Source: AGHT+IEIqesHT4FYr8rc/TuuqDEF+1Y4JGz8Td6OnM3CiT51lBb9Lc+1prXyz1kcF+i7d3fJEqxJOQ==
X-Received: by 2002:a17:903:181:b0:23f:b94d:7da7 with SMTP id d9443c01a7336-2445978c962mr231605965ad.14.1755499140970;
        Sun, 17 Aug 2025 23:39:00 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f836cfsm10420234a91.5.2025.08.17.23.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Aug 2025 23:39:00 -0700 (PDT)
Date: Mon, 18 Aug 2025 12:08:58 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Russell King <linux@armlinux.org.uk>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Michal Simek <michal.simek@amd.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ben Dooks <ben-linux@fluff.org>, Viresh Kumar <vireshk@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexey Charkov <alchark@gmail.com>, linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/38] mmc: sdhci-spear: use modern PM macros
Message-ID: <20250818063858.azqmrwjrlugafuvl@vireshk-i7>
References: <20250815013413.28641-1-jszhang@kernel.org>
 <20250815013413.28641-26-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815013413.28641-26-jszhang@kernel.org>

On 15-08-25, 09:34, Jisheng Zhang wrote:
> Use the modern PM macros for the suspend and resume functions to be
> automatically dropped by the compiler when CONFIG_PM or
> CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.
> 
> This has the advantage of always compiling these functions in,
> independently of any Kconfig option. Thanks to that, bugs and other
> regressions are subsequently easier to catch.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  drivers/mmc/host/sdhci-spear.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
