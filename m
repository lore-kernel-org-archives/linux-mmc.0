From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix card threshold control configuration
Date: Mon, 2 Jul 2018 15:16:32 +0200
Message-ID: <CAPDyKFrLY=rH+xaYSd=Qr72BVtk0UPeHkY4s0GTeU+0NHks-zg@mail.gmail.com>
References: <1527590335-171787-1-git-send-email-xiaqing17@hisilicon.com> <CAPDyKFo7FP5bL8doK3P749Rcyzh_H-3SzG+GZVJb2pp9j_ZH_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFo7FP5bL8doK3P749Rcyzh_H-3SzG+GZVJb2pp9j_ZH_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Evgeniy Didin <Evgeniy.Didin@synopsys.com>, Doug Anderson <dianders@chromium.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Qing Xia <xiaqing17@hisilicon.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 11 June 2018 at 14:20, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> + Shawn Lin, Evgeniy Didin, Doug Andersson
>
> On 29 May 2018 at 12:38, Qing Xia <xiaqing17@hisilicon.com> wrote:
>> From: x00270170 <xiaqing17@hisilicon.com>
>>
>> Card write threshold control is supposed to be set since controller
>> version 2.80a for data write in HS400 mode and data read in
>> HS200/HS400/SDR104 mode. However the current code returns without
>> configuring it in the case of data writing in HS400 mode.
>> Meanwhile the patch fixes that the current code goes to
>> 'disable' when doing data reading in HS400 mode.
>>
>> Signed-off-by: Qing Xia <xiaqing17@hisilicon.com>
>
> This looks good to me. However, it seems like Jaehoon has been busy,
> no response yet.
>
> I have looped in a few more people to see if they thinks this makes sense.

It sounds this should be a fix for regression (also confirmed
off-list). Could you please resend and by adding a fixes tag?

In the meantime, I have applied this for my next branch, as to get it
tested. I can move it later to fixes if needed.

[...]

Kind regards
Uffe
