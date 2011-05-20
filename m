From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [v5 5/5] MMC: SDHCI AutoCMD23 support.
Date: Fri, 20 May 2011 13:08:18 -0500
Message-ID: <BANLkTikVg1V908jvO5Ss4xnj0tLq+pyf9w@mail.gmail.com>
References: <1303870235-29041-1-git-send-email-andreiw@motorola.com>
	<1305841590-26963-6-git-send-email-andreiw@motorola.com>
	<6C03668EAF45B747AF947A1603D1B300011BEA693A@SAUSEXMBP01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og105.obsmtp.com ([64.18.0.180]:52782 "EHLO
	exprod5og105.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757241Ab1ETSIW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 20 May 2011 14:08:22 -0400
Received: from DE01MGRG01.AM.MOT-MOBILITY.COM ([10.176.129.42])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4KI8pXB026844
	for <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 14:08:51 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by DE01MGRG01.AM.MOT-MOBILITY.COM (8.14.3/8.14.3) with ESMTP id p4KI8nnu026822
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 14:08:51 -0400 (EDT)
Received: by wwb28 with SMTP id 28so4203828wwb.3
        for <linux-mmc@vger.kernel.org>; Fri, 20 May 2011 11:08:18 -0700 (PDT)
In-Reply-To: <6C03668EAF45B747AF947A1603D1B300011BEA693A@SAUSEXMBP01.amd.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nath, Arindam" <Arindam.Nath@amd.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "cjb@laptop.org" <cjb@laptop.org>, "arnd@arndb.de" <arnd@arndb.de>, "subhashj@codeaurora.org" <subhashj@codeaurora.org>, "malchev@google.com" <malchev@google.com>

Hi Arindam,

On Fri, May 20, 2011 at 5:46 AM, Nath, Arindam <Arindam.Nath@amd.com> w=
rote:
> Hi Andrei,
>
> [...]
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 7e28eec..713caf0 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -25,6 +25,7 @@
>> =A0 */
>>
>> =A0#define SDHCI_DMA_ADDRESS =A0 =A00x00
>> +#define SDHCI_ARGUMENT2 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00
>
> Since SDHCI_DMA_ADDRESS and SDHCI_ARGUMENT2 in actually the same regi=
ster, probably ...
>
> #define SDHCI_ARGUMENT2 =A0 =A0 =A0 =A0 SDHCI_DMA_ADDRESS

Sure.

>> =A0#define =A0SDHCI_TRNS_ACMD12 =A0 0x04
>> +#define =A0SDHCI_TRNS_ACMD23 =A0 0x08
>
> How about changing these names explicitly to _AUTO_CMD12 and _AUTO_CM=
D23? That way we are less likely to get confused with App commands with=
 same names.

Sounds good.

>> =A0#define SDHCI_ACMD12 =A0 =A0 =A0 =A0 (1<<6) =A0/* Auto CMD12 supp=
ort */
>> +#define SDHCI_ACMD23 =A0 =A0 =A0 =A0 (1<<7) =A0/* Auto CMD23 suppor=
t */
>

Ok, will clean it up.

A
