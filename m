From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: Question about commit "mmc: core: Support aggressive power management for (e)MMC/SD"
Date: Sun, 06 Oct 2013 14:56:48 +0200
Message-ID: <8e0ff317-ed21-44e1-95cc-d021c85ded73@email.android.com>
References: <1381032423.7156.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:42943 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab3JFM5U (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 6 Oct 2013 08:57:20 -0400
Received: by mail-la0-f41.google.com with SMTP id ec20so4795301lab.0
        for <linux-mmc@vger.kernel.org>; Sun, 06 Oct 2013 05:57:19 -0700 (PDT)
In-Reply-To: <1381032423.7156.1.camel@phoenix>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org



Axel Lin <axel.lin@ingics.com> skrev:
>Hi Ulf,
>
>While reading the code, I don't figure out why we need a nested
>mmc_claim_host
>/mmc_release_host calls and additional mmc_power_off/mmc_power_up calls
>in
>commit c4d770d72.

Hi Axel,

Please have a look at a patch I sent 3 October. "mmc: core: Remove redundant mmc_power_.....

You have spotted that this code is not needed, I believe the commitmsg in the patch above will give you some background, to why it looked like it did.

Kind regards
Ulf Hansson

>
>The implementation of mmc_suspend/mmc_resume and
>mmc_sd_suspend/mmc_sd_resume
>already calls mmc_claim_host/mmc_release_host and
>mmc_power_off/mmc_power_up.
>
>I don't have a hardware handy to test it at this moment.
>I'm wondering if it still works with below diff:
>
>diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
>index 6d02012..f0dcc53 100644
>--- a/drivers/mmc/core/mmc.c
>+++ b/drivers/mmc/core/mmc.c
>@@ -1552,18 +1552,11 @@ static int mmc_runtime_suspend(struct mmc_host
>*host)
> 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
> 		return 0;
> 
>-	mmc_claim_host(host);
>-
> 	err = mmc_suspend(host);
>-	if (err) {
>+	if (err)
> 		pr_err("%s: error %d doing aggessive suspend\n",
> 			mmc_hostname(host), err);
>-		goto out;
>-	}
>-	mmc_power_off(host);
> 
>-out:
>-	mmc_release_host(host);
> 	return err;
> }
> 
>@@ -1577,15 +1570,11 @@ static int mmc_runtime_resume(struct mmc_host
>*host)
> 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
> 		return 0;
> 
>-	mmc_claim_host(host);
>-
>-	mmc_power_up(host);
> 	err = mmc_resume(host);
> 	if (err)
> 		pr_err("%s: error %d doing aggessive resume\n",
> 			mmc_hostname(host), err);
> 
>-	mmc_release_host(host);
> 	return 0;
> }
> 
>diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
>index 5e8823d..0f2a1f9 100644
>--- a/drivers/mmc/core/sd.c
>+++ b/drivers/mmc/core/sd.c
>@@ -1117,18 +1117,11 @@ static int mmc_sd_runtime_suspend(struct
>mmc_host *host)
> 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
> 		return 0;
> 
>-	mmc_claim_host(host);
>-
> 	err = mmc_sd_suspend(host);
>-	if (err) {
>+	if (err)
> 		pr_err("%s: error %d doing aggessive suspend\n",
> 			mmc_hostname(host), err);
>-		goto out;
>-	}
>-	mmc_power_off(host);
> 
>-out:
>-	mmc_release_host(host);
> 	return err;
> }
> 
>@@ -1142,15 +1135,11 @@ static int mmc_sd_runtime_resume(struct
>mmc_host *host)
> 	if (!(host->caps & MMC_CAP_AGGRESSIVE_PM))
> 		return 0;
> 
>-	mmc_claim_host(host);
>-
>-	mmc_power_up(host);
> 	err = mmc_sd_resume(host);
> 	if (err)
> 		pr_err("%s: error %d doing aggessive resume\n",
> 			mmc_hostname(host), err);
> 
>-	mmc_release_host(host);
> 	return 0;
> }
> 

