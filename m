Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599D373BFE
	for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584966; cv=none; b=aWZQMf/tqzk5+yjMTq5TBdWstzKxTJDyUVrdvLtbkNfL+YxC+Um3QIxhF/wxl5eZBtw/KCR5aYoEo4JuOawmK5P8AtMnbYx6KrVxD6csVLnWX60CuO+1NF4YJ8Y09W0gaSVHBdYfb1wWcJJaI6FnXJF28FLvPeKT5Yk1tasleCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584966; c=relaxed/simple;
	bh=BgxHo+ySNt0SDscvHDIJ+CWLjsPpMmXNfeGCoW3Rr/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYsdwJPRMKH1zBLOZ8V16sdsmuc4XcqoxjRlWVADoykmvsTG+XGknpfgPpr0YAojgieqTG8xcXg8p/3sQftERWAB8SykDCCf59GYorexwKBNcTy2tgWAklkwLw9WFNAp+tmuJza8X6ZmX0cDQd5pBtVxxoAJsOej+fFCWIcaRsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BJkHAZtS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uJ8O+66p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJkHAZtS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uJ8O+66p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787584964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+MIjWVFV9tiFSCvKJHotyKhr1YJnlwFE+nvcQBHjOak=;
	b=BJkHAZtS6FI2Dfn7XGIOs3hSWinJf641NyCauRfE9SNXNlbjv4MPo1QgW5sQdtskVrpygE
	UNT+DtAd+R2ce5nWmv+jps/yEKFl7lZcU8Nk88UyCva039Pfe8GfwWPbEx8jC0Pp23ZRAq
	BPMcLy49gslrCCaUqehxzgfdWGosOS8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-Xte8SE8JMheQjfisfNjS6A-1; Mon, 24 Aug 2026 11:22:43 -0400
X-MC-Unique: Xte8SE8JMheQjfisfNjS6A-1
X-Mimecast-MFC-AGG-ID: Xte8SE8JMheQjfisfNjS6A_1787584963
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-90c8da50f4fso18041056d6.0
        for <linux-mmc@vger.kernel.org>; Mon, 24 Aug 2026 08:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1787584963; x=1788189763; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+MIjWVFV9tiFSCvKJHotyKhr1YJnlwFE+nvcQBHjOak=;
        b=uJ8O+66p1WsGn/r413A9RAdBNFWePnr8an/GmesDFrRovozJhxHa6A5NX2Yp/U7ntC
         /LhjRHkQIwzQq8DUTxgQjqLyUFslls0lICWLEkQuJttdvxMm9oSQYTrvAHKRJ+50T4sz
         GeesFAzRtWpl6uV9VgxTTAt91QRYkeq3u2JIqh5NrpGuivaTgSSrKQQP4pJp7wesvr+Y
         EahA2KNzmkqDb2wE6jYN8Qe4aFXlKgB3bB05YegmRdghif0wh8Hxtds9XT5RxJ+6v+Cd
         3LlvOc3HQGBwuKR1nhkNZsOOQiZ6alGaHPlhlgn5G44EbQp5LnlTmBNpxmDl3tlusIsm
         mtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584963; x=1788189763;
        h=user-agent:in-reply-to:content-disposition:content-type
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+MIjWVFV9tiFSCvKJHotyKhr1YJnlwFE+nvcQBHjOak=;
        b=LP3P7FI1uDIdchRWGGBrBbMXb57RldpnPASFELRA1lJUVamPzK29fCkcyQn7fjHD9w
         rMcS9HoX+j25ftDuk0v+XEMKW8tBeikDDkyjKHZU/sZsn/i3uRGiDRiW2AuCwwiJE9Lb
         +9/nPq6FWn3saLI+DoLsd7a+t28DsGcxe9SokiPt7afCEZx6V3XMSeG+ADU7q/TV97Sl
         JIq8wpgytcZtYn01XLtDxqDhEKzkZjozKzpFCycqeoieaWJV6eyPVVMXOMclemYvcORx
         Cg0zLAD1R8B279hHEqBj9pDswZgBheos8JR1VwqlNgLj1n/jIqUT13mWnPt3cY2KvjIh
         EpTg==
X-Forwarded-Encrypted: i=1; AHgh+Rp+cpJRm1YH6hZyt8dy+3rdz5rgQzPJYiMlykkOir8uKPzObBG/td/A+NoQggk62w/F0XS9UmXClGM=@vger.kernel.org
X-Gm-Message-State: AFuF++lojJWkJPiMPqrHusGB1P4o6LEgV9bTrNwoiGfP+gEqaZ0RY7zF
	9NN6SbE7T+dFYdbqlheN8VyVMGN/Ar0tfgclCs5JEwBmXxg8g99717IKJfcjLVBbzElpN/otcsw
	WQhBDjojUbryTwATOXwF0dppc2K5txFdIw5SJMvhhohKZizGfWGv4Hp1g9qGIJA==
X-Gm-Gg: AR+sD116gGcnW2fFX6aGKy7FQxKOpmT0MijOLLTN5816bGRjHRCsVex8SNbXP7TNFxI
	jGVYOfA2L7XgxFt4rbMx8eTOl+8r529mDV+bFKw+hQnC4Scg5CvHepSPQdS1hv2tx/uE+6A971g
	gqsKkxKDmsX2PYO/ReWscDbFmPpTRreDVvA9IplhhZKqZCuljDWTgEREwq4tsf0xYuG/btsJozI
	SNAQ7T1Ki7r4C6rOdUyncMQXUJcTeIJskjnZ2xLQ4Kmmyh8qU0+SzEVnbabJv2hDKPc6lx8mUu1
	3ax6smXeQKFZktH1fJA+7F7qyDa+FErwOaN03pxvlryhA6P5Avfo6zhvYrD5CnJ1OFcQ+3x3mTU
	sgBJB+QtyTUAFrt7xlzNRWPFkMvrO7QB7joo=
X-Received: by 2002:a05:6214:4113:b0:8df:98e0:4594 with SMTP id 6a1803df08f44-90c80c5c09fmr261569016d6.15.1787584961620;
        Mon, 24 Aug 2026 08:22:41 -0700 (PDT)
X-Received: by 2002:a05:6214:4113:b0:8df:98e0:4594 with SMTP id 6a1803df08f44-90c80c5c09fmr261568266d6.15.1787584961110;
        Mon, 24 Aug 2026 08:22:41 -0700 (PDT)
Received: from redhat.com (c-73-183-53-213.hsd1.pa.comcast.net. [73.183.53.213])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c9393202esm65746196d6.27.2026.08.24.08.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 08:22:40 -0700 (PDT)
Date: Mon, 24 Aug 2026 11:22:39 -0400
From: Brian Masney <bmasney@redhat.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulf Hansson <ulfh@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Michal Simek <michal.simek@amd.com>,
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 2/2] mmc: sdhci-of-arasan: Make sure clk_init_data is
 fully initialized
Message-ID: <aoxhvzXB_Cn2vExX@redhat.com>
References: <cover.1787240090.git.geert+renesas@glider.be>
 <0235d3a3d5b71a125eeff6d7be25ddaec80ce539.1787240090.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0235d3a3d5b71a125eeff6d7be25ddaec80ce539.1787240090.git.geert+renesas@glider.be>
User-Agent: Mutt/2.4.0 (2026-06-19)

On Fri, Aug 21, 2026 at 12:06:04PM +0200, Geert Uytterhoeven wrote:
> The clk_init_data structure contains several mutually-exclusive members
> for different methods to specify the possible parents of a clock,
> prompting drivers to initialize only the members they need.  However,
> not initializing all members may cause subtle issues, which are only
> exposed when CONFIG_INIT_STACK_ALL_PATTERN or CONFIG_INIT_STACK_NONE is
> enabled.
> 
> Make sure all members are fully initialized, to avoid such bugs, and to
> prevent future breakage when converting drivers to a different method
> for specifying the parents.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Brian Masney <bmasney@redhat.com>

