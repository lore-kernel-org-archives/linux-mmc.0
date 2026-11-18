Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795024250;
	b=KvVRnI7NZNlhvveoVZt8R1CSBj0IhVFfg6r2fikeiajUFLlQpUFPD4gNmsj8cXaANNNP
	 XlHE5IiVchNeYrFzxV3bTQqbSxXpjDnVuLF007K/aSDxvinCCKwwMHjrULytw/C0FZQcQ
	 WbSAloFt0pq/UtHUMjy1l8MDzj0ecCHICVgj6Lia2B6GNlH6vGM3Rk7hxuihKo89XeboZ
	 bhDN+kbXov8F1k+CNKjaKb+UQa6LuD5fZdLYZNFuXeBySGlTg6HORhXjQkYkni9rDVuBR
	 pfLN0+YQQRkQvVeTzeC0obkFgh8FUzc45B6EpUIFSNz2YCTOiyxOhvIWig/SfZXC0ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795024250;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=aGoos/bm0q3mGBn1ZAhSG7pC13rp8om2SKkXD/T2kdo=;
	b=xWK6cbtXiIZ/5CZ8YGyV+b0pKaPkXDNSB64BdBT+qvGKKJxL9HEYPoyxWNyK8tH3hIBB
	 o12u3d7MYQceXH1ybWwwuQFcSy4hBRayIQf1c+UMA5pU6SHwZcuMKk530r13LgWkpg1AU
	 fgG0wcIOiW4tBW2UhH+VTWfLDKd0+5HKc3cLIyOy2HdsEvOcR4AjCZl6MoHJqnUvVfyHz
	 Ww6/PYsZSp61UP2mHp15dMJBojONY3PvqHv2SNuRQqj/iWNKM1rqm8owE4F+yP45XCP+s
	 zYDF+IpRcBYFYSNaTB3MbWBZXxwOFv1L9o/GvXG7xBmQqHyr584PDZelPQaJyRroliQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Jo2tp2ec;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pZw6f4Ix;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B7D606A330
	for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2026 17:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38B7D606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=Jo2tp2ec;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pZw6f4Ix
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 559641400135
	for <linux-mmc@vger.kernel.org>; Wed, 18 Nov 2026 12:50:49 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Wed, 18 Nov 2026 12:50:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795024245;
	 x=1795110645; bh=aGoos/bm0q3mGBn1ZAhSG7pC13rp8om2SKkXD/T2kdo=; b=
	Jo2tp2ecbXVUADVkQ7u4Svu2jEu/wFiviN7wo1V6teOLe5a2Hrjt/l33hF1JTFPc
	1OFWgkXo1lVvyDKIlO4NvO+mxbqWFG29LF0vRersC72XQ0aVhfwrCy1xNOFIVIWy
	A2kr0Brj8JS6xTktpG7UrN2SXAiszk6qi8i7sMDCxX/89i4XVwXgGIwfL8FMNebR
	7XGOR9Lr/3MeVd63PGxaHxy7gqdGAzmaQchAqOnZuA4J4KIxQbDSKncJbPN7BhE6
	AuoccM/rtuoqZH2+nQ4jznSeiIQfP9qXVUrfG0118dpTmR8VoipDMeZDCPGmwEq1
	R9jrePz4qy+50WJdWW37sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795024245; x=
	1795110645; bh=aGoos/bm0q3mGBn1ZAhSG7pC13rp8om2SKkXD/T2kdo=; b=p
	Zw6f4IxIqOCPwEACkZnjHXC4bGogp2vX9RogsbjPk3qZKzg/J/YBSWPUodDhVSSC
	Aque0Nwwn5iPtjU0jLTT287iUZFp/wO/3FVo/Tib8IvhPK6gHxudb9xwOFcdEYUA
	J7GmBjqElqI0zNc8JZwgUjZAsFnPzePOqWZfHxOZ9I4n7hZuA+RmtUiL73TV9NcH
	T42XPVt/iPQj1N+kLgLlEdG9GaEDntgoU7vVj2+IVX9rjwvx+G9PKKlUhUBmhpdT
	rpK74M1n58mI8uT6QEF9F8MJMRosXxbz8JO7MkMG62HkWDn+vnegVyUueyGjUAIM
	jf3QPjhNz4o5GeinCWbbQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795024245; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bOngTcJ0Zjc4PsiYcm5hqoXJHDY2DMUf8xZsQ6kAbSoJOcB
	0wtyj3d3HrolXOaGG6Iyn8jqZ+lrGlMLnuvPTQjUPzfebH2tCIbY0lIuNqFhGQuT
	jbReFVFtQNmTFBZho23yF5BuHd+RPz2V9iGMoqKUinIQTSIuZfLabrjX5XLX6+lP
	GF1fT9GUQYtPBR00XMW0TpCsh9FQqVFeUIaA0Asb64ij8l15oOpKPwOjCZF2zjSF
	4AcA57X8UDwpYh5KxRVxS4m/Lm82ZG6MJD2fqGLTphFkypWTHe+3rjdLtNlemqTO
	opLQoFjrkhtgTvb8WgghVt9+LBAptqhMGTZLsrA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wPa1euv29z5VU3mBZo0cVR9qYCzCUaEPsPx4oFldfb0=:HNAiVtIOjGzSmkQr1UV0dRgDq27I2m3SqVTFy0hMr0w=;
X-ME-Sender: <xms:ceX9ajK576jRM0aq6qvCiqar-V_dr8-N70EXAl_DDmouPN1pZIuWoQ>
    <xme:ceX9ah-aG0CyBLv3xQ2ETmqquvYPpFj9-6QN00PxhE_jkTm8Elec31KUgm02QGs8v
    STDV_oeyJx4A7dZZs--MP2cKZ8aNU2X8NkmKulgYfFm4IW-nPAAYqQ0>
X-ME-Proxy-Cause: dmFkZTEC7Hu4PLzw48z+HlfEj9wpMNPvPQMm2CzSmF7B/36bEDoVSqO1f5JKOTM4YC1BIx
    klP6Kmfmv+z6Ac+8J4cbLWsD0sYOX/JIJ406Vy8vntURe6LManFaz1yEz2NKNFq1MyGdxh
    /CVgk88nV7yfpdcgwKVnDbq+b6mRllrr2LaTLrU+rA7TzGj7xEGQxNw4jvfWvV0n8o7wuN
    kSvIdHdFnESg/5rT72JjVVPbBcijYuXjaLFjHdIsE09auZCTtq5q5N22NtC2F5c8ZMvftx
    H1y79eUfnHOmBZs1eTVIWHpXbcn4vl8+u/SBuZoS5ZXyVk3rG6DC/WALPcbdPzqZVb5GQm
    w6MRPpn+FY1wf0nOLvttJpZctxET1/9Re1Bl9cIA9kbGnCrIjzaw6V+cnkKjwiK1/+0dKN
    ZGyrDq7VT/uJ79y6HRwcRi7tAJNebLaX1RjlC6SFtbBXLqAujjm8MSGio6M7DTG9lhPzY7
    OcNZAXrD8pnMQM+LlK0WgtCvGVNCp4N9IDay8IDdTN0E4N1/VXu+bJzgCnOjE2qQdHBujL
    t7JeBNFj4CmXAUIut5Od9BlpSRJW+xTbYjyAVKJdz9/3HVVMBk76dijk7QrLsFIxJLwXjZ
    68WPG8ADxL2ycX9Sjy57WU/ER7PKByj0Edu/khO41xu0cTmU6Eyc45nUFJPg
X-ME-Proxy: <xmx:cuX9aiYzcekvkOEQDinMZZorHWztEy9IWZQ7-ggP5O43Bkb63A3wEQ>
    <xmx:cuX9al2h0EWWwhT4t25Xyf501JzIPuRbhtT_LGtMZzwO2X4tE6E38g>
    <xmx:cuX9ato-kVv8vgTLJ8fBCmKuxTkQIdVr5EVLMJ71RyXW0aL7cjhXOQ>
    <xmx:cuX9asOFE_DfOTZuXKWxSFvJRZb4HvtmDkgO-CB9-kg-nC9Ympr6gg>
    <xmx:deX9ak4yr2dOAYgatmSPDBmDMhobRiEya6uEjg6DU3x7esefzfd6irX7>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 2688D32A009E; Wed, 18 Nov 2026 12:50:41 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: AbyrFe5vH_go
Date: Wed, 18 Nov 2026 18:50:20 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linusw@kernel.org>, "Arnd Bergmann" <arnd@kernel.org>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>
Cc: "Wolfram Sang" <wsa+renesas@sang-engineering.com>,
 "Ulf Hansson" <ulfh@kernel.org>, "Frank Li" <Frank.Li@nxp.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>,
 "linux-mmc @ vger . kernel . org" <linux-mmc@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <bf5fcc4b-05cb-4f11-8f6c-0f94fafd65b9@app.fastmail.com>
In-Reply-To: 
 <CAD++jLnMxxtrtDMm6rYxB1_5jn-FpnrO3Jrb0=SmBmFWFkCTdA@mail.gmail.com>
References: <20261118134445.2909283-1-arnd@kernel.org>
 <CAD++jLnMxxtrtDMm6rYxB1_5jn-FpnrO3Jrb0=SmBmFWFkCTdA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sh_mmcif: rework sg_miter handling
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026, at 18:47, Linus Walleij wrote:
> Hi Arnd,
>
> On Wed, Nov 18, 2026 at 2:45=E2=80=AFPM Arnd Bergmann <arnd@kernel.org=
> wrote:
>
>> From: Arnd Bergmann <arnd@arndb.de>
>>
>> This driver is the only one that uses sg_miter_next() to get a persis=
tent
>> mapping across interrupts, which prevents us from converting the inte=
rnal
>> kmap() to a local mapping using SG_MITER_LOCAL flag.
>>
>> Linus previously attempted to use atomic mappings here, which failed
>> for the same reason. I gave it another try, with a mapping that is on=
ly
>> active during a single sh_mmcif_mread_block()/sh_mmcif_mwrite_block()=
 call.
>>
>> This is mainly a revert of the patch that fixed the command 18 timeou=
t,
>> but tries to solve the problem by updating and checking data->bytes_x=
fered
>> to keep track of when the transfer is finished.
>>
>> Instead of calling sg_miter_stop() on error or completion, this now
>> always stops the iterator after the data transfer and restarts it dur=
ing
>> the following interrupt.
>>
>> Cc: Linus Walleij <linusw@kernel.org>
>> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
>> Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> Fixes: 4d4a2c71b862 ("mmc: sh_mmcif: Advance sg_miter before reading =
blocks")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> FWIW:
> Acked-by: Linus Walleij <linusw@kernel.org>

Thanks!

>> Hi Wolfram and Linus,
>>
>> Could you have a look at this? I'm not familiar with this driver,
>> so there is a chance I got this completely wrong. If the change
>> does make sense, maybe you can try testing it on one of the
>> highmem-enabled boards.
>
> I don't have this hardware, but Geert does (he helped me with the
> previous patches to this driver), so it'd be great if he
> could give it a spin!

I'll post a v2 tomorrow with the bugs addressed that Sashiko found,
no point testing this version. Maybe Wolfram can still take a look.

      Arnd
