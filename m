Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792839973;
	b=Mllc/1HHkPdCnJkxFa/Dn5IRnT869uvUCPbeMrytEa+2kPrvtMXN8Ky0S+ypdcH08I+q
	 LNOLWSKLuQdAxJcxR0NlDwzCI2MHgr6dxOQ0pwFNWhCoj9tbxO+MmZHqMtxoiZpQlA4p/
	 GjNyjTHVkfgNXlVV1Cd+QdWhO1q6YdAwfPFJKHJn+ZOZsVGAA6y1QkliC49BJlG4TNBU6
	 yS+ncnyILJ4trSBSTd6LcP/jpToRD5p2mhb98DwX3wunGKFmsmu3lMNVlCJ0zAajxwOCK
	 BBYH8rXKsSi4eK00dd0y3nxZ+weGLEJS/cCVc87WtzJBUglP5A9EmdAaO3bdWBeey3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792839973;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=B6vn2DStihtHQBWmF0Gq3R4jCMavXN0lRtS7lQi8Oxk=;
	b=3ksR0aSo3VOvtouSVSHtJz7gjNe/6KZAY26AQr5Hpf0jIThqmapVh/ljzkAyKIM3efV5
	 Dfadz8sG0xp++JWB1reYpOyNIfQBLlM4FgphdA7CAbKbQxnEFdYoNVxPHb8LAxl8oysJr
	 M9dQEqwQcq6fuJDMgLvrDvEfjd4n4ajlSXmY9WGTFskmCHycnjSmnR/gYY4fHYGU6myfl
	 HfcxeQgKlmgezrx6UzDtGYDS1Rfz3H9fgxU6/aih9sKPV3VeqzEgWkT8xhqy8G48IWiYP
	 LBb6UWuqNupxgNhUYtvccFUGvjAM+sajuPMFTISrZ8KrhjuqVujdPpFU19vaPtV3yEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=temperror header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=CISwAWnV;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="fAt/3jzu";
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028D2606A31E
	for <linux-mmc@vger.kernel.org>; Sat, 24 Oct 2026 11:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 028D2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=CISwAWnV;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=fAt/3jzu
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B04E7A0168
	for <linux-mmc@vger.kernel.org>; Sat, 24 Oct 2026 07:06:12 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sat, 24 Oct 2026 07:06:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792839961;
	 x=1792926361; bh=B6vn2DStihtHQBWmF0Gq3R4jCMavXN0lRtS7lQi8Oxk=; b=
	CISwAWnVFNABLcds7W9xIwX9UzJFVPk+T+yM7cMXiivsqEv2Ikd7cuBhEzL6ipv1
	qZNbm+oePHNosoeCuGV27clXiq2GgUuYb+8fcnlteTEL/752+3ZCcnSsilW4nwtk
	3CLhnCGM8+3obzJPZgWjQiIk/KP6ukFoLeJHLdY3qd91t44VQRLAJxNhdIneHrtR
	qMAqCgaxoaczEjhRK8V7P5JcM+EsLJwUDMHRv2zKuqmqsRpfKhGHrKWu7A5Cpk0R
	AmWmPSA2l42YbzK/spA/gJxAA0XNMrsQrDWeJZRUJzoVO9uSxewCfDA0Qhdkn2X7
	zPJ6Bglyij7+20Ce22ztHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792839961; x=
	1792926361; bh=B6vn2DStihtHQBWmF0Gq3R4jCMavXN0lRtS7lQi8Oxk=; b=f
	At/3jzuVCZDSFDEcage5UKeO22EIlsURUX8d6jykMFAyk9djKHt2Qcm05ajHpX+f
	XuY6Ipa2WGgkrd/meruPdU02r/vwHxPJ5wD9J7+RyP9kBHNXpwqs59HHT8ZqJLlI
	nndJ0qVJ3pvL6r/z5Qm8nMXAPzZ293ArJlU4fuGy+jnuPuPcbXCPq9OEHsz3qNQs
	EPZqYgkX7vcwLq4V7G/32PoJ9abdwKAMeGvGRuPA+skUh0SBQoLaRv7Oo5Qt4Ec5
	/qKSdooikGQnz81y50jvlsXDIZ8j1AtnVm1222Xrq5FC2jH0T+heIYSxdwHMgBea
	KmQ1XZtcWlAjRrxEUWRdQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792839961; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:RBksa1GAUfTBdW3CC4JhSz6I/D1w1Pw/BMG2JE26R1Xo7xe
	X6DcyNXzpfVZujI0yAH0elRyw/zfVGD1YpeTL3CqB+PTMe81PSA0gvO2oYWKFYyY
	/NxPyqNDRAPDTuC4sCod3qYDdYwRQ/vQScPjtMWVELDiloJpftvm76bsvS3N776h
	g4bU9axKxbUWSBwB2ryw0RcVl60pmZHu5iHNiT77PtpuxLOo2ggylHgMbBzE2WJc
	hICYE8vArNnJNjMd3q3ap6YMHwj+XTFZnDYD4TiKTs9pRKBLcaOsQG3+Y28RLrGQ
	FAoTbwJMH4Jt0JNpIwd7+XsvXN5TEs6ZXtowqwA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:6ocqnLBAD47eRfPt1LDxYvWcaenY4jjHGmLLK74+H7g=:jEbyEn2zJtQuEuH3sAaGvS9R6lKmI9NPxBte+5hi4EE=;
X-ME-Sender: <xms:EZHcapyVobuaxjA9pYoD5X6IBFhfzpCSPyzKHCtvkW6-gcySzsieUw>
    <xme:EZHcakGvlR-nVDA8S_8BXFlmK05LFFVEXiykM2psBcU2uVySDtbDsg8Gh_eof8r7v
    0LVWXk38GlUykmiRfNsfWHYouOMoS69yWaosp9QVRexN8ky7zTO7jCL>
X-ME-Proxy-Cause: dmFkZTGKJZlY7FFlfPJ8aPWgIhMiJ0abUV63GpKIM+BPAyyYxg32bVWMo9pnqmVlAUdIc5
    sOwzQUeAb3oCqdYoAAgC5I0kHbCkJ9NJhjTwwzjLdHym299Z+eAGdNIvqBO0hpkUvzPzdD
    QpQ7UG/Tq1+s++RpW3czmer7qUTwjwoRg8RohYRKQGUKbVsDsNWIxu2d3GiDeLAsTEsEOd
    XfpdJBrbp5J6/68I86tJT3nm76YXQN+5GmIKpQ+xHruD+zQy5VKcDH3Pm1/ih+bdPtsOlp
    wK0ys9JcgztEJyj/KR2hW4zPof2nqLVFJ7dvWh0D1t20P6hujZghB2CXWCqSAWDdYmY8KW
    Ywei9ALMUXODCtt86LTDU/MyZAynWN6iSG3pQj1yzAL0PbJL3VTxuFj7HcS94dXfOF/3Lg
    jL3AI0eZ2vXE3pz/e6fvVof4RMVyfQ0w1AeE8ky52GF8nnGU3Eb8mLtTB7bIVt1TuPJgAF
    EARP+NA3RC6z06KXXcnYJBs0UGfHz/R+HdGzKQBVjiaLGufpF93rYEV5BCMGJtwyhbaGiT
    bInBvcqLt/1Vs/Wy7R60XJSgasVfxEEjklDT3HCVsNT9/hm3poEUuIkYCfzx43cnLC0jmm
    ej9cx1B1njTLnLk7tFa43hNju+sA3hSKBBjc3xeAzqa4BUimNA+gJun2hEgA
X-ME-Proxy: <xmx:FJHcaiKtQi20VW3Heyi4EiFNNZ2zHPQspeqvGrI0Qzh-J-oShGCxbg>
    <xmx:FJHcavAaGsElm4uqMv806T7ufabQfqqnERyg4tR0ZtiNee9S902M-A>
    <xmx:FJHcarRg3dSQ5iaELLxFLd5mk1ALtTewfYSRf5-MmYCQiWMavYjwgg>
    <xmx:FJHcaoozF6EziMfKBP-RpOEnt7MQLGctPJodfPN3k9GIazUW5RI3IQ>
    <xmx:GZHcask2vgZPEHMXCg2ePfOpeS6c4GWhWpikn6JQYffOj04x2sAZLSbb>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5AF9832A0098; Sat, 24 Oct 2026 07:05:53 -0400 (EDT)
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
X-ThreadId: Ax4Cw9gIx-EN
Date: Sat, 24 Oct 2026 13:05:19 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "David Laight" <david.laight.linux@gmail.com>
Cc: "Ian Rogers" <irogers@google.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Arnaldo Carvalho de Melo" <acme@redhat.com>,
 "Stefan Kerkmann" <s.kerkmann@pengutronix.de>,
 "Marc Kleine-Budde" <mkl@pengutronix.de>,
 "Christophe Leroy" <chleroy@kernel.org>, "Helge Deller" <deller@gmx.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Eric Biggers" <ebiggers@google.com>, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-mmc@vger.kernel.org,
 "Jaehoon Chung" <jh80.chung@samsung.com>,
 "Shawn Lin" <shawn.lin@rock-chips.com>
Message-Id: <5674ade0-db6d-45c4-9a0a-d032efa00667@app.fastmail.com>
In-Reply-To: <20261024093209.09367c73@pumpkin>
References: <20261020163210.742728-1-irogers@google.com>
 <20261020190718.6cba898b@pumpkin>
 <9ad54286-4337-4022-8657-65e1ed86b6df@app.fastmail.com>
 <20261024093209.09367c73@pumpkin>
Subject: Re: [PATCH v2 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Oct 24, 2026, at 10:32, David Laight wrote:
> On Fri, 23 Oct 2026 23:49:50 +0200 "Arnd Bergmann" <arnd@arndb.de> wrote:
>> On Tue, Oct 20, 2026, at 20:07, David Laight wrote:
>> > On Tue, 20 Oct 2026 09:32:09 -0700 Ian Rogers <irogers@google.com> wrote:  
>>
>> This is the traditional way we have been doing the unaligned access
>> in the kernel before the change. By annotating the structure as
>> __packed, we tell the compiler that it cannot rely on alignment here,
>> so it uses whatever method it knows to access unaligned data depending
>> on the architecture and flags.
>
> That relies on the compiler not tracking the alignment through the casts.
> The only way the C language lets you get a 'foo *' pointer is taking the
> address of a 'foo' data item so it must be aligned.

I have definitely seen the reverse, where a u32 pointer dereference in
__raw_readl() gets turned into individual byte accesses because
the pointer originally came from a packed structure. This is
also bad because it breaks MMIO register access.

We also know that the packed struct version works, either because
the standard requires a punned pointer to respect the minimum
alignment, or because the implementation is smart enough to only
ever lower the alignment for punned pointers.

> So even if you cast it to another type that alignment can be assumed.
> I've seen crashes from memcpy() using word accesses when trying to
> copy from a misaligned pointer into an aligned copy of the structure.
> Now the current code must be avoiding that - but I think the compiler
> can do it.

Right, especially the memcpy() without type punning seems dangerous.
We have had several instances of code breaking on armv7 where
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set but the stp/ldp
instructions for 64-bit objects still require alignment.

I don't see any instances of the exact issue you describe, but this
one is similar and definitely broken on armv7 (adding the dw_mmc
maintainers to Cc for information):

#ifndef readq
#define __raw_writeq(__value, __reg) \
        (*(volatile u64 __force *)(__reg) = (__value))
#define __raw_readq(__reg) (*(volatile u64 __force *)(__reg))
#endif
#define mci_fifo_writeq(__value, __reg) __raw_writeq(__reg, __value)
static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt)
{
...
#ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
        if (unlikely((unsigned long)buf & 0x7)) {
                while (cnt >= 8) {
                        u64 aligned_buf[16];
                        int len = min(cnt & -8, (int)sizeof(aligned_buf));
                        int items = len >> 3;
                        int i;
                        /* memcpy from input buffer into aligned buffer */
                        memcpy(aligned_buf, buf, len);
                        buf += len;
                        cnt -= len;
                        /* push data from aligned buffer into fifo */
                        for (i = 0; i < items; ++i)
                                mci_fifo_writeq(host->fifo_reg, aligned_buf[i]);
                }
        } else
#endif
        {
                u64 *pdata = buf;

                for (; cnt >= 8; cnt -= 8)
                        mci_fifo_writeq(host->fifo_reg, *pdata++);
                buf = pdata;
        }

The 'u64 *pdata = buf' cast is of course broken here since that
is not allowed for unaligned pointers on supported target regardless
of CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS. The else{...} portion
has to be written using get_unaligned_u64() here, as the #ifndef
branch should only optimize for performance and not be required
for correctness.
If '*buf' was a u64 pointer instead of void, I could see the
compiler messing this up in the way you describe, by optimizing
out the temporary array entirely.

An unrelated problem is that the mci_fifo_writeq() definition
is not portable because the volatile u64 pointer dereference
does not guarantee that the two 32-bit halves are stored
in the order that the hardware register requires. Presumably
that was what led to DW_MMC_QUIRK_FIFO64_32.

>> The reason we need the struct here is that you cannot use __packed
>> as a qualifier on a variable, only on a type or struct member.
>
> I know all about that.
> Somewhere it also says that you can only increase the alignment (I think
> of a type), but you can definitely have a type for 'u64 with 32bit
> alignment' and use it in a structure.

Right, we do rely on that in e.g. x86

typedef s64 __attribute__((aligned(4))) compat_s64;

We cannot use this in a macro though because there is no
way to define a local typedef inside of a function or
to change the alignment of pointer without the struct.

       Arnd
