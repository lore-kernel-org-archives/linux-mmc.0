Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17E714C5B0
	for <linux-mmc@vger.kernel.org>; Tue, 22 Apr 2025 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745343456; cv=none; b=E9ZDszH4r9GhPMX6znES3sddL2rxZ6SPE/5vTDqRditlLpsDuxZlWwsnDezf4k/3kzzEneWVCzMS7Zxj9X9t2Oycd27pYv5+axaOCzBF0LgeEK8EUiivNfdJjkGZ3BY+vAh8CuB6onpaXeXuPMNfyRxl+fGcPegFHqHCmiDmvzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745343456; c=relaxed/simple;
	bh=//ljsWLJ17VFLHPdaCUPZP+ZvCW8AyV14VcjzMKwZ0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uuGUMZr2oQvgZSZdNNRtHD05gPlgC99iKxQtf7kG0kP5fLSCMh05bZMYtdl8xSKtdIlP12YOVRLgdAQctMvUvbx8C1jXq/OTJNYiNwtCwlz16P6oy5+BF36zkQJWID7DxcfwYXKDE6eV/Xpf1TSnQYxYszDq5OeDQbK8hLAQl5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=GASexZnw; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GASexZnw"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac339f53df9so932023566b.1
        for <linux-mmc@vger.kernel.org>; Tue, 22 Apr 2025 10:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1745343453; x=1745948253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaYnZXwKyJCHjKccLAG/Xf5ijKwMBcq8rg/hvv8WO7Q=;
        b=GASexZnwH3cV63lmzqiLUn/qMOuRqzt05HTaCzr7NYVUTNfu1+iGb1mWCDoNuuXhkT
         r6mjIdlMk04yeDQyjwH+1O8a9RhbGnLkWh5zkw8DZdN80H+2C0nQD4owNU2ICs/qR3j4
         D7l6wlElBLOogd95d7H6e33JqKVRfcxYoSy/pc26Xod883u7y9+E6awh93QhzDzJMJoG
         BahZR3uDhI/6Nc/ayc1ZF0sEI0RLNyY2y9CkDg2G5S+3pg5Y1ge0skk6jQl/jDfIceWD
         hL8Gh9qs6rgwtVN74P3kVRICZs038ZP7WVDhfACeOsLNwEcvxVPCTjO1CfyeQsB8rY2B
         H8hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745343453; x=1745948253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FaYnZXwKyJCHjKccLAG/Xf5ijKwMBcq8rg/hvv8WO7Q=;
        b=exz6zgwsGgGeFSfGuGfE4QbEeviVa0arUOKRgWsMq4GMb7Mf3FJXoj8BBJ/dsmgSuT
         08ZiN8u2iaO/dxO8vmvHrDY0/odmUFVFVnJFOvCh3WbBHWEzZPPahZ2eY2pmW2XnYuYM
         mB61F9v5vQi53Agzll/U1+cUKQUX2HTcR1yZFrW4tJdKZcLDWC34aHydcKhpp1niFpJE
         D5b5Cd+XnkTulSoIouIRUDphnBxNlNPhp7qBevZ5/2Bn6gtVdwGvrhzXzyqrPStrAxLu
         FudOH/cqCYqNLvQoTliFzvLy5bO/iMQmhIKNdTWFTbt7VYH1eM2pn8qn3Vp0BRo5DBfn
         KoAg==
X-Forwarded-Encrypted: i=1; AJvYcCWMOYvaBySqECBJg6MbYo3SP8LHg3/5UTWBGuX4hVAma04mHSlxAZiY/OTiflz7fNsYWGvBoPo60Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxtgN5H0Pie9Y3cwEOgFuIepda0kqDQJmamVZkcEgBcIrNY7iP
	CkP6OMsN2Qo/eYiau4DyKUFo3f5aBIKfYqrjnL0HMS9ecWov1OwgHe4ZTNWqB34Ol2UwpEpoICZ
	M+Q0NQhP2XmDFyZqEDaa/g42f/nnCGE5TuEDHWOVRT69iA/hpRA==
X-Gm-Gg: ASbGncv/+bDWCRxZDqQLVkIaZHfOpwqk6ajxjjPpdga+CRJCo1E57xyFXmDAFhwIetS
	doBLnjy5J9BhW8AKSYdFDHl4UVmpo4yX8XriJbj834Rkue79GcLm4BSiTOcjnP5PuTddD+AMI5O
	7N8ku4YK06QzH+t6Gacka5KsW34x0EuzFTqnmhTyaCGaNxZLzYcHFL7Tc=
X-Google-Smtp-Source: AGHT+IG+fFj5n6tODW07JMJnm6w4gyz1i1I7quJ3E5FrFZi0W84N8OmRxSRPTgu88x22LEZNVuelevBRZN9n7A1r9ek=
X-Received: by 2002:a17:907:7f91:b0:ac3:97f4:9c08 with SMTP id
 a640c23a62f3a-acb74b86ee5mr1599128666b.31.1745343452842; Tue, 22 Apr 2025
 10:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKh1g556YvHE9eib3WJG+mBHyyr88rxYSbNUHxpFYsUHcdOoUg@mail.gmail.com>
 <fb21ad0b-b45f-4636-9d74-1e758c3b2879@arm.com>
In-Reply-To: <fb21ad0b-b45f-4636-9d74-1e758c3b2879@arm.com>
From: Prasad Koya <prasad@arista.com>
Date: Tue, 22 Apr 2025 10:37:21 -0700
X-Gm-Features: ATxdqUHsRq6AA2YHwIWp95i1qCQoRVbl_Q5GrYv1uSDi0ATfVQKMLvX8yeJA1TM
Message-ID: <CAKh1g55ErQRRsJSe6zEmp6mT6nAhEP_Br+HA8x5RvUa4B=4ERA@mail.gmail.com>
Subject: Re: eMMC timeout reproduction. Can I send a block of data from the
 host to the card with invalid CRC?
To: Christian Loehle <christian.loehle@arm.com>
Cc: Baptiste Covolato <baptiste@arista.com>, Sushrut Shirole <sushrut@arista.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian

Thanks for going over and replying.

I couldn't find any ioctl() that changed host's block size in the 6.14
tree. We are using 5.10 kernel.

I did try mmc_test module so I can modify an existing test case and
make it a simple one. Hacking this module, I could call CMD16 via
mmc_test_set_blksize() and set the block size to 514 (0x202). Below
are the eMMC traces for this test. A CMD16, followed by CMD25 with
data, stop opcode and then CMD13. The multi-block write seems to go
fine.

            bash-3958  [001] .... 34861.450688: mmc_request_start:
mmc0: start struct mmc_request[00000000fe878338]: cmd_opcode=3D16
cmd_arg=3D0x202 cmd_flags=3D0x95 cmd_retries=3D5 stop_opcode=3D0 stop_arg=
=3D0x0
stop_flags=3D0x0 stop_retries=3D0 sbc_opcode=3D0 sbc_arg=3D0x0 sbc_flags=3D=
0x0
sbc_retires=3D0 blocks=3D0 block_size=3D0 blk_addr=3D0 data_flags=3D0x0 tag=
=3D0
can_retune=3D0 doing_retune=3D0 retune_now=3D0 need_retune=3D0 hold_retune=
=3D1
retune_period=3D0
       in:imklog-2971  [000] ..s. 34861.450737: mmc_request_done:
mmc0: end struct mmc_request[00000000fe878338]: cmd_opcode=3D16
cmd_err=3D0 cmd_resp=3D0x20000900 0x0 0x0 0x0 cmd_retries=3D5 stop_opcode=
=3D0
stop_err=3D0 stop_resp=3D0x0 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=3D0
sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=3D0
data_err=3D0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
need_retune=3D0 hold_retune=3D1 retune_period=3D0
            bash-3958  [001] .... 34861.451064: mmc_request_start:
mmc0: start struct mmc_request[00000000c2f30356]: cmd_opcode=3D25
cmd_arg=3D0x3a0000 cmd_flags=3D0x35 cmd_retries=3D0 stop_opcode=3D12
stop_arg=3D0x0 stop_flags=3D0x1d stop_retries=3D0 sbc_opcode=3D0 sbc_arg=3D=
0x0
sbc_flags=3D0x0 sbc_retires=3D0 blocks=3D128 block_size=3D512 blk_addr=3D0
data_flags=3D0x100 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
need_retune=3D0 hold_retune=3D1 retune_period=3D0
          <idle>-0     [000] ..s1 34861.456533: mmc_request_done:
mmc0: end struct mmc_request[00000000c2f30356]: cmd_opcode=3D25
cmd_err=3D0 cmd_resp=3D0x900 0x0 0x0 0x0 cmd_retries=3D0 stop_opcode=3D12
stop_err=3D0 stop_resp=3D0xc00 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=3D0
sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=3D65536
data_err=3D0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
need_retune=3D0 hold_retune=3D1 retune_period=3D0
            bash-3958  [001] .... 34861.456562: mmc_request_start:
mmc0: start struct mmc_request[00000000e93d6161]: cmd_opcode=3D13
cmd_arg=3D0x10000 cmd_flags=3D0x15 cmd_retries=3D0 stop_opcode=3D0
stop_arg=3D0x0 stop_flags=3D0x0 stop_retries=3D0 sbc_opcode=3D0 sbc_arg=3D0=
x0
sbc_flags=3D0x0 sbc_retires=3D0 blocks=3D0 block_size=3D0 blk_addr=3D0
data_flags=3D0x0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
need_retune=3D0 hold_retune=3D1 retune_period=3D0
   rs:main Q:Reg-2972  [000] ..s. 34861.456688: mmc_request_done:
mmc0: end struct mmc_request[00000000e93d6161]: cmd_opcode=3D13
cmd_err=3D0 cmd_resp=3D0x900 0x0 0x0 0x0 cmd_retries=3D0 stop_opcode=3D0
stop_err=3D0 stop_resp=3D0x0 0x0 0x0 0x0 stop_retries=3D0 sbc_opcode=3D0
sbc_err=3D0 sbc_resp=3D0x0 0x0 0x0 0x0 sbc_retries=3D0 bytes_xfered=3D0
data_err=3D0 tag=3D0 can_retune=3D0 doing_retune=3D0 retune_now=3D0
need_retune=3D0 hold_retune=3D1 retune_period=3D0

What we believe could be happening is an SEU that flips a bit in the
data block after the host controller has sent the block on the DAT
lines. Card should reject that after CRC mismatch. Does the card
reject the command right when it sees a CRC mismatch or does it have
to wait till all blocks and CMD12 is sent by the host?

Thank you.



On Wed, Apr 16, 2025 at 2:13=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 4/16/25 01:13, Prasad Koya wrote:
> > Hi
> >
> > We use eMMC as a boot drive. At a random time, maybe a month or an
> > year of uptime, we run into an issue where we see the eMMC driver
> > prints this in the kernel logs and the drive no longer responds after
> > that. We see this issue in the field on linux kernel 4.19.142 and
> > 5.10.165. From the SDHCI register dump, it looks like CMD25 ran into a
> > timeout first. After the first timeout, we see CMD12 in the second
> > SDHCI register dump. Status returned by the card at that point in
> > card_busy_detect() is 0xE00.
> >
> > I looked at the recent commits up to 6.15 and I do not see anything
> > obvious that addresses issue like below.
> >
> > We are trying to reproduce the issue in our lab and understand the
> > driver code. Is there a way I can send a block of data as part of
> > CMD25 with invalid CRC?  Appreciate any pointers.
>
> CRC is appended by hardware, so it will always be correct.
> What you can do though is change the blocksize of the transfer on the
> host side (e.g. from 512 to 514 bytes) without changing it using CMD16.
> The 2 bytes will be latched in as CRC by the card. Of course you won't
> see the CRC ACK from the card in that case (as it clashes with the
> hardware CRC signal from the host).
> You can do all this using the ioctl interface in userspace btw.
