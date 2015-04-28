From: Scott Branden <sbranden@broadcom.com>
Subject: Re: 04e079cf6b24c794 to stable
Date: Tue, 28 Apr 2015 14:15:19 -0700
Message-ID: <553FF867.9080507@broadcom.com>
References: <CAOMZO5B_L42K=VQ58B8B9buy18_7few3H1Jhd_HXFJ8wsxZ05Q@mail.gmail.com> <CAOMZO5DnfYs7O6AvshfKWrQ_Op6NZwg4R=Z2wzwXMG=_go1Lvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw1-out.broadcom.com ([216.31.210.62]:34276 "EHLO
	mail-gw1-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030711AbbD1VQi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 28 Apr 2015 17:16:38 -0400
In-Reply-To: <CAOMZO5DnfYs7O6AvshfKWrQ_Op6NZwg4R=Z2wzwXMG=_go1Lvg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Otavio Salvador <otavio@ossystems.com.br>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Fabio,

Yes, you can apply the change to stable.

Regards,
Scott

On 15-04-28 12:49 PM, Fabio Estevam wrote:
> On Tue, Apr 28, 2015 at 12:46 PM, Fabio Estevam <festevam@gmail.com> wrote:
>> Hi Ulf and Scott,
>>
>> Should the commit below be applied to stable?
>>
>> commit 04e079cf6b24c794bbc52b04b370f84cb728540e
>> Author: Scott Branden <sbranden@broadcom.com>
>> Date:   Tue Mar 10 11:35:10 2015 -0700
>>
>>      mmc: sdhci: fix card presence logic in sdhci_request function
>>
>>      The sdhci_request function should consider a non-removable device
>>      always present.
>>      Call the correct logic already available in sdhci_do_get_cd function.
>>
>>      This fixes some logic paths where MMC requests are being made to
>>      non-removable devices that do not have the card detect pin connected
>>      on the hardware as it is non-removable.
>>
>>      Signed-off-by: Scott Branden <sbranden@broadcom.com>
>>      Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> The reason I am asking is that we were seeing issues on mx6 boards
>> running 4.0 kernel branch + 8d86e4fcccf61bafe5 ("mmc: sdhci-esdhc-imx:
>> Call mmc_of_parse()"), which is 4.1-rc1 material.
>>
>> Otavio suggested me to apply 04e079cf6b24 in our tree and after that
>> the SD card detection goes away.
>
> Sorry, I meant "and after that the SD card detection problem goes away"
>

