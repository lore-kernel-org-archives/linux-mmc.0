Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146113B14BB
	for <linux-mmc@vger.kernel.org>; Fri,  4 Sep 2026 07:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788508598; cv=none; b=X8NCuypAXGpwQeMATMi3IdXxiB05qGGa4aQ8z8gi50KIVoNYd342pe7AiL7JXd5h1U8TBVmtFaura4AB2Op6sgqoMHPYXWsHd8KSVIQqudZZ8RCGx3vWKidvdVnjfjaxJae6r9zWgYa3TZxjUVFG9XGJzFATXOKK+cL7wF+1XHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788508598; c=relaxed/simple;
	bh=OCuEAwsPo6LAGIuWYwcbqhhesjnLgIEo8HDpHcn3pe4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rHcUClBUjyrhkYDay2COt5HtSVGjqFba0eElNdRCAzD3BYl20Fvo8xXH72KXlqLYcyqo9aPCb9wS+m+K8GZP3dEV369wxfxCUMdPGs/JKPwJu/N/fJj3sngXHjQxQgZQXIiIAnRO6aYWp+2dIzByqxtwPceWm13PQ8N85JVc2gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=I46e16s/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="I46e16s/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-49b96837ca3so4592705e9.3
        for <linux-mmc@vger.kernel.org>; Fri, 04 Sep 2026 00:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788508593; x=1789113393; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XJ1UH6hAE4wf/eMnhUQvleFgKZgGdJ6vWxvyx+MhAOw=;
        b=I46e16s/lJPPo/AOimII5N/KE0XA6zmndbyha3mmX3GZhSRffL+Dbb5F+4i6Cp7qNz
         WE3x4L3zvCvbQK1pYH5OFJSrAVguAcZD5wT6F79+RFUpftFbhV1SxFflBrU+02tpv4Vi
         rW7XUGltMowYXAbYWn8EXSlp51PfFTrkwXvz7UsdNEgv94TJtTBKi4DjpbgUWTG27tBl
         4lLagagOBzD/weoh00ggTZ403in733n0WizzCe8vOFtUYGWlpQsdDSXDsoFQO30FHIaY
         JOEec6ww5767bXf8uyRG0hysUil0Oc/bHDP45qxcj9uEPrdB9TY5hc7vDdNK1HHn/Vc7
         DxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788508593; x=1789113393;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XJ1UH6hAE4wf/eMnhUQvleFgKZgGdJ6vWxvyx+MhAOw=;
        b=SWof7GPxGExHTy/DaNDHle030gvEzPcsdn4tWlToU0d3pCpnNsccdtZMYh3pcrHXcA
         pX5AKia57tEFcjQecJMw5euGa979TwYO60izDIjxOR++791lOWODrLvg/hegrZe6xTGL
         qCXt5OmRu6pP1vn7cPLdhFy+SBbVHa/CGCRps24/gGcN/TaX2PKNBhuxv0zRgo3NZV46
         B7O4K+VdPTtV6aOHJZrfXpDOr3UrNUHnAaoxe0fx8cUSGJdrAA8l6IGgUe94W56xEkC9
         /GolUMnoNgZvZegNJIBaM4S5juUFjaR53jyGZQIEKTAfSkdtnb1m4YV+UrIAqZGkGKh8
         3ggw==
X-Forwarded-Encrypted: i=1; AKwUvBw0BlT39weZOBq+dvyEZwySSiabMojeia+HFVtsPQe0vCPu7uBMdYxdfUq4QE6eeX/RttK0zXMQK6w=@vger.kernel.org
X-Gm-Message-State: AFuF++kxsQDuG/XVyxnHoLB6qin3Hi/p+/INFfyvimMr26cUM/IlN4q4
	ncTIw/eLKsAxOne44aToEnQZ1rzm5cGugU29QJAC6GerPDrZhtg4R+H29QADIuoriJk=
X-Gm-Gg: AYBFou0hcB8QbNw0B1QIUyXCgY4S4SO3cU/LVFy8RBWR0ctyZeTINyNsphD3/AvhSm+
	QBQwyLSXGwvSn6O26fm1xE/G7g02qTbzFt3tjytWISanlop+e7YEDIDFXolrb6SkQex99PzTAEN
	yrbnax57d7hxtRhMJItfwxJPypluVC7hlspsZVIyPAoM/WAw/5ivm83rhD4f5Hd3bQcTrCEmMwT
	QS302oEalHSOhbmPeMDMBKgHb3YsAzcnsTr52Q1lNbMbguPR8Jy4mmlO1XGcCpy249e+a3SQBng
	leUAPxM+z30Y3cewpujamjLH/EkFh1TgSrB+obLuIrkc8+kVEoj3x9z9wy7F7PoPY0CQMcXSLw1
	bSJ6+VKEDA9CGQTGtxYAfOfSCnGJo4/eM6X80rEXXn4ZbZ5XEsxNQDzywPqJMxwOL5Th5UPSsN5
	Xcmz244lAhDD6VCnRNTQQxyPu7Otkm99VZqiLhkqY0AW5dm/avDlXPqgB/3qmEKXvzFTtebu0Ou
	jGfU2sMUpQbG2mjaA==
X-Received: by 2002:a05:600c:1c29:b0:49c:fc6c:be03 with SMTP id 5b1f17b1804b1-49cfc6cc06cmr15228165e9.26.1788508593241;
        Fri, 04 Sep 2026 00:56:33 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfd3f8192sm10480125e9.3.2026.09.04.00.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:56:32 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Lucas Tanure <tanure@linux.com>, Ulf Hansson <ulfh@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Stephen Boyd <sboyd@kernel.org>
Cc: Brian Masney <bmasney+clk@redhat.com>, Chuan Liu
 <chuan.liu@amlogic.com>, Jian Hu <jian.hu@amlogic.com>, Ronald Claveau
 <linux-kernel-dev@aliel.fr>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] clk: meson: t7: don't mark sys_ampipe_nand as critical
In-Reply-To: <20260903225921.2290441-5-tanure@linux.com>
References: <20260903225921.2290441-1-tanure@linux.com>
 <20260903225921.2290441-5-tanure@linux.com>
Date: Fri, 04 Sep 2026 09:56:31 +0200
Message-ID: <1jpkytlaa8.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On jeu. 03 sept. 2026 at 23:59, Lucas Tanure <tanure@linux.com> wrote:

> sys_ampipe_nand clocks the pipeline stage inserted in the bus path
> between the SD/eMMC controllers and the NIC_MATRIX fabric. It does have
> identifiable consumers - the three MMC controllers - so marking it
> critical was the wrong tool: the clock should be referenced from the
> consumer nodes and claimed by the mmc driver instead.
>
> Drop the CLK_IS_CRITICAL flag and update the comment accordingly.
> sys_am2axi0..2 remain critical as they clock the AXI DMA bus itself and
> have no single identifiable consumer.
>
> This depends on the MMC controllers actually referencing the clock:
> the dt-bindings, mmc driver and t7 DTS changes adding the "pipeline"
> clock must land before this one, otherwise the boot hangs and memory
> corruption this clock caused are reintroduced.

This information typically goes bellow the '---' because we will not
keep it for posterity. Please resend when your dependencies have been satisfied. 

>
> Fixes: 43e1705ecab9 ("clk: meson: t7: keep the memory fabric clocks running")

Thinking of it, we probably do not want stable to pick this up since
your other change are improvements that will no be backported. You can
drop the Fixes

> Assisted-by: Claude Fable 5 <noreply@anthropic.com>

The Assisted-by should not have an email, especially a no reply one.
check https://docs.kernel.org/process/coding-assistants.html

> Signed-off-by: Lucas Tanure <tanure@linux.com>
> ---
>  drivers/clk/meson/t7-peripherals.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/clk/meson/t7-peripherals.c b/drivers/clk/meson/t7-peripherals.c
> index 55d09e78593b..2f429ea86796 100644
> --- a/drivers/clk/meson/t7-peripherals.c
> +++ b/drivers/clk/meson/t7-peripherals.c
> @@ -945,13 +945,13 @@ static T7_SYS_PCLK(sys_aucpu,		SYS_CLK_EN0_REG0, 14,	0);
>  static T7_SYS_PCLK(sys_cec,		SYS_CLK_EN0_REG0, 16,	0);
>  static T7_SYS_PCLK(sys_gdc,		SYS_CLK_EN0_REG0, 17,	0);
>  static T7_SYS_PCLK(sys_deswarp,		SYS_CLK_EN0_REG0, 18,	0);
> +static T7_SYS_PCLK(sys_ampipe_nand,	SYS_CLK_EN0_REG0, 19,	0);
> +static T7_SYS_PCLK(sys_ampipe_eth,	SYS_CLK_EN0_REG0, 20,	0);
>  /*
> - * NOTE: sys_ampipe_nand and sys_am2axi0..2 provide the clock to the AXI bus
> - * used for DMA between the peripherals and the DRAM. After the clocks are
> - * disabled, a device that starts a transfer cannot complete it.
> + * NOTE: sys_am2axi0..2 provide the clock to the AXI bus used for DMA between
> + * the peripherals and the DRAM. After the clocks are disabled, a device that
> + * starts a transfer cannot complete it.
>   */
> -static T7_SYS_PCLK(sys_ampipe_nand,	SYS_CLK_EN0_REG0, 19,	CLK_IS_CRITICAL);
> -static T7_SYS_PCLK(sys_ampipe_eth,	SYS_CLK_EN0_REG0, 20,	0);
>  static T7_SYS_PCLK(sys_am2axi0,		SYS_CLK_EN0_REG0, 21,	CLK_IS_CRITICAL);
>  static T7_SYS_PCLK(sys_am2axi1,		SYS_CLK_EN0_REG0, 22,	CLK_IS_CRITICAL);
>  static T7_SYS_PCLK(sys_am2axi2,		SYS_CLK_EN0_REG0, 23,	CLK_IS_CRITICAL);
> -- 
> 2.55.0
>

-- 
Jerome
