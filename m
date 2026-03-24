Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406F54035B2
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 15:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774364673; cv=pass; b=kXa1MWEyTnB9M/i7oLYoCdirvYaXbQTNEtjoazQ7Hsw6xE8mV5iA2m+Bfgk7VdXd77NQ9IPfbuUPm4ZzgYpnEYJM9y77LvGMXJFXFMGnfWNyTPSdSq95I7ucfTq6v1nWxizrnv0/hiBEjRMPhusntAIpqT2WnHcDGEwbU/rBMi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774364673; c=relaxed/simple;
	bh=bcWhaCXDqT3/4plABAPIObuBjV7tjtyRKuCbcY4Z0B0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbgRWTeT1MGBvLL6HHJdHDTlhYRWoP8Pu3Yo3gyPIQ+wQK55KUtoYvf/U8qLE311Bk4iEVGRCiw01hTaOmAavyQsaUPJ5QSwK6fFbG44GX7PgkYgSRNgqggaDV2pTC2rwWcA1lW0FJtRdRE0nzUFeHBZosgv9IB3qI5ORibZOwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s8dkKayL; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8dkKayL"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a297a69089so740296e87.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 08:04:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774364670; cv=none;
        d=google.com; s=arc-20240605;
        b=kVbA9qf0G6VTFXseREdtXqy0lYfKxOz6VSKpYbwyF//tMq2xkeO7wViUvmE0aZgXvN
         X5FovlDEfTRAnQ2VomDrgLnYWrZl+qinWnlMJnpPL51kNmSbNEGn2DoP/sAtfjcBXGbu
         HK+q6zRN9KUd5HVtA/SkfK3HJKxGZDwG6k512Wl8awjQQ9YJhszmVYjS0qJStC9Z+r/G
         wM5zjybTMzrqFNaNH+ibQG2cjTd33vzAlhivZODoGkfdo+wUp59yA/mi17iFsBwPm3u3
         9x2lPhkgLOx2dGWr0u7CB8xT3YyxotkRybK6+D1fcYC+63xZ507OYRu1lVau4ZOXBpxv
         o7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EF8mh8aKz3LIz19P1c3H9JBQd1g9ZFsPluy4phQ6zIg=;
        fh=3s7PK/QOqjz7s1L0+e+6fkSzYx81r6rvKfzr0GAaKCk=;
        b=YiGZN4cJHo7R5Gb76xs3G638jGIRonXIqgZMpsry1JStq8aE3j1R5Xbm3towi+EGvR
         WUwxdaKTwn0tajdDpa9rbV1yL2a2SurZt+7bw2CQHXn2dV2vtJwXjR5kYSGfWNCtvMuT
         20rDa9todoy/tQ1HbEWHURz/nBri09nqt3faV2RbJQI0nzNQdf5yYWj+LTSO+7YpZe7+
         SA8wBTkhEEpIyrjqs8xm2iQo23CJemB8zkrwpNDOx7v8Q9VZn7M/GwxxAgYTLjn4gJcE
         XSRdtfEYrU/CAUBjLkwuyrN2thKyvRJNTbdb61RNnX77Dx6y3z4jI5oj1S/cfoAgOWjw
         K6vw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774364670; x=1774969470; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EF8mh8aKz3LIz19P1c3H9JBQd1g9ZFsPluy4phQ6zIg=;
        b=s8dkKayLdhMXbT6NgL7fC1fyEqSkeMRs7b4B6BMGO6a2tnTF272oSnt+ZsTVvPk36p
         hLlQQzzu2nRUHFjFD0GDPSuxSE/czW0sk98NXcnZGcB9e9VRjv0Rd3Y4/KiDsmWwGYn3
         np+oJxx3VUKxZ72IaBT0b4WKQfZA4ci0yWeXNSeVPSxmWeNgIYHrzsA9CyC3gI8lL9t3
         KyRnrwoJoS5sWvY/m1L6oUFFlImZnzvjFgEs5GtRfbXqyETRDiCQ3JBgrwN31PgnMQwT
         ztmteYq2UnJtIF9exOTC5LfNK93T4U+k+ssyAodqUe462Vr+Z1axlOTHKHZefOqCrdPs
         EzLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774364670; x=1774969470;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EF8mh8aKz3LIz19P1c3H9JBQd1g9ZFsPluy4phQ6zIg=;
        b=qu5n/5LxqE5mvWI9YPm6nKD7e3w5rRFfLWdGCiMj7208umiXBuLUOzjsXNX+JsT0l/
         TzlKcXB5NlC2aU0ZgZD+B7OjMPqWu0ZC/hWTgwtd+QMs3OYaOCtsIcL2UY/jiCmG6HDV
         7nHYG0uWnF0HWl0bpXv2xzoWeZeKHlo0b31j3MJ0wd46BuFQCoJU5LzJlF6qgP+rmBYm
         AWFAArjFUk9EcjRsFCTtlMjkrisg8ITkvbXD4nKy3b75mLI3uF1EUEUzSlqXhoD+Bn4k
         rndbdsuu5oTP6UsL8f53qbHa6AK5EDckotK+ulBr84ss+ZgX/yVlQmWxDZE+L2L6VYPT
         FaCA==
X-Forwarded-Encrypted: i=1; AJvYcCViMl+HExATxvzbP18RS1LPw60tUyE5ARVmQzIJvt3CWDoqhBzWKIuPzv3DZITuX4eQyoVIHxW1fAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdzXzNM/Y8MOqJg9RuY42X9y9qgDfIoZveqxg0nq5r8Zw1Qb31
	WxTE8fwALvC+UZaPf6gW8F/74WrOBp2BlvtKMIx+40UBdafkjTZ0JP/fE/q3PGIq5L+k4Pai5Yq
	HLVcDYDoB6OFTIVQh8UDZsEUo0mlxbZx15YJD7iU7ZA==
X-Gm-Gg: ATEYQzzGyWaMFTm2WPpMuRQKr4HBP5nYx65V4WvuyAnuaehnk4U5VsKxV2G2Qxwg1Rw
	pRSaj5+Sc+6FGI074HTaB0d+AtSTx9eO97sS9nQfgTLihcxaW4xUxP17xn2gmzz63Lx9nFhFUJf
	UH0QIZOhRA4oOFUWXhYtu4T+M+7+tm7eCW+Te1ho+Nco+DCQCsYTTq9vxRzXIykg2lZe79pjNe9
	SVpHzIeSOQzqEo9YUJXoOtSrhwQ2U9uAzPIkSoryJXlaVBfCvIW+cM1KNK4a3dYF4+zf7A6+6Ht
	J0kacwjm
X-Received: by 2002:a05:6512:15a9:b0:5a2:7d84:6a44 with SMTP id
 2adb3069b0e04-5a285ae4b8dmr5600779e87.6.1774364670294; Tue, 24 Mar 2026
 08:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324-sdhci-v4-0-c8c2060ccb5c@aspeedtech.com>
In-Reply-To: <20260324-sdhci-v4-0-c8c2060ccb5c@aspeedtech.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 16:03:54 +0100
X-Gm-Features: AQROBzDGb2O61nTd0QV3ZdTm6lrh7bdMvQHr7qGN2e1GOEsGjRP5W0BZL_IWEd0
Message-ID: <CAPDyKFqwCahQCw7kB495Ym1JmSkn0PAkXVn==oV9_pKcb9zj9w@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Add AST2700 support for aspeed sdhci
To: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Andrew Jeffery <andrew@aj.id.au>, linux-aspeed@lists.ozlabs.org, 
	openbmc@lists.ozlabs.org, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 02:58, Ryan Chen <ryan_chen@aspeedtech.com> wrote:
>
> This series add aspeed sdhci support for AST2700. The AST2700 sdhci
> requires an reset. This series updates the binding and driver to
> support reset requirements.
>
> Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
> ---
> Changes in v4:
> - 2/2 rebase git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git
>   next branch fix the conflit.
> - Link to v3: https://lore.kernel.org/r/20260323-sdhci-v3-0-93555b8f6411@aspeedtech.com
>

The series applied for next, thanks!

[...]

Kind regards
Uffe
