From: Matt Redfearn <matt.redfearn-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v5] mmc: OCTEON: Add host driver for OCTEON MMC controller
Date: Thu, 11 Feb 2016 08:15:42 +0000
Message-ID: <56BC432E.8000600@imgtec.com>
References: <1455125775-7245-1-git-send-email-matt.redfearn@imgtec.com>
 <56BB7B2F.60307@caviumnetworks.com>
 <20160210234907.GC1640@darkstar.musicnaut.iki.fi>
 <56BBD6AD.2090902@caviumnetworks.com> <56BBF83B.8020908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56BBF83B.8020908-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Aleksey Makarov <aleksey.makarov-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Chandrakala Chavva <cchavva-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Aleksey Makarov <aleksey.makarov-tx70/tkNEWbQT0dZR+AlfA@public.gmane.org>, Leonid Rosenboim <lrosenboim-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Peter Swain <pswain-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, Aaron Williams <aaron.williams-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Florian.

On 11/02/16 02:55, Florian Fainelli wrote:
> Le 10/02/2016 16:32, David Daney a =C3=A9crit :
>> On 02/10/2016 03:49 PM, Aaro Koskinen wrote:
>>> Hi,
>>>
>>> On Wed, Feb 10, 2016 at 10:02:23AM -0800, David Daney wrote:
>>>> On 02/10/2016 09:36 AM, Matt Redfearn wrote:
>>>>> +        pr_warn(FW_WARN "%s: Legacy property '%s'. Please remove=
\n",
>>>>> +            node->full_name, legacy_name);
>>>> I don't like this warning message.
>>>>
>>>> The vast majority of people that see it will not be able to change=
 their
>>>> firmware.  So it will be forever cluttering up their boot logs.
>>> Until they switch to use APPENDED_DTB. :-)
>>>
>> I am philosophically opposed to making the DTB an internal kernel
>> implementation detail.
>>
>> For OCTEON boards, it is an ABI between the boot firmware and the
>> kernel, and is impractical to change.
>>
>> One could argue that many years ago, when the decision was made (by =
me),
>> that we should have opted to carry in the kernel source code tree th=
e
>> DTS files for all OCTEON boards ever made, but we did not do that.  =
Due
>> to the non-reversibility of time, the decision is hard to reverse.
>>
>> In the case of this MMC driver, the only real difference is that two
>> properties have legacy names that later had differing "official" nam=
es.
>>   The overhead of carrying the legacy bindings is very low.
> Since there is an existing FDT patching infrastructure in
> arch/mips/cavium-octeon/ would not that be a place where you could pu=
t
> an adaptation layer between your legacy firmware properties and the
> upstream binding?
Thanks for your constructive advice. That does, indeed, look like a=20
better place to put this.

Thanks,
Matt
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
