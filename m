From: Chris Ball <cjb@laptop.org>
Subject: Re: [RFC PATCH] Revert "mmc: omap_hsmmc: Enable Auto CMD12"
Date: Fri, 22 Jun 2012 11:39:46 -0400
Message-ID: <87hau3jqyl.fsf@octavius.laptop.org>
References: <1340362175-25807-1-git-send-email-ming.lei@canonical.com>
	<CANrkHUacUKPS=hee6=dhcGAjiC1CS88RNrBNy=wFX5y1Oxb05A@mail.gmail.com>
	<87sjdnjykh.fsf@octavius.laptop.org>
	<CANrkHUYGLiO8S-Y1ubWmXQffhVGgex=Q=RH3DhwTqyqkZz6SaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:44259 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755713Ab2FVPjv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 22 Jun 2012 11:39:51 -0400
In-Reply-To: <CANrkHUYGLiO8S-Y1ubWmXQffhVGgex=Q=RH3DhwTqyqkZz6SaQ@mail.gmail.com>
	(T. Krishnamoorthy's message of "Fri, 22 Jun 2012 20:43:46 +0530")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Cc: Ming Lei <ming.lei@canonical.com>, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

Hi,

On Fri, Jun 22 2012, T Krishnamoorthy, Balaji wrote:
>>>> After bisecting, this commit dba3c29 is found to ruin micro-SD car=
d data
>>>> (writing incorrect file, or fs is corrupt after several times moun=
t)
>>>> on the beagle-xm revB, and reverting the commit will fix the probl=
em.
>>>
>>> Hi Ming,
>>> Rather than reverting the entire commit,
>>> Can you try with the below change alone, so that AutoCMD12 can be e=
asily
>>> enabled back when needed.
>>>
>>> @@ -1859,7 +1859,6 @@ static int __devinit omap_hsmmc_probe(st
>>> =C2=A0 =C2=A0 =C2=A0 host->mapbase =C2=A0 =3D res->start + pdata->r=
eg_offset;
>>> =C2=A0 =C2=A0 =C2=A0 host->base =C2=A0 =C2=A0 =C2=A0=3D ioremap(hos=
t->mapbase, SZ_4K);
>>> =C2=A0 =C2=A0 =C2=A0 host->power_mode =3D MMC_POWER_OFF;
>>> - =C2=A0 =C2=A0 host->flags =C2=A0 =C2=A0 =3D AUTO_CMD12;
>>> =C2=A0 =C2=A0 =C2=A0 host->next_data.cookie =3D 1;
>>>
>>> =C2=A0 =C2=A0 =C2=A0 platform_set_drvdata(pdev, host);
>>
>> I'm not totally comfortable with that; seems like it should be harde=
r
>> to cause data corruption than turning on a single flag in the host.
>>
>> The full revert is probably best until we know what the underlying
>> bug is, and how to disable AUTO_CMD12 on all affected systems.
>
> I tested autocmd12 to be working on OMAP2,3,4 SDP. With beagle board
> data corruption is observed with some cards, so it is going to be
> selectively enabling/disabling for some SoCs via board data or DT
> until data corruption due to Autocmd12 is root caused.

So far I agree with Ming that AUTO_CMD12 support should just be reverte=
d
until you understand the root cause circumstances of the corruption and
know how to turn it back on safely.

I'm not willing to build up a blacklist of which boards don't support i=
t
by waiting for more reports of data corruption, and I'm even reluctant
to use a whitelist until we understand more about the nature of the
whitelist.  The effort here should be concentrated on root causing,
not on trying to make per-board decisions without understanding what's
actually going on.

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
