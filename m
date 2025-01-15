Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAF123F286;
	Wed, 15 Jan 2025 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736930381; cv=none; b=RkwNyZ7zPfNkAXxgK4vETmfW9OPySM3/8Qauig05DPo00pKGCkjMZ1W5KH4XetG4OyTzEFwONCAyykrUnNAq54TBDYJXQxlbJTiDUBBqqMuDIOJSnq6/wzNlrT4oKVRzc6QsAEFmrNosvdc9RrTziopH58qnKQPJ1ReBDSSkO1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736930381; c=relaxed/simple;
	bh=tHSI8bP3rZLy6BjB3kn7AlIE62O+XaUYfKdsNsAwJxs=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/Mgwu+5jVTLwjGmjFm46+YG1s4I/A2vQrijeGTuDzkG3s6mdj39yT2QFQU9NzdGZbm+e3JoGIngW5BrYBr/l4x/aaLh7IM9A6bvDlqbZTyWjv+Vj6hjgmLEwG25oAD+jyy+oxrxSd4XSY3FdUZeSQLk+Fjq9Cp/vSIwXJ1DkZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TylIcpYm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TylIcpYm"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38789e5b6a7so3455209f8f.1;
        Wed, 15 Jan 2025 00:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736930378; x=1737535178; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4B/xQ2Yak+fpxIrk/GyFx/NQxbFsrazzrnNpKayLw2k=;
        b=TylIcpYmNquOqE9wm0mID+0A60BNCuTz7tMFjPafBAIkoAQ+mzn1+HfyDKk9K76L6Q
         OxF5EXaSpjoJnEaxPs1/AMD3zVX4l1twdLMm9V8PyN2ehGpV4a0YPdTKUUp9m4byQPp4
         henSNBGv8sXYz+l7eLOxFYWRcMJAk1ILuU52dLrFDBUjt3oNNWxpZQ6UjSJCDHbtnmRT
         5jcQ9j+7RN827TqpWhBpuMVNULZxozoH5yJMqoPAZROy92i9lB1GGAj63MF8u0eY/iog
         HHPzZP5J6cxiEnDAiY8sjCA+A6mC3GyPm5GYnOiEsqpRhVru0KJd4Pe7/oLfNgv8cgn/
         MQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736930378; x=1737535178;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4B/xQ2Yak+fpxIrk/GyFx/NQxbFsrazzrnNpKayLw2k=;
        b=RP+a+xwJTqzPb7JNRzefbkgL1bjBFcYnQwdYrc/bWMMe+trxZqMe85usWISQmjnCez
         EfnKGDsAgbb0PQCI8bP4uwQWf5EnMKKZLHFdsPbe9JiyVMQmNU7qHpItWjqmsSfgpPKv
         yzEWKItehPDMS7YZG7iYc9FS86mWYiKvGJ3mvB4SZvbFnsGZBK6cYydbI1tfJE7o3zq5
         IAesubqCxHq6UVMHN/Po59+vqdM+egs9oEPG6FacfgF79so2/JMiFBR1yzsEw2731N4b
         Ce/hclVAzdAOiUZo7M/zKub3mxLIb2vV+lyBYAdgs8hT+EBF+Mp2PYqYXgynzryJOjM/
         JG4w==
X-Forwarded-Encrypted: i=1; AJvYcCUo4PrInzfsXbPYn8/Awc/nivyE6bYM48USB2uZf+RbVjy1oPJXh1Z1WYrR3pOKAXuQvP06naDeng29@vger.kernel.org, AJvYcCWRlxlbgtbqQOzFQSaFlom1cyQPSM7XfvkMc/0u1aMDIIlqWSBAP3OCYJ3+LcCT44p84cVNp6iyw4Kf@vger.kernel.org, AJvYcCXW2OrgERu9DdEORuFiwcj6CuBhc7Y9i2Bmbe8PeFXln5np7dMOWsLc5/uKTjWr+DlZYZnHoSaGvxkWfJjR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ne8LOtPfa2TyA1wEiHp1RNvldSiLvoDxWNB98uU33ajgcPDg
	5WeUVSP3qw2Vt4GvRSeHVheHLku+HW3RuYJ2EUBegcya42BUU5KIqb4V3w==
X-Gm-Gg: ASbGncuBxrE7tKzHke0QPiTubSFkAL3vAK1Aqd/b1NWoj9Z4QZGc9NgFquKW8Pk5dD4
	pCinALtpJQaJzfy98d20c93AtV0s5E4svr5OX6YukfQq3pLRC1uyYu8HxqIHyyhqecD0c8F1Yfe
	SYbyuGoloTtscbwz87diu68SPdvAlvBJDDA5usX1J8DE6C6EDOUoJv6Pcvg+0J+Y9pVN5WmZInR
	XJjfLHtzHZlPygmge8KQ2c5rFiiJwt9B0rx0slflgARcnSbGb+Lvp+cEayPlqVsdxXr93bSgytA
	NEM6DxdN53KU
X-Google-Smtp-Source: AGHT+IH1S/ypLo4sxdULxIVj7iio6j8QLiJZhFQomKltaJf5Ym2Wv7jn92KqFeZHfzoy72Wy7rxhkg==
X-Received: by 2002:a05:6000:709:b0:38a:41c9:8544 with SMTP id ffacd0b85a97d-38a87336a6amr23435760f8f.37.1736930377805;
        Wed, 15 Jan 2025 00:39:37 -0800 (PST)
Received: from Ansuel-XPS. (93-34-91-161.ip49.fastwebnet.it. [93.34.91.161])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b81d7sm17016684f8f.73.2025.01.15.00.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 00:39:37 -0800 (PST)
Message-ID: <67877449.df0a0220.cdd29.8807@mx.google.com>
X-Google-Original-Message-ID: <Z4d0RkjDxhtw_655@Ansuel-XPS.>
Date: Wed, 15 Jan 2025 09:39:34 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-mediatek@lists.infradead.org,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-mmc@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Wenbin Mei <wenbin.mei@mediatek.com>,
	Conor Dooley <conor+dt@kernel.org>, upstream@airoha.com,
	Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: mtk-sd: Add eMMC for AN7581
References: <20250115073026.31552-1-ansuelsmth@gmail.com>
 <173693027082.3240418.16772447316188600820.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173693027082.3240418.16772447316188600820.robh@kernel.org>

On Wed, Jan 15, 2025 at 02:37:50AM -0600, Rob Herring (Arm) wrote:
> 
> On Wed, 15 Jan 2025 08:29:50 +0100, Christian Marangi wrote:
> > Document eMMC compatible for AN7581. This eMMC controller doesn't have
> > regulator exposed to the system and have a single clock only for source
> > clock and only default pintctrl.
> > 
> > Rework the schema to permit these new requirements and make supply
> > optional only for airoha,an7581-mmc compatible.
> > 
> > Also provide an example for airoha,an7581-mmc.
> > 
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> > This depends on patch merged in clk-next
> > bfe257f9780d8f77045a7da6ec959ee0659d2f98
> > 
> >  .../devicetree/bindings/mmc/mtk-sd.yaml       | 64 +++++++++++++++++--
> >  1 file changed, 58 insertions(+), 6 deletions(-)
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> Error: Documentation/devicetree/bindings/mmc/mtk-sd.example.dts:104.31-32 syntax error
> FATAL ERROR: Unable to parse input tree
> make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/mmc/mtk-sd.example.dtb] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1506: dt_binding_check] Error 2
> make: *** [Makefile:251: __sub-make] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250115073026.31552-1-ansuelsmth@gmail.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>

Hi Rob, I think this fails as the CLK define is still not merged as said
this patch depends on bfe257f9780d8f77045a7da6ec959ee0659d2f98.

Any hint how to make your bot work with that?

-- 
	Ansuel
