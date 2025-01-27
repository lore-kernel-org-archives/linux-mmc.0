Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BEE13B5AE
	for <linux-mmc@vger.kernel.org>; Mon, 27 Jan 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737990975; cv=none; b=H6PfeDdsBQ9GI07z6RltWQOXoNfIl0R4oEuYyPauV5psHrRe48i+Mh/674/puVU6pMeID2PKHPnlOyZr/YskU4lnPvWpay3pe0BLC1adAl2FueB11b4pX7A77Rhcjh+Fh/phKZskgz/qDHckpXYig3L6Ud40OuhI84IOIEj9eaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737990975; c=relaxed/simple;
	bh=uGfClbJNYW3WlXwU/kbZPJMDflOSclIXAFXm1sTN3xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kLvhywtfa0xFrpsPyDFt9s9fLgDBvT1gdH104kBO57xYLtW29pVA7UFt4cYktypQwH0DVMVBEKGQbxWlHe7uwaAEE3Pse9zrFwIZgBm6P8LMhIm1arn81Cy/RvPwWMrJZY0/2hocaqRNb5+Iq3I0BwVT36HrSXjUis2jeDcS9e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P249/K6n; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P249/K6n"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so6860033276.3
        for <linux-mmc@vger.kernel.org>; Mon, 27 Jan 2025 07:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737990972; x=1738595772; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z3fdf68cKnEaIGamBbArQHWaVBKPqUrbMqE+m1JNXYk=;
        b=P249/K6n+pRZlUb3RP47FXUAiuvAYDnyTJ7eo6HO99aHQ8RO+lAxmT+hps3b3tMjKr
         HhJDZRtWu5jtGzfclCyWYCdbd4bszyXHLc6azDkMFdVxtdj375IOz2sx8wzBvruict8l
         FtsLx8m8/j7CB7tta0vO8EzAO5lMive22ng4Ru2wjhua1+Q5hdACb2KNTfKFs1Ba4kMk
         XEPVMh/OMGacEnyXv6z9Wu5W5L/puFemRbssuXZzkaS0mgYM3A8JyZDHsYmmWak174+V
         t8bxBtX8iy3fXMCZrOCHqz5JwH3YtwoNkqUZ+816ykY/Jxzj/qSwN+zqvkcg/I3Lt/Bz
         Hx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737990972; x=1738595772;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z3fdf68cKnEaIGamBbArQHWaVBKPqUrbMqE+m1JNXYk=;
        b=A2Q4HrfGSJfnazf7FfXhMLSU4hnoPo9BCQ98zypj4n18VALqUiewNdupOhf0kUmryT
         /c40zsGRfZGsOMZLFnxqHewzETia9NGxAWu3Fin4fRQ4m04KToHXh6dNMBov3ov6DCR0
         yzFP8AA1oiS9c/yIc5MUBB5KFRcSOBHExZOoKKRefFgoaac5AbjfWFyTk8VboUCJbeKv
         53QnvZLTQrEQg7hb/WK2gDTiHm4lmrzxMK8BTbTO6s+me2sxEexQ8NsIt5Fe3IFnCeyi
         SbS4nvyYx7R+Ej9TQSkgq0E3nwYs7zlpa9nROChwMBDHz9brNdfectcSfZOI3Qgr1/Yf
         DBPA==
X-Forwarded-Encrypted: i=1; AJvYcCXEMjqzCMZ3i/U2yQ6rQVZlnxBzrzSgrISDL/opV4lt29fkJZCPr1yO7T0lDBiVJl5yzRB5kOJLKDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQyLWbgO2ZZAocxQK5YPcTwPMZMAG6N8R0sJlgo+U0XwDPTZL1
	J0crSsABUekn+DNhyDFAHjpF3kjOY9FOr5s6ncd9+DesX5ZFQs51wPX3FyO23j0W1oKTgvENu6+
	g4Vs4BFWNoat51ESG8i/OLjwj/fOoTValWnC5gw==
X-Gm-Gg: ASbGnctluMptZ0wsdVjM4aueEbH0nV1zdTkj/Dywd9T49FvrQGul3MGwJvDzvueoC73
	q7p9lal9RSk936wpiEYe2rgo0HLN91AX/+OcCl2vSitEpIlRNyz7zVACFlaX+CCQ=
X-Google-Smtp-Source: AGHT+IE7Vja9677she6CObvFAbVBiI5Ys+p+eByoUyFiITh4qV3MJatrF8vKcAYHzhv31KbUMJyT51BBZJ0PLRNDtTM=
X-Received: by 2002:a05:6902:150c:b0:e57:88a0:3ca with SMTP id
 3f1490d57ef6-e57b1344ac2mr27218044276.40.1737990972298; Mon, 27 Jan 2025
 07:16:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250120184728.18325-1-ansuelsmth@gmail.com> <20250120184728.18325-2-ansuelsmth@gmail.com>
 <20250121-zippy-umber-fossa-abbfb0@krzk-bin> <679770d8.7b0a0220.b6f23.38b4@mx.google.com>
In-Reply-To: <679770d8.7b0a0220.b6f23.38b4@mx.google.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 27 Jan 2025 16:15:36 +0100
X-Gm-Features: AWEUYZnk9Xh1b_Hveu4tndN_oObnjQYSeVJzcpRRCX5DJCyFhAmHsJWAlWuduBA
Message-ID: <CAPDyKFoEDbSfQA3xPCUPsJCOdiDVdAjB1Fno=S7yrqJXSqnfXA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: mtk-sd: add support for AN7581 MMC Host
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Chaotian Jing <chaotian.jing@mediatek.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wenbin Mei <wenbin.mei@mediatek.com>, linux-mmc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	upstream@airoha.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jan 2025 at 12:41, Christian Marangi <ansuelsmth@gmail.com> wrote:
>
> On Tue, Jan 21, 2025 at 08:59:19AM +0100, Krzysztof Kozlowski wrote:
> > On Mon, Jan 20, 2025 at 07:47:02PM +0100, Christian Marangi wrote:
> > > -                   pinctrl_select_state(host->pinctrl, host->pins_uhs);
> > > +                   /* Skip setting uhs pins if not supported */
> > > +                   if (host->pins_uhs)
> > > +                           pinctrl_select_state(host->pinctrl, host->pins_uhs);
> > >             } else {
> > >                     dev_pm_clear_wake_irq(host->dev);
> > >             }
> > > @@ -2816,9 +2835,12 @@ static int msdc_of_clock_parse(struct platform_device *pdev,
> > >     if (IS_ERR(host->src_clk))
> > >             return PTR_ERR(host->src_clk);
> > >
> > > -   host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > > -   if (IS_ERR(host->h_clk))
> > > -           return PTR_ERR(host->h_clk);
> > > +   /* AN7581 SoC doesn't have hclk */
> > > +   if (!device_is_compatible(&pdev->dev, "airoha,an7581-mmc")) {
> >
> > Please avoid coding compatible in multiple places. Not only because
> > above check is slow comparing to check on integer, but it just scales
> > poorly and leads to less readable further code. Use driver data with
> > model name or flags/quirks bitmask.
> >
>
> I implemented this in a more compatible way so we don't need an
> additional compatible anymore. Soo this series is not needed anymore.
>
> Should I flag these as not applicable anywhere in the patchwork systems?

No need to, just send new versions.

Kind regards
Uffe
