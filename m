Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688FD18F2FC
	for <linux-mmc@vger.kernel.org>; Wed, 14 May 2025 14:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232316; cv=none; b=BK/jtbkfAYpmgDtQeZKXqG1WfuXRdFIPCvruJxbiGwAoHnSHvlhqA8UG3IsKOg2rDZJsVU2oYZdzK6hNKbDQri79q4OatMsnQ8g9S6Ynyo8Zqh7HY0mVD39dPEROm118R4niSGQMVXcj2jLKhACRYb10UBgxYvp0J7SDuPUrI1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232316; c=relaxed/simple;
	bh=jHsA7WLaZAQUssN/Gkcz6ehZZJvqAMZ8Q9SHY06sn3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQqcz0vQjclio3jZuSTqZnJzsxaKlkyMbMHeswcO/oUF24hCO5wCC7PWT8anEC0lBuV+GSrree+Kj/AQn6MU8x1KadIASEaJT1auQhC20eUoFehtTg9/wWsrI592R6kZEDTYKJURvbET8eOxB1/rNE/ZjdTa44b8wKcYMhdamvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SRxzxuTT; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SRxzxuTT"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a1f5d2d91eso4022038f8f.1
        for <linux-mmc@vger.kernel.org>; Wed, 14 May 2025 07:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747232313; x=1747837113; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rUz3GV+6dO1qGU9AwxqVGKIzfxuE+8NTURqqLEaoFC8=;
        b=SRxzxuTTbN8XuYsKfshneQIHrI5xt+1ppK/djF2971+1Vy2jJPp8qGCBQSi44Lb3On
         IoSuu9bwVirXecmJZr9wN/SZAibIDkPiBFbvrcXYxq0f98nanuoIxGhmRSAyzdjLHn5Z
         YZKICCCExK5lvbtaJQgGdWOGmTvhVZcFRCqwYWm3XJhDVXnqgyvMjz2UdAr1be+8IZft
         GSwAoc2v6qsQsTaW+4fQaie8L7gyAEzYNzB/oEPtcw96/OzG7FAL32/1E2iSwYUPTDyC
         MYWAjiNwuJ3Fxb4m/AL66Yj9MckfVVP019Uv49fTE5zB2LAg7Jk+e2Al5kuc6sbDDRq5
         GmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747232313; x=1747837113;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUz3GV+6dO1qGU9AwxqVGKIzfxuE+8NTURqqLEaoFC8=;
        b=Y9qgbvoLwSPMHIoO92i+Q52BoKJC3uRsqNyoo3uV7sirO1TfnstfcuDFhXEEyxjpgB
         4/pq/RCtlox1ZymabJYHcuYXnlni3XF7V8UkokM6TwlYWP31X7TyNXsYMeKD5V8b0eLy
         CVi5wwJ9yI47V3mZkHxFaPdeHtGbv5B/F/e9T3ScsjbkEaRhfWo9OmPArfxI7lLpXudI
         7G4T2ogy+lMxWBBjB/yCuKy5HZseLF4CnPwoWYeXpZt858wyLjVK4k+oI71sCb+LBKUn
         ELUqK7OO9Us24NI/Q6n7VdOD68ShXnXJJx+gwA0zeEPe4hx8KjfFK8vPUiNceTtShzfg
         41yA==
X-Forwarded-Encrypted: i=1; AJvYcCXLR5Y+NeA1/egSP452yZKm3LwjI1fCljUfz/OT04ISGc+33nFzryIKt2v4LSaH36iT1KDpBUxMiu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKIdDvuhgLX/CH3ZcXmKkIOwptMHx3HdMig4KgwSl0CSNL1fx
	0hDdNvGXZQIUch9/9LygNAI1pvtLDq2E3Ji0ygXd7BX3i8lpBNmnFbwPDLwuX30=
X-Gm-Gg: ASbGncsDAy+HLvQP8P9oriyvluUavmkwFFSQG0zXKptDbebjIu/VI0jBb3467FXW449
	sfmieKKbJur8XpFcC1kpq9xPWa41XJ3G3ZUBw21wl91SFyWpebYGDH3nCSgDakfcYZv+EZmvNT9
	EAAwuB2/FeM4WVNJedyeULPoSr0YP4p2Ffc8+OVIgnGyrbP2Ig7Xk/J8c+hgZo+ywKjOEkO3vPU
	l+fnllLybFOKCv3nKt3NUrVwKbXWhb+GHmYBAtKQauHle/8/aJdxhAPLaZiME21hRuYoxSzJ0dj
	24dERAdC8W+2s0oLduMZzXYRvu88BFgS8+6FQiqdSoWcCFblEbSCLNMeKfR50zrdEoIYSeENKeF
	0JKDbtSMG6DM2rw==
X-Google-Smtp-Source: AGHT+IH4+d+Pry2CNpgKUNvxX7a5CyUBEerUkhvVVYoJxhPCGMW/etsCZMqBlMg4OuejtHCSPvBihg==
X-Received: by 2002:a05:6000:40c9:b0:391:39fb:59c8 with SMTP id ffacd0b85a97d-3a3496c1ebdmr3217848f8f.25.1747232312583;
        Wed, 14 May 2025 07:18:32 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5f6sm19729450f8f.86.2025.05.14.07.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 07:18:31 -0700 (PDT)
Date: Wed, 14 May 2025 16:18:29 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	ghost <2990955050@qq.com>,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Jisheng Zhang <jszhang@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-mmc@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: timer: Add Sophgo SG2044 ACLINT timer
Message-ID: <aCSmNRTVXQ51xj0m@mai.linaro.org>
References: <20250407010616.749833-1-inochiama@gmail.com>
 <20250407010616.749833-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250407010616.749833-2-inochiama@gmail.com>

On Mon, Apr 07, 2025 at 09:06:06AM +0800, Inochi Amaoto wrote:
> Like SG2042, SG2044 implements an enhanced ACLINT, so add necessary
> compatible string for SG2044 SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---

Applied, thanks

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
