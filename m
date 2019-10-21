From: Jianxin Pan <jianxin.pan@amlogic.com>
Subject: Re: [PATCH] mmc: fix mmc dma operation
Date: Mon, 21 Oct 2019 16:23:57 +0800
Message-ID: <a322d35b-28de-acb9-842c-ac64ba40e9b8@amlogic.com>
References: <1571637541-119016-1-git-send-email-jianxin.pan@amlogic.com>
 <fc1f61e1-b156-11e6-3f21-c498d2f0a8c6@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fc1f61e1-b156-11e6-3f21-c498d2f0a8c6@baylibre.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Armstrong <narmstrong@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@baylibre.com>
Cc: Nan Li <nan.li@amlogic.com>, Jerome Brunet <jbrunet@baylibre.com>, linux-amlogic@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Victor Wan <victor.wan@amlogic.com>
List-Id: linux-mmc@vger.kernel.org

Hi Neil,

Thanks for the review, I will update the subject and commit message in the next version.

On 2019/10/21 15:57, Neil Armstrong wrote:
> Hi,
> 
> Thanks for the fix.
> 
> First, you should add "mmc: meson-gx:" in the subject.
> 
> On 21/10/2019 07:59, Jianxin Pan wrote:
>> From: Nan Li <nan.li@amlogic.com>
>>
>> In MMC dma transfer, the region requested by dma_map_sg() may be released
>> by dma_unmap_sg() before the transfer is completed.
>>
>> Put the unmap operation in front of mmc_request_done() to avoid this.
> 
> 
> You should add a "Fixes:" tag so it can be backported on stable kernels.
> 
>>
>> Signed-off-by: Nan Li <nan.li@amlogic.com>
>> Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
>> ---
>>  drivers/mmc/host/meson-gx-mmc.c | 15 ++++++++-------
>>  1 file changed, 8 insertions(+), 7 deletions(-)
>>
[...]
>>  }
>>  
>>  static void meson_mmc_read_resp(struct mmc_host *mmc, struct mmc_command *cmd)
>>
> Neil
> 
> .
> 
