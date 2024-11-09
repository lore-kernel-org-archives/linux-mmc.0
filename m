Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B2198833
	for <linux-mmc@vger.kernel.org>; Sat,  9 Nov 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731170173; cv=none; b=u9sxaHFNuLbllUlaWql6Uiz/6d2OpEJXTJqejEyvfSwPDY/Q66XBEKJP4QOfZJcnpmTc9OM1kcg0YkZKpVqTUIw0Pl6NztS1d2I69zIvXeZ3EL1PUynDsRuA3dK4YOuUcz4hLujDClh+jUPAOtBGPf+IGjPeJ0Js4VL5CPZPCxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731170173; c=relaxed/simple;
	bh=1zw4x5pQ+s0kBi09AAI4rx8p8hKJYjtPeE1I8rzMFvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JUFNX6cGo/I5UsIY8NEscRb18K/CljRlOTYEEipmYfPnO311aRkFEFT7avxhhM/4CCUt0habxDIpvmhTh/7g4O1O7P1pTcN0SHqEGmTfMxDLLQ49AqNrxLKw0OGqIzs2GeVcetBeBWITM71U7di7ZAEqS2Bu5b6exV6J2RzvSWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QTBkzIuk; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QTBkzIuk"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b15467f383so235530085a.3
        for <linux-mmc@vger.kernel.org>; Sat, 09 Nov 2024 08:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731170170; x=1731774970; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LiyXTt78v6KIZQ1Ji+ZoKsI5Ur+Se/pukGeJe0h1QHs=;
        b=QTBkzIukXO/v+Oq7d1nDN7ZAVuCYSprCwhsPH2i5zCp1nfOCD2/eHG689p43iarI9j
         ZZt1vZoPyqeobWR9z9WELOFMpkYR7Pr2Af5eJvSHWJ0IjrJVaufnZvDA+Zurr7ZC2UFD
         y1DnArp+Jn10dEvA0YaFct3RvrPAXjM5UKlnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731170170; x=1731774970;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LiyXTt78v6KIZQ1Ji+ZoKsI5Ur+Se/pukGeJe0h1QHs=;
        b=PUMm4daqCV8C+FK92Kpr1Ar+9gcSF20hyrck6F7rnzgDwDkO7Dn62Apli/aerWiBV4
         r+Y6inIkOtLNsJFvU9p5MYd52WvcIUxGQcTEe4q5x64OTzpw5ai+5hK2GLQ8VWDMsLwU
         oy8FmNuaOE+A2BMZKby1pMlojLDL/o3KB2YHCHsU6BSZtC9OBToQirSK41DoSmjkRnZE
         KbQbjYfF+zdqtaNo1nJvmEvgwBaXO2kG2i981TnThq8CPd9i92Oju/Av6SHkQzyQ2VCO
         SXXMlnsoTIopSUXh22hzaKMLevr2ln0IdsRt1p3p0ykHj+Yiyvlw2UGiK4JhyRxh7UCe
         hOmg==
X-Forwarded-Encrypted: i=1; AJvYcCXSkRHnPDsvCK8tl3Iere6NziP8rc+Xj9k7XfIw5TUGTE0CpPJxR8PsNKEx2+Vt5AMosM9lri+4TiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNuAi42h9gS+bFi8eiB/A0URMfPbyWL6U4H+bwF4QJvsWhcRYu
	Z5Fp3QaVwumxKvAzyorH7LmTuMsb4QUSC4DsiXW7I5y1SJcC1+AmlVUROwfQZw==
X-Google-Smtp-Source: AGHT+IHR7LHF6bAJTfqfdMdT6vSoZ1qZIMt2KdNyCPNQiI/13HtKv9OHU9ir/QulbNCGPSOqD5aPSg==
X-Received: by 2002:a05:620a:24d3:b0:7b1:547d:9ba8 with SMTP id af79cd13be357-7b331d8c12fmr867466785a.21.1731170170256;
        Sat, 09 Nov 2024 08:36:10 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac63da6sm272249685a.58.2024.11.09.08.36.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Nov 2024 08:36:08 -0800 (PST)
Message-ID: <f89f2fee-35d9-4292-b2eb-b4bceda78030@broadcom.com>
Date: Sat, 9 Nov 2024 08:36:06 -0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] mmc: pwrseq_simple: Handle !RESET_CONTROLLER properly
To: Stefan Wahren <wahrenst@gmx.net>, Philipp Zabel <p.zabel@pengutronix.de>,
 Ulf Hansson <ulf.hansson@linaro.org>, Marco Felsch
 <m.felsch@pengutronix.de>,
 Catalin Popescu <catalin.popescu@leica-geosystems.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241108130647.8281-1-wahrenst@gmx.net>
Content-Language: en-US
From: Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <20241108130647.8281-1-wahrenst@gmx.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/8/2024 5:06 AM, Stefan Wahren wrote:
> The recent introduction of reset control in pwrseq_simple introduced
> a regression for platforms without RESET_CONTROLLER support, because
> devm_reset_control_get_optional_shared() would return NULL and make all
> resets no-ops. Instead of enforcing this dependency, rely on this behavior
> to determine reset support. As a benefit we can get the rid of the
> use_reset flag.
> 
> Fixes: 73bf4b7381f7 ("mmc: pwrseq_simple: add support for one reset control")
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian

