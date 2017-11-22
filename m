From: Pintu Kumar <pintu.ping@gmail.com>
Subject: Re: [tegra186]: emmc resume failing after booting from snapshot image
Date: Wed, 22 Nov 2017 22:09:33 +0530
Message-ID: <CAOuPNLhjthNSnX+iq1oCx+AB6wJAaPxN7Yivxka3esSTi9shag@mail.gmail.com>
References: <CAOuPNLjWvqvcb+eDp52GsXEfvtzAcTneUxGhQc9bPWYGsqxpEQ@mail.gmail.com>
 <d2b3b1e3-dd08-2aad-c027-2c51e4b72459@kapsi.fi> <b607c51f-559e-0315-6843-c0d9d07cb81e@nvidia.com>
 <CAOuPNLgW84yuXxm8HLQ7KS-1=0nPo9s7OumWt4ipkm7D2pdmog@mail.gmail.com> <b0729c10-601f-d609-b807-a87b4bed4e59@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b0729c10-601f-d609-b807-a87b4bed4e59@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <cyndis@kapsi.fi>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org, Pintu Kumar <pintu.ping@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Wed, Nov 22, 2017 at 9:45 PM, Jon Hunter <jonathanh@nvidia.com> wrote:
>
> On 22/11/17 12:26, Pintu Kumar wrote:
>> Hello Jon,
>> Yes I raised my query there almost 1 week back here.
>> https://devtalk.nvidia.com/default/topic/1026527/jetson-tx2/-jetson-tx2-mmc-resume-errors-after-booting-from-suspend/
>>
>> But no response.
>> So, I thought to discuss it here.
>> May be some pointers may help to find the root cause.
>> One point is that, I am able to resume the board with the sd-card, but
>> resume from emmc is returning -110 (may be CMD5 timeout).
>> Whether there is any difference between sd-card resume and emmc resume ?
>> Do we need to check the card initialization sequence for emmc ?
> OK great. There should be a team looking at these so please bare with

Ok thanks. Can you put your comments there, so that somebody can start
responding.
It will be really helpful.
I have already sent the reminder, but still no response.
I know it will be difficult to debug like this, but at least some
pointers or support will definitely help.
Basically I wanted to know, if there is any problem from SoC side
itself, or it is specific to emmc driver issue.
Because, with the kernel 4.4 (and our internal patches), other SoC
(such as hikey), it is working fine.

> them. I noticed that you did not state which release you are using for
> TX2 and there are two available (r27 and r28.1 [0]), unless I missed it.
> So it is worth stating the release you are using.
>

I am using tegra-l4t-r27.1 release, and on top of that we have our
internal patches for snapshot image.
However, I also compared with r28 repo under drivers/mmc/*
There were not major difference. Still I tried to manually apply few
of the changes to r27, but it still it did not help much.
That is the reason I thought to discuss, so that somebody can point
me, if I am missing any right fixes.
Because from r27 to r28, with our internal patches is again a painful task.
So first I wanted to make sure if some patches backing from r28 works,
then I can recommend to upgrade to r28.

> What command are you using to suspend to disk?

Its actually our internal command, something like:
# echo snap > /sys/power/state
This internally create our snapshot image and save it on disk.
Then we boot the system normally with this image.
Note: currently to debug the emmc issue, we are right now booting with sd-card.


>

> Cheers
> Jon
>
> [0] https://developer.nvidia.com/embedded/linux-tegra-archive
> --
> nvpublic
