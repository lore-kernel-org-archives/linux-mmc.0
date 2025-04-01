Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D497A1E766E
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743508351; cv=none; b=jGHfMu0YNcBQD8mIyrizM4YUziZN3F5CBWkik49X7KMo1jD4M8pRtVITUBdW0tEKGczo9vjBLgjoHuE/jbGLCNGpYacPBKQzbJxRLLN3WNSD69/FMbCqU59ZXsBBOnBokRzLI0ZIDvmAJZOy5ntRLMXbKwW3c7Okh8PTur9dacM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743508351; c=relaxed/simple;
	bh=5yzItQ8LqgsxF/Z/FOtRoqOr5/8mxxWTWVmuv/75QU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=J0BsuXoqEE2d1QuvouEwm0nN9+SWELb79GkdMckgSxi+AixRshJFfxMPvVgg0tmc57eDT7rl8po3wsgj79qu8yyGSUih91lXTHWZdVNU87Sr7zvt3rJw0Hw3JwLqIbQIQPsKUwbwP842Ddklaw52avT1dfkdTisPwbg4U+hhOGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YCWmJsDH; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YCWmJsDH"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6efe4e3d698so49201737b3.0
        for <linux-mmc@vger.kernel.org>; Tue, 01 Apr 2025 04:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743508349; x=1744113149; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5yzItQ8LqgsxF/Z/FOtRoqOr5/8mxxWTWVmuv/75QU4=;
        b=YCWmJsDHlUQxuY1RTTB+LDulZHtMdOhIPDoT+jy8nl9w3nWybIzv4Zr6Z9QgExa8yx
         mXuaoWRQdor5DbyZus15LbDq46tnVQYi+Q1NgtvZGtZhVJbN/oA6FiRJkjAmeKvVUsI4
         WeD76VV61jHg8sn2ppt/8IC+IKt8Q+ThZz71BFG67HJIShVkvFNP8vydITc9RxW4jj8U
         urX7NVWBlqUCGWxukRHhuWII0enMGQekApRsnUVVZERC1zV4ASLXyaZ2ffkSjTw7XN1m
         tjnfX7dNVMFHNtxg8ZWqVqjfXjLVujOmfcNCu1BIkH42i5LHKp9jljjINi7D24XPtQ4M
         FDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743508349; x=1744113149;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5yzItQ8LqgsxF/Z/FOtRoqOr5/8mxxWTWVmuv/75QU4=;
        b=KoyHkFr4/+7vCgvuHWB93y7mQLEaK0zo+p9nMWV+EVuiwrgKfvhVj7dTkgcSt4x/Qr
         9AtapWHpWecJmD5RzO8Socy0J9ZVp/aBbbpsgeFaPeK86vOD6/4xOpUrEaOGXeYdCrDt
         U1tR0Cx7KTA6fZYfYssJ7L5wD386yGT4xxgGicxEXNZOFKNNU2Iw0ym90RzSSF50ureJ
         ZYlgYen3qqQuw6fixYhD3DHPCUiT5BUJxj16wJbv0jCpm47Ks9aJ5EUA9g7ZfEIYQ7Z8
         8v0SDzy7YDKr0wu16Owfy0tU9eOm4zi62LTi+FuDMrmYt1eA146bS+LmymABWc5VJApn
         DHxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNRxysjgzvsRMseIcwHkwbT67m6GNKxW5Kn1X5adTTNsKpEGXKSz8PQ2Mv2r1Yrjwj62M37ONkqTc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1/xH+RPTSv7/kOr96H/O/Nme1DbR1pvbKMVxaaVX1KaEseajw
	ZZrBp3PR4SkbDMLJiXZOk28OvWz6lIv/wN88bVOg/LM7se8S5l8so/xj18Yz50ItoTyAmjVVjBf
	gD61Pb3rBLk1dI/skIud0UyYT0gL/ZM9NYXKtPw==
X-Gm-Gg: ASbGncs4rYHmWYloubd1IJPA5SLDkQlsqEYjph5LC5PprNqiy7m9tOXF/zUpP/8xxR8
	T9maNMCshHON/gFWWgpDrvStu8fwlaaAHaz75A1bUsouwntT/2T5E5Wc7V05PcpfMlZULQaA4sN
	FLTbkRZjP/9lg96pyndQ72yI8LDVQ=
X-Google-Smtp-Source: AGHT+IHxaEOwFTKWaB+ZSBcVAKNOPJ8aS6UOQcjmnOX5LqFicwu/ZfbZg7gfUlNZSAkuJ5/12Ji7ZaV/z2l4CYONuRg=
X-Received: by 2002:a05:690c:6706:b0:6fd:3ff9:ad96 with SMTP id
 00721157ae682-70257302fe7mr178667017b3.37.1743508348824; Tue, 01 Apr 2025
 04:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320140040.162416-1-ulf.hansson@linaro.org>
 <20250320140040.162416-6-ulf.hansson@linaro.org> <Z-pSq5e9MXTX3qfe@shikoro>
 <Z-uou73DUQoceMj5@shikoro> <Z-upJTp3ykMqvSAl@shikoro>
In-Reply-To: <Z-upJTp3ykMqvSAl@shikoro>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 1 Apr 2025 13:51:52 +0200
X-Gm-Features: AQ5f1JreKDN8MR7O6t-gHP4ZYjEMdyeapyJn_AtqSCQXCxMcjN2-RxnBrWR5pKE
Message-ID: <CAPDyKFoc7kWePb3SvnAHZDBNnpiA5Rmccgh3OufS_gSSfNbJrA@mail.gmail.com>
Subject: Re: [PATCH 5/5] mmc: core: Add support for graceful host removal for SD
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 1 Apr 2025 at 10:51, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
>
> > Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> Which also means that I tested the whole series on a Renesas Salvator-X
> board with a R-Car M3-W SoC (Gen3).
>

Great thanks! I will send a new version addressing your comments on patch2.

Kind regards
Uffe
