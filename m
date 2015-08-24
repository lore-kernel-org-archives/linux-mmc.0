From: Laura Abbott <labbott@redhat.com>
Subject: Re: [RFC] sdhci: fix DMA leaks [was: [SHDCI] Heavy (thousands) DMA
 leaks]
Date: Mon, 24 Aug 2015 09:26:32 -0700
Message-ID: <55DB45B8.3020106@redhat.com>
References: <55B9EF02.7040404@suse.cz>
 <BY1PR03MB138811AD7FAB3C561CC683679A770@BY1PR03MB1388.namprd03.prod.outlook.com>
 <55BF36D6.4080504@suse.cz> <55C1F919.4080002@suse.cz>
 <55C227B4.3030102@suse.cz>
 <BY1PR03MB13889A6C31FC542DB544CE479A740@BY1PR03MB1388.namprd03.prod.outlook.com>
 <55C323A5.6050303@suse.cz>
 <BY1PR03MB1388AE95AA9000BB9B8B47559A740@BY1PR03MB1388.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BY1PR03MB1388AE95AA9000BB9B8B47559A740@BY1PR03MB1388.namprd03.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen Bough <Haibo.Chen@freescale.com>, Jiri Slaby <jslaby@suse.cz>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux kernel mailing list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 08/06/2015 02:17 AM, Chen Bough wrote:
> I will format a patch based on your diff file firstly. I will test this on my side,
> If any issue, like dma issue or performance issue, I will add some modification.
> Then I will send the patch for review, and you can test the patch on your platform.
>
> Best Regards
> Haibo Chen
>

Did I miss the follow up patch or is this still pending? If it's still pending,
would you mind Ccing me when it's available for testing?

Thanks,
Laura
  
>
>> -----Original Message-----
>> From: Jiri Slaby [mailto:jslaby@suse.cz]
>> Sent: Thursday, August 06, 2015 5:07 PM
>> To: Chen Haibo-B51421; Ulf Hansson
>> Cc: linux-mmc@vger.kernel.org; Linux kernel mailing list
>> Subject: Re: [RFC] sdhci: fix DMA leaks [was: [SHDCI] Heavy (thousands)
>> DMA leaks]
>>
>> On 08/06/2015, 09:42 AM, Chen Bough wrote:
>>> I read your attached log and patch, yes, dma memory leak will happen
>>> when more than one pre_request execute. The method of ++next->cookie
>>> is not good, your patch seems good, but I still need some time to test
>>> the patch, because you unmap the dma in sdhci_finish_data rather than
>> the sdhci_post_req.
>>
>> Hi,
>>
>> yes, this is not correct. We can perhaps differentiate according to the
>> COOKIE value. Should I fix it or are you going to prepare a patch based
>> on my RFC?
>>
>> thanks,
>> --
>> js
>> suse labs
