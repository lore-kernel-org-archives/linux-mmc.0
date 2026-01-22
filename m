Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026F477E5F
	for <linux-mmc@vger.kernel.org>; Thu, 22 Jan 2026 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769062651; cv=none; b=FgkPYVoKKXdYBAwZPVl+eZ8G5AH5wlePWhhSG6DmmO8nVogopyVvpU04m3YdwTEgxhKyIiOT00RUdIbfelTv0iQ2hi9XrhT86DAW8SxMnqm4KUgjaqHpAud4Pci+PSW0DDy4h1n5qwBoyzkqV/FfoVsjK4AqDuoBQPI/b2rRzBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769062651; c=relaxed/simple;
	bh=HwQQ/e13d2XeVp13BFe2FpMedQM5DZhp8KcD4K71ego=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UUEkWGMqQb8VPANARpPdNBQAGm872pm21Cdwz0vVAwt3CpckhBAKW0Hfo70qVDkTpHEGqs6pUoW9h8Kfbiy2C7Bd4h/4Ij2nQWipvwqxq4XkTRN3gesoBwzAfcHItc4E9MmpAXm/56BEt7is8t24Fyysq7lvKd14BrBZFzN4s4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cCEo8lZK; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cCEo8lZK"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so5706495e9.3
        for <linux-mmc@vger.kernel.org>; Wed, 21 Jan 2026 22:17:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769062644; x=1769667444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XFWxi+AFltNFDVpcrpAcnDmVTxmCRVFES1AkiIw22SY=;
        b=cCEo8lZKAs1wr4lfPYM6lISHc7OyocCVXHgQM1twwkXLb2NuRB1HERaaxW76fYKOgR
         Kv9d/riU2OCb5wtfxfGlcANv57LjTxWKE/VrxnT/EMzxLh+ZAtT99J00GtjHh/KR8S4H
         7MHMP7DnxML999Bi32tWLzr9OZISoLZDdJd9644F++z6At/8GHg3JQEG5GpMQKOJrnyh
         c7/vuVQ9CMDAM2UjiUYpfX5tnOaHhPIn/ynUJ6NfW1bsDsxriBKfbdNSnKcZL100q8a3
         81xHngoT8wYXu4xVfTTg0hCauJDEExfpnclEk4qxnchsokJMNLy6sERO2HSZVj1o8xbb
         bTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769062644; x=1769667444;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFWxi+AFltNFDVpcrpAcnDmVTxmCRVFES1AkiIw22SY=;
        b=o/dhPhztNeNbv3x+g0wHy+drhuARy/0AVMy8C2won+qltdG97XGDentOtxvLY+v6Vn
         Bj0f+N3gukaoeGQTV5+FGfNzNCWvCGlU4TcH6B+gv31A2hoVaNmZ6grkml8UxxtnlEeD
         Us+yZc23t4VkcKDptRe9W0nDqkF2zOEiLtdE4BFeBhM/xJ8daLRki1SsEG79+Fd4KBlk
         4tqIcyChwgug1FYk68VDXOv7KN2cgqCs+OSb06mhWzYI6IQu3szKxr/Rd0qkbdFkZzIY
         1kRipb0HHQCoGEA6PQp04YH6aCsO8GX308bLCXjMRXxRSbHPUrB5koLzWZ6KCq1QNQlF
         b9Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWVA1rkGc8Gj33D6ePERAFvSUTdSU5sYjb6EXWXv0m0WvwXWTlRo4l1+P84G6OcUSRqNtEGJigFc94=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCrPNFC5pDQJ+1VHv+ZaQREfQV+SJ+MgZstr+ac6ourfa4OAc2
	sE+Fo/XNcXzNXi/zdXDOwFZWwCDOT2q1+r2qqW2OPC+IEHTTCT1QLenQyASM1qvaRcg=
X-Gm-Gg: AZuq6aL7NAUg4YQ0+ip487ZhzXOJM55+tGM1GdtTeNswB4960/xovjxbHKSMxZ1TrlU
	rSf3KgzludZSu/81MwbYi4glLYCt1IpfY7ZzQ8VRqrBRepHeStsWn97iXnZKkZ1V5hxr0KPDhcM
	zFrA3N5bR7ZgwTwHnkaP6BsahCbqlReBzBaBbXK1UNJm046ZbIqWW2LtDdB00rFbtmKHIOtNi14
	Y0MyZhG8DgLasiXZfPH3UbgoZqy2H6V9VlFm1R5DZWXcB5MeK5Lce67J951o9+HN9Y3d+Pk5Wxn
	/T9abZABbWLjS37jG6pFC/R+z9CE270tdqnyehlQUMQPdSLgHCOFWVSGQJmmShLXDYjg+lo7/7q
	TByz/YuFwscscV5pemtRUN5z1pE0yJi3YT59IV1j0N9VKYXjz6ZyhCrsDPiaXLoDCNEJHIdGAnm
	Vl3wuQpXoq6//fmus0
X-Received: by 2002:a05:600c:83c8:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-48028360726mr235733975e9.7.1769062643924;
        Wed, 21 Jan 2026 22:17:23 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804704b89bsm40122255e9.9.2026.01.21.22.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 22:17:23 -0800 (PST)
Date: Thu, 22 Jan 2026 09:17:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Josua Mayer <josua@solid-run.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa-dev@sang-engineering.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Message-ID: <202601221036.J0kR78Uw-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121-rz-sdio-mux-v6-2-38aa39527928@solid-run.com>

Hi Josua,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Josua-Mayer/phy-can-transceiver-rename-temporary-helper-function-to-avoid-conflict/20260121-173607
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/20260121-rz-sdio-mux-v6-2-38aa39527928%40solid-run.com
patch subject: [PATCH v6 2/7] mux: Add helper functions for getting optional and selected mux-state
config: arm64-randconfig-r073-20260121 (https://download.01.org/0day-ci/archive/20260122/202601221036.J0kR78Uw-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 8.5.0
smatch version: v0.5.0-8985-g2614ff1a

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202601221036.J0kR78Uw-lkp@intel.com/

New smatch warnings:
drivers/mux/core.c:776 __devm_mux_state_get() warn: passing zero to 'PTR_ERR'
drivers/mux/core.c:796 __devm_mux_state_get() warn: passing zero to 'ERR_PTR'

Old smatch warnings:
drivers/mux/core.c:722 mux_state_get() warn: passing zero to 'ERR_CAST'

vim +/PTR_ERR +776 drivers/mux/core.c

0610cc3159b786 Josua Mayer       2026-01-21  761  static struct mux_state *__devm_mux_state_get(struct device *dev, const char *mux_name,
0610cc3159b786 Josua Mayer       2026-01-21  762  					      bool optional,
0610cc3159b786 Josua Mayer       2026-01-21  763  					      int (*init)(struct mux_state *mstate),
0610cc3159b786 Josua Mayer       2026-01-21  764  					      int (*exit)(struct mux_state *mstate))
0610cc3159b786 Josua Mayer       2026-01-21  765  {
0610cc3159b786 Josua Mayer       2026-01-21  766  	struct devm_mux_state_state *devm_state;
0610cc3159b786 Josua Mayer       2026-01-21  767  	struct mux_state *mstate;
0610cc3159b786 Josua Mayer       2026-01-21  768  	int ret;
84564481bc4520 Aswath Govindraju 2022-01-07  769  
0610cc3159b786 Josua Mayer       2026-01-21  770  	devm_state = devres_alloc(devm_mux_state_release, sizeof(*devm_state), GFP_KERNEL);
0610cc3159b786 Josua Mayer       2026-01-21  771  	if (!devm_state)
0610cc3159b786 Josua Mayer       2026-01-21  772  		return ERR_PTR(-ENOMEM);
0610cc3159b786 Josua Mayer       2026-01-21  773  
0610cc3159b786 Josua Mayer       2026-01-21  774  	mstate = mux_state_get(dev, mux_name, optional);
0610cc3159b786 Josua Mayer       2026-01-21  775  	if (IS_ERR_OR_NULL(mstate)) {

Please, change this to if (IS_ERR(mstate)) {.  The mux_state_get() never
returns NULL.  I have written a blog about functions which return both
error pointers and NULL.

https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

0610cc3159b786 Josua Mayer       2026-01-21 @776  		ret = PTR_ERR(mstate);
0610cc3159b786 Josua Mayer       2026-01-21  777  		goto err_mux_state_get;
0610cc3159b786 Josua Mayer       2026-01-21  778  	}
0610cc3159b786 Josua Mayer       2026-01-21  779  
0610cc3159b786 Josua Mayer       2026-01-21  780  	if (init) {
0610cc3159b786 Josua Mayer       2026-01-21  781  		ret = init(mstate);
0610cc3159b786 Josua Mayer       2026-01-21  782  		if (ret)
0610cc3159b786 Josua Mayer       2026-01-21  783  			goto err_mux_state_init;
0610cc3159b786 Josua Mayer       2026-01-21  784  	}
0610cc3159b786 Josua Mayer       2026-01-21  785  
0610cc3159b786 Josua Mayer       2026-01-21  786  	devm_state->mstate = mstate;
0610cc3159b786 Josua Mayer       2026-01-21  787  	devm_state->exit = exit;
0610cc3159b786 Josua Mayer       2026-01-21  788  	devres_add(dev, devm_state);
0610cc3159b786 Josua Mayer       2026-01-21  789  
0610cc3159b786 Josua Mayer       2026-01-21  790  	return mstate;
0610cc3159b786 Josua Mayer       2026-01-21  791  
0610cc3159b786 Josua Mayer       2026-01-21  792  err_mux_state_init:
84564481bc4520 Aswath Govindraju 2022-01-07  793  	mux_state_put(mstate);
0610cc3159b786 Josua Mayer       2026-01-21  794  err_mux_state_get:
0610cc3159b786 Josua Mayer       2026-01-21  795  	devres_free(devm_state);
0610cc3159b786 Josua Mayer       2026-01-21 @796  	return ERR_PTR(ret);
84564481bc4520 Aswath Govindraju 2022-01-07  797  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

