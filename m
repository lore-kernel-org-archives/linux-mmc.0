From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: support BKOPS feature for eMMC
Date: Fri, 28 Oct 2011 20:01:18 +0900
Message-ID: <4EAA8B7E.1040203@samsung.com>
References: <4EA93C08.9030009@samsung.com>
 <loom.20111027T202726-264@post.gmane.org>
 <CAAgDR1PJFX1c3xexgv7=Ccm3HGRtu0VMDy6APWUExSHOO3aE4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:41984 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752163Ab1J1LB2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 28 Oct 2011 07:01:28 -0400
Received: from epcpsbgm1.samsung.com (mailout2.samsung.com [203.254.224.25])
 by mailout2.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LTR00A6VVY7RQD0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Oct 2011 20:01:27 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTPA id <0LTR00FC4VYF6690@mmp1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 28 Oct 2011 20:01:27 +0900 (KST)
In-reply-to: <CAAgDR1PJFX1c3xexgv7=Ccm3HGRtu0VMDy6APWUExSHOO3aE4A@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sebastian Rasmussen <sebras@gmail.com>
Cc: Per Forlin <per.lkml@gmail.com>, linux-mmc@vger.kernel.org

Hi Sebastian.

I have some question..
Maybe i think that my-patch should be worked only level-2/3..right?
Because URGENT_BKOPS bit in the EXCEPTION_EVENTS_STATUS is set whenever=
 is either 2 or 3.
In this case, host control with R1-type response.

But in level-0/1 case, need to check BKOPS_STATUS periodically.
How did you understand that "periodically" means?
If host need to get BKOPS_STATUS periodically, maybe send CMD8 periodic=
ally.
How periodically?=20

Best Regards,
Jaehoon Chung

On 10/28/2011 05:51 AM, Sebastian Rasmussen wrote:

> Hi!
>=20
>> This patch only starts BKOPS if it's urgent or critical.
>=20
> Almost, it starts BKOPS when it is urgent, which per spec means level
> 2 or 3, i.e. when performance is impacted or when it is critical.
> Better use the specs terminology as far as possible to relieve
> everyone of confusion.
>=20
>> I would be preferable to run bkops periodically and only when
>> the card is idle to minimize the risk of reaching URGENT.
>=20
> Well, you kind of need both. If the eMMC is kept busy to such an
> extent that the block device is never idling then you would definitel=
y
> require this patch, right? Otherwise you may end up wasting the time
> between the last command sent and when the device has been deemed to
> be idle for long enough.
>=20
> So basically the OP's patch fixes the case where, e.g. sustained
> (re-)writing, keeps the block device busy until and after it reaches
> the critical BKOPS level, while your proposal takes care of the other
> case where the block device is not accessed all the time.
>=20
>> The specs says:
>> -----
>> Hosts shall still read the full status from the BKOPS_STATUS byte pe=
riodically
>> and start background operations as needed.
>> -----
>=20
> Sure, if there is idle time to do it, then why not.
> If there is no idle time and URGENT_BKOPS is asserted, then the
> framework can not wait until the next idle period, but should issue
> BKOPS as soon as possible after the current command is finished.
>=20
>> I'm thinking of checking BKOPS_STATUS when the card is idle and then=
 run bkops
>> even if level is only 1 (Operations outstanding =96 non critical). W=
ould this make
>> sense?
>=20
> I guess this boils down to how you define idle..? Does it mean
> immediately after the current command has been fully serviced, or doe=
s
> it mean some arbitrary time after the last sent command has been full=
y
> serviced? My assumption is that you are refering to the latter, in
> which case certain access patterns may cause problems. So, how do
> _you_ define idle? :)
>=20

>  / Sebastian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


