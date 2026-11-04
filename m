Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818144;
	b=xmuYMMy7QVvKIJz+crg2M3c4j5iqVSKT6GuORnFHls0ShiJZp+aKnHAQDSwnhg+iRiWQ
	 tSYnS+I9+wFVB6v5cQGPup5BJ+Dr2+A9CvMGG5U49bNQQZJT8bGNNaQXhDeZI+hdS6VXe
	 mM/xLfStkMBTYxIu2Ji1YXeByvxbI90jnnTQAR2gh33GnL5FOaBW6CJITaTFbShkYq6Mb
	 Z9vI1lkjNbBCjiUWwyz5wsWEyXHq/aJAbRRbI9AexITeSUJ4xd4Ii6g9iuvGQN/65HqrG
	 7prPbZc9lXH6PmlOc78JoSX71QsKzHG4BJOgpoLw6JgttUfHJ7uPMj/V4lMS9IA5m/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818144;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=jxDJfQuqQySbeyhsMbdeZNmsBQGEc57n+fRANcEbFqc=;
	b=m0M8efmnJQhgZAvLbDbKzZR3fkG3ndFhJaX6btj5Yozc62vVzwfW+pJhqJ2MR3NbcT1S
	 WpIb67T44uYxTD/tsfxVBlHSHldEwlczs9J93KAv0aMiWeL5e1/+jwYH7imeE2jDmcNTt
	 ui4jn+qT+GdUgfe8Lk+nlESVqO1L2vlKfIHUZ1mAO6/Oh5Y+UtexfcEJgHnV1f8r+wMEA
	 slqe5rTZqizn7+b4ErG0vYLtrrTRgSsAneczYNlMspdPZKoDEdkvz52ZY+ECxvI+/aNRu
	 NDTHkruuNIzT03VodFIESJIadK7d6/4CoEjb8Y3VW/Ix3Jcuc5dBSWNc2CBO+kXWIkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=95.215.58.135
Received: from mta1.migadu.com (out-135.mta1.migadu.com [95.215.58.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CB9606A326
	for <linux-mmc@vger.kernel.org>; Wed,  4 Nov 2026 18:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11CB9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: linux-mmc@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HhYkGcuQrbLxya5Xd6Xhc7SivvwextAyDRpHv8somGw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793818141; v=1; x=1794422941;
 b=YLKlqYBel6PfpITm5cSBNxwyzxER01KRFjFuL39PTtTfCRD8ERoCSUuIA2qh1JOiIjcemOF2
 2SNQZTDqfVz9rCXAbKZxe3v4yAKVMcPHqCRU5lfHLg16MC9BO3dl+/Lj8OELsntWy14hFkfO//Y
 csAC25jQRzYgZ428pEbwI4js=
X-Envelope-To: linux-mmc@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ca283ee4143799e8;
	Wed, 04 Nov 2026 18:49:00 +0000
X-Mizu-Trace-ID: ca283ee4143799e8
X-Migadu-Flow: FLOW_OUT
Message-ID: <5c29414f-69ec-4e43-ace6-4a335c04fbf3@linux.dev>
Date: Wed, 4 Nov 2026 10:48:58 -0800
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci-pci-gli: GL9767: Wait for UHS-II PHY before
 LPM
To: =?UTF-8?B?QmVuQ2h1YW5nW+iOiuaZuumHj10=?=
 <Ben.Chuang@genesyslogic.com.tw>, Adrian Hunter <adrian.hunter@intel.com>,
 Ulf Hansson <ulfh@kernel.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Victor Shih <victor.shih@genesyslogic.com.tw>,
 Lucas Lai <lucas.lai@genesyslogic.com.tw>
References: <20261021233313.247155-1-matthew.schwartz@linux.dev>
 <TYZPR01MB426090F9895F8599611EF80BD76D2@TYZPR01MB4260.apcprd01.prod.exchangelabs.com>
Content-Language: en-US
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <TYZPR01MB426090F9895F8599611EF80BD76D2@TYZPR01MB4260.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/30/26 3:53 AM, BenChuang[莊智量] wrote:
> 
> 
>> -----Original Message-----
>> From: Matthew Schwartz <matthew.schwartz@linux.dev>
>> Sent: Thursday, October 22, 2026 7:33 AM
>> To: Adrian Hunter <adrian.hunter@intel.com>; Ulf Hansson <ulfh@kernel.org>
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org; Victor Shih <victor.shih@genesyslogic.com.tw>; Lucas Lai
>> <lucas.lai@genesyslogic.com.tw>; BenChuang[莊智量] <Ben.Chuang@genesyslogic.com.tw>; Matthew Schwartz
>> <matthew.schwartz@linux.dev>
>> Subject: [PATCH] mmc: sdhci-pci-gli: GL9767: Wait for UHS-II PHY before LPM
>>
>> sdhci_gl9767_set_clock() re-enables low power negotiation right after
>> releasing the UHS-II PHY reset. If the bus then goes idle before the
>> PHY has settled, every SDHCI MMIO read returns all-ones for about 250
>> us. sdhci_uhs2_interface_detect() takes that as IF_DETECT and LANE_SYNC
>> set, so a UHS-I only microSD card is treated as UHS-II. The attach then
>> either fails with "SDHCI_UHS2_CAPS_PTR(65535) is wrong" or, if the
>> registers come back before the CAPS_PTR read, runs DEVICE_INIT 30 times
>> with a 10 second timeout each and delays card detection by 5 minutes.
>>
>> Config register 0x8CC reads 0x2000 from clock enable until about 250-300
>> us after the PHY reset release and 0x1000 otherwise. Poll its bit 13
>> before re-enabling low power negotiation. The register meaning is
>> inferred from that behaviour, and with the wait in place 12 of 12
>> UHS-II probes of a UHS-I card correctly found no UHS-II interface.
>>
>> Fixes: 27dd3b82557a ("mmc: sdhci-pci-gli: enable UHS-II mode for GL9767")
>> Signed-off-by: Matthew Schwartz <matthew.schwartz@linux.dev>
> 
> Hi Matthew,
> 
> Thanks for the patch.
> 
> I checked the GL9767 register definition. Register 0x8CC is the UHS-II
> Status Register, and bit 13 is documented as
> UHS2_WAKEUP_ACTIVATE.
> 
> I was able to reproduce the "SDHCI_UHS2_CAPS_PTR(65535) is wrong" issue
> on my GL9767 test system, and I can no longer reproduce it with this
> patch applied.

Thanks for looking up the definition and for testing.

> 
> Tested-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
>> ---
>>  drivers/mmc/host/sdhci-pci-gli.c | 29 ++++++++++++++++++++++++++++-
>>  1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pci-gli.c b/drivers/mmc/host/sdhci-pci-gli.c
>> index b55618566d651..bd383918d27c7 100644
>> --- a/drivers/mmc/host/sdhci-pci-gli.c
>> +++ b/drivers/mmc/host/sdhci-pci-gli.c
>> @@ -205,6 +205,9 @@
>>  #define   PCIE_GLI_9767_COMBO_MUX_CTL_RST_EN           BIT(6)
>>  #define   PCIE_GLI_9767_COMBO_MUX_CTL_WAIT_PERST_EN    BIT(10)
>>
>> +#define PCIE_GLI_9767_PHY_STS                        0x8CC
>> +#define   PCIE_GLI_9767_PHY_STS_UHS2_BUSY      BIT(13)
> 
> maybe PCIE_GLI_9767_UHS2_STS and PCIE_GLI_9767_UHS2_STS_WAKEUP_ACTIVATE

Sounds good, will do in v2.

> 
>> +
>>  #define PCIE_GLI_9767_PWR_MACRO_CTL                                  0x8D0
>>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LOW_VOLTAGE                      GENMASK(3, 0)
>>  #define   PCIE_GLI_9767_PWR_MACRO_CTL_LD0_LOW_OUTPUT_VOLTAGE           GENMASK(15, 12)
>> @@ -1190,6 +1193,27 @@ static void gl9767_set_low_power_negotiation(struct pci_dev *pdev, bool enable)
>>       gl9767_vhs_read(pdev);
>>  }
>>
>> +static u32 gl9767_read_phy_sts(struct pci_dev *pdev)
>> +{
>> +     u32 value;
>> +
>> +     pci_read_config_dword(pdev, PCIE_GLI_9767_PHY_STS, &value);
>> +
>> +     return value;
>> +}
>> +
>> +static void sdhci_gl9767_uhs2_wait_phy_ready(struct sdhci_host *host)
>> +{
>> +     struct sdhci_pci_slot *slot = sdhci_priv(host);
>> +     struct pci_dev *pdev = slot->chip->pdev;
>> +     u32 value;
>> +
>> +     if (read_poll_timeout_atomic(gl9767_read_phy_sts, value,
>> +                                  !(value & PCIE_GLI_9767_PHY_STS_UHS2_BUSY),
>> +                                  10, 10000, false, pdev))
>> +             pr_warn("%s: UHS-II PHY not ready after reset.\n", mmc_hostname(host->mmc));
>> +}
>> +
> 
> One thing I was curious about.
> 
> The commit message mentions an observed settling time of approximately
> 250-300 us, while the polling loop allows up to 10 ms before reporting
> a timeout.
> 
> I assume the timeout is intentionally conservative, but I was wondering
> whether there was any particular reason for choosing 10 ms.

No particular reason beyond headroom. I only had the measured 250-300 us
to go on, so I picked a ceiling well above that which is only reached if
the bit never clears. If the GL9767 spec gives a maximum wakeup time,
I'm happy to use that instead.

> 
> Best regards,
> Ben Chuang
> 
>>  static void sdhci_gl9767_uhs2_phy_reset(struct sdhci_host *host, bool assert)
>>  {
>>       struct sdhci_pci_slot *slot = sdhci_priv(host);
>> @@ -1276,9 +1300,12 @@ static void sdhci_gl9767_set_clock(struct sdhci_host *host, unsigned int clock)
>>
>>       sdhci_enable_clk(host, clk);
>>
>> -     if (mmc_card_uhs2(host->mmc))
>> +     if (mmc_card_uhs2(host->mmc)) {
>>               /* De-assert reset */
>>               sdhci_gl9767_uhs2_phy_reset(host, false);
>> +             /* Low power negotiation before the PHY settles makes MMIO read all-ones */
>> +             sdhci_gl9767_uhs2_wait_phy_ready(host);
>> +     }
>>
>>       gl9767_set_low_power_negotiation(pdev, true);
>>  }
>> --
>> 2.56.0
> 
> ________________________________
> 
> Genesys Logic Email Confidentiality Notice:
> This mail and any attachments may contain information that is confidential, proprietary, privileged or otherwise protected by law. The mail is intended solely for the named addressee (or a person responsible for delivering it to the addressee). If you are not the intended recipient of this mail, you are not authorized to read, print, copy or disseminate this mail.
> 
> If you have received this email in error, please notify us immediately by reply email and immediately delete this message and any attachments from your system. Please be noted that any unauthorized use, dissemination, distribution or copying of this email is strictly prohibited.
> ________________________________

