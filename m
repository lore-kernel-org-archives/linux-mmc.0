From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH] mmc: block: Add new ioctl to send combo commands
Date: Tue, 8 Sep 2015 10:18:59 +0100
Message-ID: <55EEA803.5010201@nvidia.com>
References: <1441203711-19538-1-git-send-email-jonathanh@nvidia.com>
 <CAOesGMh9d6yX-dS6jg2eu2hvN5S=87rr7L-+ZUreX=GGHDxRaA@mail.gmail.com>
 <CANEJEGsb=bSyqYW6K5eXr8PwUrJxokOHz894ofk4F-SRohGeQQ@mail.gmail.com>
 <CANEJEGvRSDFjrVPMN=3d2yEK=d1eQYQgvAynw75Qj2fcPdrq7Q@mail.gmail.com>
 <55E862DA.1080509@nvidia.com>
 <CANEJEGsGfr9j8AZz-mpC=a87QX9+OJwtESCASR_t5_SYqbV8fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5465 "EHLO
	hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753367AbbIHJTG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2015 05:19:06 -0400
In-Reply-To: <CANEJEGsGfr9j8AZz-mpC=a87QX9+OJwtESCASR_t5_SYqbV8fg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Grant Grundler <grundler@chromium.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olof Johansson <olofj@chromium.org>, Seshagiri Holi <sholi@nvidia.com>


On 04/09/15 02:14, Grant Grundler wrote:
> On Thu, Sep 3, 2015 at 8:10 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
> 
>>
>> On 02/09/15 23:08, Grant Grundler wrote:
>>> [resending text-only]
>>>
>>> On Wed, Sep 2, 2015 at 3:07 PM, Grant Grundler <grundler@google.com>
>> wrote:
>>>>
>>>>
>>>> On Wed, Sep 2, 2015 at 11:28 AM, Olof Johansson <olof@lixom.net> wrote:
>>>> ...
>>>>>> +/**
>>>>>> + * struct mmc_ioc_combo_cmd - combo command information
>>>>>> + * @num_of_cmds: number of commands to send
>>>>>> + * @mmc_ioc_cmd_list: pointer to list of commands
>>>>>> + */
>>>>>> +struct mmc_ioc_combo_cmd {
>>>>>> +       uint8_t num_of_cmds;
>>>>>> +       struct mmc_ioc_cmd *mmc_ioc_cmd_list;
>>>>>> +};
>>>>>
>>>>> The size of this struct will depend on the pointer size of userspace.
>>>>>
>>>>> It might be better to use a u64 for the pointer instead. Otherwise
>>>>> you'd need a compat ioctl wrapper to copy a 32-bit pointer over on a
>>>>> 64-bit kernel.
>>>>
>>>> If alignment matters, then maybe swap the fields?
>>>> Or declare num_of_cmds as u64 as well?
>>
>> Thanks. I did swap them in the updated version as this seems to make
>> sense. However, I left num_of_cmds as an 8-bit value unless someone has
>> a need for more than 256 commands ;-)
>>
> 
> Awesome - thanks! I saw that in the new version you posted. LGTM.
> You or Ulf can add my "Reviewed by: Grant Grundler <grundler@chromium.org"
> 
> (I just switched the "reply-from:" on you ;)
> 
> Ulf, anything else stand out?
> 
> I normally don't like to rush but we'd at least like confirmation that
> struct mmc_ioc_combo_cmd is acceptable as is (since it's the main part of
> the API).

Ulf,

Sorry to pester you, but we wanted to get some feedback on whether this
proposal is ok or not.

Cheers
Jon

