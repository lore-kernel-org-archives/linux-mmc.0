Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13821A01CC
	for <linux-mmc@vger.kernel.org>; Tue, 13 May 2025 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747146804; cv=none; b=Pua1ntQP+SB3myV+6iG3ypSRKzzJnN7/zaqWENHfUsu9NojT+JJOII8/xEnOefJIykjCDYhExFefFMTBkH0TWPCeLebCoxIMmpg6XnLqYxcU46PiZgC7TW4ZF+cWUZcq9X11CKD0kEllN8tK3jlQ8f8PNqWsSxv1fJSouyDEBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747146804; c=relaxed/simple;
	bh=iQEF7nznmEycoRdRwifBr5zcStMelsRnNg7k+aa6KwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VWU99sdvWZ0AUD0+maC9g3SqxBXrVg8qNPvu7fkEywUAuv+mQ82GJaIv5NLdmF+PZ/TvhMf3VlxlJS0tP6q3+kw/W2VlkKhrnkMspH09DgD55jHnFy8HfECz3NbFldhhwnwq8lGvQkXIuK1qvWm74V6Ze7sHhU0RdVDnRE5vH0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z8gzNNuu; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8gzNNuu"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30db3f3c907so55123911fa.1
        for <linux-mmc@vger.kernel.org>; Tue, 13 May 2025 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747146800; x=1747751600; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6C+eOPgBkYyfSbaSp3zhH361dNsffIyxJdkkZYVPmTA=;
        b=Z8gzNNuuEhC9ToJQBXiF5ZFqeeBi1WceWyKf71VHr6WiImWo31odsQdUVlm1PvTvsA
         lknjbDZB7X/B9T0zGlVhdfvQrpg9Ghr/22cTvMzDP2oiGvO2RG7Vh5AQcSgR4gj7EXti
         rvbqSSNBzQ8gtjBFzFk7JqoXHTmf2d+kglEP1IYmNsd635FGJ3uHY2U6lvYe9fPCvx3J
         q7iIngoTIvA4+HP8iab5vMXw4PnXlRq100/q/UbF40pJf23ssspCeS4gWloPRh1Zgukj
         3vVaLmrZqJn31ScAa403D2/XzpwahA9FDoMgNNQLzGFwFpIW5URs7hDIRj8GOP3ME3AK
         OWhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747146800; x=1747751600;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6C+eOPgBkYyfSbaSp3zhH361dNsffIyxJdkkZYVPmTA=;
        b=OmA//OmoSHK6cg4L9oI3TkT/uoXW5Io+kVv/0fnWzkfwjM5mi4QJVLP1D5DhtoRK/y
         FjafBQcbddmyTQ+d4ONjwAECaUiTk1eIGDpKk0kg5ch6zcqySdAGjl3Sv7rJbcMxJgXg
         hklZWO4qBB3YvkDh3Mi9W39NelYJmYxGJrV2bN5OLhGM8gfJlNhuZ/8hlqydGw3v9fhv
         qmHTMOl8Igtdu7QVBqsjg9/GvjCBt2Y9VtX2Rp94y56BxumIF9XaG8JJ0KbAWP24knSI
         UFY+fCvdHtDQV43lUOzWi9vRP22im5mDyt+euu+7wtuFU/xe9XxTg7E3d77GucqPMlFS
         Cv2g==
X-Forwarded-Encrypted: i=1; AJvYcCXrW1jGSUwdaS9b4PukB2e+8fl0Sq7odj+XxQVsf4nA7Mb+dcVkiQEVz/YlRtzhla/YJ8hx1AqeI98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDxkpCnwSpI1EfMfShnfm1FKnJ5wZtxwNigGVcUiXxGMHUXhMb
	Q35PQDHgEW3FAH1NVmOBHYtgBhPEYNoRsdI/mXJhTu+0Cv5A8RlWMrRaeF0YWyeHAvqRWoNsqf7
	YW/xcCg==
X-Gm-Gg: ASbGncvLWkT+t+2PvT0ZiSHbx6P+PU1D3svYFs7Fpo6mb/db+za3r0mb1FTLmggo/la
	DlxIO1ErB6L1EeQ9bkg+9Y2I968078Fj+lh4AtYwH+yG1M0yBxUDnc/CqkRPhjQkJ1uhh9ulXZw
	qiFsGReHWgT5A7QWyVD6O5IXSYOKygU/8NnjWKGSCLiDMhFNVoiwNZKLJ/6rDQUhfbASNSW02Rd
	VeM0jc3Ugws6BqVucJyx/ltrZQZ1aWqRdh097mS7zXYTNjN6Wv9DKDI9q6sTmxz0obgTeOYdMbq
	1FkypoxOgl9CR5BYqAYajx6n3a3ja7da3mGSG7PI+bgW3xMGYjM4lDweBiuXmfJL6h9MlhpqMWx
	cH3JnYb3giVjcRw==
X-Google-Smtp-Source: AGHT+IEBNTH4zw64AEMKKTiN2s5UEu33251ThUx0I1Ms2D2DvDbTNPIeVXC3gTvYmyig2JEqJ5+Vcw==
X-Received: by 2002:a5d:650b:0:b0:3a1:f655:c5b2 with SMTP id ffacd0b85a97d-3a1f655c5femr12440694f8f.39.1747146789207;
        Tue, 13 May 2025 07:33:09 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm16357348f8f.22.2025.05.13.07.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:33:08 -0700 (PDT)
Date: Tue, 13 May 2025 16:33:06 +0200
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
	Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Jisheng Zhang <jszhang@kernel.org>, Chao Wei <chao.wei@sophgo.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-mmc@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH v2 02/10] dt-bindings: timer: Add Sophgo SG2044 ACLINT
 timer
Message-ID: <aCNYItP6SWImMvFv@mai.linaro.org>
References: <20250413223507.46480-1-inochiama@gmail.com>
 <20250413223507.46480-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250413223507.46480-3-inochiama@gmail.com>

On Mon, Apr 14, 2025 at 06:34:56AM +0800, Inochi Amaoto wrote:
> Like SG2042, SG2044 implements an enhanced ACLINT, so add necessary
> compatible string for SG2044 SoC.
> 
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied patch 2, thanks!

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
