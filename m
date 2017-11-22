From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [tegra186]: emmc resume failing after booting from snapshot image
Date: Wed, 22 Nov 2017 16:15:58 +0000
Message-ID: <b0729c10-601f-d609-b807-a87b4bed4e59@nvidia.com>
References: <CAOuPNLjWvqvcb+eDp52GsXEfvtzAcTneUxGhQc9bPWYGsqxpEQ@mail.gmail.com>
 <d2b3b1e3-dd08-2aad-c027-2c51e4b72459@kapsi.fi>
 <b607c51f-559e-0315-6843-c0d9d07cb81e@nvidia.com>
 <CAOuPNLgW84yuXxm8HLQ7KS-1=0nPo9s7OumWt4ipkm7D2pdmog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAOuPNLgW84yuXxm8HLQ7KS-1=0nPo9s7OumWt4ipkm7D2pdmog@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pintu Kumar <pintu.ping@gmail.com>
Cc: Mikko Perttunen <cyndis@kapsi.fi>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 22/11/17 12:26, Pintu Kumar wrote:
> Hello Jon,
> Yes I raised my query there almost 1 week back here.
> https://devtalk.nvidia.com/default/topic/1026527/jetson-tx2/-jetson-tx2-mmc-resume-errors-after-booting-from-suspend/
> 
> But no response.
> So, I thought to discuss it here.
> May be some pointers may help to find the root cause.
> One point is that, I am able to resume the board with the sd-card, but
> resume from emmc is returning -110 (may be CMD5 timeout).
> Whether there is any difference between sd-card resume and emmc resume ?
> Do we need to check the card initialization sequence for emmc ?
OK great. There should be a team looking at these so please bare with
them. I noticed that you did not state which release you are using for
TX2 and there are two available (r27 and r28.1 [0]), unless I missed it.
So it is worth stating the release you are using.

What command are you using to suspend to disk?

Cheers
Jon

[0] https://developer.nvidia.com/embedded/linux-tegra-archive
-- 
nvpublic
