From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: support BKOPS feature for eMMC
Date: Fri, 28 Oct 2011 14:14:13 +0900
Message-ID: <4EAA3A25.60905@samsung.com>
References: <4EA93C08.9030009@samsung.com>
 <loom.20111027T202726-264@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:16057 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751253Ab1J1FOY (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Oct 2011 01:14:24 -0400
Received: from epcpsbgm1.samsung.com (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LTR002ZVFVFJJE0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Oct 2011 14:14:22 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LTR00BG2FVYZ940@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Oct 2011 14:14:22 +0900 (KST)
In-reply-to: <loom.20111027T202726-264@post.gmane.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Per Forlin <per.lkml@gmail.com>
Cc: linux-mmc@vger.kernel.org

On 10/28/2011 04:35 AM, Per Forlin wrote:

> Jaehoon Chung <jh80.chung <at> samsung.com> writes:
>=20
>> +++ b/drivers/mmc/core/core.c
>> @@ -238,6 +238,50 @@ mmc_start_request(struct mmc_host *host, struct
> mmc_request *mrq)
>>  	host->ops->request(host, mrq);
>>  }
>>
>> +/**
>> + *	mmc_start_bkops - start BKOPS for supported cards
>> + *	@card: MMC card to start BKOPS
>> + *
>> + *	Start background operations whenever requested.
>> + *	when the urgent BKOPS bit is set in a R1 command response
>> + *	then background operations should be started immediately.
>> +*/
> This patch only starts BKOPS if it's urgent or critical. I would be p=
referable
> to run bkops periodically and only when the card is idle to minimize =
the risk of
> reaching URGENT.
>=20
> The specs says:
> -----
> Hosts shall still read the full status from the BKOPS_STATUS byte per=
iodically
> and start background operations as needed.
> -----
>=20
> I'm thinking of checking BKOPS_STATUS when the card is idle and then =
run bkops
> even if level is only 1 (Operations outstanding =E2=80=93 non critica=
l). Would this make
> sense?
>=20

host shall check the BKOPS_STATUS periodically..i will add this point..
(i think that need to check EXT_CSD register periodically.)

Thanks,
Jaehoon Chung

> Regards,
> Per
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


