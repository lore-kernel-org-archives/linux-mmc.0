Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22C9127E18
	for <linux-mmc@vger.kernel.org>; Tue, 30 Apr 2024 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469232; cv=none; b=Out1vw+CxsANdSkgA43rYbbZPC3s8X8q96fXTWo9TWQ9hZEU+5Oa9UB8odiok0oGDCsRlsi/Y6gpo9m2l4qCTPIJmBij77h2TswhMSQShZspwHx0VW/Zluahn9LuOBJzTEcjf+Y1bNiiNe1EtLV2xkJrv74On7NlQnSdXajsbFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469232; c=relaxed/simple;
	bh=xAjHBhW5G9x0pVHnYlKzO2XdfWKpzJvrtWMvXKHGP44=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=aWIDZK+g3UkN41HA6N88bRzOtlvwLF3yfawq6Pvw0eQ6bO/HV39Hv5gKpYJ3pTV6lzI/A2/f5CC6EuDeI4G+lqkYowkeeNsgqQ9InsdnVNrHe+him9erepvpeYFaZ8J5P4vkbbu31ck7ywvx70Hhb1eVPg7SflZLtwytFKyM2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=eRF+cqcD; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="eRF+cqcD"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d4d80d00so6880628e87.0
        for <linux-mmc@vger.kernel.org>; Tue, 30 Apr 2024 02:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1714469229; x=1715074029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HisHiVQGKfq5Qf2qSm14t1Am2lK9Nhtd7sYyAIDnp7s=;
        b=eRF+cqcD/74yq/aDqDIvUqdRTVzm78B7pff+7+c5K9eLTh6dyK87EZ6tCvTfdQQy8o
         9bbh+k7G13aYxs9W8o0U571aODJWXVgVdoL/v6NpFx1xyGRS9CneZukGFtv6r2/MFjmt
         LFvsqSClcYX44j3zmORqDzKwTfL5dpZGGbaZrjkvmaPPcKW7I0JE+nzJbVCFBVSqlNU3
         lwTDxY1OX8SZLq8QPDSWvFi6Ww+DsvBpsL5kuhlbsH6zYSJlwVVm+8hOIbaflx7TFnJw
         bo19XPEPQjivHEPbfvkMwiBjJaB4OGvC8q74xXWOxDn6Y7C+adM/dEReDWIz/eB/c8cs
         KWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714469229; x=1715074029;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HisHiVQGKfq5Qf2qSm14t1Am2lK9Nhtd7sYyAIDnp7s=;
        b=B0G8SLLp6l1wOJqQ+Edu0Maa7cp9BVvpPPNIbfthRHaCrUBj5ghJRHEXxjwss5anr3
         T7Tqj1xET4npjQLoOZAs2U3VEmv9aDbtRluzG9l19p/mjFHMR5j81lKLkxTzji9T4kQf
         hG+pIhYB2uOflD6UqYm94wgSbFisHlHq2R6ZpeFrBqGd8HdSQmrnwp2rzHleP4sTLIVd
         Hk9Zb4D/DJhRYxDn9EjoL6ocsjXOwfZ9wwXs8pHbtq02rIeSJNZ/Db0dCE3wxpgVtM9C
         uCXYuCKQWA7tx+4a4xlRzeNqRjdu8BcgHNYt4V2e0wABuqc9hlVzr5IY5vT+FTf+n/7Z
         rMVA==
X-Forwarded-Encrypted: i=1; AJvYcCUjvp2G6/g3iE1H919HxFaLyHnC7T+gkb5FixleZ0giultec9mJg+Vneyq9HqbgvEedRqzJMuTqr1ll/TChmXhKukFG4UOxDL8t
X-Gm-Message-State: AOJu0YyI0XDTFs3i6vQ5oDxHFJvNT3oJsww+qQNWgOkPPg+Naoe6D6kn
	bb8CFPQa04sGAvIkAZhBvYIoj2ivhe0pGF/ti+O+er1GrItXIt+AdYJy5csXq/pNEzbfD1EUqgD
	rJLk=
X-Google-Smtp-Source: AGHT+IF4mXAeWBqtm2dKYVvycB6lOTk+pmfqmDMR+Chfi6wfJeprlJ9UpCscbn4gZdES6ULMXWrEBg==
X-Received: by 2002:ac2:58d8:0:b0:51d:1239:21e8 with SMTP id u24-20020ac258d8000000b0051d123921e8mr5818763lfo.37.1714469228919;
        Tue, 30 Apr 2024 02:27:08 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id y22-20020a0565123f1600b0051b64136e0esm2818510lfa.52.2024.04.30.02.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 02:27:08 -0700 (PDT)
Message-ID: <6f1ed4ca-617e-4618-a868-44de47aa3974@tuxon.dev>
Date: Tue, 30 Apr 2024 12:27:05 +0300
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: renesas_sdhi: Set the SDBUF after reset
Content-Language: en-US
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, ulf.hansson@linaro.org,
 linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Hien Huynh <hien.huynh.px@renesas.com>
References: <20240410135416.2139173-1-claudiu.beznea.uj@bp.renesas.com>
 <h2fhduxr5bv3m7vkxl2ga6pqkkv5mlzpwgk2q6lfsnz3l63ckk@pyzj2vt4jkfw>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <h2fhduxr5bv3m7vkxl2ga6pqkkv5mlzpwgk2q6lfsnz3l63ckk@pyzj2vt4jkfw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Wolfram,

On 30.04.2024 12:10, Wolfram Sang wrote:
> Hi Claudiu,
> 
> On Wed, Apr 10, 2024 at 04:54:16PM +0300, Claudiu Beznea wrote:
>> For development purpose, renesas_sdhi_probe() could be called w/
>> dma_ops = NULL to force the usage of PIO mode. In this case the
>> renesas_sdhi_enable_dma() will not be called before transferring data.
>>
>> If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable()
>> call from renesas_sdhi_probe() will configure SDBUF by calling the
>> renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
>> tmio_mmc_host_probe() when calling tmio_mmc_reset() though host->reset().
>> If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.
>>
>> To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
>> renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
>> removed from renesas_sdhi_clk_enable() as the host->reset() is optional.
> 
> So, I tried to find a place where we would need only one call to
> renesas_sdhi_sdbuf_width() but I also couldn't find a sweet spot. So,
> this approach seems also best to me.
> 
>> +
>> +			/*
>> +			 * In case the controller works in PIO mode the SDBUF
>> +			 * needs to be set as its reset value is zero.
>> +			 */
> 
> But I think we can shorten the above comment to something like:
> 
> 			/* Ensure default value for this driver */
>> +			renesas_sdhi_sdbuf_width(host, 16);
> 
> D'accord?

Ok! I'm going to prepare a new version to change the comment.

Thank you,
Claudiu Beznea

> 
> Happy hacking,
> 
>    Wolfram
> 
