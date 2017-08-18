From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3] mmc: block: prevent propagating R1_OUT_OF_RANGE for
 open-ending mode
Date: Fri, 18 Aug 2017 09:02:15 +0800
Message-ID: <58db13f3-0cf0-8285-f279-9cdcd79f54ef@rock-chips.com>
References: <1502845901-163345-1-git-send-email-shawn.lin@rock-chips.com>
 <20170817104047.ikfljcrggl2ncxqv@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:54742 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753375AbdHRBC1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Aug 2017 21:02:27 -0400
In-Reply-To: <20170817104047.ikfljcrggl2ncxqv@ninjato>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Hi Wolfram,

On 2017/8/17 18:40, Wolfram Sang wrote:
> Hi Shawn,
> 
> On Wed, Aug 16, 2017 at 09:11:41AM +0800, Shawn Lin wrote:
>> We to some extent should tolerate R1_OUT_OF_RANGE for open-ending
>> mode as it is expected behaviour and most of the backup partition
>> tables should be located near some of the last blocks which will
>> always make open-ending read exceed the capacity of cards.
>>
>> Fixes: 9820a5b11101 ("mmc: core: for data errors, take response of stop cmd into account")
>> Fixes: a04e6bae9e6f ("mmc: core: check also R1 response for stop commands")
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>>
>> Tested-by: Shawn Guo <shawnguo@kernel.org>
>> Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 
> I'd think these Tested-by should be dropped. We changed the patch quite
> a bit meanwhile and I am quite sure Shimoda-san didn't test this new
> version of the patch. Dunno about Shawn. Hopefully they have time to
> re-test?
> 
>> +	/*
>> +	 * Per the SD specification(physical layer version 4.10)[1],
>> +	 * section 4.3.3, it explicitly states that "When the last
>> +	 * block of user area is read using CMD18, the host should
>> +	 * ignore OUT_OF_RANGE error that may occur even the sequence
>> +	 * is correct". And JESD84-B51 for eMMC also has a similar
>> +	 * statement on section 6.8.3.
>> +	 *
>> +	 * Multiple block read/write could be done by either predefined
>> +	 * method, namely CMD23, or open-ending mode.
>> +	 *
> 
> Very minor nit: I'd remove this empty line and merge the two paragraphs.

well do in v4

> 
>> +	 * For open-ending mode, we should ignore the OUT_OF_RANGE
>> +	 * error as it's normal behaviour.
>> +	 *
>> +	 * However the spec[1] doesn't tell us whether we should also
>> +	 * ignore that for predefined method. But per the spec[1], section
>> +	 * 4.15 Set Block Count Command, it says"If illegal block count
>> +	 * is set, out of range error will be indicated during read/write
>> +	 * operation (For example, data transfer is stopped at user area
>> +	 * boundary)." In another word, we could expect a out of range error
>> +	 * in the response for the following CMD18/25. And if argument of
>> +	 * CMD23 + the argument of CMD18/25 exceed the max number of blocks,
>> +	 * we could also expect to get a -ETIMEDOUT or any error number from
>> +	 * the host drivers due to missing data response(for write)/data(for
>> +	 * read), as the cards will stop the data transfer by itself per the
>> +	 * spec. So we only need to check R1_OUT_OF_RANGE for open-ending mode.
>> +	 */
> 
> Very good! I like this a lot.
> 
> Also minor nit, but likely better readable:
> 
>> +
>> +	if (!brq->stop.error) {
> 		bool OOR_with_open_end;
> 
>> +		/* If there is no error yet, check R1 response */
>> +		val = brq->stop.resp[0] & CMD_ERRORS;
> 
> 		OOR_with_open_end = val & R1_OUT_OF_RANGE && !brq->mrq.sbc;
> 
> 		if (val && !OOR_with_open_end)
>> +			brq->stop.error = -EIO;
> 
> ...
> 
>> +	if (brq->sbc.error || brq->cmd.error ||
>> +	    brq->stop.error || brq->data.error) {
> 

will do in v4 but slightly rename it to oor_with_open_end as
it doesn't seem general to name a variable with upper letter.

> I am not super strict with the 80 char limit and think one line is
> better readable, but I leave that to you and/or Ulf.

Make sense but I will keep it and leave that to Ulf too. :)

> 
> Other than that minor stuff:
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Thanks for this collaboration! I liked it :)
> 
> Regards,
> 
>     Wolfram
> 

