From: Grant Grundler <grundler@google.com>
Subject: Re: [PATCH] mmc: block: Add new ioctl to send multi commands
Date: Thu, 10 Sep 2015 13:26:20 -0700
Message-ID: <CANEJEGuPm_PdBb39iCOdCcSKVMUi3jpiPb_Jgp951xyJvp_3rg@mail.gmail.com>
References: <1441811161-18513-1-git-send-email-jonathanh@nvidia.com>
	<1481090.IIYrKtDeR0@wuerfel>
	<55F06206.9040001@nvidia.com>
	<3546402.HsxrhMD6nc@wuerfel>
	<55F13E33.9000703@nvidia.com>
	<CANEJEGsMM8c4fmSaZDzL59re99aNJk_qjo-10_UoD7josA6MDg@mail.gmail.com>
	<55F1CA06.3020904@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55F1CA06.3020904@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Olof Johansson <olofj@chromium.org>, Seshagiri Holi <sholi@nvidia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, Sep 10, 2015 at 11:20 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 10/09/15 18:10, Grant Grundler wrote:
...
>>>>>> struct mmc_ioc_multi_cmd {
>>>>>>     __u64 num_of_cmds;
>>>>>>     struct mmc_ioc_cmd cmds[0];
>>>>>> };
>>
>> I think this would work just as well. But doesn't "pointer to an
>> array" require 32-bit ioctl compat handling?
>> We were trying to avoid a 32-bit user space compatibility handler.
>
> I think that this is fine as it is a zero length array [0] and not a
> pointer.

Doh, yes. Thanks for correcting. I knew this was a gcc special but
forgot it's not actually allocating any space.

cheers,
grant

>
> Cheers
> Jon
>
> [0] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
