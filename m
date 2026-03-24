Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF43DDDD1
	for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774345111; cv=pass; b=rzrWAHgpR2LcuprKpZTWFCve/f486l2nGBgLRuQWCh8UjM7hwMex5K1xAYlgI1MnMD6HyC+ppAu+g1BsDPSpWyCqhSR89s5+vuW5bud83UU4UmaoRaHvvB1AqFCXTv8z8DVyF6UOKt2jd4EBcvDPizryVcrhIe0VzhbG34mFlWU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774345111; c=relaxed/simple;
	bh=3Q0KzI00K144CqDTO+0RAb/kjbKqPjwYNPdpwhqd4oo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMsouKUaulF/tTinASsEl9zZjjEYw8y9yEvuScIOWqqxvBNUoTTTrKngRIDkCa7cnlfII2lIRuUx6Q9U3S2b/sI+QRnAy6vsn4jepka3u+AHJcPhaGX7KQ9mmb7OlJxgHUhIojOOLjZ6Izkj++Eu77XYpBOZ1JqUkcEuE+tn4y4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o1JKTDhH; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o1JKTDhH"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-794719afcd4so44341517b3.1
        for <linux-mmc@vger.kernel.org>; Tue, 24 Mar 2026 02:38:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774345108; cv=none;
        d=google.com; s=arc-20240605;
        b=N20+/yLS3hTrd3VnE39K0ZitGouWpVuvq+6U2htCh9KUKmyXeNlm1iekgcgXPBE4xk
         Ow6XqZgSChrgJdOIoy+D7F0kAqHOSp2CCGoay9lm6AFZwA0J8G+PxauYnWnXvnv+O5M8
         nGBy3SVrjvTEtLCHC9ZzEm5nkFiSJULwKqyF3XKTrHShhxOKphmWsg0uzZ8+28qMBA5l
         Dgh4fD7eEtNF/4irmCf5vat0mQqsym3fmoB1vLV04sA1z21oOp8GmKDteZ8fTthaCr1G
         qEK7fX9hyO3tBliGY+Z2GhF1PZQP5d9An8V1MJnlq06lDHFMVaD9z+0NIzxnWTBjpVev
         sD/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=3Q0KzI00K144CqDTO+0RAb/kjbKqPjwYNPdpwhqd4oo=;
        fh=9ugX1BYTWRrCGieCRsVX+3eu72mozXqfwwZl7rO+yBg=;
        b=Q9sXgoykePtea1l9Y0iUnEbPMvPsKXXcuShUkC2wbZxTh23Gp3VJ+YBnuaowccSvAT
         4YaR+GNkN8vl1D0LRHzbyDQHu/HK1OK0SQoU14TEYOcNV+lOmoZYf8aUztir8t9NjlEe
         9h1DxKwWKcJwD5i/poBd7xu4mvSXdLKoYRL34HLyb2swHTO1+1AP+BjymJgjo+lvV70h
         d0TWFHoeMopky9tAi/CBmlg7rk8QNTcAazaSgqruehCTLkSsZWHNmlhvUpAEJ9+J4Bwb
         7rRgjSTW6u0QagRFIdSGJG6legJ4dP4vd7Yye/WXb1j014NpB8PeH5cJ+EImpTasSCWL
         ZPEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774345108; x=1774949908; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q0KzI00K144CqDTO+0RAb/kjbKqPjwYNPdpwhqd4oo=;
        b=o1JKTDhHPtN7tL07wm4vrn29NRTuK3kYVbh/VIbK+qOOpHmgGRnExEtbPbpqXwHkiX
         ug54uDXc54IRxaGvhPRGNb+NtRSq8rUrJOLhFJo6UW+lSs7T6NYIudT0zpq5eKMlibd6
         i4EDUfyWyz+USg/Jat3zif1iuM9rWzhwjQ6m9wQHIz54R/dAnKFVoXxUnFsFGV/eOTnY
         e0jn9eMEgGofImmbWoI8D3PMPxR2fjDosX2A8L7QaSizYoBaM8zwV8H0wh+aADfQXS4X
         nsPIYnamXDfEtPlwnK690R0Wj2OZmf4NZX6xcVnTCdxgMjz83YL5if/0gqnF96ckb9qO
         84Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774345108; x=1774949908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Q0KzI00K144CqDTO+0RAb/kjbKqPjwYNPdpwhqd4oo=;
        b=WxVWSlZtwhgpr9w1H20qm1dXxnIsi1SkxiMugvL08WqLr6MvRtyHpEpuDkSXg9pi+6
         7orA4tejq4BEzJVgFGqbYkEiTUuG9ApW6j/yTrPhtIbKqfGWi7MN18mAvWYF4onj+gJi
         t/fI9X8DpRkHDgiCRoLBtpjfaFCDH8hS/BhadddtAxER5o3rQ4SbimxbJMQsAs53Ycli
         BhYFv9bUcNuvLaWJ8Z4yXTYjVcX8UsIyUV0CZpsnjfPgz8oy0OaAZUds5hi2nu8DJpeC
         0KCLSfKSShDr59pGWGH3dkd4y5OSUHLN5yMmzlyU5/ekMeqGhtKRJLoHhLTvwxZST52n
         2WpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeeXibhttSB6DpAvXkwtdZ7E8ddECXnUEPxkPlHGabLgHCMRuKYGBnBghB3PKizhYhD5OUPGggcAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYtr3JWmoE94pl020HMNjVNwYK80QayR4U5Rqa9e5KLoHllI5t
	MO7TyPUgq984M67mO6ZtQBv6yDQ8KiKi7NT/2n30f00lQHHi0ULMf/dWVpo1Beeb5SEpuLJgkMu
	exO8erq0rYIK7z/mQUBSLMi9BfkgfpcDQCUnHYvQZbA==
X-Gm-Gg: ATEYQzzWUDE2hLlqlHvpuxMI9RxEoTrmCnfywIz1fcvQsARDrCryCH/8UDj/vmZKPSx
	o1YOQLVr2kzThUPzPOseOHI0Xaoz/n70G6WeV93nSX9yMlpvEmMOifbfXSnn3yXBwx8i2tdKpkw
	uYOs3dje6SkqSMbpDU15NP1va1iPKwji3lSLJNs0ajDA1v9jWKfqRzcj3ETLGCWG0N6jnYLx6MR
	MqMRIv65VlLcdaSOjZ/94T7OuGmpkAKVh1A4USRT5hHEUJZBlOWuEciPL2c00LJdlLCBnHpLeJt
	i8tcqs5G/1n8eDAt+y1/cIurwOXdUNdKnEg+6+9z
X-Received: by 2002:a05:690c:7644:b0:798:83e4:277f with SMTP id
 00721157ae682-79a90b351ebmr138576757b3.27.1774345107831; Tue, 24 Mar 2026
 02:38:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323194400.22886-1-rougueprince47@gmail.com>
In-Reply-To: <20260323194400.22886-1-rougueprince47@gmail.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Tue, 24 Mar 2026 17:38:16 +0800
X-Gm-Features: AaiRm51UGtrLd6_TOxXtMshZQx1vDpI_Zl-99r1LkNoHkpUs8Cc0m2THVB2Qi1k
Message-ID: <CABQgh9HV-DcChd1WLFAUGmZoVQ++Kekxr5gj7SU0zhqttqn_Jw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mmc: hisilicon: Convert dw-mshc bindings and fix dtbs
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	xuwei5@hisilicon.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, 
	daniel.baluta@nxp.com, simona.toaca@nxp.com, d-gole@ti.com, m-chawdhry@ti.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Mar 2026 at 03:44, Bhargav Joshi <rougueprince47@gmail.com> wrote:
>
> This series converts the Hisilicon dw-mshc text bindings to DT schema
> format and cleans up legacy node names in Hisilicon board files.
>
> While testing the new YAML schema, dtbs_check flagged the hi3660,
> hi3670, and hi6220 SoC files for using the non-standard 'dwmmc' node
> name prefix. resulting in warnings.
>
> Patch 1 Convert to DT schema
> Patch 2 updates the Hisilicon dtsi files to use standard 'mmc'
> node name.
>
> Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>

Thanks Bhargav

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
