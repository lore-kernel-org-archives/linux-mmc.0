Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F35258CD7
	for <linux-mmc@vger.kernel.org>; Mon,  9 Jun 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749475618; cv=none; b=LjEePeRJBO9Mw7mP6WWZGSgzdeOqoUWrD0Q2coufO2orIs81B5IwGWU3CjimOZ1xOgHT22nTGXf2XabH+nUM6zJE2dTaCOf3CG/ltCrXOggI/2QuCQL7uDlmhDTdGh9Ln8jyXalTJcMz8ly/4/2NH9el+MF4dAB1B3UXiHSPKDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749475618; c=relaxed/simple;
	bh=KsFwIrR3yyZx5H44934iQzkL8sKWbowPXtwXD39xdts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0XqtH3/jZAlEGUaZKFXsmxmYY3sfeXMlUh0rTJJhbWyVZLO+UwPq1QoMpHWRJnzvxIe57IAwXc5OXIuuBCBkvgxKr2/XES0GQxCf11k0L6oEj2QXbslUtGNlh12V775Sz2xhvzOueqfAFI5qJP7n7O/+x/Z1+NbYLdBfFeGL+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ze1kJeQt; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ze1kJeQt"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e819aa98db9so2227560276.3
        for <linux-mmc@vger.kernel.org>; Mon, 09 Jun 2025 06:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749475615; x=1750080415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mAiRbciuoiorHgM5EFNBfKf1XaHXDRt4R+Ad1zIscbE=;
        b=ze1kJeQt659RsJQI+FVZ9v6fkijd+LulZCFVO+7hsyQ6EJakqjoyJZvKC2RlIhXVQB
         Tv8lLBtD/ZCxI4OgL/1gXkSt09/xyhhlM52frik24Tfpffg+sGo8mF2eMbOqpRkkoy1F
         0x08QCncmXDbFBA1hfe5G7CdGl3oCD9QQrG0lBWFt8Wv1oocNK7DSmaR9t5MM5tErk6B
         xOozEC5f8U9BD75Cw5AP5FwhK2PBWio2l01KzEN2/hIjJj77/BvIGrJakAvzfYQQ1AAS
         dYWlYDIUM5kHwYXBvT9c6pjUvf87obpsgTd7hGAz7s0hMXm3qJQZwtiLhPoOX04vmZNv
         8FKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749475615; x=1750080415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mAiRbciuoiorHgM5EFNBfKf1XaHXDRt4R+Ad1zIscbE=;
        b=Oe+9cmY9u6Ca5vJhh7PrnF8athCNWpy/gU8AU9VKVSKX6zdyVE3Ge6WgGYVdhkwqW3
         wtgk3doV0sAaxZEenUZ2xpCLAKMlHrLr0mHNrEWfuuGaBZp1D4O6QqWkNKPh7P4L2fgm
         +7Ql1n5+1efxHQSvnXyIjCy00C2reIyCubEGoeNq4HuGJP55/R5oKDQpVVwVauUpOHsU
         PLhsoefF0qxt159ncDi1wZ9AXcLW335jQ/XYJ2AtKOX4pymmMEKM6tpP0xraVPGA8yMj
         GhrEIOGOGHC3c3nVaeYdFJzTPAcNxcyia+L1Ee/dQUNA32NCDomwKpTmdAYeIV8qJ4/r
         Og1g==
X-Forwarded-Encrypted: i=1; AJvYcCWo009uYI12LSmVDHrOapqbbcN47CBmI3NQvwdkA3mkDpg/DCkw3IK9MCnGNN5tbZKD5duJULJqVoY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzma3Gx0afqPRAJcz5uvf+qsge437WPKOGWW3TTEjX2Li6O4doX
	rzUuQPZFDXZVtz9m8W3HyaaP7445PQqe22Pft3K82HHdpQ3MXdU+ifrPkQ0cbA9EvVcDCSIUYYY
	1j1QneZBkYPM5tvbDvkm4Rc+V8o6zbuCKwXUO73ALTA==
X-Gm-Gg: ASbGncs4N02/49LygUqg1MRQdfp+NNw4VtyY2rTUOYF2nOKZhHkiwKrlUl3PtLUy0CA
	Z+qslW8pHHXJiHF4zNS1B5xKkqtpYDJXd57Fe8GoXLAwVkBui+e1CHu3NchcZ1zcQICx2mbblD5
	glNeX/mZhzZ7qXUAwWnJjZEOrraWTH7nnGo4jVEvBzY65K
X-Google-Smtp-Source: AGHT+IEdp4Uo8DXeT5EnMuQJvMNr8+WtEiGeMqcg+uuVjNdRmH13ttSqp1H/4vx3AbsAuwuDP4cRp1d7FkuP24yL/II=
X-Received: by 2002:a05:6902:98f:b0:e7d:7b06:c567 with SMTP id
 3f1490d57ef6-e81a226a49dmr18772294276.8.1749475615295; Mon, 09 Jun 2025
 06:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250529104853.1987456-1-alvin.paulp@amd.com>
In-Reply-To: <20250529104853.1987456-1-alvin.paulp@amd.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Jun 2025 15:26:19 +0200
X-Gm-Features: AX0GCFsV0kgRqKk0VesGIpH7txHIuNQCBKwAYohUvjNa9Wq16CR9xgCE78X7Q9Y
Message-ID: <CAPDyKFok6Ftr6OAHpy_qL3S17cecHT9f2tKWagCd+KvVFSmAFA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: Add shutdown callback
To: Paul Alvin <alvin.paulp@amd.com>
Cc: michal.simek@amd.com, adrian.hunter@intel.com, git@amd.com, 
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 May 2025 at 12:49, Paul Alvin <alvin.paulp@amd.com> wrote:
>
> Implement shutdown hook to suspend host and disable all mmc clocks to
> increase power saving during shutdown or reboot.

So how long is the shutdown process for the platform? What do we really gain?

In general we don't quite care about power-savings during shutdown, as
we are going to turn off things anyway, right?

Kind regards
Uffe

>
> Signed-off-by: Paul Alvin <alvin.paulp@amd.com>
> ---
>
> Changes in v2:
> - Make use of platform suspend instead of driver suspend as driver
>   suspend will only get defined if PMC_SLEEP is configured which
>   results in build failure if it is not configured.
> - Updated commit description.
>
>  drivers/mmc/host/sdhci-of-arasan.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 8c29676ab662..4abdad3c4e5b 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -2056,6 +2056,11 @@ static void sdhci_arasan_remove(struct platform_device *pdev)
>         clk_disable_unprepare(clk_ahb);
>  }
>
> +static void sdhci_arasan_shutdown(struct platform_device *pdev)
> +{
> +       sdhci_pltfm_suspend(&pdev->dev);
> +}
> +
>  static struct platform_driver sdhci_arasan_driver = {
>         .driver = {
>                 .name = "sdhci-arasan",
> @@ -2065,6 +2070,7 @@ static struct platform_driver sdhci_arasan_driver = {
>         },
>         .probe = sdhci_arasan_probe,
>         .remove = sdhci_arasan_remove,
> +       .shutdown = sdhci_arasan_shutdown,
>  };
>
>  module_platform_driver(sdhci_arasan_driver);
> --
> 2.44.1
>
