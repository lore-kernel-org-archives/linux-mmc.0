Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E580140366
	for <linux-mmc@vger.kernel.org>; Wed,  6 Mar 2024 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709754577; cv=none; b=GC3ndKbDzVDAp43CG70ESIf7VYXrN0G4nCNSxg98ypQpoHMPhqBee0QqImJrqFqEnb5S1lFZG4hbR4SUFcotqoI/tF5PyL+MDfhPYRWlhuNGoln2Jex8unj75CmhlQkBT0YcS3wtKPTPYiA1IRS6zwQsgICrskDixHCb6hGs6pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709754577; c=relaxed/simple;
	bh=nPlyaesjYNbkV2scuIPLuOkf3mna0HTcvu1bn+dY8YI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tWLCLfeqPca6g93qA/a9vdAV2KwMs6OlBbK7W3JhELhdbv47+Qxc4hZjsIav6PTbEIpcwu9FdiqLtDRTgXLIM3W7vCEE540ZBb3uGuDr+3tO9t4A2c0yeKDQ3JhJ9DF94gIcgK+r4e8eXqnibshPVsqb6xKFtxKpRxG6JUnw/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yro2YoIx; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yro2YoIx"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-60983233a0dso1285587b3.3
        for <linux-mmc@vger.kernel.org>; Wed, 06 Mar 2024 11:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709754574; x=1710359374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nPlyaesjYNbkV2scuIPLuOkf3mna0HTcvu1bn+dY8YI=;
        b=Yro2YoIxVHiCUZZqMZDh7Vr3vscV+8B6DQ7IKlmr19lRxBaYtcSxKoWbO0k0CgaO1s
         KSUuDORKC92XCwxtV7sv5hpRRd0fbVnpj8MFsbIYgSC9/TQ0B9Pl/fz3yHXbfiW15jR+
         svnOfGaQnFWopnVSrmpwmYailosH76Qg1dq0rlxkDF92UNiM+bbmnVJmlshqJPfmzW8K
         5amp/eVG4vLeukWPqoYzw8CMfiXdpohgmU8cnqnOIoTypNPQ66Vy/jxV3zRAGyMlIzHJ
         z3xaS4RNHAfpdko42h6iUVLnZ/t/09AGUDvazF2SUXnjvcHpFnknc2zvDIhZKRtCpwmf
         Hypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709754574; x=1710359374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nPlyaesjYNbkV2scuIPLuOkf3mna0HTcvu1bn+dY8YI=;
        b=gUX7AXV3nph3V8hKp7+9n2fzVP24JW1Vok/ggaxA3LNIC8cB5atsYSa6RY9Ua1qDsN
         uhYuuLQAYxdSQcD7MGZq0at4xN+SbV/xwVJaQh+tcCIHXuwaYOoTe5k3Zkf5Ug3GFnPy
         MG2H3UbLYATw/f5yHRR2u3dgOwO+RpvJNw0HKGzYVPISGV+8kjwSq6ax67YQDEkoJLUM
         VgaRLUMNFTOPs+I/CB95qM6Uwwk4pcfV+dkaapGgEm/8zIlUZ+pbeQknEx412azkGXN0
         4YRJQ6wkPbE1O62QsrACOUKhhq6m3wTHCIsqMXE7Rtdns+OvDLm8hgjGpQFLDzNthIsr
         r7gg==
X-Forwarded-Encrypted: i=1; AJvYcCWsLN3xv7KerCr5BPY828+IdfAE8PFT6jCLBZJneVxJabsfRr3UVtptLoB5fwkHmILmaDOuGHPQS9buP39myYuqSx70ek/Dd6zs
X-Gm-Message-State: AOJu0YwyBxEmOi4YwSlWkbfpNPtvm20IpchoMjSNfCGxNxNjK/TcHc7V
	0WcaxQ8LvXRJv3rlvcmMPLfbRyD+jKsc6RtcjEf51sLKkUuWslC3/paUZ/ZrpMGxDvpVe3E7wFo
	xt6kKjKL0gngxKPyIihh8TI7YZWGfXY1OiLzExQ==
X-Google-Smtp-Source: AGHT+IHxsHr/alraTiTEqBEIabc4AtN/z3ZG5Fo2cAVhC41CbFpwoSrEAqQlrDjlml+vAdN3ScgmBzzdVF0/UxuJffI=
X-Received: by 2002:a0d:d4c5:0:b0:609:dbbc:451b with SMTP id
 w188-20020a0dd4c5000000b00609dbbc451bmr2705058ywd.23.1709754574622; Wed, 06
 Mar 2024 11:49:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
 <Zegx5PCtg6hs8zyp@trax> <CACRpkdYZrDgVVCp2bqJqY1BpeHSXDWbRSqk6d=N_QhC4OVv=Ew@mail.gmail.com>
 <Zeh8HGDToMoHglD2@trax> <CACRpkdZ1ervTXj6++oBPDNJT3TpVgPeYsyhaEMRYavJQ5iZPqg@mail.gmail.com>
 <CAPDyKFqYDPgNjSkpH=XATkUY2XtjsaDstChcAnGxoas4jgDVfw@mail.gmail.com>
In-Reply-To: <CAPDyKFqYDPgNjSkpH=XATkUY2XtjsaDstChcAnGxoas4jgDVfw@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 6 Mar 2024 20:49:23 +0100
Message-ID: <CACRpkdaUUD8UMp9GxNVQfdAM8QV_LASp-k5hh1cvQrGVHKySKA@mail.gmail.com>
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Tomas Winkler <tomas.winkler@intel.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 4:57=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org>=
 wrote:
> On Wed, 6 Mar 2024 at 15:38, Linus Walleij <linus.walleij@linaro.org> wro=
te:

> > We should probably rename it part_cfg because that is what we
> > store in it, it's assigned from card->part[idx].part_cfg.
> >
> > Then the id field in mmc_rpmb_data should be deleted along
> > with all the IDA counter code etc and the partition name hardcoded
> > to be "0" as there will never be anything else.
>
> Seems reasonable to me. Are you thinking of sending a cleanup patch on
> top of $subject patch?

Yes I can do that once this patch is finalized and merged.

Yours,
Linus Walleij
