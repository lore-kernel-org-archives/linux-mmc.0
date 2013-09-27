From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/1] mmc: wmt-sdmmc: Fix NULL pointer dereference
Date: Fri, 27 Sep 2013 15:10:40 +0530
Message-ID: <CAK9yfHzpYKTxJWr3w6rmmsP6n-fJ-Auaty7c7ATo7isCVumizQ@mail.gmail.com>
References: <1378974078-15416-1-git-send-email-sachin.kamat@linaro.org>
	<52320B39.3080306@prisktech.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f180.google.com ([209.85.214.180]:40445 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630Ab3I0Jkl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Sep 2013 05:40:41 -0400
Received: by mail-ob0-f180.google.com with SMTP id wm4so3053981obc.11
        for <linux-mmc@vger.kernel.org>; Fri, 27 Sep 2013 02:40:41 -0700 (PDT)
In-Reply-To: <52320B39.3080306@prisktech.co.nz>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

On 13 September 2013 00:13, Tony Prisk <linux@prisktech.co.nz> wrote:
> On 12/09/13 20:21, Sachin Kamat wrote:
>>
>> 'of_id' is dereferenced before NULL pointer check. Move it to
>> after the check.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> ---
>> Compile tested.
>> ---
>>   drivers/mmc/host/wmt-sdmmc.c |    4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
>> index 34231d5..3523a72 100644
>> --- a/drivers/mmc/host/wmt-sdmmc.c
>> +++ b/drivers/mmc/host/wmt-sdmmc.c
>> @@ -771,7 +771,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
>>         struct device_node *np = pdev->dev.of_node;
>>         const struct of_device_id *of_id =
>>                 of_match_device(wmt_mci_dt_ids, &pdev->dev);
>> -       const struct wmt_mci_caps *wmt_caps = of_id->data;
>> +       const struct wmt_mci_caps *wmt_caps;
>>         int ret;
>>         int regular_irq, dma_irq;
>>   @@ -780,6 +780,8 @@ static int wmt_mci_probe(struct platform_device
>> *pdev)
>>                 return -EFAULT;
>>         }
>>   +     wmt_caps = of_id->data;
>> +
>>         if (!np) {
>>                 dev_err(&pdev->dev, "Missing SDMMC description in
>> devicetree\n");
>>                 return -EFAULT;
>
>
> While I don't mind either way, this can never fail anyway. arch-vt8500 is
> devicetree only, so the only way the driver will get probed is through a
> compatible-match, and .data must be (and is) specified.
>
> I guess it's still good housekeeping to test it to protect future changes
> so:
>
> Acked-by: Tony Prisk <linux@prisktech.co.nz>

Ping Chris.

-- 
With warm regards,
Sachin
