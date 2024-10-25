Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5D169AC5;
	Fri, 25 Oct 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729870843; cv=none; b=KhxGGAfU1fomA2Eu1eew888CSZvvYH+bApnEtniQZfW4eKZACgWEmj+T8ef7JadqPLi6XaOyaVE+JXD7Y+dyMaUJSRAR1woW+HB04b8mHWBsHHpDB6ajoimRKw3KBfY+EFP63nh3Dp0Nm+MEeUTd7OH2+hkO+8+yWPpRXT6t8DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729870843; c=relaxed/simple;
	bh=lnzej9riwoP0T3XvrgsBen19+FPab1L5CE0OE6JawpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aa1aGpGUtv7RKkHupRlncuCZLi/K0eLCFRC5D2ySp7q7sPU2ZGioUV9zirIBs79ERluxEV42CZ7VOvin/yr7hlvRV1Pa5RzfAIeMBeOIybNvEfPizY2PJJaLGSMiINXbVG1Suj+DaeqmFe6ak+vFyFPXiOSIMrODeVa1y1S0ULo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=coBG6Tt7; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="coBG6Tt7"
Received: from [192.168.178.76] (host-212-18-30-247.customer.m-online.net [212.18.30.247])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 81C8D2FC0063;
	Fri, 25 Oct 2024 17:40:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1729870830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c//f/7s6BWOQiiDwzMLRRIcTmPrSjbMYXtncbing1bQ=;
	b=coBG6Tt7Bzq424t8FVpqd5E+0hRt40TI+qQnzcTQGSWbaYChpiAGIZ3vkk3oZA7Zg2cMCo
	9aYNyHwL/tH+3EwenOn2IpQhVKg+p28azFIkgSU9hMuBksHhKeCeReEnypg28tzTCHpCHz
	7y6hWHMyTFNT3AdB8gTIa8dD7rNqCNg=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=ggo@tuxedocomputers.com
Message-ID: <4dd25dca-f217-4abd-88e8-0a6b03760dd7@tuxedocomputers.com>
Date: Fri, 25 Oct 2024 17:40:26 +0200
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mmc: sdhci-pci-gli: GL9767: Fix low power mode on the
 set clock function
To: Ulf Hansson <ulf.hansson@linaro.org>, Ben Chuang <benchuanggli@gmail.com>
Cc: adrian.hunter@intel.com, victor.shih@genesyslogic.com.tw,
 greg.tu@genesyslogic.com.tw, ben.chuang@genesyslogic.com.tw,
 HL.Liu@genesyslogic.com.tw, Lucas.Lai@genesyslogic.com.tw,
 victorshihgli@gmail.com, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Georg Gottleuber <ggo@tuxedocomputers.com>,
 Werner Sembach <wse@tuxedocomputers.com>, cs@tuxedo.de
References: <20241025060017.1663697-1-benchuanggli@gmail.com>
 <CAPDyKFpb5ZePhXziLH3VbuKKywJZbo8UBF1NM1_dyOWq9oLDng@mail.gmail.com>
Content-Language: en-US
From: Georg Gottleuber <ggo@tuxedocomputers.com>
In-Reply-To: <CAPDyKFpb5ZePhXziLH3VbuKKywJZbo8UBF1NM1_dyOWq9oLDng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello Ben, hello Uffe,

thank you for this fix.

Am 25.10.24 um 15:22 schrieb Ulf Hansson:
> + Georg
> 
> On Fri, 25 Oct 2024 at 08:01, Ben Chuang <benchuanggli@gmail.com> wrote:
>>
>> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
>>
>> On sdhci_gl9767_set_clock(), the vendor header space(VHS) is read-only
>> after calling gl9767_disable_ssc_pll() and gl9767_set_ssc_pll_205mhz().
>> So the low power negotiation mode cannot be enabled again.
>> Introduce gl9767_set_low_power_negotiation() function to fix it.
>>
>> The explanation process is as below.
>>
>> static void sdhci_gl9767_set_clock()
>> {
>>         ...
>>         gl9767_vhs_write();
>>         ...
>>         value |= PCIE_GLI_9767_CFG_LOW_PWR_OFF;
>>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <--- (a)
>>
>>         gl9767_disable_ssc_pll(); <--- (b)
>>         sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>>
>>         if (clock == 0)
>>                 return;  <-- (I)
>>
>>         ...
>>         if (clock == 200000000 && ios->timing == MMC_TIMING_UHS_SDR104) {
>>                 ...
>>                 gl9767_set_ssc_pll_205mhz(); <--- (c)
>>         }
>>         ...
>>         value &= ~PCIE_GLI_9767_CFG_LOW_PWR_OFF;
>>         pci_write_config_dword(pdev, PCIE_GLI_9767_CFG, value); <-- (II)
>>         gl9767_vhs_read();
>> }
>>
>> (a) disable low power negotiation mode. When return on (I), the low power
>> mode is disabled.  After (b) and (c), VHS is read-only, the low power mode
>> cannot be enabled on (II).
>>
>> Fixes: d2754355512e ("mmc: sdhci-pci-gli: Set SDR104's clock to 205MHz and enable SSC for GL9767")
> 
> Is this the same problem as being reported in
> https://lore.kernel.org/all/41c1c88a-b2c9-4c05-863a-467785027f49@tuxedocomputers.com/
> 
> ?

Yes, this patch fixes
https://bugzilla.kernel.org/show_bug.cgi?id=219284

This makes my patch obsolete.

Kind regards,
Georg
