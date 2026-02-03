Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22923009FA
	for <linux-mmc@vger.kernel.org>; Tue,  3 Feb 2026 15:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131107; cv=none; b=dA7TTWq7oPMLcgg5nw4n0nksKMhdrLteWHbucc2jm66kwvGASQwdNnsJi30UVDxOrf8l3ZLDjStE0Le64Dr8zfBjaPNaniGDlJpeUtMSVuYpqBGFLoghT2DyLWTK2epSxIEvl/z1TKKJBB4Gs1GLXaf4Oa5vtH1R/jXy5ABCO80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131107; c=relaxed/simple;
	bh=dwdID4DDF4GDX1SlmcA+3fzCA+ycXbc62Ld/klzXumU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLWSMQiI96JkxPqNQ3udtTkueHKwAlNv97HHVnKbEBoCidkF2Q15EUQrJVlTbUCzxdXBYVXgNAFm2Red8T1Y/8S/iws9zo7a3t6EOEz8u0CPutITTv9GTGfH61K5asIFziQRABEw802z9bdC2yY2InHBI8qMCn+iOSPHdN/9s/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QpSyuDXo; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QpSyuDXo"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-658ad86082dso9941728a12.0
        for <linux-mmc@vger.kernel.org>; Tue, 03 Feb 2026 07:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770131104; x=1770735904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9PNsfQXg9zjxapzMuZRa/zLzG4m46Jh75ILxmkVsiiI=;
        b=QpSyuDXo4abof9JkO71XCU0L++sL4W1+wPJrJo7W48kuy7WOXHhZrQZj7eTlkvPt/r
         3EF48KIYISJTJf0dVDzcU03GLcWVwnutn/ZqKxcZWAIvyGfGJbH3OQmEC9zHKVx/3eIv
         1uTifqNKiZLo622FwwQET8TQ9CzNqaLQbpqlEcTxtTxdcXJpFnpeRmlk+U9QiLi9D9x4
         4SSHT3da5CfLVETraR88yINgZJ8QN233j/EuMTgUZme3bzkTwEAgE896M2Wge2tCYmS/
         9zB7LE7l7vP30fslwT/TUHL8yBp84Ub2EbiZOUWsX6FuvpJiKF3eF8Aavz8x1Ey8WR1o
         P/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770131104; x=1770735904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9PNsfQXg9zjxapzMuZRa/zLzG4m46Jh75ILxmkVsiiI=;
        b=THle2npknpH2KoVR9M1sq1EVVX+Cjmz+WC8p8mIwen0KdWt7+veM47MtGL+RBQZNRv
         YLfVSUu30l+BqrU+nWrjsIBaXoA/3JyFqP11cYS3gVvV5ydDJaEccRb1ooE+elxpniFB
         OR902rl2lBAYM149oxoFpUpFTff2qbnGf1sAmzWeXSigwbKNTQSwcHO1MXiU6hBLY8X0
         h+lIrziQpliymog7GXPgmu3HM2ZrjyYPTqHhSmxh3IW6hpCONUIgHSZobnUfWtHlBgXJ
         GLKsaqi7LWKB35K9/uymJSpnrN22Rq3F3tf7FcGsCyaL3QY0bTPZatNFt1Wq6iAAB8XF
         UAig==
X-Forwarded-Encrypted: i=1; AJvYcCWxjhXEmoyoFLi0hPcXfc/b/79WjTWoKJAVYC1ID8e0yKJcOUOrnjJ2II2X0HoKilQXf7n9vR9MAwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR9b88FgMyYEZKdBkUO1m+dH8q6NIIbxF9YPJEz0KL78ifu6FG
	SzXngOiGmb3zDiK2tdO9OP55BOqZXFbDVtVxVE4kmdw9v5jfIQ+Q0LPnelbfciJMPw4=
X-Gm-Gg: AZuq6aLKteqxsuo1tpDbA9jsO6BHm2gzx1ev871rTtSXjvovmKbGy5W418dNwpzi8s9
	8tmGBysVgl6KYTHIbT367Irg3rIgdPvbRAoiNV7E2GLN3WOMcwIwoYiDkOsHD858u9DqPKxm2tN
	Q2a0CDL1XtAVlOBV5eUl72ASbcB94u6JAnpv/7IwZHOjTKAvgik5NtPyOEOcaCWdQO24KiSGgFk
	KoZKwEeqUto5ImpBz6HRu354wvH3XiLbS8gsKBdbjgvv4njMBdPwuvPBj8EjU3syUmzbMesR7RT
	ZNMNIWa54jZavXdWiSyOeoqp1HOTqhZG+00miDVUKrkRNd8y5xaDF/bWCf183ILfVN3l+OkC9ML
	WaZZUfojFlf4MX3VTdccg58QbHBtLxGw9DruwaKjEZhKdpHph3E48V06pUdxMgfPTCVMv4ycA6w
	INRwg+CeiaQr+dFQ6h
X-Received: by 2002:a17:907:96a8:b0:b87:65c5:602f with SMTP id a640c23a62f3a-b8dff7a30a8mr1000149366b.34.1770131104069;
        Tue, 03 Feb 2026 07:05:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2ed6f8sm1049398466b.65.2026.02.03.07.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 07:05:03 -0800 (PST)
Date: Tue, 3 Feb 2026 18:05:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Josua Mayer <josua@solid-run.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Peter Rosin <peda@axentia.se>, Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andreas Kemnade <andreas@kemnade.info>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Janusz Krzysztofik <jmkrzyszt@gmail.com>,
	Vignesh R <vigneshr@ti.com>, Andi Shyti <andi.shyti@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yazan Shhady <yazan.shhady@solid-run.com>,
	Jon Nettleton <jon@solid-run.com>,
	Mikhail Anikin <mikhail.anikin@solid-run.com>,
	linux-can@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-i2c@vger.kernel.org, linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 2/7] mux: Add helper functions for getting optional
 and selected mux-state
Message-ID: <aYIOnErmiSZ6wnP1@stanley.mountain>
References: <20260128-rz-sdio-mux-v7-0-92ebb6da0df8@solid-run.com>
 <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128-rz-sdio-mux-v7-2-92ebb6da0df8@solid-run.com>

Sorry about that, I just looked at the implementation in linux-next and
didn't read the code from the patch too closely.

On Wed, Jan 28, 2026 at 04:46:10PM +0200, Josua Mayer wrote:
> +/**
> + * mux_control_get_optional() - Get the optional mux-control for a device.
> + * @dev: The device that needs a mux-control.
> + * @mux_name: The name identifying the mux-control.
> + *
> + * Return: A pointer to the mux-control, an ERR_PTR with a negative errno.

I wish the documentation for these "optional" said it could return NULL.

> + */
> +struct mux_control *mux_control_get_optional(struct device *dev, const char *mux_name)
> +{
> +	return mux_get(dev, mux_name, NULL, true);
> +}
> +EXPORT_SYMBOL_GPL(mux_control_get_optional);
> +

regards,
dan carpenter

