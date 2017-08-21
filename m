From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 1/4] mmc: sdhci-cadence: add suspend / resume support
Date: Mon, 21 Aug 2017 21:29:27 +0900
Message-ID: <CAK7LNARiqFiJroxASQ2bPcigRftbU95rX5qsD5NiXWj8X_uNSA@mail.gmail.com>
References: <1502811922-9346-1-git-send-email-yamada.masahiro@socionext.com>
 <1502811922-9346-2-git-send-email-yamada.masahiro@socionext.com> <3b04eeee-2e29-b7d5-cef0-1dffbdf28def@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3b04eeee-2e29-b7d5-cef0-1dffbdf28def@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Piotr Sroka <piotrs@cadence.com>, Hu Ziji <huziji@marvell.com>, Christian Daudt <csd@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Zhangfei Gao <zhangfei.gao@marvell.com>, Kevin Hao <haokexin@gmail.com>, Olof Johansson <olof@lixom.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Adrian,


2017-08-21 20:48 GMT+09:00 Adrian Hunter <adrian.hunter@intel.com>:

>> +static int sdhci_cdns_resume(struct device *dev)
>> +{
>> +     struct sdhci_host *host = dev_get_drvdata(dev);
>> +     struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>> +     struct sdhci_cdns_priv *priv = sdhci_pltfm_priv(pltfm_host);
>> +     int ret;
>> +
>> +     ret = clk_prepare_enable(pltfm_host->clk);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = sdhci_cdns_phy_init(priv);
>> +     if (ret)
>> +             return ret;
>
> Perhaps clk_disable_unprepare(pltfm_host->clk)
>
>> +
>> +     return sdhci_resume_host(host);
>
> Ditto on error.

Thanks.

Maybe 3/4 should be fixed as well.




-- 
Best Regards
Masahiro Yamada
