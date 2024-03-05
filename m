Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98DC59B5E
	for <linux-mmc@vger.kernel.org>; Tue,  5 Mar 2024 12:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640910; cv=none; b=JG8zh7f64jw1vnuFaWMxbIg9UTWaqGeOeRe89iF+xkwnkE+RtMLwIgurXEDSE2li92F5+R0VCzF95P7qrgP1ayYhZfPqCv71M62eN0AmWj91N/YBVAFwPn1PRzaRUHScd3xqhldR3h1/+7OZdwQv66sd/LJfZprkul9K5/HNUxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640910; c=relaxed/simple;
	bh=RCaP4GDWT87Zd9IUZzQQpBKEXe+s1x2lF2pIn4GuNXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PFGQtyY7w4r3MrTpLmt/60BZZc1xnxUdLF9P3TMJRmv6CIhpi25okg+J46IbsjjgmCtlWonzn9KYvbqtbpnt7YDTRWEmC+PwrrDg4it83Hgv0Tqf/o8+9r509Q77Cst+kFuwakL79PYGKcKG/itRfduDoiARiZSApZNMy2UPmq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UlXlibw3; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UlXlibw3"
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso573332276.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 Mar 2024 04:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709640908; x=1710245708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZVW/PXVs5nzy5Gr+BEyjbP8Shu9TAluG0kZZRSGaf1s=;
        b=UlXlibw3caQYA57kMfjNtfV6yf5J+oylhS9K4ZXt73FtLQhoSMTyKVWUDyiZYM9FlO
         EpBnaNdd20YdCCHFYLDfAnnK92S9dPpJ2Y9GVPA05wQI9IcIc2O1F8zGjuqEbuf3blQA
         Xj9Fvt86ML6cxLIoamGCj1otdU1z5qe1RbQvrj8ausuGUyRf1TBAKvzTjczJAhCmix1s
         qTtYnakLOvJnfliFe+S++misrWDWyrDGTwvbUAKHi7KiM62Jz34pKCbGwLnoWqAzuB2h
         cHAWIhmJRSiprowLH6F341m3oIAjgIg4nZXuKHrW/AA6Caed9MyL3loyZrer3w39SvHg
         fi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709640908; x=1710245708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVW/PXVs5nzy5Gr+BEyjbP8Shu9TAluG0kZZRSGaf1s=;
        b=RHPWfTvOD6LXTylIUAzj+T2iPGCMXKFJGovt4r2nD86TbQYl92jvGK/k2O0W7HQihF
         fSMVXzsMuQ01/MAKOq3FztLz4/GU6i/r2fqaMEV/lCev2CXzh4I4nPiNVRCs2EO+l2fX
         0lrQVT1s3oUGnu3mlq2MHN61ZkwN6xGXvMsJPGRqVvxtdFdCFVY1xUIF8JM+AyNSlBjQ
         65R68ouRm9EmZ0K4Vd82WZ2RIw7RH1LLlq0f2CU0BGD69HaRjfadeZmWWaD75kzu3LmW
         FptFO4As2RmvV/3yERUqmwFH0BGDWeUU/VThVVyQRkemGtLHteCjj0ZyRURsBWLKB50o
         8ycA==
X-Forwarded-Encrypted: i=1; AJvYcCWMI2ktTVd7vOZnpxtFjdrXGp4W1aX2VdhSXpcfVDOY50w1L83qWugt4tL1/jb3Gtyagp5RPR+t8wjgFlSmvf+B702sNtnofTKJ
X-Gm-Message-State: AOJu0Yyi3yza24SE2socVYRGlwgvn5Sga1p915WSN+GY/huGOsX4FH9G
	0UqTMaDTAlzFlwicVAZ1oLRA81isFX8INFYDT2h1JVGT2Lvgzu9AwPEjVDTt+j5EvbHhEDtpVU8
	cBibN1y8bjos2YFqKslInvuTqrVY82Z+SgqjA5Q==
X-Google-Smtp-Source: AGHT+IE2Y4cAajm9+l0CPilDWB96P4S9WhAwezHUZMdrZBUawlG/ZjtdnYQewd1l4phaxcPiQSTerAEAXTI4XU4tz+w=
X-Received: by 2002:a25:660c:0:b0:dd0:c2a:26f9 with SMTP id
 a12-20020a25660c000000b00dd00c2a26f9mr6859439ybc.27.1709640907662; Tue, 05
 Mar 2024 04:15:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305104423.3177-2-wsa+renesas@sang-engineering.com>
In-Reply-To: <20240305104423.3177-2-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 5 Mar 2024 13:14:31 +0100
Message-ID: <CAPDyKFryGhRju5CohRipXk9E_G3kob2g8=VztjtPBZ_i6D9Ugw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: tmio: avoid concurrent runs of mmc_request_done()
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, 
	stable@vger.kernel.org, Chris Ball <cjb@laptop.org>, 
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 5 Mar 2024 at 11:44, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> With the to-be-fixed commit, the reset_work handler cleared 'host->mrq'
> outside of the spinlock protected critical section. That leaves a small
> race window during execution of 'tmio_mmc_reset()' where the done_work
> handler could grab a pointer to the now invalid 'host->mrq'. Both would
> use it to call mmc_request_done() causing problems (see link below).
>
> However, 'host->mrq' cannot simply be cleared earlier inside the
> critical section. That would allow new mrqs to come in asynchronously
> while the actual reset of the controller still needs to be done. So,
> like 'tmio_mmc_set_ios()', an ERR_PTR is used to prevent new mrqs from
> coming in but still avoiding concurrency between work handlers.
>
> Reported-by: Dirk Behme <dirk.behme@de.bosch.com>
> Closes: https://lore.kernel.org/all/20240220061356.3001761-1-dirk.behme@de.bosch.com/
> Fixes: df3ef2d3c92c ("mmc: protect the tmio_mmc driver against a theoretical race")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Reviewed-by: Dirk Behme <dirk.behme@de.bosch.com>
> Cc: stable@vger.kernel.org # 3.0+

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>
> Change since v1/RFT: added Dirk's tags and stable tag
>
> @Ulf: this is nasty, subtle stuff. Would be awesome to have it in 6.8
> already!
>
>  drivers/mmc/host/tmio_mmc_core.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
> index be7f18fd4836..c253d176db69 100644
> --- a/drivers/mmc/host/tmio_mmc_core.c
> +++ b/drivers/mmc/host/tmio_mmc_core.c
> @@ -259,6 +259,8 @@ static void tmio_mmc_reset_work(struct work_struct *work)
>         else
>                 mrq->cmd->error = -ETIMEDOUT;
>
> +       /* No new calls yet, but disallow concurrent tmio_mmc_done_work() */
> +       host->mrq = ERR_PTR(-EBUSY);
>         host->cmd = NULL;
>         host->data = NULL;
>
> --
> 2.43.0
>
