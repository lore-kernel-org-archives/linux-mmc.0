From: David Strobach <lalochcz@gmail.com>
Subject: kernel 2.6.38.6 MMC controller problem (fwd)
Date: Mon, 16 May 2011 10:42:10 +0200
Message-ID: <BANLkTinJem0PdpCmRBSpVzarDqevkjc6Lg@mail.gmail.com>
References: <Pine.LNX.4.64.1105160830420.4131@axis700.grange>
	<BANLkTinbJfDLp5nfkq-VTYLJvihT1thXvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=90e6ba2121879d064604a360a109
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64562 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752795Ab1EPImL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 May 2011 04:42:11 -0400
Received: by iwn34 with SMTP id 34so3736323iwn.19
        for <linux-mmc@vger.kernel.org>; Mon, 16 May 2011 01:42:10 -0700 (PDT)
In-Reply-To: <BANLkTinbJfDLp5nfkq-VTYLJvihT1thXvA@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org

--90e6ba2121879d064604a360a109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

It's actually an oops. The backtrace is attached.

David

On Mon, May 16, 2011 at 09:06, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
>
> (added the ML and previous discussion participants to CC)
>
> Looks like my patch was indeed less obviious, than we thought. We need a
> lock-up backtrace, I guess. David, can you use a sysrq to get a trace?
> Something like
>
> echo w > /proc/sysrq-trigger
> or even
> echo t > /proc/sysrq-trigger
>
> and provide traces? The one with 't' will be probably huge, so, maybe you
> could do it with as few tasks running as possible, maybe without a
> graphical login. Or I would have to test it with my Laptop, to which I'll
> get access tomorrow.
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski, Ph.D.
> Freelance Open-Source Software Developer
> http://www.open-technology.de/
>
> ---------- Forwarded message ----------
> Date: Mon, 16 May 2011 01:57:04 +0200
> From: David Strobach <lalochcz@gmail.com>
> To: gregkh@suse.de, g.liakhovetski@gmx.de
> Cc: horms@verge.net.au, damm@opensource.se
> Subject: kernel 2.6.38.6 MMC controller problem
>
> Hello,
>
> I found (by bisection), that the commit 3fe962c (
> http://git.kernel.org/?p=3Dlinux/kernel/git/stable/linux-2.6.38.y.git;a=
=3Dcommit;h=3D3fe962c04818a4634255beb3be9f236d36350543)
> introduced regression in MMC card detection. The card is either not detec=
ted
> or causes the system to hang. There is related forum thread at
> https://bbs.archlinux.org/viewtopic.php?id=3D118751. Relevant part of my =
own
> log follows:
>
> May 16 00:15:13 localhost kernel: [ =A0134.670685] mmc0: new SD card at
> address aaaa
> May 16 00:15:23 localhost kernel: [ =A0144.715115] mmc0: Timeout waiting =
for
> hardware interrupt.
> May 16 00:15:23 localhost kernel: [ =A0144.715119] sdhci: =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D REGISTER
> DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> May 16 00:15:23 localhost kernel: [ =A0144.715126] sdhci: Sys addr: 0xbae=
85840
> | Version: =A00x00000400
> May 16 00:15:23 localhost kernel: [ =A0144.715133] sdhci: Blk size: 0x000=
07040
> | Blk cnt: =A00x00000001
> May 16 00:15:23 localhost kernel: [ =A0144.715140] sdhci: Argument: 0x000=
00200
> | Trn mode: 0x00000013
> May 16 00:15:23 localhost kernel: [ =A0144.715146] sdhci: Present: =A00x0=
1ff0001
> | Host ctl: 0x00000003
> May 16 00:15:23 localhost kernel: [ =A0144.715153] sdhci: Power: =A0 =A00=
x0000000f
> | Blk gap: =A00x00000000
> May 16 00:15:23 localhost kernel: [ =A0144.715159] sdhci: Wake-up: =A00x0=
0000000
> | Clock: =A0 =A00x00000100
> May 16 00:15:23 localhost kernel: [ =A0144.715166] sdhci: Timeout: =A00x0=
0000009
> | Int stat: 0x00000000
> May 16 00:15:23 localhost kernel: [ =A0144.715172] sdhci: Int enab: 0x02f=
f00cb
> | Sig enab: 0x02ff00cb
> May 16 00:15:23 localhost kernel: [ =A0144.715178] sdhci: AC12 err: 0x000=
00000
> | Slot int: 0x00000000
> May 16 00:15:23 localhost kernel: [ =A0144.715185] sdhci: Caps: =A0 =A0 0=
x01e032b2
> | Caps_1: =A0 0x00000000
> May 16 00:15:23 localhost kernel: [ =A0144.715192] sdhci: Cmd: =A0 =A0 =
=A00x0000101a
> | Max curr: 0x00000040
> May 16 00:15:23 localhost kernel: [ =A0144.715194] sdhci:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> May 16 00:15:31 localhost kernel: [ =A0152.604505] mmc0: Card removed dur=
ing
> transfer!
> May 16 00:15:31 localhost kernel: [ =A0152.604511] mmc0: Resetting contro=
ller.
> May 16 00:15:31 localhost kernel: [ =A0152.604568] mmcblk0: unable to set
> block size to 512: -123
> May 16 00:15:31 localhost kernel: [ =A0152.604687] mmcblk: probe of mmc0:=
aaaa
> failed with error -22
> May 16 00:15:31 localhost kernel: [ =A0152.801534] mmc0: card aaaa remove=
d
> May 16 00:15:31 localhost kernel: [ =A0152.814827] mmc0: Got command inte=
rrupt
> 0x00030000 even though no command operation was in progress.
> May 16 00:15:31 localhost kernel: [ =A0152.814835] sdhci: =3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D REGISTER
> DUMP (mmc0)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> May 16 00:15:31 localhost kernel: [ =A0152.814844] sdhci: Sys addr: 0xbae=
85840
> | Version: =A00x00000400
> May 16 00:15:31 localhost kernel: [ =A0152.814853] sdhci: Blk size: 0x000=
07040
> | Blk cnt: =A00x00000001
> May 16 00:15:31 localhost kernel: [ =A0152.814860] sdhci: Argument: 0x000=
00200
> | Trn mode: 0x00000013
> May 16 00:15:31 localhost kernel: [ =A0152.814867] sdhci: Present: =A00x0=
1f00001
> | Host ctl: 0x00000000
> May 16 00:15:31 localhost kernel: [ =A0152.814874] sdhci: Power: =A0 =A00=
x0000000f
> | Blk gap: =A00x00000000
> May 16 00:15:31 localhost kernel: [ =A0152.814881] sdhci: Wake-up: =A00x0=
0000000
> | Clock: =A0 =A00x00004007
> May 16 00:15:31 localhost kernel: [ =A0152.814888] sdhci: Timeout: =A00x0=
0000009
> | Int stat: 0x00000000
> May 16 00:15:31 localhost kernel: [ =A0152.814895] sdhci: Int enab: 0x00f=
f00c3
> | Sig enab: 0x00ff00c3
> May 16 00:15:31 localhost kernel: [ =A0152.814902] sdhci: AC12 err: 0x000=
00000
> | Slot int: 0x00000000
> May 16 00:15:31 localhost kernel: [ =A0152.814909] sdhci: Caps: =A0 =A0 0=
x01e032b2
> | Caps_1: =A0 0x00000000
> May 16 00:15:31 localhost kernel: [ =A0152.814916] sdhci: Cmd: =A0 =A0 =
=A00x0000101a
> | Max curr: 0x00000040
> May 16 00:15:31 localhost kernel: [ =A0152.814919] sdhci:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> Regards
> David Strobach

--90e6ba2121879d064604a360a109
Content-Type: application/octet-stream; name=mmc-oops
Content-Disposition: attachment; filename=mmc-oops
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gnr5pubc0

WyAgMzU0LjQ4NDY3Nl0gbW1jMDogbmV3IFNESEMgY2FyZCBhdCBhZGRyZXNzIGIzNjgKWyAgMzU0
LjQ4NTU2N10gbW1jYmxrMDogbW1jMDpiMzY4IE5DYXJkIDMuNzIgR2lCIApbICAzNTQuNDg2NDMx
XSBkaXZpZGUgZXJyb3I6IDAwMDAgWyMxXSBQUkVFTVBUIFNNUCAKWyAgMzU0LjQ4NzI5M10gbGFz
dCBzeXNmcyBmaWxlOiAvc3lzL2RldmljZXMvdmlydHVhbC9iZGkvMTc5OjAvdWV2ZW50ClsgIDM1
NC40ODgyNzFdIENQVSAzIApbICAzNTQuNDg4NTg4XSBNb2R1bGVzIGxpbmtlZCBpbjogbW1jX2Js
b2NrIHVzYmhpZCBoaWQgbmV0Y29uc29sZSBjb25maWdmcyBleHQyIGJ0dXNiIGJsdWV0b290aCB2
Ym94ZHJ2IGNwdWZyZXFfb25kZW1hbmQgYWNwaV9jcHVmcmVxIGZyZXFfdGFibGUgbXBlcmYgdXZj
dmlkZW8gdmlkZW9kZXYgdjRsMl9jb21wYXRfaW9jdGwzMiBzbmRfaGRhX2NvZGVjX2hkbWkgdHBt
X2luZmluZW9uIHNuZF9oZGFfY29kZWNfcmVhbHRlayBzbmRfaGRhX2ludGVsIG52aWRpYShQKSBz
bmRfaGRhX2NvZGVjIHNuZF9wY20gc25kX3RpbWVyIHNuZF9wYWdlX2FsbG9jIHNuZF9od2RlcCBq
b3lkZXYgaTJjX2NvcmUgYXJjNCBzbmRfbWl4ZXJfb3NzIGVjYiB0cG1fdGlzIGVoY2lfaGNkIHRw
bSB0b3NoaWJhX2FjcGkgc3BhcnNlX2tleW1hcCB0cG1fYmlvcyB1c2Jjb3JlIHNnIHRvc2hpYmFf
Ymx1ZXRvb3RoIHByb2Nlc3NvciBzbmQgdGhlcm1hbCBiYXR0ZXJ5IGJ1dHRvbiBwc21vdXNlIHZp
ZGVvIGFjIHNvdW5kY29yZSBwY3Nwa3IgaXdsYWduIGl3bGNvcmUgc2VyaW9fcmF3IG1hYzgwMjEx
IGNmZzgwMjExIHJma2lsbCBzZGhjaV9wY2kgc2RoY2kgbW1jX2NvcmUgaW50ZWxfaXBzIGludGVs
X2FncCBpVENPX3dkdCBpbnRlbF9ndHQgaVRDT192ZW5kb3Jfc3VwcG9ydCBldmRldiBlMTAwMGUg
ZXh0NCBtYmNhY2hlIGpiZDIgY3JjMTYgZG1fbW9kIHNyX21vZCBjZHJvbSBzZF9tb2QgYWhjaSBs
aWJhaGNpIGxpYmF0YSBzY3NpX21vZApbICAzNTQuNTAxMTUzXSAKWyAgMzU0LjUwMTM4OV0gUGlk
OiAzMDY1LCBjb21tOiBtbWNxZC8wIFRhaW50ZWQ6IFAgICAgICAgICAgICAyLjYuMzgtQVJDSCAj
MSBUT1NISUJBIFRFQ1JBIFMxMS9Qb3J0YWJsZSBQQwpbICAzNTQuNTAzMDE5XSBSSVA6IDAwMTA6
WzxmZmZmZmZmZmEwMTI3Zjk1Pl0gIFs8ZmZmZmZmZmZhMDEyN2Y5NT5dIHNkaGNpX3NlbmRfY29t
bWFuZCsweDU3NS8weGJmMCBbc2RoY2ldClsgIDM1NC41MDQ1MzJdIFJTUDogMDAxODpmZmZmODgw
MTJjNWQxYjYwICBFRkxBR1M6IDAwMDEwMDQ2ClsgIDM1NC41MDUzNjhdIFJBWDogMDAwMDAwMDAw
MDAwMDAwMCBSQlg6IGZmZmY4ODAxMmUzM2ZjODAgUkNYOiAwMDAwMDAwMDAwMDAwMDAwClsgIDM1
NC41MDY0OTldIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDgwMDAwODUgUkRJ
OiBmZmZmODgwMTJlMzNmODAwClsgIDM1NC41MDc2MjNdIFJCUDogZmZmZjg4MDEyYzVkMWJlMCBS
MDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDEwNjI0ZGQzClsgIDM1NC41MDg3NDdd
IFIxMDogMDAwMDAwMDAwMDAwMDAwMSBSMTE6IDAwMDAwMDAwMDAwMDAwMDEgUjEyOiBmZmZmODgw
MTJjNWQxY2UwClsgIDM1NC41MDk4NzhdIFIxMzogZmZmZjg4MDEyYzVkMWQ1MCBSMTQ6IDAwMDAw
MDAwMDAwMDAwMDMgUjE1OiBmZmZmODgwMTJjNzBmYzAwClsgIDM1NC41MTEwMDJdIEZTOiAgMDAw
MDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmODgwMGJlZWMwMDAwKDAwMDApIGtubEdTOjAwMDAw
MDAwMDAwMDAwMDAKWyAgMzU0LjUxMjI4MF0gQ1M6ICAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENS
MDogMDAwMDAwMDA4MDA1MDAzYgpbICAzNTQuNTEzMTg4XSBDUjI6IDAwMDA3ZjJmOWM4ODEyMDAg
Q1IzOiAwMDAwMDAwMDAxNjkzMDAwIENSNDogMDAwMDAwMDAwMDAwMDZlMApbICAzNTQuNTE0MzEy
XSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAw
MDAwMDAwMDAwMApbICAzNTQuNTE1NDM2XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAw
MDAwMGZmZmYwZmYwIERSNzogMDAwMDAwMDAwMDAwMDQwMApbICAzNTQuNTE2NTY3XSBQcm9jZXNz
IG1tY3FkLzAgKHBpZDogMzA2NSwgdGhyZWFkaW5mbyBmZmZmODgwMTJjNWQwMDAwLCB0YXNrIGZm
ZmY4ODAxMmIxYzc1ZjApClsgIDM1NC41MTc4ODNdIFN0YWNrOgpbICAzNTQuNTE4MjAwXSAgZmZm
Zjg4MDEyYzVkMWJmMCBmZmZmZmZmZmEwMTUyZTNjIDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAw
MDAwMDAwMApbICAzNTQuNTE5NDg3XSAgZmZmZjg4MDEyYjFjNzVmMCAwMDAwMDAwMDAwMDAwMDAw
IDAwMDAwMDAwMDAwMDAwMDAgZmZmZjg4MDEyYjFjNzVmMApbICAzNTQuNTIwNzY1XSAgZmZmZmZm
ZmY4MTA1MWYyMCAwMDAwMDAwMDAwMDAwMjg2IGZmZmY4ODAxMmM1ZDFiZDAgZmZmZjg4MDEyZTMz
ZjgwMApbICAzNTQuNTIyMDQ0XSBDYWxsIFRyYWNlOgpbICAzNTQuNTIyNDQxXSAgWzxmZmZmZmZm
ZmEwMTUyZTNjPl0gPyBfX21tY19jbGFpbV9ob3N0KzB4MTJjLzB4MTgwIFttbWNfY29yZV0KWyAg
MzU0LjUyMzU0M10gIFs8ZmZmZmZmZmY4MTA1MWYyMD5dID8gZGVmYXVsdF93YWtlX2Z1bmN0aW9u
KzB4MC8weDEwClsgIDM1NC41MjQ1MThdICBbPGZmZmZmZmZmYTAxMjg2Zjk+XSBzZGhjaV9yZXF1
ZXN0KzB4ZTkvMHgxMTAgW3NkaGNpXQpbICAzNTQuNTI1NDk0XSAgWzxmZmZmZmZmZmEwMTUyNGUy
Pl0gbW1jX3dhaXRfZm9yX3JlcSsweDEwMi8weDE0MCBbbW1jX2NvcmVdClsgIDM1NC41MjY1NzFd
ICBbPGZmZmZmZmZmYTExNTc2YWU+XSBtbWNfYmxrX2lzc3VlX3J3X3JxKzB4MjBlLzB4NjkwIFtt
bWNfYmxvY2tdClsgIDM1NC41Mjc2OTddICBbPGZmZmZmZmZmYTAxNTI1YjA+XSA/IG1tY193YWl0
X2RvbmUrMHgwLzB4MTAgW21tY19jb3JlXQpbICAzNTQuNTI4NzE1XSAgWzxmZmZmZmZmZjgxMWY4
MDE4Pl0gPyBjZnFfZGlzcGF0Y2hfcmVxdWVzdHMrMHgxYjgvMHhiNjAKWyAgMzU0LjUyOTc0MF0g
IFs8ZmZmZmZmZmZhMTE1ODAyZD5dIG1tY19ibGtfaXNzdWVfcnErMHgxMGQvMHgxYTAgW21tY19i
bG9ja10KWyAgMzU0LjUyOTc0Ml0gIFs8ZmZmZmZmZmY4MTFlNWU5ZT5dID8gYmxrX3N0YXJ0X3Jl
cXVlc3QrMHgyZS8weDQwClsgIDM1NC41Mjk3NDRdICBbPGZmZmZmZmZmYTExNTgxYzI+XSBtbWNf
cXVldWVfdGhyZWFkKzB4MTAyLzB4MTMwIFttbWNfYmxvY2tdClsgIDM1NC41Mjk3NDZdICBbPGZm
ZmZmZmZmYTExNTgwYzA+XSA/IG1tY19xdWV1ZV90aHJlYWQrMHgwLzB4MTMwIFttbWNfYmxvY2td
ClsgIDM1NC41Mjk3NTRdICBbPGZmZmZmZmZmODEwNzlhNDc+XSBrdGhyZWFkKzB4ODcvMHg5MApb
ICAzNTQuNTI5NzU4XSAgWzxmZmZmZmZmZjgxMDBiYzI0Pl0ga2VybmVsX3RocmVhZF9oZWxwZXIr
MHg0LzB4MTAKWyAgMzU0LjUyOTc2MF0gIFs8ZmZmZmZmZmY4MTA3OTljMD5dID8ga3RocmVhZCsw
eDAvMHg5MApbICAzNTQuNTI5NzYxXSAgWzxmZmZmZmZmZjgxMDBiYzIwPl0gPyBrZXJuZWxfdGhy
ZWFkX2hlbHBlcisweDAvMHgxMApbICAzNTQuNTI5NzYyXSBDb2RlOiAwMSA0NSAxOSBmNiA0MSA4
MyBlNiBmZSA0MSA4MyBjNiAwMyBlOSBkYyBmYSBmZiBmZiAwZiAxZiA0NCAwMCAwMCA0MSA4YiA0
ZCAwNCA0NCA4YiA4MyA2NCAwMSAwMCAwMCAzMSBkMiA0MSBiOSBkMyA0ZCA2MiAxMCA4OSBjOCA8
NDE+IGY3IGYwIDQxIDhiIDU1IDAwIDg5IGMxIDg5IGQwIDQxIGY3IGUxIGMxIGVhIDA2IDAxIGQx
IDgxIGU2IApbICAzNTQuNTI5Nzc0XSBSSVAgIFs8ZmZmZmZmZmZhMDEyN2Y5NT5dIHNkaGNpX3Nl
bmRfY29tbWFuZCsweDU3NS8weGJmMCBbc2RoY2ldClsgIDM1NC41Mjk3NzddICBSU1AgPGZmZmY4
ODAxMmM1ZDFiNjA+ClsgIDM1NC41Mjk3NzldIC0tLVsgZW5kIHRyYWNlIGYyZTUxMTI4YTdlNzA1
NmEgXS0tLQpbICAzNTQuNTI5NzgwXSBub3RlOiBtbWNxZC8wWzMwNjVdIGV4aXRlZCB3aXRoIHBy
ZWVtcHRfY291bnQgMQo=
--90e6ba2121879d064604a360a109--
