From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3] mmc: block: prevent propagating R1_OUT_OF_RANGE for
 open-ending mode
Date: Fri, 18 Aug 2017 09:03:04 +0800
Message-ID: <fdf88986-aefc-a4c1-c340-2b5ad89616f4@rock-chips.com>
References: <1502845901-163345-1-git-send-email-shawn.lin@rock-chips.com>
 <20170817104047.ikfljcrggl2ncxqv@ninjato> <20170817133413.GD7608@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:55487 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753375AbdHRBDJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Aug 2017 21:03:09 -0400
In-Reply-To: <20170817133413.GD7608@dragon>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On 2017/8/17 21:34, Shawn Guo wrote:
> On Thu, Aug 17, 2017 at 12:40:47PM +0200, Wolfram Sang wrote:
>> Hi Shawn,
>>
>> On Wed, Aug 16, 2017 at 09:11:41AM +0800, Shawn Lin wrote:
>>> We to some extent should tolerate R1_OUT_OF_RANGE for open-ending
>>> mode as it is expected behaviour and most of the backup partition
>>> tables should be located near some of the last blocks which will
>>> always make open-ending read exceed the capacity of cards.
>>>
>>> Fixes: 9820a5b11101 ("mmc: core: for data errors, take response of stop cmd into account")
>>> Fixes: a04e6bae9e6f ("mmc: core: check also R1 response for stop commands")
>>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>>
>>> Tested-by: Shawn Guo <shawnguo@kernel.org>
>>> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>
>> I'd think these Tested-by should be dropped. We changed the patch quite
>> a bit meanwhile and I am quite sure Shimoda-san didn't test this new
>> version of the patch. Dunno about Shawn. Hopefully they have time to
>> re-test?
> 
> I just re-tested it on Hikey, so my Tested-by tag can be kept.

Great! Thanks for testing it again!

> 
> Shawn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 

