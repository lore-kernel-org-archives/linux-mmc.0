From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Write only 4 bit in case of TIMEOUT_CONTROL
Date: Fri, 1 Nov 2013 07:31:34 +0100
Message-ID: <52734AC6.6020101@de.bosch.com>
References: <1373956571-25967-1-git-send-email-dirk.behme@de.bosch.com> <20130716073826.GH28375@S2101-09.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:11153 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892Ab3KAGbm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Nov 2013 02:31:42 -0400
In-Reply-To: <20130716073826.GH28375@S2101-09.ap.freescale.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 16.07.2013 09:38, Shawn Guo wrote:
> Hi Dirk,
>
> On Tue, Jul 16, 2013 at 08:36:11AM +0200, Dirk Behme wrote:
>> In case of SDHCI_TIMEOUT_CONTROL write only 4 bits and not the
>> whole byte to avoid touching other unrelated bits in the i.MX6
>> SYS_CTRL register. E.g. IPP_RST_N shouldn't be touched accidently.
>>
>> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>

What's the status of this? I can't find it e.g. in linux-next?

Does anybody like to help to apply this?

Many thanks and best regards

Dirk

>> ---
>>   drivers/mmc/host/sdhci-esdhc-imx.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>> index 1dd5ba8..1af3a2a 100644
>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>> @@ -362,6 +362,18 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>>
>>   		esdhc_clrset_le(host, mask, new_val, reg);
>>   		return;
>> +	case SDHCI_TIMEOUT_CONTROL:
>> +		/*
>> +		 * On i.MX6 the timeout value DTOCV is 4 bit large. Touch only
>> +		 * these 4 bits (lower nibble of the byte), but not the upper
>> +		 * nibble of the byte. The upper nibble of the byte contains
>> +		 * IPP_RST_N which should keep the reset value, i.e. 1, and
>> +		 * shouldn't be touched here.
>> +		 */
>> +		if (is_imx6q_usdhc(imx_data)) {
>> +			esdhc_clrset_le(host, 0x0f, val, reg);
>> +			return;
>> +		}
>>   	}
>>   	esdhc_clrset_le(host, 0xff, val, reg);
>>
>> --
>> 1.8.2
