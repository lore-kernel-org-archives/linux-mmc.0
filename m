From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] mmc: sdhci-xenon: Mark expected switch fall-through
Date: Wed, 13 Feb 2019 12:13:26 -0600
Message-ID: <657aa413-f36e-8b5b-edd2-756edd24b74c@embeddedor.com>
References: <20190212152558.GA21933@embeddedor>
 <CAPDyKFrP3GX16EXQTjCa1ThfF-jzWM-JdtvY6TOqo8LBCJ2bbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrP3GX16EXQTjCa1ThfF-jzWM-JdtvY6TOqo8LBCJ2bbw@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Hu Ziji <huziji@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kees Cook <keescook@chromium.org>
List-Id: linux-mmc@vger.kernel.org



On 2/13/19 2:35 AM, Ulf Hansson wrote:
> On Tue, 12 Feb 2019 at 16:26, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> In preparation to enabling -Wimplicit-fallthrough, mark switch
>> cases where we are expecting to fall through.
>>
>> This patch fixes the following warning:
>>
>> drivers/mmc/host/sdhci-xenon-phy.c: In function ‘xenon_emmc_phy_slow_mode’:
>> drivers/mmc/host/sdhci-xenon-phy.c:527:47: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>    if ((priv->init_card_type == MMC_TYPE_SDIO) ||
>>        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~
>>        params->slow_mode) {
>>        ~~~~~~~~~~~~~~~~~
>> drivers/mmc/host/sdhci-xenon-phy.c:534:2: note: here
>>   default:
>>   ^~~~~~~
>>
>> Warning level 3 was used: -Wimplicit-fallthrough=3
>>
>> Notice that, in this particular case, the code comment is modified
>> in accordance with what GCC is expecting to find.
>>
>> This patch is part of the ongoing efforts to enable
>> -Wimplicit-fallthrough.
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> 
> Applied for next - and by cleaning up the somewhat noisy change log, thanks!
> 

Great.

Thanks, Uffe.

--
Gustavo
