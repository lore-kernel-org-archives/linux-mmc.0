From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH] mmc: block: Add new ioctl to send multi commands
Date: Thu, 10 Sep 2015 09:24:19 +0100
Message-ID: <55F13E33.9000703@nvidia.com>
References: <1441811161-18513-1-git-send-email-jonathanh@nvidia.com>
 <1481090.IIYrKtDeR0@wuerfel> <55F06206.9040001@nvidia.com>
 <3546402.HsxrhMD6nc@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3546402.HsxrhMD6nc@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, grundler@google.com, olofj@chromium.org, Seshagiri Holi <sholi@nvidia.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Arnd,

On 09/09/15 21:22, Arnd Bergmann wrote:
> On Wednesday 09 September 2015 17:44:54 Jon Hunter wrote:
>>
>> On 09/09/15 16:56, Arnd Bergmann wrote:
>>> On Wednesday 09 September 2015 16:06:01 Jon Hunter wrote:
>>>> +
>>>> +       idata = kcalloc(mcci.num_of_cmds, sizeof(*idata), GFP_KERNEL);
>>>> +       if (!idata) {
>>>> +               err = -ENOMEM;
>>>> +               goto cmd_err;
>>>> +       }
>>>> +
>>>> +       cmds = (struct mmc_ioc_cmd __user *)(unsigned long)mcci.cmds_ptr;
>>>> +       for (n_cmds = 0; n_cmds < mcci.num_of_cmds; n_cmds++) {
>>>> +               idata[n_cmds] = mmc_blk_ioctl_copy_from_user(&cmds[n_cmds]);
>>>> +               if (IS_ERR(idata[n_cmds])) {
>>>> +                       err = PTR_ERR(idata[n_cmds]);
>>>> +                       goto cmd_err;
>>>> +               }
>>>> +       }
>>>> +
>>>
>>> You have no upper bound on the number of commands, which means you end
>>> up catching overly large arguments only through -ENOMEM. Can you come
>>> up with an upper bound that is guaranteed to succeed with the allocation?
>>
>> The uint8 type would limit you to 256 commands (if you have the memory),
>> although admittedly that is probably overkill.
> 
> Good point.
> 
> Please note a few details here:
> 
> - in uabi headers, we need to use __u8 instead of uint8, because we cannot
>   rely on libc header file inclusion for kernel headers.

Ok.

> - you have some implicit padding after the structure and should replace that
>   with explictit pad bytes to extend the structure to a multiple of its
>   alignment (8 bytes).

Would padding with __u32 at the end be sufficient here? I assume the
__u32 would be 32-bit aligned. However, was not sure if this would
always be the case.

>>>> +struct mmc_ioc_multi_cmd {
>>>> +       __u64 cmds_ptr;
>>>> +       uint8_t num_of_cmds;
>>>> +};
>>>  
>>> complex commands are always nasty in one way or another. Can you describe
>>> in the patch description why you picked an indirect pointer over something
>>> like
>>>
>>> struct mmc_ioc_multi_cmd {
>>> 	__u64 num_of_cmds;
>>> 	struct mmc_ioc_cmd cmds[0];
>>> };
>>>
>>> as I said, both are ugly. My first choice would have been the other one,
>>> but I'm sure you have some reasons yourself.
>>
>> It was a suggestion from Olof to ensure the structure size is constant for
>> both 32-bit and 64-bit userspaces. I am not sure if it is worth adding a
>> macro similar to the below for this?
>>
>> #define mmc_ioc_cmd_set_data(ic, ptr) ic.data_ptr = (__u64)(unsigned long) ptr
>>
>> However, yes can update the changelog.
> 
> I was not referring to the use of an __u64 variable to pass a pointer, that
> is expected (and the macro would make it harder to understand).
> 
> What I meant instead was the use of a pointer to an array as opposed to
> passing the array itself. With the definition I gave above, the size would
> still be the same on all architectures (you can replace the __u64 with
> an __u8 plus padding if you like), as sizeof(struct mmc_ioc_multi_cmd)
> is just '8' here.

Do you have any strong preference here? I guess I don't and agree
neither are ideal.

> Alternatively, you could just use an array of struct mmc_ioc_cmd by
> itself and encode the length in the ioctl command:
> 
> #define MMC_COMBO_IOC_CMD(n) _IOC(_IOC_READ|_IOC_WRITE, 1, sizeof(struct mmc_ioc_cmd) * (n))
> 
> This is of course also ugly because the ioctl command number is not
> fixed, and because the limit for the number of mmc command blocks
> is architecture dependent, depending on the definition of the _IOC
> macro that can have either 13 or 14 bits to encode the argument length
> in bytes.

Interesting idea. However, given your comments above, I think that I
would rather place the size in the structure.

Cheers
Jon
