From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: Re: [PATCH v2 2/6] arm: davinci: Explicitly set channel controllers'
 default queues
Date: Fri, 29 Jul 2011 10:42:36 -0400
Message-ID: <CAPcSpEJRjE-vD3XaTcVBUoBH_Ud+gBMgBSd=F0S1ON6cUy0vvg@mail.gmail.com>
References: <1310303679-17936-1-git-send-email-ido@wizery.com>
	<1310303679-17936-3-git-send-email-ido@wizery.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024DD2CE05@dbde02.ent.ti.com>
	<4E2D70B9.7060202@mvista.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024DD2CEA5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:39561 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751630Ab1G2Omr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 29 Jul 2011 10:42:47 -0400
Received: by mail-vw0-f44.google.com with SMTP id 12so4499020vws.17
        for <linux-mmc@vger.kernel.org>; Fri, 29 Jul 2011 07:42:36 -0700 (PDT)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CEA5@dbde02.ent.ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Nori, Sekhar" <nsekhar@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Mon, Jul 25, 2011 at 12:31 PM, Nori, Sekhar <nsekhar@ti.com> wrote:
> Hi Sergei,
>
> On Mon, Jul 25, 2011 at 19:03:45, Sergei Shtylyov wrote:
>> Hello.
>>
>> Nori, Sekhar wrote:
>>
>> >> Davinci platforms may define a default queue for each channel
>> >> controller. If one is not defined, the default queue is set to EV=
ENTQ_1.
>> >> However, there's no way to distinguish between an unset default q=
ueue to
>> >> one that is set to EVENTQ_0, as EVENTQ_0 =3D 0.
>>
>> >> Explicitly specify the default queue for all channel controllers =
on all
>> >> Davinci platforms to EVENTQ_1, and don't overwrite it in the EDMA=
 probe
>> >> function.
>>
>> >> One exception is the DA850 board, for which EVENTQ_1 is not a val=
id
>> >> option for its second channel controller. Use EVENTQ_0 instead fo=
r that
>> >> channel controller.
>>
>> >> Signed-off-by: Ido Yariv <ido@wizery.com>
>>
>> > Looks good to me. Will queue for v3.2/fixes
>>
>> =A0 =A0 Why wait for 3.2? If this is considered a fix, it should be =
applied to 3.1, no?
>
> 3.2/fixes just indicates it will be queued as a fix/cleanup
> for 3.2 so it will have higher priority for merge when compared
> to a new feature.
>
> This patch doesn't really fix any existing broken functionality.
> It corrects event queue configuration for EDMA CC1 on DA850 for
> which there are no current users in mainline.
>
> So, not sending for v3.1.

If it's not too late:

Tested this patch and it fixes SD/MMC1 support on da850.

Tested-by: Ben Gardiner <bengardiner@nanometrics.ca>

Thanks, Ido!

Best Regards,
Ben Gardiner

---
Nanometrics Inc.
http://www.nanometrics.ca
