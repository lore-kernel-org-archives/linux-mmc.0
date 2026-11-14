Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794689635;
	b=atRtAqMch353oM1b0TxYU34fIMmR6eewfYw8+tdeI6IV/0YqkmET53MxynqT2H34+s9E
	 O6TZhTVE6cBkknH2wBVvRSanzRmSWwh9Dtfq26F6Kuwne1mkrc3Y1GUu/2TJ6yaBXSB+z
	 GzTLOMjMl2JFUk7QKfjYqUOi0aa3K4IhQ7PYeZdFHzUNK7QSqA2nsLso9oP0/kXY11HCX
	 9aXVzUnblV9eFGOPw40hR7BaibraXSKQgmIWhUTnjFPGHutWrOiWCPGshtdSlP4a50D0b
	 L4NQygyXCs+GuNNX1xxkr8nMS8vdo0MyjgZw4OfEx7KOLYYE2eBScvWr/yKMkgMERdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794689635;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
	bh=RUSch1jwRpHlWQSJdR2mOWWkzt6lR/un0SRxwgp5/jg=;
	b=bEQoIPpJRT2jBbKbv5HIDZAvqJYM4Fkh52trPENHO+Y6y3ga5tr3//F1mzNsnGSUaePs
	 N1lNAdVM+dV3GnpsYkeVEVpRd/6GhYLO0Ph5Ce8IXtJhhfIkU1CBHqZ+bSGuo71Wk/Pp4
	 3GHopOtPhgDopzzYBfo9jVBVF4z7T2ehu+9+nvArq7B4XhoxbVoDVs0KI6Eum3/0Dunsp
	 1HMuh9E2Ym1RN0ZNOk5Et8I10P28x0/xwQwziuThk2HnepD1ScdPV8psUz3G2JV/E9A6j
	 rks8qqdbxy0JxfDpey7idXMta8P4nEwdB9vxLuyzW3kEWFAh+VqBJOPJMAtUg7Sx6qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=web.de;
	spf=pass smtp.mailfrom=web.de;
	dkim=pass header.d=web.de header.i=pjjonas@web.de header.a=rsa-sha256 header.s=s29768273 header.b=mU59uasT;
	arc=none smtp.remote-ip=212.227.15.3
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD14606A327
	for <linux-mmc@vger.kernel.org>; Sat, 14 Nov 2026 20:53:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD14606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=pjjonas@web.de header.a=rsa-sha256 header.s=s29768273 header.b=mU59uasT
DKIM2-Signature:  i=1; m=1; t=1794689632;
 mf=PHBqam9uYXNAd2ViLmRlPg==;
 rt=PGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+;
 d=web.de;
 s=s29768273:rsa-sha256:QafUY8VXgl/RSDdDk7jgyvXcL5Ck
   O0oRrWt0h3JlRpWpkwFnShus3hKZR+tG9cfns4yYqAHtwOtqf5p/lDdY28wVki5I+aWVndSBk4u
   PLMwe7tbjyE9WnHxpyUIc9Yfspy6w3nuOeL5VUq1uvjojcRQdeY2D0iJ8y987pbsmkWMj/f5Y3x
   hazGMjw+UVYbc4rYDuu57V8HLw7OezT1EH5tJp1tNEYKjCJU3eMv+zUY7hrH89V0TQywNsArVDJ
   e/7OyVjkZ7Kg9GnqPI45fEdIhln/eyTuztHlKP/HZ4C2xhppy2XZqUqTxWLjkm64YGKlMx2AJK+
   TI8/ktXmCLASKA==;
Message-Instance:  m=1;
 h=sha256:
   yGfjYqKPionkxphC6ogVHALRg9Ri8fHJA/1Tldur/SY=:
   ccsEHEfd882jxVU61GzF7IARbsaFqo9r9rkVD5leH+c=,
  sha512:
   rKRAdRHUAKfszy5AUAvy840L9g8AZ5lJk5lWxSL1k++ztdeInIECyZ00PVoGd+Jmmga4N288QwEXyGQsZdf+iQ==:
   5eW2NWW00xLScUonPRDePYgTy1IzXVs9E/6RzXDWlHAWNpJyak3s6ywGbtfg0V3dWQ2gEi03i6F8tMDsnNixIg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1794689625; x=1795294425; i=pjjonas@web.de;
	bh=RUSch1jwRpHlWQSJdR2mOWWkzt6lR/un0SRxwgp5/jg=;
	h=X-UI-Sender-Class:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:cc:content-transfer-encoding:content-type:date:from:
	 message-id:mime-version:reply-to:subject:to;
	b=mU59uasTEgp7w9pHnXVvkp7JY2ujdlaOvNXtPcuL2IBUiFAp6lH0gj48kHkGzuKa
	 tE9VxcspgZmUWvX1e0wzgAzSNV3mmTLKi2oX6DPwiGxUyf2yTgjVI60MhHloknjCb
	 dftYyRxABt0J2mXbRRZk4akUwmlmbtlIag2oC5M9Wt56e7Lk9HxzaINInvrbbdDoy
	 HqTsfPc7LgjjJ2qw5lo3nq7CfGV/kvXniE5nSskSU752hA+O1DHA/CMjt21710+9c
	 lV/T2TQ1TYYt5Vp37UbiQn3A3Zd26aR6dQBp7gn6Fh2pzk3JiCsFOo849A2iZttL2
	 sS57ZDRz7jz4VZ8Tzw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M2xrs-1xREI82JzA-00DgkK; Sat, 14
 Nov 2026 21:53:44 +0100
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
Date: Sat, 14 Nov 2026 21:53:41 +0100
Message-Id: <DMV8DI3F257U.DPLVLW2DZC3Z@web.de>
Cc: <regressions@lists.linux.dev>, "Sean Rhodes" <sean@starlabs.systems>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Ulf Hansson"
 <ulfh@kernel.org>
Subject: Re: [REGRESSION] rtsx_usb_sdmmc: RTS5129 (0bda:0129) no longer
 detects SD card
From: "Philipp Jonas" <pjjonas@web.de>
To: "Thorsten Leemhuis" <regressions@leemhuis.info>, "Philipp"
 <pjjonas@web.de>, <linux-mmc@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <523eb7d1cc0811df4a5e4c534538f3dd@web.de>
 <eb52777b-8607-427b-a709-cf1ab76ef672@leemhuis.info>
In-Reply-To: <eb52777b-8607-427b-a709-cf1ab76ef672@leemhuis.info>
X-Provags-ID: V03:K1:psjxO2sb6wRumoqe05ywfgkQqQnPV28Zb2A/mmMKF6+qgt3ix3w
 PC6XPM3X/NtYE1xa4O3vVxwhpNBRGWVO/pf8d7Gxtb3zFlwQjrRuEKqF6saKjaI7T8el5a4
 eezGc/4NMd4VNTD+v5qcOA1lDcIiNQEsrCB96Ffjjn7nuUrdp4lLubGCmg1CIghK5OFLtkk
 UVLcd1MZOEae13qz5MVow==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:o8GG9+fGZ8Q=;DPDRwAakohGhDtHzLCd7i7krjeS
 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

On Wed Nov 11, 2026 at 10:06 AM CET, Thorsten Leemhuis wrote:
> On 11/8/26 19:51, Philipp wrote:
>>=20
>> the SD card in the internal Realtek RTS5129 USB card reader
>> (0bda:0129) of my Lenovo V110-15IKB is no longer detected.
>>=20
>> Works:  6.12.116, 7.2.x
>> Broken: 6.18.x, 7.3.3
>>=20
>> On broken kernels rtsx_usb and rtsx_usb_sdmmc load and the platform
>> devices rtsx_usb_sdmmc.0.auto / rtsx_usb_ms.1.auto exist, but no
>> mmc host/card appears (no mmc0, no mmcblk0) and there are no errors
>> in dmesg. Reloading rtsx_usb / rtsx_usb_sdmmc, re-inserting the card
>> and disabling USB autosuspend (power/control=3Don) do not help.
>>=20
>> Since 7.2.x worked but 6.18.x does not, I suspect a change that was
>> backported to stable.
>
> Might, but might not -- and I wonder if you have two bugs, some race, or
> if some .config setting is disturbing something. Overall this situations
> is somewhat puzzling. The best way to bring some light into this is afaic=
s:
>
> Check if 7.2 is working; if it is, bisect between that and 7.3.3; of
> not, bisect between 7.2 and 7.2.x to find what fixes things. And ensure
> to use the same .config as a base during the bisection, as explained here=
:
> https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.ht=
ml
>
> dmesg outputs from a working and a not-that-different version that is
> broken (say 7.2 and 7.3.3) would be helpful, too.
>
> Ciao, Thorsten

I found the culprit:

  7185b6d33b17 ("mmc: rtsx_usb_sdmmc: suppress false CD after init timeout"=
)

Reverting just that commit on top of 7.3.4 fixes it. Same kernel
version and config, the revert being the only difference:

  7.3.4:           card not detected
  7.3.4 + revert:  card detected again

dmesg with the revert:

[    4.133620] usbcore: registered new interface driver rtsx_usb
[    5.582812] mmc0: new high speed SD card at address b368
[    5.638774] mmcblk0: mmc0:b368 SD 1.90 GiB

Without the revert, nothing card related shows up after the
rtsx_usb line.

Hardware: Lenovo V110-15IKB, internal Realtek RTS5129 (0bda:0129),
no tray, plain SD slot. The card is permanently inserted and holds
a LUKS key, so it has to be detected during boot.

Judging from the commit message, I assume an init command times out
before the card is attached, suppress_cd gets set, and as the card
is never removed, raw SD_CD never drops and the suppression is never
cleared. Note that physically removing and re-inserting the card on
7.3.3 did not bring it back either, so the clearing path does not
seem to work here as intended.

Sean, Greg, Ulf: CCing you as author/acker/committer.
Happy to test patches.

#regzbot introduced: 7185b6d33b17

Philipp
