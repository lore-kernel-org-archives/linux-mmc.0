Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2506B19E96D
	for <linux-mmc@vger.kernel.org>; Sat, 12 Sep 2026 00:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789171715; cv=none; b=GMZvNVHkMmsdgA8/4YitZINmX2wdHl9Pcye1mKJj48UTzlWfib5MWetjmO9TXHs0fHiF6pusB6CqJ0ONZah2iX4fqurl8s3j6qqRELVSmMdAulH6jDsL7sGPIMSzGwtWlFxQ9vbEjH+l/HFOAfbgMXDH++QFtiXCgR9W07pHh8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789171715; c=relaxed/simple;
	bh=qg2xXIZS9q8+FQ9NaVnqQx5QGT07BCa7Wy5M4wefSiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttq4zVE4cRj+/Et7ddb1qm/Ayfj5zYV0lh7nenXtaGA/Uf61VgdFXOJEkpV3HCu+IW6bFNmi82BrjVKp0AtVUAgthrojo4febjWrAY9Ej7yXZbrlrLKLEJYZ5wkCegRBSYT+0UP+POoXmZmg68Gj3LbIBT4Hb88wR9zuQXyrq74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g8QQoOva; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Viu3DDxX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g8QQoOva";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Viu3DDxX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789171711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+e6U5jGD86yqBXhoRz8wqGY9P2a9TSeSSbA20YZjfA=;
	b=g8QQoOvacpz5TJpghxmtMh4vYA9oUyFX8TR1+LEfoEFYiZgM9nXw7jn3ow9X8027zWdS30
	9jRwi4hX/yQXCS/sWJsSVO37wjhF8zPiwtsIWrWReMq8d4r2YRfsQSrp7fcg5r0g3ICKt1
	I2by67xdUOx38q8aDGGA/aSVqjmgkO8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-4kemIBjlNE-jV3nFGfKBtg-1; Fri, 11 Sep 2026 20:08:30 -0400
X-MC-Unique: 4kemIBjlNE-jV3nFGfKBtg-1
X-Mimecast-MFC-AGG-ID: 4kemIBjlNE-jV3nFGfKBtg_1789171709
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90e8341cfb4so26610666d6.0
        for <linux-mmc@vger.kernel.org>; Fri, 11 Sep 2026 17:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789171709; x=1789776509; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=r+e6U5jGD86yqBXhoRz8wqGY9P2a9TSeSSbA20YZjfA=;
        b=Viu3DDxXEFGseBmlMQxMTMPsPIU5fm7TqvE41+LFBzPYL/OgcGske6+LVxjTy4dAeQ
         BQrOTnVZ5oV8qLKQkBnlBtlqng1jsY2bi/9ciT/J9Kzx/VsHOQYBvoSLtJ/qS0cvEE+X
         cvKpWVW8rJMDRURfHcSY/XziCouHIzHN7ot4vpR1Vilh5kGbYBbonZ96ilqnFexC8W3n
         U67O4Q9XxKQk/rGpJAHesCcFJ9WzDLsldcj39Q7MoLOBp8CpO0emtchNK3Y/T/gTTdsY
         9uY/D6a7DebBXx0ofSvCkDEg/dhAvQlV9KI0RZq399YVtCevBgJn1SLVEJNOEXD0yc9l
         +X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789171709; x=1789776509;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r+e6U5jGD86yqBXhoRz8wqGY9P2a9TSeSSbA20YZjfA=;
        b=M6uAObpJrTDbydnBwvu0HLRFuwNSaoxyWLUj8ckXaXRr7h2TtQVXwRpZZuoH7NrDYM
         hY2UaCpvoJfi89Mi23vPRJSYSEVDWv3FDDY4yxwP8qlRVPCZZlLsukB087ikuXZXe6fJ
         x1dDPT9sceCPtiLokuLkjo2QUHaVGqTgzu4ZZ4SutxUz+PzX6yCjclNAtZhSG5ju0G4S
         vJtZ49Mx+Eow6KTAdVAgVpB/8FjvhwF7tLf33jwCoJIQPEYuR111aaNnFOMERnnczNiQ
         VffYc7N8WMMdanid9NjzNoe2NqP6u0jGkfhc+Ec9fw7y0nl/TD8qP/MlunXojXvLnKXY
         ZZ/w==
X-Forwarded-Encrypted: i=1; AKwUvBxKhCg/kU1lB9oW7KDqzKz7mjUwic/ItIK+9I6qn5Sa2v9ndTG5bcZlkALez1cF4NjTvJDB8Non3zs=@vger.kernel.org
X-Gm-Message-State: AFuF++lF/koMjtURe5GOX8mdNsbEMCzlXSL+Y1OEtjrZHcb2Ups+rkC5
	naWF2zYROfIQsNL5vGjd+AzMUPeydXg7u9HDgKm+rQwqFcpl3MWWvAifOkMjwYUXnucZDy3W+45
	ZH6p0VSNw8XkOlKYOxUBVo1E073F8hQltSAnEY0S1CI85cFBeA0+8i+NgK/MHhg==
X-Gm-Gg: AYBFou3zOIR+zM99NGcSTuYdf2tVFOOwM2FJfAaeZiwpp0SSdP4tiTxazAuhcaflqqc
	GUONVJwEsZoEDUNph3ZTq+aWXMyiWraJlKBnOagVbZ3jtq0G2amAKwCQL1/f58ZRpXrt65xF1vw
	3ixAZH7zrV5BUWmZi/sf9xK9tZU+zQ8ms8IY8WzXKP/OhrMYTIAVX8oDF6RDDCmErz1aBkeCWzP
	54SdVIZFx9sICHrr+foEDyPAcI9LbhoqggWae/D5OydMbeHnbwB9nv35OaBh8LTkdLvntuN38JS
	R2cwk0bVLuwM4GOEJA5qRH7mHGn+/M6rPRxPphZ8m4s4///Bw5eNcMZF2pD4ZTvR6FvgzgKU4/i
	QfD+ZsvdoYysxkS4J4RaciTTWw9yTpKu1SyY=
X-Received: by 2002:a05:6214:2307:b0:910:722f:b8b with SMTP id 6a1803df08f44-9121da7621emr10925406d6.21.1789171709447;
        Fri, 11 Sep 2026 17:08:29 -0700 (PDT)
X-Received: by 2002:a05:6214:2307:b0:910:722f:b8b with SMTP id 6a1803df08f44-9121da7621emr10924946d6.21.1789171708976;
        Fri, 11 Sep 2026 17:08:28 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f20367dsm32915306d6.6.2026.09.11.17.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 17:08:28 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:08:26 -0400
From: Brian Masney <bmasney@redhat.com>
To: Lucas Tanure <tanure@linux.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Chuan Liu <chuan.liu@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
	Ronald Claveau <linux-kernel-dev@aliel.fr>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] clk: meson: t7: don't mark sys_ampipe_nand as
 critical
Message-ID: <aqSX-kUvYaixESxe@redhat.com>
References: <20260905153234.133217-1-tanure@linux.com>
 <20260905153234.133217-5-tanure@linux.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905153234.133217-5-tanure@linux.com>
User-Agent: Mutt/2.4.0 (2026-06-19)

Hi Lucas,

On Sat, Sep 05, 2026 at 04:32:34PM +0100, Lucas Tanure wrote:
> sys_ampipe_nand clocks the pipeline stage inserted in the bus path
> between the SD/eMMC controllers and the NIC_MATRIX fabric. It does have
> identifiable consumers - the three MMC controllers - so marking it
> critical was the wrong tool: the clock should be referenced from the
> consumer nodes and claimed by the mmc driver instead.
> 
> Drop the CLK_IS_CRITICAL flag and update the comment accordingly.
> sys_am2axi0..2 remain critical as they clock the AXI DMA bus itself and
> have no single identifiable consumer.
> 
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
> This patch depends on the MMC controllers actually referencing the clock:
> the dt-bindings, mmc driver and t7 DTS changes adding the "pipeline"
> clock must land before this patch, otherwise the boot hangs and memory
> corruption this clock caused are reintroduced.

This series should be merged together in one tree? Which tree? I can
provide an Acked-by if it should go through the mmc tree.

Brian

