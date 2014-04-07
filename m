From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: Re: [PATCH] sdhci: Forward EPROBE_DEFER on vmmc and vqmmc regulators
Date: Mon, 7 Apr 2014 14:09:38 +0200
Message-ID: <53429582.9010007@topic.nl>
References: <1395991817-3503-1-git-send-email-mike.looijmans@topic.nl> <1396852708-11058-1-git-send-email-mike.looijmans@topic.nl> <4366803.P4zmzQMZfl@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp102.mer-nm.internl.net ([217.149.192.138]:45991 "EHLO
	smtp102.mer-nm.internl.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754792AbaDGMJo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Apr 2014 08:09:44 -0400
In-Reply-To: <4366803.P4zmzQMZfl@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, cjb@laptop.org, gdjakov@mm-sol.com

=EF=BB=BFOn 04/07/2014 10:11 AM, Arnd Bergmann wrote:
> On Monday 07 April 2014 08:38:28 Mike Looijmans wrote:
>> index 34aef81..43b90c1 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2972,6 +2972,8 @@ int sdhci_add_host(struct sdhci_host *host)
>>          host->vqmmc =3D regulator_get_optional(mmc_dev(mmc), "vqmmc=
");
>>          if (IS_ERR_OR_NULL(host->vqmmc)) {
>>                  if (PTR_ERR(host->vqmmc) < 0) {
>> +                       if (PTR_ERR(host->vqmmc) =3D=3D -EPROBE_DEFE=
R)
>> +                               return -EPROBE_DEFER;
>>                          pr_info("%s: no vqmmc regulator found\n",
>>                                  mmc_hostname(mmc));
>>                          host->vqmmc =3D NULL;
>> @@ -3048,8 +3050,10 @@ int sdhci_add_host(struct sdhci_host *host)
>>          host->vmmc =3D regulator_get_optional(mmc_dev(mmc), "vmmc")=
;
>>          if (IS_ERR_OR_NULL(host->vmmc)) {
>>                  if (PTR_ERR(host->vmmc) < 0) {
>> -                       pr_info("%s: no vmmc regulator found\n",
>> -                               mmc_hostname(mmc));
>> +                       if (PTR_ERR(host->vmmc) =3D=3D -EPROBE_DEFER=
)
>> +                               return -EPROBE_DEFER;
>> +                       pr_info("%s: no vmmc regulator found (%d)\n"=
,
>> +                               mmc_hostname(mmc), PTR_ERR(host->vmm=
c));
>>                          host->vmmc =3D NULL;
>>                  }
>
> Please change the code to not use IS_ERR_OR_NULL() instead, getting
> a NULL return value from regulator_get_optional() should not be
> considered a bug, while getting an error return should always
> cause the probe function to fail.

Please make that a separate patch, because doing so will break most (if=
 not=20
all) boards using this controller.

Mike.


Met vriendelijke groet / kind regards,

Mike Looijmans

TOPIC Embedded Systems
Eindhovenseweg 32-C, NL-5683 KH Best
Postbus 440, NL-5680 AK Best
Telefoon: (+31) (0) 499 33 69 79
Telefax:  (+31) (0) 499 33 69 70
E-mail: mike.looijmans@topic.nl
Website: www.topic.nl

Please consider the environment before printing this e-mail

Visit us at the Hannover Messe 7 - 11 April 2014 - Hall 002/D10 (Dutch =
Pavillion)
http://www.hannovermesse.de/exhibitor/topic-embedded-products/V229623

