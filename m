From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v5 02/12] mmc: mediatek: add support of mt2701/mt2712
Date: Mon, 16 Oct 2017 09:49:33 +0200
Message-ID: <a506506b-a326-6d54-9827-4fd82680700d@gmail.com>
References: <1507689696-25928-1-git-send-email-chaotian.jing@mediatek.com>
 <1507689696-25928-3-git-send-email-chaotian.jing@mediatek.com>
 <1508055978.8978.5.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:56505 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751180AbdJPHth (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Oct 2017 03:49:37 -0400
In-Reply-To: <1508055978.8978.5.camel@mtksdaap41>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: CK Hu <ck.hu@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, srv_heupstream@mediatek.com, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, yong mao <yong.mao@mediatek.com>, Phong LE <ple@baylibre.com>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Heiner Kallweit <hkallweit1@gmail.com>



On 10/15/2017 10:26 AM, CK Hu wrote:
> Hi, Chaotian:
> 
> On Wed, 2017-10-11 at 10:41 +0800, Chaotian Jing wrote:
>> mt2701/mt2712 has 12bit clock div, which is not compatible with
>> mt8135/mt8173. and, some additional features will be added in
>> mt2701/mt2712, so that need distinguish it by comatibale name.
>>
>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>> ---
>>   drivers/mmc/host/mtk-sd.c | 82 +++++++++++++++++++++++++++++++++++++++--------
>>   1 file changed, 69 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
>> index 267f7ab..643c795 100644
>> --- a/drivers/mmc/host/mtk-sd.c
>> +++ b/drivers/mmc/host/mtk-sd.c
[...]
>> @@ -350,6 +358,31 @@ struct msdc_host {
>>   	struct msdc_tune_para saved_tune_para; /* tune result of CMD21/CMD19 */
>>   };
>>   
>> +static const struct mtk_mmc_compatible mt8135_compat = {
>> +	.clk_div_bits = 8,
>> +};
>> +
>> +static const struct mtk_mmc_compatible mt8173_compat = {
>> +	.clk_div_bits = 8,
>> +};
>> +
>> +static const struct mtk_mmc_compatible mt2701_compat = {
>> +	.clk_div_bits = 12,
>> +};
>> +
>> +static const struct mtk_mmc_compatible mt2712_compat = {
>> +	.clk_div_bits = 12,
>> +};
>> +
>> +static const struct of_device_id msdc_of_ids[] = {
>> +	{ .compatible = "mediatek,mt8135-mmc", .data = &mt8135_compat},
>> +	{ .compatible = "mediatek,mt8173-mmc", .data = &mt8173_compat},
> 
> Because mt8135_compat is equal to mt8173_compat, so I think the
> compatible of "mediatek,mt8173-mmc" is redundant. You could just keep
> compatible of "mediatek,mt8135-mmc" in driver, and use
> "mediatek,mt8135-mmc" for both mt8135.dtsi and mt8173.dtsi.
> 

Well thing is, that in the follow-up patches, new data types get added to the 
different compat structures and in the end all four a different.

>> +	{ .compatible = "mediatek,mt2701-mmc", .data = &mt2701_compat},
>> +	{ .compatible = "mediatek,mt2712-mmc", .data = &mt2712_compat},
> 
> Ditto.
> 

Same here.

Regards,
Matthias
