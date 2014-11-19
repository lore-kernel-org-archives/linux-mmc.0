From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: Add support for IMG Pistachio
Date: Wed, 19 Nov 2014 10:26:29 +0900
Message-ID: <546BF1C5.3050000@samsung.com>
References: <1415904621-26800-1-git-send-email-abrestic@chromium.org>
 <CAD=FV=WZx6r5L76Bfn2L8WeSU4hKwNJ=tZq_FoT3ot1Hd2ToeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <CAD=FV=WZx6r5L76Bfn2L8WeSU4hKwNJ=tZq_FoT3ot1Hd2ToeQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>, Andrew Bresticker <abrestic@chromium.org>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, James Hartley <James.Hartley@imgtec.com>, Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 11/19/2014 02:28 AM, Doug Anderson wrote:
> Andrew,
> 
> On Thu, Nov 13, 2014 at 10:50 AM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>> Add support for the DW MMC host found on the Imagination Pistachio SoC.
>> Like the DW MMC hosts found on SOCFPGA and Rockchip SoCs, the DW MMC
>> host on Pistachio requires the use of SDMMC_CMD_USE_HOLD_REG.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>>  .../devicetree/bindings/mmc/img-dw-mshc.txt        | 29 ++++++++++++++++++++++
>>  drivers/mmc/host/dw_mmc-pltfm.c                    |  6 +++++
>>  2 files changed, 35 insertions(+)
> 
> This seems quite sane to me.
> 
> Reviewed-by: Doug Anderson <dianders@chromium.org>

Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

Best Regards,
Jaehoon Chung
> 
