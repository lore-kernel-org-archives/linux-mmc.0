From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v1] mmc: sdhci-of-esdhc: fix the mmc error after sleep on ls1046ardb
Date: Thu, 30 Nov 2017 14:04:34 +0100
Message-ID: <CAPDyKFpy=-YJZAL7Xzitrr1w-McVziSMp0Hq8=JfdvSou_i=8Q@mail.gmail.com>
References: <20171128035706.16939-1-yinbo.zhu@nxp.com> <f550c0ad-7505-e553-e88d-eb8605659e7b@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:42504 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbdK3NEf (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 30 Nov 2017 08:04:35 -0500
Received: by mail-it0-f68.google.com with SMTP id p139so8220592itb.1
        for <linux-mmc@vger.kernel.org>; Thu, 30 Nov 2017 05:04:35 -0800 (PST)
In-Reply-To: <f550c0ad-7505-e553-e88d-eb8605659e7b@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yinbo.zhu@nxp.com
Cc: Xiaobo Xie <xiaobo.xie@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, Yangbo Lu <yangbo.lu@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Yinbo,

On 30 November 2017 at 11:44, Adrian Hunter <adrian.hunter@intel.com> wrote=
:
> On 28/11/17 05:57, yinbo.zhu@nxp.com wrote:
>> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
>>
>> When system wakes up from sleep on ls1046ardb, the SD operation fails
>> with mmc error messages since ESDHC_TB_EN bit couldn=E2=80=99t be cleane=
d by
>> eSDHC_SYSCTL[RSTA]. It's proper to clean this bit in esdhc_reset()
>> rather than in probe.
>>
>> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
>
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

This one was rejected by patchwork. Could you please sort out the
problem and re-submit it.

Kind regards
Uffe

>
>> ---
>>  drivers/mmc/host/sdhci-of-esdhc.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-=
of-esdhc.c
>> index ac2505a95403..5ee0d86a2f4d 100644
>> --- a/drivers/mmc/host/sdhci-of-esdhc.c
>> +++ b/drivers/mmc/host/sdhci-of-esdhc.c
>> @@ -578,10 +578,18 @@ static void esdhc_clock_enable(struct sdhci_host *=
host, bool enable)
>>
>>  static void esdhc_reset(struct sdhci_host *host, u8 mask)
>>  {
>> +     u32 val;
>> +
>>       sdhci_reset(host, mask);
>>
>>       sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
>>       sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
>> +
>> +     if (mask & SDHCI_RESET_ALL) {
>> +             val =3D sdhci_readl(host, ESDHC_TBCTL);
>> +             val &=3D ~ESDHC_TB_EN;
>> +             sdhci_writel(host, val, ESDHC_TBCTL);
>> +     }
>>  }
>>
>>  /* The SCFG, Supplemental Configuration Unit, provides SoC specific
>> @@ -771,10 +779,6 @@ static void esdhc_init(struct platform_device *pdev=
, struct sdhci_host *host)
>>       pltfm_host =3D sdhci_priv(host);
>>       esdhc =3D sdhci_pltfm_priv(pltfm_host);
>>
>> -     val =3D sdhci_readl(host, ESDHC_TBCTL);
>> -     val &=3D ~ESDHC_TB_EN;
>> -     sdhci_writel(host, val, ESDHC_TBCTL);
>> -
>>       host_ver =3D sdhci_readw(host, SDHCI_HOST_VERSION);
>>       esdhc->vendor_ver =3D (host_ver & SDHCI_VENDOR_VER_MASK) >>
>>                            SDHCI_VENDOR_VER_SHIFT;
>>
>
