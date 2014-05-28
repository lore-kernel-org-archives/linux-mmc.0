From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 08/13] mmc: mmci: add 8bit bus support in variant data
Date: Wed, 28 May 2014 08:27:31 +0100
Message-ID: <53858FE3.9040207@linaro.org>
References: <1400849362-7007-1-git-send-email-srinivas.kandagatla@linaro.org>	<1400849527-7384-1-git-send-email-srinivas.kandagatla@linaro.org> <CAPDyKFruVPo-k+19pQ4zGrVBH0gqszQ5vphsTAm6HTXUX5riFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:62458 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882AbaE1H1f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 28 May 2014 03:27:35 -0400
Received: by mail-we0-f179.google.com with SMTP id q59so10506517wes.24
        for <linux-mmc@vger.kernel.org>; Wed, 28 May 2014 00:27:34 -0700 (PDT)
In-Reply-To: <CAPDyKFruVPo-k+19pQ4zGrVBH0gqszQ5vphsTAm6HTXUX5riFg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

Hi Linus W,


On 26/05/14 11:07, Ulf Hansson wrote:
>>          unsigned int            fifosize;
>> >         unsigned int            fifohalfsize;
>> >@@ -116,6 +118,7 @@ static struct variant_data variant_u300 = {
>> >         .fifosize               = 16 * 4,
>> >         .fifohalfsize           = 8 * 4,
>> >         .clkreg_enable          = MCI_ST_U300_HWFCEN,
>> >+       .clkreg_8bit_bus_enable = MCI_ST_8BIT_BUS,
> Linus, will have to confirm this. I don't know if the u300 variant
> support 8-bit.
>

Do you know if u300 supports 8BIT bus?

thanks,
srini

> Kind regards
> Ulf Hansson
>
