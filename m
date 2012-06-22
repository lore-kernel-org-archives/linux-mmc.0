From: "T Krishnamoorthy, Balaji" <balajitk@ti.com>
Subject: Re: [RFC PATCH] Revert "mmc: omap_hsmmc: Enable Auto CMD12"
Date: Fri, 22 Jun 2012 20:43:46 +0530
Message-ID: <CANrkHUYGLiO8S-Y1ubWmXQffhVGgex=Q=RH3DhwTqyqkZz6SaQ@mail.gmail.com>
References: <1340362175-25807-1-git-send-email-ming.lei@canonical.com>
	<CANrkHUacUKPS=hee6=dhcGAjiC1CS88RNrBNy=wFX5y1Oxb05A@mail.gmail.com>
	<87sjdnjykh.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:35293 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755503Ab2FVPNt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 22 Jun 2012 11:13:49 -0400
Received: by lbok6 with SMTP id k6so4998568lbo.18
        for <linux-mmc@vger.kernel.org>; Fri, 22 Jun 2012 08:13:46 -0700 (PDT)
In-Reply-To: <87sjdnjykh.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Ming Lei <ming.lei@canonical.com>, linux-mmc@vger.kernel.org, Venkatraman S <svenkatr@ti.com>

On Fri, Jun 22, 2012 at 6:25 PM, Chris Ball <cjb@laptop.org> wrote:
> Hi,
>
> On Fri, Jun 22 2012, T Krishnamoorthy, Balaji wrote:
>> On Fri, Jun 22, 2012 at 4:19 PM, Ming Lei <ming.lei@canonical.com> w=
rote:
>>> This patch reverts the commit dba3c29ea4a1d5d544.
>>>
>>> After bisecting, this commit dba3c29 is found to ruin micro-SD card=
 data
>>> (writing incorrect file, or fs is corrupt after several times mount=
)
>>> on the beagle-xm revB, and reverting the commit will fix the proble=
m.
>>
>> Hi Ming,
>> Rather than reverting the entire commit,
>> Can you try with the below change alone, so that AutoCMD12 can be ea=
sily
>> enabled back when needed.
>>
>> @@ -1859,7 +1859,6 @@ static int __devinit omap_hsmmc_probe(st
>> =A0 =A0 =A0 host->mapbase =A0 =3D res->start + pdata->reg_offset;
>> =A0 =A0 =A0 host->base =A0 =A0 =A0=3D ioremap(host->mapbase, SZ_4K);
>> =A0 =A0 =A0 host->power_mode =3D MMC_POWER_OFF;
>> - =A0 =A0 host->flags =A0 =A0 =3D AUTO_CMD12;
>> =A0 =A0 =A0 host->next_data.cookie =3D 1;
>>
>> =A0 =A0 =A0 platform_set_drvdata(pdev, host);
>
> I'm not totally comfortable with that; seems like it should be harder
> to cause data corruption than turning on a single flag in the host.
>
> The full revert is probably best until we know what the underlying
> bug is, and how to disable AUTO_CMD12 on all affected systems.

I tested autocmd12 to be working on OMAP2,3,4 SDP. With beagle board
data corruption is observed with some cards, so it is going to be selec=
tively
enabling/disabling for some SoCs via board data or DT until data corrup=
tion
due to Autocmd12 is root caused.

>
> Thanks,
>
> - Chris.
> --
> Chris Ball =A0 <cjb@laptop.org> =A0 <http://printf.net/>
> One Laptop Per Child
