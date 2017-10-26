From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH] mmc: dw_mmc: Increase the timeout in mci_send_cmd to 5
 sec
Date: Thu, 26 Oct 2017 09:11:46 +0800
Message-ID: <b61a3818-936b-814b-8692-2bb87e90bc63@rock-chips.com>
References: <AM5PR0701MB2657301FD402EEAA4B83917CE47F0@AM5PR0701MB2657.eurprd07.prod.outlook.com>
 <CAPDyKFojY21yTMu2E9M8tec6QPZfFuVwJMZO0vY8V2kG7=yRCg@mail.gmail.com>
 <3c46c1a6-edd2-698e-3286-e30d04b99103@hotmail.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:40372 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751911AbdJZBLw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 25 Oct 2017 21:11:52 -0400
In-Reply-To: <3c46c1a6-edd2-698e-3286-e30d04b99103@hotmail.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Bernd Edlinger <bernd.edlinger@hotmail.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, shawn.lin@rock-chips.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>


On 2017/10/2 21:29, Bernd Edlinger wrote:
> On 10/02/17 09:13, Ulf Hansson wrote:
>> On 30 September 2017 at 17:38, Bernd Edlinger <bernd.edlinger@hotmail.de> wrote:
>>>
>>> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
>>
>> Why?
>>
> 
> Obviously the 0.5 seconds time-out was not sufficent for me.
> I experienced a time-out I believe it was with an erase command,
> that took around one second to complete.  Not all brands of SD
> card behave this way, but some do.

The timeout in mci_send_cmd is suffcient. Ideally SDMMC_CMD_START
should be cleared immediately once the cmd was sent out. The only
reason that it wasn't, is that at least one of the IO, including
cmd line and all data lines used, is kept low for whatever reason.

Per your description, the failed case suffers from a long busy time
due to the previous erase command(R1b). But I think the following
command which was expected to use data line, shouldn't be fired to
the host drivers at all without checking the busy state. Otherwise....


> 
> Incidentally I had a similar problem with a completely different
> hardware, see: https://bugzilla.kernel.org/show_bug.cgi?id=107811
> Should I send a patch for that as well?

are there more cases to be fixed?

> 
> 
> Bernd.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

