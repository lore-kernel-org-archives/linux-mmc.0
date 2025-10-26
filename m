Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73B48F40
	for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 19:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761505359; cv=none; b=XSvjapwWUwUHoiSEVtxEqDc64gvWQ6cymc9ddcEta7MJLQ4lNYuleBpL2U2B1anFsf7kpD5zQ/ENA3nkskD+8LSNdRXye0f/J8/cc+COftOMrhnkESIsiNtHjm83vgsHinqWtqqQiSX6NSUi9v1zS0svhZUXkwYCCeW0B+Yq/GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761505359; c=relaxed/simple;
	bh=2Zk64nIinYp75+zdhYO2p5F5t8LO7MM1BYxuCH05Bsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8V7nqJjdDwo7ftYFvaWcJQzKFi54QGz2PYbMofRrZin3xUjCmuucSoQsoTGV0RPhhLLwLu5/ZxEVVtE5rttAQ6rC7vXOLG+/XIp6pTD+9I+4wdaDscb57O6TaiGs69ziuCtRYBJs5kyR6eH7DipjkbzVxYlro8moJ/5ZtviOzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xTChXUf7; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xTChXUf7"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee15b5435bso2791907f8f.0
        for <linux-mmc@vger.kernel.org>; Sun, 26 Oct 2025 12:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761505356; x=1762110156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JTgQLFpDzOTh0ZoPt3i/pwuz2uzBGwVH7SJBsVRuI78=;
        b=xTChXUf7p6MpBXoFbVAcFVB9wWym2dF7Dd/8VFmhZnZdnfCpYA+k7EKRndFOgJqTqh
         Nzw+W7wYIEjYxbMjSeuTnpAeykfIHxnLJUc3C2OSxjOx5lMug1qmaJQaUjY6RnDqYZRc
         M4nD2JsTPK/3NzTDFoYDdDeNjDCnGNFxkxGMWr3q2PLr1lXlH4DSxbOBryzDe0EfPZMX
         UmjvIRM5l0sDDKy/w6kiyOPzfiUJNerI4Q9Pf4ipYsfbPRu+8oZFgZWs3V/H1gyltrCp
         XHZyoyQHo6+drdZJKLs5/B3P52yDwX1qFe3LNp8QY9Vxtbdwk2enfvE/MrjmJZ9+Yctr
         InwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761505356; x=1762110156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JTgQLFpDzOTh0ZoPt3i/pwuz2uzBGwVH7SJBsVRuI78=;
        b=dK1kljdsPQgzEDdUxR2rxrDhpXNyUyRSl9JbYImpFq3Idv98SbiFA9qjouuxsfyy+N
         AizAb+4F+iWOu/Mzyv3tKIZPhVtbLRuA9M7cYcLIlzOLCY4YPkAh1ZtIfiBwtGMaijy9
         I0JtyVvtCdWLX1E1VPg4QrUrBeudzXb1xwxgICMpkvIkhpOnIa3yH/nI1Fh/rX2jmzlA
         n9Y/HzhZ8kc1IM1uCKLRucj68JddyythVXszSMBBhqwAw1gFgEPFtag9zZe6PYReIYEy
         gFRDm24xdZlLVZAbKEZ6KbU11p/+X87Ycdhxhq3Ylk1nJPYFuWAxpZQfxchm7a3azlWr
         eBsw==
X-Forwarded-Encrypted: i=1; AJvYcCW/LjSHTCV73imSx84VayDW+8qro2rGuw/3zzfMGnMagP+Rg1pLemGDyvIi/bfBFtVU0Xo3WMmctBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/5xdSecAK4Ly8CE109E4wv7lz795/kdKScQjQLlRjtot+9Vfl
	UfFxia98SSJKHg4KeGWtyeRVBI7Pv7woyNkxDbeRdQEeSHT/qn+7SsPbKpsZJ8j9Cgk=
X-Gm-Gg: ASbGncsTHxv+1Jb9M6Dp1bO9KIV/Dz9UePJRbUHpwNDrx0ZZWrBAMadsa3PIuxqYQWE
	xbVuqcZWkfD+dWhaY29dIp+T+9FneKl8BFjQ1vNvSEgdbt6ZaJYzGzgOfjz2za0HcVjWjX6gTT1
	sCe+qIV0k46Jt2cRt6d6m2UInzCnJr2TdwKTJoPSHRxva1N86RfmFxwXYM1bo6edMu0CC9GFU7T
	z17cYbH5d/GNaRU2hAz+sjQtukvc06R5ug9tHZXXxA8M97PY0FQz0DzoOyolKjKH8KgtmWG/ux8
	5CbF02FPY9dxPQyU82E6LyTDxtHvhcB5thOMVReNpCQz5LxmnufKdKbM8eYFlc6ibSUO176g2jq
	XHsIzlIvsFmtLe6/lTX11oYEb4rsmi5FVUaH3sXK+TUay0xWRCH8qLep3THXbftzpLzwEn4DQJ2
	/21E9Tb/A=
X-Google-Smtp-Source: AGHT+IGxHR5B1DhcUj3Sg4f6YGF6eRKC27Zj/+bUenMC5vwB5qpsgIYVS5DHdOJagXUhkL1MGGao8Q==
X-Received: by 2002:a05:6000:22c9:b0:425:8bc2:9c4b with SMTP id ffacd0b85a97d-4298a04068dmr8285438f8f.6.1761505355881;
        Sun, 26 Oct 2025 12:02:35 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7badsm9698313f8f.7.2025.10.26.12.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 12:02:35 -0700 (PDT)
Date: Sun, 26 Oct 2025 21:02:33 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Sarthak Garg <sarthak.garg@oss.qualcomm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_nguyenb@quicinc.com, quic_rampraka@quicinc.com, 
	quic_pragalla@quicinc.com, quic_sayalil@quicinc.com, quic_nitirawa@quicinc.com, 
	quic_bhaskarv@quicinc.com, kernel@oss.qualcomm.com
Subject: Re: [PATCH V3 2/4] arm64: dts: qcom: sm8750: Add SDC2 nodes for
 sm8750 soc
Message-ID: <wqkmiumkn4mha26jlky2o2dyplchz4c7kjlhgkictlep3gjoga@6kxhawbf2ytz>
References: <20251026111746.3195861-1-sarthak.garg@oss.qualcomm.com>
 <20251026111746.3195861-3-sarthak.garg@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026111746.3195861-3-sarthak.garg@oss.qualcomm.com>

On 25-10-26 16:47:44, Sarthak Garg wrote:
> Add SD Card host controller for sm8750 soc.
> 
> Signed-off-by: Sarthak Garg <sarthak.garg@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
