From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v4 3/4] mmc: dw_mmc: Always setup the bus after
 suspend/resume
Date: Fri, 09 Aug 2013 22:35:45 +0900
Message-ID: <001a01ce9505$59c28b20$0d47a160$%jun@samsung.com>
References: <1373470926-19314-1-git-send-email-dianders@chromium.org>
 <1375825071-20922-1-git-send-email-dianders@chromium.org>
 <1375825071-20922-4-git-send-email-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:22777 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966148Ab3HINfr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Aug 2013 09:35:47 -0400
In-reply-to: <1375825071-20922-4-git-send-email-dianders@chromium.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Doug Anderson' <dianders@chromium.org>, 'Chris Ball' <cjb@laptop.org>
Cc: 'Olof Johansson' <olof@lixom.net>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'James Hogan' <james.hogan@imgtec.com>, 'Grant Grundler' <grundler@chromium.org>, 'Alim Akhtar' <alim.akhtar@samsung.com>, 'Abhilash Kesavan' <a.kesavan@samsung.com>, 'Tomasz Figa' <tomasz.figa@gmail.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, August 07, 2013, Doug Anderson wrote:
> After suspend/resume all of the dw_mmc registers are reset to
> defaults.  We restore most of them, but specifically don't setup the
> clock registers after resume unless we've got a powered card.  Things
> still work because the core will eventually call set_ios() and we'll
> set things up.

Hmm, I didn't get the need of this call during resume.
I think set_ios is only valid where core layer calls.
Besides, important things is ios's parameters.
If suspend has finished successfully, last call of set_ios() is from mmc_power_off().
On seeing fields of 'mmc->ios' stored last, these values aren't proper in resume phase.
Please check mmc_power_off() function.
In case MMC_PM_KEEP_POWER it could be kept.

Thanks,
Seungwon Jeon
> 
> There doesn't seem to be any reason that I can see _not_ to set things
> up after resume.  Restoring this state makes the code easier to reason
> about and should help prevent bugs.  It also allows us to do a
> register dump before and after suspend/resume to confirm that we've
> set things up OK.
> 
> I examined the state of the dw_mmc instance before and after suspend
> after this patch.  I had no card inserted in an SD card slot.
> 
> Before this patch, differences were:
> * CLKDIV (0x08)
> * CLKENA (0x10)
> * TMOUT (0x14)
> * CMD (0x2C) - difference is not important
> * CLKSEL (0x9C - exynos specific)
> 
> After this patch, only TMOUT was different.  I have a separate patch
> for that.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
> Changes in v4: None
> Changes in v3: None
> Changes in v2: None
> 
>  drivers/mmc/host/dw_mmc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 13a363c..0fa3135 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2522,9 +2522,7 @@ int dw_mci_resume(struct dw_mci *host)
>  		struct dw_mci_slot *slot = host->slot[i];
>  		if (!slot)
>  			continue;
> -		if (slot->mmc->pm_flags & MMC_PM_KEEP_POWER) {
> -			dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
> -		}
> +		dw_mci_set_ios(slot->mmc, &slot->mmc->ios);
> 
>  		ret = mmc_resume_host(host->slot[i]->mmc);
>  		if (ret < 0)
> --
> 1.8.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


