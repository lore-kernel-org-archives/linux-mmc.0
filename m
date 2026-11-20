Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185847;
	b=LpevTI09PnaRQ5l5iPPs+ZJ8V5Hzjn9HUkOQkesbynuiy0rCTkW6mPfX+9aUj19tES0x
	 jR/EQBE/WgfshVlOk70WeHwFv8QCciboi7TByKQNVKcsgdcXHGh0vzsAUjeGxSsIgZm5M
	 Q5nQiNAbMuiFC0Sb5Tp5jZYnOGJafOPQioWwu8XFchZxzke/XzHKgHCtOpWYHVPdWvvHw
	 xEjer5A+6/3WinaFc/atYrWtpem3JspcG1s7A0/1Y6j/Q7rNrRdNv4b46K+afWuzrY9GM
	 CNmZ5Y5T/w9BibWxjE6mAXsHVytFJrOLelYYs6dkA63gJIikwJtvAwYZtqfnxv9I/Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185847;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:X-Mailer:References:
	 In-Reply-To:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=M4Xl1y2K7U681cmLm19mvIuC8zvk+I8mQ245EOnKHyM=;
	b=hf7G3rH53l7FxAEbpAEIMQPOJHR/O/Xf0iAZMosALSwYJhr3T1/veFlfbqsTEKcXnj9a
	 DT5THIUwE5r8wKXMJZaQ107UdkipeCppJHqkWIFbKePQUlaSdjx8iO5eUmYbnDcuuP56k
	 M+wP7+IkCAS+dL4p7wl2Empwnyw34JjRaZQpuHLWkQF0l2EDi+kat07+fquYPT40l19fz
	 rvfiBAo9ux2DZL7BLkyvS0eeRu6p9cjDUWudkG+DI6ZmprmhsDh0efCQG6fxU1H+VUyEa
	 Nd1etm+sF4NAShyCo5ggcKo1Sz+KQ4/hxE+IfpAIpunaEOB8fNMERbLMoBbheoo7l0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=pjjonas@web.de header.a=rsa-sha256 header.s=s29768273 header.b=sO5RhVQf;
	arc=none smtp.remote-ip=212.227.15.4
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9500606A320
	for <linux-mmc@vger.kernel.org>; Fri, 20 Nov 2026 14:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9500606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=pjjonas@web.de header.a=rsa-sha256 header.s=s29768273 header.b=sO5RhVQf
DKIM2-Signature:  i=1; m=1; t=1795185838;
 mf=PHBqam9uYXNAd2ViLmRlPg==;
 rt=PGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:IqXy/N3arcl9Js5nucmNG7QMPf55
   XLWVH1WVhZINxqzSezeVHdiuKjxQ2Ocw4zQ+z45oiAm8f8gY6a8bo5V4QCWNEEb2KTa7K/e7Poe
   pW09YEBAggAKF+cyf0XJqe8WpDdh7Q6lE+RRLcPHhmiF1xD/1ZRZL7c1YVPnG+A2euFDmJgTTX/
   GyxEK8rI9a2qKVFWY5C9vp5di9VT3O4qOPcmIMYT+E/0eJRT2AgIUwBTcYsLuQNsH/RqRVfh3qz
   nlQN4KoB4l2xFeKi7Jz8Xc8ViTDMhc9ishOX3LwnoiD9R0S9ndUuSFS9ATxZzbgJS82co2dGsmp
   omktyOuKiq/O7g==;
Message-Instance:  m=1;
 h=sha256:
   4GNQCvfCKDr7KHPzmo9wIkQMHkXSka9P6kS1V8WxN00=:
   k+ZXWroofm6iBUXwAiHqaJw0loKGeCQZwnJn/bqyqc4=,
  sha512:
   ns5I7gjMR6SAB+xZllVuLNeePX0IQ3rCTO1hpvftWeTv9Q+c6KaM2Csre1EzhlQyHswgKTnpqCnwZOj2VgR5RA==:
   pknVmZZ5kEk5YDxYueueOJTTf1F1JbOwe7MXZB7KUbtGw67a0CqUgrdMpmUiXaXYhF70VoI8M7G+QjcmSNGv1A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1795185838; x=1795790638; i=pjjonas@web.de;
	bh=M4Xl1y2K7U681cmLm19mvIuC8zvk+I8mQ245EOnKHyM=;
	h=X-UI-Sender-Class:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=sO5RhVQfvMG8wAPaCQretHDnwgZc8k0QjKmmo0/ksi+Scnxfci4yjGmDimnV8IQJ
	 OAYpXjvvlP1Uh/2ywH/h5C9yIiRSwNTD51wsLbR7PlaaoM7eJjFJBMpxOzfTWPPpD
	 k1/BHcEuPyBzijWu+Sbd0E7PgHIquDiIuXFrqDekvtYFZCPGnYQuXZkVd8YA6+23t
	 OlBd+QcnLyaYlf/A3/oWbk1LBoaP0BhJCtGRM/uITeGSKW6xFBjEvE9VQBqf35hzK
	 ZKBTlt8/HXXCwkJBnB3QQm+nh9hHQ5jgufNGrMCw3fdKtekmGMyftK2S6Ewr4KITs
	 TJE6rYOlZahLe6Rnjw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N2SL5-1yYEIT1c5f-012Ktp; Fri, 20
 Nov 2026 15:43:58 +0100
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 15:43:54 +0100
Message-Id: <DN049N2EXDXT.30B93GJPIZN9S@web.de>
Subject: Re: [REGRESSION] rtsx_usb_sdmmc: RTS5129 (0bda:0129) no longer
 detects SD card
From: "Philipp Jonas" <pjjonas@web.de>
To: "Sean Rhodes" <sean@starlabs.systems>, "Philipp Jonas" <pjjonas@web.de>
Cc: "Thorsten Leemhuis" <regressions@leemhuis.info>,
 <linux-mmc@vger.kernel.org>, <regressions@lists.linux.dev>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Ulf Hansson"
 <ulfh@kernel.org>
X-Mailer: aerc 0.22.0
References: <523eb7d1cc0811df4a5e4c534538f3dd@web.de>
 <eb52777b-8607-427b-a709-cf1ab76ef672@leemhuis.info>
 <DMV8DI3F257U.DPLVLW2DZC3Z@web.de>
 <CABtds-3f_Gcsd6_vgcbqiAoN-9AUwHg5cr71VetRpO5jC4ZxFw@mail.gmail.com>
 <DMZEIO23VCO0.2BB6F5495FHVG@web.de>
 <CABtds-0DNu1HP1M5qf34SWEMoYW3i9jkNxOYg5+7gywGU01nwg@mail.gmail.com>
In-Reply-To: <CABtds-0DNu1HP1M5qf34SWEMoYW3i9jkNxOYg5+7gywGU01nwg@mail.gmail.com>
X-Provags-ID: V03:K1:cKMLbQkq99PURCAjcRig11DpmX2hgjDyG/KfMbxJYSH+C5PalLj
 81pygAGSzpyQtR+V3NKMnxKlq3sMqikznhsSnYpmaZFbN/whd9E/qZHupO2QccxBTRDgn5d
 CeJfDCD3MWbUoNOxZJoNbdJhGN+iRRJs+4T8jMFM6+uM6F2wFmLi4gqa19n8yTa6t2L3mBH
 NY10Heoom6fztjCMXOHEg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iLZVXx8FPG4=;iPJdAg5gB7+N7gSa4t6T1wAhLrC
 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

On Thu Nov 19, 2026 at 11:10 PM CET, Sean Rhodes wrote:
> Hi
>
> Thanks - I don't have any cards that old to test with, but the attached
> should work (borrowed from the old driver that was removed)
>
> Sean
>
> On Thu, 19 Nov 2026 at 18:53, Philipp Jonas <pjjonas@web.de> wrote:
>
>> On Thu Nov 19, 2026 at 3:35 PM CET, Sean Rhodes wrote:
>> > Hi
>> >
>> > Could you share the trace from a failing 7.3.4? And what card was it?
>> >
>> > Thanks
>> >
>> > Sean
>> >
>> > On Sat, 14 Nov 2026 at 20:54, Philipp Jonas <pjjonas@web.de> wrote:
>> >
>> >> On Wed Nov 11, 2026 at 10:06 AM CET, Thorsten Leemhuis wrote:
>> >> > On 11/8/26 19:51, Philipp wrote:
>> >> >>
>> >> >> the SD card in the internal Realtek RTS5129 USB card reader
>> >> >> (0bda:0129) of my Lenovo V110-15IKB is no longer detected.
>> >> >>
>> >> >> Works:  6.12.116, 7.2.x
>> >> >> Broken: 6.18.x, 7.3.3
>> >> >>
>> >> >> On broken kernels rtsx_usb and rtsx_usb_sdmmc load and the platfor=
m
>> >> >> devices rtsx_usb_sdmmc.0.auto / rtsx_usb_ms.1.auto exist, but no
>> >> >> mmc host/card appears (no mmc0, no mmcblk0) and there are no error=
s
>> >> >> in dmesg. Reloading rtsx_usb / rtsx_usb_sdmmc, re-inserting the ca=
rd
>> >> >> and disabling USB autosuspend (power/control=3Don) do not help.
>> >> >>
>> >> >> Since 7.2.x worked but 6.18.x does not, I suspect a change that wa=
s
>> >> >> backported to stable.
>> >> >
>> >> > Might, but might not -- and I wonder if you have two bugs, some rac=
e,
>> or
>> >> > if some .config setting is disturbing something. Overall this
>> situations
>> >> > is somewhat puzzling. The best way to bring some light into this is
>> >> afaics:
>> >> >
>> >> > Check if 7.2 is working; if it is, bisect between that and 7.3.3; o=
f
>> >> > not, bisect between 7.2 and 7.2.x to find what fixes things. And
>> ensure
>> >> > to use the same .config as a base during the bisection, as explaine=
d
>> >> here:
>> >> >
>> >>
>> https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.h=
tml
>> >> >
>> >> > dmesg outputs from a working and a not-that-different version that =
is
>> >> > broken (say 7.2 and 7.3.3) would be helpful, too.
>> >> >
>> >> > Ciao, Thorsten
>> >>
>> >> I found the culprit:
>> >>
>> >>   7185b6d33b17 ("mmc: rtsx_usb_sdmmc: suppress false CD after init
>> >> timeout")
>> >>
>> >> Reverting just that commit on top of 7.3.4 fixes it. Same kernel
>> >> version and config, the revert being the only difference:
>> >>
>> >>   7.3.4:           card not detected
>> >>   7.3.4 + revert:  card detected again
>> >>
>> >> dmesg with the revert:
>> >>
>> >> [    4.133620] usbcore: registered new interface driver rtsx_usb
>> >> [    5.582812] mmc0: new high speed SD card at address b368
>> >> [    5.638774] mmcblk0: mmc0:b368 SD 1.90 GiB
>> >>
>> >> Without the revert, nothing card related shows up after the
>> >> rtsx_usb line.
>> >>
>> >> Hardware: Lenovo V110-15IKB, internal Realtek RTS5129 (0bda:0129),
>> >> no tray, plain SD slot. The card is permanently inserted and holds
>> >> a LUKS key, so it has to be detected during boot.
>> >>
>> >> Judging from the commit message, I assume an init command times out
>> >> before the card is attached, suppress_cd gets set, and as the card
>> >> is never removed, raw SD_CD never drops and the suppression is never
>> >> cleared. Note that physically removing and re-inserting the card on
>> >> 7.3.3 did not bring it back either, so the clearing path does not
>> >> seem to work here as intended.
>> >>
>> >> Sean, Greg, Ulf: CCing you as author/acker/committer.
>> >> Happy to test patches.
>> >>
>> >> #regzbot introduced: 7185b6d33b17
>> >>
>> >> Philipp
>> >>
>>
>> Hi,
>>
>> Attached is the full dmesg from an unpatched 7.3.4, booted with
>> rtsx_usb_sdmmc.dyndbg=3D+p rtsx_usb.dyndbg=3D+p mmc_core.dyndbg=3D+p
>> The card was inserted the whole time.
>>
>> The relevant part:
>>
>> [    4.273107] mmc0: starting CMD0 arg 00000000 flags 000000c0
>> [    4.274391] mmc0: req done (CMD0): 0: 00000000 00000000 00000000
>> 00000000
>> [    4.277087] mmc0: starting CMD8 arg 000001aa flags 000002f5
>> [    4.909018] rtsx_usb_sdmmc rtsx_usb_sdmmc.0.auto: rtsx_usb_get_rsp
>> failed (err =3D -110)
>> [    4.909149] mmc0: req done (CMD8): -110: 00000000 00000000 00000000
>> 00000000
>> [    4.909157] mmc0: starting CMD55 arg 00000000 flags 000000f5
>> [    4.909313] rtsx_usb_sdmmc rtsx_usb_sdmmc.0.auto: cmd->error =3D -123
>>
>> After the CMD8 timeout every further command (CMD55, CMD1, and the
>> retries at 300 and 250 kHz) fails immediately with -ENOMEDIUM. The
>> same pattern repeats at ~82s after runtime resume.
>>
>> The card is a 2 GB standard capacity SD card, so most likely SD 1.x,
>> which per spec does not respond to CMD8 at all. On 7.2 the core then
>> simply continued with CMD55/ACMD41. With 7185b6d33b17 that CMD8
>> timeout is treated as "no media", so I suspect all pre-SD 2.0 cards
>> are affected, not just mine.
>>
>> Philipp
>>

Works for me, the card is detected again on 7.3.4 with your patch
applied (and without the revert):

[    5.647781] mmc0: new high speed SD card at address b368
[    5.693354] mmcblk0: mmc0:b368 SD 1.90 GiB

Tested-by: Philipp Jonas <pjjonas@web.de>

Thanks!
Philipp
