From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4] mmc: dw_mmc: add support for the other bit of sdio
 interrupt
Date: Fri, 14 Nov 2014 22:25:53 +0900
Message-ID: <546602E1.3080800@samsung.com>
References: <1414977633-3196-1-git-send-email-addy.ke@rock-chips.com>
 <1415109789-7046-1-git-send-email-addy.ke@rock-chips.com>
 <CAD=FV=XGjDZRBw7re8aRHdzNAq5cmtfpZ5RMdQ7o1CzbFMVXjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-reply-to: <CAD=FV=XGjDZRBw7re8aRHdzNAq5cmtfpZ5RMdQ7o1CzbFMVXjw@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Addy Ke <addy.ke@rock-chips.com>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Randy Dunlap <rdunlap@infradead.org>, Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Dinh Nguyen <dinguyen@altera.com>, =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Olof Johansson <olof@lixom.net>, Sonny Rao <sonnyrao@chromium.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, zhenf
List-Id: linux-mmc@vger.kernel.org

On 11/14/2014 03:58 AM, Doug Anderson wrote:
> Addy,
> 
> On Tue, Nov 4, 2014 at 6:03 AM, Addy Ke <addy.ke@rock-chips.com> wrote:
>> The bit of sdio interrupt is 16 in designware implementation,
>> but it is 24 on Rockchip SoCs.This patch add sdio_id0 for the
>> number of slot0 in the SDIO interrupt registers.
>>
>> Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
>> ---
>> Changes in v2:
>> - rebase on http://git.linaro.org/git/people/ulf.hansson/mmc.git, next branch
>> Changes in v3:
>> - Remove dts for sdio_id0, just replace this with 8, suggested by Doug
>> - Change to support all Rockchip Socs, suggested by Heiko
>> Changes in v4:
>> - use init-hook to set sdio_id0, suggested by Jaehoon
>>
>>  drivers/mmc/host/dw_mmc-rockchip.c | 10 ++++++++++
>>  drivers/mmc/host/dw_mmc.c          | 12 +++++++-----
>>  drivers/mmc/host/dw_mmc.h          |  2 ++
>>  include/linux/mmc/dw_mmc.h         |  3 +++
>>  4 files changed, 22 insertions(+), 5 deletions(-)
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> 

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung


