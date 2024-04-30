Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F18F49
	for <linux-mmc@vger.kernel.org>; Tue, 30 Apr 2024 01:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714440437; cv=none; b=rx7trAQ5C3P7Ugp7lWAgQpKR05iVcotJXyrldRhc6HGTKqnv4kDZKVhjYnH8WByrUN/4MTIDYvlVuOSzx358HSheAfBuDNsXSvQByTelfHZHvZWg1QMxAZ9MTCEa1UjlsoGwXxUxOo8qqjwRtMay1fWNato8z7W2bwyLFmCluKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714440437; c=relaxed/simple;
	bh=4aAZSnm2s2NBl3SVc8x7goe8wtzimDSqyHoOul6Ypmc=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Shp5zBty2zF8pvj7qIB/DLS4mQEpjcc50R4wL3wTZCvnMpdkmwZB/h6mKQv++Qzwmpw1/WecrMrzUDhLOnitGUzBYGVnYCz1/D8IFAe9nR/YEVQlwMaXC6svE/om+7Y5q+uz1k5DVaGJsYnKX05GH5OQ4bXQ5+W2SlsaPuX4+Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=B3H1B4v7; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="B3H1B4v7"
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714440432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVbET5PIn8Rgn08e108WJ+SjALJbECrcvPz0i6KsyBI=;
	b=B3H1B4v7CKFRgzUpek/5yPzxAGRw/bWyWEhwakEjCrzIVYggaJwDrUBNsv5QjVBlLOf6wM
	17DECuYDBDlaTjla8LZwgjDR2zbNB1P4Um/5WzWlMcHNxq1LvmgWtXq35yvLwMzaaCluDB
	sRjnfg4BH0dz9Lnqct6QzaKO+aAHJmKXwKAyR8EpCQGHK1v0xs6zE3jFOuok1jB1AfGK+a
	PTmppkaN2Grp3UiMxdbYr8t/AUmbP0XZir+ZlESevIhbAD4Q1TYREgFtX1xJ96bBJ+6V1Q
	OsRrHW+wqw/AJJwXJHUctc1fgp3axxTnYhC8f+V1ZRxgAox/UGzF2LPHG7NAHw==
Date: Tue, 30 Apr 2024 03:27:12 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Felix Qin <xiaokeqinhealth@126.com>
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH v3 1/1] mmc: core: increase the timeout period of the
 ACMD41 command.
In-Reply-To: <20240429071955.163282-1-xiaokeqinhealth@126.com>
References: <20240429071955.163282-1-xiaokeqinhealth@126.com>
Message-ID: <3c362697ad716c7526c4caad8d3fb7a8@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Felix,

On 2024-04-29 09:19, Felix Qin wrote:
> Extensive testing has shown that some specific SD cards require an
> increased command timeout to be successfully initialized.
> 
> More info:
> Platform: Rockchip SoC + DW Multimedia host Controller
> SD card: Xvv microSD CMH34A17TMA12 (Made in Korea)
> Note: The SD card is custom-made by the customer in collaboration
> with the wafer foundry.
> 
> Signed-off-by: Felix Qin <xiaokeqinhealth@126.com>

After going through the associated discussion [1] and after
reviewing the associated preparatory patch, [2] this patch is
surely looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

[1] 
https://lore.kernel.org/linux-mmc/CAPDyKFqdA8yisf6tY4gJ-ejk5azTUOZOkZhySYjeHJKibVraLg@mail.gmail.com/
[2] 
https://lore.kernel.org/all/20240425133034.79599-1-ulf.hansson@linaro.org/

> ---
> v2: Add more info
> v3: Based on the __mmc_poll_for_busy API for modification
> ---
>  drivers/mmc/core/sd_ops.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/sd_ops.c b/drivers/mmc/core/sd_ops.c
> index 3ce1ff336826..a1c028303ba7 100644
> --- a/drivers/mmc/core/sd_ops.c
> +++ b/drivers/mmc/core/sd_ops.c
> @@ -19,8 +19,13 @@
>  #include "sd_ops.h"
>  #include "mmc_ops.h"
> 
> +/*
> + * Extensive testing has shown that some specific SD cards
> + * require an increased command timeout to be successfully
> + * initialized.
> + */
>  #define SD_APP_OP_COND_PERIOD_US	(10 * 1000) /* 10ms */
> -#define SD_APP_OP_COND_TIMEOUT_MS	1000 /* 1s */
> +#define SD_APP_OP_COND_TIMEOUT_MS	2000 /* 2s */
> 
>  struct sd_app_op_cond_busy_data {
>  	struct mmc_host *host;
