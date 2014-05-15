From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v2 1/6] mmc: omap_hsmmc: use devm_clk_get
Date: Thu, 15 May 2014 18:55:45 +0530
Message-ID: <5374C059.8080404@ti.com>
References: <1399654013-28262-1-git-send-email-balajitk@ti.com> <1399654013-28262-2-git-send-email-balajitk@ti.com> <CAPDyKFpQ43168D4FVpbKExHuBPAfkyPrhiy4mG7c=481cpncmQ@mail.gmail.com> <5370CDA1.2060209@ti.com> <CAPDyKFqJc92kZn_Yj87q3GJWOq+jftm0UPsShAPREqkMKC5S4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53554 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752149AbaEONZn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 May 2014 09:25:43 -0400
In-Reply-To: <CAPDyKFqJc92kZn_Yj87q3GJWOq+jftm0UPsShAPREqkMKC5S4g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, linux-omap <linux-omap@vger.kernel.org>

On Monday 12 May 2014 07:20 PM, Ulf Hansson wrote:
> On 12 May 2014 15:33, Balaji T K <balajitk@ti.com> wrote:
>> On Monday 12 May 2014 02:03 PM, Ulf Hansson wrote:
>>>
>>> On 9 May 2014 18:46, Balaji T K <balajitk@ti.com> wrote:
>>>>
>>>> With devm_clk_get conversion clk_put can be removed in clean up path
>>>>
>>>> Signed-off-by: Balaji T K <balajitk@ti.com>
>>>> ---
>>>>    drivers/mmc/host/omap_hsmmc.c |   15 ++++-----------
>>>>    1 files changed, 4 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/omap_hsmmc.c
>>>> b/drivers/mmc/host/omap_hsmmc.c
>>>> index b4de63b..b8ae7ee 100644
>>>> --- a/drivers/mmc/host/omap_hsmmc.c
>>>> +++ b/drivers/mmc/host/omap_hsmmc.c
>>>> @@ -1922,7 +1922,7 @@ static int omap_hsmmc_probe(struct platform_device
>>>> *pdev)
>>>>
>>>>           spin_lock_init(&host->irq_lock);
>>>>
>>>> -       host->fclk = clk_get(&pdev->dev, "fck");
>>>> +       host->fclk = devm_clk_get(&pdev->dev, "fck");
>>>>           if (IS_ERR(host->fclk)) {
>>>>                   ret = PTR_ERR(host->fclk);
>>>>                   host->fclk = NULL;
>>>> @@ -1941,7 +1941,7 @@ static int omap_hsmmc_probe(struct platform_device
>>>> *pdev)
>>>>
>>>>           omap_hsmmc_context_save(host);
>>>>
>>>> -       host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
>>>> +       host->dbclk = devm_clk_get(&pdev->dev, "mmchsdb_fck");
>>>>           /*
>>>>            * MMC can still work without debounce clock.
>>>>            */
>>>> @@ -1949,7 +1949,6 @@ static int omap_hsmmc_probe(struct platform_device
>>>> *pdev)
>>>>                   host->dbclk = NULL;
>>>>           } else if (clk_prepare_enable(host->dbclk) != 0) {
>>>>                   dev_warn(mmc_dev(host->mmc), "Failed to enable debounce
>>>> clk\n");
>>>> -               clk_put(host->dbclk);
>>>>                   host->dbclk = NULL;
>>>
>>>
>>> You should use the IS_ERR macro, no need to reset dbclk to NULL.
>>>
>>
>> Agreed, IS_ERR macro usage deserves patch on its own.
>> will create separate patch on top of this series.
>
> Or you just update this patch, since it would touch there very same
> piece of code. :-)

plus few more code additionally, since these are two different logical changes,
have sent a separate patch. But feel free to squash them if needed.

Thanks and Regards,
Balaji T K
