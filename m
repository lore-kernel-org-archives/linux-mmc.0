From: Tomas Melin <tomas.melin@vaisala.com>
Subject: Re: [RFC PATCH] mmc: block: Support the fixed index for mmcblk with
 aliases nodes
Date: Fri, 10 Feb 2017 13:35:18 +0200
Message-ID: <e4c2e2ab-29bc-a32a-8da7-082f5ffbabd8@vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hel-mailgw-01.vaisala.com ([193.143.230.17]:46778 "EHLO
        hel-mailgw-01.vaisala.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbdBJLfr (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 10 Feb 2017 06:35:47 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, jszhang@marvell.com, shawn.lin@rock-chips.com, dianders@google.com

Hi,

It looks as this RFC was never posted as a real patch.
For embedded devices with several memory devices, some being removable,
providing a way to define aliases for the nodes in the device tree is a benefit.
I have tested the patch from Jaehoon and it works nicely.

Could this be reposted and considered for inclusion?

Found the original patch here: https://patchwork.kernel.org/patch/8685711/

Best Regards
Tomas


On 04/04/2016 09:14 PM, Ulf Hansson wrote:
> On 4 April 2016 at 04:08, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi All,
>>
>> Are there any other opinion for this RFC patch?
>>
>> Best Regards,
>> Jaehoon Chung
>>
>> On 03/30/2016 09:15 AM, Shawn Lin wrote:
>>> åœ¨ 2016/3/29 18:49, Jisheng Zhang å†™é“:
>>>> Hi Jaehoon,
>>>>
>>>> On Tue, 29 Mar 2016 19:43:34 +0900 Jaehoon Chung wrote:
>>>>
>>>>> This patch is just RFC. I want to know opinions.
>>>>>
>>>>> Now, index of mmcblk is allocated in accordance with probing time.
>>>>> If want to use the mmcblk1 for some device, it can use alias.
>>>>>
>>>>> aliases {
>>>>>     mmc0 = &mmc0;    /* mmcblk0 for eMMC */
>>>>>     mmc1 = &mmc2;    /* mmcblk1 for SD */
>>>>>     mmc2 = &mmc1;    /* mmcblk2 for SDIO*/
>>>>> };
>>>>
>>>> I like this feature and we do need it. In the past, we have to put emmc dt node
>>>> before the sd node, but on our platform, the register base of sdhc host for
emmc
>>>> is higher than the one for sd, putting emmc dt node before sd looks a bit
>>>> strange, but we have no better solutions.
>>>>
>>>
>>> :) That is also what I suffered currently. I have to prepare two
>>> seperate firmware with two diff fstab files to assign the mount point
>>> since sometime I need to boot from sd, but sometimes from emmc....
>>> With this patch, I only need to dtc a new dtb... quite simple.
>>>
>>>> Thanks,
>>>> Jisheng
>
> I am not immediately opposed to this patch, although let me think a
> bit more about it.
>
> What I would like to understand is why UUID/PARTUUID isn't working for
> your case. Did you try to use that?

I have used with UUID/PARTUUID/PARTLABEL and etc.. I think it's not problem.
But that is why some guys wants to use the fixed index.
(Almost all SoCs are still using "root=mmcblk0pX" in bootloader.)

I'm considering more what is better. :)

Best Regards,
Jaehoon Chung

>
> Kind regards
> Uffe
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
