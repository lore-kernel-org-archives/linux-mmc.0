Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5CC2DF714
	for <linux-mmc@vger.kernel.org>; Tue, 18 Nov 2025 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763491831; cv=none; b=iCoT9EU2VK4GDpZbY8TnKqtKGWalng3ZqOOIENRUz1jlDlCU5yH5J0NaC2TjjWYR47nLTvDZX4qUn4rchwtM/8ILqKFOwUyL/ZRZBRGaBWX2l1D3zQw6/3Ke/XOSHrdHgaeRRnIUZ5/vE9L/x01rRY4fN9FKftPUXESdfm1cK7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763491831; c=relaxed/simple;
	bh=FHR1vghh3/Ry94P21SXhw8smish6xFij+qwri1zqTjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+rtfUEm6Qtmg0uBkmpureumkjs9EbpUQZE6HJfYPb1vhV08TBwQn47amrkfAnBvWit0wuwFW+4Arkbc+hyfTeqAM77i+7TxTEYmUK8vPsXOMDFbUQgpsfSKWk1f31VV4ApiS7wuR1dAm7B2gNFziCi+loVn/Bn1V//W8ShNP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvE5vKh4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvE5vKh4"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4779c672e9cso2683095e9.1
        for <linux-mmc@vger.kernel.org>; Tue, 18 Nov 2025 10:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763491828; x=1764096628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/xelqTh0MJxdYizhebw3VTy7C2C4gWnDlrkViLNdgoU=;
        b=QvE5vKh4K0PXe/iK5Gz+DxqXXShnyMLG9fTdyr+6T3Xde98eMHNgA6cUla6nGzMcYz
         YKNPuag367ldhYpDExhC50jEOAkrAyiSxMoIxvq0naEmmLbAkaokKBO9S6Et2luJUtk+
         iL5b9mxbLlDYj9ZtzRZKJ5Hi3lnaOLD4RdsTrMIysJTS/BEy+Xo9NUE4QiqPb5qfhHRW
         8Im1bfD9oOJVJJUvDs+iSn05b6Gl0evuwNlq6jX0IpPiRdf+g7nmgv3QmxUhpaR1UTPy
         trflq4FEH5fZ2WopFSG0AyELUjdt9UCkTGbWGThs5ZMgXh5zDeqVSonrmOvB7ZL0LWeI
         NqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763491828; x=1764096628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xelqTh0MJxdYizhebw3VTy7C2C4gWnDlrkViLNdgoU=;
        b=fsOhv5VdDoxoJeGi+gjPNIItFIlHYQ1noFLKCilN4fNUWPDW2sgIN8sAnVYnOfkrmu
         xfO/Or5oXq0rWWs/YJDY6/nipmR6zOhEiGsq8+rHRBNKDyRbWRtd1JCnyW86RFrsPBNz
         2AeBSpaXk3lz1S5jZgJIE1x1tzOszT5nZIOQmQzo0MGKHB5LJCrWoV18MSEYy8yu9Pr2
         ZU13gfXm/IN2vLOQuG3esks7gV9OcsbHp/Myh++5eNKB/RNjtV1tByaVBn+y1FHYPcf4
         px47kJhy18BqtMDL4nQab/dTvsmOmNyQJmzX+jh48xh7ZlMxD3pmC2GoC81D+XJYDhhD
         09sA==
X-Forwarded-Encrypted: i=1; AJvYcCWrnbM/ThFn8JqsuQ88TVRWCWbn8SxD9+KWBclCMU4dp6nlmDSsVby/qFWUdQULkcye5GNpE1Is/6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK2DAoHyhgMe7SghT05oZX/s4/gAeK6zP5wAnaaCGMDI2ldTpE
	9HVqLfaH+8gpSzinMHg9w83dPi/gRS8HFFgdtplccYdUZhJlTt+0Gecb
X-Gm-Gg: ASbGncvfXO9BLRW3y1cqdsGtRVa1lFCvafgRmUQB8agbqrVLaMkADZYFN7plrZaj4Ej
	1OQzLN7CHb/c24X7u7L1A5yBUAz4clD3LibO6uk5ewXoJM6C+FQUSJ8zK9egRHLZwvfbuDBdvr6
	fk20Oa9+H46V4CLlc5eWpI1vQwELLhgZlF6tL31j8ZL36TByBhEY1siVQJQfsOKxVsR8yDIPyaa
	sBabbjFdKsDJJSth96xurri1RA0Cu9eGLQs8p3eQAjZ8hXg6hW8u5oGVjxtzdTjK2A2K7CTu+4B
	a4Zpg0J8wlmOd+pw+dq0ZDSMuBNdn+gAIuauo5g32QMirnp5vcgIYP3fu3gQK0XPwwXIyqej9og
	zBicjXgXjg2JcUH4GVsiG8cYr4A+NrHublF2IvY+EAutFJylsesChXVLQudfKtuR3hEALvs6XAh
	X1PU1ZIZU42Skr
X-Google-Smtp-Source: AGHT+IHx6i4VYWR6pSTcXtSoFlN4Y9U/3Z/PI54PVyQA5JnsfbBaJwpdM3LzkIBKtiuh5JtXbYxanA==
X-Received: by 2002:a05:600c:1547:b0:477:5c70:e14e with SMTP id 5b1f17b1804b1-4778feabadamr87966605e9.5.1763491827278;
        Tue, 18 Nov 2025 10:50:27 -0800 (PST)
Received: from skbuf ([2a02:2f04:d106:d600:9ac1:9a91:7d1:a813])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9df99d3sm22110705e9.12.2025.11.18.10.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:50:23 -0800 (PST)
Date: Tue, 18 Nov 2025 20:50:17 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sagi Maimon <maimon.sagi@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Petr Mladek <pmladek@suse.com>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
	ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 14/21] net: dsa: sja1105: Switch to use %ptSp
Message-ID: <20251118185017.kk7binsumhh27n7x@skbuf>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <20251113150217.3030010-15-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113150217.3030010-15-andriy.shevchenko@linux.intel.com>

Hi Andy,

On Thu, Nov 13, 2025 at 03:32:28PM +0100, Andy Shevchenko wrote:
> Use %ptSp instead of open coded variants to print content of
> struct timespec64 in human readable format.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

Acked-by: Vladimir Oltean <olteanv@gmail.com>
Tested-by: Vladimir Oltean <olteanv@gmail.com>

Thanks!

This is a rarely modified portion of the SJA1105 driver, and it doesn't
conflict with other changes that I have planned, so from my PoV there is
no problem with the patch being picked up via other trees.
