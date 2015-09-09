From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] mmc: block: Add new ioctl to send multi commands
Date: Wed, 9 Sep 2015 17:44:54 +0100
Message-ID: <55F06206.9040001@nvidia.com>
References: <1441811161-18513-1-git-send-email-jonathanh@nvidia.com>
 <1481090.IIYrKtDeR0@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4474 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752438AbbIIQpB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 Sep 2015 12:45:01 -0400
In-Reply-To: <1481090.IIYrKtDeR0@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, grundler@google.com, olofj@chromium.org, Seshagiri Holi <sholi@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org


On 09/09/15 16:56, Arnd Bergmann wrote:
> On Wednesday 09 September 2015 16:06:01 Jon Hunter wrote:
>> +
>> +       idata = kcalloc(mcci.num_of_cmds, sizeof(*idata), GFP_KERNEL);
>> +       if (!idata) {
>> +               err = -ENOMEM;
>> +               goto cmd_err;
>> +       }
>> +
>> +       cmds = (struct mmc_ioc_cmd __user *)(unsigned long)mcci.cmds_ptr;
>> +       for (n_cmds = 0; n_cmds < mcci.num_of_cmds; n_cmds++) {
>> +               idata[n_cmds] = mmc_blk_ioctl_copy_from_user(&cmds[n_cmds]);
>> +               if (IS_ERR(idata[n_cmds])) {
>> +                       err = PTR_ERR(idata[n_cmds]);
>> +                       goto cmd_err;
>> +               }
>> +       }
>> +
> 
> You have no upper bound on the number of commands, which means you end
> up catching overly large arguments only through -ENOMEM. Can you come
> up with an upper bound that is guaranteed to succeed with the allocation?

The uint8 type would limit you to 256 commands (if you have the memory),
although admittedly that is probably overkill.
 
> Or would it be possible to process the user data one at a time while
> going through the commands?

Yes, I think that could be a good option, I will take a look.
 
>> +struct mmc_ioc_multi_cmd {
>> +       __u64 cmds_ptr;
>> +       uint8_t num_of_cmds;
>> +};
>  
> complex commands are always nasty in one way or another. Can you describe
> in the patch description why you picked an indirect pointer over something
> like
> 
> struct mmc_ioc_multi_cmd {
> 	__u64 num_of_cmds;
> 	struct mmc_ioc_cmd cmds[0];
> };
> 
> as I said, both are ugly. My first choice would have been the other one,
> but I'm sure you have some reasons yourself.

It was a suggestion from Olof to ensure the structure size is constant for
both 32-bit and 64-bit userspaces. I am not sure if it is worth adding a
macro similar to the below for this?

#define mmc_ioc_cmd_set_data(ic, ptr) ic.data_ptr = (__u64)(unsigned long) ptr

However, yes can update the changelog.

Cheers
Jon
