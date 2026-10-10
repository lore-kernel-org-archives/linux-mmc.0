Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDAB3D9547
	for <linux-mmc@vger.kernel.org>; Sat, 10 Oct 2026 10:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626822; cv=none; b=NH7S5DrpUXXHLrgM/i+J038GNLghe5bFvTUM8dEdf6SWSuHeULAap4XhWV92zOyelKSRN/oyxliXsLWPmt/6YQvDA9Y6HN5SatABAZFU7Lf4qlbZXVB+B2Buu014b3Va2xojx44CT4zpIdtN4FutiYuwd84lg3izImKJ1gZ1Imk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626822; c=relaxed/simple;
	bh=G+OmJo6KHk1Dz1mbCFgc9+lDQS9rLz/nyFsb9jkmjTQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=R9bLmXY5/jd0nMJUP32WLgts2OAi4TOt+eabuBrnJiyg8kqRHvZ35lV/oqVlb2GO2Y9HQYE5xYmp2iLJfRsN3WkRyHhvSj4I/KlrX5Bn7h+aXVNJT02zeJJjKr/43vDQUwjgnZ7fIxlVwyRoClEYurjc227FIcJcE25f+YlbHSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=d68cN/PS; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="d68cN/PS"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-487049569b6so304374f8f.1
        for <linux-mmc@vger.kernel.org>; Sat, 10 Oct 2026 03:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791626818; x=1792231618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ElWk8fKGydcvVdEATDJFrXGRGjE67AASQOUO8YEQCOc=;
        b=d68cN/PS96BgvaIVEbW2urVOHeTHY7+qz2vq3ZYroJ7w6D2flGUHlTYleNncFvf4vO
         puUb3WbeX7NaZjNdQ17BYEefqc7aCo6zwUFZ//ichHmHw2uvxkUYlqip+MoobynRH+Ma
         h46VywE+M2rCQUhdXxzsXBSp2DNt5+uNyLjvoh0yGSVenUen61/flVwvUqVCr3FtKWKO
         zY96L61c0UjNnt1Sxg1utoRuwI4rOX9hJdDjmmXYXprqHZJ+4cF2h3Nbq8Oc+v51FzEa
         VjFySdR3C4kLh7p/pvbtWP0Lrnvl8JKnt58lPu6Km54GKt3h6KTjcga9YUY+czD/duZk
         7xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791626818; x=1792231618;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ElWk8fKGydcvVdEATDJFrXGRGjE67AASQOUO8YEQCOc=;
        b=L6yzC2lBebOvjKLhWWn/awsl1DmaYX5UsXC9mVzhGkuqaEXhVJhiPYQcXGqubdUXi1
         1DIqJSJ1zDaknvbx+vKPrg2O/NPKV877L/cJ9+hSPgrNVlm/Gkuf7mq2P3ZgU3YqSOwY
         rwvYFtptQUx7kF9Tlcr6l+zofXGAG4/ovKMWji7YTi9xs/OD9c2R4SyVNHIyuzGp4ZXa
         AboqWmnssp3SdEMgjbjrRmsgSOvvod5wZYwOr/jGj0k97NMNFgfpd6PddhmiZySO7A9U
         tCo1tMydtv8XLJBVsf8BjwzXLPmm6cO1Z7awvslQeznLLECw4moky5FPCCZcEXpuvbSC
         FS5A==
X-Forwarded-Encrypted: i=1; AKwUvBwyguX/Q0az8KeOSg+2VxZdrMDSnm0Afkrz/A0MYpcbLxEF5Kg7Gnu4IQ7ftPuapMzkHm8g/ZCRQ4A=@vger.kernel.org
X-Gm-Message-State: AFq9FYL2hJChepwH2WxQgRFR0PZIhBQBrbY/Bz2/7oD8fv8cf0kmNImx
	+QW0YStTHrEVjHJ2i2zVUx3PAjTn2HOAiNbErV9ii2ywUfNWSNISJ4c/oZBAKfctpxkR2I0AeC4
	IDwwUTMnyPw==
X-Gm-Gg: AYBFou0ECfPW5WyaKyK7Dsjkh6tntoHVmPzgihxf2Lrv1hFSh/KtDVSRN/7deyaTq0z
	AiXrlnmPcnQMawv0oGecxKNRCybEaQZjhKLNBVVX+yPfs4R6I7ekeAt0O2uALN2IOIn5IpVNvck
	iqu3JifU1kmRaJ7N5A3tFSFT82N24oq1xKsDcLpz3P48FVt1bC52IPEX7Ya/hiu4T8+3ajiDrfo
	n3FmHdL+sFNLIaw/bEvaYQ0CnhVBaZXBl5oCLDpYt28iTZvN6MS9GsQHh/1eG7CRqtngh1ZQHat
	O7dMAHHOZJ7wF2zo8/9i+TtHlwHGazpUZnkrHfz2FonyvoRylc+WnewM6XUby36TJAXWJxJJJsm
	odFB2Ru8aH/IatygCcU3IWmsekCcNaP3dN+yyyAeJs7p90/3BMrl7bHqBoHtdm+wQHISirEOr+K
	tmigynbsUKhNRdKbsTJs7EUfTU93MTPBzB7tUSxkDqEiKo6VAJkHONmRBWuBMpldEZCM4QJ3Xj8
	rS5nqc/Xt42+E5BAA==
X-Received: by 2002:adf:f2cf:0:b0:48a:fe3b:64b7 with SMTP id ffacd0b85a97d-48dbacf6ef6mr5914261f8f.53.1791626817764;
        Sat, 10 Oct 2026 03:06:57 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ac6a91sm7389151f8f.41.2026.10.10.03.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:06:56 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Stephen Boyd <sboyd@kernel.org>, Lucas Tanure <tanure@linux.com>
Cc: Brian Masney <bmasney+clk@redhat.com>, 
 Chuan Liu <chuan.liu@amlogic.com>, Jian Hu <jian.hu@amlogic.com>, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-mmc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260905153234.133217-1-tanure@linux.com>
References: <20260905153234.133217-1-tanure@linux.com>
Subject: Re: (subset) [PATCH v2 0/4] amlogic: t7: give the MMC bus pipeline
 clock real consumers
Message-Id: <179162681558.457042.13976808955805070898.b4-ty@b4>
Date: Sat, 10 Oct 2026 12:06:55 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0

Applied to git@github.com:BayLibre/clk-meson.git (clk-meson-next), thanks!

[4/4] clk: meson: t7: don't mark sys_ampipe_nand as critical
      commit: 363f97a1ce635b86be7fd263d56a040fbd87bdbb

Best regards,
--
Jerome

