From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/6] mmc: omap_hsmmc: use devm_clk_get
Date: Mon, 12 May 2014 15:50:38 +0200
Message-ID: <CAPDyKFqJc92kZn_Yj87q3GJWOq+jftm0UPsShAPREqkMKC5S4g@mail.gmail.com>
References: <1399654013-28262-1-git-send-email-balajitk@ti.com>
	<1399654013-28262-2-git-send-email-balajitk@ti.com>
	<CAPDyKFpQ43168D4FVpbKExHuBPAfkyPrhiy4mG7c=481cpncmQ@mail.gmail.com>
	<5370CDA1.2060209@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f43.google.com ([209.85.216.43]:53233 "EHLO
	mail-qa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbaELNuj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 May 2014 09:50:39 -0400
Received: by mail-qa0-f43.google.com with SMTP id m5so7017365qaj.2
        for <linux-mmc@vger.kernel.org>; Mon, 12 May 2014 06:50:38 -0700 (PDT)
In-Reply-To: <5370CDA1.2060209@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-omap <linux-omap@vger.kernel.org>

On 12 May 2014 15:33, Balaji T K <balajitk@ti.com> wrote:
> On Monday 12 May 2014 02:03 PM, Ulf Hansson wrote:
>>
>> On 9 May 2014 18:46, Balaji T K <balajitk@ti.com> wrote:
>>>
>>> With devm_clk_get conversion clk_put can be removed in clean up path
>>>
>>> Signed-off-by: Balaji T K <balajitk@ti.com>
>>> ---
>>>   drivers/mmc/host/omap_hsmmc.c |   15 ++++-----------
>>>   1 files changed, 4 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/omap_hsmmc.c
>>> b/drivers/mmc/host/omap_hsmmc.c
>>> index b4de63b..b8ae7ee 100644
>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>> @@ -1922,7 +1922,7 @@ static int omap_hsmmc_probe(struct platform_device
>>> *pdev)
>>>
>>>          spin_lock_init(&host->irq_lock);
>>>
>>> -       host->fclk = clk_get(&pdev->dev, "fck");
>>> +       host->fclk = devm_clk_get(&pdev->dev, "fck");
>>>          if (IS_ERR(host->fclk)) {
>>>                  ret = PTR_ERR(host->fclk);
>>>                  host->fclk = NULL;
>>> @@ -1941,7 +1941,7 @@ static int omap_hsmmc_probe(struct platform_device
>>> *pdev)
>>>
>>>          omap_hsmmc_context_save(host);
>>>
>>> -       host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
>>> +       host->dbclk = devm_clk_get(&pdev->dev, "mmchsdb_fck");
>>>          /*
>>>           * MMC can still work without debounce clock.
>>>           */
>>> @@ -1949,7 +1949,6 @@ static int omap_hsmmc_probe(struct platform_device
>>> *pdev)
>>>                  host->dbclk = NULL;
>>>          } else if (clk_prepare_enable(host->dbclk) != 0) {
>>>                  dev_warn(mmc_dev(host->mmc), "Failed to enable debounce
>>> clk\n");
>>> -               clk_put(host->dbclk);
>>>                  host->dbclk = NULL;
>>
>>
>> You should use the IS_ERR macro, no need to reset dbclk to NULL.
>>
>
> Agreed, IS_ERR macro usage deserves patch on its own.
> will create separate patch on top of this series.

Or you just update this patch, since it would touch there very same
piece of code. :-)

Kind regards
Ulf Hansson
