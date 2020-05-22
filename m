Return-Path: <SRS0=PvXF=7E=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F2EC433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 15:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA32205CB
	for <linux-mmc@archiver.kernel.org>; Fri, 22 May 2020 15:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="d+hHBwcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729931AbgEVPLr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 22 May 2020 11:11:47 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7392 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729929AbgEVPLq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 22 May 2020 11:11:46 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec7eba60001>; Fri, 22 May 2020 08:11:34 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 May 2020 08:11:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 May 2020 08:11:46 -0700
Received: from [10.2.164.184] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 May
 2020 15:11:46 +0000
Subject: Re: [PATCH] sdhci: tegra: Avoid reading autocal timeout values when
 not applicable
To:     Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <jonathanh@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
References: <1590005337-1087-1-git-send-email-skomatineni@nvidia.com>
 <20200522122644.GE2163848@ulmo>
 <95d01fae-bf1f-28d1-2d11-8f5693646fa3@gmail.com>
 <20200522125230.GH2163848@ulmo>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <e574c225-aa2a-7431-6ea8-2d2f1e7dd384@nvidia.com>
Date:   Fri, 22 May 2020 08:11:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522125230.GH2163848@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590160294; bh=Cu28XGa339sBuWwlN0QzgMrZoS1F9/2gZmihdDFygrc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=d+hHBwcOlxc0SyYXGAZcvYybu5e3BZ7RDbBRuPWZSxkz2ZbnGmCLmx5uZZagc/cic
         W1IsywmOoIUrW1Xc+O4eeNnovorvnLlQIeBzD2J54Kq0QlRk4x3NEFjeBtSlgdqio4
         Xr6pV6HalC3i5l2nTEgBF++TtwveDpo5jokK/hwn/faCFtyb42o1fH/vNUcBAU4Jer
         YKUHhnC6GYI//QmHE2GhmFUJ9lffP5bPaSJ93FUdWC31kI7f09dmgnK2O+4LCKLjpG
         c+iNxCWOqJjlcM8M43mwyc9vkKBQCW4UiGtYKCN5f3vP9YMsTImMfpbGq42cVRVj66
         Mac15biGHQaPw==
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


On 5/22/20 5:52 AM, Thierry Reding wrote:
> On Fri, May 22, 2020 at 03:42:18PM +0300, Dmitry Osipenko wrote:
>> 22.05.2020 15:26, Thierry Reding =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>> On Wed, May 20, 2020 at 01:08:57PM -0700, Sowjanya Komatineni wrote:
>>>> When auto calibration timeouts, calibration is disabled and fail-safe
>>>> drive strength values are programmed based on the signal voltage.
>>>>
>>>> Different fail-safe drive strength values based on voltage are
>>>> applicable only for SoCs supporting 3V3 and 1V8 pad controls.
>>>>
>>>> So, this patch avoids reading these properties from the device tree
>>>> for SoCs not using pad controls and the warning of missing properties
>>>> will not show up on these SoC platforms.
>>>>
>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>> ---
>>>>   drivers/mmc/host/sdhci-tegra.c | 57 ++++++++++++++++++++++++--------=
----------
>>>>   1 file changed, 33 insertions(+), 24 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-t=
egra.c
>>>> index 3e2c510..141b49b 100644
>>>> --- a/drivers/mmc/host/sdhci-tegra.c
>>>> +++ b/drivers/mmc/host/sdhci-tegra.c
>>>> @@ -605,6 +605,39 @@ static void tegra_sdhci_parse_pad_autocal_dt(stru=
ct sdhci_host *host)
>>>>   		autocal->pull_down_1v8 =3D 0;
>>>>  =20
>>>>   	err =3D device_property_read_u32(host->mmc->parent,
>>>> +			"nvidia,pad-autocal-pull-up-offset-sdr104",
>>>> +			&autocal->pull_up_sdr104);
>>>> +	if (err)
>>>> +		autocal->pull_up_sdr104 =3D autocal->pull_up_1v8;
>>>> +
>>>> +	err =3D device_property_read_u32(host->mmc->parent,
>>>> +			"nvidia,pad-autocal-pull-down-offset-sdr104",
>>>> +			&autocal->pull_down_sdr104);
>>>> +	if (err)
>>>> +		autocal->pull_down_sdr104 =3D autocal->pull_down_1v8;
>>>> +
>>>> +	err =3D device_property_read_u32(host->mmc->parent,
>>>> +			"nvidia,pad-autocal-pull-up-offset-hs400",
>>>> +			&autocal->pull_up_hs400);
>>>> +	if (err)
>>>> +		autocal->pull_up_hs400 =3D autocal->pull_up_1v8;
>>>> +
>>>> +	err =3D device_property_read_u32(host->mmc->parent,
>>>> +			"nvidia,pad-autocal-pull-down-offset-hs400",
>>>> +			&autocal->pull_down_hs400);
>>>> +	if (err)
>>>> +		autocal->pull_down_hs400 =3D autocal->pull_down_1v8;
>>>> +
>>>> +	/*
>>>> +	 * Different fail-safe drive strength values based on the signaling
>>>> +	 * voltage are applicable for SoCs supporting 3V3 and 1V8 pad contro=
ls.
>>>> +	 * So, avoid reading below device tree properies for SoCs that don't
>>>> +	 * have NVQUIRK_NEEDS_PAD_CONTROL.
>>>> +	 */
>>>> +	if (!(tegra_host->soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL))
>>>> +		return;
>>> Hm... so what exactly is the difference between NVQUIRK_HAS_PADCALIB? I
>>> think Tegra30 will also end up calling tegra_sdhci_set_padctrl(), but i=
t
>>> will then write the default (0) value for these drive strength. Is that
>>> okay?

Yes separate 3v3 and 1v8 drive strengths are for Tegra210/184/194 where=20
they have separate pad controls.

T30 also has auto calibration enabled but don't need to use these=20
properties as they don't have separate default drive strengths based on=20
signaling.

Same default drive strengths set by boot loader/default pinmux will hold=20
good.

>> It won't write 0, but skip the writing if values are 0. Technically T30+
>> supports the customized strengths, but I'm not sure whether it was ever
>> tested and whether it's really needed. I think Sowjanya said before that
>> the default values are always okay for older SoCs.
> Alright then, in that case:
>
> Acked-by: Thierry Reding <treding@nvidia.com>
