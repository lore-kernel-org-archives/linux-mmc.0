From: Stefan Wahren <stefan.wahren@i2se.com>
Subject: Re: [PATCH 1/2] mmc: bcm2835: reset host on timeout
Date: Wed, 14 Feb 2018 17:49:31 +0100
Message-ID: <ecf8dd61-ab16-b298-d197-ea93ecf5982b@i2se.com>
References: <97593d6e1a41af1baff61f7d9e6e68a450fc9da6.1518619058.git.msuchanek@suse.de>
 <1fbf0d77-cb53-f0fa-b810-e9954138d907@i2se.com>
 <20180214163649.3a0c9476@kitsune.suse.cz>
 <20180214165827.386b9bb1@kitsune.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180214165827.386b9bb1@kitsune.suse.cz>
Content-Language: de-DE
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>, Phil Elwell <phil@raspberrypi.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, bcm-kernel-feedback-list@broadcom.com, Eric Anholt <eric@anholt.net>, Gerd Hoffmann <kraxel@redhat.com>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, Julia Lawall <Julia.Lawall@lip6.fr>, linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Hi Michal,

[add Phil]

Am 14.02.2018 um 17:13 schrieb Michal Suchánek:
> On Wed, 14 Feb 2018 16:36:49 +0100
> Michal Suchánek <msuchanek@suse.de> wrote:
>
>> On Wed, 14 Feb 2018 15:58:31 +0100
>> Stefan Wahren <stefan.wahren@i2se.com> wrote:
>>
>>> Hi Michal,
>>>
>>> Am 14.02.2018 um 15:38 schrieb Michal Suchanek:  
>>>> The bcm2835 mmc host tends to lock up for unknown reason so reset
>>>> it on timeout. The upper mmc block layer tries retransimitting
>>>> with single blocks which tends to work out after a long wait.
>>>>
>>>> This is better than giving up and leaving the machine broken for
>>>> no obvious reason.    
>>> could you please provide more information about this issue (affected
>>> hardware, kernel config, version, dmesg, reproducible scenario)?
>>>   
> It tends to reproduce when upgrading a few packages with zypper and
> otherwise at random during system operation. It seems that for my card
> it worsens with age to some degree so perhaps it depends on the
> fragmentation of the internal card flash.
>
> Attaching dmesg and kernel config.

do you noticed this issue before 4.15-rc4?

Could you please test with 4.15 final again?

What kind of SD card (name) triggers the issue?

Thanks Stefan

>
> Thanks
>
> Michal
