Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C5427465F;
	Mon, 14 Apr 2025 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744641077; cv=none; b=tklaPh9YsCiaDWrrzDeaaCe+IFRhE/xFwJNxApUfHbDi0UholQSfX4+eQyoLWCMdpDUZwMDSsofnsO+0/d/rhThx36CuNi8o/R4Ij3jGaGbiAw4w6M9AoZ8qtpciNLACFglclgx9wbnTk+Eyej1lT/SklfLJWJRzckVd7qyJQuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744641077; c=relaxed/simple;
	bh=OqXg4e+osxpah5HvqjCGSuOnhbTfXN7l09sIFukQFwQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rSh/MKcr9J7c/OUCTP11n0OYE3xVOWqJKLX+t15JI9axXv2LBrjoPqi2SICcFXGJTLKn+epjdxnF+VvYmlImS1OaZxJGG2yQPMIS5zIVA3oLzXpMmlBboaWfvjL4oMYlcAscy653QeSzLbwrLQpCg92AQSDT3wf2D190lkKHljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TOkPAmHe; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TOkPAmHe"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53EEV4Rl2081601
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 09:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1744641064;
	bh=K/rwGIsJ8Kg+PnijAfoO4OaX+sYxwlBFIawLCatqUGs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=TOkPAmHeT20/wBHitFbboTwwbCaIPDfNRB3WdsO6nVN1L0X1fjTGptvdouIgxTxck
	 kmCpiKCwUxv3KIkUCmSYzCp3XB/Sx8L3WAgZ4oWhAkpIYX9Mk+3ZS/P/Yhj0USYjlw
	 4fIt9ox3U/LNyOg5PE/WE8kcJkZfkSEjSQjqB9GI=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53EEV31T020080
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Apr 2025 09:31:03 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Apr 2025 09:31:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Apr 2025 09:31:03 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53EEV3a0008545;
	Mon, 14 Apr 2025 09:31:03 -0500
Message-ID: <4c8ef068-570c-4f85-8991-47f305b87fb2@ti.com>
Date: Mon, 14 Apr 2025 09:31:03 -0500
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Fix V1P8_SIGNAL_ENA and HIGH_SPEED_ENA
To: Hiago De Franco <hiagofranco@gmail.com>,
        Adrian Hunter
	<adrian.hunter@intel.com>
CC: Josua Mayer <josua@solid-run.com>, Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Moteen Shah
	<m-shah@ti.com>,
        Hiago De Franco <hiago.franco@toradex.com>
References: <20250407222702.2199047-1-jm@ti.com>
 <20250411130354.dc3sv3e7ruekkhkp@hiago-nb>
 <d8e45e50-f0eb-41d0-9c50-56147eaf262a@ti.com>
 <20250411194813.c4ft2uxgdiuza5cm@hiago-nb>
 <5f36ec5d-bb31-4b6c-aa4e-4ec48cb1d067@ti.com>
 <20250412132012.xpjywokcpztb4jg4@hiago-nb>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20250412132012.xpjywokcpztb4jg4@hiago-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Hiago,

On 4/12/25 8:20 AM, Hiago De Franco wrote:
> Hi Judith,
> 
> On Fri, Apr 11, 2025 at 04:55:39PM -0500, Judith Mendez wrote:
>> Actually this was one of the previous implementations, I should have that
>> original patch somewhere. My understanding was that we do not like adding
>> new DT properties if we can find a way to apply the quirk in the driver.
> 
> Got it, makes sense. This will work fine with eMMC, but for the SD card
> I am not seeing other option. Maybe we could use both implementations?
> 
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index 4e1156a2f1b8..db8ee66e76d8 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -888,7 +888,7 @@ static int sdhci_am654_get_of_property(struct platform_device *pdev,
> 
>          /* Suppress V1P8_SIGNAL_ENA for eMMC */
>          device_property_read_u32(dev, "bus-width", &bus_width);
> -       if (bus_width == BUS_WIDTH_8)
> +       if (bus_width == BUS_WIDTH_8 || device_property_read_bool(dev, "ti,suppress-v1p8-ena"))
>                  sdhci_am654->quirks |= SDHCI_AM654_QUIRK_SUPPRESS_V1P8_ENA;
> 
> So the driver applies the quirk for eMMC and we set the DT property for
> SD card. Not sure which one is the best, but maybe it is another option.
> Let's see what Adrian also thinks about that.

I like it, sure lets see what Adrian says, thanks for your suggestion.

~ Judith

