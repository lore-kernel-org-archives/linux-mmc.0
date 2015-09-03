From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFC PATCH] mmc: block: Add new ioctl to send combo commands
Date: Thu, 3 Sep 2015 16:10:18 +0100
Message-ID: <55E862DA.1080509@nvidia.com>
References: <1441203711-19538-1-git-send-email-jonathanh@nvidia.com>
 <CAOesGMh9d6yX-dS6jg2eu2hvN5S=87rr7L-+ZUreX=GGHDxRaA@mail.gmail.com>
 <CANEJEGsb=bSyqYW6K5eXr8PwUrJxokOHz894ofk4F-SRohGeQQ@mail.gmail.com>
 <CANEJEGvRSDFjrVPMN=3d2yEK=d1eQYQgvAynw75Qj2fcPdrq7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANEJEGvRSDFjrVPMN=3d2yEK=d1eQYQgvAynw75Qj2fcPdrq7Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Grant Grundler <grundler@google.com>, Olof Johansson <olof@lixom.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Olof Johansson <olofj@chromium.org>, Seshagiri Holi <sholi@nvidia.com>
List-Id: linux-mmc@vger.kernel.org


On 02/09/15 23:08, Grant Grundler wrote:
> [resending text-only]
> 
> On Wed, Sep 2, 2015 at 3:07 PM, Grant Grundler <grundler@google.com> wrote:
>>
>>
>> On Wed, Sep 2, 2015 at 11:28 AM, Olof Johansson <olof@lixom.net> wrote:
>> ...
>>>> +/**
>>>> + * struct mmc_ioc_combo_cmd - combo command information
>>>> + * @num_of_cmds: number of commands to send
>>>> + * @mmc_ioc_cmd_list: pointer to list of commands
>>>> + */
>>>> +struct mmc_ioc_combo_cmd {
>>>> +       uint8_t num_of_cmds;
>>>> +       struct mmc_ioc_cmd *mmc_ioc_cmd_list;
>>>> +};
>>>
>>> The size of this struct will depend on the pointer size of userspace.
>>>
>>> It might be better to use a u64 for the pointer instead. Otherwise
>>> you'd need a compat ioctl wrapper to copy a 32-bit pointer over on a
>>> 64-bit kernel.
>>
>> If alignment matters, then maybe swap the fields?
>> Or declare num_of_cmds as u64 as well?

Thanks. I did swap them in the updated version as this seems to make
sense. However, I left num_of_cmds as an 8-bit value unless someone has
a need for more than 256 commands ;-)

Jon
