From: Konstantin Dorfman <kdorfman@codeaurora.org>
Subject: Re: [PATCH v2] mmc: fix async request mechanism for sequential read
 scenarios
Date: Mon, 12 Nov 2012 14:49:00 +0200
Message-ID: <50A0F03C.10502@codeaurora.org>
References: <n> <1351780852-1293-1-git-send-email-kdorfman@codeaurora.org> <50975AA8.8030304@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine01.qualcomm.com ([199.106.114.254]:55468 "EHLO
	wolverine01.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752398Ab2KLMtE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Nov 2012 07:49:04 -0500
In-Reply-To: <50975AA8.8030304@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?Per_F=F6rlin?= <per.forlin@stericsson.com>
Cc: "cjb@laptop.org" <cjb@laptop.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "per.lkml@gmail.com" <per.lkml@gmail.com>

On 11/05/2012 08:20 AM, Per F=F6rlin wrote:
> Hi Konstantin,
>=20
> On 11/01/2012 03:40 PM, Konstantin Dorfman wrote:
>> When current request is running on the bus and if next request fetch=
ed
>> by mmcqd is NULL, mmc context (mmcqd thread) gets blocked until the
>> current request completes. This means if new request comes in while
>> the mmcqd thread is blocked, this new request can not be prepared in
>> parallel to current ongoing request. This may result in latency to
>> start new request.
>>
>> This change allows to wake up the MMC thread (which
>> is waiting for the current running request to complete). Now once th=
e
>> MMC thread is woken up, new request can be fetched and prepared in
>> parallel to current running request which means this new request can
>> be started immediately after the current running request completes.
>>
>> With this change read throughput is improved by 16%.
> What HW and what test cases have you been running?

I use the msm_sdcc controller and ran lmdd, tiotest, iozone benchmark
tool (details were on other mail in this thread).

I ran it on Qualcomm=AE SnapdragonT S4 ProAPQ8064

Thanks,

--=20
Konstantin Dorfman,
QUALCOMM ISRAEL, on behalf of Qualcomm Innovation Center,
Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
