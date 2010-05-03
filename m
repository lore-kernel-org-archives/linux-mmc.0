From: =?UTF-8?B?UmljaGFyZCBSw7ZqZm9ycw==?=
	<richard.rojfors@pelagicore.com>
Subject: Re: [PATCH 3/3] sdhci-pltfm: Do not print errors in case of an extended
 iomem size
Date: Mon, 03 May 2010 08:01:00 +0200
Message-ID: <4BDE669C.6030901@pelagicore.com>
References: <20100316183400.GA24191@oksana.dev.rtsoft.ru> <20100316183430.GC25670@oksana.dev.rtsoft.ru> <4BA0708C.8070402@pelagicore.com> <20100423182552.GA4076@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay-h22.telenor.se ([195.54.99.197]:53000 "EHLO
	smtprelay-h22.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754549Ab0ECGBG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 May 2010 02:01:06 -0400
In-Reply-To: <20100423182552.GA4076@oksana.dev.rtsoft.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Vrabel <david.vrabel@csr.com>, Pierre Ossman <pierre@ossman.eu>, Ben Dooks <ben@simtec.co.uk>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

On 04/23/2010 08:25 PM, Anton Vorontsov wrote:
> On Wed, Mar 17, 2010 at 07:02:52AM +0100, Richard R=C3=B6jfors wrote:
>> On 3/16/10 7:34 PM, Anton Vorontsov wrote:
>>> Some hosts have an extended SDHCI iomem size, so the driver should
>>> only print errors if the iomem size is less than 0x100.
>>
>> With this change you allow a bigger resource than we really need.
>> I think you should also change request_mem_region and ioremap to onl=
y
>> request and map the actual needed size. (0x100)
>
> Sorry for the delayed response.
>
> Why do you think that mapping more than "needed" is a bad thing?
> Looking into the PCI driver, it just maps the whole PCI BAR (which
> makes sense, since later SDHCI spec might easily introduce an
> extended address space, so hardcoding 0x100 isn't very good).
>
> There is another case when mapping the whole SDHCI mem space
> might be convenient: if the platform code will want to use
> the ioremapped region inside the platform hooks.

That's a good reason.

Acked-by: Richard R=C3=B6jfors <richard.rojfors@pelagicore.com>

>
> Thanks!
>
>>> Signed-off-by: Anton Vorontsov<avorontsov@ru.mvista.com>
>>> ---
>>>   drivers/mmc/host/sdhci-pltfm.c |    2 +-
>>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhc=
i-pltfm.c
>>> index 217b911..b6ee0d7 100644
>>> --- a/drivers/mmc/host/sdhci-pltfm.c
>>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>>> @@ -61,7 +61,7 @@ static int __devinit sdhci_pltfm_probe(struct pla=
tform_device *pdev)
>>>   		goto err;
>>>   	}
>>>
>>> -	if (resource_size(iomem) !=3D 0x100)
>>> +	if (resource_size(iomem)<  0x100)
>>>   		dev_err(&pdev->dev, "Invalid iomem size. You may "
>>>   			"experience problems.\n");
>>>
>>
>
