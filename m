From: Pankaj Jangra <jangra.pankaj9@gmail.com>
Subject: Re: [PATCH 1/2] regulator: core.c Pass voltage to notifier when
 setting voltage
Date: Sat, 16 Jun 2012 00:07:22 +0530
Message-ID: <CADTbHxq1xY2bg2VWVhoYxB2Gjhz6PhGLjV3FPV0wjXUVnuo9-w@mail.gmail.com>
References: <1339711609-3417-1-git-send-email-prakity@marvell.com>
	<CADTbHxq5rmHJtFTp53sYhFSYWVrSqyo_Jq+0aWNOF2HQR+nhGA@mail.gmail.com>
	<84B43340-7E4D-474B-9217-56E809FF16A9@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65040 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab2FOShX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jun 2012 14:37:23 -0400
In-Reply-To: <84B43340-7E4D-474B-9217-56E809FF16A9@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Philip Rakity <philipspatches@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

On Fri, Jun 15, 2012 at 11:59 PM, Philip Rakity <prakity@marvell.com> w=
rote:
>
> On Jun 15, 2012, at 10:58 AM, Pankaj Jangra wrote:
>
>> Hi Philip,
>>
>> Just a cosmetic comments.
>>
>> On Fri, Jun 15, 2012 at 3:36 AM, Philip Rakity <philipspatches@gmail=
=2Ecom> wrote:
>> V2
>> --
>>
>> Incorporate performance suggestions made by Mark Brown
>> Use linux-next as base code rather than mmc-next
>>
>> The voltage being set should be passed to the handler requesting
>> the callback. =A0Currently this is not done.
>
> thanks -- my typo when redoing the patch -- V3 has this fixed.
>
>>
>> The callback cannot call regulator_get_voltage() to get the
>> information since the mutex is held by the regulator and
>> deadlock occurs.
>>
>> Without this change the receiver of the notify cannot now what
>>
>> You mean to say "cannot know what" ?
>>
>> action to take. =A0This is used, for example, to set PAD voltages
>> when doing SD vccq voltage changes.
>
>
> if you call in that receives the notify does not know the new voltage
> then in our case we do not know if we should switch the pad from
> 3.3v to 1.8v for example. =A0vccq signaling in SD is normally 3.3V
> but in UHS mode it is lowered to 1.8V
>

Yes right. So that means we need to make change in
blocking_notifier_call_chain() too in order to send the voltage back?

Regards,
Pankaj Jangra
