Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E843CC9F4
	for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 15:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279213; cv=pass; b=K3Ctl505L2z+lHxI6Ua7irM+z4BRJQohHqLiiYF3w8AEBDnuqlXfjJFcImxIXvsjNvX17FPBZtDWcNgKQqG/QxS5CjVeVD3bnSu2hCrLNuuvR/HCfgHGaHMXZ6Sb+ec0M2CDAzHxpY/tpicJqAW5wwOfd3cWWhodhQS7rfA4Wic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279213; c=relaxed/simple;
	bh=wBGo8KkdjmiZTWFyjGly0/KWmmcqAZA8ltGfPALOJN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQHF9uN33D/Gs5OYsLQDS1MkSTlDSih3oMskqNnVZPuP3TceFEd3f0IyuaAAattrsls4n9NCPIsyXIRRSOCP71fRO0Vka35TWf4Odwu8YRjCK+asfPpO4m1J0dxq/d4No/20qXrnIwO07O/oJNFr5sfIZXRMJKT/CgUSFMIODQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L2bGKQ8P; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L2bGKQ8P"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a27dddecb0so6002642e87.2
        for <linux-mmc@vger.kernel.org>; Mon, 23 Mar 2026 08:20:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774279210; cv=none;
        d=google.com; s=arc-20240605;
        b=fEjJRk/99qp9Kn3574zHUZJfpklcRklOmkfFl43XDdoToLvHEJ7guJgFOUTmAANg6Q
         7pSof3jmCDDGq5IpjJaLP97LghorTyy52Lzlna+y2G+LQJ5zHETVeXZsNiS0t6emSLgn
         uoOlt9HyPJHApkRdwT/Z1wDZywqMQNbw9KqBcXUTOvp5v3efiA+wWpWjUTvDskF5n7qB
         k8BQx0Fio5ee3uOTroVz70nBGe77tnm0KuOPWEreZHgC4T3L3wu5Wkl12DSFkxZD/EZQ
         Ex6dQd/bftXq8cS8jT+Vro8ewcf9zuF40bJOmw6pOM3/HNHm7ltrBcbZj8J57GhORAb7
         slBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cuf9deas97ABy9xzbUoTZYnn0tkG6ilPsqWbJW2Wj2E=;
        fh=ZTJ+wcsrNpuQcmrYEKgDg6mFikvFphgjIxthCNMzMeA=;
        b=FQMPV6RwuztpP5djXHIu8XjtjVL4ygwmLI+izzyOTrmTeU7sXhEOaoohoLBMaQ8y1E
         d69u8WLhF7NuutrvQRO3xR6BXPRg42zCk1d8kIBCUv9ErAlRNruBW8sKlQkQBIDbnLPE
         7DADN7S87r+9IKuueh8xmoOne4GF9lS156ugjK52EVrhlGpej4O5FeBmibhc9nSkqyHd
         Gem7dkyxqaKKLsT7b+IO1knytGWalok/TyS6stZwgRKAaObR7a7wC938WQ++z8ElCkFM
         RVZ6TbW++vSP6NOTZJpJjZmORHOPCK/eYBY5J5NBd4qZ3UDJYcz/IsV1x0hh+hHE+oVj
         VOTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774279210; x=1774884010; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cuf9deas97ABy9xzbUoTZYnn0tkG6ilPsqWbJW2Wj2E=;
        b=L2bGKQ8PDKPYnFumWl4PqWORDkYNTRWG7bYtE0voZMKKafIDtCqHaELVRpg4Fc4jcy
         YML3gBiWxvTj3/91Pn7pdDhNULX2bm67SdWp3vSQ2b+YOG/oc5Ex+5sirxpL+0MjevWo
         e/35OJd75Vl9pyGynjRynqEhnPhw0geaorLBmuu8lgg+T6VthUgP1TZwixsvBDhBAWYv
         rXY721NYFxOC3UFhsWJPEdBo+uAeZm2Tqwu/IPkZ4TnNP+u2zcU3Iw9SysHNbxXs+B59
         AkFxtChlmhjcipeQdY/38dP5F72Qoc6KnZNuWng9pgk0dkBe0e4uZ1xuokLnHNEiFLch
         RHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279210; x=1774884010;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuf9deas97ABy9xzbUoTZYnn0tkG6ilPsqWbJW2Wj2E=;
        b=ZXKNIaun0Z5UohOMnTtYHhuFvIpMnUUy2jtikO9tCmWYWMcB59zG0y9jrL0jrOJjqi
         rWYI6pIEuq+RXhD9r5lTSM9z43HgyYsye7scV4arxtijwj/qeq80PvcQuo/UgSOMwRIR
         VFuHYsfmwshBzke02Q4wtwLM18ZXfBo8lW2km05Qj3OMsEYRN40v9cYz5yOeR2i5bDsy
         xKTO/d94I+hMvZp0caq3mKgUCsSBOraMAna8BYWdWeJrAT1cAQRgumGUjGT6mG3RTxkN
         I70lx6gkYvoYbXiYasoSR0QQLr6SMpQdwGQElbBEG+1Cit3mG7JcTxGKEB/yhWBTa5bq
         zePg==
X-Gm-Message-State: AOJu0YxxaimtNgESt25nY4jk48qj7PgvSstAFCk9dAymnTUf5uxHiJ1D
	GOaWrdmu/01a1SY3WsfayWQOnFZ4SKcFXBkyga7PZbLQ8joMc2/C4dYTQdTRLwYm/+BU8mCQuIK
	Em1oKpO/Hcz1T4fCYj+SvDfi2E/iCm+E7dqwWdqgw9g==
X-Gm-Gg: ATEYQzyjfKPsv8NwN7zBn3ENqv4PT5AIV3Yu2R+77MWRHlUL7hxUWtA995IZHBLSSzX
	t+ucsmTtVyDLqHet6vhikxtUC8S7TpO5edWUDKKb7n0nYUp2lXU8kOCq3FN4lXe9YBb8e6CgyiA
	sK13Ygom/BEGU4JPLWoep15113AdwQQiirwI941dF0YfGS2pPVeuBI8gHpQIhfWesz1fkOh94Im
	emTml2J4LT+To5ZfVLGMHaB7zsGhSb9EamgUSrDzhdNYGqqcmdPMxjfOeOqXsnj4iqzTAajRhR9
	NAJpMsDH
X-Received: by 2002:a05:6512:3a84:b0:5a1:34f8:b603 with SMTP id
 2adb3069b0e04-5a285af568emr3824451e87.8.1774279210200; Mon, 23 Mar 2026
 08:20:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320220221.3236937-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260320220221.3236937-1-andriy.shevchenko@linux.intel.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Mar 2026 16:19:34 +0100
X-Gm-Features: AQROBzCXjfYH3Vxh6f0TuCnQoy5nZ7SKPlztBf2P_1WDn1HIIvHuEFMvh2dKlrs
Message-ID: <CAPDyKFp9dRnmFwaoaY_rgorRi9oChVY+XNKZXV1ioZjoBqgvXQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] mmc: sdhci-pci: Drop unused include
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Mar 2026 at 23:02, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> This driver includes the legacy header <linux/gpio.h> but does
> not use any symbols from it. Drop the inclusion.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied for next, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/host/sdhci-pci-core.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 47a0a738862b..c347fac24515 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -20,7 +20,6 @@
>  #include <linux/scatterlist.h>
>  #include <linux/io.h>
>  #include <linux/iopoll.h>
> -#include <linux/gpio.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/pm_qos.h>
> --
> 2.50.1
>
