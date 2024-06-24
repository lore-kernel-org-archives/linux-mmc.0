Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB31FAA;
	Mon, 24 Jun 2024 00:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719188945; cv=none; b=c231NFBsR/4O8OcQ/HVJIGCxupHeVJzD/GkcQrCzb1UykxqHpisaEyyZmb4SzIGiEIxd0aHx4hS4vzujrz+O8+4okJ19Z0sPZSO3oz/lFk6s0z3TJPxuwusRy3AnuLw4Rr+spQFOEtFM9dF1zRQ7iPQ4t1aXzOiYv1OpWUbfyJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719188945; c=relaxed/simple;
	bh=kkKIhT1w67xTBMy3jgYr4bWuoVNLfPhZ2j4E9XDkl28=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rKlsdrgRvpnQca3UJ+6rfD+LQ8sj6psx9/gt+Gp2sCBDTal2W/Dfe30njNVUccexp1rc9uUPaVJnr3DkeUV8hxwsaR/Sc+6haxJ3hBqSqaqctjDZrfCma8qD3DpVq05va+99Gy1hKyd44cf1udjnRheAZ36qkxOOr3KZocGSqfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=La7VEkU5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="La7VEkU5"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f64ecb1766so27736095ad.1;
        Sun, 23 Jun 2024 17:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719188943; x=1719793743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oLmnGFODnPObQ8SNLRDoqcDqu7WbjsbbEs2V4iPJ7G8=;
        b=La7VEkU5Phijv7dG4FyyzWwKHE/rHXvaGJtpFj/ZUtIa0juV3IY6gyNZXxPalDjHpw
         H+rNwVJfbSGTsau4xHN0nOBdAzx3Zzq9QBvYIbe9Xtqh0/c4rIPdUewQ5uKStWlVXSUK
         AkKa/bGRw9DNZ9L/12/wDAnZe6ul032OT/jl9KpQfVnam3epxo92wwJrm1gZVtx1uonC
         U9KohtHuxrU+fe3YQrtIJPicfXtqjseRq5wGQifnIkEvm55154QP/LdX18r0otVouL4O
         rdtGMnJsIF355JUk5pVav21R9AOhAzjhHnmwJNncjgiDNacvoy/9L5fUDTv/WNe0M2Fh
         2JXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719188943; x=1719793743;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLmnGFODnPObQ8SNLRDoqcDqu7WbjsbbEs2V4iPJ7G8=;
        b=Oqww8PCaZbdr9AHSnCRNdg04gK3aSEyh4PwlHg4JaD9BEX4kXMwVeUIjZRzNtNXaQi
         rCZJLSBeuSWlOO1xu/Uz7Pc3dYcg7uGZr+Ie33BHfqREmCUKBiyW+nhHWD87ZhCZllJw
         hGMad43l8LDPBKHfdDs1RlRPUzS/KI63rLMe1nxLr9wWQ/XmQYzkGAPzxP8lb23fTECF
         N2KhL55sqb1Wws9Lk/y3aaGV9zqs5Ww8iMw80IG3w4O0cw2tmvhdll36zk3l1HQlsqb8
         t5goTgF44tFHzQ2649FNb9XStbQup50yutOkOjT/ak3uGLux4wTPr0LqWQD8lkk4hl0f
         WUrQ==
X-Forwarded-Encrypted: i=1; AJvYcCW02A0VtNYVB8nO2zgwndwS6cz/86+g2EZzfcjWyQcJll5CWC8QngviT3y9KQjENBFXreak3APwqWVHhHQmQN4xhmwLCCS7PsGMN0HTrf7xW/R3ctxm8yJU7cWxTSohXPpgh8IHqUITpCdQLUft/csZiw310eali1R06UhJtKQp+8l9QQ==
X-Gm-Message-State: AOJu0YytsPy4D3mfMRW5Mb6SbOU2RgNwj6OPJVV8St8BjlHpLuOMgON/
	uN82Y4yWh1QtA6QnlCFGTcRrs9V3QumznBvg3whQAxyFJMx5uaJsVu6neoX2yIc=
X-Google-Smtp-Source: AGHT+IECn2hTtkJjNmvo3hggOFyAa58BXolKo9b0f+I99ahJTLOAAtfdF/uLHCUGuOL9LyZQb8E7Fg==
X-Received: by 2002:a17:902:ce82:b0:1f7:3d0d:4cd with SMTP id d9443c01a7336-1fa1d514687mr45274765ad.24.1719188942752;
        Sun, 23 Jun 2024 17:29:02 -0700 (PDT)
Received: from [172.19.1.51] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb32b9edsm50417225ad.118.2024.06.23.17.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 17:29:02 -0700 (PDT)
Message-ID: <abdb1e63-dde7-47c6-a961-1d1674c4888d@gmail.com>
Date: Mon, 24 Jun 2024 08:28:57 +0800
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Shan-Chun Hung <shanchun1218@gmail.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-of-ma35d1: Add Novoton MA35D1 SDHCI driver
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: ulf.hansson@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, adrian.hunter@intel.com, p.zabel@pengutronix.de,
 pbrobinson@gmail.com, serghox@gmail.com, mcgrof@kernel.org,
 prabhakar.mahadev-lad.rj@bp.renesas.com, forbidden405@outlook.com,
 tmaimon77@gmail.com, linux-arm-kernel@lists.infradead.org,
 linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, ychuang3@nuvoton.com, schung@nuvoton.com
References: <20240619054641.277062-1-shanchun1218@gmail.com>
 <20240619054641.277062-3-shanchun1218@gmail.com>
 <CAHp75VcJGoDaAbD7vWin8yTGarrLZbVQqucHs+M9rAAS0BZd9g@mail.gmail.com>
 <1e249c77-def1-4ffc-bbd6-d64f7e95b0ac@gmail.com>
 <CAHp75VfpPR3Nat2dJrwLaxvnQNmn6KbpAfLcD-BvadwyHXDE1A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAHp75VfpPR3Nat2dJrwLaxvnQNmn6KbpAfLcD-BvadwyHXDE1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andy,

Thanks for you review.

On 2024/6/21 下午 07:25, Andy Shevchenko wrote:
> On Fri, Jun 21, 2024 at 10:06 AM Shan-Chun Hung<shanchun1218@gmail.com>  wrote:
>> On 2024/6/20 上午 03:09, Andy Shevchenko wrote:
>>> On Wed, Jun 19, 2024 at 7:47 AM Shan-Chun Hung<shanchun1218@gmail.com>   wrote:
> ...
>
>>> You are missing a lot of header inclusions, please follow IWYU principle.
>> I am not familiar with IWYU yet, but I will learn it and use it for
>> checks later on.
> "Include What You Use". But some of the headers may be omitted as they
> are guaranteed to be included by others. It's a bit hard because one
> should know and follow the kernel development, currently the headers
> in the kernel are a bit of a mess.
Absolutely, kernel development needs careful attention to many details, 
like managing header file
> ...
>
>>>> +#define BOUNDARY_OK(addr, len) \
>>>> +       ((addr | (SZ_128M - 1)) == ((addr + len - 1) | (SZ_128M - 1)))
>>> Besides sizes.h being missed, this can be done with help of ALIGN()
>>> macro (or alike). So, kill this and use the globally defined macro
>>> inline.
>> I will add sizes.h and directly apply globally defined  ALIGN() macro
>> instead
> Also check what header should be included for that macro, IIRC it's align.h.
I will add add "#include <linux/align.h>"
> ...
>
>>>> +               for (idx = 0; idx < ARRAY_SIZE(restore_data); idx++) {
>>>> +                       if (restore_data[idx].width == 32)
>>> sizeof(u32) ?
>> Your idea is better, I will change it.
> You might probably want to use the same in the restore_data array initialiser.
I will modify it.
>>>> +                               val[idx] = sdhci_readl(host, restore_data[idx].reg);
>>>> +                       else if (restore_data[idx].width == 8)
>>> sizeof(u8) ?
>> I will fix it.
>>>> +                               val[idx] = sdhci_readb(host, restore_data[idx].reg);
>>>> +               }
> ...
>
>>>> +               pltfm_host->clk = devm_clk_get(&pdev->dev, NULL);
>>>> +               if (IS_ERR(pltfm_host->clk)) {
>>>> +                       err = PTR_ERR(pltfm_host->clk);
>>>> +                       dev_err(&pdev->dev, "failed to get clk: %d\n", err);
>>> Use
>>>
>>>     return dev_err_probe(...);
>> I will use dev_err_probe() instead of dev_err()
>>>> +                       goto free_pltfm;
>>> This is wrong. You may not call non-devm before devm ones, otherwise
>>> it makes a room for subtle mistakes on remove-probe or unbind-bind
>>> cycles. Have you tested that?
>> I have tested it, there is no error messages during driver initial process.
>>
>> My thought is that sdhci_pltfm_init() and sdhci_pltfm_free() are used together.
>>
>> If there's any error after the successful execution of sdhci_pltfm_init(),
>> I'll use sdhci_pltfm_free().
>>
>> I am not entirely sure if this answers your question.
> Yes, they are, the problem is that freeing resources happens in
> non-reversed order (for some of the resources). This might lead to
> subtle mistakes as I said above. The rule of thumb is to avoid mixing
> devm_*() with non-devm_*() calls. If you have both, they have to be
> grouped as all devm_*() followed by all non-devm_*().
> In some cases you might need to wrap existing calls to become managed.
> This may be done with the help of devm_add_action_or_reset(). Check
> other drivers which are using that.
I will add devm_add_action_or_reset() to do sdhci_pltfm_free().
>>>> +               }
>>>> +               err = clk_prepare_enable(pltfm_host->clk);
>>>> +               if (err)
>>>> +                       goto free_pltfm;
>>> Use _enabled variant of devm_clk_get() instead.
>> I will use devm_clk_get_optional_enabled() instead.
>>>> +       }
> ...
>
>>>> +free_pltfm:
>>>> +       sdhci_pltfm_free(pdev);
>>> This should go to be correct in ordering.
>> I am not entirely sure if it is similar to the "goto free_pltfm;" issue.
> Yes. It's part of the same issue.
>>>> +       return err;
>>>> +}
>>>> +
>>>> +static int ma35_remove(struct platform_device *pdev)
>>> Use remove_new callback.
>> I will fix it.
>>>> +{
>>>> +       struct sdhci_host *host = platform_get_drvdata(pdev);
>>>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>> +
>>>> +       sdhci_remove_host(host, 0);
>>>> +       clk_disable_unprepare(pltfm_host->clk);
>>>> +       sdhci_pltfm_free(pdev);
>>> At least these two will go away as per probe error path.
>> I will use sdhci_pltfm_remove instead of  the ma35_remove.
> After fixing the ordering issues in ->probe() this might need more
> modifications.
Understood, I will correct these issues as soon as possible.
>>>> +       return 0;
>>>> +}
> --
> With Best Regards,
> Andy Shevchenko

Best Regards,

Shan-Chun

