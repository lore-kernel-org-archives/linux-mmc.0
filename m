From: "S, Venkatraman" <svenkatr@ti.com>
Subject: Re: [PATCHv4 0/3] OMAP: HSMMC: cleanup and runtime pm
Date: Mon, 4 Jul 2011 23:35:31 +0530
Message-ID: <CANfBPZ-A8WMqjkNspvtXK1FSE1BRG_PE6JKKqmLWQerzn=h2Xw@mail.gmail.com>
References: <1309538376-23260-1-git-send-email-balajitk@ti.com>
	<8762nlzy1d.fsf@ti.com>
	<CANrkHUb-i4cQmGzrDjcooZPRvyQLSd0+kqLMA04hGzgVjCT+=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <CANrkHUb-i4cQmGzrDjcooZPRvyQLSd0+kqLMA04hGzgVjCT+=A@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>, Chris Ball <cjb@laptop.org>
Cc: Madhusudhan <madhu.cr@ti.com>, Kevin Hilman <khilman@ti.com>, linux-omap <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Benoit Cousson <b-cousson@ti.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>
List-Id: linux-mmc@vger.kernel.org

> From: Kevin Hilman <khilman@ti.com>
> Date: Fri, Jul 1, 2011 at 11:24 PM
> Subject: Re: [PATCHv4 0/3] OMAP: HSMMC: cleanup and runtime pm
> To: cjb@laptop.org
> Cc: Balaji T K <balajitk@ti.com>, linux-omap@vger.kernel.org,
> linux-mmc@vger.kernel.org, tony@atomide.com, madhu.cr@ti.com,
> b-cousson@ti.com, paul@pwsan.com, kishore.kadiyala@ti.com
>
>
> Chris,
>
> Balaji T K <balajitk@ti.com> writes:
>
>> Removing the custom state machine - lazy disable framework in
>> omap_hsmmc to make way for runtime pm to handle host controller powe=
r
>> states.
>>
>> This allows mmc_host_enable/mmc_host_disable to be replaced
>> by runtime get_sync and put_sync at host controller driver.
>>
>> Enable runtime PM in omap_hsmmc
>>
>> Rebased to MMC tree : mmc-next branch
>> Tested on OMAP4430SDP, OMAP3430SDP, OMAP2430SDP
>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
> Tested-by: Kevin Hilman <khilman@ti.com>
>
> Could you queue this series for the v3.1 merge window? =A0Or, with yo=
ur
> ack, we are happy to take this through the OMAP tree along with the
> other dependecies mentioned below.
>
> I've also tested this on OMAP4430/Blaze, OMAP3630/Zoom3 and
> OMAP3430/n900.
>
> We have OMAP PM core code changes queued for v3.1 which require the M=
MC
> driver to correctly use runtime PM or we can get hangs if MMC is used
> during boot.
>
> Kevin

Kevin,
  Another series from Per Forlin [1] is also modifying the same file,
and might result in merge conflict if this series is queued under OMAP
and the other is queued by Chris.

Chris,
  If you intend to queue [1] into mmc-next, Balaji / myself can repost
this series on
top of it or you'd like to practice some git merge ? Let me know if
there is anything that I can do to help.

[1] https://lkml.org/lkml/2011/7/1/303

>
>> MMC runtime patch has dependency on
>> [PATCH 0/6] OMAP2+: hwmod framework fixes [1]
>> for MMC1/MMC2 clock to get ungated after idle in OMAP4.
>>
>> Without [1] patches, MMC1/MMC2 fails to get detected on OMAP4.
>>
>> [1] http://www.mail-archive.com/linux-omap@vger.kernel.org/msg51457.=
html
>>
>> Balaji T K (3):
>> =A0 MMC: OMAP: HSMMC: Remove lazy_disable
>> =A0 MMC: OMAP: HSMMC: add runtime pm support
>> =A0 MMC: OMAP: HSMMC: Remove unused iclk
>>
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0365 +++++++-------------------=
---------------
>> =A01 files changed, 57 insertions(+), 308 deletions(-)
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
