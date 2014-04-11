From: Arend van Spriel <arend@broadcom.com>
Subject: Re: [RFC] dt: bindings: add bindings for Broadcom bcm43xx sdio devices
Date: Fri, 11 Apr 2014 10:06:52 +0200
Message-ID: <5347A29C.7020602@broadcom.com>
References: <1392059868-8782-1-git-send-email-arend@broadcom.com> <52FC8CB3.4090305@gmail.com> <CAGb2v67za+5yW3RE0pwBWk-NdTUSm-JkKE+j9NLjbBkE_Fc1hQ@mail.gmail.com> <5337DC2E.5040000@broadcom.com> <1397165245229-838046.post@n7.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:9373 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbaDKIGz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Apr 2014 04:06:55 -0400
In-Reply-To: <1397165245229-838046.post@n7.nabble.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-1?Q?J=F6rg_Krause?= <jk@lintech.de>, linux-kernel@vger.kernel.org, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>

On 10/04/14 23:27, J=F6rg Krause wrote:
> On 02/13/14 10:28, Chen-Yu Tsai wrote:
>> Hi,
>>
>> On Thu, Feb 13, 2014 at 5:13 PM, Tomasz Figa&lt;tomasz.figa@&gt;  wr=
ote:
>>> Hi Arend,
>>>
>>>
>>> On 10.02.2014 20:17, Arend van Spriel wrote:
>
> [...]
>
> Hi Chen-Yu,
>
> picking up this thread.
>
>> AFAIK, the pinctrl in tied to the device node, and is selected when =
the
>> device
>> is registered. The MMC subsystem currently does not register child n=
odes,
>> so
>> this would be useless.
>
> So if MMC does not register child nodes, brcmfmac will not be probed
> with of_node set? Have there been patches submitted for this in mmc
> subsystem recently.
>
> [...]
>
>
>
> Sascha Hauer submitted a patch a week ago. Link:
> https://lkml.org/lkml/2014/4/3/522 <https://lkml.org/lkml/2014/4/3/52=
2>

Thanks, J=F6rg

It is a partial solution, but it seems to conflict with my change. So=20
thanks for the heads up. I am not convinced whether the GPIO and clock=20
should be bound to the function. They seem more a property of the=20
card/device inserted.

Regards,
Arend
> --
> View this message in context: http://linux-kernel.2935.n7.nabble.com/=
RFC-dt-bindings-add-bindings-for-Broadcom-bcm43xx-sdio-devices-tp801976=
p838046.html
> Sent from the Linux Kernel mailing list archive at Nabble.com.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

