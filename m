Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485B13A1D14
	for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773674160; cv=pass; b=OZXM58x0g4sNyL/mTc5FVlfPDU977MQsfSOKfnReRDY49Ypw+nvofbyB0PlqwgPY6HhgLKa3DVE+xF/aeq4ntiMZ7g8Yu5hTWosE+QQZzVA74DHb0M/Ru/spBhtOSbxERz2iil7dPMZwxNEv8SDMXD9JPo6O62unFiQEv37mD18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773674160; c=relaxed/simple;
	bh=tlbBAU2x6jiKpjqtYKusaJnoykXmh9IJaWw/fuzG+5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBOhiQXihRy4JYLmJHKhI/IWjuzP6xbgP1h7HnpDssThgC0Cs6wygo7DyPPRk0sYojwRkqxduCSX7CeNtmhE7dQyTXTw/owTmFxaXW3wI++xEKS2Co2R7eFndE47NIOP2bcUvcHQ0v3PldjQi6TSsItLgLadHCn39SvM+vGsgmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ArQChw3j; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ArQChw3j"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a1307438ddso4692232e87.1
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2026 08:15:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773674156; cv=none;
        d=google.com; s=arc-20240605;
        b=f3m+BTorSVf1GcnpX7YpUHn3YharZH1BaT9LjETrnredmXF7VnLohCoWG7ZQRmQYsv
         N4fH3KOvd3NhK9J580fqIwHo0Gwp2HHgwYpbFYdd4RRzXIf2DkY2o4AGxq5kwaJo1Uje
         kAIl2lHEbw96O3Wc0AF0qsIkH4xIS5hLb/D/UU+cgSz9kXBMOteilYKGuMt/GN7x8wAQ
         QTTXgpwv61zleKEFjWcNMwdqCoJddEDsd3fjYThEGbcsdZeXCEaH0iZEAPM2T/8Nqp4r
         iD6MkrYil4GtR4KFFwiVlr4Nx6G6kyPZ2YosySDFvuV53FiDdgTNkQz4qKwaBaUwGvWQ
         ITsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/+FbqSYTir9YBMeFUKx06b7z4pIcCSnNdQI0qzzp0T8=;
        fh=3yEk/uZ+QB9N/Dx3MqreW9In3SUu24aH0SQz+wQec/g=;
        b=hubexDWBP8L5h/+Lo9jIlZMthY2WojU1tzicUtEeOoWJm3/ZYvojWFI7qNqvCqQgZe
         cDPb8w550BjuxUuBBmrNYv4NYdRPvpYEksHBbXxYv6+MuoMTsmByzwRxXXw1bQtO+7Et
         MFAP36rGNvqgM1PJ4JVhcn5cGOtJM4Ea/S0lwS411IecnJ58yvuHZqmRg2LhYkYBbcWP
         mecksWTwyKsgcACyP2+3muoKpVCybfzuEMLntUfbiQP9FlZbSxi7GjAbDD/M++3bmdFS
         0PytokHAOpbZbRoti1IO0BeZ9P/XIFmsXuYX5A6G+Xed6q5bFoh+vlnOPXmz461TRSfP
         XtCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773674156; x=1774278956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/+FbqSYTir9YBMeFUKx06b7z4pIcCSnNdQI0qzzp0T8=;
        b=ArQChw3jSqlJUYXJDshZ2Pk9A3bSQ6bMpuMiH4HzcdPtQWlMu0G1oK6nqcBI9DE9u8
         /LRXbnYBPIBuV7c0wrKlOcgI992DEnbD634e0J/JwHO+pni0BRKaw1ANvUmiZI3tIUko
         DnDb7jcFcP0XRGbyGFo61ZiqC4OXAf1NimY/nsthElHsUP0jW8vqHznPAGR/RL7hBmp8
         EgbjvB5t4Goh1Bs/RgHGAKQ2UaWvrlVGrbguGStRH1jOI5hYseKvQbH1JXPXmo59Q59k
         iHhAoJiMnaUVDjWdL9ZahbP1TKcigb74pf0dVGfMOmWHkSDdjUNe6TsaTQOQP6lxGbkj
         5yZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773674156; x=1774278956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+FbqSYTir9YBMeFUKx06b7z4pIcCSnNdQI0qzzp0T8=;
        b=pfGs7VDcMfrT7eW7u5Wa/fMxnHYwj+eWycNENQZIyBrXYvbM13Xa7xJ4d1SY91Nt0o
         B29uIv8+Tm5D/Xt7DiEzv6oLqa33yI73dpTV3bdPmsARQbR6s8ooh8O/sGqOVhn2VWli
         m9pDis6sr4GbEplxRuORwv9Ks3wfShaYvI1s7KxkHXVbrCuuLr3lkai4MmjFdWTnCXqI
         uDyHLfNTKIsqXZ4ALb4gLZQldJQmPt9tlLFo++3DPMpYSBim1X+9zH1Dth79iSgg4Z4z
         fy+s8draRtgj2faPAl9BOh8bYx3esU6+6SKF4F8bVN+uw6QWuc32R1LJKHYUxiS3bC2M
         tWog==
X-Gm-Message-State: AOJu0YxWFWlkJzNjwpkUrYm12cH1FCPQTyi1/DgxTs5o8F1Y3Vzd+F9c
	4kSSMtZ2yxlftAo10FSm/yvCZ6h9ig6OnN4Tblmmu4OtREWPwo0lWAfcPyoo71oWKPUOKf8P+zE
	KyE51NgO4/IH5qZ4V7DXrrBgSm75IG3ebsW8YM8Po6VUlrpl+9v7EDHg=
X-Gm-Gg: ATEYQzwWk3OTA9A0D01jSGI3gSTH8L3s4FFs8IMFe6aAVCHV0ARoM/8C4aCSsxIpE84
	swCIL4l6n646e+dYK9oIuvqscSPyK7muuHaCmLx00UcPZ+8vffFJtoH8tjbSlxNh2HP7Ee9xN0Z
	OjgW41WcGiOAP89p9o8WTFU7uO5ihw3YR+9U9e0eelrHzQeNnx9r9rwgzhr5B/uo7Tnw2IIFjtR
	mrJLBVs2bX3Dem9PA6p6FntgdMXJ6A3VTIfwAKsJoVpxCzpGqWF6DRfQYAlq643JP9NJpOsXIQF
	m3DtfxzQ
X-Received: by 2002:ac2:515e:0:b0:5a1:39dd:e85c with SMTP id
 2adb3069b0e04-5a162b0a2f9mr3333239e87.24.1773674156262; Mon, 16 Mar 2026
 08:15:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310013553.29332-1-shawn.lin@linux.dev>
In-Reply-To: <20260310013553.29332-1-shawn.lin@linux.dev>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 16 Mar 2026 16:15:20 +0100
X-Gm-Features: AaiRm5164HrxYnwGOPCM8LTvkAFHKdLqm0jySbj65uTcjvkpn6YBj7i7s6bnbao
Message-ID: <CAPDyKFosfUB6YyYYWmUY9wfxg9JNW2+7g5N5c31i42-foKg8wA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Validate and clean up UHS/DDR/HS200 timing checks
To: Shawn Lin <shawn.lin@linux.dev>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shawn Lin <shawn.lin@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 02:36, Shawn Lin <shawn.lin@linux.dev> wrote:
>
> From: Shawn Lin <shawn.lin@rock-chips.com>
>
>
> This series adds validation for UHS/DDR/HS200 timing modes when the host
> only supports 1-bit bus width which also fixes a real performance drop issue
> due to incorrect hs200 mode switch code. And then cleans up the check in
> mmc_host_can_uhs().
>
>
> Changes in v2:
> - updating the temporary variables in the middle and update host's caps(2)
>   in the final. (Ulf)
>
> Luke Wang (1):
>   mmc: core: Validate UHS/DDR/HS200 timing selection for 1-bit bus width
>
> Shawn Lin (1):
>   mmc: core: Remove checking MMC_CAP_4_BIT_DATA from mmc_host_can_uhs()
>
>  drivers/mmc/core/host.c | 14 +++++++++++++-
>  drivers/mmc/core/host.h |  6 +-----
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> --
> 2.7.4
>

The series applied for next, thanks!

Kind regards
Uffe
