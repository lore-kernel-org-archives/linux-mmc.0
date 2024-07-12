Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03087143747
	for <linux-mmc@vger.kernel.org>; Fri, 12 Jul 2024 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720775408; cv=none; b=eyyuBOD91pG7dxiAxYBZZAjk1XTlfy8Ie0JRwsfUk7D5HVR7/Kv1bpvX0ZN7zcRInrA8JZgzBPYjU90IO8NibvHVcNa1hRnvmfnYQwT3j/zRgFtZmhFjJdX55hqI6FrG3NV/v8FcMqhpueHxnw0N7BiLqqp4lKnpmtUtRgwIa8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720775408; c=relaxed/simple;
	bh=92ARlhMrFxnltJoEG/KO+vFy4IkhU7sCILYUeEcc59U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/Mq/oXtVNW6I12GTURZH04R60Ndw3CynS1oaiP/q/ynjBLLw747ly5Xc5BhiTJmLgdmiFCbd9HeCwOxTJhVgONz2kYVhhoGyKap3+Dle2uGVcAc5Q+LApLNMnXDiq/e8bvJCnBeMXpVWjJcz2fbNt9OGEk08ANtQr5zscfO2YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZDRxxwMq; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDRxxwMq"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e03a63ec15eso1728305276.1
        for <linux-mmc@vger.kernel.org>; Fri, 12 Jul 2024 02:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720775405; x=1721380205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Hp1jgtDDKp2yfm23SCirsWH2DTom7+EqUMqjaOQMl8s=;
        b=ZDRxxwMqJmoRDPLP7dH9E9jpMk71/QoGUf2ECb4jZj+4pF1t2GBGJe3l3SwyhQ67o2
         mAjgDHFokj3v17519JNJfbq25ilBq132jODpr4ugCWjG0kTqYzy1a3Arv0vNXCWwCYfc
         nbZaBXiSi4VoM5TWrwC3xEu17WbHp3MP8kqjT02qE3Unr68NIw9tWW5/bESHB4qpmxyw
         2wc77vtErItuPHKN0SSkFumtBGBk4EA5tj8C6yJ4zWO+7bvWr7vZjCBseydCwHjbrlvW
         u7OI+bm2EoDR/j2n8UJlL43owxfROht9K74qxQ7pOdHdAdKUq7e99w/zlS4RYsdCiGgp
         Hl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720775405; x=1721380205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hp1jgtDDKp2yfm23SCirsWH2DTom7+EqUMqjaOQMl8s=;
        b=pXAIlPIw8Au6JZbM7WV6cXMBK3saPC4h5YMRCLrH0q5h4hWTUcy6Flu4Kg/SE5NLP9
         2usGk60y1IoFF3oAeaArx4RVyYGbPFZ7Pjzd58zgdmcxrC0Cskr0oJMu3RblWE9JmLOK
         7oC5PBl6P500pBxVCHB3aUCwa58TmWr08yH1VPz5Rf4i8yXkaMBwp9iqi+O4Ol1KUYJM
         h6avalwL1BdepCh3uW89V8o7eombStltP2XDHL5P25gPCtAc5eihNMlhRgCWj9QAvygz
         +sEP4x7fYKn/lar4vNBlkqdge+0WsHPy/DOxB+bYLIchV7mhAv/IM/ZnQW20745KuKs+
         gwxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3tyND3hxN+U6fEdipgQ2qPTcDXH+/XjBPQEz3mBqEynWhfTEj8kFgVt1K1xf0vkyX4bbt8+ZBN/FK9PDw+cneSfrZL9UguFLN
X-Gm-Message-State: AOJu0YyFUKUBrDBw5FyrmzHzt3oN0Tu3A3w+n8kzo2NKBgr7JwCNUD+B
	eCpr9C+L26QYHQwLtjRr5/3Wg5Et91J5PPfVYnILlmcbe9b10f8Dka4c+jMZT7vG9LAdINJ6H5G
	EmhOpDpKF2lJexqAHIT8KUHzSjgScEWRmLHQ71BuM4VEbvfK0
X-Google-Smtp-Source: AGHT+IEhhN868PqjoOtPt4/HXGxzNPUJJGslyFKUXQCrTsbztUttPEoG4X/T5cjLdpglfCj2+mvP6vMuVbajMoDBAHo=
X-Received: by 2002:a5b:1cd:0:b0:e03:5895:31b8 with SMTP id
 3f1490d57ef6-e041b059200mr12504526276.26.1720775404920; Fri, 12 Jul 2024
 02:10:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
In-Reply-To: <20240708121018.246476-1-ciprianmarian.costea@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 12 Jul 2024 11:09:28 +0200
Message-ID: <CAPDyKFoWdRdi-NZbtj4yXeBxiH9o1+J0uux+Aiaw8AQbUGpM5A@mail.gmail.com>
Subject: Re: [PATCH 0/3] address S32G2/S32G3 SoC based boards particularities
To: Ciprian Costea <ciprianmarian.costea@oss.nxp.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mmc@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, s32@nxp.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 8 Jul 2024 at 14:10, Ciprian Costea
<ciprianmarian.costea@oss.nxp.com> wrote:
>
> This patchset addresses S32G2/S32G3 SoC based boards
> uSDHC controller particularities such as:
> - GPIO card detect wake mechanism is not available
>
> It also fixes a clocking usage issue on 'clk_get_rate',
> in case of 'per' clock.
>
> Changes in v2:
>  - Dropped option to not change pinctrl during PM.
> Instead, when S32G2/S32G3 uSDHC pinctrl entries will be
> upstream'ed, 'sleep' pinctrl will not be defined.
>
> Ciprian Costea (3):
>   mmc: sdhci-esdhc-imx: disable card detect wake for S32G based
>     platforms
>   mmc: sdhci-esdhc-imx: obtain the 'per' clock rate after its enablement
>   MAINTAINERS: add 's32@nxp.com' as relevant mailing list for
>     'sdhci-esdhc-imx' driver
>
>  MAINTAINERS                        |  1 +
>  drivers/mmc/host/sdhci-esdhc-imx.c | 16 +++++++++++++---
>  2 files changed, 14 insertions(+), 3 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
