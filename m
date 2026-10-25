Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792933322;
	b=O8duuA/ivw8xBDnKylf60WQrIu07dQFGej/pFubPu3KuSX+68+U230yUWl2VfxHXmk4X
	 O9IanojD5GdZwmnnkYPaWoFPoQm6XaroXWCfQIF4MVbVIoznZ3qCHzGn1z70E/4H3s9nM
	 60tLXimJpYSSLNhVwBmq1lJOBs1dZ7RqCTmec9wGoSPUqRcpYAy3MvV3fSVvSY0p8ALo3
	 IASKOsUoBWahVMQRkoFryvqARdndsMvneFZh/6tdGyqZhVq7kde7MmSjH4qmzXuD0/SMQ
	 fBaqAhHW//uHfi5O7qTIjxcuOC20xq7wzpHkVdSouH73iD3BQVPVUNMYbx2nVhnVB7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792933322;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NH6uaE3LJzdARQ+uy+rf0Zqa21dqbATNK0Q75TVfU1M=;
	b=J4GrBLI3PCKHxY9AJB2OW3E1CyF2HSjWcB5bJf94qyBK3uQ+BN0nT8PTf8YgWM9ZQVYi
	 4t9G0h8Zc9Mjk/QWui9Md/Za9eqXpnRRzNpv2mhh7f7YvWHCpFHr754uiNErGDtKqx6Hf
	 MqWqiuWTa5o9QSmV/v5AJPeuuUs9T6v+VFC1Sq6C54iJhuLmYlA8FFcnM/qPdBYOCARg+
	 xkfEfa1g56+cYUasCdpCvCzoT3GQtHtx6WIBuvf/uJspKnObLGjTXG266zUlT6RtYtWuj
	 YnQPhV8oavvI9VNVoCaljbiP5Y0lcWkWthwIf2+Wmjkhy4wscl7oQXqsasvCQszDukA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eFS8GKad;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B63D606A31A
	for <linux-mmc@vger.kernel.org>; Sun, 25 Oct 2026 13:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B63D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eFS8GKad
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso8711325e9.0
        for <linux-mmc@vger.kernel.org>; Sun, 25 Oct 2026 06:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792933321; x=1793538121; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NH6uaE3LJzdARQ+uy+rf0Zqa21dqbATNK0Q75TVfU1M=;
        b=eFS8GKadMHZO7VVf1it3BX+BdQYUW9YGZDsRHgK0H/YkIAHv9P9XbAHTDNcJp8nyDJ
         vHS6RoxLFLqmPITisd0Jap8WpXOslwjXC1naaB8SA/Xk0a/711zI/qt3sQD2hCoTCU7o
         Of0BHuhT3ZROCX76Fg/eYhbRzRRBSjZW5W/DjXB6vgW9N9qcBL6nAz6P2KfwC7CHsoyn
         LrHBdfmRqkVbJI3ddURzhpACLt3tvvmpmRg2B3qXkmZsk03YjOg+Jrhon1xQm1vveLqD
         8pBaLCYU5x/fH2s34sFx4Rrmf9b7y5/dpU9ojMhpxhFi7ml3Dl94WSLlaAO+JYxPZi4I
         FkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792933321; x=1793538121;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NH6uaE3LJzdARQ+uy+rf0Zqa21dqbATNK0Q75TVfU1M=;
        b=mt0gw8IlLjzUhQlvXRxBvbyjJ8SxeTBddjlxNg6JPjGsuVLAoBC+Fn9lkAUpylQInF
         ewxoPv0GeXUXwZL1/seS2/OpIZFkei98/tuCJp0iOaHrhLop0t849VawzbZM8PDgb+5v
         1+W6M9mVQOd23J4yQ/wZq+3xtEWZtZq0HB8+eYtkrttPF1qK6mjXaTQuw1H+Ueq7FPyR
         y305hIAhV6EM1tMQ8mxVERMeLjYqMBp/7h5xWBVjzi2k9NaHO10Blc84XetiVS39y+nY
         MviZ+b7qW4WWPDgNI1H5sg6mSZmd5kFueXd3oXAjCvQhuJ6WDjHTwLHjioyudC+0IlLX
         xtWg==
X-Forwarded-Encrypted: i=1; AKwUvBx/hHCT7MUE6AQ7F7w+Q+1FfTRDgHpxG+F3NgiNYgHic57t3QkbbunvAgtEh0lHMxZ2bSYUu9adzRE=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8VltK6b3eSgHgNoxYufp0jigFcN9qcRY/UAjlMhbnWmb4AgFV
	vX846OMYEYi9HriOOHs9eaFJy7CCs/F7tD0PONrIWhVqVGKazTxVOC3j
X-Gm-Gg: AYBFou0dJ/bZGvvnMLmg+Y0M2eA5Eg4QsIQgXDz2/Tl1rwI+9LAbYJ/ZXxrsuyq/gPB
	MoSX6XXlX223lotcOqPxPe4UAmmP3t3FarYE73Pm3Fi40h5oClaaMV6gDBQaaeS9H89zmalIgh7
	x3SsM0C/DkWoCI32wZSycz7MZx3MNlz+GkKh9DxGBkHxHf6uprkP8eJhsBHCXhZ0//kslKIoE38
	CgX6TfiKtbnEyWY3+a6wBCm/8Y+4mRCJ73PPcaWAJJdTwcv2frDbYMcjetBPybd6ZsP0jXKU/UW
	LggeYMwM/X8w6RmWUrDW3Nvrxln3rNp4MmEbRU8m+cKmxcysPQbF+09VZX5rqCbOkB0TgIfcHlt
	Jk/ACfh7+FlijSl2rRhdL0ykpK2ozb35goKIrb9UJmvYQkFOUpNi0S18cExNQxsYH73PWTCXf7H
	2APG9sfzy0p7pOTsIxd9MEcXwg0gMz/WbKfMN/60TKL1U7xU+sx9hlX0/v8NUhpevJmpzb4hY6H
	LSswWR6Kz+53q1By2RQ+NBFf6J9FOSdHcSxqibj5kLbbMN4YVYgeJvaMm79RAnooKAqDbVJEUho
	fc4IzOid1etn5T5k
X-Received: by 2002:a05:600d:18:b0:4a4:f48e:78fa with SMTP id 5b1f17b1804b1-4a4f48e7b2cmr31818105e9.12.1792933320372;
        Sun, 25 Oct 2026 06:02:00 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd37f4sm12035476f8f.44.2026.10.25.06.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 06:01:57 -0700 (PDT)
Date: Sun, 25 Oct 2026 13:01:54 +0000
From: David Laight <david.laight.linux@gmail.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Ian Rogers" <irogers@google.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Vincenzo Frascino"
 <vincenzo.frascino@arm.com>, "Arnaldo Carvalho de Melo" <acme@redhat.com>,
 "Stefan Kerkmann" <s.kerkmann@pengutronix.de>, "Marc Kleine-Budde"
 <mkl@pengutronix.de>, "Christophe Leroy" <chleroy@kernel.org>, "Helge
 Deller" <deller@gmx.de>, "James E . J . Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Jason A . Donenfeld"
 <Jason@zx2c4.com>, "Alexander Viro" <viro@zeniv.linux.org.uk>, "Eric
 Biggers" <ebiggers@google.com>, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-mmc@vger.kernel.org, "Jaehoon Chung"
 <jh80.chung@samsung.com>, "Shawn Lin" <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v2 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option
Message-ID: <20261025130154.16b54998@pumpkin>
In-Reply-To: <5674ade0-db6d-45c4-9a0a-d032efa00667@app.fastmail.com>
References: <20261020163210.742728-1-irogers@google.com>
	<20261020190718.6cba898b@pumpkin>
	<9ad54286-4337-4022-8657-65e1ed86b6df@app.fastmail.com>
	<20261024093209.09367c73@pumpkin>
	<5674ade0-db6d-45c4-9a0a-d032efa00667@app.fastmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Post: <mailto:linux-mmc@vger.kernel.org>
List-Help: <mailto:linux-mmc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-mmc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Oct 2026 13:05:19 +0200
"Arnd Bergmann" <arnd@arndb.de> wrote:

> On Sat, Oct 24, 2026, at 10:32, David Laight wrote:
> > On Fri, 23 Oct 2026 23:49:50 +0200 "Arnd Bergmann" <arnd@arndb.de> wrote:  
> >> On Tue, Oct 20, 2026, at 20:07, David Laight wrote:  
> >> > On Tue, 20 Oct 2026 09:32:09 -0700 Ian Rogers <irogers@google.com> wrote:    
> >>
> >> This is the traditional way we have been doing the unaligned access
> >> in the kernel before the change. By annotating the structure as
> >> __packed, we tell the compiler that it cannot rely on alignment here,
> >> so it uses whatever method it knows to access unaligned data depending
> >> on the architecture and flags.  
> >
> > That relies on the compiler not tracking the alignment through the casts.
> > The only way the C language lets you get a 'foo *' pointer is taking the
> > address of a 'foo' data item so it must be aligned.  
> 
> I have definitely seen the reverse, where a u32 pointer dereference in
> __raw_readl() gets turned into individual byte accesses because
> the pointer originally came from a packed structure. This is
> also bad because it breaks MMIO register access.

The code rather relies on the compiler not splitting a volatile access.
But it is allowed to do that (eg 64bit accesses on 32bit) so it
may be allowed all the time and the kernel just hopes it never does.

The whole thing is a bear pit :-)

> 
> We also know that the packed struct version works, either because
> the standard requires a punned pointer to respect the minimum
> alignment, or because the implementation is smart enough to only
> ever lower the alignment for punned pointers.

Or the implementation currently chooses to honour the lower alignment
for punned pointers.

The standard doesn't allow many casts at all. IIRC you can cast a pointer
to 'void *' and then back to its original type, and you might be able to
cast a 'pointer to struct' to a pointer to its first element.
Remember it has to allow for word addressable systems where the offset
of a char in the word is held in (say) the top 2 bits.
(I doubt any such systems still exist...)

> 
> > So even if you cast it to another type that alignment can be assumed.
> > I've seen crashes from memcpy() using word accesses when trying to
> > copy from a misaligned pointer into an aligned copy of the structure.
> > Now the current code must be avoiding that - but I think the compiler
> > can do it.  
> 
> Right, especially the memcpy() without type punning seems dangerous.
> We have had several instances of code breaking on armv7 where
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set but the stp/ldp
> instructions for 64-bit objects still require alignment.

I had the compiler unroll loops on x86 and had a 'sum += *buf++;'
checksum crash when the buffer (mmap() of a file) was misaligned.

> 
> I don't see any instances of the exact issue you describe, but this
> one is similar and definitely broken on armv7 (adding the dw_mmc
> maintainers to Cc for information):
> 
> #ifndef readq
> #define __raw_writeq(__value, __reg) \
>         (*(volatile u64 __force *)(__reg) = (__value))
> #define __raw_readq(__reg) (*(volatile u64 __force *)(__reg))
> #endif
> #define mci_fifo_writeq(__value, __reg) __raw_writeq(__reg, __value)
> static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt)
> {
> ...
> #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>         if (unlikely((unsigned long)buf & 0x7)) {
>                 while (cnt >= 8) {
>                         u64 aligned_buf[16];
>                         int len = min(cnt & -8, (int)sizeof(aligned_buf));
>                         int items = len >> 3;
>                         int i;
>                         /* memcpy from input buffer into aligned buffer */
>                         memcpy(aligned_buf, buf, len);
>                         buf += len;
>                         cnt -= len;
>                         /* push data from aligned buffer into fifo */
>                         for (i = 0; i < items; ++i)
>                                 mci_fifo_writeq(host->fifo_reg, aligned_buf[i]);
>                 }
>         } else
> #endif
>         {
>                 u64 *pdata = buf;
> 
>                 for (; cnt >= 8; cnt -= 8)
>                         mci_fifo_writeq(host->fifo_reg, *pdata++);
>                 buf = pdata;
>         }
> 
> The 'u64 *pdata = buf' cast is of course broken here since that
> is not allowed for unaligned pointers on supported target regardless
> of CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS. The else{...} portion
> has to be written using get_unaligned_u64() here, as the #ifndef
> branch should only optimize for performance and not be required
> for correctness.
> If '*buf' was a u64 pointer instead of void, I could see the
> compiler messing this up in the way you describe, by optimizing
> out the temporary array entirely.

Jeepers that is horrid.
The simple:
	for (off = 0; off < cnt; off += 8)
		mci_fifo_writeq(host->fifo_reg, get_unaligned_u64(buf + off));
will generate better code.
The compiler will usually optimise out 'off', decrement 'cnt' and
increment 'buf'. It does that even when you try to use negative offsets
from the end of the buffer - which generates the best code on x86.
(And you might want to copy host->fifo_reg into a local.)

It might be worth optimising for CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
being unset and the buffer being aligned (to sizeof long, not 8).
But that isn't the conditional there.	

> An unrelated problem is that the mci_fifo_writeq() definition
> is not portable because the volatile u64 pointer dereference
> does not guarantee that the two 32-bit halves are stored
> in the order that the hardware register requires. Presumably
> that was what led to DW_MMC_QUIRK_FIFO64_32.
> 
> >> The reason we need the struct here is that you cannot use __packed
> >> as a qualifier on a variable, only on a type or struct member.  
> >
> > I know all about that.
> > Somewhere it also says that you can only increase the alignment (I think
> > of a type), but you can definitely have a type for 'u64 with 32bit
> > alignment' and use it in a structure.  
> 
> Right, we do rely on that in e.g. x86
> 
> typedef s64 __attribute__((aligned(4))) compat_s64;
> 
> We cannot use this in a macro though because there is no
> way to define a local typedef inside of a function or
> to change the alignment of pointer without the struct.

I think it could be inside the cast - the same as the struct definition.
But that is not really any different to the packed struct.

David

> 
>        Arnd

