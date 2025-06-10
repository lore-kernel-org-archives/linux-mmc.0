Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383D298242
	for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 12:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560244; cv=none; b=ZECpTeoZsPICwmxu4Z9PSWBXtSb4aIxirti7LorgWY6t5CfFyAZjZ7xZ/vHu8J1JhURoi0WiAQWW9AmjDH/qw5Y/0kTCpTA+VOGDX4mFNCkyTITsfU8RUgQC5VlaaBdAUa+LYHUaL45hiu8T4Em57wOBsFlA4pUOu8skzPIn+Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560244; c=relaxed/simple;
	bh=qhIVpEZDZOmir5ypQGJPM5AKAogRaLno5vHtbx9uYco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bm96HV1YrazRhONyXiwTW/HkZxKCRSy+Hr+78RIApTXD+O1YhDEExSchAn8IEw+oFRnwWAc8mqWurjiGPADXyJScG/C7yLoGdX869HfZonsKuDAjQxMBFVRll7a3SAmkeiXTOF52pzKe5A5koo5Rz9n9oPOtUTS/KF804lgPPdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iw+pYu9w; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iw+pYu9w"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ade5ca8bc69so308936666b.0
        for <linux-mmc@vger.kernel.org>; Tue, 10 Jun 2025 05:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749560241; x=1750165041; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CUkJhWRp3L7SGl8YQInLtuEOp8CfW807ly4f8cXAKNg=;
        b=Iw+pYu9wj8TPnjtMho6jQXgdksId+1akOTNdyrRNkjp//ulZJygzb8PR/ptjfENVEI
         qug6n8lx5eEN39bQeDG9LdswoQDdg7oM6tPa84afyw/Zwf58Z+Q10R3ezILP38VgBNfO
         lj/6JHFZTa4kdC0TkJElVfoiBOW8k8tb4UMBiZ3sqPVgh3hjBzsQV8EHramZhcy/pqrF
         ySDl7jug2TIDUOj/25BZqQOoX3A1qbYbhOeEU1NnnEuVlrqlcmJB9WWlIswr/rUtafI7
         bIf7a+zyhni8VvJsMj/V+BVS1ivtdMQFmz7M9z5H5COhbIbZgd57LRx8AdVUS7G+MziH
         W2Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749560241; x=1750165041;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUkJhWRp3L7SGl8YQInLtuEOp8CfW807ly4f8cXAKNg=;
        b=kVzvLFotPdnlBgYI9bAqfooeaCEoUFwC19+R+KBArauc+2vIF5SNeqT9iRHix07TlA
         f2nRG146H7X0BMlc/7tRj8x7ayfrwfFSa6xiPL0E+g+gzy8SsrfAloKNuCurEM+cb2ew
         TByRW/Z95CxzcUnC23NOKH9TvLrbP3POxcFPdVGuPzYlgSTrHpheGhHJ709LAjth162Y
         +3b7KwG0eScSfXnqFM0Q/Hn+6nwJ+Fwl/+aGOsjM5p/WqHOWek+qYRFd2G/wRl9q1orz
         N1Aa+XMqAUTQmLUqwPamQsYAZQbEc0oRJMW3Mmo0Cx26j8415QG+vOeQ8+G2DMhMzx0Y
         +6mA==
X-Forwarded-Encrypted: i=1; AJvYcCUpEFa/YnMp6eYWe7D+nNavWRmGerCUfs9pws3nfkYMiwd4AA/DUCqgP2toD7FaH4P2aOK0YWvhGTU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJnNfLGU6FH3Gu8BmOWMl8zAkfMhKXSoVv8o1RVPOoB+47Nih
	M4VakSvSF7NJsBya6MCEQrKkR7/Mhuom+gU5kQQ4Isy7uJMCQl75AxFjkGxBfy87i9S8bdBKS2Q
	PDGwIwyhA8+DLD16nyHGlSEsy6ztPt1sJPCP24z96mw==
X-Gm-Gg: ASbGnctoNkq+2nWmOzMJBC4CnXH2Qo8GWdPUfsbmDa3Re3wLjTgf1Wouxg2z2Y3rYfB
	JvLgzZVE29Bi+rRcEZEdA9m25+eat3Lux/1gmV+6CjiOq12KDFTGYw06Yt8OdQDttR+VAum9SD0
	d6N/X491eUtUiE0vg1lmkKOCSS40BzoN1cwsZIyGF8f+3W
X-Google-Smtp-Source: AGHT+IFnoTHHifJTlb/W9AH+wSprRlJ6AOhC3m2qBRGlahZc+wsPlXhKLbork72DQJ3HMf/KrBrC0eU+kRMagyP2nkg=
X-Received: by 2002:a17:907:d644:b0:ad8:8689:2cc6 with SMTP id
 a640c23a62f3a-ade1ab2216fmr1457025566b.47.1749560240911; Tue, 10 Jun 2025
 05:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606110121.96314-1-victorshihgli@gmail.com>
In-Reply-To: <20250606110121.96314-1-victorshihgli@gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 10 Jun 2025 14:56:42 +0200
X-Gm-Features: AX0GCFtz58qEc2pH3XdErcJzGd3l9xp3ByR8YdkuPCCJGBGEv9OQcWr7tPHik30
Message-ID: <CAPDyKFrpHvrgjG2xOYPoPwUf1NNyBM+fGaO+AgPpZ1CMZYrqgg@mail.gmail.com>
Subject: Re: [PATCH V3 0/3] Adjust some error messages for SD UHS-II
 initialization process
To: Victor Shih <victorshihgli@gmail.com>
Cc: adrian.hunter@intel.com, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, benchuanggli@gmail.com, 
	ben.chuang@genesyslogic.com.tw, HL.Liu@genesyslogic.com.tw, 
	Greg.tu@genesyslogic.com.tw, Victor Shih <victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"

On Fri, 6 Jun 2025 at 13:01, Victor Shih <victorshihgli@gmail.com> wrote:
>
> From: Victor Shih <victor.shih@genesyslogic.com.tw>
>
> Summary
> =======
> It is normal that errors will occur when using non-UHS-II card to enter
> the UHS-II card initialization process. We should not be producing error
> messages and register dumps. Therefore, switch the error messages to debug
> mode and register dumps to dynamic debug mode.
>
> Patch structure
> ===============
> patch#1:    for core
> patch#2-#3: for sdhci
>
> Changes in v3 (June. 06, 2025)
> * Rebase on latest mmc/next.
> * Patch#2: Separate the helper function in V2 patch#2 into V3 patch#2.
>
> ----------------- original cover letter from v2 -----------------
> Summary
> =======
> It is normal that errors will occur when using non-UHS-II card to enter
> the UHS-II card initialization process. We should not be producing error
> messages and register dumps. Therefore, switch the error messages to debug
> mode and register dumps to dynamic debug mode.
>
> Patch structure
> ===============
> patch#1: for core
> patch#2: for sdhci
>
> Changes in v2 (May. 23, 2025)
> * Rebase on latest mmc/next.
> * Patch#1: Drop the use of DBG macro and use pr_debug() instead.
> * Patch#2: Drop the use of DBG macro in some function
>            and use pr_debug() instead.
>
> ----------------- original cover letter from v1 -----------------
> Summary
> =======
> It is normal that errors will occur when using non-UHS-II card to enter
> the UHS-II card initialization process. We should not be producing error
> messages and register dumps. Therefore, switch the error messages to debug
> mode and register dumps to dynamic debug mode.
>
> Patch structure
> ===============
> patch#1: for core
> patch#2: for sdhci
>
> Changes in v1 (May. 16, 2025)
> * Rebase on latest mmc/next.
> * Patch#1: Adjust some error messages for SD UHS-II cards.
> * Patch#2: Adjust some error messages and register dump for SD UHS-II card
>
> Victor Shih (3):
>   mmc: core: Adjust some error messages for SD UHS-II cards
>   mmc: sdhci: Add a helper function for dump register in dynamic debug
>     mode
>   mmc: sdhci-uhs2: Adjust some error messages and register dump for SD
>     UHS-II card
>
>  drivers/mmc/core/sd_uhs2.c    |  4 ++--
>  drivers/mmc/host/sdhci-uhs2.c | 20 ++++++++++----------
>  drivers/mmc/host/sdhci.h      | 16 ++++++++++++++++
>  3 files changed, 28 insertions(+), 12 deletions(-)
>
> --
> 2.43.0
>

The series applied for next, thanks!

Kind regards
Uffe
