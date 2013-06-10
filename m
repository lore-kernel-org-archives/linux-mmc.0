From: Oded Gabbay <ogabbay@advaoptical.com>
Subject: Re: [PATCH 3/3] MMC: FSL SDHC: Add support for hard-wired (permanent)
 card. Kernel version 3.4.47
Date: Mon, 10 Jun 2013 19:44:38 +0300
Message-ID: <51B60276.5040002@advaoptical.com>
References: <1370155128-680-1-git-send-email-ogabbay@advaoptical.com> <51B57266.9050107@de.bosch.com> <51B5D7F0.4050708@advaoptical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.advaoptical.com ([91.217.199.15]:51552 "EHLO
	mail.advaoptical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751999Ab3FJQpD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 10 Jun 2013 12:45:03 -0400
In-Reply-To: <51B5D7F0.4050708@advaoptical.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "cjb@laptop.org" <cjb@laptop.org>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "rob@landley.net" <rob@landley.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>

Hi All,

Just noticed that 3.4.47/8 doesn't have the mmc_of_parse (compared to 
3.9.4).
Therefore, I will not use it and just fix the code to recognize the 
property "non-removable"

Best regards,
Oded

On 06/10/2013 04:43 PM, Oded Gabbay wrote:
> Hi Dirk,
>
> You are absolutely right.
> I will revise my patch series to reflect the change.
> Basically, I will call the generic mmc_of_parse from the probe 
> function of Freescale's driver.
> That will handle all the additional capabilities.
>
> Thanks
> Oded
>
> On 06/10/2013 09:29 AM, Dirk Behme wrote:
>> On 02.06.2013 08:38, Oded Gabbay wrote:
>>> This patch adds support of recognizing hard-wired (permanent) cards
>>> to Freescale's SDHC host driver. This is done by adding the option
>>> "fsl,card-wired" to the SDHC device-tree entry. Detection of this
>>> option is done in the probe function. Update documentation in file
>>> fsl-esdhc.txt
>>
>> Why don't you want to introduce "fsl,card-wired"? Why don't you use 
>> "non-removable"?
>>
>> To my understanding the patch
>>
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=7f217794ffa72f208a250b79ab0b7ea3de19677f 
>>
>>
>> explicitly removed "fsl,card-wired". So I don't think re-introducing 
>> it is a good idea?
>>
>> Best regards
>>
>> Dirk
>

