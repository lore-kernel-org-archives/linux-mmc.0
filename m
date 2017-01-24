From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3 2/3] dts: mediatek: configure some fixed mmc parameters
Date: Tue, 24 Jan 2017 11:36:48 +0100
Message-ID: <e4fc97fa-b898-e838-56db-0dc5079a2e95@gmail.com>
References: <1484821156-20565-1-git-send-email-yong.mao@mediatek.com>
 <1484821156-20565-3-git-send-email-yong.mao@mediatek.com>
 <CAPDyKFrHCy7bLb-wDRWpELAB5VxPc4tjyWKd31YufEZC_AQtVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36448 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdAXKgx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 24 Jan 2017 05:36:53 -0500
In-Reply-To: <CAPDyKFrHCy7bLb-wDRWpELAB5VxPc4tjyWKd31YufEZC_AQtVA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Yong Mao <yong.mao@mediatek.com>
Cc: srv_heupstream <srv_heupstream@mediatek.com>, Linus Walleij <linus.walleij@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mediatek@lists.infradead.org, Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Huang <eddie.huang@mediatek.com>, Chaotian Jing <chaotian.jing@mediatek.com>

Hi Ulf,

On 01/20/2017 08:59 AM, Ulf Hansson wrote:
> On 19 January 2017 at 11:19, Yong Mao <yong.mao@mediatek.com> wrote:
>> From: yong mao <yong.mao@mediatek.com>
>>
>> configure some fixed mmc parameters
>>
>> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
>> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
>
> Please change the prefix of the commit message header to "ARM64: dts: mt8173:".
>
> Also make sure you send this to the ARM mailing list as well.
>
> In general, I think it's better DTS changes go via the ARM SoC tree,
> but I can pick it up if it's trivial and I get an ack from the SoC
> maintainer.
>

I can take them through my tree, let's wait at Rob's opinion of v4.

Regards,
Matthias

>> ---
>>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts |    3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> index 0ecaad4..403705e 100644
>> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
>> @@ -134,6 +134,9 @@
>>         bus-width = <8>;
>>         max-frequency = <50000000>;
>>         cap-mmc-highspeed;
>> +       mtk-hs200-cmd-int-delay=<26>;
>> +       mtk-hs400-cmd-int-delay=<14>;
>> +       mtk-hs400-cmd-resp-sel=<0>; /* 0:rising, 1:falling */
>>         vmmc-supply = <&mt6397_vemc_3v3_reg>;
>>         vqmmc-supply = <&mt6397_vio18_reg>;
>>         non-removable;
>> --
>> 1.7.9.5
>>
>
> Kind regards
> Uffe
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
