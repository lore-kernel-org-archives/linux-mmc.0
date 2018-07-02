From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix card threshold control configuration
Date: Mon, 2 Jul 2018 10:00:20 -0700
Message-ID: <CAD=FV=VBQOeaFGnJBBmVtYZjoJo1WdkwkPFaVJ=zr+C=N9iqQw@mail.gmail.com>
References: <1527590335-171787-1-git-send-email-xiaqing17@hisilicon.com>
 <CAPDyKFo7FP5bL8doK3P749Rcyzh_H-3SzG+GZVJb2pp9j_ZH_A@mail.gmail.com> <08a08d60-8176-df54-ff0e-ffc195f40d6c@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <08a08d60-8176-df54-ff0e-ffc195f40d6c@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Evgeniy Didin <Evgeniy.Didin@synopsys.com>, Jaehoon Chung <jh80.chung@samsung.com>, Qing Xia <xiaqing17@hisilicon.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi,

On Mon, Jun 11, 2018 at 7:17 AM, Shawn Lin <shawn.lin@rock-chips.com> wrote:
> On 2018/6/11 20:20, Ulf Hansson wrote:
>>
>> + Shawn Lin, Evgeniy Didin, Doug Andersson
>>
>> On 29 May 2018 at 12:38, Qing Xia <xiaqing17@hisilicon.com> wrote:
>>>
>>> From: x00270170 <xiaqing17@hisilicon.com>
>>>
>>> Card write threshold control is supposed to be set since controller
>>> version 2.80a for data write in HS400 mode and data read in
>>> HS200/HS400/SDR104 mode. However the current code returns without
>>> configuring it in the case of data writing in HS400 mode.
>>> Meanwhile the patch fixes that the current code goes to
>>> 'disable' when doing data reading in HS400 mode.
>>>
>
> I'm more or less unable to review this, as I don't have 2.80a databook,
> nor a such platform to verify it. :(

Sorry for not responding earlier.  I didn't have a lot of context here
so reviewing it never made it to the top of my queue.  ...but quickly
checking what I can...

I'm in almost the same boat as Shawn.  I don't have any HS400 hardware
using dw_mmc available to me, but I do seem to have the 2.80a databook
hanging around and it agrees that we need to enable the card write
threshold for HS400 writes.  That also matches the comments, so the
patch seems right to me.  Probably Jaehoon would make a better
reviewer since he submitted the original code and also has more
familiarity with HS400 on dw_mmc.

I don't think I have enough context to give a full Reviewed-by, but in
the very least I can confirm that the patch seems sane.

-Doug
