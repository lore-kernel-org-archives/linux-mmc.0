Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC503244691
	for <linux-mmc@vger.kernel.org>; Thu, 25 Sep 2025 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758806627; cv=none; b=FZEF1dr4V7ycubdBOFl5hU7dLIXd8uUoywEzWEEBr0inrog4uI0W39+zn0zU1/hAvUnb3c5dpMFRAVn/Cca9JlTd3CtnnHqXX3g4PrhDHZm172c6weLO1MHuFg7roZsak3M7aAeQwqfdybJ2J97W44nbPpIZwAxF3FqfiNNBnhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758806627; c=relaxed/simple;
	bh=IDkFycj+9UKtKZZOJsBm7WyqSmtlL2Fraf0qF7yWxH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyONUBzDBQW7sZDqMm0uyci8qqray9F8et0idn3Nd4WPEi5/Se2Zf6sRF8/xKzb4IVP1XV5rQF3UQ9oEqpB8gRw9OrXL7XbDwK1Z7NGk+MJfOw/sM6kPXfmXH7cm+pI51osmxiQUjrPu7Ovhm5F1SPVEHwsnoGFqGdpArDK0bhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fsQ/1uDh; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fsQ/1uDh"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63604582e53so677664d50.3
        for <linux-mmc@vger.kernel.org>; Thu, 25 Sep 2025 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758806625; x=1759411425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2jGpcIJG4hng0BeFpGfvRbmVsEAFGkbeZpU5851V2aE=;
        b=fsQ/1uDh8DUCfrGhE4mG/SoCir3RzjN3lhWd7VlqfWjhoRwP5l7zShI775ES0z+xQb
         /fl/j/7fPH6NP1F+VC97jLtYCXZYpOZCEh9Y26P5UvmeKTpncdZ958RZFFiumbY992Z0
         eGsMqONkvrCtvO3Nvkrn5p6Y+CQRigskuEEhEllEYWuw+flstcIeNhTJiNu7Ih2WZrMS
         +JtvXa8zaY4ww5IuRDHufT1PDfw0RMDlvBmsSqJ7uQf9WAeKV7DfZZJckrGdrXQeGJkj
         6Mav9VgaruaRdXSx6nFARxuDuzH2u2SvSqB/zB9fWU/sKsFIEQLlEfBRWeqYkaaEY9Q4
         Uj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758806625; x=1759411425;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2jGpcIJG4hng0BeFpGfvRbmVsEAFGkbeZpU5851V2aE=;
        b=RHM8SmX9WDd/ulZ2qeBWh8ox7huXD5rC+KbaYIm3XNTpwqV8mpqkza5GHluYxDDt7g
         vX8dLJDkjvyKlpV8tR87Jj3NY9XTpPn0iKEYw+WDxi4c8BKYZZEt0Tu6HP6qrAmH+sy/
         xIq3iI923kNRti/nyMWfw4gfaREjeRNDWQ95MDA/7yqR+mpUDkU1v1Pp5fII7YOO36Gc
         WUUjRgdxOtuX1j9r/N2d/iAKv1cewIImVYq8lM7R1oTsYob5g/G2vf39P+ZGRPH/lAy+
         t3CpTtPqwiwKb6inrfZGZjDHdIjozAaA+xLLQJKjFp2zU6iUFcZBvYfnh27f7p0nvHmj
         8rAA==
X-Gm-Message-State: AOJu0Yzw6tQfwIqqJV0sZDq6oVb+D52Fss2RwWPMNBt8T+phJ75w8kQE
	jNMFJJwbhEVNIobAYXAVS2R+a/RneR5X+rmCEnxPcKgrhA0+eQtJLh8NdQlk9EzPPuBTuHBL17h
	SIwfgp0sAj4WWZmMFcCJjo2fDDpkoCujf/58YQ45mNmREWqUwRnTC
X-Gm-Gg: ASbGnctChjpFCAJORoz+KPPyg3KOrMpZcsrHB+KNlC15jYqvWm0xoKmlGtWiYg+xoAL
	AS7UB7kySvUPfAZ+eGhrK5pHltGR5HJ++qjGYZCNCgKlKY3SzwXk04ksVyLc8PpeUaOo7EgWzhh
	kcfBhhfjto0gbA1K2ugh5f4bnOW1FwCDhBSRTlBfGwKmcyzETusDXOU0ayH9qM4ut6DKK47Pdnl
	Da1Bg3k
X-Google-Smtp-Source: AGHT+IEeMvSjqWSfau0ExpJcofiHdyZgwUbjcrhOFyoc5D2lal2IZDhy1lug3vRqiU4f477yB8Ze21RdBRRszAftJSc=
X-Received: by 2002:a05:690e:244c:b0:636:149a:f579 with SMTP id
 956f58d0204a3-6361a7a7a96mr1876603d50.23.1758806624889; Thu, 25 Sep 2025
 06:23:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <167acbaa-c61f-4d75-b2b6-9acee22ddee9@siemens.com> <fc592d6d-5f6b-4afd-9e4a-e77987a88a56@siemens.com>
In-Reply-To: <fc592d6d-5f6b-4afd-9e4a-e77987a88a56@siemens.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 25 Sep 2025 15:23:08 +0200
X-Gm-Features: AS18NWAZTbpyGB6Xr42xorZDT0cIBH5A30Scf0L7vi3X4roXNyHRBAoHI8pkWcA
Message-ID: <CAPDyKForTu9xdtPbYZ-DyLPGrnx7c6aXE8E1qoz9U_yZzAhRWQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc-utils: Correctly handle write counter overflow status
To: Jan Kiszka <jan.kiszka@siemens.com>, Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 09:53, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
> On 01.09.25 11:26, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > The result field of an RPMB frame will have bit 7 set as soon as the
> > write counter reached its limit (0xffffffff) - even if the operation was
> > successful. Handle that correctly to avoid false error reports.
> >
> > This was found and fixed over the RPMB model of QEMU after adjusting it
> > to expire earlier.
> >
> > Fixes: c6cb053ec59e ("mmc-utils: RPMB: add support for 4 rpmb operations")
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >
> > Changes in v2:
> >  - use operation result mask, rather than masking out the counter status
> >  - handle all result evaluation equally, even if not practically needed
> >  - massage commit message
> >
> >  mmc_cmds.c | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> >
> > diff --git a/mmc_cmds.c b/mmc_cmds.c
> > index 16c6b2e..429a9c7 100644
> > --- a/mmc_cmds.c
> > +++ b/mmc_cmds.c
> > @@ -2103,6 +2103,8 @@ enum rpmb_op_type {
> >       MMC_RPMB_READ_RESP = 0x05
> >  };
> >
> > +#define RPMB_OP_RESULT_MASK          0x7f
> > +
> >  struct rpmb_frame {
> >       u_int8_t  stuff[196];           /* Bytes 511 - 316 */
> >       u_int8_t  key_mac[32];          /* Bytes 315 - 284 */
> > @@ -2295,7 +2297,7 @@ int do_rpmb_write_key(int nargs, char **argv)
> >       }
> >
> >       /* Check RPMB response */
> > -     if (frame_out.result != 0) {
> > +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
> >               printf("RPMB operation failed, retcode 0x%04x\n",
> >                          be16toh(frame_out.result));
> >               exit(1);
> > @@ -2321,7 +2323,7 @@ static int rpmb_read_counter(int dev_fd, unsigned int *cnt)
> >       }
> >
> >       /* Check RPMB response */
> > -     if (frame_out.result != 0) {
> > +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
> >               *cnt = 0;
> >               return be16toh(frame_out.result);
> >       }
> > @@ -2442,7 +2444,8 @@ int do_rpmb_read_block(int nargs, char **argv)
> >       }
> >
> >       /* Check RPMB response */
> > -     if (frame_out_p[blocks_cnt - 1].result != 0) {
> > +     if ((frame_out_p[blocks_cnt - 1].result &
> > +          htobe16(RPMB_OP_RESULT_MASK)) != 0) {
> >               printf("RPMB operation failed, retcode 0x%04x\n",
> >                          be16toh(frame_out_p[blocks_cnt - 1].result));
> >               exit(1);
> > @@ -2573,7 +2576,7 @@ static int rpmb_auth_write(int nargs, char **argv, uint16_t addr,
> >       }
> >
> >       /* Check RPMB response */
> > -     if (frame_out.result != 0) {
> > +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
> >               printf("RPMB operation failed, retcode 0x%04x\n",
> >                      be16toh(frame_out.result));
> >       }
> > @@ -2621,7 +2624,7 @@ static int rpmb_auth_read(int nargs, char **argv)
> >       }
> >
> >       /* Check RPMB response */
> > -     if (frame_out.result != 0) {
> > +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
> >               printf("RPMB operation failed, retcode 0x%04x\n", be16toh(frame_out.result));
> >               goto out;
> >       }
> > @@ -2783,7 +2786,7 @@ int do_rpmb_write_block(int nargs, char **argv)
> >       }
> >
> >       /* Check RPMB response */
> > -     if (frame_out.result != 0) {
> > +     if ((frame_out.result & htobe16(RPMB_OP_RESULT_MASK)) != 0) {
> >               printf("RPMB operation failed, retcode 0x%04x\n",
> >                          be16toh(frame_out.result));
> >               exit(1);
>
> Any news on this one?

I was waiting for you and Avri to reach a conclusion. Avri, is this
good to go or do you expect Jan to send a new version?

Kind regards
Uffe
