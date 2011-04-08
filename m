From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH v3] mmc: Add ioctl to let userspace apps send ACMDs
Date: Fri, 8 Apr 2011 14:58:09 -0500
Message-ID: <BANLkTi=wPYkrj72ixpN52WewVwsb9Ar-Vg@mail.gmail.com>
References: <alpine.DEB.2.00.1104071816270.10238@peruna>
	<BANLkTin9hfr+VfprkDr-Lc+iY0qShmcnng@mail.gmail.com>
	<alpine.DEB.2.00.1104081202550.15086@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og112.obsmtp.com ([64.18.0.24]:52556 "EHLO
	exprod5og112.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757831Ab1DHT6M convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Apr 2011 15:58:12 -0400
Received: from il93mgrg01.am.mot-mobility.com ([10.176.130.20])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p38JuQIo023375
	for <linux-mmc@vger.kernel.org>; Fri, 8 Apr 2011 15:56:27 -0400 (EDT)
Received: from mail-ww0-f46.google.com (mail-ww0-f46.google.com [74.125.82.46])
	by il93mgrg01.am.mot-mobility.com (8.14.3/8.14.3) with ESMTP id p38JtMXt022872
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=OK)
	for <linux-mmc@vger.kernel.org>; Fri, 8 Apr 2011 15:56:26 -0400 (EDT)
Received: by mail-ww0-f46.google.com with SMTP id 28so4480246wwb.3
        for <linux-mmc@vger.kernel.org>; Fri, 08 Apr 2011 12:58:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104081202550.15086@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

Hi John,

On Fri, Apr 8, 2011 at 2:20 PM, John Calixto
<john.calixto@modsystems.com> wrote:
> Hi Andrei,
>
> On Fri, 8 Apr 2011, Andrei Warkentin wrote:
>
>> Hi John,
>>
>> On Thu, Apr 7, 2011 at 8:18 PM, John Calixto
>> <john.calixto@modsystems.com> wrote:
>> > + =A0 =A0 =A0 /* data.flags must already be set before doing this.=
 */
>> > + =A0 =A0 =A0 mmc_set_data_timeout(&data, card);
>> > + =A0 =A0 =A0 /* Allow overriding the timeout_ns for empirical tun=
ing. */
>> > + =A0 =A0 =A0 if (idata->ic.force_timeout_ns)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data.timeout_ns =3D idata->ic.force_=
timeout_ns;
>> > +
>>
>> Are there any R1B ACMDs?
>>
>
> Yes, there are. =A0Do you think this timeout is unnecessary? =A0We fo=
und it
> useful to adjust this to be more accepting of some cheaper cards that
> exceeded the timeout in the spec (250 ms).

Is the timeout fixed or variable (I've seen all timeouts in the
simplified ASSD to be specified in units of 250ms in fields of
ASSD-PR)? Are you using this force_timeout_ns for DAT-transfer
commands also, or just for R1B commands?

Do you always invoke commands that only involve transfers? If not, I
can see how your code handles R1B command timeouts correctly (always
pretends it's a data transfer, even if 0-byte sized - thus host driver
sets timeout correctly). In my boot partition patch set, there are two
changes that add cmd_timeout (for DAT-busy commands) and enable proper
handling of it for SDHCI. Obviously, none of the other hosts are
fixed, so I guess what you are doing is okay for now. Could you add a
"cmd_timeout" field to your ioctl, however, so in the future this is
not a breaking change? Then right now you could add something like -

if (blksz * blocks =3D=3D 0) {

    /*
     * We're doing a R1B command and relying on the host driver to
compute timeout as if
     * we were doing a data transfer. When all host drivers are fixed
to handle R1B right, we won't have to rely
     * on this behavior, and can make mrq.data NULL in this case, and
pass the timeout
     * through cmd.cmd_timeout.
     */
    data.timeout_ns =3D idata->cmd_timeout;
}

and in the future it can be changed to -

if (blksz * blocks =3D=3D 0) {
   mrq.data =3D NULL;
   cmd.cmd_timeout =3D idata->cmd_timeout;
}


>
> In practice, 100 us. =A0Borderline? =A0Note that this sleep is separa=
te from
> the timeout above. =A0This one is specifically for read operations wh=
ere
> there is no such thing as "busy".
>

You mean 'write'? I don't know. Nasty, really, in my opinion. If
you're doing ASSD operations then you know if the card is busy or not
(via ASSD-state) . As in something like this paragraph from the
simplified ASSD?

         "The card shall not assert the BUSY signal for time periods
longer then the WR_SEC_BUS_BUSY as
         defined in the card properties register. The only indication
for completion of a secure Token execution is
         the ASSD_STATE field in the card status register. The host
shall validate that the card is in the correct
         state before attempting any ASSD command."

If so, maybe it's worthwhile to just make your user code use SEND_PSI
to get the ASSD_STATE registers and verify that previous secure
operation completed before sending another one.

Anyone else have an opinion on this?

If this is not ASSD but something else, maybe you have a status
register to query someplace?

>> I'm not sure I understand why blksz is passed. If you needed to set
>> the block size (via CMD16) prior to some command (like MMC password
>> protection) I could kind of get it, but then all I see the blk size
>> getting used for is calculating the data amount in bytes, so you're
>> not doing that. So why not just infer it from the card queue?
>>
>
> The block size for some commands is strictly specified, and does
> change according to the command. =A0In these cases, you do not call C=
MD16
> to change it. =A0You just call the command knowing that its block siz=
e is
> fixed according to spec.
>

Ah okay.

A
