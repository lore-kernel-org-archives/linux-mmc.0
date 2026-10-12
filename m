Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4B346F4BB
	for <linux-mmc@vger.kernel.org>; Mon, 12 Oct 2026 09:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797020; cv=none; b=jZiNA1cHwnEPaorfzNL7Yr78DbBlCme3Q/Ld4kiWgYcrEvrIXwBOVeVejoHEiNzcjCxLKdBuGT6xwjeuap8DMj+Dz/TYz8dOsCrgqN+H6MMMIAPQHskmJQgQeptangeSEPnl37bSabimosPm9OmZN9IuDk6Zi1teLKWU4jmcLS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797020; c=relaxed/simple;
	bh=nHzUwHePOxq2aoo85Lh6q2Qyb0zVMyTUscHVEyJRWUE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=K2YNvCiE5v/SNwDhSrcJic5Cae8+2pe7OFyLBMq3mi36NXastjHVUy95GgC3x+Ej81zhdTV9jijQB2Q6LTFCWwxBto5c+RZniz1BqRV2yXwIq35n+18pbkn2q3UIRu/WHYQHR9bIDyQWn3YqyJhMcMgO0q/xE7/NM80Sr3/N+oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iv8u8IJq; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iv8u8IJq"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a19cba5c14so9532115e9.3
        for <linux-mmc@vger.kernel.org>; Mon, 12 Oct 2026 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791797016; x=1792401816; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHs5QmsAznY6JYFFT0GfFNt0MOtPZ8zk+n24R7ETBWM=;
        b=iv8u8IJqF1vobad+EkHp32mlRF3wQ82LRZUH71f/9sfsudbnWnnhFua5PoUloi2D5w
         eWjJnXP/yxLkTW6fZPJHrAKxfpPyIwc6ytWAWJ6wfCVWl3MKHsa/Huvp0IRkNRIV0cla
         +5zDNc4VMVGXCANMAbx3ovWU1BFBqyzTR+rBdHKEfQM4ZmMLtvwybY3XA7v/xKXMKmxN
         SXZzs4Pl8pC5xFQNUgqD6bmmDVbcxEI1g2UKLJFfa59tY+XxwohSk8yFP7auSqxEE1ia
         HQOJYl9qHSxbFcLBBUJa9E4xO0v71D8AS83OL4bvS4nvqvtrDRobKMC0h5brUGxoyizK
         Fzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791797016; x=1792401816;
        h=content-transfer-encoding:content-type:in-reply-to:organization
         :autocrypt:content-language:references:cc:to:subject:reply-to:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FHs5QmsAznY6JYFFT0GfFNt0MOtPZ8zk+n24R7ETBWM=;
        b=tm1RGtMFV8gHZ6KELwZnAjNCMBQWjeGc7Pp7tOUE11qvqaIzfKd/12obS/au2Wro8G
         QsjQtwsVExVvTvUK0Lujws6arP7zJEVdl5lSSkWcotAycJMXbRGWaujvhdXOzXOD6gKo
         f6jnHFlvvAaxdOEwP0llYMToZhhtyl77ZTP3hazUE176D7rC+VLv5d2mnobliOlHy2eJ
         erwb+kP4lwOipSW0+LaRnGU4wkKUu1SMClY62Ot6htF+xHBoBA8aw8d4yubPzS0gQDAp
         Lg4b8oFNSXY06K21AJyVI+aWHDu1PtToLx8ia4FiZ4+bnviB79nmkzm0cEDRVjhQBB+V
         9Qfg==
X-Forwarded-Encrypted: i=1; AKwUvByYHuMg6NEL6ra1zCh9EqJpTdxHJilGRIAZPwynRARCZaDPvgkxWdFV95TbluRE/utt6dioCA53XyQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJF/tyzr/keTdaGeICE4UHkaFnussMgQBYoxHBgwW+/aRJGw/uS
	PRaCpPr5qHP4fTHgAMLneBQyoeG2zET/jFJw2/mWdMcIQO73gJPNP365rj2f0ozeUus=
X-Gm-Gg: AYBFou3iLDwlt5wN5I+Hf0u7XZSZS69rvydYa47p7zrv3K4RYJO6OEFC3kM5naBhGAs
	KWENkdZ3tk3Uv4IFDNmHqwVZqi+GbMc9GOdyA5tLEjK2ucKINkBlag3rtDX8MGHj11SxQ6Xrlf/
	KWrdboqBceWaB104o/74hLGyQPNJ5hz+68qadfNWCV+4Zvsh5RsLnFUS9Z6wxL9SHvc1mZBB7TB
	jiNg4L3JLYH7NYHkas98UD+6Tk4bBEcpnqNbh7pWezZFXlzQ8va+PCFHJlmojauBJ2m5kXHM5v4
	Hv3bqNOLnSAfxgSCU+DCxY6kM/w/hbLvZrsFEILMVdaaLla5hXSOIqMYJrvfIwt/KaMIR+qdxPl
	XrypDNuANKClSQYaloFBVVmZRCmZVNYCJetJ6YOwhdiPsgvkscRjXiVREm6JcCPxaltwySqGQE9
	3hMIAhMyA3P3711ddYPFHAKcekGxW1lNT8uIBMo1l+kSd/BCB7/w4nhG4FgjQv/stXBE+TDn3iR
	Atb0nrNQYT0F3nFIBmYKEB0wCqKPGAbaBrH/r+dvDk8Xu5NHIw=
X-Received: by 2002:a05:600c:3e8d:b0:4a1:7701:f863 with SMTP id 5b1f17b1804b1-4a18e4aeae4mr156670605e9.15.1791797016157;
        Mon, 12 Oct 2026 02:23:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:417e:f4c4:5b8:8c48? ([2a01:e0a:106d:1080:417e:f4c4:5b8:8c48])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bb68abfsm304568075e9.0.2026.10.12.02.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2026 02:23:35 -0700 (PDT)
Message-ID: <27d5c013-9346-4159-aded-12ed8ce4e951@linaro.org>
Date: Mon, 12 Oct 2026 11:23:34 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v3 0/4] mmc: meson-gx: honour the busy timeout for R1b
 commands
To: iav@iav.lv, Ulf Hansson <ulfh@kernel.org>
Cc: Kevin Hilman <khilman@baylibre.com>, Jerome Brunet
 <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261009-meson-gx-busy-timeout-v3-0-67d0db3a8328@iav.lv>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20261009-meson-gx-busy-timeout-v3-0-67d0db3a8328@iav.lv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/9/26 19:02, Igor Velkov via B4 Relay wrote:
> For a command without data the driver programs a fixed 1024 ms into the
> CMD_CFG timeout field and does not tell the core how long the controller
> can wait for busy. Erase and cache flush then fail with -110 on eMMC.
> Patch 3 fixes card_busy, which reported a busy card free; patch 4 makes
> the core rely on it.
> 
> Tested on ODROID-N2+ (S922X), 256 GB eMMC, btrfs root with discard=async,
> Armbian builds in docker as load. Without the series (7.3-rc6): 262
> errors in 3 h and 68 in 2.5 h in two runs; the first came 4 and 43 min
> into the build. With v1 (7.3-rc6): 0 in 16 h, 2.4 h of it under the
> build. With v3: 0 in a 37 min kernel build and in a 20 GiB write +
> fstrim; a sanitize went out as R1 and the core polled DAT0 for 523 ms
> until the card was back in TRAN. On 7.1 with the previous eMMC module
> a synthetic test (20 GiB write + fstrim) gave 48 errors without the
> patches, 0 and 0 with them.
> 
> ODROID-N2 (S922X), 128 GB Kingston eMMC, 20 GiB write + fstrim:
> without the series an erase hit the 1024 ms limit and failed with -110
> in 3 of 3 runs. With v3, in 3 such runs and a fill of the card to 85 %
> with rm + fstrim, 5 erases took over 1024 ms, up to 1219 ms, and
> completed; 0 errors.
> 
> ODROID-HC4, SD card in SDR104 at 1.8 V: 0 errors in 5 boots.
> 
> The timeout is rounded up to a power of two: the field holds powers of
> two only, and the timeout is a lower bound. MMC_CAP_WAIT_WHILE_BUSY is
> not set: I have not checked that the controller waits for busy on every
> R1b command, HS400 switches included.
> 
> ---
> Changes in v3:
> - Clamp cmd->busy_timeout to the range of the field before rounding it
>    up to a power of two: the rounding of a value above 2^31 overflowed
>    unsigned int (Sashiko).
> - New patch 3: card_busy reports busy from DAT0 alone. It required
>    DAT0..3 all low and reported a busy card free (Sashiko).
> - Link to v2: https://lore.kernel.org/r/20261008-meson-gx-busy-timeout-v2-0-8bde1adfb5b4@iav.lv
> 
> Changes in v2:
> - Split into three patches, as Neil asked: name the limit of the
>    timeout field, program the R1b timeout from cmd->busy_timeout, report
>    max_busy_timeout.
> - Link to v1: https://lore.kernel.org/r/20261008-meson-gx-busy-timeout-v1-1-d92f3c68c409@iav.lv
> 
> ---
> Igor Velkov (4):
>        mmc: meson-gx: name the limit of the CMD_CFG timeout field
>        mmc: meson-gx: honour the busy timeout for R1b commands
>        mmc: meson-gx: report busy from DAT0 alone
>        mmc: meson-gx: report the longest busy wait the controller can do
> 
>   drivers/mmc/host/meson-gx-mmc.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> ---
> base-commit: fd9af27f6c2319713bb23832066585f8a59a1771
> change-id: 20261005-meson-gx-busy-timeout-7e8e3fdcb3e3
> 
> Best regards,

This looks much better!

For me it looks all good, so:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
